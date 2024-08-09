export type registerImpl = {
	__index: registerImpl,
	Test: {
		new: () -> registerImpl,
		__call: (test: any) -> registerImpl,
	},
	create: (Name: string, Type: string) -> registerImpl,
	register: () -> (),
	refactor: () -> {
		Register_add: () -> { add: () -> registerImpl },
		Type_add: () -> { add: () -> registerImpl, Register: () -> registerImpl },
		Type: () -> registerImpl,
		Register: () -> registerImpl,
	},
	Name: string,
	Registor: any,
	Type: any,
}

export type testImpl = {
	new: () -> registerImpl,
	__call: (test: any) -> registerImpl,
}

type register = typeof(setmetatable({} :: {
	refactor: () -> {
		Type: () -> (),
	}
}, {} :: registerImpl))

export type test = typeof(setmetatable({} :: {
	new: () -> registerImpl,
	__call: (test: any) -> registerImpl,
}, {} :: testImpl))

return {}
