//
//  ViewController.swift
//  Form2FlyMLKitTest
//
//  Created by Amanda Peterson on 2/11/21.
//

import UIKit
import MLKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var myImgView: UIImageView!
    @IBOutlet weak var myTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detect()
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadImg(_ sender: Any) {
        //Create image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    
        //Disply image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImgView.image = image
        }
        detect()
        self.dismiss(animated: true, completion: nil)
    }
    
    func detect() {
        let options = AccuratePoseDetectorOptions()
        options.detectorMode = .singleImage
           
        let poseDetector = PoseDetector.poseDetector(options: options)
           
        let image = VisionImage(image: myImgView.image!)
        
        var detectedP = true
           
        DispatchQueue.global(qos: .background).async {
            var results: [Pose]?
            do {
                results = try poseDetector.results(in: image)
            }
            catch let error {
                self.myTxtView.text = "Failed to detect pose with error: \(error.localizedDescription)."
                return
            }
            guard let detectedPoses = results, !detectedPoses.isEmpty else {
                detectedP = false
                return
            }
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                                
                for pose in detectedPoses {
                    let leftAnkleLM = (pose.landmark(ofType: .leftAnkle)).position
                    let rightAnkleLM = (pose.landmark(ofType: .rightAnkle)).position
                    let leftEyeLM = (pose.landmark(ofType: .leftEye)).position
                    let rightEyeLM = (pose.landmark(ofType: .rightEye)).position
                    let leftShoulderLM = (pose.landmark(ofType: .leftShoulder)).position
                    let rightShoulderLM = (pose.landmark(ofType: .rightShoulder)).position
                    let leftElbowLM = (pose.landmark(ofType: .leftElbow)).position
                    let rightElbowLM = (pose.landmark(ofType: .rightElbow)).position
                    let leftWristLM = (pose.landmark(ofType: .leftWrist)).position
                    let rightWristLM = (pose.landmark(ofType: .rightWrist)).position
                                    
                    self.myTxtView.text = "Left Ankle: \(leftAnkleLM)"
                                    
                    let imgDr = self.myImgView.image
                                    
                    UIGraphicsBeginImageContext(imgDr!.size)
                    imgDr!.draw(at: CGPoint.zero)
                    let context = UIGraphicsGetCurrentContext()!
                                    
                    context.setStrokeColor(UIColor.red.cgColor)
                    context.setAlpha(0.5)
                    context.setLineWidth(10.0)
                    context.addEllipse(in: CGRect(x: leftAnkleLM.x, y: leftAnkleLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: rightAnkleLM.x, y: rightAnkleLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: leftEyeLM.x, y: leftEyeLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: rightEyeLM.x, y: rightEyeLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: leftShoulderLM .x, y: leftShoulderLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: rightShoulderLM .x, y: rightShoulderLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: leftElbowLM .x, y: leftElbowLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: rightElbowLM .x, y: rightElbowLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: leftWristLM .x, y: leftElbowLM.y, width: 10, height: 10))
                    context.addEllipse(in: CGRect(x: rightWristLM .x, y: rightElbowLM.y, width: 10, height: 10))
                                    
                    context.drawPath(using: .stroke) // or .fillStroke if need filling
                                         
                    // Save the context as a new UIImage
                    let myImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                                    
                self.myImgView.image = myImage
                } // for poses
            } //end async on main queue
        } //end background async
    }//end detect
    
}//end ViewController
