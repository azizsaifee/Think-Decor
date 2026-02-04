//
//  CartView.swift
//
//  Created by Vijayan on 05/02/26.
//

import SwiftUI

// MARK: - Model

struct CartItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let variant: String
    let price: Double
    var qty: Int
}

// MARK: - Main Cart Screen

struct CartView: View {
    
    @Environment(\.dismiss) private var dismiss   // ✅ here
    @Binding var hideTabBar: Bool

    @State private var items: [CartItem] = [
                CartItem(image: "ic_chair", title: "Simple Elegant Chair", variant: "Silver", price: 12, qty: 2),
                CartItem(image: "chair_black", title: "Simple Elegant Chair", variant: "Silver", price: 12, qty: 1),
                CartItem(image: "chair_silver", title: "Cushion Cover", variant: "Silver", price: 12, qty: 3)
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            topBar
            
            if items.isEmpty {
                emptyView
            } else {
                listView
            }
        }
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)   // ✅ hides nav bar
        
        .onAppear {
                hideTabBar = true
            }
            .onDisappear {
                hideTabBar = false
            }
    }
}

// MARK: - Top Bar

private extension CartView {
    
    var topBar: some View {
        
        HStack {
            
            Button {
                
                dismiss()   // ✅ go back

                
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(items.isEmpty ? "Cart" : "Chart (\(items.count))")
                .font(.headline)
            
            Spacer()
            
            Button { } label: {
                Image(systemName: "heart")
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}

// MARK: - Empty View

private extension CartView {
    
    var emptyView: some View {
        
        VStack(spacing: 16) {
            
            Spacer()
            
            Image("ic_empty_cart")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
            
            
            Text("You're cart is empty")
                .font(.headline)
            
            Text("Looks like you haven't added anything to your cart yet")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button { } label: {
                
                Text("Start Shopping")
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#00594E"))
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - List View

private extension CartView {
    
    var listView: some View {
        
        VStack(spacing: 0) {
            
            ScrollView {
                
                LazyVStack(spacing: 0) {
                    
                    ForEach($items) { $item in
                        CartRow(item: $item) {
                            remove(item)
                        }
                        Divider()
                    }
                }
                .padding(.top, 8)
            }
            
            bottomBar
        }
    }
}

// MARK: - Bottom Bar

private extension CartView {
    
    var bottomBar: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Total (\(items.count) products)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("£\(totalPrice, specifier: "%.0f")")
                    .font(.headline)
            }
            
            Spacer()
            
            Button { } label: {
                
                Text("Send req to buyers")
                    .foregroundColor(.white)
                    .frame(width: 190, height: 44)
                    .background(Color(hex: "#00594E"))
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
    }
    
    var totalPrice: Double {
        
        items.reduce(0) {
            $0 + ($1.price * Double($1.qty))
        }
    }
}

// MARK: - Helpers

private extension CartView {
    
    func remove(_ item: CartItem) {
        
        withAnimation {
            items.removeAll { $0.id == item.id }
        }
    }
}

// MARK: - Row

struct CartRow: View {
    
    @Binding var item: CartItem
    var onRemove: () -> Void
    
    @State private var offset: CGFloat = 0
    
    private let actionWidth: CGFloat = 90
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            // Red remove background
            HStack {
                Spacer()
                
                Button {
                    onRemove()
                } label: {
                    
                    VStack(spacing: 6) {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                        
                        Text("Remove")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .frame(width: actionWidth)
                    .frame(maxHeight: .infinity)
                    .background(Color.red)
                }
            }
            
            // Main content
            content
                .background(Color.white)
                .offset(x: offset)
                .gesture(dragGesture)
        }
    }
    
    // MARK: - Row content
    
    private var content: some View {
        
        HStack(alignment: .top, spacing: 12) {
            
            Image(item.image)
                .resizable()
                .scaledToFit()
                .padding(6)
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
            
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(item.variant)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    
                    Text("£\(item.price, specifier: "%.0f")")
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("/ pcs")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                
                qtyView
                
                HStack(spacing: 4) {
                    
                    Text("Total")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("£\(item.price * Double(item.qty), specifier: "%.0f")")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
    
    // MARK: - Qty
    
    private var qtyView: some View {
        
        HStack(spacing: 10) {
            
            Button {
                if item.qty > 1 {
                    item.qty -= 1
                }
            } label: {
                
                Image(systemName: "minus")
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
            }
            
            Text("\(item.qty)")
                .foregroundColor(.black)
                .font(.caption.bold())
                .frame(width: 18)
            
            Button {
                item.qty += 1
            } label: {
                
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
            }
        }
    }
    
    // MARK: - Drag
    
    private var dragGesture: some Gesture {
        
        DragGesture()
            .onChanged { value in
                
                let translation = value.translation.width
                
                // allow both left and right
                if translation < 0 {
                    // open
                    offset = max(translation, -actionWidth)
                } else {
                    // close
                    offset = min(translation - actionWidth, 0)
                }
            }
            .onEnded { value in
                
                withAnimation(.easeOut) {
                    
                    if offset < -actionWidth / 2 {
                        offset = -actionWidth
                    } else {
                        offset = 0
                    }
                }
            }
    }
    
}


// MARK: - Preview

#Preview {
    CartView(hideTabBar: .constant(true))

}
