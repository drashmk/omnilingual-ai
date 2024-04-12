# Omnilingual AI

Engage in natural conversations with AI, write and get responses in your language of choice.

## Getting Started

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

The CloudFlare worker is located in `omnilingual-ai` folder

## Local development

- go to `omnilingual-ai`
- run `npm install`
- run `npm run dev`

## Deploy on CloudFlare workers

- Install the [dependencies](https://developers.cloudflare.com/workers/get-started/guide/) on your computer
- change the `releaseUrl` in `lib/api/api_client.dart` to your url
- run `flutter build web -o omnilingual-ai/assets` to build the flutter application for web
- go to `omnilingual-ai`
- run `npm install`
- run `npm run deploy` to deploy it on CloudFlare