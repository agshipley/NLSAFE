use std::env;
use std::fs;

fn main() {
    let input = env::args().nth(1).expect("Usage: audit_tool <file.mlir>");
    let content = fs::read_to_string(&input).expect("Unable to read file");

    for (i, line) in content.lines().enumerate() {
        if line.contains("reshape") && line.contains("-1") {
            println!("⚠️  Line {}: Dynamic reshape detected: '{}'", i + 1, line);
        }
    }
}