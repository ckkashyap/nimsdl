#
# https://github.com/ckkashyap/nimsdl
#
import sdl2, unsigned
{.pragma: rtl, exportc, dynlib}

proc render*(rp: RendererPtr) {.rtl.}=
    rp.setDrawColor 0,0,255,255
    for x in 0..799:
            for y in 0..599:
                    rp.drawPoint cast[cint](x),cast[cint](y)
                    

    rp.setDrawColor 255,255,255,255
    for x in 200..300:
            rp.drawPoint cast[cint](x),cast[cint](100)
            rp.drawPoint cast[cint](x),cast[cint](200)
    for y in 100..200:
            rp.drawPoint cast[cint](200),cast[cint](y)
            rp.drawPoint cast[cint](300),cast[cint](y)


