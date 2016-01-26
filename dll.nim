import sdl2, unsigned
{.pragma: rtl, exportc, dynlib}

proc render*(rp: RendererPtr) {.rtl.}=
    rp.setDrawColor 0,0,0,255
    rp.clear
    rp.setDrawColor 255,0,0,255
    rp.drawPoint 100, 100
    rp.drawPoint 100, 101
    rp.drawPoint 100, 102
    rp.drawPoint 100, 103
    rp.drawPoint 100, 104
    rp.drawPoint 100, 105

    rp.setDrawColor 0,255,0,255
    rp.drawPoint 101, 100
    rp.drawPoint 101, 101
    rp.drawPoint 101, 102
    rp.drawPoint 101, 103
    rp.drawPoint 101, 104
    rp.drawPoint 101, 105

    rp.setDrawColor 0,127,127,255
    for i in 0..100:
            for j in 0..100: 
                    rp.drawPoint cast[cint](i*8),cast[cint](j*6) 
                    
    rp.drawPoint 101, 105
