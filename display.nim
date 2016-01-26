import sdl2, dynlib, locks, net, os, times


var lock: Lock
initLock(lock)


var thread: array [0..0, Thread[int]]

type RenderFuncType = proc (rp: RendererPtr) {.stdcall.}

var renderFunc : RenderFuncType = nil # cast[RenderFuncType](symbol)

discard sdl2.init(INIT_EVERYTHING)

var
  window: WindowPtr
  renderer: RendererPtr

window = createWindow("Hello SDL2", 100, 100, 800,600, SDL_WINDOW_SHOWN)
renderer = createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync or Renderer_TargetTexture)




proc threadFunc(i: int) {.thread.}=
  var dllFileName="libdll.dylib"
  var lastWriteTime = getFileInfo(dllFileName).lastWriteTime
  var dll = loadLib(dllFileName)
  var symbol = symAddr(dll, "render")
  renderFunc = cast[RenderFuncType](symbol)
  while true:
    acquire(lock)
    if lastWriteTime < getFileInfo(dllFileName).lastWriteTime:
            lastWriteTime = getFileInfo(dllFileName).lastWriteTime
            echo "Reloading library"
            if dll != nil:
                    unloadLib(dll)
                    dll = loadLib(dllFileName)
            if dll != nil:
                    symbol = symAddr(dll, "render")

                    if symbol == nil:
                          echo "symbol not found"

                    renderFunc = cast[RenderFuncType](symbol)
            else:
                    echo "Could not load the library"

    release(lock)
    sleep (400)
  
  


createThread(thread[0], threadFunc, 10)

var surface = getSurface(window)

var
  evt = sdl2.defaultEvent
  runGame = true

var once=false

proc doDraw(r: RendererPtr) =
  acquire(lock) # lock stdout
  if renderFunc != nil:
    renderFunc(r)
  if once:
    echo "hello World"
    r.setDrawColor 0,0,0,255
    r.clear
    r.setDrawColor 255,255,255,255
    r.drawPoint 100, 100
    once=false
  release(lock)

while runGame:
  while pollEvent(evt):
    if evt.kind == QuitEvent:
      runGame = false
      break

  doDraw renderer
  renderer.present

destroy renderer
destroy window

