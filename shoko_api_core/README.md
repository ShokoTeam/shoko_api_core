This package serves as the core for `shoko_api_core_supabase` and `shoko_api_core_drift` (not yet published).

The core is built on `dart_frog`, a package that makes it easy and fast to create an API in Dart. It core provides a foundation for building APIs while following a certain architecture.

# Features
1. **Automatic error validation.** You don’t need to manually handle basic errors—they are processed automatically. For example, by using `request.validatedBody`, you pass the required keys that should be in the request body, and in response, you get validated data. If validation fails, a `RepositoryException` is thrown, which is automatically caught in `RouteController`.
2. **Custom errors.** A set of predefined errors that the API can return in different situations, which you can use for responses.
3. **Logger.** You can track incoming requests, results, and errors.

# More About Features
## RouteController
This is an abstract class with the `direct` function, which you call in a route. It automatically invokes the appropriate method based on the request type. Each request method has a corresponding method in `RouteController`, all of which can be overridden.

Another advantage of `direct` is that it catches unexpected errors that are not handled within the method and returns an appropriate response.

**Example of using the controller:**
```dart
Future<Response> onRequest(RequestContext context) async => _RouteController().direct(context.request);

class _RouteController extends RouteController {
  @override
  Future<Response> get(Request request, [Map<String, dynamic>? dynamicRouteParams]) {
    final random = Random();
    final number = random.nextInt(50);

    return Response(body: number.toString());
  }
}
```
In this example, we override the `get` method and respond to incoming requests with a random number.

## ErrorCodes
`ErrorCodes` contains several variables (`user`, `client`, `server`, `postgres`, `smtp`), each returning different error types within its category.

Keep in mind:
- user = 4XX
- client = 4XX
- server = 5XX
- postgres = 5XX, 404
- smtp = 500

**Example of using the controller with errors:**
```dart
Future<Response> onRequest(RequestContext context) async => _RouteController().direct(context.request);

class _RouteController extends RouteController {
  @override
  Future<Response> get(Request request, [Map<String, dynamic>? dynamicRouteParams]) {
    final random = Random();
    final number = random.nextInt(50);

    if(number == 25) throw RepositoryException(ErrorCodes.server.unvailable);

    return Response(body: number.toString());
  }
}
```
In this case, an exception will be logged, and the client will receive the corresponding error response.

However, if you don’t want to throw an exception and prefer to return an error response directly:
```dart

    if(number == 25) return ErrorCodes.server.unvailable.response;
```
Yes, every error has a corresponding `response`.

You can also create your own `ErrorCode` and your own class (or enum) to return these codes. They will be processed the same way as the built-in ones!

## RequestExtension
The core also extends the Request class by adding the `validatedBody` and `validatedQueryParameters` methods. The key feature of these methods is that they take the required keys for the request body and query parameters. If the request does not contain the necessary keys, an error is generated.

In addition to these two methods, there is also the userId getter, which extracts the userId from the `BearerToken`. This getter will be useful if you use BearerToken for generating an access token.


## Config
What’s an API without a config? You need to initialize it in a custom entry point in [dart_frog](https://dartfrog.vgv.dev/docs/advanced/custom_init_method).

It takes a secret key, which is used for `BearerToken` and can be utilized as needed. There is also an isDev field, which you can use at your discretion.