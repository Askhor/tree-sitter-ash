/**
 * @file The parser for Ash, a parser generator
 * @author J. Günthner <j@guenthner.xyz>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
    name: "ash",

    rules: {
        source_file: $ => repeat($._definition),
        identifier: $ => /\w+/,
        regular_expr: $ => /\|.*/,
        regex_ref: $ => seq("#", $.identifier),
        number: $ => /\d+/,
        comment: $ => /\/{2}.*/,

        _definition: $ => choice($.token_definition, $.node_definition, $.abstract_node_definition, $.comment),
        _node_declaration: $ => seq("node", $.identifier, optional(seq("is", $.identifier))),

        token_definition: $ => seq("token", $.identifier, $.regular_expr),
        node_definition: $ => seq($._node_declaration, "{", repeat($._field), "}"),
        abstract_node_definition: $ => seq("abstract", $._node_declaration),

        _field: $ => choice($.node_field, $.comment),
        node_field: $ => choice(
            seq(optional(choice("optional", $._repeat_modifier)), $.identifier, "is", $.identifier),
            $.regular_expr,
            $.regex_ref
        ),
        _repeat_modifier: $ => seq("array", optional(seq("[", optional($.number), ",", optional($.number), "]")))
    }
});