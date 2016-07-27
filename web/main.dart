// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'package:async/async.dart';  //needed for future Groups

main() async{
  querySelector('#output').text = 'Your Dart app is running.';


  //aproach with future groups
  await do_All_Work();

  for (var u in urls) {
    print("Totally Done? : {$u}");
  }

  //second aproach with Future.wait works also fine
  await do_all_Work2();

  for (var u in urls) {
    print("Totally Done? : {$u}");
  }
}

List urls = [
  {'id': 1, 'url': 'http://orf.at'},
  {'id': 2, 'url': 'http://derstandard.at'},
  {'id': 3, 'url': 'http://diepresse.com'},
  {'id': 4, 'url': 'http://orf.at'},
  {'id': 5, 'url': 'http://derstandard.at'},
  {'id': 6, 'url': 'http://diepresse.com'},
  {'id': 7, 'url': 'http://orf.at'},
  {'id': 8, 'url': 'http://derstandard.at'},
  {'id': 9, 'url': 'http://diepresse.com'},
  {'id': 10, 'url': 'http://orf.at'},
  {'id': 11, 'url': 'http://derstandard.at'},
  {'id': 12, 'url': 'http://diepresse.com'}
];

First_update_Task(Map u) async{
    String response = await HttpRequest.getString(u['url']);
    //print("${response}");
    u['conent'] = response.length;
    Random r = new Random(500);
    u['newkey'] = r.nextInt(500);
    print("Set new Key and content  for ${u['id']} ${u['url']}");
}

Second_update_Task(Map u) async{
    String response = await HttpRequest.getString(u['url']);
    //print("${response}");
    u['conent2'] = response.length * 2;
    Random r = new Random(500);
    u['newkey2'] = r.nextInt(500);
    print("Set new Key and content2 for ${u['id']} ${u['url']}");
}

Future do_All_Work() {
    FutureGroup f = new FutureGroup();
    for (var u in urls){
        f.add(First_update_Task(u));
        f.add(Second_update_Task(u));
    }
    f.close();
    return f.future;
}

Future do_all_Work2(){
    List tasks =[];
    for (var u in urls){
        tasks.add(First_update_Task(u));
        tasks.add(Second_update_Task(u));
    }
    return Future.wait(tasks);
}

// THIS DID NOT WORK SO WELL...

// Long_update_Taks_1() async {
//   for (var u in urls) {
//     String response = await HttpRequest.getString(u['url']);
//     //print("${response}");
//     u['conent'] = response.length;
//     Random r = new Random(500);
//     u['newkey'] = r.nextInt(500);
//     print("1st Task done for ${u['id']} ${u['url']}");
//   }
// }
//
// Long_update_Taks_2() async {
//   for (var u in urls) {
//     String response = await HttpRequest.getString(u['url']);
//     //print("${response}");
//     u['conent2'] = response.length * 2;
//     Random r = new Random(500);
//     u['newkey2'] = r.nextInt(500);
//     print("2nd Task done for ${u['id']} ${u['url']}");
//   }
// }
//
// Long_update_Task3() {
//   urls.forEach((u) {
//     HttpRequest.getString(u['url']).then((response) {
//       u['conent2'] = response.length * 2;
//       Random r = new Random(500);
//       u['newkey2'] = r.nextInt(500);
//       print("3rd Task done for ${u['id']} ${u['url']}");
//     });
//     //print("${response}");
//   });
//   return;
// }
