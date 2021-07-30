//
//  ContentView.swift
//  API Calling
//
//  Created by Henry Majewski on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
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
                        Text("\(song.rank)  \(song.name)")
                    }
                )
            }
        }
        .onAppear(perform: {
            getSongs()
        })
        .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text("Loading Error"),
                              message: Text("There was a problem loading the data"),
                              dismissButton: .default(Text("OK")))
                })
    }
    func getSongs() {
        let apiKey = "?rapidapi-key=b617eab960msh0dfbbe9ea27b312p1268e7jsn3c209154ec9d"
        let query = "https://billboard-api2.p.rapidapi.com/hot-100?date=2021-02-20&range=1-10\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents {
                        let rank = item["rank"].stringValue
                        let name = item["title"].stringValue
                        let artist = item["artist"].stringValue
                        let weeksOnChart = item["weeks on chart"].stringValue
                        let song = Song(rank: rank, name: name, artist: artist, weeksOnChart: weeksOnChart)
                        songs.append(song)
                    }
                    return
                }
            }
        }
        showingAlert = true
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
