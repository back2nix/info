test:
	go test -v -race -count=1  ./...

test_malloc_show:
	go test -v -race -count=1 -gcflags=-m ./...

becnhmark_without_test:
	mkdir -p pprof
	go test -bench=Benchmark* -benchmem -benchtime=3s -run=^a \
		-cpuprofile=pprof/cpu.out \
		-memprofile=pprof/mem.out \
		-mutexprofile=pprof/mutex.out \
		-blockprofile=pprof/block.out \
		pkg/trie/*.go

# go tool cover -func=pprof/coverage.out
# go tool cover -html=pprof/coverage.out
cover:
	mkdir -p pprof
	go test -coverprofile=pprof/coverage.out ./...

BenchmarkAlloc:
	mkdir -p pprof
	go test -bench=BenchmarkAlloc -benchmem -benchtime=3s -run=^a \
		-cpuprofile=pprof/cpu.out \
		-memprofile=pprof/mem.out \
		-mutexprofile=pprof/mutex.out \
		-blockprofile=pprof/block.out \
		pkg/trie/*.go


benchmark:
	go test -bench=. -benchmem -benchtime=3s  ./...
	# go test -bench=. -benchmem -benchtime=3s -cpuprofile=cpu.out
	# go test -bench=. -benchmem -benchtime=5000000000x

cycle:
	go test -bench=. -benchmem -benchtime=3x

# Используем для сравнения разных запусков теста
# go run golang.org/x/perf/cmd/benchstat@latest new.txt old.tx
benchstat:
	go test -bench=Benchmark* -run=^a -count=10  | tee new.txt

profile:
	go tool pprof --http=:8080 pprof/cpu.out
	# go tool pprof --http=:8080 pprof/mem.out
	# go tool pprof --http=:8080 pprof/mutex.out
	# go tool pprof --http=:8080 pprof/block.out
	# (pprof) list func
	# (pprof) top
	# (pprof) web
	
# Ищем ошибки в коде
staticcheck:
	staticcheck ./...

# Авто выравнивание полей в структурах. Расставляет переменные в нужном порядке, 
# чтобы размеры структуры стал минимальным за счет выравнивая памяти
fieldalignment:
	fieldalignment -fix ./... 

all: test benchmark
