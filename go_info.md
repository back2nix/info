### каталог библиотек для golang
- https://github.com/avelino/awesome-go#audio-and-music

- компилировать библиотеку для линковки с С/C++
```bash
go build -o lib.so -buildmode=c-archive lib.go
```
- скомпилировать либу для Visual studio
```bash
cd C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64
lib.exe /def:lib.def /OUT:lib.lib /MACHINE:x64
```

```
[lib.def]
EXPORTS
MyFunction
```

### cross compile ubuntu for windows

```bash
CC=i686-w64-mingw32-gcc GOOS=windows GOARCH=386 CGO_ENABLED=1 go build -o golib.lib -buildmode=c-shared golib.go
```

```go
switch item {
    case 1:
        fallthrough // Позволяет провалиться в следующий case
    case 2:
        ...
    default:
        ...
}
```

### Передать русский текст в C++

```cpp
cStr = C.CString("Привет")
ret, _, _ = Speak.Call(uintptr(unsafe.Pointer(cStr)))
C.free(unsafe.Pointer(cStr))
```

### golang arm compile
### Установить из бинарника

- gvm install go1.13.3 -B

```bash
cd $(go env GOROOT)/src
export CC="gcc -Wimplicit-fallthrough=0 -Wno-error=shift-negative-value -Wno-shift-negative-value" && CGO_ENABLED=0 gvm install go1.13.3
gvm list
gvm use go1.13.3
sudo GOROOT_BOOTSTRAP=/home/user/.gvm/gos/go1.13.3 GOOS=linux GOARCH=arm CGO_ENABLED=0 ./make.bash --no-clean
```

### Компиляци приложения приложение под arm

```bash
GOOS=linux GOARCH=arm go build check_port.go

go mod init
go mod edit -replace github.com/REPO_DEPRECATED/helloworld=../helloworld
```

### go 1.12
-  https://gophp.io/how-to-install-go-1-12-on-ubuntu-18/

```bash
golang уже предварительно установлен на машине. Для примера возьмем go version 1.13.3 но можно взять другую

Установить gwm
Инструкция взята отсюда https://github.com/moovweb/gvm

source ~/.gvm/scripts/gvm
source /home/user/.gvm/scripts/gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
Соберем toolchain для crosscompile
cd $(go env GOROOT)/src
export CC="gcc -Wimplicit-fallthrough=0 -Wno-error=shift-negative-value -Wno-shift-negative-value" && CGO_ENABLED=0 gvm install go1.13.4
gvm list
gvm use go1.13.4
sudo GOROOT_BOOTSTRAP=/home/user/.gvm/gos/go1.13.4 GOOS=linux GOARCH=arm CGO_ENABLED=0 ./make.bash --no-clean
Команда для компиляции
GOOS=linux GOARCH=arm go build check_port.go
Добавить сервис:

cp my_ssh_remote.service /etc/systemd/system/my_ssh_remote.service
sudo systemctl daemon-reload
sudo systemctl enable my_ssh_remote
sudo systemctl start my_ssh_remote
Подключится к ubuntu aws
ssh -i id_rsa ubuntu@$host
```

- https://insomnia.rest/

### gdb for golang 

- https://github.com/derekparker/delve
- https://github.com/sebdah/vim-delve


- bug arm
- type Payload struct
- /home/user/go/pkg/mod/github.com/googollee/go-engine.io@v1.4.3-0.20200220091802-9b2ab104b298/payload/payload.go
- https://github.com/googollee/go-socket.io/issues/236
- https://github.com/googollee/go-engine.io/pull/86/commits/3d906e43a03fd355d6f60c6ce103acf7cafd0159#diff-fff052930dc3dc5b0639def327826223

- logrotate logrus
- https://github.com/natefinch/lumberjack

- live download updater terminal
- https://github.com/gosuri/uilive

- скрывать окна golang
- https://github.com/inconshreveable/go-update/blob/master/hide_windows.go

- go update
- https://github.com/inconshreveable/go-update/blob/master/doc.go
- go update from github
- github.com/rhysd/go-github-selfupdate/selfupdate

- Установка lint
- https://golangci-lint.run/usage/install/
```bash
golangci-lint --version
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.27.
```

- golang lint chech error
- https://www.youtube.com/watch?v=VlnxsfSs1ms
- https://golangci-lint.run/
```bash
go get -u github.com/golangci/golangci-lint
golangci-lint run --fix
golangci-lint run --fix --enable-all
golangci-lint run --fix --enable-all  -new
```

- change const in golang from build -ldflags
```bash
go build -ldflags='-X main.version="$TAG"' -o hello-updater src/hello-updater/main.go
```

- profile go https://www.youtube.com/watch?v=a8oEETIRpCk
```bash
import _ "net/http/pprof"
go tool pprof -seconds 5 http://server/debug/pprof/profile
go tool pprof -seconds 5 http://server/debug/pprof/heap
```

- profile line by line
- https://go.dev/blog/pprof

```bash
go tool profile prog.pprof mprog.mprof
list dfs
```

- уменьшить размер бинарника upx
```
upx new last
bincmp -no-symtab old new
```

- sudo: furious: command not found
```bash
sudo env "PATH=$PATH" furious
```

### gogrep
- https://github.com/mvdan/gogrep
```bash
gogrep -r -x 'if $x != nil { $*_ }' cmd/apiserver/main.go
 find -name '*.go' -exec gogrep -x 'if $x != nil { $*_ }' {} \;
gogrep -x '$b.($x)' ./...
gogrep -x 'if $x := $_.Create($_).Error; $x != nil { $*_ }' ./...

go test -cpuprofile=cpu.out
go tool pprof cpu.out
>>> web
```

- https://flaviocopes.com/golang-profiling/

- go auto test https://github.com/cweill/gotests
```bash
go get -u github.com/cweill/gotests/...
```

- gui golang gio https://gioui.org/

- memory leak
- https://unix.stackexchange.com/questions/36450/how-can-i-find-a-memory-leak-of-a-running-process

- memory leak prifle
```go
import(
	"net/http"
	_ "net/http/pprof"
)

func main() {
	go func() {
        runtime.LockOSThread()
		log.Fatal(http.ListenAndServe(":8080", nil))
	}()
}
```

- cpu profile cheatsheat
- https://gist.github.com/slok/33dad1d0d0bae07977e6d32bcc010188

```bash
go tool pprof -seconds 5 http://localhost:8080/debug/pprof/profile

go tool pprof -seconds 5 http://localhost:8080/debug/pprof/heap

curl http://localhost:8080/debug/pprof/heap > heap.0.pprof
curl http://localhost:8080/debug/pprof/cpu > cpu.0.pprof
curl http://localhost:8080/debug/pprof/trace > trace.0.pprof
go tool pprof heap.0.pprof
HEAP=heap.7.pprof && curl http://localhost:8080/debug/pprof/heap > $HEAP && go tool pprof -nodefraction=0 -inuse_objects $HEAP

go tool pprof -nodefraction=0 -inuse_objects http://localhost:8080/debug/pprof/heap 
nodefraction=0

web
list Track
top20

sudo apt-get install bpfcc-tools
sudo memleak-bpfcc -p 25635

go build -gcflags=-m main.go

wget -O trace.out http://localhost:8080/debug/pprof/trace
go tool trace trace.out
```

```go

import "github.com/pkg/profile" // v1.5.0

func main() {
	defer profile.Start(profile.MemProfileRate(2048), profile.ProfilePath("./profiling"), profile.NoShutdownHook).Stop()
}
```

- go robot https://gobot.io/

- https://habr.com/ru/post/337098/
Создатель Node.js: «Для серверов я не могу представить другой язык кроме Go»

- вывести структуру go красиво в консоль
```go
spew.Dump(outRes)
```

```bash
go build -o main main.go && LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc.so.4 HEAPCHECK=normal HEAPPROFILE=gpt-heapprofile.log ./main
```
- https://dashboard.stackimpact.com/#/hotspots/memory
- https://www.instana.com/docs/profiling/

### 50 подводных камней
- http://devs.cloudimmunity.com/gotchas-and-common-mistakes-in-go-golang/?ref=hackernoon.com

### stack trace info
- https://www.ardanlabs.com/blog/2015/01/stack-traces-in-go.html

```bash
go tool pprof "http://localhost:8081/debug/pprof/profile?seconds=10"
```

- cgo траблы
- https://www.youtube.com/watch?v=bdx8W_gxS3E

### vegete
- https://www.youtube.com/watch?v=TVe8pIFn2mY

### оптимизации
- https://www.youtube.com/watch?v=DvkArdKQjBI

### linter revgrep orig/master
- https://www.youtube.com/watch?v=VlnxsfSs1ms
```bash
glonagci-lint run --new-from-rev=orign/master

go get golang.org/x/tools/gopls@latest
```
- staticcheck
- https://github.com/dominikh/go-tools

### линтер делает ревью в pull request
- reviewdog

### ~/.bashrc
```bash
export GO111MODULE=on
export GOPROXY=direct
export GOSUMDB=off

#И выполнить команду
git config --global url."ssh://git@github.com".insteadOf "https://github.com"
```

### Установить экспеременатальную go
https://golang.org/doc/install/source

```bash
git clone https://go.googlesource.com/go goroot
cd goroot
git checkout go1.16beta1
#./make.bash  177,56s user 39,59s system 591% cpu 36,681 total
```

### performance go
- https://dave.cheney.net/high-performance-go

- ERROR: /lib64/libc.so.6: version `GLIBC_2.32' not found (required by ./server)
### fix
```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server *.go"
```

### docker build kit
- https://www.docker.com/blog/containerize-your-go-developer-environment-part-1/


### WrapPanic stack trace
- https://stackoverflow.com/questions/52103182/how-to-get-the-stacktrace-of-a-panic-and-store-as-a-variable
```bash
defer func() {
if err := recover(); err != nil {
logrus.WithFields(logrus.Fields{
"err":   err,
"debug": string(debug.Stack()),
}).Fatal("panic")
}
}()
```

### WrapPanic stack trace
```bash
exitStatus, err := panicwrap.BasicWrap(panicHandler)
if err != nil {
    logrus.Fatalf("%v\n", err)
}
logrus.WithFields(logrus.Fields{
    "exitStatus": exitStatus,
}).Warn("exitStatus")
if exitStatus >= 0 {
    os.Exit(exitStatus)
}
```

### fix
go mod vendor

```bash
godef: err: exit status 1: stderr: go: inconsistent vendoring in
```

### python golang
https://www.ardanlabs.com/blog/2020/08/packaging-python-code.html
### duration

```
start := time.Now()
end := time.Now()
duration := end.Sub(start)
fmt.Printf("t: %v \n", duration)
```

```
func Stream() {
	stream := mjpeg.Handler{
		Next: func() (img image.Image, err error) {
			select {
			case img = <-chanMjpeg:
			default:
			}
			return img, nil
		},
		Options: &jpeg.Options{Quality: 80},
	}

	mux := http.NewServeMux()
	mux.Handle("/stream", stream)
	fmt.Println("http://locahost:8080/stream")
	log.Fatal(http.ListenAndServe(":8080", mux))
}
```

### Cross platform gui

- https://www.youtube.com/watch?v=4qiHYE81nIE
- https://gioui.org/doc/contribute
- gioui.org
- https://github.com/pierrec/games/tree/main/blocks/internal/ui
- https://github.com/vsariola/sointu
- https://www.youtube.com/watch?v=qVNucOG6gqM
- https://github.com/google/swiftshader
- https://www.youtube.com/watch?v=HC4Cg78l-9U
- git clone https://git.sr.ht/~ghost08/photon
- git clone https://git.sr.ht/~gioverse/chat
- git clone https://git.sr.ht/~eliasnaur/gio-example gio-example_v2
- git clone https://github.com/egonelbre/expgio.git
- git clone https://github.com/ajstarks/giocanvas.git
- git clone https://github.com/theclapp/gio-mirror ????

Видео по gio
- https://www.youtube.com/watch?v=faySIH26NCs

### GUI fyne
- https://github.com/fyne-io/fyne
- https://apps.fyne.io/all
- https://github.com/fyne-io/examples/

##### gif

```
convert original.gif -coalesce unoptimized.gif
```

- http://tech.nitoyon.com/en/blog/2016/01/07/go-animated-gif-gen/
- https://github.com/srinathh/goanigiffy
### Authentication

- https://www.ory.sh/kratos/docs/quickstart

### Run test

```
go clean -testcache
go test --race ./cmd/testing_runner/main_test.go -run "^TestRunner" -v
```

### 

```
echo 0 > /proc/sys/kernel/yama/ptrace_scope
```

### Go gio arm64
sudo apt install -y libvulkan-dev libxkbcommon-x11-dev

### go generic

- https://go.dev/doc/tutorial/generics

### golang dev

- build tag, go:build constraint
- https://pkg.go.dev/cmd/go#hdr-Build_constraints

### list gorelase users

- https://goreleaser.com/users/

- https://github.com/fastly/cli/blob/main/.goreleaser.yml
- https://github.com/compose-generator/compose-generator/blob/main/.goreleaser.yml
- https://github.com/fleetdm/fleet/blob/main/.goreleaser.yml
- https://github.com/GitGuardian/src-fingerprint/blob/main/.goreleaser.yml
- https://github.com/gohugoio/hugo/blob/master/goreleaser.yml
- https://github.com/planetscale/cli/blob/main/.goreleaser.yml
- https://github.com/pulumi/pulumi/blob/master/.goreleaser.yml
- https://github.com/prest/prest/blob/main/.goreleaser.yml
- https://github.com/sigstore/fulcio/blob/main/.goreleaser.yml
- https://github.com/sigstore/cosign/blob/main/.goreleaser.yml



### timer

```bash
go run github.com/antonmedv/countdown@latest 25m
```

### golang debuuger nvim

- https://www.youtube.com/watch?v=RziPWdTzSV8&ab_channel=DevOpsToolbox

### nvim plugin glonag multi combain

- https://github.com/ray-x/go.nvim

### tips tricks
- https://joshrendek.com/2015/09/golang-performance-tips/
- DANGER performace mutex
- https://texlution.com/post/golang-lock-free-values-with-atomic-value/
- https://hashrocket.com/blog/posts/go-performance-observations
```go
# bed performance
n, err := strconv.ParseInt(s, 10, 32)
# good performance
binary.BigEndian.PutUint32(buf, 12345678)
```
- https://studygolang.com/articles/1794
```go
for k, v := range m {
	// k, v := k, v   // copy for capturing by the goroutine
   	x := struct{ k, v string }{k, v}   // copy for capturing by the goroutine
   go func() {
      // use x.k and x.v
   }()
}
```
- https://studygolang.com/articles/1794
```bash
go test --blockprofile=block.out
# net/http/pprof via http://myserver:6060:/debug/pprof/block or by callingruntime/pprof.Lookup("block").WriteTo.
#runtime.SetBlockProfileRate(1)
go tool pprof -http=:8080 block.out # --ignore
```
- 

### ?

- https://www.youtube.com/watch?v=ptCNC9lrg8U&ab_channel=iSpringTech
```bash
go list -f '{{ .XTestGoFiles }}' strings
go run github.com/quasilyte/gogrep/cmd/gogrep@latest main.go 'if _, ok := $_; !ok { $_ }'
```

- https://www.youtube.com/watch?v=kClQ7rM5uBY&ab_channel=FIXGroupofCompanies
```bash
- escaped heap
go tool compile -m main.go
go build -gcflags="-m=2"
```

```go
bytes.Index(hashstack, []byte(needle)) // бесплатно если needle < 32 byte

concatLen(x, y string) int {
	result := x + y // тоже бесплатно если < 32 байт
	return len(result) 
}
```

- https://www.youtube.com/watch?v=tmrqqk0q22g&ab_channel=FIXGroupofCompanies
- bench
```go
go test -bench=Benchmark* -benchmem -benchtime=3s -run=^a -cpuprofile=cpu -memprofile=mem
go tool pprof -alloc_space mem
go tool pprof -alloc_objects mem
go tool pprof cpu
```

- bech stat
```go
go test -bench=Benchmark* -run=^a -count=10  | tee old.txt
go test -bench=Benchmark* -run=^a -count=10  | tee new.txt

go run golang.org/x/perf/cmd/benchstat@latest new.txt old.tx
```

- wrk becnhmark http
- https://github.com/wg/wrk

```bash
curl http://localhost:8080/startProfile
wrk "$@"
curl http://localhost:8080/stopProfile
```

```bash
go test -bench=Benchmark* -benchmem -benchtime=3s -run=^a -cpuprofile=cpu.out -memprofile=mem.out -mutexprofile=mutex.out -blockprofile=block.out pkg/trie2/*.go

go tool pprof -http=:8080 cpu.out
go tool pprof -http=:8080 mem.out
go tool pprof -http=:8080 mutex.out
go tool pprof -http=:8080 block.out # --ignore

go tool pprof <test.binary> -http=:8080 ?.out
```

- no inline for becnhmark

```go
//go:noinline
func foo() {
	return
}
```

- gorutine trace

```bash
go tool trace ...
```

- go leak 
- https://github.com/uber-go/goleak

- staticcheck
- https://github.com/dominikh/go-tools
- go-tools
```bash
staticcheck ./...
```

- https://github.com/cweill/gotests
- https://github.com/golang/go/wiki/TableDrivenTests

- protobuf best performace lib
- https://github.com/gogo/protobuf

- https://betterprogramming.pub/6-ways-to-boost-the-performance-of-your-go-applications-5382bb7532d7
- byte -> string
```go
// For Go 1.20 and higher
func StringToBytes(s string) []byte {
 return unsafe.Slice(unsafe.StringData(s), len(s))
}

func BytesToString(b []byte) string {
 return unsafe.String(unsafe.SliceData(b), len(b))
}
```

- best json
- import jsoniter "github.com/json-iterator/go"

- memset
- https://stackoverflow.com/questions/30614165/is-there-analog-of-memset-in-go
- https://github.com/tmthrgd/go-memset

```go
func memsetRepeat(a []int, v int) {
    if len(a) == 0 {
        return
    }
    a[0] = v
    for bp := 1; bp < len(a); bp *= 2 {
        copy(a[bp:], a[:bp])
    }
}
```

