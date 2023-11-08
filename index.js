const fs = require('fs');
const path = require('path');
const OpenAI = require('openai');
const express = require('express');
const similarity = require('compute-cosine-similarity')

const app = express();
require('dotenv').config();
const apiKey = process.env.GPT_KEY;
// 40,000 TPM

const openai = new OpenAI({ apiKey });

app.get('/chat', async function (req, res) {
    const chat = await openai.chat.completions.create({
        messages: [{ role: 'user', content: '바이오바이츠라고 알아?' }],
        model: "gpt-3.5-turbo",
    });
    res.send(chat?.choices[0]?.message?.content);
});

app.get('/image', async function (req, res) {
    const image = await openai.images.generate({
        prompt: "The doctor with raining money on top of the building",
        n: 1, size: "256x256",
    });
    res.redirect(image.data[0]?.url);
});

app.get('/embedding', async function (req, res) {
    const input = ["속이 쓰려", "다리가 아프다", "가슴이 아프다", "속이 메스껍다"]
    const embedding = await openai.embeddings.create({
        model: "text-embedding-ada-002",
        input,
    });
    const resp = embedding.data.map(e => e.embedding);
    let html = `문장 유사도 테이블<br>`;
    html += `<table><tr><th></th>${input.map(e => `<th>${e}</th>`).join('')}</tr>`
    for await (let [i, x] of Object.entries(resp)) {
        html += `<tr><th>${input[i]}</th>`
        for await (let [j, y] of Object.entries(resp)) {
            const sim = Math.round(similarity(x, y) * 10000) / 100;
            html += `<td>${sim}</td>`
        }
        html += `</tr>`
    }
    html += `</table>`
    res.send(html);
})

app.listen(3000);