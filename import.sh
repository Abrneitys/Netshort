USE_MULTITAIL=false

SPEED=--release
if [ "$1" == "--dev" ]; then
	shift
	SPEED=
fi

if ! command -v multitail &> /dev/null; then
	USE_MULTITAIL=false
fi

if $USE_MULTITAIL; then
	RUST_BACKTRACE=1 RUST_LOG_STYLE=always cargo run --bin cli $SPEED --features importer/scenarios -- import $@ > /tmp/abst_stdout 2> /tmp/abst_stderr &
	multitail /tmp/abst_stdout -cT ANSI /tmp/abst_stderr
else
	RUST_BACKTRACE=1 cargo run --bin cli $SPEED --features importer/scenarios -- import $@
fi
