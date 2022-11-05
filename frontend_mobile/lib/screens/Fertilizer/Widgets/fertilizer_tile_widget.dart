import 'package:flutter/material.dart';
import 'package:frontend_mobile/providers/fertilizer_provider.dart';

class FertilizerTile extends StatelessWidget {
  final Fertilizer fertilizer;

  FertilizerTile(this.fertilizer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fertilizer.name,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fertilizer.code,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${fertilizer.weight} kg',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fertilizer.description,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //       child: Text(
                  //         fertilizer.code,
                  //         style: TextStyle(
                  //           color: Colors.grey[700],
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(width: 15),
                  //     Expanded(
                  //       child: Text(
                  //         fertilizer.weight,
                  //         style: TextStyle(
                  //           color: Colors.grey[700],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //       child: Text(
                  //         fertilizer.description,
                  //         style: TextStyle(
                  //           color: Colors.grey[700],
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
