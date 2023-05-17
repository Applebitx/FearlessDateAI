//
//  LoginView.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 16.05.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    
                    Text("Hello")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("Welcome Back")
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
                    
                    RoundedTexField(placeholder: "Password", text: $password, imageName: "lock", isSecure: true, isCapitalization: true, imageColor: .redColor)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                Button {
                    
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.redColor)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    HStack {
                        Text("Don't have an account")
                            .font(.footnote)
                        
                        Text("Sign up")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
        }
    }
}
