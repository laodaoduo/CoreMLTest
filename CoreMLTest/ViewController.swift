//
//  ViewController.swift
//  CoreMLTest
//
//  Created by ycgwl on 2017/6/10.
//  Copyright © 2017年 lwj. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
//    var resultLab = UILabel(frame: CGRect(x: 100, y: 44, width: 80, height: 30))
    
    var lable = UILabel()
    var pickImageView = UIImageView()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
//             var resultLab = UILabel(frame: CGRect(x: 100, y: 44, width: 80, height: 30))
        lable.backgroundColor = UIColor.red
        lable.frame = CGRect(x: 90, y: 44, width: width-180, height: 30)
        lable.layer.cornerRadius = 7
        lable.clipsToBounds = true
        self.view.addSubview(lable)
        lable.textAlignment = .center
        lable.textColor = UIColor.black
        
        
        pickImageView.frame = CGRect(x: 15, y: 120, width:width-30 , height: height-150)
        self.view.addSubview(pickImageView)
//        let imgView = UIImageView().image?.cgImage
//
//        let model = try! VNCoreMLModel(for: Resnet50().model)
//        let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
//        let handler = VNImageRequestHandler(cgImage: imgView!)
//        try! handler.perform([request])
        
        /// 相机
        let openCameraBtn = UIButton(type: .custom)
        
        openCameraBtn.frame = CGRect(x: 15, y: 44, width: 60, height: 30)
        openCameraBtn.backgroundColor = UIColor.green
        openCameraBtn.layer.cornerRadius = 3
        openCameraBtn.setTitle("相机", for: .normal)
        openCameraBtn.setTitleColor(UIColor.orange, for: .normal)
        openCameraBtn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        self.view.addSubview(openCameraBtn)
        // 相册
        let photoLibrary = UIButton(type: .custom)
        photoLibrary.frame = CGRect(x: width-75, y: 44, width: 60, height: 30)
        photoLibrary.backgroundColor = UIColor.magenta
        photoLibrary.layer.cornerRadius = 3
        photoLibrary.setTitle("相册", for: .normal)
        photoLibrary.setTitleColor(UIColor.brown, for: .normal)
        photoLibrary.addTarget(self, action: #selector(openPhotoLibrary), for: .touchUpInside)
        self.view.addSubview(photoLibrary)
        
        // 查询按钮
        let searchBtn = UIButton(type: .custom)
        searchBtn.frame = CGRect(x: 15, y: 85, width: 60, height: 30)
        searchBtn.layer.cornerRadius = 10
        searchBtn.setTitle("search", for: .normal)
        searchBtn.layer.borderWidth = 0.5
        searchBtn.layer.borderColor = UIColor.cyan.cgColor
        searchBtn.setTitleColor(UIColor.black, for: .normal)
        searchBtn.addTarget(self, action: #selector(search), for: .touchUpInside)
        self.view.addSubview(searchBtn)
//
//        let imageDate = imgView.image?.cgImage
//        let model = try!VNCoreMLModel(for: Resnet50().model)
//        let request = VNCoreMLRequest(model: model, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
//
        
        
        
//        let model = Resnet50()
//
////        let cVPixelBuffer = CVPixelBuffer()
//        let input = Resnet50Input(image: imageDate)
//        let out = model.prediction(input: input)
//
//        Resnet50Output(classLabelProbs: <#T##[String : Double]#>, classLabel: <#T##String#>)
    }
    @objc func openCamera() {
        //
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
    @objc func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerControl = UIImagePickerController()
            imagePickerControl.delegate = self
            imagePickerControl.sourceType = .photoLibrary
            self.present(imagePickerControl, animated: true, completion: nil)
            
        }
    }
//    func camare() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imagePicked.contentMode = .scaleToFill
//            imagePicked.image = pickedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    func myResultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        lable.text = results[0].identifier
        for classification in results {
            
            
            print("=====++===" + classification.identifier + "----++----" )
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pickImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        pickImageView.image = pickImage
        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    @objc func search() {
        
        let imageData = pickImageView.image?.cgImage
        let model = try! VNCoreMLModel(for: Resnet50().model)
        let hander = VNImageRequestHandler(cgImage: imageData!)
        let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
        try! hander.perform([request])
        
    }
}


