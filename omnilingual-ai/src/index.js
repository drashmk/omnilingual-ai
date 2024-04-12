import { Ai } from '@cloudflare/ai';
import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { serveStatic } from 'hono/cloudflare-workers'
import manifest from '__STATIC_CONTENT_MANIFEST'

const app = new Hono();
app.use('/api/*', cors());
app.post('/api/chat', async (c) => {
	const payload = await c.req.json();
	const ai = new Ai(c.env.AI);
	const userLanguage = payload.config.userLanguage;
	const aiLanguage = payload.config.aiLanguage;
	let messages = [...payload.messages];
	let translatedUserResponse;
	if (payload?.config?.systemMessage) {
		messages.unshift({ role: 'system', content: payload.config.systemMessage });
	}
	if (userLanguage !== 'en') {
		const lastMessage = messages.pop();
		translatedUserResponse = await ai.run('@cf/meta/m2m100-1.2b', {
			text: lastMessage.content,
			source_lang: userLanguage, // defaults to english
			target_lang: 'en'
		});
		lastMessage.content = translatedUserResponse.translated_text;
		messages.push(lastMessage);
	}

	const originalResponse = await ai.run(payload.config.model, { messages });

	const translatedResponse = await ai.run('@cf/meta/m2m100-1.2b', {
		text: originalResponse.response,
		source_lang: 'en', // defaults to english
		target_lang: aiLanguage
	});
	const response = {
		'ai_message': originalResponse.response,
		'translated': translatedResponse.translated_text,
		'translated_request': translatedUserResponse ? translatedUserResponse.translated_text : '',
		'user_language': userLanguage,
		'ai_language': aiLanguage
	};
	return c.json(response);
});

app.get('/*', serveStatic({ root: './', manifest }))
app.get('/favicon.ico', serveStatic({ path: './favicon.ico' }))

export default app;
