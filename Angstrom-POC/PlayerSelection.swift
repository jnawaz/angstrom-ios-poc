//
//  PlayerSelection.swift
//  Angstrom-POC
//
//  Created by Jamil Nawaz on 06/02/2024.
//

import Foundation
import SwiftUI

struct PlayerSelection: View {
    
    var onPlayerSelected: (PlayerRowData) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    let players = [
        PlayerRowData(name: "Erling Haaland", imageName: "ErlingHaaland", goalsScoredLastSeason: 16, teamName: "Manchester City F.C", position: "FW"),
        PlayerRowData(name: "Mohamed Salah", imageName: "MoSalah", goalsScoredLastSeason: 9, teamName: "Liverpool F.C", position: "FW"),
        PlayerRowData(name: "Son Hueng-min", imageName: "SHM", goalsScoredLastSeason: 13, teamName: "Tottenham Hotspur F.C", position: "FW"),
        PlayerRowData(name: "Cole Palmer", imageName: "ColePalmer", goalsScoredLastSeason: 6, teamName: "Chelsea F.C", position: "MD"),
        PlayerRowData(name: "Bruno Fernandes", imageName: "BrunoFernandes", goalsScoredLastSeason: 4, teamName: "Manchester United F.C", position: "MD"),
        PlayerRowData(name: "Declan Rice", imageName: "DeclanRice", goalsScoredLastSeason: 3, teamName: "Arsenal F.C", position: "MD"),
        PlayerRowData(name: "Thiago Silva", imageName: "ThiagoSilva", goalsScoredLastSeason: 0, teamName: "Chelsea F.C", position: "DF")
    ]
    
    var body: some View {
        PlayerSelectionBanner()
            .navigationTitle("Player Selection")
        List {
            ForEach(0..<6) { index in
                
                let player = players[index]
                
                PlayerRow(
                    name: player.name,
                    imageName: player.imageName,
                    goalsScored: player.goalsScoredLastSeason,
                    teamName: player.teamName,
                    position: player.position
                )
                .contentShape(
                    Rectangle()
                )
                .swipeActions {
                    Button {
                        onPlayerSelected(player)
                        self.dismiss()
                    } label: {
                        VStack {
                            Image(systemName: "checkmark")
                        }
                    }
                    .tint(.green)
                }
                .onTapGesture {
                    onPlayerSelected(player)
                    self.dismiss()
                }
            }
        }
    }
}

struct PlayerRow: View {
    var name: String
    var imageName: String
    var goalsScored: Int
    var teamName: String
    var position: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(.green)
                    .clipShape(Circle())
                    .padding(.top, 16.0)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title3).fontWeight(.bold)
                        .padding(.top, 8.0)
                    Text("Goals scored last season: \(goalsScored) ")
                        .font(.caption)
                }
                Spacer()
                Text(position)
                    .font(.headline)
            }
            Text(teamName)
                .multilineTextAlignment(.leading)
                .font(.footnote)
        }
    }
}

struct PlayerSelectionBanner: View {
    var body: some View {
        VStack {
            HStack {
                Text("DRAFTS")
                    .padding()
                    .font(.headline)
                Text("TEAM")
                    .padding()
                    .font(.headline)
                Text("PLAYER")
                    .padding()
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .underline(pattern: .solid)
                Text("LEAGUE")
                    .padding()
                    .font(.headline)
            }
        }
        .frame(width: 1024)
        .background(.green)
        .clipped()
    }
}

struct PlayerRowData {
    var name: String
    var imageName: String
    var goalsScoredLastSeason: Int
    var teamName: String
    //    var ranking: String
    var position: String
}

#Preview {
    PlayerSelection { _ in
        
    }
}
