//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct LoginView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var hideTabBar: Bool
    @State private var goToRegister = false
    @State private var goToForgotPassword = false
    @State private var goToHomeView = false

    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false

    @State private var currentNonce: String?

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Button {
                    dismiss()
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

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Let’s Sign you in")
                            .font(.title2.bold())

                        Text("Lorem ipsum dolor sit amet, consectetur")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding(.top, 24)

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

                    Button {

                        goToHomeView = true

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
                    .navigationDestination(isPresented: $goToHomeView) {
                        ContentView()
                    }

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

                    HStack(spacing: 24) {

                        socialButton("ic_google") {
                            signInWithGoogle()
                        }

                        socialButton("ic_apple") {
                            signInWithApple()
                        }

                        socialButton("ic_facebook") {
                            loginWithFacebook()
                        }
                    }
                    .frame(maxWidth: .infinity)

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
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            hideTabBar = true
        }
        .onDisappear {
            hideTabBar = true
        }
    }

    // MARK: - Google

    private func signInWithGoogle() {

        guard let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first?
            .rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in

            if let error {
                print("Google Sign in error:", error.localizedDescription)
                return
            }

            guard let user = result?.user else { return }

            print("Google UID:", user.userID ?? "")
        }
    }

    // MARK: - Facebook

    func loginWithFacebook() {

        let manager = LoginManager()

        guard let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first?
            .rootViewController else { return }

        manager.logIn(permissions: ["public_profile", "email"], from: rootVC) { result, error in

            if let error {
                print("Facebook login error:", error.localizedDescription)
                return
            }

            guard let result, !result.isCancelled else {
                print("Facebook login cancelled")
                return
            }

            guard let token = AccessToken.current?.tokenString else {
                print("Facebook token missing")
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: token)

            Auth.auth().signIn(with: credential) { authResult, error in

                if let error {
                    print("Firebase Facebook login error:", error.localizedDescription)
                    return
                }

                print("✅ Facebook login success")
                print(authResult?.user.uid ?? "")
            }
        }
    }

    // MARK: - Apple (custom button)

    private func signInWithApple() {

        let nonce = randomNonceString()
        currentNonce = nonce

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = AppleSignInCoordinator.shared
        controller.presentationContextProvider = AppleSignInCoordinator.shared

        AppleSignInCoordinator.shared.onResult = { result in

            switch result {

            case .success(let credential):

                guard
                    let appleIDCredential = credential as? ASAuthorizationAppleIDCredential,
                    let tokenData = appleIDCredential.identityToken,
                    let tokenString = String(data: tokenData, encoding: .utf8),
                    let nonce = currentNonce
                else {
                    print("❌ Apple credential error")
                    return
                }

                let firebaseCredential = OAuthProvider.appleCredential(
                    withIDToken: tokenString,
                    rawNonce: nonce,
                    fullName: appleIDCredential.fullName
                )

                Auth.auth().signIn(with: firebaseCredential) { result, error in

                    if let error {
                        print("❌ Firebase Apple login error:", error.localizedDescription)
                        return
                    }

                    print("✅ Apple login success")
                    print("UID:", result?.user.uid ?? "")
                    print("Email:", result?.user.email ?? "")
                }

            case .failure(let error):
                print("❌ Apple Sign In failed:", error.localizedDescription)
            }
        }

        controller.performRequests()
    }

    // MARK: - Social button

    private func socialButton(
        _ imageName: String,
        action: @escaping () -> Void
    ) -> some View {

        Button(action: action) {

            RoundedRectangle(cornerRadius: 14)
                .fill(Color.gray.opacity(0.08))
                .frame(width: 64, height: 64)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(16)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Apple Coordinator

final class AppleSignInCoordinator: NSObject,
                                   ASAuthorizationControllerDelegate,
                                   ASAuthorizationControllerPresentationContextProviding {

    static let shared = AppleSignInCoordinator()

    var onResult: ((Result<ASAuthorizationCredential, Error>) -> Void)?

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        onResult?(.success(authorization.credential))
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        onResult?(.failure(error))
    }

    func presentationAnchor(for controller: ASAuthorizationController)
    -> ASPresentationAnchor {

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow } ?? UIWindow()
    }
}

// MARK: - Nonce helpers

extension LoginView {

    private func randomNonceString(length: Int = 32) -> String {

        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        var result = ""
        var remainingLength = length

        while remainingLength > 0 {

            var randoms = [UInt8](repeating: 0, count: 16)
            let errorCode = SecRandomCopyBytes(
                kSecRandomDefault,
                randoms.count,
                &randoms
            )

            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce.")
            }

            randoms.forEach { random in

                if remainingLength == 0 { return }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {

        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)

        return hashedData.map {
            String(format: "%02x", $0)
        }.joined()
    }
}

#Preview {
    NavigationStack {
        LoginView(hideTabBar: .constant(true))
    }
}
