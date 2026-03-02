import SwiftUI

// MARK: - Container


struct OnboardingContainerView: View {

    @State private var page = 0

    private let pages: [OnboardingModel] = [

        .init(
            image: "onboard1",
            title: "Goods with guaranteed quality",
            subtitle: "Semper in cursus magna et varius nunc adipiscing. Elementum justo, laoreet id sem."
        ),

        .init(
            image: "onboard2",
            title: "Total warranty if the product doesn't fit",
            subtitle: "Semper in cursus magna et varius nunc adipiscing. Elementum justo, laoreet id sem."
        ),

        .init(
            image: "onboard3",
            title: "Let’s fulfill your housing needs in Dream Decor",
            subtitle: "Lorem ipsum is simply dummy text of the printing and typesetting industry."
        )
    ]

    var body: some View {

        TabView(selection: $page) {

            ForEach(pages.indices, id: \.self) { index in

                OnboardingPageView(
                    model: pages[index],
                    index: index,
                    total: pages.count,
                    currentIndex: $page
                ) {
                    withAnimation {
                        page = pages.count
                    }
                }
                .tag(index)
            }

            FinalLetsGoView()
                .tag(pages.count)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))   // IMPORTANT
        .toolbar(.hidden, for: .navigationBar)
    }
}


// MARK: - Model

struct OnboardingModel {
    let image: String
    let title: String
    let subtitle: String
}


// MARK: - Page

struct OnboardingPageView: View {

    let model: OnboardingModel
    let index: Int
    let total: Int
    @State private var goToRegister = false

    @Binding var currentIndex: Int
    let onLastPage: () -> Void

    var body: some View {

        GeometryReader { geo in

            ZStack(alignment: .bottom) {

                Image(model.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width,
                           height: geo.size.height)
                    .clipped()

                LinearGradient(
                    colors: [
                        Color.black.opacity(0.0),
                        Color.black.opacity(0.35),
                        Color.black.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(spacing: 14) {

                    Text(model.title)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)          // IMPORTANT
                        .padding(.horizontal, 28)

                    Text(model.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .frame(maxWidth: .infinity)          // IMPORTANT
                        .padding(.horizontal, 28)

                    PageDotsView(
                        count: total,
                        index: currentIndex
                    )

                    Button {

                        if index < total - 1 {
                            withAnimation {
                                currentIndex += 1
                            }
                        } else {
                            onLastPage()
                        }

                    } label: {

                        Text(index == total - 1 ? "Get Started" : "Continue")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(Color(hex: "#00594E"))
                            .cornerRadius(27)
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 6)
                    if index == total - 1 {

                            HStack(spacing: 4) {

                                Text("Don’t have an account?")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.85))

                                Button {
                                    print("Register tapped")
                                    goToRegister = true

                                } label: {
                                    Text("Register")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(Color(hex: "#00B2A9"))
                                }
                                
                                .navigationDestination(isPresented: $goToRegister) {
                                    RegisterView(hideTabBar: .constant(false))
                                }
                            }
                            .padding(.top, 10)
                        }

                }
                .frame(maxWidth: .infinity)    // IMPORTANT
                .padding(.bottom, geo.safeAreaInsets.bottom + 28)
            }
            .ignoresSafeArea(edges: .top)   // only top
        }
    }
}


// MARK: - Dots

struct PageDotsView: View {

    let count: Int
    let index: Int

    var body: some View {

        HStack(spacing: 8) {

            ForEach(0..<count, id: \.self) { i in

                Capsule()
                    .fill(
                        i == index
                        ? Color(hex: "#00594E")
                        : Color.white.opacity(0.5)
                    )
                    .frame(width: i == index ? 18 : 6,
                           height: 6)
            }
        }
    }
}


// MARK: - Final screen

struct FinalLetsGoView: View {

    @State private var goToLogin = false

    var body: some View {

        GeometryReader { geo in

            ZStack(alignment: .bottom) {

                Image("onboard4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width,
                           height: geo.size.height)
                    .clipped()

                LinearGradient(
                    colors: [
                        Color.black.opacity(0.0),
                        Color.black.opacity(0.35),
                        Color.black.opacity(0.9)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(spacing: 16) {

                    Text("Decorate your dream space")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 28)

                    Text("Discover the power of modern interior design with our intuitive app.")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 28)

                    Button {

                        print("➡️ Navigate to Home")
                        goToLogin = true

                    } label: {

                        HStack(spacing: 8) {
                            Text("Let’s go")
                                .font(.system(size: 16, weight: .semibold))
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color(hex: "#00594E"))
                        .cornerRadius(27)
                    }
                    .padding(.horizontal, 28)

                    .navigationDestination(isPresented: $goToLogin) {
                        LoginView(hideTabBar: .constant(true))
                                }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, geo.safeAreaInsets.bottom + 28)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}


// MARK: - Preview

#Preview {
    OnboardingContainerView()
}
