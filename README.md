# goArenaPoc-ios

1.Download file from console or directly from link

2.Go to root of the project in console.

3 write "pod install" 

4. open GoArenaPoc.xcworkspace and press cmd + r


IOS DOKUMANTASYON


Go Arena Poc projesi model-view-controller katmanıyla oluşturulmuştur. Network katmanında Apple standart NSURLSessionTask sınıfı kullanılmış olup, 3rd parti kütüphane kullanılmamıştır.
Network katmanı Encode,Manager,EndPoint ve Servis olarak dört katmandan oluşturulmuştur.

Model katmanı request,response ve data model olarak 3 katmandan oluşturulmuştur. Controllerdan oluşturulan istekler custom viewlere gönderilerek ekranda gösterillmiştir.

Uygulama içinde yardımcı olarak kullanılan her fonksiyon ve extensionlar ayrı birer dosyada, root klasörü altında durmaktadır. Ekstara olarak UI ihtiyacı olarak çekilen kütüphaneler için CocoaPods kullanılmıştır.

Uygulama, kodun okunabilirliliği göz önünde alınarak, storyboard ile yazılan projelerde karşılaşılan zorluklara karşı full-code olarak yazılmıştır.

Uygulamanın Unit Testleri root klasörü altındadır.


