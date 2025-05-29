token space |([ \t\n\r]|//.*)
token identifier |\w+
token number |\d+
token regular_expression |\|.*

// A comment!
node file {
	// Another comment!
	array definitions is definition
}

abstract node definition

node type_spec {
	|is
	type is identifier
}

node token is definition {
	|token
	regex is regular_expression
}

node abstract_node is definition {
	|abstract
	|node
	name is identifier
	optional type is type_spec
}

node node is definition {
	|node
	name is identifier
	optional type is type_spec
	|{
	array fields is field
	|}
}

abstract node field

abstract node field_modifier

node OPTIONAL is field_modifier {
	|optional
}

node ARRAY is field_modifier {
	|array
}

node unnamed_field is field {
	regex is regular_expression
}

node typed_field is field {
	modifier is field_modifier
	name is identifier
	type is type_spec
}

node enum is definition {
	|enum
	name is identifier
	optional type is type_spec
	|{
	array values is enum_value
	|}
}

node enum_value {
	name is identifier
	regex is regular_expression
}
