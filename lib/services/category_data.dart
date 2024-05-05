import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();
  
  categoryModel.categoryName = 'Business';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = 'Entertainment';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = 'Health';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = 'Science';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = 'Sports';
  category.add(categoryModel);
  categoryModel = CategoryModel();
  
  categoryModel.categoryName = 'Technology';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;

}