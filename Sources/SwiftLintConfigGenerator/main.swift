import SwiftLintFramework
import TSCBasic
import TSCUtility
import Yams
import Files

// TODO: Use swift-argument-parser for parsing command line arguments: https://github.com/apple/swift-argument-parser

// TODO: Fill in usage/overview details
let parser = ArgumentParser(usage: "[options]", overview: "Generates a .swiftlint.yml file with all opt-in rules enabled, taking the provided options into consideraiton.")

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

let allSwiftLintRules = masterRuleList.list
print("All SwiftLint rules: \(allSwiftLintRules.keys)\n\(allSwiftLintRules.count) total") // 191 total

let allOptInRules = allSwiftLintRules.filter { $0.value is OptInRule.Type }
print("All Opt-In rules: \(allOptInRules.keys)\n\(allOptInRules.count) total") // 107 opt in

let optInRuleNames = allOptInRules.keys.map { String(describing: $0) }.sorted()
let yamlOptions: [String: [String]] = ["opt_in_rules": optInRuleNames]
print(yamlOptions)

let yamlString = try? Yams.dump(object: yamlOptions)
print(yamlString ?? "fail")
guard let yamlStringData = yamlString?.data(using: .utf8) else { fatalError("Failed to convert YAML string into data") }

do {
    let savedConfig = try Folder.current.createFile(named: ".swiftlint.yml", contents: yamlStringData)
    print("Created SwiftLint config at '\(savedConfig.path)'")
} catch {
    fatalError(error.localizedDescription)
}
