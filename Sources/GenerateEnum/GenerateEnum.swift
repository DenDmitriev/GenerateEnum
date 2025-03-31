@attached(member, names: named(init))
public macro GenerateEnum(base: Any, name: String) = #externalMacro(module: "GenerateEnumMacros", type: "GenerateEnumMacro")
