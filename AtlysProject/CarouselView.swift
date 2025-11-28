//
//  CarouselView.swift
//  AtlysProject
//
//  Created by Keertika on 28/11/25.
//
//import SwiftUI


import SwiftUI

struct Item: Identifiable {
    var id: Int
    var title: String
    var image: String
}

class Store: ObservableObject {
    @Published var items: [Item]
    
    let images = ["Canada", "Tokyo", "London", "HongKong", "Paris"]
    
    init() {
        items = []
        for i in 0..<images.count {
            let new = Item(id: i, title: images[i], image: images[i])
            items.append(new)
        }
    }
}
struct CarouselView: View {

    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            let cardSize = min(width * 0.7, height)

            ZStack {
                ForEach(store.items) { item in
                    
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardSize, height: cardSize)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        .scaleEffect(1.0 - abs(distance(item.id)) * 0.2)
                        
                        .offset(x: distance(item.id) * (cardSize * 0.8))
                        
                        .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                }
            }
            .frame(width: width, height: height)
            .contentShape(Rectangle()) 
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = snappedItem + value.translation.width / 120
                    }
                    .onEnded { value in
                        let predicted = snappedItem + value.predictedEndTranslation.width / 120
                        let target = round(predicted)
                            .remainder(dividingBy: Double(store.items.count))

                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            draggingItem = target
                        }

                        snappedItem = target
                    }
            )
        }
    }

    func distance(_ item: Int) -> Double {
        (draggingItem - Double(item))
            .remainder(dividingBy: Double(store.items.count))
    }
}


struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
