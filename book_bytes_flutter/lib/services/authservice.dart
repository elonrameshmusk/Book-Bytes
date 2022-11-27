import 'dart:convert';
import 'package:http/http.dart' as http;

var url = '10.3.1.24:3000';
var headers = (token) => {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

class AuthService {
  Future<String> login(email, password) async {
    print('reached login function');
    Map<String, dynamic> map = {
      'email': email, 'password':password
    };
    var signinRequest = jsonEncode(map);
    print('completed model compiling');
    final response = await http.post(Uri.http(url, '/authenticate'),
        body: signinRequest,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      return temp['token'];
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
  Future<String> signup(email, password) async{
    Map<String, dynamic> map = {
      'email': email, 'password':password
    };
    var signupRequest = jsonEncode(map);
    final response = await http.post(Uri.http(url, '/adduser'),
    body: signupRequest,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      return temp['token'];
    } else {
      print(response.statusCode);
      print(response);
      throw Exception('Failed to signup');
    }
  }
  Future<dynamic> addShelf(token, shelf) async {
    final queryParameters = {'shelf': shelf};
    final response = await http.post(
        Uri.http(url, '/addshelf', queryParameters),
        headers: headers(token));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to post shelf');
    }
  }

  Future<dynamic> getShelves(token) async {
    final response = await http.get(Uri.http(url, '/getshelves'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      if (temp['success'] == true) {
        return temp['shelves'];
      } else {
        print('Cannot get user');
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to load shelves');
    }
  }

  Future<dynamic> getBooksFromGoogle(query) async {
    String url = 'www.googleapis.com';
    String extension = '/books/v1/volumes';
    var queryParams = {'q': query};
    final response = await http.get(Uri.http(url, extension, queryParams));
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body)['items'];
      List<dynamic> items = [];
      for (int i = 0; i < temp.length; i++) {
        items.add({
          'image': temp[i]['volumeInfo']['imageLinks']['smallThumbnail'],
          'title': temp[i]['volumeInfo']['title'],
          'author': temp[i]['volumeInfo']['authors'].join(', '),
          'id': temp[i]['id']
        });
      }
      return items;
    } else {
      throw Exception('Cannot get books from google');
    }
  }

  Future<dynamic> getBookFromGoogle(id) async {
    String url = 'www.googleapis.com';
    String extension = '/books/v1/volumes/$id';
    final response = await http.get(Uri.http(url, extension));
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body)['volumeInfo'];
      Map<String, String> book = {
        'image': temp['imageLinks']['thumbnail'],
        'title': temp['title'],
        'author': temp['authors'].join(', ')
      };

      return book;
    } else {
      throw Exception('Cannot get books from google');
    }
  }

  Future<dynamic> addBook(token, shelf, id) async {
    var queryParams = {'shelf': shelf, 'id': id};
    final response = await http.post(Uri.http(url, '/addbook', queryParams),
        headers: headers(token));
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('faild to add book');
    }
  }

  Future<dynamic> getBooks(token, shelf) async {
    var queryParams = {'shelf': shelf};
    final response =
        await http.get(Uri.http(url, '/getbooks', queryParams), headers: headers(token));

    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      if (temp['success'] == true) {
        return temp['books'];
      } else {
        throw Exception('Cannot get user');
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to load books');
    }
  }
  Future<dynamic> addFolder(token, shelf, id, folder) async {
    final queryParameters = {'shelf': shelf, 'id':id, 'folder':folder};
    final response = await http.post(
        Uri.http(url, '/addfolder', queryParameters),
        headers: headers(token));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to post folder');
    }
  }
  Future<dynamic> getFolders(token, shelf, id) async {
    var queryParams = {'shelf':shelf, 'id':id};
    final response = await http.get(Uri.http(url, '/getfolders', queryParams), headers: headers(token));
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      if (temp['success'] == true) {
        return temp['folders'];
      } else {
        print('Cannot get user');
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to load folders');
    }
  }
  Future<dynamic> addByte(token, shelf, id, folder, heading, lines, learning) async {
    var queryParams = {'shelf':shelf, 'id':id, 'folder':folder};
    final response = await http.post(Uri.http(url, '/addbyte', queryParams), headers: headers(token), body: jsonEncode({
      'heading': heading,
      'lines': lines,
      'learning': learning
    }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to post byte');
    }
  }
  Future<dynamic> getBytes(token, shelf, id, folder) async {
    var queryParams = {'shelf': shelf, 'id':id, 'folder':folder};
    final response = await http.get(Uri.http(url, '/getbytes', queryParams), headers: headers(token));
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      if (temp['success'] == true) {
        return temp['bytes'];
      } else {
        print('Cannot get user');
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to load bytes');
    }
  }
}
