# TO DO: Naprawić wyświetlanie polskich znaków.

import discord
from discord.ext import commands
from utils import permissions, http, default
from samp_client import constants
from samp_client.client import SampClient

class SAMP(commands.Cog, name="SA:MP"):
	def __init__(self, bot):
		self.bot = bot
		self.config = default.get("config.json")	
			
	@commands.command()
	@commands.cooldown(rate=1, per=1.5, type=commands.BucketType.user)
	async def samp(self, ctx, arg, port=7777):
		""" Pobiera informacje dot. serwera SA:MP """
		with SampClient(address=arg, port=int(port)) as client:
			info = client.get_server_info()
			embed = discord.Embed(colour=ctx.me.top_role.colour)
			embed.add_field(name="Hostname", value=f"{info.hostname}", inline=True)
			embed.add_field(name="Ilość graczy", value=f" {info.players}/{info.max_players}", inline=True)
			embed.add_field(name="Gamemode", value=f"{info.gamemode}", inline=True)
			embed.add_field(name="Język", value=f"{info.language}", inline=True)
			await ctx.send(content=f"Informacje o serwerze **{arg}:{port}**", embed=embed)
			
def setup(bot):
	bot.add_cog(SAMP(bot))