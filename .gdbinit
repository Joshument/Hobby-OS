define hook-stop
    # Translate the segment:offset into a physical address
    b *0x7c00
    printf "[%4x:%4x] ", $cs, $eip
    x/i $cs*16+$eip
end 

set architecture i8086
target remote localhost:26000

set disassembly-flavor intel

layout asm
layout reg