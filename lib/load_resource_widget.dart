import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

final dio = Dio();

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print("请求http完成, 状态码：${response.statusCode}");
}

class LoadResourceWidget extends StatefulWidget {
  const LoadResourceWidget({super.key});

  @override
  State<LoadResourceWidget> createState() => _LoadResourceWidgetState();
}

class _LoadResourceWidgetState extends State<LoadResourceWidget> {
  List<String> items = List.generate(20, (index) => 'Item $index');

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    // 在这里执行刷新逻辑
    setState(() {
      items = List.generate(20, (index) => 'Item ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RefreshIndicator Example')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            print("reload build: $index");
            getHttp();
            return TestWidget(
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final int index;
  const TestWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    print("重建TestWidget");
    return Container(
      height: 200,
      width: 200,
      child: Column(
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2024/07/23/13/03/moon-8915307_960_720.png",
            width: 100,
            height: 100,
            cacheWidth: null,
            cacheHeight: null,
          ),
          Text("Index: $index")
        ],
      ),
    );
  }
}
