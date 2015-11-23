all:
	nim c --threads:on display.nim
	nim c -d:release --app:lib dll.nim -o dll
