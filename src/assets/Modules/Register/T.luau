export type registerImpl = {
	__index: registerImpl,
	Test: {
		new: () -> registerImpl,
		__call: (test: any) -> registerImpl,
	},
	create: (Name: string, Type: string) -> registerImpl,
	register: () -> (),
	refactor: (registerImpl) -> {
		Type: Type
	},
	Name: string,
	Registor: any,
	Type: any,
}

export type testImpl = {
	new: () -> registerImpl,
	__call: (test: any) -> registerImpl,
}

type T_add = ( Paramater: string, Value: string | number | CFrame | Vector2 | Vector3 ) -> {["add"]: T_add, ["Register"]: Register}
type R_add = ( FunctionName: string, Function: FunctionalTest ) -> {["add"]: R_add}
type Register = () -> {["add"]: R_add}
type Type = () -> {["add"]: T_add, ["Register"]: Register}


type register = typeof(setmetatable({} :: { }, {} :: registerImpl))

export type test = typeof(setmetatable({} :: {
	new: () -> registerImpl,
	__call: (test: any) -> registerImpl,
}, {} :: testImpl))

return {}