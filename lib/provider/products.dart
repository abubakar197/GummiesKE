import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:gummieske/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> FetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      _products = [];
      productsSnapshot.docs.forEach((element) {
        _products.insert(
          0,
          Product(
              id: element.get('productId'),
              title: element.get('productTitle'),
              description: element.get('productDescription'),
              price: double.parse(
                element.get('price'),
              ),
              imageUrl: element.get('productImage'),
              brand: element.get('productBrand'),
              productCategoryName: element.get('productCategory'),
              quantity: int.parse(
                element.get('productQuantity'),
              ),
              isPopular: true),
        );
      });
    });
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List _categoryList = _products
        .where((element) => element.productCategoryName.contains(categoryName))
        .toList();
    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List _categoryList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
  /* 
    List<Product> _products = [
    Product(
        id: 'Mule Extracts',
        title: 'Muleshine',
        description: '1:2 THC:CBN with watermelon flavor indica dominant',
        price: 69.69,
        imageUrl:
            'https://i0.wp.com/pdxgreenbox.com/wp-content/uploads/2021/09/Watermelon-Muleshine.jpg?fit=1000%2C1000&ssl=1',
        brand: 'Gummies',
        productCategoryName: 'Tinctures',
        quantity: 96,
        isPopular: false),
    Product(
        id: 'Lemon Draiz',
        title: 'Lemon Driaz Extract',
        description:
            'Start with high CBD and a dash of THC well suited for evening\'s for a relaxed night ',
        price: 50.99,
        imageUrl:
            'https://cdn.greenrush.com/media/4/1/1/44411/LP%20Lemon%20Draiz.jpg',
        brand: 'Nature ',
        productCategoryName: 'Extracts',
        quantity: 1002,
        isPopular: false),
    Product(
        id: 'Wiz Khalifa',
        title: 'Wiz Khalifa Rolling Papers',
        description: 'Wiz Khalifa\'s rolling papers with tips and tray',
        price: 3.69,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/1752/6725/products/raw-x-wiz-khalifa-king-size-loud-pack-rolling-papers-w-tips-535974215710_1400x.jpg?v=1581712812',
        brand: 'Cookies',
        productCategoryName: 'Accessories',
        quantity: 65489,
        isPopular: true),
    Product(
        id: 'Mota CBD Indica',
        title: 'Mota Indica',
        description:
            'High quality organic grape seed of indica based THC oil best suited for night use',
        price: 58.99,
        imageUrl:
            'https://wccannabis.co/wp-content/uploads/2019/04/cbdtinc-wccannabis.jpg',
        brand: 'Nature',
        productCategoryName: 'Tinctures',
        quantity: 84894,
        isPopular: false),
    Product(
        id: 'Relaxing Mints',
        title: 'Relaxing Mints',
        description:
            'THC infused peppermint, contains 16 mints per pack. 80mg THC per pack, 5mg THC per mint',
        price: 12.99,
        imageUrl:
            'http://assets.coolhunting.com/coolhunting/mt_asset_cache/2015/02/dixie-elixirs-cannabis-edibles-1.jpg',
        brand: 'Nature',
        productCategoryName: 'Edibles',
        quantity: 325,
        isPopular: true),
    Product(
        id: 'MPX',
        title: 'Melting Point Extracts',
        description:
            'One of the best cannabis grown in Malawi under the sun, turpenes extracted with the best methods producing high quality extracts rich in THC',
        price: 50.99,
        imageUrl:
            'https://uploads.iheartjane.com/uploads/3d5e02c5-8234-456c-916e-452dd941e246.jpg',
        brand: 'Cookies',
        productCategoryName: 'Extracts',
        quantity: 6423,
        isPopular: true),
    Product(
        id: 'Alpine Extracts',
        title: 'Alpine Extracts',
        description:
            'It\'s a sativa dominant with a concetration of: THC: 63.7%, CBD: 16.0% and Terpenes:1.86%',
        price: 110,
        imageUrl:
            'https://64.media.tumblr.com/5a90532ad2b596f2e2ce8d30af148a65/tumblr_npjq2md7bd1r7moo4o1_1280.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Extracts',
        quantity: 3,
        isPopular: false),
    Product(
        id: 'Harmony Extracts',
        title: 'Harmony Extracts',
        description:
            'Our waxes are made to perform. We start with high-THC plant strains, extract all the goodness nature has to offer, and whip in some O2 to create the perfect consistency. Depending on the source material, the end product can either be a more dry crumbly wax, or a soft thick budder. Waxes and budders are known for their great flavor and aroma, along with being very user-friendly.',
        price: 50.99,
        imageUrl:
            'https://mir-s3-cdn-cf.behance.net/project_modules/1400/f9c72756300701.59a8662628ec5.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Extracts',
        quantity: 65,
        isPopular: false),
    Product(
        id: 'SATIVA 3:1 ',
        title: 'SATIVA 3:1',
        description: 'Contains a 3:1 ratio sativa, 7.5mg CBD:2.5mg THC',
        price: 50.99,
        imageUrl:
            'https://s3.amazonaws.com/images.ecwid.com/images/13206615/1181904008.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Essential Oils',
        quantity: 2654,
        isPopular: false),
    Product(
        id: 'Bic Lighters large',
        title: 'Bic  Lighters',
        description: 'The best lighter in the world, made in spain',
        price: 1.14,
        imageUrl: 'https://i.ebayimg.com/images/i/382509139317-0-1/s-l1000.jpg',
        brand: 'BIC',
        productCategoryName: 'Accessories',
        quantity: 8100,
        isPopular: false),
    Product(
        id: 'DIOLIEVE ',
        title: 'DIOLIEVE',
        description:
            'The Diolieve Tincture is a high quality lab-tested tincture that can be consumed under the tounge, added to beverages or food. This zesty lemon-flavored oil-based tincture offers a more pleasing administration experience for a high concentration solution containing 300mg active cannabinoids. ',
        price: 22.30,
        imageUrl:
            'https://i1.wp.com/diolieve.com/wp-content/uploads/2018/09/Tincture-500mg.jpg?fit=3270%2C3270&ssl=1',
        brand: 'Nature',
        productCategoryName: 'Tinctures',
        quantity: 58466,
        isPopular: true),
    Product(
        id: 'Cookies',
        title: 'Cookies Rolling Tray',
        description: 'Glow in the dark, high quality rolling trays',
        price: 50.99,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/0368/9362/2408/products/7123Ian9tWL._AC_SL1500_1162x700.jpg?v=1586905344',
        brand: 'Cookies',
        productCategoryName: 'Accessories',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'GELATO',
        title: 'Gelato',
        description:
            'Is an evenly_balanced hybrid marijuana strain made from a crossing of Sunset Sherbet and Thin Mint Girl Scout Cookies with its balane of indica & sativa, this strian produces a euphoric high accomplished by strong feeling of relaxation ',
        price: 90.99,
        imageUrl:
            'https://i0.wp.com/herbrxus.com/wp-content/uploads/2019/12/86.jpg?fit=1080%2C1080&ssl=1',
        brand: 'Nature',
        productCategoryName: 'Extracts',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'Hemp Oil',
        title: 'Hemp Oil',
        description:
            'Natural hemp flavor herbal supplement full of OMEGA 3,6,9 ',
        price: 69.99,
        imageUrl:
            'https://ae01.alicdn.com/kf/H38091af8a2d549db90fc4153efed07ffZ/MO-TULIP-10000mg-Massage-Oil-30ML-Organic-Pure-Essential-Oil-Herbal-Drops-Body-Relieve-Stress-Oil.jpg_640x640.jpg',
        brand: 'Nature',
        productCategoryName: 'Essential Oils',
        quantity: 89741,
        isPopular: false),
    Product(
        id: 'RA Cannabis',
        title: 'RA Cannabis',
        description: 'Fresh & Raw Honey Tincture ',
        price: 88.88,
        imageUrl: 'https://cdn.greenrush.com/media/4/8/7/5190487/c/zoom.jpg',
        brand: 'Cookies',
        productCategoryName: 'Tincture',
        quantity: 8941,
        isPopular: true),
    Product(
        id: 'Gelatti',
        title: 'Cookies CBD Oil Tincture',
        description: ' Home made and extacted tincture by home growers',
        price: 68.29,
        imageUrl:
            'https://i0.wp.com/www.cookiescbd.shop/ishuxeeh/Drops%20-%20Tincture1%20gelatti.png?fit=1500%2C1500&ssl=1',
        brand: 'Cookies',
        productCategoryName: 'Tincture',
        quantity: 3,
        isPopular: false),
    Product(
        id: 'Jaydens tincture',
        title: 'Jaydens tincture',
        description:
            'Contains 145mg of THC & 148mg of CBD fractionated MCT coconut oil',
        price: 54.98,
        imageUrl:
            'https://naturalcannabis.com/wp-content/uploads/JaydenTHC-1.jpg',
        brand: 'Cookies',
        productCategoryName: 'Tincture',
        quantity: 8515,
        isPopular: false),
    Product(
        id: 'Mimosa Blossoms',
        title: 'Mimosa Blossoms',
        description: 'Raw tincture pure THC',
        price: 80.99,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/0014/3749/9486/products/IMG_6842.jpg?v=1564073699',
        brand: 'Cookies',
        productCategoryName: 'Tincture',
        quantity: 3,
        isPopular: false),
    Product(
        id: 'Baked Bees',
        title: 'Baked Bees',
        description:
            'Medicated Honey delta 9 per dose per 50mg (550mg+delta 9 THC)',
        price: 50.99,
        imageUrl:
            'https://3ncb884ou5e49t9eb3fpeur1-wpengine.netdna-ssl.com/wp-content/uploads/2016/07/e15_extra_strength_medicated_honey_artisian_edition_solvent_free_baked_bees_with_gold_drop_co.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Edibles',
        quantity: 38425,
        isPopular: true),
    Product(
        id: 'Indica gummies',
        title: 'Indica gummies',
        description:
            'THC infused gummies with sour & sweet taste. High THC concetration with fluit flavor',
        price: 14.69,
        imageUrl:
            'https://cdn.patchcdn.com/users/22844250/stock/T800x600/201503550c6f5b9a97e.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Edibles',
        quantity: 384,
        isPopular: true),
    Product(
        id: 'TERRA',
        title: 'Terra Blueberries',
        description: 'Blueberrie infused coated in milk and chocolate',
        price: 50.99,
        imageUrl:
            'https://cdn.greenrush.com/media/6/8/6/1523686/Kiva-Terra-Blueberries-9836.jpg',
        brand: 'Good_karma',
        productCategoryName: 'Edibles',
        quantity: 45,
        isPopular: true),
    Product(
        id: 'Edible Flakes',
        title: 'Edible Flakes',
        description: 'Medical Cannabis Chocolate',
        price: 84.99,
        imageUrl:
            'https://i5.walmartimages.com/asr/199328de-c6d7-4107-bdc0-27cd0371c0ad_1.52a65ffb47c36ec1edb966bc32a1fe90.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
        brand: 'Good_karma',
        productCategoryName: 'Edibles',
        quantity: 98432,
        isPopular: true),
    Product(
        id: 'Elderberry Gummies 1:1 THC:CBN',
        title: 'Elderberry Gummies 1:1 THC:CBN',
        description:
            'The sedating effects of CBN in combination with THC, alongside terpenes found in Indica strains may provide greater sedation than THC alone. This combination may be particularly useful when preparing for sleep.It’s a little like watching sheep count you.',
        price: 19.00,
        imageUrl:
            'https://i2.wp.com/pdxgreenbox.com/wp-content/uploads/2021/03/Wyld_CBN_Elderberry_Gummies_OR_REC-reflct-1.jpg?fit=1000%2C1000&ssl=1',
        brand: 'Gummies',
        productCategoryName: 'Edibles',
        quantity: 100,
        isPopular: true),
    Product(
        id: 'Big Pete\'s',
        title: 'Big Pete\'s',
        description:
            'Cannabis-infused double chocolate mini cookies. Contains 10mg THC per cookie/ 100mg THC per bag',
        price: 90.99,
        imageUrl:
            'https://stickyguide.imgix.net/product_photos/1714453/original-1561424164.jpeg?auto=format&fm=jpg&q=85&w=1000&h=1000',
        brand: 'Good_karma',
        productCategoryName: 'Edibles',
        quantity: 3811,
        isPopular: false),
    Product(
        id: 'CBC (Cannabichromene)',
        title: 'CBC (Cannabichromene)',
        description: '100mg transdermal compound activated with CBD & THC',
        price: 50.99,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/2091/5959/products/MM_CBC_Tablets_R_grande.jpg?v=1519066070',
        brand: 'Nature',
        productCategoryName: 'Topicals',
        quantity: 81,
        isPopular: true),
    Product(
        id: 'Marley Natural',
        title: 'Marley Natural',
        description:
            'Marley Natural Cannabis, Accessories & Hemp Based Body Care',
        price: 99.99,
        imageUrl:
            'https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-ux-2880-1000,f_auto,q_auto:best/newscms/2016_05/1405526/marley_natural_2.jpg',
        brand: 'Nature',
        productCategoryName: 'Accessories',
        quantity: 91,
        isPopular: true),
    Product(
        id: 'Lionz Share',
        title: 'Lionz Share',
        description: 'Medically infused rub for back and head pain',
        price: 70.99,
        imageUrl:
            'https://hightimes.com/wp-content/uploads/2017/05/t06_500mg_1_to_1_thc_cbd_cannarub_lionz_share_topicals.jpg',
        brand: 'Nature',
        productCategoryName: 'Topicals',
        quantity: 815,
        isPopular: true),
    Product(
        id: '2oz',
        title: 'MR. NATURE',
        description: 'MR. NATURE topical cannabis rub',
        price: 80.99,
        imageUrl:
            'https://themrnatural.com/wp-content/uploads/2017/12/WebsiteProductImgs-topical-01.jpg',
        brand: 'Nature',
        productCategoryName: 'Topicals',
        quantity: 885,
        isPopular: true),
    Product(
        id: 'Mary Jane\'s SALVES',
        title: 'Mary Jane\'s SALVES',
        description: 'Cannabis infused face cream for ladies',
        price: 90.99,
        imageUrl:
            'https://stickyguide.imgix.net/product_photos/84044/original-1435182389.jpg?auto=format&fm=jpg&q=85&w=1000&h=1000',
        brand: 'Nature',
        productCategoryName: 'Topicals',
        quantity: 815,
        isPopular: true),
    Product(
        id: 'Relief Balm',
        title: 'Relief Balm',
        description: '50/50 THC & CBD infused relief balm topicals',
        price: 70.89,
        imageUrl:
            'https://cdn.shopify.com/s/files/1/1061/0012/products/DSC_8608_grande.jpg?v=1470444380',
        brand: 'Ever_green',
        productCategoryName: 'Topicals',
        quantity: 815,
        isPopular: true),
    Product(
        id: 'Awakened Topicals',
        title: 'Awakened Topicals',
        description: 'Cannabis Sublingual natural cannabis, Raw Cannabis',
        price: 70.99,
        imageUrl:
            'https://images.weedmaps.com/products/000/098/276/avatar/original/1578535171-3_1_Sublingual.jpg?fit=fill&fill=solid&fill-color=ffffff&h=640&w=640',
        brand: 'Ever_green',
        productCategoryName: 'Topicals',
        quantity: 4455,
        isPopular: false),
    Product(
        id: 'empower',
        title: 'Topical Relief Oil',
        description:
            'We’ve found a new addition to our hiking pack. Empower’s topical roll on is amazing for rubbing out sore muscles, into cramped hands or working on a tight calf. Bergamot, wintergreen, lavender, and cannabis work together to offer one of the most pleasing scents we’ve found in a roll on. With all natural ingredients and a fresh herbal scent, it just might keep insects at bay or at least offer relief if you do get bit. The applicator makes it easy to pinpoint the area affected and with no worries of psychoactivity you can count on it without getting couch lock in the middle of a trail hike. Perfect for giving your muscles a treat for carrying you all the way up the mountain or waiting out a rainstorm with an impromptu neck massage.',
        price: 50.00,
        imageUrl:
            'https://i0.wp.com/pdxgreenbox.com/wp-content/uploads/2018/02/empower-topical-relief-oil.jpg?fit=1000%2C1000&ssl=1',
        brand: 'Dot New',
        productCategoryName: 'Topicals',
        quantity: 700,
        isPopular: true),
    Product(
        id: 'Assorted grinders',
        title: 'Assorted grinders',
        description:
            'Hemp silicone plastic grinders, good quailty in assorted colors',
        price: 15.99,
        imageUrl:
            'https://i2.wp.com/www.maybaowholesale.com/wp-content/uploads/2020/07/3D-Herb-Grinder.jpg?fit=652%2C652&ssl=1',
        brand: 'Ever_green',
        productCategoryName: 'Accessories',
        quantity: 885,
        isPopular: false),
    Product(
        id: 'Wolf Grinders',
        title: 'Wolf Grinders',
        description:
            'Best pack n go accessories on the go never forget you essentials ',
        price: 40.99,
        imageUrl: 'https://i.ebayimg.com/images/i/112150115636-0-1/s-l1000.jpg',
        brand: 'Cookies',
        productCategoryName: 'Accessories',
        quantity: 815,
        isPopular: false),
    Product(
        id: 'Cannabis Accessories',
        title: 'Cannabis Accessories',
        description: 'if it\'s hip then you got all accessories in one box',
        price: 69.99,
        imageUrl:
            'https://prestodoctor.com/content/wp-content/uploads/2018/09/Screen-Shot-2018-09-10-at-12.27.47-PM.png',
        brand: 'Cookies',
        productCategoryName: 'Accessories',
        quantity: 8100,
        isPopular: true),
    Product(
        id: 'Mega Drop',
        title: 'Cream Soda',
        description: 'Cream Soda indica, contains 1000MG THC',
        price: 60.00,
        imageUrl:
            'https://i2.wp.com/pdxgreenbox.com/wp-content/uploads/2020/10/Cream-Soda-Mega-Drops-Magic-Number.jpg?fit=1000%2C1000&ssl=1',
        brand: '1 Third Freak',
        productCategoryName: 'Tinctures',
        quantity: 6,
        isPopular: true),
  ];

  */
}
