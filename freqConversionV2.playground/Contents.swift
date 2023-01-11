import Cocoa

enum Base: Float {
    case four_o = 440
    case three_two = 432
}

let NOTES_SHARP = ["A","A#","B","C","C#","D","D#","E","F","F#","G","G#"]

let NOTES_FLAT = ["A","B♭","B","C","D♭","D","E♭","E","F","G♭","G","A♭"]

/// Converts every frequency over 27 to note
func convertToNote(freq: Float, base: Base) -> String? {
    
    /// Return nil if not within processing range
    if (freq < 27 || freq > 4190) {
        return nil
    }
    
    /// Take the different from A4 on the keyboard
    let dif = log2(freq/base.rawValue)*12
    
    /// Convert to actual index
    let index = Int(round(dif)) + 48
    
    /// Find octave and note
    var octave = Int(index/12)
    let note = index % 12
    octave += (note>2) ? 1 : 0
    
    /// Generate the sharp and flat names
    let sharp = "\(NOTES_SHARP[note])\(octave)"
    let flat = "\(NOTES_FLAT[note])\(octave)"
    
    /// Return note name
    if sharp == flat {
        return sharp
    } else {
        return "\(sharp)/\(flat)"
    }
}

var result = convertToNote(freq: 27.5, base: .four_o) ?? "Undefined"
print(result)

/// Converts any note to frequency
func convertToFreq(n: String, base: Base) -> Float {
    /// Returns -1 if no note is found
    if n == "Undefined" {
        return -1
    }
    
    var str = ""
    /// If n contains "/" then its a semi-note, find based on the sharp
    if n.contains("/") {
        let charIndex = n.firstIndex(of: "/")
        str = String(n[..<charIndex!])
    } else {
        str = n
    }
    
    /// Find the octave through the last  number
    var octave = Int(String(n.last!))!
    str.popLast()
    
    /// Get the note name from the split array and find the index in NOTES_SHARP
    guard let note = NOTES_SHARP.firstIndex(of: str) else {
        return -1
    }
    
    /// Adjust octave according to note so that  each octave starts with a C-note
    octave -= (note>2) ? 1 : 0
    
    /// Find index relative to A4
    let index = note + octave*12 - 48

    let frequency = base.rawValue * pow(2, Float(index)/12)
    
    let rounded = (frequency * 100).rounded()/100
    
    return rounded
}

let freq_res = convertToFreq(n: result, base: .four_o)
print(freq_res)
