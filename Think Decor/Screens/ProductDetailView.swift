import SwiftUI

struct ProductDetailView: View {

    @State private var selectedVariant = 0
    @State private var expandedSection: String?

    let variants = ["Silver", "Black"]

    var body: some View {

        VStack(spacing: 0) {

            ScrollView {

                VStack(alignment: .leading, spacing: 16) {

                    // MARK: - Image section
                    ZStack(alignment: .bottomTrailing) {

                        Image("chair") // your asset name
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)

                        Text("1/4")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .padding()
                    }

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
                            .foregroundColor(.green)
                        }

                        Spacer()

                        Button {

                        } label: {
                            Text("Open AR")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.green.opacity(0.15))
                                .foregroundColor(.green)
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

                                RelatedItemView(title: "Navy Clock")
                                RelatedItemView(title: "Keranjang Rotan")
                                RelatedItemView(title: "Guci Silver")
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
                    .background(Color.green)
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

    var body: some View {

        VStack(spacing: 6) {

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 54, height: 54)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 2)
                )

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

                    Spacer()

                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(.gray)
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

    let title: String

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 110, height: 110)

            Text(title)
                .font(.caption)
                .fontWeight(.medium)

            Text("£12")
                .font(.caption)
                .foregroundColor(.green)
        }
        .frame(width: 110)
    }
}




#Preview {
    NavigationStack {
        ProductDetailView()
    }
}
