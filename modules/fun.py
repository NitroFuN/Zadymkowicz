import random
import discord
import json
import secrets

from io import BytesIO
from discord.ext import commands
from utils import permissions, http, default
from bs4 import BeautifulSoup
import requests
import wikipedia
import os

barka = "\nPan kiedyś stanął nad brzegiem\nSzukał ludzi gotowych pójść za Nim\nBy łowić serca\nSłów Bożych prawdą.\n\nRef.:\nO Panie, to Ty na mnie spojrzałeś,\nTwoje usta dziś wyrzekły me imię.\nSwoją barkę pozostawiam na brzegu,\nRazem z Tobą nowy zacznę dziś łów.\n\n2.\nJestem ubogim człowiekiem,\nMoim skarbem są ręce gotowe\nDo pracy z Tobą\nI czyste serce.\n\n3.\nTy, potrzebujesz mych dłoni,\nMego serca młodego zapałem\nMych kropli potu\nI samotności.\n\n4.\nDziś wypłyniemy już razem\nŁowić serca na morzach dusz ludzkich\nTwej prawdy siecią\nI słowem życia."
pseudol_1 = ["Polski", "Fun", "Full", "Extra", "Server", "Ibiza", "Party", "Polska", "Rozrywki", "Elita", "Impreza", "Premium", "Critical", "Diamond"]
pseudol_2 = ["Polski", "Fun", "Extra", "Full", "Server", "Ibiza", "Party", "Polska", "Rozrywki", "Wszystkiego", "Elita", "Elite", "Impreza", "Deluxe", "Zajebistości", "Premium", "Gold", "Zadyma", "Ziomals", "Freeroam", "Mega", "Critical", "Diamond"]
pseudol_3 = ["Polski", "Fun", "Extra", "Server", "Ibiza", "Party", "Polska", "Rozrywki", "Wszystkiego", "Elita", "Impreza", "Imprezy", "Zajebistości", "Elite", "Deluxe", "Premium", "Zadymki", "Spierdolenia", "Zabawy", "International", "Diamond"]
movies = ['kHEC34cuwFs', '8QPTfAd6HRs', 'O29-Glc-aWQ', 'rMRAG300p5c', 'tk1koL5Vojc', 'DE1dO_RZDSs', '9sfv6c0DKPo', 'GE2-iWgaoa8', 'KxLtLpWym-s', 'Y-fCgZXcIgs', 'p1D0v9G4ywM', 'HHXxZrrUz7w', '3U4F3k_Tc34', 'DKTCtMgFhSY', 'hGjwhs0V4Ko', 'EfYT8P54BG0', 'ufQo9RpkSnU', 's_4flQrmNFY', 'eYdWNw6l5r8', 'TDn5Zy5Qgxc', 'fgLkWtL0zkg', '-tRVuU1YWJs', 'BrroYxOZEL4', 'gr4Zzd5CERg', 'W_0H1C_nYW8', 'GpKHMkk77IM', 'FKU6BxdoKq4', 'AU_ObRC42Jc', 'x_fu_tYHW-0', '390cv3_cPQU', '6piK-wvrMOk', '8WLcvzLAGQI', '1x3OSr8Bps0', 'UTOqdscQTFM', 'J-13P2z-N-M']

class Zabawy(commands.Cog, name="Zabawne"):
	def __init__(self, bot):
		wikipedia.set_lang("pl")
		self.bot = bot
		self.config = default.get("config.json")

	async def randomimageapi(self, ctx, url, endpoint):
		try:
			r = await http.get(url, res_method="json", no_cache=True)
		except json.JSONDecodeError:
			return await ctx.send(":x: | Błąd połączenia z API :(")

		await ctx.send(r[endpoint])

	@commands.command()
	async def losujpseudola(self, ctx):
		""" Generator pseudoli samp """
		wypierdalaj = "Wygenerowana nazwa serwera: " + random.choice(pseudol_1) + ' ' + random.choice(pseudol_2) + ' ' + random.choice(pseudol_3)
		await ctx.send(wypierdalaj, tts=True)
		
	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def barka(self, ctx):
		""" OOO PAAAANIE TOOO TY NA MNIE SPOJRZAAAAŁEŚŚŚŚŚ """
		await ctx.send(barka, tts=True)

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def kot(self, ctx):
		""" Wysyła losowe zdjęcie kotka """
		await ctx.send(f'nwm jakiś fajny kotek z neta')
		await self.randomimageapi(ctx, 'http://aws.random.cat/meow', 'file')

	@commands.command()
	async def losowalinijkazgs(self, ctx):
		""" Pokazuje losową linijkę z GMa GS v1.3.3 """
		random_lines = random.choice(open("Project_GS.pwn", 'r', encoding='utf-8', errors="surrogateescape").readlines())
		await ctx.send(f"```cpp\n{random_lines}```", tts=True)
		
	@commands.command()
	async def szkaluje(self, ctx, *, kogo: str):
		""" Szkaluje """
		random_lines = random.choice(open("szkaluje.txt", 'r', encoding='utf-8', errors="surrogateescape").readlines())
		if ("@everyone" in kogo):
			return await ctx.send(f"{ctx.author.mention} {random_lines}", tts=True)
			
		if ("@here" in kogo):
			return await ctx.send(f"{ctx.author.mention} {random_lines}", tts=True)

		await ctx.send(f"{kogo} {random_lines}", tts=True)

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def pandka(self, ctx):
		""" Wysyła losowe zdjęcie pandki czerwonej """
		await ctx.send(f'nwm jakaś fajna pandka czerwona z neta')
		await self.randomimageapi(ctx, 'https://some-random-api.ml/redpandaimg', 'link')
		
	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def lisek(self, ctx):
		""" Wysyła losowe zdjęcie liska """
		await ctx.send(f'nwm jakiś fajny lisek z neta')
		await self.randomimageapi(ctx, 'https://some-random-api.ml/foximg', 'link')

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def tekst(self, ctx, *, text: str):
		""" Wyszukuje tekst piosenek """
		r = requests.get("https://some-random-api.ml/lyrics?title=" + text)
		title = r.json()['title']
		tekst = r.json()['lyrics']
		znaki = len(tekst)
		chuj = 'Znaki: ' + str(znaki)
		if len(tekst) > 2000:
			await ctx.send(title)
			await ctx.send(f':x: | Przekroczzono limit maksymalnych znaków w wiadomości.')
			await ctx.send(chuj)
		else:
			await ctx.send(title)
			await ctx.send(tekst)
			await ctx.send(chuj)

	@commands.command()	
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def kot2(self, ctx):
		""" Wysyła losowe zdjęcie kotka z innego API """
		await ctx.send(f'nwm jakiś fajny kotek z neta')
		await self.randomimageapi(ctx, 'https://nekos.life/api/v2/img/meow', 'url')

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def pies(self, ctx):
		""" Wysyła losowe zdjęcie pieska """
		await ctx.send(f'nwm jakiś fajny piesek z neta')
		await self.randomimageapi(ctx, 'https://random.dog/woof.json', 'url')

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def ptaszek(self, ctx):
		""" Wysyła losowe zdjęcie ptaszka """
		await ctx.send(f'nwm jakiś fajny ptaszek z neta')
		await self.randomimageapi(ctx, 'https://some-random-api.ml/birbimg', 'link')

	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def kaczka(self, ctx):
		""" Wysyła losowe zdjęcie kaczki """
		await ctx.send(f'nwm jakaś fajna kaczka z neta')
		await self.randomimageapi(ctx, 'https://random-d.uk/api/v1/random', 'url')
		
	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def miejski(self, ctx, *, text: str):
		""" Pobiera slang ze strony miejski.pl """
		text = text.replace(" ", "+")
		response = requests.get("https://www.miejski.pl/slowo-" + text)
		if response.status_code == 404:
			await ctx.send(f':x: | Nie znaleziono takiego słowa')
		else:
			parsed = BeautifulSoup(response.text, "html.parser")
			title = parsed.body.find("h1").get_text()
			definition = parsed.find("div", "definition summary").get_text()
			example = parsed.find("div", "example").get_text()
			if ("@" in title):
				title = "No chyba se kurwa żartujesz"
				
			if ("@" in definition):
				definition = "No chyba se kurwa żartujesz"
				
			if ("@" in example):
				example = "No chyba se kurwa żartujesz"
				
			if ("PMS" in text):
				title = "PMS\n"
				definition = "Polski Mega Serwer - jeden z najlepszych serwerów DM na SA:MP'ie. \n"
				example = ""
				
			if ("pms" in text):
				title = "PMS\n"
				definition = "Polski Mega Serwer - jeden z najlepszych serwerów DM na SA:MP'ie. \n"
				example = ""
				
			message = title + "\n" + definition + "\n"+example+""
			await ctx.send(message, tts=True)
			
	@commands.command()
	@commands.cooldown(rate=3, per=10, type=commands.BucketType.user)
	async def wiki(self, ctx, *, text: str):
		""" Pobiera definicje z wikipedii """
		try:
			definition = wikipedia.summary(text)
			
		except wikipedia.PageError:
			await ctx.send(f':x: | Nie istnieje')
			return 0;
			
		except wikipedia.DisambiguationError as e:
			pagelist = ":information_source:  | To jest **strona ujednoznaczniająca**.\n Poniżej znajdują się różne znaczenia hasła:\n"
			for page in e.options:
				pagelist += page + '\n'
				
			await ctx.send(f'{pagelist}')
			return 0;
			
		if len(definition) > 2000:
			await ctx.send(f':x: | Przekroczono limit maksymalnych znaków w wiadomości.')
		else:
			await ctx.send(definition, tts=True)
		
	@commands.command()
	@commands.cooldown(rate=1, per=60, type=commands.BucketType.user)
	async def zadymka(self, ctx):
		""" Uruchamia zadymke """
		await ctx.send(f'ZADYMKA XDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD', tts=True)
		
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def wypierdalaj(self, ctx):
		""" Jak sama nazwa wskazuje, wypierdalaj! """
		if not permissions.can_upload(ctx):
			return await ctx.send(":x: | Nie mogę wysyłać plików!")
		await ctx.send("Wypierdalaj", tts=True)
		wypierdalaj = 'http://nitrofun.5v.pl/memuchy/wyp' + str(random.randint(1,33)) + '.jpg'
		wypierpapier = BytesIO(await http.get(wypierdalaj, res_method="read"))
		await ctx.send(file=discord.File(wypierpapier, filename="wypierdalaj.jpg"))
		
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def filmik(self, ctx):
		""" Wysyła losowy filmik Małego """
		wypierdalaj = 'https://youtu.be/' + random.choice(movies)
		await ctx.send(wypierdalaj)
		
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def mikser(self, ctx):
		""" Wysyła losowe zdjęcie miksera! """
		if not permissions.can_upload(ctx):
			return await ctx.send(":x: | Nie mogę wysyłać plików!")
		await ctx.send(f'nwm jakiś fajny mikser z neta')
		wypierdalaj = random.choice(os.listdir("mikser"))
		await ctx.send(file=discord.File("mikser/" + wypierdalaj, filename=wypierdalaj))
		
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def bmw(self, ctx):
		""" Wysyła zdjęcie rozjebanego bmw """
		if not permissions.can_upload(ctx):
			return await ctx.send(":x: | Nie mogę wysyłać plików!")
		await ctx.send(f'nwm jakieś fajne rozjebane BMW z neta')
		wypierdalaj = random.choice(os.listdir("bmw"))
		await ctx.send(file=discord.File("bmw/" + wypierdalaj, filename=wypierdalaj))
		
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def focus(self, ctx):
		""" Wysyła zdjęcie rozjebanego focusa """
		if not permissions.can_upload(ctx):
			return await ctx.send(":x: | Nie mogę wysyłać plików!")
		await ctx.send(f'nwm jakiś fajny rozjebany focus z neta')
		wypierdalaj = random.choice(os.listdir("focus"))
		await ctx.send(file=discord.File("focus/" + wypierdalaj, filename=wypierdalaj))

	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def konin(self, ctx):
		""" Wysyła losowe zdjęcie Konina """
		if not permissions.can_upload(ctx):
			return await ctx.send(":x: | Nie mogę wysyłać plików!")
		await ctx.send(f'nwm jakieś fajne zdjęcie Konina')
		wypierdalaj = random.choice(os.listdir("konin"))
		await ctx.send(file=discord.File("konin/" + wypierdalaj, filename=wypierdalaj))

def setup(bot):
	bot.add_cog(Zabawy(bot))