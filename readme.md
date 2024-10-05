# LavinMQ Hackthon Week

This repository contains the code for the LavinMQ Hackathon Week. I was trying LavinMQ for the first time and I wanted to try something fun, so I decided to participate in the hackathon week.

## Usage

Crawl and get all links from a given page. These links are published to a queue on LavinMQ.

```bash
crystal craw-page.cr "https://crystal-lang.org/"
```

Consume links from the queue and search for a pattern in the page.

```bash
crystal consumer.cr "Crystal"
```

## Installation

You need to have Crystal and Shards installed. And also install the dependencies:

```bash
shards install
```

- amqp-client: AMQP client for Crystal
- dotenv: Loads environment variables from a .env file

## Author

Tulio Faria (tuliofaria at gmail.com)

- [Website](https://tuliofaria.dev/)
- [LinkedIn](https://www.linkedin.com/in/tuliofaria/)
- [Github](https://github.com/tuliofaria)
- [Twitter](https://twitter.com/tuliofaria)
