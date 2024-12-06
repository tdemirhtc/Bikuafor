//
//  Update.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 5.12.2024.
//

import Foundation
import Alamofire

struct Update {
    var base64logo: String = ""
    
    func updateProfileImage(completion: @escaping (Bool, String) -> Void) {
        guard !base64logo.isEmpty else {
            print("Base64 kodlaması yapılmamış")
            completion(false, "Base64 kodlaması yapılmamış")
            return
        }
        
        let parameters: [String: Any] = [
            "FileBase64": base64logo,
            "FileExt": ".png"
        ]
        
        AlamofireManager.instance.responseObjectWithMultipart(
            url: RestApiURLManager.updateCustomer,
            parameters: parameters,
            imageArray: StaticVariables.imageArray,
            showLoader: false,
            progressVal: { progress in
                print(progress)
            }
        ) { (response: AFDataResponse<ResponseResult<BaseResponse>>) in
            if let responseResult = response.value {
                if responseResult.Success == true && responseResult.Code == 200 {
                    AlertManager.showSuccess(title: "BAŞARILI", message: responseResult.Message)
                    completion(true, responseResult.Message ?? "")
                } else {
                    AlertManager.showWarning(title: "UYARI", message: responseResult.Message)
                    completion(false, responseResult.Message ?? "")
                }
            } else {
                AlertManager.showWarning(title: "UYARI", message: response.description)
                completion(false, "Güncelleme sırasında bir hata oluştu")
            }
        }
    }
}

class ProfileManager {
    var profileImageUrl: String?
    var userId: Int?
    
    func fetchUserData(completion: @escaping (String?) -> Void) {
        guard let userId = userId else {
            print("Giriş yapılmamış kullanıcı")
            completion(nil)
            return
        }
        
        let request = getOnecustomerRequest()
        request.Id = userId
        
        AuthenticationManager.instance.getOneCustomer(
            parameters: request,
            success: { response in
                DispatchQueue.main.async {
                    if let user = response, let imageUrl = user.ImageUrl, !imageUrl.isEmpty {
                        self.profileImageUrl = imageUrl
                        completion(imageUrl)
                    } else {
                        self.profileImageUrl = nil
                        completion(nil)
                        print("Geçersiz veya boş ImageUrl")
                    }
                }
            },
            failure: { error in
                DispatchQueue.main.async {
                    print("Kullanıcı bilgileri alınamadı: \(error)")
                    self.profileImageUrl = nil
                    completion(nil)
                }
            }
        )
    }
    
    func downloadImageAsBase64(from imageUrl: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: imageUrl), let imageData = try? Data(contentsOf: url) {
                let base64Image = imageData.base64EncodedString()
                UserDefaultManager.setValue(key: "userProfileImageBase64", value: base64Image)
                completion(base64Image)
            } else {
                print("Image URL geçersiz veya veri indirilemedi")
                completion(nil)
            }
        }
    }
    
    func updateUserProfileImage() {
        fetchUserData { [weak self] imageUrl in
            guard let self = self, let imageUrl = imageUrl else {
                print("Kullanıcı resmi alınamadı")
                return
            }
            
            self.downloadImageAsBase64(from: imageUrl) { base64Image in
                guard let base64Image = base64Image else {
                    print("Resim indirilemedi veya Base64 formatına çevrilemedi")
                    return
                }
                
                var updateInstance = Update()
                updateInstance.base64logo = base64Image
                print("Base64 kodlaması Update yapısına atandı: \(updateInstance.base64logo)")
                
                updateInstance.updateProfileImage { success, message in
                    if success {
                        print("Profil resmi başarıyla güncellendi: \(message)")
                    } else {
                        print("Profil resmi güncellenirken hata oluştu: \(message)")
                    }
                }
            }
        }
    }
}



// topbar oluştur profile resmini göster ve profil resmine tıklanınca profil resmi büyüüsn.
//

