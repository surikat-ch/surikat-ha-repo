#!/usr/bin/env python3
import json, sys

with open("/data/options.json") as f:
    options = json.load(f)

if options["network"] == "wifi":
    if not options["network_wifi_name"] or not options["network_wifi_pwd"]:
        print("Erreur : Configuration Wi-Fi incomplète !")
        sys.exit(1)
else:
    options["network_wifi_name"] = None
    options["network_wifi_user"] = None
    options["network_wifi_pwd"] = None

print("Options validées :", options)