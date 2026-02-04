import SwiftUI

struct ProductDetailView: View {

    @State private var selectedVariant = 0
    @State private var expandedSection: String?
    @Environment(\.dismiss) var dismiss
    @Binding var hideTabBar: Bool
    @State private var isFavourite = false
    @State private var selectedImageIndex = 0

    let productImages = ["ic_chair", "ic_chair", "ic_chair", "ic_chair"]
    let variants = ["Silver", "Black"]

    var body: some View {

        VStack(spacing: 0) {

            ScrollView {

                VStack(alignment: .leading, spacing: 16) {

                    // MARK: - Image header with top actions

                    ZStack {
                        
                        // MARK: Image + pager + counter
                        VStack(spacing: 8) {

                            ZStack(alignment: .bottomTrailing) {

                                TabView(selection: $selectedImageIndex) {

                                    ForEach(productImages.indices, id: \.self) { index in
                                        Image(productImages[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 300)
                                            .background(Color.white)
                                            .padding(.top, 20)
                                            .tag(index)
                                    }
                                }
                                .frame(height: 320)
                                .tabViewStyle(.page(indexDisplayMode: .never))

                                // counter
                                Text("\(selectedImageIndex + 1)/\(productImages.count)")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                                    .padding(.trailing, 12)
                                    .padding(.bottom, 12)
                            }

                            // ✅ dots BELOW the image
                            HStack(spacing: 6) {

                                ForEach(productImages.indices, id: \.self) { index in
                                    Circle()
                                        .fill(
                                            selectedImageIndex == index
                                            ? Color(hex: "#00594E")
                                            : Color.gray.opacity(0.4)
                                        )
                                        .frame(width: 6, height: 6)
                                }
                            }
                            .padding(.bottom, 6)
                        }


                        // MARK: Top bar (overlay)
                        VStack {

                            HStack {

                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.black)
                                        .frame(width: 36, height: 36)
                                }

                                Spacer()

                                HStack(spacing: 16) {

                                    Button {
                                        isFavourite.toggle()
                                    } label: {
                                        Image(systemName: isFavourite ? "heart.fill" : "heart")
                                            .font(.system(size: 18))
                                            .foregroundColor(
                                                isFavourite
                                                ? Color(hex: "#00594E")
                                                : .black
                                            )
                                    }

                                    Button { } label: {
                                        Image(systemName: "ellipsis")
                                            .font(.system(size: 18))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 10)

                            Spacer()
                        }
                    }
                    .frame(height: 300)
                    .background(Color.white)

                    // MARK: - Title + Open AR
                    HStack(alignment: .top) {

                        VStack(alignment: .leading, spacing: 6) {

                            Text("Simple Chair")
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text("Kaktusfikon")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            HStack(spacing: 6) {

                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.fill")
                                Image(systemName: "star.leadinghalf.filled")

                                Text("4.8  •  29 reviews")
                                    .font(.caption)

                            }
                            .foregroundColor(Color(hex: "#00594E"))
                        }

                        Spacer()

                        Button {

                        } label: {
                            Text("Open AR")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color(hex: "#00594E"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    Divider()

                    // MARK: - Choose variant
                    HStack {
                        Text("Choose variant")
                            .fontWeight(.semibold)

                        Spacer()

                        Text("2 options")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 12) {

                        ForEach(0..<variants.count, id: \.self) { index in

                            VariantItemView(
                                title: variants[index],
                                isSelected: selectedVariant == index
                            )
                            .onTapGesture {
                                selectedVariant = index
                            }
                        }
                    }

                    Divider()

                    // MARK: - Description
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Description")
                            .fontWeight(.semibold)

                        Text("Premium eco elementum massa rutrum ut ut nunc sagittis justo, facilisi vel cras et vulputate in proin aliquet")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // MARK: - Expandable sections
                    ExpandableRow(title: "Key features", expanded: $expandedSection)
                    ExpandableRow(title: "Product measurements", expanded: $expandedSection)
                    ExpandableRow(title: "Package size & weight", expanded: $expandedSection)
                    ExpandableRow(title: "Materials", expanded: $expandedSection)
                    ExpandableRow(title: "Care instructions", expanded: $expandedSection)
                    ExpandableRow(title: "Assembly instructions/documents", expanded: $expandedSection)
                    ExpandableRow(title: "Store location", expanded: $expandedSection)
                    ExpandableRow(title: "Additional information", expanded: $expandedSection)

                    // MARK: - You might also need
                    VStack(alignment: .leading, spacing: 12) {

                        Text("You might also need")
                            .fontWeight(.semibold)

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                RelatedItemView(
                                    image: "navy_clock",
                                    title: "Navy Clock",
                                    subtitle: "Rollado",
                                    price: "£12"
                                )

                                RelatedItemView(
                                    image: "rotan_basket",
                                    title: "Keranjang Rotan",
                                    subtitle: "Bamboow",
                                    price: "£12"
                                )

                                RelatedItemView(
                                    image: "silver_pot",
                                    title: "Guci Silver",
                                    subtitle: "Napolin",
                                    price: "£12"
                                )
                                
                                RelatedItemView(
                                    image: "navy_clock",
                                    title: "Navy Clock",
                                    subtitle: "Rollado",
                                    price: "£12"
                                )

                            }
                        }
                    }

                    Spacer(minLength: 80)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)   // optional
            .toolbar(.hidden, for: .navigationBar) // ✅ completely hides nav bar


            // MARK: - Bottom bar
            bottomBar
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
                hideTabBar = true
            }
            .onDisappear {
                hideTabBar = false
            }
        
    }

    // MARK: - Bottom bar
    private var bottomBar: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text("Total price")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("£22")
                    .font(.headline)
            }

            Spacer()

            Button {

            } label: {

                Text("Send req to buyers")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(width: 190, height: 44)
                    .background(Color(hex: "#00594E"))
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

struct VariantItemView: View {

    let title: String
    let isSelected: Bool

    var imageName: String {
        switch title.lowercased() {
        case "silver":
            return "chair_silver"
        case "black":
            return "chair_black"
        default:
            return "ic_chair"
        }
    }

    var body: some View {

        VStack(spacing: 6) {

            ZStack(alignment: .topTrailing) {

                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.12))

                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                }
                .frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color(hex: "#00594E") : Color.gray.opacity(0.3),
                                lineWidth: isSelected ? 2 : 1)
                )

                // ✅ Selected tick (green)
                if isSelected {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#00594E"))

                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 18, height: 18)
                    .offset(x: 6, y: -6)
                }
            }

            Text(title)
                .font(.caption)
        }
    }
}

struct ExpandableRow: View {

    let title: String
    @Binding var expanded: String?

    var isExpanded: Bool {
        expanded == title
    }

    var body: some View {

        VStack(spacing: 0) {

            Button {

                withAnimation(.easeInOut) {
                    expanded = isExpanded ? nil : title
                }

            } label: {

                HStack {

                    Text(title)
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 12)
            }

            if isExpanded {

                Text("Details go here...")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 12)
            }

            Divider()
        }
    }
}

struct RelatedItemView: View {

    let image: String
    let title: String
    let subtitle: String
    let price: String

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 124, height: 124)
                .background(Color(.systemGray6))
                .cornerRadius(12)

            Text(title)
                .font(.caption)
                .fontWeight(.semibold)

            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.gray)

            Text(price)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#00594E"))
        }
        .frame(width: 124, height: 190)   // ✅ exact size like design
    }
}


#Preview {
    NavigationStack {
        ProductDetailView(hideTabBar: .constant(true))
    }
}
