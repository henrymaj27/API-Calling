//
//  ContentView.swift
//  API Calling
//
//  Created by Henry Majewski on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var songs = [Song]()
    var body: some View {
        NavigationView {
            List(songs) { song in
                NavigationLink(
                    destination: VStack{
                        Text(song.rank)
                            .font(.title)
                        Text(song.name)
                        Text(song.artist)
                        Text("\(song.weeksOnChart) weeks on chart")
                    },
                    label: {
                        Text("\(song.rank)")
                    }
                )
            }
        }
        .onAppear(perform: {
            getSongs()
        })
    }
    func getSongs() {
        songs.append(Song(rank: "1", name: "Cruel Summer", artist: "Taylor Swift", weeksOnChart: "13"))
        songs.append(Song(rank: "2", name: "Supercut", artist: "Lorde", weeksOnChart: "5"))
        songs.append(Song(rank: "3", name: "Bambi", artist: "CLairo", weeksOnChart: "1"))
    }
}

struct Song: Identifiable {
    let id = UUID()
    var rank: String
    var name: String
    var artist: String
    var weeksOnChart: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
