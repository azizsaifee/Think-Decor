//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI

// MARK: - Enter OTP Screen

struct EnterOTPView: View {

    @Environment(\.dismiss) private var dismiss

    let email: String

    @State private var otp: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?

    @State private var showAgreement = false
    @State private var showInvalidAlert = false

    private let brandColor = Color(hex: "#00594E")

    var body: some View {

        ZStack {

            VStack(spacing: 0) {

                topBar

                VStack(spacing: 22) {

                    headerView

                    otpBoxes

                    continueButton

                    resendView
                }
                .padding(.horizontal, 24)

                Spacer()
            }

            if showAgreement {
                agreementPopup
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .alert("Invalid OTP", isPresented: $showInvalidAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a valid OTP")
        }
        .onAppear {
            focusedIndex = 0
        }
    }
}

// MARK: - Top Bar

private extension EnterOTPView {

    var topBar: some View {

        HStack {

            Button {
                dismiss()
            } label: {

                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 10)
    }
}

// MARK: - Header

private extension EnterOTPView {

    var headerView: some View {

        VStack(spacing: 8) {

            Text("Enter OTP")
                .font(.title2.bold())
                .foregroundColor(.black)

            Text("We have just sent you 4 digit code via your\nemail \(email)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }
}

// MARK: - OTP Boxes

private extension EnterOTPView {

    var otpBoxes: some View {

        HStack(spacing: 14) {

            ForEach(0..<4, id: \.self) { index in

                TextField("", text: $otp[index])
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 56, height: 56)
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                focusedIndex == index
                                ? brandColor
                                : Color.clear,
                                lineWidth: 1.5
                            )
                    )
                    .focused($focusedIndex, equals: index)
                    .onChange(of: otp[index]) { newValue in

                        let filtered = newValue.filter { $0.isNumber }

                        if filtered.count > 1 {
                            otp[index] = String(filtered.last!)
                        } else {
                            otp[index] = filtered
                        }

                        if filtered.count == 1 {
                            focusedIndex = index < 3 ? index + 1 : nil
                        }
                    }
            }
        }
    }
}

// MARK: - Continue Button

private extension EnterOTPView {

    var continueButton: some View {

        Button {

            let code = otp.joined()

            // Demo validation
            if code == "1234" {

                withAnimation {
                    showAgreement = true
                }

            } else {

                showInvalidAlert = true
            }

        } label: {

            Text("Continue")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(brandColor)
                .cornerRadius(27)
        }
        .padding(.top, 18)
    }
}

// MARK: - Resend View

private extension EnterOTPView {

    var resendView: some View {

        HStack(spacing: 4) {

            Text("Didn’t receive code?")
                .foregroundColor(.gray)

            Button("Resend Code") {

                // API call here if needed

            }
            .foregroundColor(brandColor)
            .fontWeight(.semibold)
        }
        .font(.subheadline)
        .padding(.top, 8)
    }
}

// MARK: - Agreement Popup

private extension EnterOTPView {

    var agreementPopup: some View {

        ZStack {

            Color.black.opacity(0.35)
                .ignoresSafeArea()

            VStack(spacing: 18) {

                Text(
                    "I agree to the Terms of Service and Conditions of Use including consent to electronic communications and I affirm that the information provided is my own."
                )
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

                HStack {

                    Button("Disagree") {

                        withAnimation {
                            showAgreement = false
                        }
                    }
                    .foregroundColor(.red)

                    Spacer()

                    Button {

                        withAnimation {
                            showAgreement = false
                        }

                        // ✅ success / next screen navigation here

                    } label: {

                        Text("Agree")
                            .foregroundColor(.white)
                            .frame(width: 110, height: 40)
                            .background(brandColor)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: 320)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EnterOTPView(email: "example@gmail.com")
    }
}
