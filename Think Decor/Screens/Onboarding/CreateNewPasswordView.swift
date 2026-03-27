//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI


struct CreateNewPasswordView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var goToChooseInterest = false

    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var showPassword = false
    @State private var showConfirm = false

    @State private var errorText = ""
    @State private var showSuccess = false

    let brand = Color(hex: "#00594E")

    var body: some View {

        ZStack {

            VStack {

                topBar

                VStack(alignment: .leading, spacing: 22) {

                    VStack(alignment: .leading, spacing: 6) {

                        Text("Create a\nNew Password")
                            .font(.title2.bold())

                        Text("Enter your new password")
                            .foregroundColor(.gray)
                    }

                    passwordField(
                        title: "New Password",
                        text: $password,
                        isSecure: !showPassword,
                        toggle: { showPassword.toggle() }
                    )

                    passwordField(
                        title: "Confirm Password",
                        text: $confirmPassword,
                        isSecure: !showConfirm,
                        toggle: { showConfirm.toggle() }
                    )

                    if !errorText.isEmpty {
                        Text(errorText)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    Button {

                        validateAndSubmit()

                    } label: {

                        Text("Next")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(brand)
                            .cornerRadius(27)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)

            if showSuccess {
                successPopup
            }
        }
    }

    // MARK: - Top bar

    private var topBar: some View {

        HStack {

            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding()
    }

    // MARK: - Password Field

    private func passwordField(
        title: String,
        text: Binding<String>,
        isSecure: Bool,
        toggle: @escaping () -> Void
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .foregroundColor(.gray)

            HStack {

                Group {
                    if isSecure {
                        SecureField("Enter your password", text: text)
                    } else {
                        TextField("Enter your password", text: text)
                    }
                }

                Button(action: toggle) {
                    Image(systemName: "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 18)
            .frame(height: 54)
            .background(Color.gray.opacity(0.08))
            .cornerRadius(27)
        }
    }

    // MARK: - Validation

    private func validateAndSubmit() {

        errorText = ""

        if password.count < 6 {
            errorText = "Password must be at least 6 characters"
            return
        }

        if password != confirmPassword {
            errorText = "Passwords do not match"
            return
        }

        // ✅ validation OK
        withAnimation {
            showSuccess = true
        }
    }

    // MARK: - Success popup

    private var successPopup: some View {

        ZStack {

            Color.black.opacity(0.35)
                .ignoresSafeArea()

            VStack(spacing: 14) {

                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 90, height: 90)

                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 42))
                        .foregroundColor(brand)
                }

                Text("Success")
                    .font(.headline)

                Text("Your password is successfully created")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Button {

                    showSuccess = false
                    goToChooseInterest = true
//                    dismiss()
                } label: {

                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(width: 140, height: 44)
                        .background(brand)
                        .cornerRadius(22)
                }
                .padding(.top, 6)
            }
            .padding()
            .frame(width: 280)
            .background(Color.white)
            .cornerRadius(22)
            .navigationDestination(isPresented: $goToChooseInterest) {
                ChooseInterestsView()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CreateNewPasswordView()
}
