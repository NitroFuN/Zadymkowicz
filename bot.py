import os

from discord.ext.commands import DefaultHelpCommand
from data import Bot
from utils import permissions, default

config = default.get("config.json")
description = """
"""


class HelpFormat(DefaultHelpCommand):
	async def get_destination(self, no_pm: bool = False):
		try:
			if permissions.can_react(self.context):
				await self.context.message.add_reaction(chr(0x2709))
		except discord.Forbidden:
			pass

		if no_pm:
			return self.context.channel
		else:
			return self.context.author

	async def send_command_help(self, command):
		self.add_command_formatting(command)
		self.paginator.close_page()
		await self.send_pages(no_pm=False)

	async def send_pages(self, no_pm: bool = False):
		destination = await self.get_destination(no_pm=no_pm)
		try:
			for page in self.paginator.pages:
				await destination.send(page)
		except discord.Forbidden:
			destination = await self.get_destination(no_pm=True)
			await destination.send(":x: | Nie mogę wysłać ci helpa, ponieważ masz zablokowane prywatne wiadomości :(")


print("Uruchamianie...")
help_attrs = dict(hidden=True)
bot = Bot(command_prefix=config.prefix, prefix=config.prefix, pm_help=True, help_attrs=help_attrs, formatter=HelpFormat())

for file in os.listdir("modules"):
	if file.endswith(".py"):
		name = file[:-3]
		bot.load_extension(f"modules.{name}")

@bot.event
async def on_ready(self):
	print(f'Ready: {self.bot.user} | Servers: {len(self.bot.guilds)}')
	await self.bot.change_presence(activity=discord.Game(type=0, name=self.config.playing), status=discord.Status.online)
	
bot.run(config.token)
