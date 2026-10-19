
## Özellikler

- **Ana sayfa:** banner, kategori kısayolları ve tüm ürünlere giden buton
- **Ürün listesi:** `GridView` ile ürün kartları, isme göre arama, kategori filtre çipleri
- **Ürün detayı:** büyük görsel, fiyat, puan, açıklama ve "Add to cart" butonu
- **Sepet:** adet artırma/azaltma, ürün silme, toplam tutar, demo ödeme
- **Navigasyon:** `Navigator.pushNamed` ile adlandırılmış rotalar; kategori adı ve `Product` nesnesi *route arguments* ile sayfalar arasında taşınır
- **Sepet sayacı:** AppBar'daki sepet ikonunda ürün adedini gösteren rozet (`Badge`)
- **Veri modeli:** `Product.fromJson` / `toJson`, veriler `assets/data/products.json` dosyasından okunur
- **Görseller:** `Image.asset` ile `assets/images/` altından yüklenir
