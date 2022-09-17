import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/service/local_user_service.dart';

import '../../domain/product.dart';

enum ProductQuery {
  defaultQuery;
}

extension on Query<Product> {
  Query<Product> queryBy(ProductQuery query) {
    switch (query) {
      case ProductQuery.defaultQuery:
        return where('localUserId', isEqualTo: LocalUserService().localUser!.id)
            .orderBy('name', descending: false);
    }
  }
}
