import sdl2
{.pragma: rtl, exportc, dynlib}

proc render*(rp: RendererPtr) {.rtl.}=
    echo "Rendering"
    rp.setDrawColor 0,0,0,255
    rp.clear
    rp.setDrawColor 255,255,255,255
    rp.drawPoint 100, 100
