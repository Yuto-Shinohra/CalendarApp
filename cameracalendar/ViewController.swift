//
//  ViewController.swift
//  cameracalendar
//
//  Created by 篠原優仁 on 2022/08/31.
//

import UIKit
import AppAuth
import GTMAppAuth
import GoogleAPIClientForREST
import GTMSessionFetcher
import Vision
import VisionKit
import Foundation

class ViewController: UIViewController {
    
    private var authorization: GTMAppAuthFetcherAuthorization?
    private let clientID = ""
    private let iOSUrlScheme = ""
    typealias showAuthorizationDialogCallBack = ((Error?) -> Void)
    var requests = [VNRequest]()
    var resultingText = ""
//    let fromAppDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVision()
    }
    
    @IBAction func LogInButton(_ sender:Any){
        let scopes = [
                "https://www.googleapis.com/auth/calendar",
                "https://www.googleapis.com/auth/calendar.readonly",
                "https://www.googleapis.com/auth/calendar.events",
                "https://www.googleapis.com/auth/calendar.events.readonly"
            ]

            let configuration = GTMAppAuthFetcherAuthorization.configurationForGoogle()
            let redirectURL = URL.init(string: iOSUrlScheme + ":/oauthredirect")
            let request = OIDAuthorizationRequest.init(
                configuration: configuration,
                clientId: clientID,
                scopes: scopes,
                redirectURL: redirectURL!,
                responseType: OIDResponseTypeCode,
                additionalParameters: nil
            )

            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(
                byPresenting: request,
                presenting: self,
                callback: { (authState, error) in
                    if let error = error {
                        NSLog("\(error)")
                    } else {
                        if let authState = authState {
                            self.authorization = GTMAppAuthFetcherAuthorization.init(authState: authState)
                            GTMAppAuthFetcherAuthorization.save(self.authorization!, toKeychainForName: "authorization")
                        }
                    }
                    
                })
        print("aaa")
    }
    
    
    
    @IBAction func clear(_ sender:Any) {
        textView.text = ""
        resultingText = ""
    }
    
    @IBAction func MovetoCalendar(_ sender:Any){
        performSegue(withIdentifier: "toKakunin", sender: nil)
        print("a\n" + resultingText + "a")
    }
    
    
    @IBOutlet weak var textView: UITextView!
    
        // Setup Vision request as the request can be reused
    func setupVision() {
        let textRecognitionRequest = VNRecognizeTextRequest { request, _ in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            // 解析結果の文字列を連結する
            let maximumCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                self.resultingText += candidate.string + "\n"
            }
        }
        // 文字認識のレベルを設定
        textRecognitionRequest.recognitionLevel = .accurate
        self.requests = [textRecognitionRequest]
    }

    @IBAction func TakePicture(_ sender: Any) {
        let documentCameraViewController = VNDocumentCameraViewController()
                documentCameraViewController.delegate = self
                present(documentCameraViewController, animated: true)
        
    }
    
    func readplandata() {
        var planmonth:Int = 0
        var plandate:Int = 0
        //月特定
        /*if resultingText.contains("January"){
            planmonth = 1
        }else if resultingText.contains("February"){
            planmonth = 2
        }else if resultingText.contains("March"){
            planmonth = 3
        }else if resultingText.contains("April"){
            planmonth = 4
        }else if resultingText.contains("May"){
            planmonth = 5
        }else if resultingText.contains("June"){
            planmonth = 6
        }else if resultingText.contains("July"){
            planmonth = 7
        }else if resultingText.contains("August"){
            planmonth = 8
        }else if resultingText.contains("September"){
            planmonth = 9
        }else if resultingText.contains("October"){
            planmonth = 10
        }else if resultingText.contains("November"){
            planmonth = 11
        }else if resultingText.contains("December"){
            planmonth = 12
        }else{
            print("カレンダーに追加できませんでした。")
        }
        //日にち特定
        if resultingText.contains("first"){
            plandate = 1
        }else if resultingText.contains("second"){
            plandate = 2
        }else if resultingText.contains("third"){
            plandate = 3
        }else if resultingText.contains("fourth"){
            plandate = 4
        }else if resultingText.contains("fifth"){
            plandate = 5
        }else if resultingText.contains("sixth"){
            plandate = 6
        }else if resultingText.contains("seventh"){
            plandate = 7
        }else if resultingText.contains("eighth"){
            plandate = 8
        }else if resultingText.contains("ninth"){
            plandate = 9
        }else if resultingText.contains("tenth"){
            plandate = 10
        }else if resultingText.contains("eleventh"){
            plandate = 11
        }else if resultingText.contains("twelfth"){
            plandate = 12
        }else if resultingText.contains("thirteenth"){
            plandate = 13
        }else if resultingText.contains("fourteenth"){
            plandate = 14
        }else if resultingText.contains("fifteenth"){
            plandate = 15
        }else if resultingText.contains("sixteenth"){
            plandate = 16
        }else if resultingText.contains("seventeenth"){
            plandate = 17
        }else if resultingText.contains("eighteenth"){
            plandate = 18
        }else if resultingText.contains("nineteenth"){
            plandate = 19
        }else if resultingText.contains("twentieth"){
            plandate = 20
        }else if resultingText.contains("twenty-first"){
            plandate = 21
        }else if resultingText.contains("twenty-second"){
            plandate = 22
        }else if resultingText.contains("twenty-third"){
            plandate = 23
        }else if resultingText.contains("twenty-fourth"){
            plandate = 24
        }else if resultingText.contains("twenty-fifth"){
            plandate = 25
        }else if resultingText.contains("twenty-sixth"){
            plandate = 26
        }else if resultingText.contains("twenty-seventh"){
            plandate = 27
        }else if resultingText.contains("twenty-eighth"){
            plandate = 28
        }else if resultingText.contains("twenty-nineth"){
            plandate = 29
        }else if resultingText.contains("thirtieth"){
            plandate = 30
        }else if resultingText.contains("thirty-first"){
            plandate = 31
        }else{
            print("カレンダーに追加できませんでした。")
        }*/
        
        
        
        
        
    }
    
 

}

extension ViewController: VNDocumentCameraViewControllerDelegate {

    // DocumentCamera で画像の保存に成功したときに呼ばれる
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true)

        // Dispatch queue to perform Vision requests.
        let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue",
                                                             qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
        textRecognitionWorkQueue.async {
            self.resultingText = ""
            for pageIndex in 0 ..< scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                if let cgImage = image.cgImage {
                    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

                    do {
                        try requestHandler.perform(self.requests)
                    } catch {
                        print(error)
                    }
                }
            }
            DispatchQueue.main.async(execute: {
                // textViewに表示する
                self.textView.text = self.resultingText
            })
        }
    }
}
