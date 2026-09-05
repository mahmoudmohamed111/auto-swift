import 'package:auto_swift/core/components/custom_container.dart';
import 'package:auto_swift/core/components/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYC2OLdKr-jgP9ujR6RxbWaUlbXNHJbS8RrSc0SjvNrQ&s=10",
                  ),
                ),
                Text(
                  "Cairo , Egypt",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Icon(CupertinoIcons.circle_grid_3x3),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Hello, ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Mahmoud",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(
              fontSize: 16,
              text: "choose your ideal Car ",
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: CustomContainer(
                      radius: 20,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: CustomText(
                        text: "Audi",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.black,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW25vezW1HMHcmyx85ghvNixVh9DOGawLp7E8F180hMg&s=10",
                        ),
                        SizedBox(height: 4),

                        CustomText(
                          maxLines: 1,
                          text: "Porshe caynne",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: "Porshe",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "\$150",
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            Icon(
                              Icons.arrow_circle_right_rounded,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
