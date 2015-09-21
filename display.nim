import sdl2
import dynlib

var dll = loadLib("dll")

if dll == nil:
        echo "Could not load library"
        system.quit()


var symbol = symAddr(dll, "render")

if symbol == nil:
        echo "symbol not found"

type RenderFuncType = proc (rp: RendererPtr) {.stdcall.}

var renderFunc = cast[RenderFuncType](symbol)

discard sdl2.init(INIT_EVERYTHING)

var
  window: WindowPtr
  renderer: RendererPtr

window = createWindow("Hello SDL2", 100, 100, 800,600, SDL_WINDOW_SHOWN)
renderer = createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync or Renderer_TargetTexture)




var surface = getSurface(window)

var
  evt = sdl2.defaultEvent
  runGame = true

var once=false

proc doDraw(r: RendererPtr) =
  renderFunc(r)
  if once:
    echo "hello World"
    r.setDrawColor 0,0,0,255
    r.clear
    r.setDrawColor 255,255,255,255
    r.drawPoint 100, 100
    once=false
  else:
    echo "done"

while runGame:
  while pollEvent(evt):
    if evt.kind == QuitEvent:
      runGame = false
      break

  doDraw renderer
  renderer.present

destroy renderer
destroy window

