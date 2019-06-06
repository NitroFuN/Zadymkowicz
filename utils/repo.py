from utils import default

version = default.get("config.json").version
owners = default.get("config.json").owners


def is_owner(ctx):
	return ctx.author.id in owners
