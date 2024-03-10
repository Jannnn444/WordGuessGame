//
//  ContentView.swift
//  WordGameRe
//
//  Created by yucian huang on 2024/3/10.
//
import SwiftUI

struct ContentView: View {
    
    // Array containing all the words for guessing
    let words = ["apple", "cat", "umbrella", "pencil", "strawberry"]
    
    // State variables
    @State var guessWord = ""
    @State var countGuessing = 0
    @State var emptyBlock1 = [String]()
    @State var emptyBlock2 = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(countGuessing)")
            Spacer()
            HStack {
                Text("\(emptyBlock2)")
            }
            Spacer()
            HStack {
                // Buttons for guessing letters
                ForEach(Array("abcdefghi"), id: \.self) { letter in
                    Button(action: {
                        guessLetter(String(letter))
                    }, label: {
                        Text(String(letter))
                    })
                }
            }
            .padding(.bottom)
            HStack{
                ForEach(Array("jklmnopqrstu"), id: \.self) { letter in
                    Button(action: {
                        guessLetter(String(letter))
                    }, label: {
                        Text(String(letter))
                    })
                }
            }
            .padding(.bottom)
            HStack{
                ForEach(Array("vwxyz"), id: \.self) { letter in
                    Button(action: {
                        guessLetter(String(letter))
                    }, label: {
                        Text(String(letter))
                    })
                }
            }
            Spacer()
            Spacer()
            //MARK: New Game Button
            
            
            Button(action: startNewGame, label: {
                Image(systemName: "trophy")
                    .padding(.top)
                    .foregroundColor(.secondary)
            })
            
            HStack{
                Text("New Game")
                    .foregroundColor(.secondary)
            }
            
        }
        .padding()
        .onAppear {
            // Initialize a new game
            startNewGame()
        }
    }
    
    // Function to start a new game
    func startNewGame() {
        // Select a random word from the array
        guessWord = words.randomElement() ?? ""
        // Reset other variables
        countGuessing = 0
        emptyBlock1 = [String](repeating: "_", count: guessWord.count)
        emptyBlock2 = String(repeating: "_ ", count: guessWord.count)
        
    }
    
    // Function to handle letter guessing
    func guessLetter(_ letter: String) {
        // Increment the guess count
        countGuessing += 1
        // Check if the guessed letter is in the word
        if guessWord.contains(letter) {
            let indices = guessWord.indicesOf(string: letter)
            for index in indices {
                emptyBlock1[index] = letter
            }
            updateEmptyBlock2()
            if !emptyBlock1.contains("_") {
                // If there are no more underscores in the guessed word, all letters have been guessed correctly
                startNewGame() // Restart the game automatically
            }
        }
        // Add logic for handling incorrect guesses here
    }
    
    // Function to update the visual representation of the guessed word
    func updateEmptyBlock2() {
        emptyBlock2 = emptyBlock1.joined(separator: " ")
    }
}

extension String {
    // Function to find all indices of a substring within the string
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: string, range: position ..< endIndex) {
            indices.append(distance(from: startIndex, to: range.lowerBound))
            position = index(after: range.lowerBound)
        }
        return indices
    }
}


#Preview {
    ContentView()
}
