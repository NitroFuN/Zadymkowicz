import time
import aiohttp
import discord
import asyncio

from asyncio.subprocess import PIPE
from discord.ext import commands
from io import BytesIO
from utils import repo, default, http


class Administracyjne(commands.Cog, name="Komendy administracyjne"):
	def __init__(self, bot):
		self.bot = bot
		self.config = default.get("config.json")
		self._last_result = None

	@commands.command()
	@commands.check(repo.is_owner)
	async def reload(self, ctx, name: str):
		""" Przełaadowywuje moduł """
		try:
			self.bot.unload_extension(f"cogs.{name}")
			self.bot.load_extension(f"cogs.{name}")
		except Exception as e:
			return await ctx.send(f"```\n{e}```")
		await ctx.send(f":white_check_mark: | Przeładowano **{name}.py**")
		
	@commands.command()
	@commands.check(repo.is_owner)
	async def server(self, ctx):
		""" Pokazuje na jakich serwerach jest bot """
		print(self.bot.guilds)
		
	@commands.command()
	@commands.check(repo.is_owner)
	async def playing(self, ctx, *, text: str):
		""" Dynamiczny system zmiany nazwy gry """
		await self.bot.change_presence(activity=discord.Game(type=0, name=text), status=discord.Status.online)
		await ctx.send(f":white_check_mark: | Zmieniono dynamicznie nazwę gry na: **{text}**")

	@commands.command()
	@commands.check(repo.is_owner)
	async def reboot(self, ctx):
		""" Ponownie uruchamia bota """
		time.sleep(1)
		await self.bot.logout()

	@commands.command()
	@commands.check(repo.is_owner)
	async def load(self, ctx, name: str):
		""" Ładuje moduł """
		try:
			self.bot.load_extension(f"cogs.{name}")
		except Exception as e:
			return await ctx.send(f"```diff\n- {e}```")
		await ctx.send(f":white_check_mark: | Załadowano moduł **{name}.py**")

	@commands.command()
	@commands.check(repo.is_owner)
	async def unload(self, ctx, name: str):
		""" Wyłącza moduł """
		try:
			self.bot.unload_extension(f"cogs.{name}")
		except Exception as e:
			return await ctx.send(f"```diff\n- {e}```")
		await ctx.send(f":white_check_mark: | Wyłączono moduł **{name}.py**")
		
	@commands.command(aliases=['exec'])
	@commands.check(repo.is_owner)
	async def execute(self, ctx, *, text: str):
		""" Wykonuje komende """
		message = await ctx.send(f"Loading...")
		proc = await asyncio.create_subprocess_shell(text, stdin=None, stderr=PIPE, stdout=PIPE)
		out = (await proc.stdout.read()).decode('utf-8').strip()
		err = (await proc.stderr.read()).decode('utf-8').strip()

		content = ""

		if err:
			content += f"Error:\r\n{err}\r\n{'-' * 30}\r\n"
		if out:
			content += out

		if len(content) > 2000:
			try:
				data = BytesIO(content.encode('utf-8'))
				await message.delete()
				await ctx.send(content=f"Wynik jest za duży, więc daje plik tekstowy z wynikiem wykonania polecenia", file=discord.File(data, filename=default.timetext(f'Result')))
			except asyncio.TimeoutError as e:
				await message.delete()
				return await ctx.send(e)
		else:
			await message.edit(content=f"```fix\n{content}\n```")

def setup(bot):
	bot.add_cog(Administracyjne(bot))