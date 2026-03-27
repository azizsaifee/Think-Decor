import SwiftUI

struct SplashView: View {

    @State private var goToNext = false

    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: - Background
                SplashBackground()

                VStack(spacing: 0) {

                    Spacer()

                    // MARK: - Logo
                    Image("dream_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400, height: 200)

                    // MARK: - Title
                    Text("Dream Decor")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, -10)
                        .tracking(0)

                    Spacer()

                    // MARK: - Loader
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Color.white.opacity(0.8))
                        )
                        .scaleEffect(1.4)

                    Spacer()
                        .frame(height: 50)
                }
            }
            .ignoresSafeArea()
            .onAppear {

                // ✅ show splash for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    goToNext = true
                }
            }
            .navigationDestination(isPresented: $goToNext) {

                // 👉 your existing login screen
                OnboardingContainerView()
//                LoginView(hideTabBar: .constant(true))
            }
        }
    }
}

// MARK: - Background View

private struct SplashBackground: View {

    var body: some View {

        ZStack {

            // Base color
            Color(hex: "#00594E")

            // Big soft circle
            Circle()
                .fill(Color.white.opacity(0.08))
                .frame(width: 420, height: 420)
                .offset(x: -80, y: -220)

            // Ring
            Circle()
                .stroke(Color.white.opacity(0.10), lineWidth: 60)
                .frame(width: 460, height: 460)
                .offset(x: 120, y: -220)

            // Second ring
            Circle()
                .stroke(Color.white.opacity(0.06), lineWidth: 50)
                .frame(width: 520, height: 520)
                .offset(x: 60, y: -260)
        }
    }
}

#Preview {
    SplashView()
}
