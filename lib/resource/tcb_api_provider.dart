import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter_with_tcb/common/constants.dart';

class Tcb {
  Tcb();

  CloudBaseAuth auth;
  CloudBaseCore core;

  void initTcb() {
    core = CloudBaseCore.init({
      // 填写您的云开发 env
      'env': ENV_ID,
      // 填写您的移动应用安全来源凭证
      // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
      'appAccess': {
        // 凭证
        'key': APP_KEY,
        // 版本
        'version': VERSION
      }
    });
    // 获取登录状态
    auth = CloudBaseAuth(core);
  }

  Future<String> getTime() async {
    initTcb();
    CloudBaseAuthState authState = await auth.getAuthState();
    // 唤起匿名登录
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('success ${success.authType.toString()}');
      }).catchError((err) {
        // 登录失败
        print('err $err');
      });
    }

    // call tcb function
    CloudBaseFunction cloudBaseFunction = CloudBaseFunction(core);
    CloudBaseResponse res =
        await cloudBaseFunction.callFunction('getTime', null);
    return res.data;
  }

  // add todo
  Future<DbCreateResponse> addTodo(String todo) async {
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('todo');

    return collection.add({'todo': todo});
  }

  // query all todo
  Future<DbQueryResponse> getAllTodo() async {
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('todo');

    return collection.limit(10).get();
  }

  // remove one todo
  Future<DbRemoveResponse> removeTodo(String todo) async {
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('todo');

    return collection.where({'todo': todo}).remove();
  }

  // update one todo
  Future<DbUpdateResponse> updateTodo(String todo, String newTodo) async {
    CloudBaseDatabase db = CloudBaseDatabase(core);
    Collection collection = db.collection('todo');

    return collection.where({'todo': todo}).update({'todo': newTodo});
  }
}
