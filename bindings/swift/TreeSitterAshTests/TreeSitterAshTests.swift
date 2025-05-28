import XCTest
import SwiftTreeSitter
import TreeSitterAsh

final class TreeSitterAshTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_ash())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Ash grammar")
    }
}
