import time
import json
import timeago as timesince

from collections import namedtuple


def get(file):
	try:
		with open(file, encoding='utf8') as data:
			return json.load(data, object_hook=lambda d: namedtuple('X', d.keys())(*d.values()))
	except AttributeError:
		raise AttributeError("Nieprawidłowy argument")
	except FileNotFoundError:
		raise FileNotFoundError("Plik JSON nie został znaleziony")


def timetext(name):
	return f"{name}_{int(time.time())}.txt"


def timeago(target):
	return timesince.format(target)


def date(target, clock=True):
	if clock is False:
		return target.strftime("%d %B %Y")
	return target.strftime("%d %B %Y, %H:%M")


def responsible(target, reason):
	responsible = f"[ {target} ]"
	if reason is None:
		return f":white_check_mark: | {responsible} \nPowód: nie podano powodu..."
	return f":white_check_mark: | {responsible} \nPowód: {reason}"


def actionmessage(case, mass=False):
	output = f"**{case}** użytkownika"

	if mass is True:
		output = f"**{case}** użytkowników"

		return f":white_check_mark: | Pomyślnie {output}"