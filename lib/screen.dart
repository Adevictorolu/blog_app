import 'package:flutter/material.dart';
import 'package:project_2/provider.dart';
import 'package:provider/provider.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Providerstate(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              Provider.of<Providerstate>(context).name,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  context.read<Providerstate>().name,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<Providerstate>(
                      context,
                      listen: false,
                    ).changeDate('Victor Programmed this Application');
                  },
                  child: Text('Change Name!'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
