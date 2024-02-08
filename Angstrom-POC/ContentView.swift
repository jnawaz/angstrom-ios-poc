//
//  ContentView.swift
//  Angstrom-POC
//
//  Created by Jamil Nawaz on 06/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var showAutoPick = true
    @State var autoPickSelected = false
    @State var selectedPlayers: [PlayerRowData] = []
    var positions: [String] = [
        "MD",
        "DF",
        "MD",
        "FW",
        "FW",
        "FW"
    ]
    
    @State var fwPlayers: [PlayerRowData] = []
    @State var mdPlayers: [PlayerRowData] = []
    @State var dfPlayers: [PlayerRowData] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("FootballPitch")
                    .opacity(0.65)
                    .offset(x: 0, y: -830)
                    .zIndex(-1000.0)
                
                NavigationLink(destination: PlayerSelection(onPlayerSelected: { playerData in
                    selectedPlayers = []
                    selectedPlayers.append(playerData)
                })) {
                    if mdPlayers.count > 0 {
                        HexagonImage(playerName: mdPlayers[1].name, imageName: mdPlayers[1].imageName)
                            .frame(width: 140, height: 130)
                    } else {
                        Hexagon()
                            .stroke(Color("HexCentral"), lineWidth: 4)
                            .frame(width: 140, height: 130)
                    }
                }
                .frame(width: 140, height: 130)
                
                if !autoPickSelected {
                    Text("MD")
                        .foregroundColor(.gray)
                        .opacity(0.65)
                        .font(.title)
                }
                
                ForEach(0..<6) { index in
                    let color: Color = colorForHex(index: index)
                    let degreesPerSide = Double.pi / 3
                    let initialAngleOffset = Double.pi / 6
                    let radius = 140.0
                    
                    let angle = Double(index) * degreesPerSide + initialAngleOffset
                    let xOffset: CGFloat = CGFloat(radius * cos(angle))
                    let yOffset: CGFloat = CGFloat(CFloat(radius * sin(angle)))
                    
                    if fwPlayers.count > 0 {
                        switch index {
                        case 3, 4, 5:
                            HexagonImage(playerName: fwPlayers[index - 3].name, imageName: fwPlayers[index - 3].imageName)
                                .offset(x: xOffset, y: yOffset)
                        default:
                            EmptyView()
                        }
                    }
                    
                    if mdPlayers.count > 0 {
                        switch index {
                        case 0, 2:
                            HexagonImage(playerName: mdPlayers[index].name, imageName: mdPlayers[index].imageName)
                                .offset(x: xOffset, y: yOffset)
                        default:
                            EmptyView()
                        }
                    }
                    
                    if dfPlayers.count > 0 {
                        switch index {
                        case 1:
                            HexagonImage(playerName: dfPlayers[index - 1].name, imageName: dfPlayers[index - 1].imageName)
                                .offset(x: xOffset, y: yOffset)
                        default:
                            EmptyView()
                        }
                    }
                    
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
                            
                            if !autoPickSelected {
                                Text(positions[index])
                                    .foregroundColor(Color.gray)
                                    .font(.title)
                                    .opacity(0.65)
                                    .offset(x: xOffset, y: yOffset)
                            }
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
            .onAppear {
                showAutoPick = true
            }
            .onDisappear {
                showAutoPick = false
                selectedPlayers = []
            }
            
            
        }
        
        ZStack {
            VStack {
                if self.showAutoPick {
                    Button {
                        autoPickSelected = true
                        selectedPlayers = []
                        fwPlayers = [
                            PlayerRowData(name: "Erling Haaland", imageName: "ErlingHaaland", goalsScoredLastSeason: 16, teamName: "Manchester City F.C", position: "FW"),
                            PlayerRowData(name: "Mohamed Salah", imageName: "MoSalah", goalsScoredLastSeason: 9, teamName: "Liverpool F.C", position: "FW"),
                            PlayerRowData(name: "Son Hueng-min", imageName: "SHM", goalsScoredLastSeason: 13, teamName: "Tottenham Hotspur F.C", position: "FW")
                        ]
                        
                        mdPlayers = [
                            PlayerRowData(name: "Cole Palmer", imageName: "ColePalmer", goalsScoredLastSeason: 6, teamName: "Chelsea F.C", position: "MD"),
                            PlayerRowData(name: "Bruno Fernandes", imageName: "BrunoFernandes", goalsScoredLastSeason: 4, teamName: "Manchester United F.C", position: "MD"),
                            PlayerRowData(name: "Declan Rice", imageName: "DeclanRice", goalsScoredLastSeason: 3, teamName: "Arsenal F.C", position: "MD"),
                            
                        ]
                        
                        dfPlayers = [
                            PlayerRowData(name: "Thiago Silva", imageName: "ThiagoSilva", goalsScoredLastSeason: 0, teamName: "Chelsea F.C", position: "DF")
                        ]
                    } label: {
                        Text("Auto Pick")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    .frame(width: 320.0)
                    .padding()
                    .contentShape(Rectangle())
                    .background(.green)
                    .cornerRadius(8.0)
                }
                
                if selectedPlayers.count > 0 || autoPickSelected {
                    Button {
                        selectedPlayers = []
                    } label: {
                        Text("Create Bet")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                    }
                    .frame(width: 320.0)
                    .padding()
                    .contentShape(Rectangle())
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
                    .foregroundColor(.black)
                
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
