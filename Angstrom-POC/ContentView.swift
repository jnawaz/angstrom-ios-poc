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
                    .offset(x: 0, y: -830)
                    .zIndex(-1000.0)
                
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
                    .foregroundColor(.gray)
                    .opacity(0.65)
                    .font(.title)
                
                
                ForEach(0..<6) { index in
                    let color: Color = colorForHex(index: index)
                    let degreesPerSide = Double.pi / 3
                    let initialAngleOffset = Double.pi / 6
                    let radius = 140.0
                    
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
                                .foregroundColor(Color.gray)
                                .font(.title)
                                .opacity(0.65)
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
                
                ToolbarItem(placement: .principal) {
                    Image("Super7")
                        .resizable()
//                        .offset(x: 0, y: self.selectedPlayers.count > 0 ? 0 : 20)
                        .frame(width: 20, height: 38)
                        .foregroundStyle(Color.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.white)
                }
            }
            .onDisappear {
                selectedPlayers = []
            }
            
            
        }
        if selectedPlayers.count > 0 {
            ZStack {
                VStack {
                    Button {} label: {
                        Text("Auto Pick")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    .frame(width: 320.0)
                    .padding()
                    .background(.green)
                    .cornerRadius(8.0)
                    
                    Button {} label: {
                        Text("Create Bet")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    .frame(width: 320.0)
                    .padding()
                    .background(.green)
                    .cornerRadius(8.0)
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
