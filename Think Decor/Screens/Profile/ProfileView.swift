import SwiftUI


// MARK: - Profile Screen

struct ProfileView: View {

    @State private var showLogoutPopup = false
    @State private var goToLogin = false


    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 0) {

                    // Header
                    profileHeader
                        .padding(.bottom, 28)

                    // First group
                    profileMenuSection

                    sectionSpacer

                    // Setting
                    settingSection

                    sectionSpacer

                    // Support
                    supportSection

                    // Push logout down like screenshot
                    Spacer(minLength: 60)

                    logoutSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
            .background(Color.white)   // ← important
            .navigationBarHidden(true)
        }
        .overlay {
            if showLogoutPopup {
                LogoutPopupView(
                    onConfirm: {
                        showLogoutPopup = false
                        goToLogin = true
                    },
                    onCancel: {
                        showLogoutPopup = false
                    }
                )
            }
        }
        .background(Color.white)       // ← important
    }
}


// MARK: - Header

extension ProfileView {

    var profileHeader: some View {

        HStack(spacing: 16) {

            Image("ic_profile")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {

                Text("Yus Febrian")
                    .font(.system(size: 20, weight: .semibold))

                Button("Edit profile") { }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#0F766E"))
            }

            Spacer()
        }
    }
}


// MARK: - First group

extension ProfileView {

    var profileMenuSection: some View {

        VStack(spacing: 20) {

            profileRow(icon: "heart", title: "My whislist")

            profileRow(icon: "truck.box", title: "Delivery address")

            profileRow(icon: "creditcard", title: "Payment method")
        }
    }
}


// MARK: - Setting

extension ProfileView {

    var settingSection: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("Setting")
                .font(.system(size: 16, weight: .semibold))
                .padding(.bottom, 4)

            profileRow(icon: "shield", title: "Login & Security")

            profileRow(icon: "gearshape", title: "Setting")
        }
    }
}


// MARK: - Support

extension ProfileView {

    var supportSection: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("Support")
                .font(.system(size: 16, weight: .semibold))
                .padding(.bottom, 4)

            profileRow(icon: "questionmark.circle", title: "Help")

            HStack(spacing: 12) {

                Image(systemName: "globe")
                    .frame(width: 22)

                Text("Language")
                    .font(.system(size: 15))

                Spacer()

                Text("EN")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
    }
}


// MARK: - Logout

extension ProfileView {

    var logoutSection: some View {

        Button {

            print("Logout tapped")
            showLogoutPopup = true

        } label: {

            Text("Logout")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.red)
        }
    }
}


// MARK: - Row

extension ProfileView {

    func profileRow(icon: String, title: String) -> some View {

        HStack(spacing: 12) {

            Image(systemName: icon)
                .frame(width: 22)

            Text(title)
                .font(.system(size: 15))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
    }
}


// MARK: - Section Spacer

extension ProfileView {

    var sectionSpacer: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.15))
            .frame(height: 1)
            .padding(.vertical, 24)
    }
}

struct LogoutPopupView: View {

    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {

        ZStack {

            Color.black.opacity(0.45)
                .ignoresSafeArea()

            VStack(spacing: 18) {

                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 52))
                    .foregroundColor(.red)

                Text("Logout?")
                    .font(.system(size: 20, weight: .semibold))

                Text("Are you sure you want to logout?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                VStack(spacing: 12) {

                    Button {

                        onConfirm()

                    } label: {

                        Text("Yes, Logout")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.red)
                            .cornerRadius(10)
                    }

                    Button {

                        onCancel()

                    } label: {

                        Text("No, Cancel")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                    }
                }
                .padding(.top, 4)

            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
}
