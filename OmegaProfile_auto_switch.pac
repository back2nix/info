var FindProxyForURL = function(init, profiles) {
    return function(url, host) {
        "use strict";
        var result = init, scheme = url.substr(0, url.indexOf(":"));
        do {
            result = profiles[result];
            if (typeof result === "function") result = result(url, host, scheme);
        } while (typeof result !== "string" || result.charCodeAt(0) === 43);
        return result;
    };
}("+auto switch", {
    "+auto switch": function(url, host, scheme) {
        "use strict";
        if (/(?:^|\.)imgilall\.me$/.test(host)) return "DIRECT";
        if (/(?:^|\.)gstatic\.com$/.test(host)) return "DIRECT";
        if (/openai\.com$/.test(host)) return "+proxy";
        if (/claude\.ai$/.test(host)) return "+proxy";
        if (/bard\.google\.com$/.test(host)) return "+proxy";
        if (/instagram\.com$/.test(host)) return "+proxy";
        if (/play\.google\.com$/.test(host)) return "+proxy";
        if (/torproject\.org$/.test(host)) return "+proxy";
        if (/facebook\.com$/.test(host)) return "+proxy";
        if (/twitter\.com$/.test(host)) return "+proxy";
        if (/dell\.com$/.test(host)) return "+proxy";
        if (/medium\.com$/.test(host)) return "+proxy";
        if (/pixabay\.com$/.test(host)) return "+proxy";
        if (/linkedin\.com$/.test(host)) return "+proxy";
        if (/remotive\.com$/.test(host)) return "+proxy";
        if (/ieee\.org$/.test(host)) return "+proxy";
        if (/azureedge\.net$/.test(host)) return "+proxy";
        if (/berkeley\.edu$/.test(host)) return "+proxy";
        if (/perplexity\.ai$/.test(host)) return "DIRECT";
        if (/patreon\.com$/.test(host)) return "+proxy";
        if (/webbrowsertools\.com$/.test(host)) return "+proxy";
        if (/microsoft\.com$/.test(host)) return "+proxy";
        if (/bing\.com$/.test(host)) return "+proxy";
        if (/live\.com$/.test(host)) return "+proxy";
        if (/flicksbar\.lol$/.test(host)) return "DIRECT";
        if (/fb\.com$/.test(host)) return "+proxy";
        if (/^2ip\.ru$/.test(host)) return "+proxy";
        if (/^play\.google\.com$/.test(host)) return "+proxy";
        if (/(?:^|\.)x\.ai$/.test(host)) return "+proxy";
        if (/oaistatic\.com$/.test(host)) return "+proxy";
        if (/^glazboga\.cc$/.test(host)) return "+proxy";
        if (/^gemini\.google\.com$/.test(host)) return "+proxy";
        if (/office\.net$/.test(host)) return "+proxy";
        if (/^gtmetrix\.com$/.test(host)) return "+proxy";
        if (/^coinmarketcap\.com$/.test(host)) return "+proxy";
        if (/^oaiusercontent\.com$/.test(host)) return "+proxy";
        if (/(?:^|\.)oaiusercontent\.com$/.test(host)) return "+proxy";
        if (/(?:^|\.)googleapis\.com$/.test(host)) return "+proxy";
        return "DIRECT";
    },
    "+proxy": function(url, host, scheme) {
        "use strict";
        if (/^127\.0\.0\.1$/.test(host) || /^::1$/.test(host) || /^localhost$/.test(host)) return "DIRECT";
        return "SOCKS5 192.168.100.3:1080; SOCKS 192.168.100.3:1080";
    }
});