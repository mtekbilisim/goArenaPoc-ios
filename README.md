
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/mtekbilisim">
    <img src="https://www.cioupdate.com.tr/wp-content/uploads/2020/06/poc.jpg" alt="Logo">
  </a>

<h3 align="center">Turkcell GoArena POC</h3>

  <p align="center">
    IOS Native Application /  Navigation Architecture Component
    <br />
    <a href="http://www.mtekbilisim.com"><strong>MTek Bilişim A.Ş. »</strong></a>
    <br />
    <br />
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>İçerik</summary>
  <ol>
    <li>
      <a href="#about-the-project">Proje hakkında</a>
      <ul>
        <li><a href="#built-with">Mimari hakkında</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Başlangıç</a>
      <ul>
        <li><a href="#installation">Kurulum</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Katılım</a></li>
    <li><a href="#license">Lisans</a></li>
    <li><a href="#contact">İletişim</a></li>
  </ol>
</details>


Aşağıda uygulamayı geliştirirken kullandığımız yapılara dair bilgileri bulabilirsiniz.

### Mimari Hakkında

Bu bölümde oluşturduğumuz kullandığımız ana kütüphaneler, çatı ve 3ncü parti hizmetler hakkında bilgi mevcuttur.

* [Swift](https://developer.apple.com/swift/)
* [MVC](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
* [Navigation](https://developer.apple.com/documentation/uikit/uitabbarcontroller)
* [Dependency manager] https://cocoapods.org/ 
* [YPImagePicker](https://github.com/Yummypets/YPImagePicker)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [Charts](https://github.com/danielgindi/Charts)
* [Alamofire](https://github.com/Alamofire/Alamofire)


<br />
<p align="center">
  <a href="https://github.com/mtekbilisim">
    <img src="https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png" alt="Logo">
  </a>
</p>

Go Arena Poc projesi model-view-controller katmanıyla oluşturulmuştur. Network katmanında Apple standart NSURLSessionTask sınıfı kullanılmış olup, 3rd parti kütüphane kullanılmamıştır.
Network katmanı Encode,Manager,EndPoint ve Servis olarak dört katmandan oluşturulmuştur.

Model katmanı request,response ve data model olarak 3 katmandan oluşturulmuştur. Controllerdan oluşturulan istekler custom viewlere gönderilerek ekranda gösterillmiştir.

Uygulama içinde yardımcı olarak kullanılan her fonksiyon ve extensionlar ayrı birer dosyada, root klasörü altında durmaktadır. Ekstara olarak UI ihtiyacı olarak çekilen kütüphaneler için CocoaPods kullanılmıştır.

Uygulama, kodun okunabilirliliği göz önünde alınarak, storyboard ile yazılan projelerde karşılaşılan zorluklara karşı full-code olarak yazılmıştır.
<!-- GETTING STARTED -->
## Başlangıç

Uygulamayı kendi tarafınızda kurabilmek ve çalıştırabilmek için aşağıdaki adımları takip etmeniz gereklidir.

### Gereksinimler

* Xcode 11
* Swift 5
* iOS 12+
  
  ### Kurulum

1. Repoyu klonlayın
   ```sh
   git clone https://github.com/mtekbilisim/goArenaPoc-ios
   ```
2. 

 ```sh
   pod init
   ```

3. ```sh
   pod install
   ```

4.Run
 
 <!-- CONTRIBUTING -->
## Katılım

Katılım projenin bir POC olması sebebi ile **kapatılmıştır**. Ancak projemizi beğendiyseniz paylaşıma açığız. Bu sebeple MIT lisansını tercih ettik.</br>
[![LinkedIn][linkedin-shield]][linkedin-url]
<!-- LICENSE -->
## Lisans

MIT lisansı altında dağıtılmaktadır.</br>
[![MIT License][license-shield]][license-url]


<!-- CONTACT -->
## İletişim

Proje linki : [https://github.com/mtekbilisim/goArenaPoc-ios)



<!-- ACKNOWLEDGEMENTS -->
## Teşekkürler!
Bu bökümanın hazırlanmasında emeği geçen diğer kütüphaneler : 
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [Animate.css](https://daneden.github.io/animate.css)
* [Loaders.css](https://connoratherton.com/loaders)
* [Slick Carousel](https://kenwheeler.github.io/slick)
* [Smooth Scroll](https://github.com/cferdinandi/smooth-scroll)
* [Sticky Kit](http://leafo.net/sticky-kit)
* [JVectorMap](http://jvectormap.com)
* [Font Awesome](https://fontawesome.com)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://opensource.org/licenses/MIT
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/emrahtoy
[product-screenshot]: images/screenshot.png

-------------
<p align="center">
  <a href="http://www.mtekbilisim.com/">
    <img src="http://www.mtekbilisim.com/img/logo.png" alt="Logo">
  </a>
</p>
