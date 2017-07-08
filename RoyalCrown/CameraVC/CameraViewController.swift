//
//  CameraViewController.swift
//  RoyalCrown
//
//  Created by pasichniak maryan on 7/6/17.
//  Copyright © 2017 pasichniak maryan. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var previewView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var viewWithCollection: UIView!
    @IBOutlet weak var cameraActView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    
    var camera = true
    
    var assetsFetchResults : PHFetchResult<AnyObject>?
    var imageManager : PHCachingImageManager?
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PhotoCell", bundle:nil)
        photoCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCell)
        
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.makePhotoAction(_:)))
        cameraActView.addGestureRecognizer(tapGesture)
        
        
         let options = PHFetchOptions.init()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
        assetsFetchResults = PHAsset.fetchAssets(with: options) as! PHFetchResult<AnyObject>
        imageManager = PHCachingImageManager.init()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureImageView.layer.cornerRadius = 16.0
        captureImageView.layer.masksToBounds = true
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)

            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            previewView.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()

            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.frame
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.addSublayer(bottomView.layer)
        videoPreviewLayer?.addSublayer(viewWithCollection.layer)
        videoPreviewLayer?.addSublayer(switchButton.layer)
         videoPreviewLayer?.addSublayer(flashButton.layer)
    }

    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  assetsFetchResults!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.photoCell, for: indexPath) as! PhotoCell
        
        let asset = assetsFetchResults?[indexPath.item];
        imageManager?.requestImage(for: asset as! PHAsset, targetSize: cell.frame.size, contentMode: PHImageContentMode(rawValue: 1)!, options: nil) { (result, info) in
            cell.setUpWithImage(image: result!)
        }
      
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = collectionView.frame.height
        let cellWidth:CGFloat = collectionView.frame.width/4
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    
    
    
    
    
    
    
    
    
    // MARK - Actions
     func makePhotoAction(_ sender: Any) {
        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)

                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    }, completionHandler: { success, error in
                        if success {
                            // Saved successfully!
                        }
                        else if let error = error {
                            // Save photo failed with error
                        }
                        else {
                            // Save photo failed with no error
                        }
                    })
                    self.captureImageView.image = image
                }
            })
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func switchCameraAction(_ sender: Any) {
        camera = !camera
        
        captureImageView.layer.cornerRadius = 16.0
        captureImageView.layer.masksToBounds = true
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        //let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
         var backCamera = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        if (camera == false) {
            for device in backCamera!{
                let device = device as! AVCaptureDevice
                if device.position == AVCaptureDevicePosition.front {
                    backCamera = device
                    break
                }
            }
        } else {
            var captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        }
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            previewView.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()
            
            
        }
        
    }
    
    
    
    

}
