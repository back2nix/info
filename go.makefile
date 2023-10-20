test:
	go test -v -race -count=1  ./...

becnhmark_without_test:
	go test -bench=Benchmark* -benchmem -benchtime=3s -run=^a -cpuprofile=cpu -memprofile=mem pkg/trie2/*.go

BenchmarkAlloc:
	go test -bench=BenchmarkAlloc -benchmem -benchtime=3s -run=^a \
		-cpuprofile=cpu.out \
		-memprofile=mem.out \
		-mutexprofile=mutex.out \
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
	go tool pprof --http=:8080 cpu.out
	# go tool pprof --http=:8080 mem.out
	# go tool pprof --http=:8080 mutex.out
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
