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

protocol CameraDelegate {
    func fetchPhotos(photosArray: [Any])
}


class CameraViewController: UIViewController {
    @IBOutlet private var previewView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var viewWithCollection: UIView!
    @IBOutlet private weak var cameraActView: UIView!
    @IBOutlet private weak var captureImageView: UIImageView!
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var switchButton: UIButton!
    @IBOutlet private weak var flashButton: UIButton!
    @IBOutlet fileprivate weak var countLabel: UILabel!
    
    
    fileprivate  var assetsFetchResults : PHFetchResult<AnyObject>?
    fileprivate  var imageManager : PHCachingImageManager?
    private  var session: AVCaptureSession?
    private  var captureSession: AVCaptureSession?
    private  var stillImageOutput: AVCaptureStillImageOutput?
    private  var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private  var currentCaptureDevice: AVCaptureDevice?
    private  var usingFrontCamera = false
    fileprivate  var selectedPhotoSet : [PHAsset] = []
    fileprivate  var photoImg  : [UIImage] = []
    
     var delegate: CameraDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PhotoCell", bundle:nil)
        photoCollectionView.register(nibName, forCellWithReuseIdentifier:CollectionViewCellIdentifiers.photoCell)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.makePhotoAction(_:)))
        cameraActView.addGestureRecognizer(tapGesture)

        fetchPhotoFromLibrary()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureImageView.layer.cornerRadius = 10.0
        captureImageView.layer.masksToBounds = true
        loadCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.frame
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.addSublayer(bottomView.layer)
        videoPreviewLayer?.addSublayer(viewWithCollection.layer)
        videoPreviewLayer?.addSublayer(switchButton.layer)
    }
    

    
    
    // MARK: - Actions
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
                            DispatchQueue.main.async {
                                self.captureImageView.image = image
                                self.fetchPhotoFromLibrary()
                                self.photoCollectionView.reloadData()
                            }
                        }
                        else if let error = error {
                            print(error.localizedDescription)
                        }
                        else {
                            print("Something is bad")
                        }
                    })
                }
            })
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {

        self.delegate?.fetchPhotos(photosArray:photoImg)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func switchCameraAction(_ sender: Any) {
        usingFrontCamera = !usingFrontCamera
        loadCamera()
    }
    
    // MARK: - Private Func
    
    func getFrontCamera() -> AVCaptureDevice?{
        let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for device in videoDevices!{
            let device = device as! AVCaptureDevice
            if device.position == AVCaptureDevicePosition.front {
                return device
            }
        }
        return nil
    }
    
    func getBackCamera() -> AVCaptureDevice{
        return AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    }
    
    func loadCamera() {
        if(captureSession == nil){
            captureSession = AVCaptureSession()
            captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        }
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        currentCaptureDevice = (usingFrontCamera ? getFrontCamera() : getBackCamera())
        
        do {
            input = try AVCaptureDeviceInput(device: currentCaptureDevice)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        for i : AVCaptureDeviceInput in (self.captureSession?.inputs as! [AVCaptureDeviceInput]){
            self.captureSession?.removeInput(i)
        }
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                //self.cameraPreviewSurface.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                self.previewView.layer.addSublayer(videoPreviewLayer!)
                DispatchQueue.main.async {
                    self.captureSession!.startRunning()
                }
            }
        }
    }
    
    func fetchPhotoFromLibrary() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
        assetsFetchResults = PHAsset.fetchAssets(with: options) as? PHFetchResult<AnyObject>
        imageManager = PHCachingImageManager()
    }
    
}

extension CameraViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  assetsFetchResults!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCellIdentifiers.photoCell, for: indexPath) as! PhotoCell
        
        let asset = assetsFetchResults?[indexPath.item];
        imageManager?.requestImage(for: asset as! PHAsset, targetSize: cell.frame.size, contentMode: PHImageContentMode(rawValue: 1)!, options: nil) { (result, info) in
            cell.setUpWithImage(image: result!)
//            if (self.selectedPhotoSet.contains((self.assetsFetchResults?.object(at: indexPath.row)) as Any)){
//                cell.selectedView.isHidden = false
//            }
        }
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight:CGFloat = collectionView.frame.height
        let cellWidth:CGFloat = collectionView.frame.width/4
        
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    // MARK - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        cell.selectCell()

        let checkArray = self.photoImg.filter({ $0 == cell.backImage.image })
        
        if checkArray.count > 0{
            for i in 0  ..< self.photoImg.count {
                if self.photoImg[i] == checkArray.first {
                    self.photoImg.remove(at: i)
                    break
                }
            }

        }else{
            photoImg.append(cell.backImage.image!)

        }

        
        countLabel.text = String(photoImg.count)
        if photoImg.count < 1 {
            countLabel.isHidden = true
        }else {
            countLabel.isHidden = false
        }
        
        
    }
    
    
}
