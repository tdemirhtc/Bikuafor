//
//  Alamofire.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

var alamofireManager: AlamofireManager?

class Networking {
    static let sharedInstance = Networking()
    public var sessionManager: Alamofire.Session // most of your web service clients will call through sessionManager
    public var backgroundSessionManager: Alamofire.Session // your web services you intend to keep running when the system backgrounds your app will use this
    private init() {
        self.sessionManager = Alamofire.Session(configuration: URLSessionConfiguration.default)
        self.backgroundSessionManager = Alamofire.Session(configuration: URLSessionConfiguration.background(withIdentifier: ""))
    }
}

class AlamofireManager: NSObject {
    
    class var instance: AlamofireManager {
        
        if alamofireManager == nil {
            alamofireManager = AlamofireManager()
            AlamofireManager.instance.configureAlamofire()
        }
        
        return alamofireManager!
    }
    
    public var sessionManager: Alamofire.Session?
    public var backgroundSessionManager: Alamofire.Session?
    
    struct Certificates {
        
        static let certificate: SecCertificate = Certificates.certificate(filename: "192.168.1.69:45455")
        
        private static func certificate(filename: String) -> SecCertificate {
            let filePath = Bundle.main.path(forResource: filename, ofType: "cer")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
            let certificate = SecCertificateCreateWithData(nil, data as CFData)!
            
            return certificate
        }
    }
    
    func configureAlamofire() {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 60*1
        configuration.timeoutIntervalForResource = 60*1
        
        self.sessionManager = Alamofire.Session(configuration: configuration)
        
        
        let rootQueue = DispatchQueue(label: "org.alamofire.customQueue")
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.underlyingQueue = rootQueue
        
        let delegate = SessionDelegate()
        let urlSession = URLSession(configuration: configuration,
                                    delegate: delegate,
                                    delegateQueue: queue)
        self.backgroundSessionManager = Session(session: urlSession, delegate: delegate, rootQueue: rootQueue)
        
        //let configuration = URLSessionConfiguration.default
        //configuration.timeoutIntervalForResource = 60 //seconds
        //
        //self.sessionManager = Alamofire.Session(configuration: configuration)
        //self.backgroundSessionManager = Alamofire.Session(configuration: URLSessionConfiguration.background(withIdentifier: Bundle.main.bundleIdentifier!))
    }
    
    func responseObject<T>(url: URLConvertible, method: HTTPMethod = HTTPMethod.post, parameters:Parameters? = nil, encoding:ParameterEncoding = JSONEncoding.default, keyPath: String? = nil, showLoader: Bool = false, completionHandler: @escaping (AFDataResponse<T>) -> Void) where T:Mappable {
   
       
            let headerToken =  UserDefaults.standard.string(forKey: "LoginToken") == nil || UserDefaults.standard.string(forKey: "LoginToken") == "" ?  StaticVariables.publicToken : UserDefaults.standard.string(forKey: "LoginToken")
           
            
            let headers: HTTPHeaders = [
                "Content-Type" : "application/json",
                "BiKuafor-Token": headerToken! ,
                "BiKuafor-Culture" : "tr-TR"]
            
            sessionManager!.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .responseObject(keyPath: keyPath, completionHandler: {(response: AFDataResponse<T> ) -> Void in
               
                    switch response.result{
                    case .success(_):
                        completionHandler(response)
                    case .failure(let error) :
                        //print(error)
                        self.handleError(error)
                    }
                })
            
        
        
    }
    
    func responseObjectWithMultipart<T>(url: URLConvertible, parameters:Parameters? = nil,salonTypeIds:[String]? = nil , imageArray: [Data]? = nil, videoArray: [Data]? = nil, pdfArray: [Data]? = nil, youtubeArray: [String]? = nil, showLoader: Bool = false, progressVal: @escaping (Double)-> Void, completionHandler: @escaping (AFDataResponse<T>) -> Void) where T:Mappable {
    
        let headerToken =  UserDefaults.standard.string(forKey: "LoginToken") == nil || UserDefaults.standard.string(forKey: "LoginToken") == "" ?  StaticVariables.publicToken : UserDefaults.standard.string(forKey: "LoginToken")
        
        let headers: HTTPHeaders = [
            "Content-Type":"multipart/form-data",
            "BiKuafor-Culture" : "tr-TR",
            "BiKuafor-Token" : headerToken!
        ]
        
        if showLoader {
            //Lodin açılacak
            //self.isLoading = true
        }
        
        AF.upload(multipartFormData: { (multipartData) in
            
            for (key, value) in parameters! {
                multipartData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                
            }
            
            if let imageArray = imageArray {
                for imageData in imageArray {
                    multipartData.append(imageData, withName: "File", fileName: "image.png", mimeType: "image/png")
                }
            }
            
            if let _salonTypeIds = salonTypeIds {
                for salonID in _salonTypeIds {
                    multipartData.append("\(salonID)".data(using: String.Encoding.utf8)!, withName: "SalonTypeIds")
                }
            }
            
            if let videoArray = videoArray {
                for videoData in videoArray {
                    multipartData.append(videoData, withName: "File", fileName: "video.mp4", mimeType: "video/mp4")
                }
            }
            
            if let pdfArray = pdfArray {
                for pdfData in pdfArray {
                    multipartData.append(pdfData, withName: "File", fileName: "document.pdf", mimeType: "application/pdf")
                }
            }
            
            if let youtubeArray = youtubeArray {
                for youtubeData in youtubeArray {
                    multipartData.append(UIImage(named: "down_arrow")!.pngData()!, withName: "File", fileName: youtubeData, mimeType: "image/png")
                }
            }
        },to: url, usingThreshold: .max,
                  method: .post,
                  headers: headers)
        .responseObject(completionHandler: {(response: AFDataResponse<T> ) -> Void in
            
            switch (response.result) {
            case .success(_):
                print(response)
                completionHandler(response)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                self.handleError(error)
                break
            }
            if let error = response.error {
                self.handleError(error)
                print(error)
            }
            guard response.value != nil else {
                return
            }
            
            
            print(response.description)
        })
        
    }
    
    func handleError(_ error: Error?) {
        
        //AlertManager.showError(message: (error?.localizedDescription)!)
        
            }
}

public var Response = Array<Any>()
