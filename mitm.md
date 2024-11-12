nix-shell -p mitmproxy --run "mitmproxy --mode upstream:http://127.0.0.1:18081 -p 1080"
nix-shell -p mitmproxy --run "mitmproxy --rfile ./save.flow -n"
