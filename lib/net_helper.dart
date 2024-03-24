import 'package:http/http.dart';

class NetHelper {
  final String url;
  const NetHelper({required this.url});
  Future<Response> getData() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == 200) {
        return res;
      } else {
        print(res.statusCode);
        return Response('', res.statusCode);
      }
    } catch (e) {
      print(e);
      return Response('', 404);
    }
  }
}
