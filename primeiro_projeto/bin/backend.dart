import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'infra/custom_server.dart';
import 'api/login_api.dart';
import 'utils/custom_env.dart';

void main() async {
  //inicializar varias API's
  //criação de varios handler's
  var cascadeHandler =
      Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;
  //pipeline do shelf -> adicionar Middleware e handlers
  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: 'localhost', //await CustomEnv.get(key: 'server_address'),
    port: 8080,
  );
}
