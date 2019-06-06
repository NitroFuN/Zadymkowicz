from utils import permissions
from discord.ext.commands import AutoShardedBot
import random
import requests
import datetime
import json
Muszla = ["Może", "Tak", "Prawdopodobnie", "Zainstaluj Oskara gówno w muszli klozetowej to się dowiesz", "Nie", "Nigdy", "Może w przyszłości", "Nie ma szans!", "Być może", "Wszystko jest możliwe!"]


class Bot(AutoShardedBot):
	def __init__(self, *args, prefix=None, **kwargs):
		super().__init__(*args, **kwargs)

	async def on_message(self, msg):
		if not self.is_ready() or msg.author.bot or not permissions.can_send(msg):
			return

		if msg.content.startswith('benc'):
			await msg.channel.send('pozdro', tts=True)

		if msg.content.startswith('dodasz pb'):
			await msg.channel.send('nie.', tts=True)

		if msg.content.startswith('streetwear'):
			await msg.channel.send('to pedalstwo', tts=True)

		if msg.content.startswith('dodasz <:pb:531200132566351893>'):
			await msg.channel.send('nie.', tts=True)

		if msg.content.startswith('siema siema'):
			await msg.channel.send('o tej porze kazdy wypic moze jakby nie bylo jest bardzo miło normalnie walimy to co mamy tak kminimy normalnie na lewo to nie zgrzewo jakby nie bylo jest bardzo milo zwolnij bo to jest jednokierunkowa panie pij od nowa dwa łyki byly dla filarty stylistyki tera pijemy pod wwa bo to jest artykul 202 nie eee spoko luzik bluzik facet z aparatem sobie normalnie jaja kmini jak by byla myszka miki se zdjął kolczyki normalnie kiedys byl zakuty normalnie w kajdany ale normalnie dowiedzial sie od mamy ze go rozkuli tacy byli mili ze go normalnie wypuscili jakby nie bylo bedzie bardzo milo <:siemasiema:437992184537415693>')

		if msg.content.startswith('Siema siema'):
			await msg.channel.send('o tej porze kazdy wypic moze jakby nie bylo jest bardzo miło normalnie walimy to co mamy tak kminimy normalnie na lewo to nie zgrzewo jakby nie bylo jest bardzo milo zwolnij bo to jest jednokierunkowa panie pij od nowa dwa łyki byly dla filarty stylistyki tera pijemy pod wwa bo to jest artykul 202 nie eee spoko luzik bluzik facet z aparatem sobie normalnie jaja kmini jak by byla myszka miki se zdjął kolczyki normalnie kiedys byl zakuty normalnie w kajdany ale normalnie dowiedzial sie od mamy ze go rozkuli tacy byli mili ze go normalnie wypuscili jakby nie bylo bedzie bardzo milo <:siemasiema:437992184537415693>')

		if msg.content.startswith('ddos'):
			text = '{0.author.mention}, chcesz ddos na 5gb z vpn 24/7?'.format(msg)
			await msg.channel.send(text, tts=True)

		if msg.content.startswith('Magiczna muszlo,'):
			text = random.choice(Muszla)
			dupa = '{0.author.mention}, '.format(msg) + text
			await msg.channel.send(f'{dupa}', tts=True)

		await self.process_commands(msg)
