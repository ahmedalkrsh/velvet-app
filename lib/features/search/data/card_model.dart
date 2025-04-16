import 'package:velvet/core/utils/app_assets.dart' show AppAssets;

class ProductModel {
  final String name;
  final String image;
  final double price;

  ProductModel({required this.name, required this.image, required this.price});

  static List<ProductModel> getDummyProducts() => [
        ProductModel(name: "Wooden bed", image: AppAssets.woodenBed, price: 349.99),
        ProductModel(name: "Velvet bed", image: AppAssets.velvetBed, price: 529.99),
        ProductModel(name: "Classic bed", image: AppAssets.bedndStorage, price: 469.99),
        ProductModel(name: "Headbord bed", image: AppAssets.classicBed, price: 619.99),
        ProductModel(name: "Bed & Storage", image: AppAssets.hadBoardBed, price: 799.99),
        ProductModel(name: "Black bed", image: AppAssets.blackBed, price: 456.99),
      ];
}
