This chart was created for self-hosting @rssnyder's discord-stock-ticker docker image on Kubernetes clusters
His repo can be found here https://github.com/rssnyder/discord-stock-ticker

**Chart tree**
├── Chart.yaml
├── README.md
├── charts
│   ├── sample-crypto
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   └── deployment.yaml
│   │   └── values.yaml
│   └── sample-stock
│       ├── Chart.yaml
│       ├── templates
│       │   └── deployment.yaml
│       └── values.yaml
├── templates
│   └── _deployment.tpl
└── values.yaml

Each ticker bot that you want to run will be a subchart.


**Instructions:**

I will be using `tsla` as the stock exaple and `bitcoin` as the crypto example in these instructions.

The `Chart.yaml` for the parent chart will need to have the dependencies updated to whatever tickers you will be using.
Change the placeholders of `sample-stock` and `sample-crypto` and add whatever tickers will be using like below. 
```
dependencies:
  - name: tsla
    version: 1.0.3
  - name: bitcoin
    version: 1.0.3
```
The version is the subchart's version that's in the subchart's `Chart.yaml`. I used the same versions for the parent chart as well as the subcharts for simplicity.

***NOTE:***

Use the same value across the following:
- the dependency in the parent `Chart.yaml`
- the subchart directory name
- the name in subchart's `Chart.yaml`
- the `STOCK_NAME` or `CRYPTO_NAME` in the subchart's `values.yaml`

The `values.yaml` for the parent chart contains all the environmental variables that will apply to every subchart. Edit to your preferences. Whenever @rssnyder updates his docker image the image tag will need to be updated here as well as the `appVersion` the parent `Chart.yaml`.

There are 2 sample subchart directories `sample-stock` and `sample-crypto`. Duplicate these directories as many times as you need and name them according to the tickers you will be running.

The `Chart.yaml` for each subchart will also need to be updated like below
```
apiVersion: v2
name: tsla
description: tsla tickerbot
version: 1.0.3
```

The `values.yaml` for each subchart is where you'll put the tickers specific variables like below
```
env:
  DISCORD_BOT_TOKEN: "ABCDEF0123456789"
  STOCK_NAME: "tsla"
  TICKER: "TSLA"
```
-or-
```
env:
  DISCORD_BOT_TOKEN: "ABCDEF0123456789"
  CRYPTO_NAME: "bitcoin"
  TICKER: "BTC"
