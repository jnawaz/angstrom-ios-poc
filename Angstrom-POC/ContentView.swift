//
//  ContentView.swift
//  Angstrom-POC
//
//  Created by Jamil Nawaz on 06/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var selectedPlayers: [PlayerRowData] = []
    var positions: [String] = [
        "MD",
        "DF",
        "MD",
        "AT",
        "AT",
        "AT"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("FootballPitch")
                    .opacity(0.65)
                
                NavigationLink(destination: PlayerSelection(onPlayerSelected: { playerData in
                    print(playerData)
                    selectedPlayers = []
                    selectedPlayers.append(playerData)
                })) {
                    Hexagon()
                        .stroke(Color("HexCentral"), lineWidth: 4)
                        .frame(width: 140, height: 130)
                }
                .frame(width: 140, height: 130)
                
                Text("MD")
                    .font(.headline)
                    .padding(.top, 80)
                
                
                ForEach(0..<6) { index in
                    let color: Color = colorForHex(index: index)
                    let degreesPerSide = Double.pi / 3
                    let initialAngleOffset = Double.pi / 6
                    let radius = 140.0 // Make sure to use a decimal point to indicate a floating-point number
                    
                    let angle = Double(index) * degreesPerSide + initialAngleOffset
                    let xOffset: CGFloat = CGFloat(radius * cos(angle))
                    let yOffset: CGFloat = CGFloat(CFloat(radius * sin(angle)))
                    
                    if selectedPlayers.count > 0 && index == 3 {
                        HexagonImage(playerName: selectedPlayers.first!.name, imageName: selectedPlayers.first!.imageName)
                            .offset(x: xOffset, y: yOffset)
                    } else {
                        
                        ZStack {
                            NavigationLink(destination: PlayerSelection(onPlayerSelected: { playerRowData in
                                print(playerRowData)
                                selectedPlayers = []
                                selectedPlayers.append(playerRowData)
                            })) {
                                Hexagon()
                                    .stroke(color, lineWidth: 4)
                                    .frame(width: 140, height: 130)
                            }
                            .frame(width: 140, height: 130)
                            .offset(x: xOffset, y: yOffset)
                            
                            Text(positions[index])
                                .font(.headline)
                                .padding(.top, 80)
                                .offset(x: xOffset, y: yOffset)
                        }
                        
                        
                    }
                    
                    
                }
            }
            .background(Color.purple)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("BurgerMenu")
                        .resizable()
                        .frame(width:24, height: 24)
                        .foregroundStyle(Color.white)
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.white)
                }
            }
        }
        
    }
    
    
    func colorForHex(index: Int) -> Color {
        switch index {
        case 0:
            return Color("HexCentral")
        case 1:
            return Color("Hex2")
        case 2:
            return Color("HexCentral")
        case 3:
            return Color("HexAT")
        case 4:
            return Color("HexAT")
        case 5:
            return Color("HexAT")
        default:
            return Color.green
        }
    }
}

struct HexagonImage: View {
    var playerName: String
    var imageName: String
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //                .frame(width: geometry.size.width, height: geometry.size.height)
                    .frame(width: 140, height: 130)
                    .clipShape(Hexagon())
                    .overlay(
                        Hexagon()
                            .stroke(Color("HexCentral"), lineWidth: 4)
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                Text(playerName)
                               
//                    .font(.system(size: geometry.size.width / CGFloat(playerName.count + 8))) // Adjust font size dynamically
//                    .frame(maxWidth: geometry.size.width / 2)
//                    .position(x: (geometry.size.width / 2), y: (geometry.size.height / 2) + 40)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
//                    .clipShape(Hexagon())
            }
            
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    HexagonImage(playerName: "Kevin De Bruyne", imageName: "KDB")
}
