//
//  ProfileView.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 4.12.2024.
//
//



import SwiftUI
import CropViewController
import PhotosUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var profileImageUrl: String? = nil
    @State private var userId: Int? = UserDefaultManager.getValue(key: "userId") as? Int
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var isPresentingCropView = false
    @State private var croppedImage: UIImage? = nil
    @State private var isPresentingCamera = false
    @State private var isShowingActionSheet = false
    @State private var isPresentingPhotosPicker = false
    @AppStorage("savedProfileImage") private var savedProfileImageData: Data?
    
    var body: some View {
        VStack {

            if let croppedImage = croppedImage {
                Image(uiImage: croppedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .onTapGesture { isShowingActionSheet = true }
                var updateInstance = Update()

            } else if let savedData = savedProfileImageData,
                      let savedImage = UIImage(data: savedData) {
                Image(uiImage: savedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .onTapGesture { isShowingActionSheet = true }
            } else if let imageUrl = profileImageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 150)
                            .background(Circle().fill(Color.gray))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .onTapGesture { isShowingActionSheet = true }
                    case .failure:
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .onTapGesture { isShowingActionSheet = true }
                    }
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .onTapGesture { isShowingActionSheet = true }
            }
            
            TextField("User Name", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
            
            Button("Save") {
                fetchUserData()
                
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(
                    title: Text("Select Photo"),
                    message: Text("Choose an option"),
                    buttons: [
                        .default(Text("Go to Camera")) {
                            isPresentingCamera = true
                        },
                        .default(Text("Select from Photos Library")) {
                            isPresentingPhotosPicker = true
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $isPresentingCamera) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage, isPresentingCropView: $isPresentingCropView)
            }
            .photosPicker(isPresented: $isPresentingPhotosPicker, selection: $selectedPhoto, matching: .images)
            .onChange(of: selectedPhoto) { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            selectedImage = uiImage
                            isPresentingCropView = true
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresentingCropView) {
                if let image = selectedImage {
                    CropViewControllerWrapper(image: image, croppedImage: $croppedImage, isPresented: $isPresentingCropView)
                } else {
                    Text("loading Image...")
                }
            }
        }
        .padding()
        .onAppear(perform: fetchUserData)
        .navigationTitle("Profile")
    }
    
    func updateProfile () {
        guard let croppedImage = croppedImage,
              let imageData = croppedImage.jpegData(compressionQuality: 0.8) else {
            print("No image selected")
            return
        }
        let base64Image = imageData.base64EncodedString()
        UserDefaultManager.setValue(key: "userProfileImageBase64", value: base64Image)
        var updateInstance = Update()
        updateInstance.base64logo = base64Image
        print("Base64 kodlaması Update yapısına atandı: \(updateInstance.base64logo)")
        
        updateInstance.updateProfileImage { success, message in
            if success {
                print("Profil resmi başarıyla güncellendi: \(message)")
            } else {
                print("Profil resmi güncellenemedi: \(message)")
            }
        }
        
    }
    
    func fetchUserData() {
        guard let userId = userId else {
            print("Giriş yapılmamış kullanıcı")
            return
        }
        let request: getOnecustomerRequest = getOnecustomerRequest()
        request.Id = 20110
        
        AuthenticationManager.instance.getOneCustomer(parameters: request, success: { response in
            DispatchQueue.main.async {
                if let user = response {
                    if let imageUrl = user.ImageUrl, !imageUrl.isEmpty {
                        profileImageUrl = imageUrl
                      
                    } else {
                        profileImageUrl = nil
                        print("Geçersiz veya boş ImageUrl")
                    }
                } else {
                    print("Kullanıcı bilgileri alınamadı")
                }
            }
        }, failure: { error in
            DispatchQueue.main.async {
                print("Hata")
                profileImageUrl = nil
            }
        })
    }
    
    
    func downloadImageData(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Resim indirirken hata oluştu: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Boş veri alındı")
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
    
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Binding var isPresentingCropView: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.parent.selectedImage = image
                    self.parent.isPresentingCropView = true
                }
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct CropViewControllerWrapper: UIViewControllerRepresentable {
    var image: UIImage
    @Binding var croppedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> TOCropViewController {
        let cropViewController = TOCropViewController(image: image)
        
        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
    
    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: CropViewControllerWrapper
        
        init(_ parent: CropViewControllerWrapper) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.croppedImage = image
            parent.isPresented = false
        }
        
        
        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            parent.isPresented = false
        }
    }
}




#Preview {
    ProfileView()
}

