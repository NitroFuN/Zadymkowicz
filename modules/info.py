# -*- coding: utf-8 -*-
import time
import discord
import psutil
import os

from datetime import datetime
from discord.ext import commands
from utils import repo, default


class Informacyjne(commands.Cog, name="Komendy informacyjne"):
	def __init__(self, bot):
		self.bot = bot
		self.config = default.get("config.json")
		self.process = psutil.Process(os.getpid())

	@commands.command()
	async def ping(self, ctx):
		""" Pong! """
		before = time.monotonic()
		message = await ctx.send("Pong")
		ping = (time.monotonic() - before) * 1000
		await message.edit(content=f"Pong   |   {int(ping)}ms")

	@commands.command(aliases=['info', 'stats', 'status'])
	async def informacje(self, ctx):
		""" Informacje o bocie """
		ramUsage = self.process.memory_full_info().rss / 1024**2
		embed = discord.Embed(colour=ctx.me.top_role.colour)
		embed.set_thumbnail(url=ctx.bot.user.avatar_url)
		embed.add_field(name="Ostatnie uruchomienie", value=default.timeago(datetime.now() - self.bot.uptime), inline=True)
		embed.add_field(name=f"Autor{'' if len(self.config.owners) == 1 else 's'}", value=', '.join([str(self.bot.get_user(x)) for x in self.config.owners]), inline=True)
		embed.add_field(name="Załadowanych komend", value=len([x.name for x in self.bot.commands]), inline=True)
		embed.add_field(name="Użycie RAM", value=f"{ramUsage:.2f} MB", inline=True)
		await ctx.send(content=f"**Zadymkowicz** | **{repo.version}**", embed=embed)


def setup(bot):
	bot.add_cog(Informacyjne(bot))