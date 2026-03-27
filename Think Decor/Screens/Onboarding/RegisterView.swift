//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var hideTabBar: Bool
    @State private var goToOTP = false

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    var body: some View {

        VStack(spacing: 0) {

            topBar

            ScrollView {

                VStack(spacing: 22) {

                    header

                    inputSection

                    createButton

                    socialSection

                    termsText
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
                hideTabBar = true
            }
            .onDisappear {
                hideTabBar = true
            }
    }
}

// MARK: - Top bar

private extension RegisterView {

    var topBar: some View {

        HStack {

            Button {
                dismiss()     // ✅ back navigation
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

// MARK: - Header

private extension RegisterView {

    var header: some View {

        VStack(spacing: 8) {

            Text("Create Account")
                .font(.title2.bold())

            Text("Lorem ipsum dolor sit amet, consectetur")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 10)
    }
}

// MARK: - Inputs

private extension RegisterView {

    var inputSection: some View {

        VStack(spacing: 16) {

            field(title: "Full Name", placeholder: "Enter your name", text: $name)

            field(title: "E-mail", placeholder: "Enter your email", text: $email)

            passwordField
        }
    }

    func field(title: String,
               placeholder: String,
               text: Binding<String>) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            TextField(placeholder, text: text)
                .padding(.horizontal, 18)
                .frame(height: 52)
                .background(Color.gray.opacity(0.08))
                .cornerRadius(26)
        }
    }

    var passwordField: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Password")
                .font(.caption)
                .foregroundColor(.gray)

            HStack {

                Group {
                    if showPassword {
                        TextField("Enter your password", text: $password)
                    } else {
                        SecureField("Enter your password", text: $password)
                    }
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 18)
            .frame(height: 52)
            .background(Color.gray.opacity(0.08))
            .cornerRadius(26)
        }
    }
}

// MARK: - Create button

private extension RegisterView {

    var createButton: some View {

        Button {
            goToOTP = true

        } label: {

            Text("Create An Account")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color(hex: "#00594E"))
                .cornerRadius(27)
        }
        .padding(.top, 10)
        .navigationDestination(isPresented: $goToOTP) {
            EnterOTPView(email: email)
        }

    }
}

// MARK: - Social section

private extension RegisterView {

    var socialSection: some View {

        VStack(spacing: 16) {

            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.2))
                Text("Or Sign In with")
                    .font(.caption)
                    .foregroundColor(.gray)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.2))
            }

            HStack(spacing: 20) {
                
                socialButton(image: "ic_google")
                socialButton(image: "ic_apple")
                socialButton(image: "ic_facebook")
            }
        }
        .padding(.top, 8)
    }

    func socialButton(image: String) -> some View {

        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.08))
            .frame(width: 56, height: 56)
            .overlay(
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(12)
            )
    }
}

// MARK: - Terms

private extension RegisterView {

    var termsText: some View {

        Text("By signing up you agree to our ")
            .font(.caption)
            .foregroundColor(.gray)
        +
        Text("Terms")
            .font(.caption.bold())
            .foregroundColor(.black)
        +
        Text(" and ")
            .font(.caption)
            .foregroundColor(.gray)
        +
        Text("Conditions of Use")
            .font(.caption.bold())
            .foregroundColor(.black)
    }
}

#Preview {
    NavigationStack {
        RegisterView(hideTabBar: .constant(true))
    }
}
