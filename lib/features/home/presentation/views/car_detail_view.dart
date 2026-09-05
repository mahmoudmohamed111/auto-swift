import 'package:auto_swift/core/components/custom_text.dart';
import 'package:flutter/material.dart';

class CarDetailView extends StatelessWidget {
  CarDetailView({super.key, required this.cardetail});
  Map cardetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(cardetail["image_url"]),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text:
                      "Car Model : "
                      "${cardetail["model"]}",
                ),
                SizedBox(height: 8),
                CustomText(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text:
                      "Car Brand : "
                      "${cardetail["brand"]}",
                ),
                SizedBox(height: 8),
                CustomText(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text:
                      "Car Price : "
                      "${cardetail["price"]}\$",
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      text:
                          "Car Speed: "
                          "${cardetail["speed"]} km/h",
                    ),
                    CustomText(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      text:
                          "Car Engine: "
                          "${cardetail["engine"]}",
                    ),
                    CustomText(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      text:
                          "Car Seats: "
                          "${cardetail["seat_number"]}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
