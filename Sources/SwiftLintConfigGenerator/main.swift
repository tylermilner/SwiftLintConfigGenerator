import SwiftLintFramework
import TSCBasic
import TSCUtility

// TODO: Use swift-argument-parser for parsing command line arguments: https://github.com/apple/swift-argument-parser

// TODO: Fill in usage/overview details
let parser = ArgumentParser(usage: "options", overview: "Generates a .swiftlint.yml file")

let disabledRulesArgument: OptionArgument<[String]> = parser.add(option: "--disabled-rules", kind: [String].self, usage: "Specify the rules to disable (e.g. `SwiftLintConfigGenerator --disabled-rules legacy_multiple force_try`)")

// TODO: What other arguments to parse?
//          - Path to save the resulting .swiftlint.yml file (otherwise just output to current directory)
//          - Opt-in rules
//          - Excluded directories
//          - Custom rules?
//          - Rule configurations (e.g. `line_length: 240`)

let arguments = Array(CommandLine.arguments.dropFirst())

do {
    let parseResult = try parser.parse(arguments)
    
    let disabledRules = parseResult.get(disabledRulesArgument) ?? []
    print("disabled_rules: \(disabledRules)")
} catch {
    parser.printUsage(on: stdoutStream)
}

let allSwiftLintRules = masterRuleList.list.keys

print("All SwiftLint rules: \(allSwiftLintRules)\n\(allSwiftLintRules.count) total")
