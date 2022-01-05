import 'dart:async';

import 'package:f_shake_animation_widget/f_shake_animation_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 定义菜单按钮选项
  List<Icon> iconList = const [
    Icon(Icons.add),
    Icon(Icons.save),
    Icon(Icons.share),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("抖动动画")),
        // 填充布局
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Stack(
              children: [
                Column(
                  children: [
                    // 通用组件的抖动
                    buildShakeAnimationWidget(),
                    const SizedBox(height: 10),
                    // 文字的抖动
                    buildTextAnimationWidget(),
                    const SizedBox(height: 10),
                    // 提交动画按钮
                    buildAnimatedStatusButton(),
                    const SizedBox(height: 10),
                    // 自定义动画按钮
                    buildProgressButton(),
                  ],
                ),
                // buildBottomRoundFlowMenu(),
                // 向上弹出的按钮组件
                buildRoteFloatingButton(),
              ],
            ),
          ),
        ),
        // floatingActionButton: buildRoteFlowButtonMenu(),
      ),
    );
  }

  /// 向上弹出的按钮组件
  buildRoteFloatingButton() {
    return RoteFloatingButton(
      // 子菜单按钮选项
      iconList: iconList,
      // 子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");
      },
    );
  }

  /// 向上弹出的按钮组件
  buildRoteFlowButtonMenu() {
    return RoteFlowButtonMenu(
      // 子菜单按钮选项
      iconList: iconList,
      // 子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");
      },
    );
  }

  /// 仿开源中国自定义底部菜单
  buildBottomRoundFlowMenu() {
    return BottomRoundFlowMenu(
      // 子菜单按钮选项
      iconList: iconList,
      // 子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");
      },
    );
  }

  buildTextAnimationWidget() {
    return const ShakeTextAnimationWidget(
      // 需要设置抖动效果的文本
      animationText: "这里是文字的抖动",
      // 字符间距
      space: 1.0,
      // 行间距
      runSpace: 10,
      // 文字的样式
      textStyle: TextStyle(fontSize: 25),
      // 抖动次数
      shakeCount: 0,
    );
  }

  /// 抖动动画控制器
  final ShakeAnimationController _shakeAnimationController =
      ShakeAnimationController();

  /// 构建抖动效果
  ShakeAnimationWidget buildShakeAnimationWidget() {
    return ShakeAnimationWidget(
      // 抖动控制器
      shakeAnimationController: _shakeAnimationController,
      // 微旋转的抖动
      shakeAnimationType: ShakeAnimationType.skew,
      // 设置不开启抖动
      isForward: false,
      // 默认为 0 无限执行
      shakeCount: 0,
      // 抖动的幅度 取值范围为[0,1]
      shakeRange: 0.2,
      // 执行抖动动画的子Widget
      child: ElevatedButton(
        child: const Text(
          '测试',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          // 判断抖动动画是否正在执行
          if (_shakeAnimationController.animationRunning) {
            // 停止抖动动画
            _shakeAnimationController.stop();
          } else {
            // 开启抖动动画
            // 参数shakeCount 用来配置抖动次数
            // 通过 controller start 方法默认为 1
            _shakeAnimationController.start(shakeCount: 1);
          }
        },
      ),
    );
  }

  Widget buildProgressButton() {
    // 切换样式的动画按钮
    return AnimatedButton(
      width: 120.0,
      height: 40,
      buttonText: '动画样式按钮',
      clickCallback: () {
        print("点击事件回调");
      },
    );
  }

  // 动画按钮使用到的控制器
  final AnimatedStatusController animatedStatusController =
      AnimatedStatusController();

  // 切换样式的动画按钮
  Widget buildAnimatedStatusButton() {
    return AnimatedStatusButton(
      // 控制器
      animatedStatusController: animatedStatusController,
      // 显示按钮的宽度
      width: 220.0,
      // 显示按钮的高度
      height: 40,
      // 动画交互时间
      milliseconds: 1000,
      buttonText: '提交',
      // 背景颜色
      backgroundNormalColor: Colors.white,
      // 边框颜色
      borderNormalColor: Colors.deepOrange,
      // 文字颜色
      textNormalCcolor: Colors.deepOrange,
      // 点击回调
      clickCallback: () async {
        print("点击事件回调");
        // 模拟耗时操作
        await Future.delayed(const Duration(milliseconds: 4000));

        // 返回false 会一直在转圈圈
        // 返回true 会回到默认显示样式
        return Future.value(true);
      },
    );
  }
}
