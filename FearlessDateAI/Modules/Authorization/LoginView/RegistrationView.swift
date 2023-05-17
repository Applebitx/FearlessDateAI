//
//  RegistrationView.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 17.05.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var userName = ""
    @State private var fullName = ""
    @State private var password = ""
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text("Get Started")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Create your account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color.redColor)
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack(spacing: 16) {
                RoundedTexField(placeholder: "Email", text: $email, imageName: "envelope", isSecure: false, isCapitalization: true, imageColor: .redColor)
               
                RoundedTexField(placeholder: "Username", text: $userName, imageName: "person", isSecure: false, isCapitalization: true, imageColor: .redColor)
                
                RoundedTexField(placeholder: "Fullname", text: $fullName, imageName: "person", isSecure: false, isCapitalization: true, imageColor: .redColor)
                
                RoundedTexField(placeholder: "Password", text: $password, imageName: "lock", isSecure: true, isCapitalization: true, imageColor: .redColor)
            }
            .padding(32)
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.redColor)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color.redColor)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
