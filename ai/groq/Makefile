deps:
	poetry lock
	poetry install --no-root
	
run/groq:
	python3 main.py

run/gemini:
	python3 gemini.py

proxychains4:
	proxychains4 python3 main.py

proxy:
	export HTTP_PROXY="socks5://localhost:8080"
	export HTTPS_PROXY="socks5://localhost:8080"
	export ALL_PROXY="socks5://localhost:8080"
	python3 main.py
