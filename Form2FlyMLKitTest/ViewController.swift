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
        
        var containsPoses = false
        
        DispatchQueue.global(qos: .background).async { //Background thread
            var results: [Pose]?
            do {
                results = try poseDetector.results(in: image)
            }
            catch let error {
                print("Failed to detect pose with error: \(error.localizedDescription).")
                return
            }
            guard let detectedPoses = results, !detectedPoses.isEmpty else {
                return
            }
            
            containsPoses = true
            
            DispatchQueue.main.async { //Ran on main queue
                                
                for pose in detectedPoses {
                    let noseLM = (pose.landmark(ofType: .nose))
                    let leftEyeInnerLM = (pose.landmark(ofType: .leftEyeInner))
                    let leftEyeLM = (pose.landmark(ofType: .leftEye))
                    let leftEyeOuterLM = (pose.landmark(ofType: .leftEyeOuter))
                    let rightEyeInnerLM = (pose.landmark(ofType: .rightEyeInner))
                    let rightEyeLM = (pose.landmark(ofType: .rightEye))
                    let rightEyeOuterLM = (pose.landmark(ofType: .rightEyeOuter))
                    let leftEarLM = (pose.landmark(ofType: .leftEar))
                    let rightEarLM = (pose.landmark(ofType: .rightEar))
                    let mouthLeftLM = (pose.landmark(ofType: .mouthLeft))
                    let mouthRightLM = (pose.landmark(ofType: .mouthRight))
                    let leftShoulderLM = (pose.landmark(ofType: .leftShoulder))
                    let rightShoulderLM = (pose.landmark(ofType: .rightShoulder))
                    let leftElbowLM = (pose.landmark(ofType: .leftElbow))
                    let rightElbowLM = (pose.landmark(ofType: .rightElbow))
                    let leftWristLM = (pose.landmark(ofType: .leftWrist))
                    let rightWristLM = (pose.landmark(ofType: .rightWrist))
                    let leftPinkyFingerLM = (pose.landmark(ofType: .leftPinkyFinger))
                    let rightPinkyFingerLM = (pose.landmark(ofType: .rightPinkyFinger))
                    let leftIndexFingerLM = (pose.landmark(ofType: .leftIndexFinger))
                    let rightIndexFingerLM = (pose.landmark(ofType: .rightIndexFinger))
                    let leftThumbLM = (pose.landmark(ofType: .leftThumb))
                    let rightThumbLM = (pose.landmark(ofType: .rightThumb))
                    let leftHipLM = (pose.landmark(ofType: .leftHip))
                    let rightHipLM = (pose.landmark(ofType: .rightHip))
                    let leftKneeLM = (pose.landmark(ofType: .leftKnee))
                    let rightKneeLM = (pose.landmark(ofType: .rightKnee))
                    let leftAnkleLM = (pose.landmark(ofType: .leftAnkle))
                    let rightAnkleLM = (pose.landmark(ofType: .rightAnkle))
                    let leftHeelLM = (pose.landmark(ofType: .leftHeel))
                    let rightHeelLM = (pose.landmark(ofType: .rightHeel))
                    let leftToeLM = (pose.landmark(ofType: .leftToe))
                    let rightToeLM = (pose.landmark(ofType: .rightToe))

                                    
                    self.myTxtView.text = "Left Ankle: \(leftAnkleLM.position)"
                                    
                    let imgDr = self.myImgView.image
                                    
                    UIGraphicsBeginImageContext(imgDr!.size)
                    imgDr!.draw(at: CGPoint.zero)
                    let context = UIGraphicsGetCurrentContext()!
                    
                    context.setStrokeColor(UIColor.red.cgColor)
                    context.setAlpha(0.5)
                    context.setLineWidth(10.0)
                    
                    self.checkFrameLike(noseLM, context)
                    self.checkFrameLike(leftEyeInnerLM, context)
                    self.checkFrameLike(leftEyeLM, context)
                    self.checkFrameLike(leftEyeOuterLM, context)
                    self.checkFrameLike(rightEyeInnerLM, context)
                    self.checkFrameLike(rightEyeLM, context)
                    self.checkFrameLike(rightEyeOuterLM, context)
                    self.checkFrameLike(leftEarLM, context)
                    self.checkFrameLike(rightEarLM, context)
                    self.checkFrameLike(mouthLeftLM, context)
                    self.checkFrameLike(mouthRightLM, context)
                    self.checkFrameLike(leftShoulderLM, context)
                    self.checkFrameLike(rightShoulderLM, context)
                    self.checkFrameLike(leftElbowLM, context)
                    self.checkFrameLike(rightElbowLM, context)
                    self.checkFrameLike(leftWristLM, context)
                    self.checkFrameLike(rightWristLM, context)
                    self.checkFrameLike(leftPinkyFingerLM, context)
                    self.checkFrameLike(rightPinkyFingerLM, context)
                    self.checkFrameLike(leftIndexFingerLM, context)
                    self.checkFrameLike(rightIndexFingerLM, context)
                    self.checkFrameLike(leftThumbLM, context)
                    self.checkFrameLike(rightThumbLM, context)
                    self.checkFrameLike(leftHipLM, context)
                    self.checkFrameLike(rightHipLM, context)
                    self.checkFrameLike(leftKneeLM, context)
                    self.checkFrameLike(rightKneeLM, context)
                    self.checkFrameLike(leftAnkleLM, context)
                    self.checkFrameLike(rightAnkleLM, context)
                    self.checkFrameLike(leftHeelLM, context)
                    self.checkFrameLike(rightHeelLM, context)
                    self.checkFrameLike(leftToeLM, context)
                    self.checkFrameLike(rightToeLM, context)
                    
                    
                    context.drawPath(using: .stroke) // or .fillStroke if need filling
                                         
                    // Save the context as a new UIImage
                    let myImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                                    
                self.myImgView.image = myImage
                } // for poses
            } //end async on main queue
        } //end background async
        
        if containsPoses != true {
            self.myTxtView.text = "No poses detected."
        }
        
    }//end detect()
    
    // Check if the landmark.inFrameLikelihood is > 0.5 if it is add the circle 
    func checkFrameLike(_ landMark: PoseLandmark, _ lmContext: CGContext) {
        if landMark.inFrameLikelihood > 0.5 {
            let landMarkPos = landMark.position
            lmContext.addEllipse(in: CGRect(x: landMarkPos.x, y: landMarkPos.y, width: 10, height: 10))
        }//end if
    }//end checkFrameLike
    
}//end ViewController
