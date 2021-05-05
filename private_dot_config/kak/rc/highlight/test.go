package main

func Func1(foo, bar string)          {}
func Func2(foo bool, bar *Type) bool { return true }
func Func3() (bool, int, []Entry)    {}
func Func3() (_ bool, err error)     {}

func main() {
	var foo = "foo %s bar\n"
	var foo = `foo %s bar\n`

	var foo = 'foo'
	var foo = 'f'

	var foo = bar(10, 20)

	var foo = bar[10]
	var foo = bar[baz + 10]

	var foo, bar string
	var foo string
	var foo Custom
	var foo []Custom
	var foo *Custom
	var foo bool = true
	var foo Custom = Custom{}
	var
	var foo map[string]bool
	var foo map[string]Custom
	var foo map[Custom]Custom
	foo, bar := 10, 20
	foo := true

	// integer
	var _ = 42
	var _ = 4_2
	var _ = 0600
	var _ = 0_600
	var _ = 0o600
	var _ = 0o600
	var _ = 0xBadFace
	var _ = 0xBad_Face
	var _ = 0x_67_7a_2f_cc_40_c6
	var _ = 170141183460469231731687303715884105727
	var _ = 170_141183_460469_231731_687303_715884_105727

	// float
	var _ = 0.
	var _ = 72.40
	var _ = 072.40
	var _ = 2.71828
	var _ = 1.e+0
	var _ = 6.67428e-11
	var _ = 1e6
	var _ = .25
	var _ = .12345e+5
	var _ = 1_5.
	var _ = 0.15e+0_2
	var _ = 0x1p-2
	var _ = 0x2.p10
	var _ = 0x1.Fp+0
	var _ = 0x.8p-0
	var _ = 0x_1FFFp-16

	// imaginary
	var _ = 0i
	var _ = 123i
	var _ = 0o123i
	var _ = 0xabci
	var _ = 0.i
	var _ = 2.71828i
	var _ = 1.e+0i
	var _ = 6.67428e-11i
	var _ = 1e6i
	var _ = .25i
	var _ = .12345e+5i
	var _ = 0x1p-2i
}
