abstract class ProductEvent {}

class FetchAllProductEvent extends ProductEvent{}

class ProductSearchEvent extends ProductEvent{
  int categoryId;
  ProductSearchEvent({required this.categoryId});
}