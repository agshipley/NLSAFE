use std::env;
use std::fs;

fn main() {
    let input = env::args().nth(1).expect("Usage: analyzer <file.ll>");
    let content = fs::read_to_string(&input).expect("Unable to read file");

    for (i, line) in content.lines().enumerate() {
        if line.contains("getelementptr") && line.contains("i64 80") {
            println!("⚠️  Line {}: Potential buffer overrun: '{}'", i + 1, line.trim());
        }
    }
}