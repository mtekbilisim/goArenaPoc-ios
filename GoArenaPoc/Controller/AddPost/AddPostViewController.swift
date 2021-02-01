//
//  AddPostViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit
import SwiftIcons
import YPImagePicker
import AVFoundation
import AVKit
import Photos

class AddPostViewController: ViewController {
    let maxLength = 600
    var scrollView =  UIScrollView()
    var sendPostButton = SPButton()
    
    var textView = UITextView()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var keyboardTopView = UIView()
    var accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .white
        accessoryView.addTopBorder(with: Global.appColor, andWidth: 2)
        accessoryView.alpha = 0.8
        return accessoryView
    }()
    
    var cameraButton: UIButton = {
        let cameraButton = UIButton(type: .custom)
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        cameraButton.addTarget(self, action:#selector(showPicker), for: .touchUpInside)
        cameraButton.showsTouchWhenHighlighted = true
        return cameraButton
    }()
    
    var charactersLeftLabel: UILabel = {
        let charactersLeftLabel = UILabel()
        charactersLeftLabel.text = "0/600"
        charactersLeftLabel.textColor = UIColor.init(hex: "059FE7")
        charactersLeftLabel.font = AppAppearance.seventeen
        return charactersLeftLabel
    }()

    var selectedItems = [YPMediaItem]() {
        didSet {
            if selectedItems.count > 0 {
                accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                }
            } else {
                accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = true
                }
            }
        }
    }
    let selectedImageV = UIImageView()
    let pickButton = UIButton()
    let resultsButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        textView.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        hideLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yeni İleti"
        setupView()
    }
    
    // MARK: - Configuration
   @objc
   func showPicker() {

       var config = YPImagePickerConfiguration()

       /* Uncomment and play around with the configuration 👨‍🔬 🚀 */

       /* Set this to true if you want to force the  library output to be a squared image. Defaults to false */
//         config.library.onlySquare = true
       /* Set this to true if you want to force the camera output to be a squared image. Defaults to true */
       // config.onlySquareImagesFromCamera = false
       /* Ex: cappedTo:1024 will make sure images from the library or the camera will be
          resized to fit in a 1024x1024 box. Defaults to original image size. */
       // config.targetImageSize = .cappedTo(size: 1024)
       /* Choose what media types are available in the library. Defaults to `.photo` */
       config.library.mediaType = .photoAndVideo
       config.library.itemOverlayType = .grid
       /* Enables selecting the front camera by default, useful for avatars. Defaults to false */
       // config.usesFrontCamera = true
       /* Adds a Filter step in the photo taking process. Defaults to true */
       // config.showsFilters = false
       /* Manage filters by yourself */
//        config.filters = [YPFilter(name: "Mono", coreImageFilterName: "CIPhotoEffectMono"),
//                          YPFilter(name: "Normal", coreImageFilterName: "")]
//        config.filters.remove(at: 1)
//        config.filters.insert(YPFilter(name: "Blur", coreImageFilterName: "CIBoxBlur"), at: 1)
       /* Enables you to opt out from saving new (or old but filtered) images to the
          user's photo library. Defaults to true. */
       config.shouldSaveNewPicturesToAlbum = false

       /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
       config.video.compression = AVAssetExportPresetMediumQuality

       /* Defines the name of the album when saving pictures in the user's photo library.
          In general that would be your App name. Defaults to "DefaultYPImagePickerAlbumName" */
       // config.albumName = "ThisIsMyAlbum"
       /* Defines which screen is shown at launch. Video mode will only work if `showsVideo = true`.
          Default value is `.photo` */
       config.startOnScreen = .library

       /* Defines which screens are shown at launch, and their order.
          Default value is `[.library, .photo]` */
       config.screens = [.library, .photo, .video]

       /* Can forbid the items with very big height with this property */
//        config.library.minWidthForItem = UIScreen.main.bounds.width * 0.8
       /* Defines the time limit for recording videos.
          Default is 30 seconds. */
       // config.video.recordingTimeLimit = 5.0
       /* Defines the time limit for videos from the library.
          Defaults to 60 seconds. */
       config.video.libraryTimeLimit = 500.0

       /* Adds a Crop step in the photo taking process, after filters. Defaults to .none */
       config.showsCrop = .rectangle(ratio: (16/9))

       /* Defines the overlay view for the camera. Defaults to UIView(). */
       // let overlayView = UIView()
       // overlayView.backgroundColor = .red
       // overlayView.alpha = 0.3
       // config.overlayView = overlayView
       /* Customize wordings */
       config.wordings.libraryTitle = "Gallery"

       /* Defines if the status bar should be hidden when showing the picker. Default is true */
       config.hidesStatusBar = false

       /* Defines if the bottom bar should be hidden when showing the picker. Default is false */
       config.hidesBottomBar = false

       config.maxCameraZoomFactor = 2.0

       config.library.maxNumberOfItems = 5
       config.gallery.hidesRemoveButton = false

       /* Disable scroll to change between mode */
       // config.isScrollToChangeModesEnabled = false
//        config.library.minNumberOfItems = 2
       /* Skip selection gallery after multiple selections */
       // config.library.skipSelectionsGallery = true
       /* Here we use a per picker configuration. Configuration is always shared.
          That means than when you create one picker with configuration, than you can create other picker with just
          let picker = YPImagePicker() and the configuration will be the same as the first picker. */

       /* Only show library pictures from the last 3 days */
       //let threDaysTimeInterval: TimeInterval = 3 * 60 * 60 * 24
       //let fromDate = Date().addingTimeInterval(-threDaysTimeInterval)
       //let toDate = Date()
       //let options = PHFetchOptions()
       // options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
       //
       ////Just a way to set order
       //let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
       //options.sortDescriptors = [sortDescriptor]
       //
       //config.library.options = options
       config.library.preselectedItems = selectedItems


       // Customise fonts
       //config.fonts.menuItemFont = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
       //config.fonts.pickerTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .black)
       //config.fonts.rightBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .bold)
       //config.fonts.navigationBarTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)
       //config.fonts.leftBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)
       let picker = YPImagePicker(configuration: config)

       picker.imagePickerDelegate = self

       /* Change configuration directly */
       // YPImagePickerConfiguration.shared.wordings.libraryTitle = "Gallery2"
       /* Multiple media implementation */
       picker.didFinishPicking { [unowned picker] items, cancelled in

           if cancelled {
               print("Picker was canceled")
               picker.dismiss(animated: true, completion: nil)
               return
           }
           _ = items.map { print("🧀 \($0)") }

           self.selectedItems = items
           if let firstItem = items.first {
               switch firstItem {
               case .photo(let photo):
                   self.selectedImageV.image = photo.image
                   picker.dismiss(animated: true, completion: nil)
               case .video(let video):
                   self.selectedImageV.image = video.thumbnail

                   let assetURL = video.url
                   let playerVC = AVPlayerViewController()
                   let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
                   playerVC.player = player

                   picker.dismiss(animated: true, completion: { [weak self] in
                       self?.present(playerVC, animated: true, completion: nil)
                       print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                   })
               }
           }
        }
        self.present(picker, animated: true, completion: nil)

   }
    // MARK: - Send Post Tapped

    @objc func sendPost(_ sender: UIButton) {
        
    }
    
    // MARK: - Close VC
    @objc
    func dismissView() {
        dismiss()
    }
}

// MARK: - AddPostViewController Extensions

extension AddPostViewController {
    
    
    private func setupView() {
        view.backgroundColor = .white
        addNavigationButtons()
        addTextView()
        addAccessory()
    }
    
    private func addNavigationButtons() {
        //CANCEL BUTTON
        let btn1 = SPButton()
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.titleLabel?.font = AppAppearance.fifteenL
        btn1.setImage(UIImage(named: "close"), for: .normal)
//        btn1.setTitle("İptal", color: UIColor.init(hex: "059FE7"))
        btn1.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1

        //SEND BUTTON
        sendPostButton = SPButton()
        sendPostButton.set(enable: false, animatable: true)
        sendPostButton.setTitle("Gönder")
        sendPostButton.titleLabel?.font = AppAppearance.seventeen
        sendPostButton.titleLabel?.textColor = UIColor.init(hex: "059FE7")
        sendPostButton.addShadow(offset: CGSize(width: 0, height: 0), color: .yellow, radius: 1, opacity: 0.1, cornerRadius: 3)
        sendPostButton.backgroundColor = Global.appColor
        sendPostButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        sendPostButton.addTarget(self, action: #selector(sendPost), for: .touchUpInside)
        let item2 = UIBarButtonItem()
        item2.customView = sendPostButton

        self.navigationItem.leftBarButtonItems = [item1]
        self.navigationItem.rightBarButtonItems = [item2]
    }
    
    private func addTextView() {
       
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.sizeToFit()
        textView.isScrollEnabled = true
        textView.textColor = SPNativeColors.black
        textView.delegate = self
        textView.isEditable = true
        textView.font = AppAppearance.eighteen
        textView.contentInset = UIEdgeInsets(top:16 ,left: 16,bottom: 16,right: 16);
        view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: view.topAnchor,constant: 8).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
            
        if Device.isIPhoneXSimilar() {
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenHeight + 420 ).isActive = true
        } else {
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenHeight + 220 ).isActive = true
        }
    }
    
    func addAccessory() {
        let height:CGFloat = selectedItems.count > 0 ? 180 : 45
        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.inputAccessoryView = accessory
        accessory.addSubview(cameraButton)
        accessory.addSubview(charactersLeftLabel)
        NSLayoutConstraint.activate([
            cameraButton.leadingAnchor.constraint(equalTo:accessory.leadingAnchor, constant: 20),
            cameraButton.bottomAnchor.constraint(equalTo:accessory.bottomAnchor,constant: -8),
            charactersLeftLabel.trailingAnchor.constraint(equalTo:accessory.trailingAnchor, constant: -20),
            charactersLeftLabel.bottomAnchor.constraint(equalTo:accessory.bottomAnchor,constant: -12)
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
    
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
        accessory.addSubview(collectionView)
        
        collectionView.bottomAnchor.constraint(equalTo: cameraButton.topAnchor,constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: accessory.topAnchor,constant:0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: accessory.leadingAnchor,constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: accessory.trailingAnchor,constant: 0).isActive = true
       

    }
}

// MARK: - UITextViewDelegate

extension AddPostViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        calculateCharacters()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= maxLength
    }

    func calculateCharacters() {
        let length = textView.text.count
        let charsLeft = maxLength - length
        self.charactersLeftLabel.text = "\(charsLeft) / \(maxLength)"
        let isEnabled = charsLeft >= 0 && length > 0
        self.sendPostButton.set(enable: isEnabled, animatable: true)
        charactersLeftLabel.textColor = isEnabled ? UIColor.init(hex: "059FE7") : SPNativeColors.red
    }
        
}

// Support methods
extension AddPostViewController {
    /* Gives a resolution for the video by URL */
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}

// YPImagePickerDelegate
extension AddPostViewController: YPImagePickerDelegate {
    func noPhotos() {}

    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true// indexPath.row != 2
    }
}

extension AddPostViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier,
                                                      for: indexPath) as! ImagesCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.contentView.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 5)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.red.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowPath = shadowPath.cgPath
        
        for item in self.selectedItems.map({$0}) {
            switch item {
            case .photo(let photo):
                cell.imageView.setImage(image: photo.image, animatable: true)
            case .video(let video):
                cell.imageView.setImage(image: video.thumbnail, animatable: true)
            }
        }
       
        return cell
    }
    
}
extension AddPostViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height - 16, height: collectionView.frame.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    }
}
