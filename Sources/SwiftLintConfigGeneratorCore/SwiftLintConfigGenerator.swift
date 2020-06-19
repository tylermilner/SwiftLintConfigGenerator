//
//  SwiftLintConfigGenerator.swift
//  
//
//  Created by Tyler Milner on 6/19/20.
//

import SwiftLintFramework
import TSCBasic
import TSCUtility
import Yams
import Files

public final class SwiftLintConfigGenerator {
    
    // MARK: - Properties
    
    private let arguments: [String]
    
    // MARK: - Init

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    // MARK: - Public

    public func run() throws {
        // TODO: Implement a logging framework

        // TODO: Use swift-argument-parser for parsing command line arguments: https://github.com/apple/swift-argument-parser

        // TODO: What other arguments to parse?
        //          - Path to save the resulting .swiftlint.yml file (otherwise just output to current directory)
        //          - Opt-in rules
        //          - Excluded directories
        //          - Custom rules?
        //          - Rule configurations (e.g. `line_length: 240`)

        let parser = ArgumentParser(usage: "[options]", overview: "Generates a .swiftlint.yml file with all opt-in rules enabled (by default).")

        let disabledRulesArgument: OptionArgument<[String]> = parser.add(option: "--disabled-rules", kind: [String].self, usage: "Specify the rules to disable (e.g. `SwiftLintConfigGenerator --disabled-rules legacy_multiple force_try`)")

        let arguments = Array(CommandLine.arguments.dropFirst())

        let parseResult = try parser.parse(arguments)
        
        // TODO: Implement functionality to take the disabled rules into account
        let disabledRules = parseResult.get(disabledRulesArgument) ?? []
        print("disabled_rules: \(disabledRules)")

        print("Using SwiftLint version '\(Version.current.value)'")

        let allRules = masterRuleList.list

        let optInRules = allRules.filter { $0.value is OptInRule.Type }
        print("\(optInRules.count) opt-in rules (\(allRules.count) total)")

        let optInRuleNames = optInRules.keys.map { String(describing: $0) }.sorted()
        let yamlOptions: [String: [String]] = ["opt_in_rules": optInRuleNames]

        let yamlString = try? Yams.dump(object: yamlOptions)
        guard let yamlStringData = yamlString?.data(using: .utf8) else { fatalError("Failed to convert YAML string into data") }
        
        let savedConfig = try Folder.current.createFile(named: ".swiftlint.yml", contents: yamlStringData)
        print("Created SwiftLint config at '\(savedConfig.path)'")
    }
}
