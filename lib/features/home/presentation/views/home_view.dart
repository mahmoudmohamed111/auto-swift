import 'package:auto_swift/core/components/custom_text.dart';
import 'package:auto_swift/features/home/presentation/views/car_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auto_swift/core/components/custom_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedBrand = "All";
  final List<String> brands = ["All", "Bmw", "Audi", "Porshe"];
  final Stream<List<Map<String, dynamic>>> _carsStream = Supabase
      .instance
      .client
      .from('cars')
      .stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
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
                const Icon(CupertinoIcons.circle_grid_3x3),
              ],
            ),
            const SizedBox(height: 16),
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
                const Text(
                  "Mahmoud",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomText(
              fontSize: 16,
              text: "choose your ideal Car ",
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands.map((brand) {
                  final isSelected = selectedBrand == brand;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBrand = brand;
                        });
                      },
                      child: CustomContainer(
                        radius: 25,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        color: isSelected ? Colors.black : Colors.grey.shade200,
                        child: CustomText(
                          text: brand,
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _carsStream,
                builder: (context, snapshot) {
                  final allCars = snapshot.data ?? [];
                  final filteredCars = selectedBrand == "All"
                      ? allCars
                      : allCars
                            .where((car) => car['brand'] == selectedBrand)
                            .toList();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final cars = snapshot.data ?? [];

                  if (cars.isEmpty) {
                    return const Center(
                      child: Text(
                        "No cars available",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: filteredCars.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.4,
                        ),
                    itemBuilder: (context, index) {
                      final car = filteredCars[index];
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    car['image_url'] ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 50,
                                            ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                maxLines: 1,
                                text: car['model'] ?? 'No Model',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: car['brand'] ?? 'No Brand',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "\$${car['price'] ?? 0}",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CarDetailView(
                                              cardetail: car,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      size: 25,
                                      Icons.arrow_circle_right_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
