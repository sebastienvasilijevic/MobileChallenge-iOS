import Foundation
import ApolloCodegenLib
import ArgumentParser

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
struct FileStructure: CustomDebugStringConvertible {
    
    let rootFolderUrl: URL
    let coreFolderUrl: URL
    let cliFolderUrl: URL
    
    init() throws {

        let fileFolder = FileFinder.findParentFolder() // Result: MobileChallenge/Codegen/Sources/Codegen

        rootFolderUrl = fileFolder
            .apollo.parentFolderURL() // Result: MobileChallenge/Codegen/Sources
            .apollo.parentFolderURL() // Result: MobileChallenge/Codegen
            .apollo.parentFolderURL() // Result: MobileChallenge

        coreFolderUrl = rootFolderUrl
            .apollo.childFolderURL(folderName:"MobileChallenge")
            .apollo.childFolderURL(folderName:"Network")
            .apollo.childFolderURL(folderName:"Core")

        cliFolderUrl = rootFolderUrl
            .apollo.childFolderURL(folderName: "Codegen")
            .apollo.childFolderURL(folderName: "ApolloCLI")
    }
    
    // MARK: CustomDebugStringConvertible

    var debugDescription: String {
        """
        Root folder URL: \(self.rootFolderUrl)
        Core folder URL: \(self.coreFolderUrl)
        CLI folder URL: \(self.cliFolderUrl)
        """
    }
}

struct SwiftScript: ParsableCommand {

    static var configuration = CommandConfiguration(
            abstract: """
        A swift-based utility for performing Apollo-related tasks.
        
        NOTE: If running from a compiled binary, prefix subcommands with `swift-script`. Otherwise use `swift run ApolloCodegen [subcommand]`.
        """,
            subcommands: [DownloadSchema.self, GenerateCode.self])
    
    /// The sub-command to download a schema from a provided endpoint.
    struct DownloadSchema: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "download",
            abstract: "Downloads the schema with the settings you've set up in the `DownloadSchema` command in `main.swift`.")
        
        mutating func run() throws {
            let fileStructure = try FileStructure()

            CodegenLogger.log("File structure: \(fileStructure)")

            let endpoint = URL(string: "https://graphbrainz.herokuapp.com")!

            try FileManager.default.apollo.createFolderIfNeeded(at: fileStructure.coreFolderUrl)

            let downloadOptions = ApolloSchemaOptions(endpointURL: endpoint, outputFolderURL: fileStructure.coreFolderUrl)

            try ApolloSchemaDownloader.run(
                with: fileStructure.cliFolderUrl,
                options: downloadOptions
            )
        }
    }
    
    /// The sub-command to actually generate code.
    struct GenerateCode: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your schema + your operations based on information set up in the `GenerateCode` command.")
        
        mutating func run() throws {
            let fileStructure = try FileStructure()

            CodegenLogger.log("File structure: \(fileStructure)")
            
            let schemaFileUrl = try fileStructure.coreFolderUrl.apollo.childFileURL(fileName: "schema.json")
            let apiFileUrl = try fileStructure.coreFolderUrl.apollo.childFileURL(fileName: "API.swift")
            
            let codegenOptions = ApolloCodegenOptions(
                includes: "./../**/*.graphql",
                outputFormat: .singleFile(atFileURL: apiFileUrl),
                urlToSchemaFile: schemaFileUrl
            )
            
            try ApolloCodegen.run(
                from: fileStructure.coreFolderUrl,
                with: fileStructure.cliFolderUrl,
                options: codegenOptions
            )
        }
    }
}

SwiftScript.main()
