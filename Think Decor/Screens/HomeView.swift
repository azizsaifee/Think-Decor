//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Vijayan on 07/10/25.
//

import SwiftUI


// MARK: - Home Screen

struct HomeView: View {

    @State private var showFilter = false
    @State private var showAR = false
    @Binding var hideTabBar: Bool
    @State private var goToCart = false
    @State private var goToLogin = false

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 16) {

                headerARCard()

                searchBar().padding(.horizontal, 10)

                categorySection().padding(.horizontal, 10)

//                NavigationStack {
                    
                    popularSection().padding(.horizontal, 10)
                    
//                }

                roomsSection().padding(.horizontal, 10)
            }
            .padding(.top, 10)
            .padding(.bottom, 20) // breathing space above tab bar
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            hideTabBar = false
        }
        .onDisappear {
            hideTabBar = false
        }
    }
}


// MARK: - Header

extension HomeView {

    func headerARCard() -> some View {

        ZStack(alignment: .topLeading) {

            Image("header_chair_with_bg")
                .resizable()
                .scaledToFill()
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 570 : 370)
                .clipped()

            ZStack {

                Image("ic_ellipse_header")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 70)
                    .padding(.top, 120)

                ZStack {
                    Circle()
                        .fill(Color(hex: "#00594E"))
                        .frame(width: 44, height: 44)

                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .offset(x: -6)

                    Image(systemName: "circle.fill")
                        .font(.system(size: 6))
                        .foregroundColor(.white)

                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .offset(x: 6)
                }
                .padding(.top, 220)
            }

            // top icons
            HStack {

                Button {
                    goToLogin = true
                } label: {
                    
                    Image(systemName: "square.grid.2x2")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
//                .navigationDestination(isPresented: $goToLogin) {
//                    LoginView(hideTabBar: $hideTabBar)
//                }

                Spacer()

                Button {
                    goToCart = true
                } label: {

                    ZStack(alignment: .topTrailing) {

                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.white)

                        Circle()
                            .fill(Color(hex: "#00594E"))
                            .frame(width: 16, height: 16)
                            .overlay(
                                Text("2")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .offset(x: 8, y: -8)
                    }
                }
                .buttonStyle(.plain)
                .navigationDestination(isPresented: $goToCart) {
                    CartView(hideTabBar: $hideTabBar)
                }

            }
            .padding(.top, 20)
            .padding(.horizontal, 20)

            VStack(alignment: .leading, spacing: 8) {

                Text("Check our")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 58)

                HStack {
                    Text("AR FEATURE!")
                        .font(.headline.bold())
                        .foregroundColor(.black)

                    Image(systemName: "sofa")
                        .foregroundColor(.black)
                }

                Text("Dining Chair")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.bottom, 100)

                HStack(spacing: 20) {


                    Button { showAR = true } label: {
                        Text("Open AR")
                            .font(.caption.bold())
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                    .fullScreenCover(isPresented: $showAR) {
                                ARViewControllerWrapper()
                            }

                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: "viewfinder")
                                .foregroundColor(.black)
                        )
                }

//                Spacer()

                Text("360°")
                    .foregroundColor(.white)
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
    }
}


// MARK: - Search Bar

extension HomeView {


    func searchBar() -> some View {


        HStack {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Chair, Lamp, Desk, Table etc", text: .constant(""))
                .font(.subheadline)

            Button {
                showFilter = true

            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color(hex: "#00594E"))
                    .cornerRadius(8)
            }
            .sheet(isPresented: $showFilter) {
                FilterBottomSheet()
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct FilterBottomSheet: View {

    @State private var price: Double = 260
    @State private var selectedCategory = "Chairs"
    @State private var selectedRating = 4

    let categories = ["Chairs","Sofa","Dining Room","Dining Room1","Sofa Bed","Others"]

    var body: some View {

        VStack(spacing: 20) {

            // drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)

            // header
            HStack {

                Image(systemName: "xmark")
                Text("Filter")
                    .font(.headline)

                Spacer()

                Button("Reset Filters") { }
                    .foregroundColor(Color(hex: "#00594E"))
            }

            // Categories
            VStack(alignment: .leading, spacing: 12) {

                Text("Categories")
                    .font(.headline)

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {

                    ForEach(categories, id: \.self) { item in

                        Text(item)
                            .font(.subheadline)
                            .foregroundColor(
                                selectedCategory == item ? .white : .black
                            )
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedCategory == item
                                ? Color(hex: "#00594E")
                                : Color.white
                            )
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .clipShape(Capsule())
                            .onTapGesture {
                                selectedCategory = item
                            }
                    }
                }
            }

            // Price
            VStack(alignment: .leading, spacing: 12) {

                Text("Price")
                    .font(.headline)

                Slider(value: $price, in: 260...12000)

                HStack {
                    Text("$260")
                    Spacer()
                    Text("$12.000")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }

            // Rating
            VStack(alignment: .leading, spacing: 12) {

                Text("Star Rating")
                    .font(.headline)

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {

                    ForEach(1...5, id: \.self) { value in

                        HStack(spacing: 4) {

                            ForEach(0..<value, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            Capsule()
                                .stroke(
                                    selectedRating == value
                                    ? Color.orange
                                    : Color.gray.opacity(0.3)
                                )
                        )
                        .clipShape(Capsule())
                        .onTapGesture {
                            selectedRating = value
                        }
                    }
                }
            }

            Spacer()

            Button {
                // Apply filter
            } label: {

                Text("Apply Filters")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#00594E"))
                    .cornerRadius(18)
            }

        }
        .padding()
        .presentationDetents([.fraction(0.75)])
//        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }
}


// MARK: - Category

extension HomeView {

    func categorySection() -> some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("Furniture Essentials")
                    .font(.headline)

                Spacer()

                Text("See all →")
                    .font(.caption)
                    .foregroundColor(Color(hex: "#00594E"))
            }

            HStack(spacing: 14) {

                categoryItem(title: "Chair", icon: "chair.fill")
                categoryItem(title: "Sofa", icon: "sofa.fill")
                categoryItem(title: "Desk", icon: "desktopcomputer")
            }
        }
    }

    func categoryItem(title: String, icon: String) -> some View {

        VStack(spacing: 8) {

            Image(systemName: icon)
                .font(.title2)

            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.white))
        .cornerRadius(14)
    }
}


// MARK: - Popular

extension HomeView {

    func popularSection() -> some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("Popular")
                    .font(.headline)
                Spacer()
                Text("See all →")
                    .font(.caption)
                    .foregroundColor(Color(hex: "#00594E"))
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 14) {

                NavigationLink {
                    ProductDetailView(hideTabBar: $hideTabBar)
                } label: {
                    popularItem(image: "sofa1", title: "Leatherette Sofa", price: "$30.99")
                }

                NavigationLink {
                    ProductDetailView(hideTabBar: $hideTabBar)
                } label: {
                    popularItem(image: "sofa2", title: "Modern Sofa", price: "$45.99")
                }

                NavigationLink {
                    ProductDetailView(hideTabBar: $hideTabBar)
                } label: {
                    popularItem(image: "sofa1", title: "Leatherette Sofa", price: "$30.99")
                }

                NavigationLink {
                    ProductDetailView(hideTabBar: $hideTabBar)
                } label: {
                    popularItem(image: "sofa2", title: "Modern Sofa", price: "$45.99")
                }
            }
            .buttonStyle(.plain)
        }
    }

    func popularItem(image: String, title: String, price: String) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 90)

            Text(title)
                .font(.caption)

            HStack {

                Text(price)
                    .font(.caption.bold())
                    .foregroundColor(Color(hex: "#00594E"))

                Spacer()

                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(Color(hex: "#00594E"))
            }
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(16)
    }
}


// MARK: - Rooms

extension HomeView {

    func roomsSection() -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("Rooms")
                .font(.headline)

            Text("Furniture for every corners in your home")
                .font(.caption)
                .foregroundColor(.gray)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 14) {

                    roomItem(image: "room1", title: "Dining Room")
                    roomItem(image: "room2", title: "Bed Room")
                    roomItem(image: "room3", title: "Office Room")
                }
            }
        }
    }

    func roomItem(image: String, title: String) -> some View {

        ZStack(alignment: .bottomLeading) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 190)
                .clipped()
                .cornerRadius(16)

            Text(title)
                .font(.caption.bold())
                .foregroundColor(.black)
                .padding(6)
                .background(Color.white.opacity(0.9))
                .cornerRadius(8)
                .padding(8)
        }
    }
}


// MARK: - Preview

#Preview {
    ContentView()
}
