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
        PlayerRowData(name: "Kevin De Bruyne", imageName: "KDB", goalsScoredLastSeason: 10, teamName: "Manchester City F.C", ranking: "+1.3K"),
        PlayerRowData(name: "Mohamed Salah", imageName: "MoSalah", goalsScoredLastSeason: 9, teamName: "Liverpool F.C", ranking: "+1.2K"),
        PlayerRowData(name: "Harry Kane", imageName: "HarryKane", goalsScoredLastSeason: 4, teamName: "FC Bayern Munich", ranking: "-1.3K"),
        PlayerRowData(name: "Bruno Fernandes", imageName: "BrunoFernandes", goalsScoredLastSeason: 14, teamName: "Manchester United", ranking: "+1K"),
        PlayerRowData(name: "Sadio Mané", imageName: "SadioMane", goalsScoredLastSeason: 22, teamName: "Al-Nassr FC", ranking: "+1.8K"),
        PlayerRowData(name: "Raheem Sterling", imageName: "RaheemSterling", goalsScoredLastSeason: 2, teamName: "Chelsea F.C", ranking: "+2K"),
        PlayerRowData(name: "Virgil van Dijk", imageName: "VirgilVanDijk", goalsScoredLastSeason: 10, teamName: "Liverpool F.C", ranking: "+712"),
        PlayerRowData(name: "Trent Alexander-Arnold", imageName: "TrentArnold", goalsScoredLastSeason: 9, teamName: "Liverpool F.C", ranking: "+650"),
        PlayerRowData(name: "Jamie Vardy", imageName: "JamieVardy", goalsScoredLastSeason: 7, teamName: "Leicester City F.C", ranking: "+461"),
        PlayerRowData(name: "Pierre-Emerick Aubameyang", imageName: "Aubameyang", goalsScoredLastSeason: 12, teamName: "Olympique de Marseille", ranking: "+200")
    ]
    
    var body: some View {
        PlayerSelectionBanner()
            .navigationTitle("Player Selection")
        List {
            ForEach(0..<10) { index in
                
                let player = players[index]
                
                PlayerRow(
                    name: player.name,
                    imageName: player.imageName,
                    goalsScored: player.goalsScoredLastSeason,
                    teamName: player.teamName,
                    ranking: player.ranking
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
    var ranking: String
    
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
                Text(ranking)
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
    var ranking: String
}

#Preview {
    PlayerSelection { _ in
        
    }
}
