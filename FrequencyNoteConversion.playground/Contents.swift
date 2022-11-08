import Cocoa

let notes = ["A0","A#0","B0","C0","C#0","D0","D#0","E0","F0","F#0","G0","G#0","A1","A#1","B1","C1","C#1","D1","D#1","E1","F1","F#1","G1","G#1","A2","A#2","B2","C2","C#2","D2","D#2","E2","F2","F#2","G2","G#2","A3","A#3","B3","C3","C#3","D3","D#3","E3","F3","F#3","G3","G#3","A4","A#4","B4","C4","C#4","D4","D#4","E4","F4","F#4","G4","G#4","A5","A#5","B5","C5","C#5","D5","D#5","E5","F5","F#5","G5","G#5","A6","A#6","B6","C6","C#6","D6","D#6","E6","F6","F#6","G6","G#6","A7","A#7","B7","C8"]

let indexA4 = notes.firstIndex(of: "A4")!

// MARK: Find Frequency from Note
func findFrequency(from note: String) -> Double? {
    if let noteIndex = notes.firstIndex(of: note) {
        let n = noteIndex - indexA4 // n represents the distance from A4 (default frequency of 440 Hz) in the list (negative for smaller and positive for greater index)
        return 440*(pow(2, Double(n)/12))
    }
    
    print("Note not found.")
    return nil
}

let freqResult = findFrequency(from: "C8")!
print(round(freqResult * 100) / 100.0) // Multiply by 10, round, and then divide by 10.0 for 1 decimal place

// MARK: Find Note from Frequency

func findNote(from frequency: Double) -> String {
    let dif = log2(frequency/440)*12 // dif represents the difference from A4 in the list
    let index = Int(round(dif)) + indexA4 // Round dif and add index of A4 (default) to find index as integer

    return notes[index]
}

let noteResult = findNote(from: freqResult)

print(noteResult)
