//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

struct LoginView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var hideTabBar: Bool
    @State private var goToRegister = false
    @State private var goToForgotPassword = false

    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            // Top bar
            HStack {
                Button {
                    dismiss()   // ✅ back navigation
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 20) {

                    // Title
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Let’s Sign you in")
                            .font(.title2.bold())

                        Text("Lorem ipsum dolor sit amet, consectetur")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding(.top, 24)

                    // Email
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Email Address")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        TextField("Enter your email address", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(24)
                    }

                    // Password
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        HStack {

                            if showPassword {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
                            }

                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(24)
                    }

                    // Remember + Forgot
                    HStack {

                        Button {
                            rememberMe.toggle()
                        } label: {
                            HStack(spacing: 10) {

                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 22, height: 22)
                                    .overlay(
                                        Circle()
                                            .fill(Color(hex: "#00594E"))
                                            .frame(width: 12, height: 12)
                                            .opacity(rememberMe ? 1 : 0)
                                    )

                                Text("Remember Me")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        .buttonStyle(.plain)

                        Spacer()

                        Button {
                            goToForgotPassword = true
                        } label: {
                            Text("Forgot Password")
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                        .navigationDestination(isPresented: $goToForgotPassword) {
                            ForgotPasswordView()
                        }
                    }
                    .padding(.top, 4)

                    // Sign in
                    Button {

                    } label: {

                        Text("Sign In")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(Color(hex: "#00594E"))
                            .cornerRadius(28)
                    }
                    .padding(.top, 12)

                    // Sign up
                    HStack(spacing: 4) {

                        Text("Don’t have an account?")
                            .foregroundColor(.gray)

                        Button {
                            goToRegister = true

                        } label: {
                            Text("Sign Up")
                                .foregroundColor(Color(hex: "#00594E"))
                                .fontWeight(.semibold)
                        }
                        .navigationDestination(isPresented: $goToRegister) {
                            RegisterView(hideTabBar: $hideTabBar)
                                   }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)

                    // Or sign in with
                    HStack {

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)

                        Text("Or Sign In with")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                    }
                    .padding(.vertical, 16)

                    // Social buttons
                    HStack(spacing: 24) {

                        socialButton("ic_google")
                        socialButton("ic_apple")
                        socialButton("ic_facebook")
                    }
                    .frame(maxWidth: .infinity)

                    // Terms
                    VStack(spacing: 4) {

                        Text("By signing up you agree to our")
                            .foregroundColor(.gray)
                            .font(.footnote)

                        HStack(spacing: 4) {
                            Text("Terms")
                                .font(.footnote.bold())

                            Text("and")
                                .font(.footnote)
                                .foregroundColor(.gray)

                            Text("Conditions of Use")
                                .font(.footnote.bold())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)

                }
                .padding(.horizontal)
            }

            Spacer()
        }
//        .background(Color.white)
//        .navigationBarBackButtonHidden(true)
//        .toolbar(.hidden, for: .navigationBar)
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)   // ✅ hides nav bar
        
        .onAppear {
                hideTabBar = true
            }
            .onDisappear {
                hideTabBar = true
            }
    }

    // MARK: - Social button

    private func socialButton(_ systemImage: String) -> some View {

        RoundedRectangle(cornerRadius: 14)
            .fill(Color.gray.opacity(0.08))
            .frame(width: 64, height: 64)
            .overlay(
                Image(systemImage)
                    .font(.title2)
                    .foregroundColor(.black)
            )
    }
}

#Preview {
    NavigationStack {
        LoginView(hideTabBar: .constant(true))
    }
}
