//
//  AlertManager.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit
import CDAlertView

class AlertManager: NSObject {

    static func showTextFiled(title: String = "Bilgilendirme", message: String? = nil, complation:((String?) -> Void)? = nil, cancelComplation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.notification)
        alert.add(action: CDAlertViewAction(title: "İptal", handler: { action in
            
            if cancelComplation != nil {
                cancelComplation!()
            }
            
            return true
        }))
        alert.add(action: CDAlertViewAction(title: "Ekle", handler: { action in
            if complation != nil {
               
                complation!(alert.textFieldText)
            }
            return true
        }))
        
        alert.isTextFieldHidden = false
        alert.textFieldPlaceholderText = "YouTube Linki Giriniz"
        
        alert.show { (alertview) in
            
        }
    }
    
    static func showWarning(title: String = "Uyarı", message: String? = nil, complation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.warning)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        alert.show()
    }
    
    static func showSuccess(title: String = "Başarılı", message: String? = nil, complation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
                        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.success)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        //if message!.contains("<") {
        //    let htmlMessage = "<html>" + message! + "</html>"
        //    alert.messageLabel.attributedText = UIUtilityManager.stringFromHtml(string: htmlMessage)
        //}
        
        alert.show()
    }
    
    static func showError(title: String = "Hata", message: String? = nil, complation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.error)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        alert.show()
        
    }
    
    static func showNotification(title: String = "Bilgilendirme", message: String? = nil, complation:(()->Void)? = nil, cancelComplation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.notification)
        alert.add(action: CDAlertViewAction(title: "İptal", handler: { action in
            
            if cancelComplation != nil {
                cancelComplation!()
            }
            
            return true
        }))
        alert.add(action: CDAlertViewAction(title: "Evet", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        
        alert.show()
    }
    
    static func showInfoNotification(title: String = "Bilgilendirme", message: String? = nil, complation:(()->Void)? = nil, cancelComplation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.notification)
        alert.add(action: CDAlertViewAction(title: "Tamam", handler: { action in
            
            if cancelComplation != nil {
                cancelComplation!()
            }
            return true
        }))
        
        alert.show()
    }
    
    static func showErrorNotification(title: String = "Uyarı", message: String? = nil, complation:(()->Void)? = nil, cancelComplation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.error)
        alert.add(action: CDAlertViewAction(title: "İptal", handler: { action in
            
            return true
        }))
        alert.add(action: CDAlertViewAction(title: "Evet", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        
        alert.show()
    }
    
    static func showWarningNotification(title: String = "Uyarı", message: String? = nil, complation:(()->Void)? = nil, cancelComplation:(()->Void)? = nil) {
        
        //UIUtilityManager.viewEndEditing()
        
        let alert = CDAlertView(title: title, message: message, type: CDAlertViewType.warning)
        alert.add(action: CDAlertViewAction(title: "İptal", handler: { action in
            
            return true
        }))
        alert.add(action: CDAlertViewAction(title: "Evet", handler: { action in
            if complation != nil {
                complation!()
            }
            return true
        }))
        
        alert.show()
    }
}
