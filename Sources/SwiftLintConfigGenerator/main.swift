import SwiftLintConfigGeneratorCore

let tool = SwiftLintConfigGenerator()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
