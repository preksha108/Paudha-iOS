//
//  CameraButtonView.swift
//  PaudhaUI
//
//  Created by Anant Narain on 17/01/24.
//
import SwiftUI

struct CameraButtonView: View {
    @Binding var isImagePickerPresented: Bool
    @Binding var capturedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType?

    var body: some View {
        VStack {
            Button("Open Camera") {
                self.sourceType = .camera
                self.isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: self.sourceType ?? .camera, isShown: $isImagePickerPresented, image: $capturedImage)
            }

            Divider()

            Button("Choose from Gallery") {
                self.sourceType = .photoLibrary
                self.isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: self.sourceType ?? .camera, isShown: $isImagePickerPresented, image: $capturedImage)
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(20)
        .padding()
    }
}

struct CameraButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonView(isImagePickerPresented: .constant(false), capturedImage: .constant(nil))
    }
}

