00030400  BC402D0300        mov esp,0x32d40
00030405  C705C8B103000000  mov dword [dword 0x3b1c8],0x0
         -0000
0003040F  0F0105CCB10300    sgdt [dword 0x3b1cc]
00030416  E8BC010000        call dword 0x305d7
0003041B  0F0115CCB10300    lgdt [dword 0x3b1cc]
00030422  0F011D402D0300    lidt [dword 0x32d40]
00030429  EA300403000800    jmp dword 0x8:0x30430
00030430  31C0              xor eax,eax
00030432  66B82000          mov ax,0x20
00030436  0F00D8            ltr ax
00030439  E9B90A0000        jmp dword 0x30ef7
0003043E  90                nop
0003043F  90                nop
00030440  83EC04            sub esp,byte +0x4
00030443  60                pushad
00030444  1E                push ds
00030445  06                push es
00030446  0FA0              push fs
00030448  0FA8              push gs
0003044A  668CD2            mov dx,ss
0003044D  8EC2              mov es,edx
0003044F  8EDA              mov ds,edx
00030451  65FE0500000000    inc byte [dword gs:0x0]
00030458  B020              mov al,0x20
0003045A  E620              out 0x20,al
0003045C  8D442448          lea eax,[esp+0x48]
00030460  A364B10300        mov [0x3b164],eax
00030465  0FA9              pop gs
00030467  0FA1              pop fs
00030469  07                pop es
0003046A  1F                pop ds
0003046B  83C404            add esp,byte +0x4
0003046E  61                popad
0003046F  CF                iretd
00030470  6A01              push byte +0x1
00030472  E8490A0000        call dword 0x30ec0
00030477  83C404            add esp,byte +0x4
0003047A  F4                hlt
0003047B  90                nop
0003047C  90                nop
0003047D  90                nop
0003047E  90                nop
0003047F  90                nop
00030480  6A02              push byte +0x2
00030482  E8390A0000        call dword 0x30ec0
00030487  83C404            add esp,byte +0x4
0003048A  F4                hlt
0003048B  90                nop
0003048C  90                nop
0003048D  90                nop
0003048E  90                nop
0003048F  90                nop
00030490  6A03              push byte +0x3
00030492  E8290A0000        call dword 0x30ec0
00030497  83C404            add esp,byte +0x4
0003049A  F4                hlt
0003049B  90                nop
0003049C  90                nop
0003049D  90                nop
0003049E  90                nop
0003049F  90                nop
000304A0  6A04              push byte +0x4
000304A2  E8190A0000        call dword 0x30ec0
000304A7  83C404            add esp,byte +0x4
000304AA  F4                hlt
000304AB  90                nop
000304AC  90                nop
000304AD  90                nop
000304AE  90                nop
000304AF  90                nop
000304B0  6A05              push byte +0x5
000304B2  E8090A0000        call dword 0x30ec0
000304B7  83C404            add esp,byte +0x4
000304BA  F4                hlt
000304BB  90                nop
000304BC  90                nop
000304BD  90                nop
000304BE  90                nop
000304BF  90                nop
000304C0  6A06              push byte +0x6
000304C2  E8F9090000        call dword 0x30ec0
000304C7  83C404            add esp,byte +0x4
000304CA  F4                hlt
000304CB  90                nop
000304CC  90                nop
000304CD  90                nop
000304CE  90                nop
000304CF  90                nop
000304D0  6A07              push byte +0x7
000304D2  E8E9090000        call dword 0x30ec0
000304D7  83C404            add esp,byte +0x4
000304DA  F4                hlt
000304DB  90                nop
000304DC  90                nop
000304DD  90                nop
000304DE  90                nop
000304DF  90                nop
000304E0  6A08              push byte +0x8
000304E2  E8D9090000        call dword 0x30ec0
000304E7  83C404            add esp,byte +0x4
000304EA  F4                hlt
000304EB  90                nop
000304EC  90                nop
000304ED  90                nop
000304EE  90                nop
000304EF  90                nop
000304F0  6A09              push byte +0x9
000304F2  E8C9090000        call dword 0x30ec0
000304F7  83C404            add esp,byte +0x4
000304FA  F4                hlt
000304FB  90                nop
000304FC  90                nop
000304FD  90                nop
000304FE  90                nop
000304FF  90                nop
00030500  6A0A              push byte +0xa
00030502  E8B9090000        call dword 0x30ec0
00030507  83C404            add esp,byte +0x4
0003050A  F4                hlt
0003050B  90                nop
0003050C  90                nop
0003050D  90                nop
0003050E  90                nop
0003050F  90                nop
00030510  6A0B              push byte +0xb
00030512  E8A9090000        call dword 0x30ec0
00030517  83C404            add esp,byte +0x4
0003051A  F4                hlt
0003051B  90                nop
0003051C  90                nop
0003051D  90                nop
0003051E  90                nop
0003051F  90                nop
00030520  6A0C              push byte +0xc
00030522  E899090000        call dword 0x30ec0
00030527  83C404            add esp,byte +0x4
0003052A  F4                hlt
0003052B  90                nop
0003052C  90                nop
0003052D  90                nop
0003052E  90                nop
0003052F  90                nop
00030530  6A0D              push byte +0xd
00030532  E889090000        call dword 0x30ec0
00030537  83C404            add esp,byte +0x4
0003053A  F4                hlt
0003053B  90                nop
0003053C  90                nop
0003053D  90                nop
0003053E  90                nop
0003053F  90                nop
00030540  6A0E              push byte +0xe
00030542  E879090000        call dword 0x30ec0
00030547  83C404            add esp,byte +0x4
0003054A  F4                hlt
0003054B  90                nop
0003054C  90                nop
0003054D  90                nop
0003054E  90                nop
0003054F  90                nop
00030550  6A0F              push byte +0xf
00030552  E869090000        call dword 0x30ec0
00030557  83C404            add esp,byte +0x4
0003055A  F4                hlt
0003055B  6AFF              push byte -0x1
0003055D  6A00              push byte +0x0
0003055F  EB4E              jmp short 0x305af
00030561  6AFF              push byte -0x1
00030563  6A01              push byte +0x1
00030565  EB48              jmp short 0x305af
00030567  6AFF              push byte -0x1
00030569  6A02              push byte +0x2
0003056B  EB42              jmp short 0x305af
0003056D  6AFF              push byte -0x1
0003056F  6A03              push byte +0x3
00030571  EB3C              jmp short 0x305af
00030573  6AFF              push byte -0x1
00030575  6A04              push byte +0x4
00030577  EB36              jmp short 0x305af
00030579  6AFF              push byte -0x1
0003057B  6A05              push byte +0x5
0003057D  EB30              jmp short 0x305af
0003057F  6AFF              push byte -0x1
00030581  6A06              push byte +0x6
00030583  EB2A              jmp short 0x305af
00030585  6AFF              push byte -0x1
00030587  6A07              push byte +0x7
00030589  EB24              jmp short 0x305af
0003058B  6A08              push byte +0x8
0003058D  EB20              jmp short 0x305af
0003058F  6AFF              push byte -0x1
00030591  6A09              push byte +0x9
00030593  EB1A              jmp short 0x305af
00030595  6A0A              push byte +0xa
00030597  EB16              jmp short 0x305af
00030599  6A0B              push byte +0xb
0003059B  EB12              jmp short 0x305af
0003059D  6A0C              push byte +0xc
0003059F  EB0E              jmp short 0x305af
000305A1  6A0D              push byte +0xd
000305A3  EB0A              jmp short 0x305af
000305A5  6A0E              push byte +0xe
000305A7  EB06              jmp short 0x305af
000305A9  6AFF              push byte -0x1
000305AB  6A10              push byte +0x10
000305AD  EB00              jmp short 0x305af
000305AF  E8B9060000        call dword 0x30c6d
000305B4  83C408            add esp,byte +0x8
000305B7  F4                hlt
000305B8  8B25E0B90300      mov esp,[dword 0x3b9e0]
000305BE  0F00542448        lldt [esp+0x48]
000305C3  8D442448          lea eax,[esp+0x48]
000305C7  A364B10300        mov [0x3b164],eax
000305CC  0FA9              pop gs
000305CE  0FA1              pop fs
000305D0  07                pop es
000305D1  1F                pop ds
000305D2  61                popad
000305D3  83C404            add esp,byte +0x4
000305D6  CF                iretd
000305D7  55                push ebp
000305D8  89E5              mov ebp,esp
000305DA  83EC18            sub esp,byte +0x18
000305DD  83EC0C            sub esp,byte +0xc
000305E0  6840100300        push dword 0x31040
000305E5  E886000000        call dword 0x30670
000305EA  83C410            add esp,byte +0x10
000305ED  B8CCB10300        mov eax,0x3b1cc
000305F2  0FB700            movzx eax,word [eax]
000305F5  0FB7C0            movzx eax,ax
000305F8  83C001            add eax,byte +0x1
000305FB  BACEB10300        mov edx,0x3b1ce
00030600  8B12              mov edx,[edx]
00030602  83EC04            sub esp,byte +0x4
00030605  50                push eax
00030606  52                push edx
00030607  6860AD0300        push dword 0x3ad60
0003060C  E8FF000000        call dword 0x30710
00030611  83C410            add esp,byte +0x10
00030614  C745F4CCB10300    mov dword [ebp-0xc],0x3b1cc
0003061B  C745F0CEB10300    mov dword [ebp-0x10],0x3b1ce
00030622  8B45F4            mov eax,[ebp-0xc]
00030625  66C700FF03        mov word [eax],0x3ff
0003062A  BA60AD0300        mov edx,0x3ad60
0003062F  8B45F0            mov eax,[ebp-0x10]
00030632  8910              mov [eax],edx
00030634  C745EC402D0300    mov dword [ebp-0x14],0x32d40
0003063B  C745E8422D0300    mov dword [ebp-0x18],0x32d42
00030642  8B45EC            mov eax,[ebp-0x14]
00030645  66C700FF07        mov word [eax],0x7ff
0003064A  BAE0B10300        mov edx,0x3b1e0
0003064F  8B45E8            mov eax,[ebp-0x18]
00030652  8910              mov [eax],edx
00030654  E81A020000        call dword 0x30873
00030659  83EC08            sub esp,byte +0x8
0003065C  6A74              push byte +0x74
0003065E  686A100300        push dword 0x3106a
00030663  E846000000        call dword 0x306ae
00030668  83C410            add esp,byte +0x10
0003066B  90                nop
0003066C  C9                leave
0003066D  C3                ret
0003066E  6690              xchg ax,ax
00030670  55                push ebp
00030671  89E5              mov ebp,esp
00030673  8B7508            mov esi,[ebp+0x8]
00030676  8B3DC8B10300      mov edi,[dword 0x3b1c8]
0003067C  B40F              mov ah,0xf
0003067E  AC                lodsb
0003067F  84C0              test al,al
00030681  7423              jz 0x306a6
00030683  3C0A              cmp al,0xa
00030685  7516              jnz 0x3069d
00030687  50                push eax
00030688  89F8              mov eax,edi
0003068A  B3A0              mov bl,0xa0
0003068C  F6F3              div bl
0003068E  25FF000000        and eax,0xff
00030693  40                inc eax
00030694  B3A0              mov bl,0xa0
00030696  F6E3              mul bl
00030698  89C7              mov edi,eax
0003069A  58                pop eax
0003069B  EBE1              jmp short 0x3067e
0003069D  65668907          mov [gs:edi],ax
000306A1  83C702            add edi,byte +0x2
000306A4  EBD8              jmp short 0x3067e
000306A6  893DC8B10300      mov [dword 0x3b1c8],edi
000306AC  5D                pop ebp
000306AD  C3                ret
000306AE  55                push ebp
000306AF  89E5              mov ebp,esp
000306B1  8B7508            mov esi,[ebp+0x8]
000306B4  8B3DC8B10300      mov edi,[dword 0x3b1c8]
000306BA  8A650C            mov ah,[ebp+0xc]
000306BD  AC                lodsb
000306BE  84C0              test al,al
000306C0  7423              jz 0x306e5
000306C2  3C0A              cmp al,0xa
000306C4  7516              jnz 0x306dc
000306C6  50                push eax
000306C7  89F8              mov eax,edi
000306C9  B3A0              mov bl,0xa0
000306CB  F6F3              div bl
000306CD  25FF000000        and eax,0xff
000306D2  40                inc eax
000306D3  B3A0              mov bl,0xa0
000306D5  F6E3              mul bl
000306D7  89C7              mov edi,eax
000306D9  58                pop eax
000306DA  EBE1              jmp short 0x306bd
000306DC  65668907          mov [gs:edi],ax
000306E0  83C702            add edi,byte +0x2
000306E3  EBD8              jmp short 0x306bd
000306E5  893DC8B10300      mov [dword 0x3b1c8],edi
000306EB  5D                pop ebp
000306EC  C3                ret
000306ED  8B542404          mov edx,[esp+0x4]
000306F1  8A442408          mov al,[esp+0x8]
000306F5  EE                out dx,al
000306F6  90                nop
000306F7  90                nop
000306F8  C3                ret
000306F9  8B542404          mov edx,[esp+0x4]
000306FD  31C0              xor eax,eax
000306FF  EC                in al,dx
00030700  90                nop
00030701  90                nop
00030702  C3                ret
00030703  6690              xchg ax,ax
00030705  6690              xchg ax,ax
00030707  6690              xchg ax,ax
00030709  6690              xchg ax,ax
0003070B  6690              xchg ax,ax
0003070D  6690              xchg ax,ax
0003070F  90                nop
00030710  55                push ebp
00030711  89E5              mov ebp,esp
00030713  56                push esi
00030714  57                push edi
00030715  51                push ecx
00030716  8B7D08            mov edi,[ebp+0x8]
00030719  8B750C            mov esi,[ebp+0xc]
0003071C  8B4D10            mov ecx,[ebp+0x10]
0003071F  83F900            cmp ecx,byte +0x0
00030722  740B              jz 0x3072f
00030724  3E8A06            mov al,[ds:esi]
00030727  46                inc esi
00030728  268807            mov [es:edi],al
0003072B  47                inc edi
0003072C  49                dec ecx
0003072D  EBF0              jmp short 0x3071f
0003072F  8B4508            mov eax,[ebp+0x8]
00030732  59                pop ecx
00030733  5F                pop edi
00030734  5E                pop esi
00030735  89EC              mov esp,ebp
00030737  5D                pop ebp
00030738  C3                ret
00030739  55                push ebp
0003073A  89E5              mov ebp,esp
0003073C  56                push esi
0003073D  57                push edi
0003073E  51                push ecx
0003073F  8B7D08            mov edi,[ebp+0x8]
00030742  8B550C            mov edx,[ebp+0xc]
00030745  8B4D10            mov ecx,[ebp+0x10]
00030748  83F900            cmp ecx,byte +0x0
0003074B  7406              jz 0x30753
0003074D  8817              mov [edi],dl
0003074F  47                inc edi
00030750  49                dec ecx
00030751  EBF5              jmp short 0x30748
00030753  59                pop ecx
00030754  5F                pop edi
00030755  5E                pop esi
00030756  89EC              mov esp,ebp
00030758  5D                pop ebp
00030759  C3                ret
0003075A  55                push ebp
0003075B  89E5              mov ebp,esp
0003075D  83EC10            sub esp,byte +0x10
00030760  8B4508            mov eax,[ebp+0x8]
00030763  8945FC            mov [ebp-0x4],eax
00030766  C745F000000000    mov dword [ebp-0x10],0x0
0003076D  8B45FC            mov eax,[ebp-0x4]
00030770  8D5001            lea edx,[eax+0x1]
00030773  8955FC            mov [ebp-0x4],edx
00030776  C60030            mov byte [eax],0x30
00030779  8B45FC            mov eax,[ebp-0x4]
0003077C  8D5001            lea edx,[eax+0x1]
0003077F  8955FC            mov [ebp-0x4],edx
00030782  C60078            mov byte [eax],0x78
00030785  837D0C00          cmp dword [ebp+0xc],byte +0x0
00030789  750E              jnz 0x30799
0003078B  8B45FC            mov eax,[ebp-0x4]
0003078E  8D5001            lea edx,[eax+0x1]
00030791  8955FC            mov [ebp-0x4],edx
00030794  C60030            mov byte [eax],0x30
00030797  EB61              jmp short 0x307fa
00030799  C745F41C000000    mov dword [ebp-0xc],0x1c
000307A0  EB52              jmp short 0x307f4
000307A2  8B45F4            mov eax,[ebp-0xc]
000307A5  8B550C            mov edx,[ebp+0xc]
000307A8  89C1              mov ecx,eax
000307AA  D3FA              sar edx,cl
000307AC  89D0              mov eax,edx
000307AE  83E00F            and eax,byte +0xf
000307B1  8845FB            mov [ebp-0x5],al
000307B4  837DF000          cmp dword [ebp-0x10],byte +0x0
000307B8  7506              jnz 0x307c0
000307BA  807DFB00          cmp byte [ebp-0x5],0x0
000307BE  7E30              jng 0x307f0
000307C0  C745F001000000    mov dword [ebp-0x10],0x1
000307C7  0FB645FB          movzx eax,byte [ebp-0x5]
000307CB  83C030            add eax,byte +0x30
000307CE  8845FB            mov [ebp-0x5],al
000307D1  807DFB39          cmp byte [ebp-0x5],0x39
000307D5  7E0A              jng 0x307e1
000307D7  0FB645FB          movzx eax,byte [ebp-0x5]
000307DB  83C007            add eax,byte +0x7
000307DE  8845FB            mov [ebp-0x5],al
000307E1  8B45FC            mov eax,[ebp-0x4]
000307E4  8D5001            lea edx,[eax+0x1]
000307E7  8955FC            mov [ebp-0x4],edx
000307EA  0FB655FB          movzx edx,byte [ebp-0x5]
000307EE  8810              mov [eax],dl
000307F0  836DF404          sub dword [ebp-0xc],byte +0x4
000307F4  837DF400          cmp dword [ebp-0xc],byte +0x0
000307F8  79A8              jns 0x307a2
000307FA  8B45FC            mov eax,[ebp-0x4]
000307FD  C60000            mov byte [eax],0x0
00030800  8B4508            mov eax,[ebp+0x8]
00030803  C9                leave
00030804  C3                ret
00030805  55                push ebp
00030806  89E5              mov ebp,esp
00030808  83EC18            sub esp,byte +0x18
0003080B  FF7508            push dword [ebp+0x8]
0003080E  8D45E8            lea eax,[ebp-0x18]
00030811  50                push eax
00030812  E843FFFFFF        call dword 0x3075a
00030817  83C408            add esp,byte +0x8
0003081A  83EC0C            sub esp,byte +0xc
0003081D  8D45E8            lea eax,[ebp-0x18]
00030820  50                push eax
00030821  E84AFEFFFF        call dword 0x30670
00030826  83C410            add esp,byte +0x10
00030829  90                nop
0003082A  C9                leave
0003082B  C3                ret
0003082C  55                push ebp
0003082D  89E5              mov ebp,esp
0003082F  83EC10            sub esp,byte +0x10
00030832  C745F400000000    mov dword [ebp-0xc],0x0
00030839  EB2D              jmp short 0x30868
0003083B  C745FC00000000    mov dword [ebp-0x4],0x0
00030842  EB1A              jmp short 0x3085e
00030844  C745F800000000    mov dword [ebp-0x8],0x0
0003084B  EB04              jmp short 0x30851
0003084D  8345F801          add dword [ebp-0x8],byte +0x1
00030851  817DF80F270000    cmp dword [ebp-0x8],0x270f
00030858  7EF3              jng 0x3084d
0003085A  8345FC01          add dword [ebp-0x4],byte +0x1
0003085E  837DFC09          cmp dword [ebp-0x4],byte +0x9
00030862  7EE0              jng 0x30844
00030864  8345F401          add dword [ebp-0xc],byte +0x1
00030868  8B45F4            mov eax,[ebp-0xc]
0003086B  3B4508            cmp eax,[ebp+0x8]
0003086E  7CCB              jl 0x3083b
00030870  90                nop
00030871  C9                leave
00030872  C3                ret
00030873  55                push ebp
00030874  89E5              mov ebp,esp
00030876  83EC08            sub esp,byte +0x8
00030879  E88E050000        call dword 0x30e0c
0003087E  6A00              push byte +0x0
00030880  685B050300        push dword 0x3055b
00030885  688E000000        push dword 0x8e
0003088A  6A00              push byte +0x0
0003088C  E80A050000        call dword 0x30d9b
00030891  83C410            add esp,byte +0x10
00030894  6A00              push byte +0x0
00030896  6861050300        push dword 0x30561
0003089B  688E000000        push dword 0x8e
000308A0  6A01              push byte +0x1
000308A2  E8F4040000        call dword 0x30d9b
000308A7  83C410            add esp,byte +0x10
000308AA  6A00              push byte +0x0
000308AC  6867050300        push dword 0x30567
000308B1  688E000000        push dword 0x8e
000308B6  6A02              push byte +0x2
000308B8  E8DE040000        call dword 0x30d9b
000308BD  83C410            add esp,byte +0x10
000308C0  6A03              push byte +0x3
000308C2  686D050300        push dword 0x3056d
000308C7  688E000000        push dword 0x8e
000308CC  6A03              push byte +0x3
000308CE  E8C8040000        call dword 0x30d9b
000308D3  83C410            add esp,byte +0x10
000308D6  6A03              push byte +0x3
000308D8  6873050300        push dword 0x30573
000308DD  688E000000        push dword 0x8e
000308E2  6A04              push byte +0x4
000308E4  E8B2040000        call dword 0x30d9b
000308E9  83C410            add esp,byte +0x10
000308EC  6A00              push byte +0x0
000308EE  6879050300        push dword 0x30579
000308F3  688E000000        push dword 0x8e
000308F8  6A05              push byte +0x5
000308FA  E89C040000        call dword 0x30d9b
000308FF  83C410            add esp,byte +0x10
00030902  6A00              push byte +0x0
00030904  687F050300        push dword 0x3057f
00030909  688E000000        push dword 0x8e
0003090E  6A06              push byte +0x6
00030910  E886040000        call dword 0x30d9b
00030915  83C410            add esp,byte +0x10
00030918  6A00              push byte +0x0
0003091A  6885050300        push dword 0x30585
0003091F  688E000000        push dword 0x8e
00030924  6A07              push byte +0x7
00030926  E870040000        call dword 0x30d9b
0003092B  83C410            add esp,byte +0x10
0003092E  6A00              push byte +0x0
00030930  688B050300        push dword 0x3058b
00030935  688E000000        push dword 0x8e
0003093A  6A08              push byte +0x8
0003093C  E85A040000        call dword 0x30d9b
00030941  83C410            add esp,byte +0x10
00030944  6A00              push byte +0x0
00030946  688F050300        push dword 0x3058f
0003094B  688E000000        push dword 0x8e
00030950  6A09              push byte +0x9
00030952  E844040000        call dword 0x30d9b
00030957  83C410            add esp,byte +0x10
0003095A  6A00              push byte +0x0
0003095C  6895050300        push dword 0x30595
00030961  688E000000        push dword 0x8e
00030966  6A0A              push byte +0xa
00030968  E82E040000        call dword 0x30d9b
0003096D  83C410            add esp,byte +0x10
00030970  6A00              push byte +0x0
00030972  6899050300        push dword 0x30599
00030977  688E000000        push dword 0x8e
0003097C  6A0B              push byte +0xb
0003097E  E818040000        call dword 0x30d9b
00030983  83C410            add esp,byte +0x10
00030986  6A00              push byte +0x0
00030988  689D050300        push dword 0x3059d
0003098D  688E000000        push dword 0x8e
00030992  6A0C              push byte +0xc
00030994  E802040000        call dword 0x30d9b
00030999  83C410            add esp,byte +0x10
0003099C  6A00              push byte +0x0
0003099E  68A1050300        push dword 0x305a1
000309A3  688E000000        push dword 0x8e
000309A8  6A0D              push byte +0xd
000309AA  E8EC030000        call dword 0x30d9b
000309AF  83C410            add esp,byte +0x10
000309B2  6A00              push byte +0x0
000309B4  68A5050300        push dword 0x305a5
000309B9  688E000000        push dword 0x8e
000309BE  6A0E              push byte +0xe
000309C0  E8D6030000        call dword 0x30d9b
000309C5  83C410            add esp,byte +0x10
000309C8  6A00              push byte +0x0
000309CA  68A9050300        push dword 0x305a9
000309CF  688E000000        push dword 0x8e
000309D4  6A10              push byte +0x10
000309D6  E8C0030000        call dword 0x30d9b
000309DB  83C410            add esp,byte +0x10
000309DE  6A00              push byte +0x0
000309E0  6840040300        push dword 0x30440
000309E5  688E000000        push dword 0x8e
000309EA  6A20              push byte +0x20
000309EC  E8AA030000        call dword 0x30d9b
000309F1  83C410            add esp,byte +0x10
000309F4  6A00              push byte +0x0
000309F6  6870040300        push dword 0x30470
000309FB  688E000000        push dword 0x8e
00030A00  6A21              push byte +0x21
00030A02  E894030000        call dword 0x30d9b
00030A07  83C410            add esp,byte +0x10
00030A0A  6A00              push byte +0x0
00030A0C  6880040300        push dword 0x30480
00030A11  688E000000        push dword 0x8e
00030A16  6A22              push byte +0x22
00030A18  E87E030000        call dword 0x30d9b
00030A1D  83C410            add esp,byte +0x10
00030A20  6A00              push byte +0x0
00030A22  6890040300        push dword 0x30490
00030A27  688E000000        push dword 0x8e
00030A2C  6A23              push byte +0x23
00030A2E  E868030000        call dword 0x30d9b
00030A33  83C410            add esp,byte +0x10
00030A36  6A00              push byte +0x0
00030A38  68A0040300        push dword 0x304a0
00030A3D  688E000000        push dword 0x8e
00030A42  6A24              push byte +0x24
00030A44  E852030000        call dword 0x30d9b
00030A49  83C410            add esp,byte +0x10
00030A4C  6A00              push byte +0x0
00030A4E  68B0040300        push dword 0x304b0
00030A53  688E000000        push dword 0x8e
00030A58  6A25              push byte +0x25
00030A5A  E83C030000        call dword 0x30d9b
00030A5F  83C410            add esp,byte +0x10
00030A62  6A00              push byte +0x0
00030A64  68C0040300        push dword 0x304c0
00030A69  688E000000        push dword 0x8e
00030A6E  6A26              push byte +0x26
00030A70  E826030000        call dword 0x30d9b
00030A75  83C410            add esp,byte +0x10
00030A78  6A00              push byte +0x0
00030A7A  68D0040300        push dword 0x304d0
00030A7F  688E000000        push dword 0x8e
00030A84  6A27              push byte +0x27
00030A86  E810030000        call dword 0x30d9b
00030A8B  83C410            add esp,byte +0x10
00030A8E  6A00              push byte +0x0
00030A90  68E0040300        push dword 0x304e0
00030A95  688E000000        push dword 0x8e
00030A9A  6A28              push byte +0x28
00030A9C  E8FA020000        call dword 0x30d9b
00030AA1  83C410            add esp,byte +0x10
00030AA4  6A00              push byte +0x0
00030AA6  68F0040300        push dword 0x304f0
00030AAB  688E000000        push dword 0x8e
00030AB0  6A29              push byte +0x29
00030AB2  E8E4020000        call dword 0x30d9b
00030AB7  83C410            add esp,byte +0x10
00030ABA  6A00              push byte +0x0
00030ABC  6800050300        push dword 0x30500
00030AC1  688E000000        push dword 0x8e
00030AC6  6A2A              push byte +0x2a
00030AC8  E8CE020000        call dword 0x30d9b
00030ACD  83C410            add esp,byte +0x10
00030AD0  6A00              push byte +0x0
00030AD2  6810050300        push dword 0x30510
00030AD7  688E000000        push dword 0x8e
00030ADC  6A2B              push byte +0x2b
00030ADE  E8B8020000        call dword 0x30d9b
00030AE3  83C410            add esp,byte +0x10
00030AE6  6A00              push byte +0x0
00030AE8  6820050300        push dword 0x30520
00030AED  688E000000        push dword 0x8e
00030AF2  6A2C              push byte +0x2c
00030AF4  E8A2020000        call dword 0x30d9b
00030AF9  83C410            add esp,byte +0x10
00030AFC  6A00              push byte +0x0
00030AFE  6830050300        push dword 0x30530
00030B03  688E000000        push dword 0x8e
00030B08  6A2D              push byte +0x2d
00030B0A  E88C020000        call dword 0x30d9b
00030B0F  83C410            add esp,byte +0x10
00030B12  6A00              push byte +0x0
00030B14  6840050300        push dword 0x30540
00030B19  688E000000        push dword 0x8e
00030B1E  6A2E              push byte +0x2e
00030B20  E876020000        call dword 0x30d9b
00030B25  83C410            add esp,byte +0x10
00030B28  6A00              push byte +0x0
00030B2A  6850050300        push dword 0x30550
00030B2F  688E000000        push dword 0x8e
00030B34  6A2F              push byte +0x2f
00030B36  E860020000        call dword 0x30d9b
00030B3B  83C410            add esp,byte +0x10
00030B3E  83EC04            sub esp,byte +0x4
00030B41  6A68              push byte +0x68
00030B43  6A00              push byte +0x0
00030B45  6860B10300        push dword 0x3b160
00030B4A  E8EAFBFFFF        call dword 0x30739
00030B4F  83C410            add esp,byte +0x10
00030B52  C70568B103001000  mov dword [dword 0x3b168],0x10
         -0000
00030B5C  83EC0C            sub esp,byte +0xc
00030B5F  6A10              push byte +0x10
00030B61  E84B000000        call dword 0x30bb1
00030B66  83C410            add esp,byte +0x10
00030B69  BA60B10300        mov edx,0x3b160
00030B6E  01D0              add eax,edx
00030B70  6889000000        push dword 0x89
00030B75  6A67              push byte +0x67
00030B77  50                push eax
00030B78  6880AD0300        push dword 0x3ad80
00030B7D  E87E000000        call dword 0x30c00
00030B82  83C410            add esp,byte +0x10
00030B85  83EC0C            sub esp,byte +0xc
00030B88  6A10              push byte +0x10
00030B8A  E822000000        call dword 0x30bb1
00030B8F  83C410            add esp,byte +0x10
00030B92  BA4ABA0300        mov edx,0x3ba4a
00030B97  01D0              add eax,edx
00030B99  6882000000        push dword 0x82
00030B9E  6A0F              push byte +0xf
00030BA0  50                push eax
00030BA1  6888AD0300        push dword 0x3ad88
00030BA6  E855000000        call dword 0x30c00
00030BAB  83C410            add esp,byte +0x10
00030BAE  90                nop
00030BAF  C9                leave
00030BB0  C3                ret
00030BB1  55                push ebp
00030BB2  89E5              mov ebp,esp
00030BB4  83EC14            sub esp,byte +0x14
00030BB7  8B4508            mov eax,[ebp+0x8]
00030BBA  668945EC          mov [ebp-0x14],ax
00030BBE  0FB745EC          movzx eax,word [ebp-0x14]
00030BC2  66C1E803          shr ax,byte 0x3
00030BC6  0FB7C0            movzx eax,ax
00030BC9  C1E003            shl eax,byte 0x3
00030BCC  0560AD0300        add eax,0x3ad60
00030BD1  8945FC            mov [ebp-0x4],eax
00030BD4  8B45FC            mov eax,[ebp-0x4]
00030BD7  0FB64007          movzx eax,byte [eax+0x7]
00030BDB  0FB6C0            movzx eax,al
00030BDE  C1E018            shl eax,byte 0x18
00030BE1  89C2              mov edx,eax
00030BE3  8B45FC            mov eax,[ebp-0x4]
00030BE6  0FB64004          movzx eax,byte [eax+0x4]
00030BEA  0FB6C0            movzx eax,al
00030BED  C1E010            shl eax,byte 0x10
00030BF0  09C2              or edx,eax
00030BF2  8B45FC            mov eax,[ebp-0x4]
00030BF5  0FB74002          movzx eax,word [eax+0x2]
00030BF9  0FB7C0            movzx eax,ax
00030BFC  09D0              or eax,edx
00030BFE  C9                leave
00030BFF  C3                ret
00030C00  55                push ebp
00030C01  89E5              mov ebp,esp
00030C03  83EC04            sub esp,byte +0x4
00030C06  8B4514            mov eax,[ebp+0x14]
00030C09  668945FC          mov [ebp-0x4],ax
00030C0D  8B4510            mov eax,[ebp+0x10]
00030C10  89C2              mov edx,eax
00030C12  8B4508            mov eax,[ebp+0x8]
00030C15  668910            mov [eax],dx
00030C18  8B450C            mov eax,[ebp+0xc]
00030C1B  89C2              mov edx,eax
00030C1D  8B4508            mov eax,[ebp+0x8]
00030C20  66895002          mov [eax+0x2],dx
00030C24  8B450C            mov eax,[ebp+0xc]
00030C27  C1E810            shr eax,byte 0x10
00030C2A  89C2              mov edx,eax
00030C2C  8B4508            mov eax,[ebp+0x8]
00030C2F  885004            mov [eax+0x4],dl
00030C32  0FB745FC          movzx eax,word [ebp-0x4]
00030C36  89C2              mov edx,eax
00030C38  8B4508            mov eax,[ebp+0x8]
00030C3B  885005            mov [eax+0x5],dl
00030C3E  8B4510            mov eax,[ebp+0x10]
00030C41  C1E810            shr eax,byte 0x10
00030C44  83E00F            and eax,byte +0xf
00030C47  89C2              mov edx,eax
00030C49  0FB745FC          movzx eax,word [ebp-0x4]
00030C4D  66C1E808          shr ax,byte 0x8
00030C51  83E0F0            and eax,byte -0x10
00030C54  09C2              or edx,eax
00030C56  8B4508            mov eax,[ebp+0x8]
00030C59  885006            mov [eax+0x6],dl
00030C5C  8B450C            mov eax,[ebp+0xc]
00030C5F  C1E818            shr eax,byte 0x18
00030C62  89C2              mov edx,eax
00030C64  8B4508            mov eax,[ebp+0x8]
00030C67  885007            mov [eax+0x7],dl
00030C6A  90                nop
00030C6B  C9                leave
00030C6C  C3                ret
00030C6D  55                push ebp
00030C6E  89E5              mov ebp,esp
00030C70  57                push edi
00030C71  56                push esi
00030C72  53                push ebx
00030C73  83EC6C            sub esp,byte +0x6c
00030C76  C745E074000000    mov dword [ebp-0x20],0x74
00030C7D  8D4590            lea eax,[ebp-0x70]
00030C80  BBE0120300        mov ebx,0x312e0
00030C85  BA14000000        mov edx,0x14
00030C8A  89C7              mov edi,eax
00030C8C  89DE              mov esi,ebx
00030C8E  89D1              mov ecx,edx
00030C90  F3A5              rep movsd
00030C92  C705C8B103000000  mov dword [dword 0x3b1c8],0x0
         -0000
00030C9C  C745E400000000    mov dword [ebp-0x1c],0x0
00030CA3  EB14              jmp short 0x30cb9
00030CA5  83EC0C            sub esp,byte +0xc
00030CA8  68A0100300        push dword 0x310a0
00030CAD  E8BEF9FFFF        call dword 0x30670
00030CB2  83C410            add esp,byte +0x10
00030CB5  8345E401          add dword [ebp-0x1c],byte +0x1
00030CB9  817DE48F010000    cmp dword [ebp-0x1c],0x18f
00030CC0  7EE3              jng 0x30ca5
00030CC2  C705C8B103000000  mov dword [dword 0x3b1c8],0x0
         -0000
00030CCC  83EC08            sub esp,byte +0x8
00030CCF  FF75E0            push dword [ebp-0x20]
00030CD2  68A2100300        push dword 0x310a2
00030CD7  E8D2F9FFFF        call dword 0x306ae
00030CDC  83C410            add esp,byte +0x10
00030CDF  8B4508            mov eax,[ebp+0x8]
00030CE2  8B448590          mov eax,[ebp+eax*4-0x70]
00030CE6  83EC08            sub esp,byte +0x8
00030CE9  FF75E0            push dword [ebp-0x20]
00030CEC  50                push eax
00030CED  E8BCF9FFFF        call dword 0x306ae
00030CF2  83C410            add esp,byte +0x10
00030CF5  83EC08            sub esp,byte +0x8
00030CF8  FF75E0            push dword [ebp-0x20]
00030CFB  68B2100300        push dword 0x310b2
00030D00  E8A9F9FFFF        call dword 0x306ae
00030D05  83C410            add esp,byte +0x10
00030D08  83EC08            sub esp,byte +0x8
00030D0B  FF75E0            push dword [ebp-0x20]
00030D0E  68B5100300        push dword 0x310b5
00030D13  E896F9FFFF        call dword 0x306ae
00030D18  83C410            add esp,byte +0x10
00030D1B  83EC0C            sub esp,byte +0xc
00030D1E  FF7518            push dword [ebp+0x18]
00030D21  E8DFFAFFFF        call dword 0x30805
00030D26  83C410            add esp,byte +0x10
00030D29  83EC08            sub esp,byte +0x8
00030D2C  FF75E0            push dword [ebp-0x20]
00030D2F  68BD100300        push dword 0x310bd
00030D34  E875F9FFFF        call dword 0x306ae
00030D39  83C410            add esp,byte +0x10
00030D3C  83EC0C            sub esp,byte +0xc
00030D3F  FF7514            push dword [ebp+0x14]
00030D42  E8BEFAFFFF        call dword 0x30805
00030D47  83C410            add esp,byte +0x10
00030D4A  83EC08            sub esp,byte +0x8
00030D4D  FF75E0            push dword [ebp-0x20]
00030D50  68C1100300        push dword 0x310c1
00030D55  E854F9FFFF        call dword 0x306ae
00030D5A  83C410            add esp,byte +0x10
00030D5D  83EC0C            sub esp,byte +0xc
00030D60  FF7510            push dword [ebp+0x10]
00030D63  E89DFAFFFF        call dword 0x30805
00030D68  83C410            add esp,byte +0x10
00030D6B  837D0CFF          cmp dword [ebp+0xc],byte -0x1
00030D6F  7421              jz 0x30d92
00030D71  83EC08            sub esp,byte +0x8
00030D74  FF75E0            push dword [ebp-0x20]
00030D77  68C6100300        push dword 0x310c6
00030D7C  E82DF9FFFF        call dword 0x306ae
00030D81  83C410            add esp,byte +0x10
00030D84  83EC0C            sub esp,byte +0xc
00030D87  FF750C            push dword [ebp+0xc]
00030D8A  E876FAFFFF        call dword 0x30805
00030D8F  83C410            add esp,byte +0x10
00030D92  90                nop
00030D93  8D65F4            lea esp,[ebp-0xc]
00030D96  5B                pop ebx
00030D97  5E                pop esi
00030D98  5F                pop edi
00030D99  5D                pop ebp
00030D9A  C3                ret
00030D9B  55                push ebp
00030D9C  89E5              mov ebp,esp
00030D9E  83EC1C            sub esp,byte +0x1c
00030DA1  8B4D08            mov ecx,[ebp+0x8]
00030DA4  8B550C            mov edx,[ebp+0xc]
00030DA7  8B4514            mov eax,[ebp+0x14]
00030DAA  884DEC            mov [ebp-0x14],cl
00030DAD  8855E8            mov [ebp-0x18],dl
00030DB0  8845E4            mov [ebp-0x1c],al
00030DB3  0FB645EC          movzx eax,byte [ebp-0x14]
00030DB7  C1E003            shl eax,byte 0x3
00030DBA  05E0B10300        add eax,0x3b1e0
00030DBF  8945FC            mov [ebp-0x4],eax
00030DC2  8B4510            mov eax,[ebp+0x10]
00030DC5  8945F8            mov [ebp-0x8],eax
00030DC8  8B45F8            mov eax,[ebp-0x8]
00030DCB  89C2              mov edx,eax
00030DCD  8B45FC            mov eax,[ebp-0x4]
00030DD0  668910            mov [eax],dx
00030DD3  8B45FC            mov eax,[ebp-0x4]
00030DD6  66C740020800      mov word [eax+0x2],0x8
00030DDC  8B45FC            mov eax,[ebp-0x4]
00030DDF  C6400400          mov byte [eax+0x4],0x0
00030DE3  0FB645E4          movzx eax,byte [ebp-0x1c]
00030DE7  C1E005            shl eax,byte 0x5
00030DEA  89C2              mov edx,eax
00030DEC  0FB645E8          movzx eax,byte [ebp-0x18]
00030DF0  09D0              or eax,edx
00030DF2  89C2              mov edx,eax
00030DF4  8B45FC            mov eax,[ebp-0x4]
00030DF7  885005            mov [eax+0x5],dl
00030DFA  8B45F8            mov eax,[ebp-0x8]
00030DFD  C1E810            shr eax,byte 0x10
00030E00  89C2              mov edx,eax
00030E02  8B45FC            mov eax,[ebp-0x4]
00030E05  66895006          mov [eax+0x6],dx
00030E09  90                nop
00030E0A  C9                leave
00030E0B  C3                ret
00030E0C  55                push ebp
00030E0D  89E5              mov ebp,esp
00030E0F  83EC08            sub esp,byte +0x8
00030E12  83EC08            sub esp,byte +0x8
00030E15  6A11              push byte +0x11
00030E17  6A20              push byte +0x20
00030E19  E8CFF8FFFF        call dword 0x306ed
00030E1E  83C410            add esp,byte +0x10
00030E21  83EC08            sub esp,byte +0x8
00030E24  6A11              push byte +0x11
00030E26  68A0000000        push dword 0xa0
00030E2B  E8BDF8FFFF        call dword 0x306ed
00030E30  83C410            add esp,byte +0x10
00030E33  83EC08            sub esp,byte +0x8
00030E36  6A20              push byte +0x20
00030E38  6A21              push byte +0x21
00030E3A  E8AEF8FFFF        call dword 0x306ed
00030E3F  83C410            add esp,byte +0x10
00030E42  83EC08            sub esp,byte +0x8
00030E45  6A28              push byte +0x28
00030E47  68A1000000        push dword 0xa1
00030E4C  E89CF8FFFF        call dword 0x306ed
00030E51  83C410            add esp,byte +0x10
00030E54  83EC08            sub esp,byte +0x8
00030E57  6A04              push byte +0x4
00030E59  6A21              push byte +0x21
00030E5B  E88DF8FFFF        call dword 0x306ed
00030E60  83C410            add esp,byte +0x10
00030E63  83EC08            sub esp,byte +0x8
00030E66  6A02              push byte +0x2
00030E68  68A1000000        push dword 0xa1
00030E6D  E87BF8FFFF        call dword 0x306ed
00030E72  83C410            add esp,byte +0x10
00030E75  83EC08            sub esp,byte +0x8
00030E78  6A01              push byte +0x1
00030E7A  6A21              push byte +0x21
00030E7C  E86CF8FFFF        call dword 0x306ed
00030E81  83C410            add esp,byte +0x10
00030E84  83EC08            sub esp,byte +0x8
00030E87  6A01              push byte +0x1
00030E89  68A1000000        push dword 0xa1
00030E8E  E85AF8FFFF        call dword 0x306ed
00030E93  83C410            add esp,byte +0x10
00030E96  83EC08            sub esp,byte +0x8
00030E99  68FE000000        push dword 0xfe
00030E9E  6A21              push byte +0x21
00030EA0  E848F8FFFF        call dword 0x306ed
00030EA5  83C410            add esp,byte +0x10
00030EA8  83EC08            sub esp,byte +0x8
00030EAB  68FF000000        push dword 0xff
00030EB0  68A1000000        push dword 0xa1
00030EB5  E833F8FFFF        call dword 0x306ed
00030EBA  83C410            add esp,byte +0x10
00030EBD  90                nop
00030EBE  C9                leave
00030EBF  C3                ret
00030EC0  55                push ebp
00030EC1  89E5              mov ebp,esp
00030EC3  83EC08            sub esp,byte +0x8
00030EC6  83EC0C            sub esp,byte +0xc
00030EC9  6830130300        push dword 0x31330
00030ECE  E89DF7FFFF        call dword 0x30670
00030ED3  83C410            add esp,byte +0x10
00030ED6  83EC0C            sub esp,byte +0xc
00030ED9  FF7508            push dword [ebp+0x8]
00030EDC  E824F9FFFF        call dword 0x30805
00030EE1  83C410            add esp,byte +0x10
00030EE4  83EC0C            sub esp,byte +0xc
00030EE7  683F130300        push dword 0x3133f
00030EEC  E87FF7FFFF        call dword 0x30670
00030EF1  83C410            add esp,byte +0x10
00030EF4  90                nop
00030EF5  C9                leave
00030EF6  C3                ret
00030EF7  55                push ebp
00030EF8  89E5              mov ebp,esp
00030EFA  83EC18            sub esp,byte +0x18
00030EFD  83EC0C            sub esp,byte +0xc
00030F00  6844130300        push dword 0x31344
00030F05  E866F7FFFF        call dword 0x30670
00030F0A  83C410            add esp,byte +0x10
00030F0D  C745F400BA0300    mov dword [ebp-0xc],0x3ba00
00030F14  8B45F4            mov eax,[ebp-0xc]
00030F17  66C740482800      mov word [eax+0x48],0x28
00030F1D  8B45F4            mov eax,[ebp-0xc]
00030F20  83C04A            add eax,byte +0x4a
00030F23  83EC04            sub esp,byte +0x4
00030F26  6A08              push byte +0x8
00030F28  6868AD0300        push dword 0x3ad68
00030F2D  50                push eax
00030F2E  E8DDF7FFFF        call dword 0x30710
00030F33  83C410            add esp,byte +0x10
00030F36  8B45F4            mov eax,[ebp-0xc]
00030F39  C6404FB8          mov byte [eax+0x4f],0xb8
00030F3D  8B45F4            mov eax,[ebp-0xc]
00030F40  83C052            add eax,byte +0x52
00030F43  83EC04            sub esp,byte +0x4
00030F46  6A08              push byte +0x8
00030F48  6870AD0300        push dword 0x3ad70
00030F4D  50                push eax
00030F4E  E8BDF7FFFF        call dword 0x30710
00030F53  83C410            add esp,byte +0x10
00030F56  8B45F4            mov eax,[ebp-0xc]
00030F59  C64057B2          mov byte [eax+0x57],0xb2
00030F5D  8B45F4            mov eax,[ebp-0xc]
00030F60  C7403805000000    mov dword [eax+0x38],0x5
00030F67  8B45F4            mov eax,[ebp-0xc]
00030F6A  C7400C0D000000    mov dword [eax+0xc],0xd
00030F71  8B45F4            mov eax,[ebp-0xc]
00030F74  C740080D000000    mov dword [eax+0x8],0xd
00030F7B  8B45F4            mov eax,[ebp-0xc]
00030F7E  C740040D000000    mov dword [eax+0x4],0xd
00030F85  8B45F4            mov eax,[ebp-0xc]
00030F88  C740440D000000    mov dword [eax+0x44],0xd
00030F8F  8B45F4            mov eax,[ebp-0xc]
00030F92  C70019000000      mov dword [eax],0x19
00030F98  BACF0F0300        mov edx,0x30fcf
00030F9D  8B45F4            mov eax,[ebp-0xc]
00030FA0  895034            mov [eax+0x34],edx
00030FA3  B8602D0300        mov eax,0x32d60
00030FA8  8D9000800000      lea edx,[eax+0x8000]
00030FAE  8B45F4            mov eax,[ebp-0xc]
00030FB1  895040            mov [eax+0x40],edx
00030FB4  8B45F4            mov eax,[ebp-0xc]
00030FB7  C7403C02120000    mov dword [eax+0x3c],0x1202
00030FBE  C705E0B9030000BA  mov dword [dword 0x3b9e0],0x3ba00
         -0300
00030FC8  E8EBF5FFFF        call dword 0x305b8
00030FCD  EBFE              jmp short 0x30fcd
00030FCF  55                push ebp
00030FD0  89E5              mov ebp,esp
00030FD2  83EC18            sub esp,byte +0x18
00030FD5  C745F400000000    mov dword [ebp-0xc],0x0
00030FDC  83EC0C            sub esp,byte +0xc
00030FDF  6864130300        push dword 0x31364
00030FE4  E887F6FFFF        call dword 0x30670
00030FE9  83C410            add esp,byte +0x10
00030FEC  8B45F4            mov eax,[ebp-0xc]
00030FEF  8D5001            lea edx,[eax+0x1]
00030FF2  8955F4            mov [ebp-0xc],edx
00030FF5  83EC0C            sub esp,byte +0xc
00030FF8  50                push eax
00030FF9  E807F8FFFF        call dword 0x30805
00030FFE  83C410            add esp,byte +0x10
00031001  83EC0C            sub esp,byte +0xc
00031004  6866130300        push dword 0x31366
00031009  E862F6FFFF        call dword 0x30670
0003100E  83C410            add esp,byte +0x10
00031011  83EC0C            sub esp,byte +0xc
00031014  68F4010000        push dword 0x1f4
00031019  E80EF8FFFF        call dword 0x3082c
0003101E  83C410            add esp,byte +0x10
00031021  EBB9              jmp short 0x30fdc
00031023  0000              add [eax],al
00031025  0000              add [eax],al
00031027  0000              add [eax],al
00031029  0000              add [eax],al
0003102B  0000              add [eax],al
0003102D  0000              add [eax],al
0003102F  0000              add [eax],al
00031031  0000              add [eax],al
00031033  0000              add [eax],al
00031035  0000              add [eax],al
00031037  0000              add [eax],al
00031039  0000              add [eax],al
0003103B  0000              add [eax],al
0003103D  0000              add [eax],al
0003103F  000A              add [edx],cl
00031041  0A0A              or cl,[edx]
00031043  0A0A              or cl,[edx]
00031045  0A0A              or cl,[edx]
00031047  0A0A              or cl,[edx]
00031049  0A0A              or cl,[edx]
0003104B  0A0A              or cl,[edx]
0003104D  0A0A              or cl,[edx]
0003104F  2D2D2D2D2D        sub eax,0x2d2d2d2d
00031054  226373            and ah,[ebx+0x73]
00031057  7461              jz 0x310ba
00031059  7274              jc 0x310cf
0003105B  2220              and ah,[eax]
0003105D  626567            bound esp,[ebp+0x67]
00031060  696E732D2D2D2D    imul ebp,[esi+0x73],dword 0x2d2d2d2d
00031067  2D0A002D2D        sub eax,0x2d2d000a
0003106C  2D2D2D2263        sub eax,0x63222d2d
00031071  7374              jnc 0x310e7
00031073  61                popad
00031074  7274              jc 0x310ea
00031076  2220              and ah,[eax]
00031078  656E              gs outsb
0003107A  64732D            fs jnc 0x310aa
0003107D  2D2D2D0A00        sub eax,0xa2d2d
00031082  0000              add [eax],al
00031084  0000              add [eax],al
00031086  0000              add [eax],al
00031088  0000              add [eax],al
0003108A  0000              add [eax],al
0003108C  0000              add [eax],al
0003108E  0000              add [eax],al
00031090  0000              add [eax],al
00031092  0000              add [eax],al
00031094  0000              add [eax],al
00031096  0000              add [eax],al
00031098  0000              add [eax],al
0003109A  0000              add [eax],al
0003109C  0000              add [eax],al
0003109E  0000              add [eax],al
000310A0  2000              and [eax],al
000310A2  45                inc ebp
000310A3  7863              js 0x31108
000310A5  657074            gs jo 0x3111c
000310A8  696F6E21202D2D    imul ebp,[edi+0x6e],dword 0x2d2d2021
000310AF  3E2000            and [ds:eax],al
000310B2  0A0A              or cl,[edx]
000310B4  004546            add [ebp+0x46],al
000310B7  4C                dec esp
000310B8  41                inc ecx
000310B9  47                inc edi
000310BA  53                push ebx
000310BB  3A00              cmp al,[eax]
000310BD  43                inc ebx
000310BE  53                push ebx
000310BF  3A00              cmp al,[eax]
000310C1  45                inc ebp
000310C2  49                dec ecx
000310C3  50                push eax
000310C4  3A00              cmp al,[eax]
000310C6  45                inc ebp
000310C7  7272              jc 0x3113b
000310C9  6F                outsd
000310CA  7220              jc 0x310ec
000310CC  636F64            arpl [edi+0x64],bp
000310CF  653A00            cmp al,[gs:eax]
000310D2  23444520          and eax,[ebp+eax*2+0x20]
000310D6  44                inc esp
000310D7  69766964652045    imul esi,[esi+0x69],dword 0x45206564
000310DE  7272              jc 0x31152
000310E0  6F                outsd
000310E1  7200              jc 0x310e3
000310E3  23444220          and eax,[edx+eax*2+0x20]
000310E7  52                push edx
000310E8  45                inc ebp
000310E9  53                push ebx
000310EA  45                inc ebp
000310EB  52                push edx
000310EC  56                push esi
000310ED  45                inc ebp
000310EE  44                inc esp
000310EF  002D2D20204E      add [dword 0x4e20202d],ch
000310F5  4D                dec ebp
000310F6  49                dec ecx
000310F7  20496E            and [ecx+0x6e],cl
000310FA  7465              jz 0x31161
000310FC  7272              jc 0x31170
000310FE  7570              jnz 0x31170
00031100  7400              jz 0x31102
00031102  234250            and eax,[edx+0x50]
00031105  204272            and [edx+0x72],al
00031108  6561              gs popad
0003110A  6B706F69          imul esi,[eax+0x6f],byte +0x69
0003110E  6E                outsb
0003110F  7400              jz 0x31111
00031111  234F46            and ecx,[edi+0x46]
00031114  204F76            and [edi+0x76],cl
00031117  657266            gs jc 0x31180
0003111A  6C                insb
0003111B  6F                outsd
0003111C  7700              ja 0x3111e
0003111E  234252            and eax,[edx+0x52]
00031121  20424F            and [edx+0x4f],al
00031124  55                push ebp
00031125  4E                dec esi
00031126  44                inc esp
00031127  205261            and [edx+0x61],dl
0003112A  6E                outsb
0003112B  6765204578        and [gs:di+0x78],al
00031130  636565            arpl [ebp+0x65],sp
00031133  6465640000        add [fs:eax],al
00031138  235544            and edx,[ebp+0x44]
0003113B  20496E            and [ecx+0x6e],cl
0003113E  7661              jna 0x311a1
00031140  6C                insb
00031141  6964204F70636F64  imul esp,[eax+0x4f],dword 0x646f6370
00031149  652028            and [gs:eax],ch
0003114C  55                push ebp
0003114D  6E                outsb
0003114E  646566696E656420  imul bp,[gs:esi+0x65],word 0x2064
00031156  4F                dec edi
00031157  7063              jo 0x311bc
00031159  6F                outsd
0003115A  64652900          sub [gs:eax],eax
0003115E  0000              add [eax],al
00031160  234E4D            and ecx,[esi+0x4d]
00031163  20446576          and [ebp+0x76],al
00031167  696365204E6F74    imul esp,[ebx+0x65],dword 0x746f4e20
0003116E  204176            and [ecx+0x76],al
00031171  61                popad
00031172  696C61626C652028  imul ebp,[ecx+0x62],dword 0x2820656c
0003117A  4E                dec esi
0003117B  6F                outsd
0003117C  204D61            and [ebp+0x61],cl
0003117F  7468              jz 0x311e9
00031181  20436F            and [ebx+0x6f],al
00031184  7072              jo 0x311f8
00031186  6F                outsd
00031187  636573            arpl [ebp+0x73],sp
0003118A  736F              jnc 0x311fb
0003118C  7229              jc 0x311b7
0003118E  0023              add [ebx],ah
00031190  44                inc esp
00031191  46                inc esi
00031192  20446F75          and [edi+ebp*2+0x75],al
00031196  626C6520          bound ebp,[ebp+0x20]
0003119A  46                inc esi
0003119B  61                popad
0003119C  756C              jnz 0x3120a
0003119E  7400              jz 0x311a0
000311A0  2020              and [eax],ah
000311A2  2020              and [eax],ah
000311A4  43                inc ebx
000311A5  6F                outsd
000311A6  7072              jo 0x3121a
000311A8  6F                outsd
000311A9  636573            arpl [ebp+0x73],sp
000311AC  736F              jnc 0x3121d
000311AE  7220              jc 0x311d0
000311B0  53                push ebx
000311B1  65676D            gs a16 insd
000311B4  656E              gs outsb
000311B6  7420              jz 0x311d8
000311B8  4F                dec edi
000311B9  7665              jna 0x31220
000311BB  7272              jc 0x3122f
000311BD  756E              jnz 0x3122d
000311BF  2028              and [eax],ch
000311C1  7265              jc 0x31228
000311C3  7365              jnc 0x3122a
000311C5  7276              jc 0x3123d
000311C7  65642900          sub [fs:eax],eax
000311CB  23545320          and edx,[ebx+edx*2+0x20]
000311CF  49                dec ecx
000311D0  6E                outsb
000311D1  7661              jna 0x31234
000311D3  6C                insb
000311D4  6964205453530023  imul esp,[eax+0x54],dword 0x23005353
000311DC  4E                dec esi
000311DD  50                push eax
000311DE  205365            and [ebx+0x65],dl
000311E1  676D              a16 insd
000311E3  656E              gs outsb
000311E5  7420              jz 0x31207
000311E7  4E                dec esi
000311E8  6F                outsd
000311E9  7420              jz 0x3120b
000311EB  50                push eax
000311EC  7265              jc 0x31253
000311EE  7365              jnc 0x31255
000311F0  6E                outsb
000311F1  7400              jz 0x311f3
000311F3  235353            and edx,[ebx+0x53]
000311F6  205374            and [ebx+0x74],dl
000311F9  61                popad
000311FA  636B2D            arpl [ebx+0x2d],bp
000311FD  53                push ebx
000311FE  65676D            gs a16 insd
00031201  656E              gs outsb
00031203  7420              jz 0x31225
00031205  46                inc esi
00031206  61                popad
00031207  756C              jnz 0x31275
00031209  7400              jz 0x3120b
0003120B  234750            and eax,[edi+0x50]
0003120E  204765            and [edi+0x65],al
00031211  6E                outsb
00031212  657261            gs jc 0x31276
00031215  6C                insb
00031216  205072            and [eax+0x72],dl
00031219  6F                outsd
0003121A  7465              jz 0x31281
0003121C  6374696F          arpl [ecx+ebp*2+0x6f],si
00031220  6E                outsb
00031221  0023              add [ebx],ah
00031223  50                push eax
00031224  46                inc esi
00031225  205061            and [eax+0x61],dl
00031228  6765204661        and [gs:bp+0x61],al
0003122D  756C              jnz 0x3129b
0003122F  7400              jz 0x31231
00031231  0000              add [eax],al
00031233  002D2D202028      add [dword 0x2820202d],ch
00031239  49                dec ecx
0003123A  6E                outsb
0003123B  7465              jz 0x312a2
0003123D  6C                insb
0003123E  207265            and [edx+0x65],dh
00031241  7365              jnc 0x312a8
00031243  7276              jc 0x312bb
00031245  65642E20446F20    and [cs:edi+ebp*2+0x20],al
0003124C  6E                outsb
0003124D  6F                outsd
0003124E  7420              jz 0x31270
00031250  7573              jnz 0x312c5
00031252  652E2900          sub [cs:eax],eax
00031256  0000              add [eax],al
00031258  234D46            and ecx,[ebp+0x46]
0003125B  207838            and [eax+0x38],bh
0003125E  37                aaa
0003125F  204650            and [esi+0x50],al
00031262  55                push ebp
00031263  20466C            and [esi+0x6c],al
00031266  6F                outsd
00031267  61                popad
00031268  7469              jz 0x312d3
0003126A  6E                outsb
0003126B  672D506F696E      sub eax,0x6e696f50
00031271  7420              jz 0x31293
00031273  45                inc ebp
00031274  7272              jc 0x312e8
00031276  6F                outsd
00031277  7220              jc 0x31299
00031279  284D61            sub [ebp+0x61],cl
0003127C  7468              jz 0x312e6
0003127E  204661            and [esi+0x61],al
00031281  756C              jnz 0x312ef
00031283  7429              jz 0x312ae
00031285  0023              add [ebx],ah
00031287  41                inc ecx
00031288  43                inc ebx
00031289  20416C            and [ecx+0x6c],al
0003128C  69676E6D656E74    imul esp,[edi+0x6e],dword 0x746e656d
00031293  204368            and [ebx+0x68],al
00031296  65636B00          arpl [gs:ebx+0x0],bp
0003129A  234D43            and ecx,[ebp+0x43]
0003129D  204D61            and [ebp+0x61],cl
000312A0  636869            arpl [eax+0x69],bp
000312A3  6E                outsb
000312A4  65204368          and [gs:ebx+0x68],al
000312A8  65636B00          arpl [gs:ebx+0x0],bp
000312AC  235846            and ebx,[eax+0x46]
000312AF  205349            and [ebx+0x49],dl
000312B2  4D                dec ebp
000312B3  44                inc esp
000312B4  20466C            and [esi+0x6c],al
000312B7  6F                outsd
000312B8  61                popad
000312B9  7469              jz 0x31324
000312BB  6E                outsb
000312BC  672D506F696E      sub eax,0x6e696f50
000312C2  7420              jz 0x312e4
000312C4  45                inc ebp
000312C5  7863              js 0x3132a
000312C7  657074            gs jo 0x3133e
000312CA  696F6E00000000    imul ebp,[edi+0x6e],dword 0x0
000312D1  0000              add [eax],al
000312D3  0000              add [eax],al
000312D5  0000              add [eax],al
000312D7  0000              add [eax],al
000312D9  0000              add [eax],al
000312DB  0000              add [eax],al
000312DD  0000              add [eax],al
000312DF  00D2              add dl,dl
000312E1  1003              adc [ebx],al
000312E3  00E3              add bl,ah
000312E5  1003              adc [ebx],al
000312E7  00F0              add al,dh
000312E9  1003              adc [ebx],al
000312EB  0002              add [edx],al
000312ED  1103              adc [ebx],eax
000312EF  0011              add [ecx],dl
000312F1  1103              adc [ebx],eax
000312F3  001E              add [esi],bl
000312F5  1103              adc [ebx],eax
000312F7  0038              add [eax],bh
000312F9  1103              adc [ebx],eax
000312FB  006011            add [eax+0x11],ah
000312FE  0300              add eax,[eax]
00031300  8F                db 0x8f
00031301  1103              adc [ebx],eax
00031303  00A0110300CB      add [eax-0x34fffcef],ah
00031309  1103              adc [ebx],eax
0003130B  00DB              add bl,bl
0003130D  1103              adc [ebx],eax
0003130F  00F3              add bl,dh
00031311  1103              adc [ebx],eax
00031313  000B              add [ebx],cl
00031315  1203              adc al,[ebx]
00031317  0022              add [edx],ah
00031319  1203              adc al,[ebx]
0003131B  003412            add [edx+edx],dh
0003131E  0300              add eax,[eax]
00031320  58                pop eax
00031321  1203              adc al,[ebx]
00031323  00861203009A      add [esi-0x65fffcee],al
00031329  1203              adc al,[ebx]
0003132B  00AC1203007370    add [edx+edx+0x70730003],ch
00031332  7572              jnz 0x313a6
00031334  696F75735F6972    imul ebp,[edi+0x75],dword 0x72695f73
0003133B  713A              jno 0x31377
0003133D  2000              and [eax],al
0003133F  0A00              or al,[eax]
00031341  0000              add [eax],al
00031343  002D2D2D2D2D      add [dword 0x2d2d2d2d],ch
00031349  226B65            and ch,[ebx+0x65]
0003134C  726E              jc 0x313bc
0003134E  656C              gs insb
00031350  5F                pop edi
00031351  6D                insd
00031352  61                popad
00031353  696E2220626567    imul ebp,[esi+0x22],dword 0x67656220
0003135A  696E732D2D2D2D    imul ebp,[esi+0x73],dword 0x2d2d2d2d
00031361  2D0A004100        sub eax,0x41000a
00031366  2E001400          add [cs:eax+eax],dl
0003136A  0000              add [eax],al
0003136C  0000              add [eax],al
0003136E  0000              add [eax],al
00031370  017A52            add [edx+0x52],edi
00031373  0001              add [ecx],al
00031375  7C08              jl 0x3137f
00031377  011B              add [ebx],ebx
00031379  0C04              or al,0x4
0003137B  0488              add al,0x88
0003137D  0100              add [eax],eax
0003137F  001C00            add [eax+eax],bl
00031382  0000              add [eax],al
00031384  1C00              sbb al,0x0
00031386  0000              add [eax],al
00031388  4F                dec edi
00031389  F2                repne
0003138A  FF                db 0xff
0003138B  FF9700000000      call dword [edi+0x0]
00031391  41                inc ecx
00031392  0E                push cs
00031393  088502420D05      or [ebp+0x50d4202],al
00031399  0293C50C0404      add dl,[ebx+0x4040cc5]
0003139F  001C00            add [eax+eax],bl
000313A2  0000              add [eax],al
000313A4  3C00              cmp al,0x0
000313A6  0000              add [eax],al
000313A8  B2F3              mov dl,0xf3
000313AA  FF                db 0xff
000313AB  FFAB00000000      jmp dword far [ebx+0x0]
000313B1  41                inc ecx
000313B2  0E                push cs
000313B3  088502420D05      or [ebp+0x50d4202],al
000313B9  02A7C50C0404      add ah,[edi+0x4040cc5]
000313BF  001C00            add [eax+eax],bl
000313C2  0000              add [eax],al
000313C4  5C                pop esp
000313C5  0000              add [eax],al
000313C7  003DF4FFFF27      add [dword 0x27fffff4],bh
000313CD  0000              add [eax],al
000313CF  0000              add [eax],al
000313D1  41                inc ecx
000313D2  0E                push cs
000313D3  088502420D05      or [ebp+0x50d4202],al
000313D9  63C5              arpl bp,ax
000313DB  0C04              or al,0x4
000313DD  0400              add al,0x0
000313DF  001C00            add [eax+eax],bl
000313E2  0000              add [eax],al
000313E4  7C00              jl 0x313e6
000313E6  0000              add [eax],al
000313E8  44                inc esp
000313E9  F4                hlt
000313EA  FF                db 0xff
000313EB  FF4700            inc dword [edi+0x0]
000313EE  0000              add [eax],al
000313F0  00410E            add [ecx+0xe],al
000313F3  088502420D05      or [ebp+0x50d4202],al
000313F9  0243C5            add al,[ebx-0x3b]
000313FC  0C04              or al,0x4
000313FE  0400              add al,0x0
00031400  1C00              sbb al,0x0
00031402  0000              add [eax],al
00031404  9C                pushfd
00031405  0000              add [eax],al
00031407  006BF4            add [ebx-0xc],ch
0003140A  FF                db 0xff
0003140B  FF                db 0xff
0003140C  3E0300            add eax,[ds:eax]
0003140F  0000              add [eax],al
00031411  41                inc ecx
00031412  0E                push cs
00031413  088502420D05      or [ebp+0x50d4202],al
00031419  033A              add edi,[edx]
0003141B  03C5              add eax,ebp
0003141D  0C04              or al,0x4
0003141F  041C              add al,0x1c
00031421  0000              add [eax],al
00031423  00BC00000089F7    add [eax+eax-0x8770000],bh
0003142A  FF                db 0xff
0003142B  FF4F00            dec dword [edi+0x0]
0003142E  0000              add [eax],al
00031430  00410E            add [ecx+0xe],al
00031433  088502420D05      or [ebp+0x50d4202],al
00031439  024BC5            add cl,[ebx-0x3b]
0003143C  0C04              or al,0x4
0003143E  0400              add al,0x0
00031440  1C00              sbb al,0x0
00031442  0000              add [eax],al
00031444  DC00              fadd qword [eax]
00031446  0000              add [eax],al
00031448  B8F7FFFF6D        mov eax,0x6dfffff7
0003144D  0000              add [eax],al
0003144F  0000              add [eax],al
00031451  41                inc ecx
00031452  0E                push cs
00031453  088502420D05      or [ebp+0x50d4202],al
00031459  0269C5            add ch,[ecx-0x3b]
0003145C  0C04              or al,0x4
0003145E  0400              add al,0x0
00031460  2C00              sub al,0x0
00031462  0000              add [eax],al
00031464  FC                cld
00031465  0000              add [eax],al
00031467  0005F8FFFF2E      add [dword 0x2efffff8],al
0003146D  0100              add [eax],eax
0003146F  0000              add [eax],al
00031471  41                inc ecx
00031472  0E                push cs
00031473  088502420D05      or [ebp+0x50d4202],al
00031479  46                inc esi
0003147A  8703              xchg eax,[ebx]
0003147C  860483            xchg al,[ebx+eax*4]
0003147F  05032101C3        add eax,0xc3012103
00031484  41                inc ecx
00031485  C641C741          mov byte [ecx-0x39],0x41
00031489  C50C04            lds ecx,[esp+eax]
0003148C  0400              add al,0x0
0003148E  0000              add [eax],al
00031490  1C00              sbb al,0x0
00031492  0000              add [eax],al
00031494  2C01              sub al,0x1
00031496  0000              add [eax],al
00031498  03F9              add edi,ecx
0003149A  FF                db 0xff
0003149B  FF7100            push dword [ecx+0x0]
0003149E  0000              add [eax],al
000314A0  00410E            add [ecx+0xe],al
000314A3  088502420D05      or [ebp+0x50d4202],al
000314A9  026DC5            add ch,[ebp-0x3b]
000314AC  0C04              or al,0x4
000314AE  0400              add al,0x0
000314B0  1C00              sbb al,0x0
000314B2  0000              add [eax],al
000314B4  4C                dec esp
000314B5  0100              add [eax],eax
000314B7  0054F9FF          add [ecx+edi*8-0x1],dl
000314BB  FFB40000000041    push dword [eax+eax+0x41000000]
000314C2  0E                push cs
000314C3  088502420D05      or [ebp+0x50d4202],al
000314C9  02B0C50C0404      add dh,[eax+0x4040cc5]
000314CF  001C00            add [eax+eax],bl
000314D2  0000              add [eax],al
000314D4  6C                insb
000314D5  0100              add [eax],eax
000314D7  00E8              add al,ch
000314D9  F9                stc
000314DA  FF                db 0xff
000314DB  FF37              push dword [edi]
000314DD  0000              add [eax],al
000314DF  0000              add [eax],al
000314E1  41                inc ecx
000314E2  0E                push cs
000314E3  088502420D05      or [ebp+0x50d4202],al
000314E9  73C5              jnc 0x314b0
000314EB  0C04              or al,0x4
000314ED  0400              add al,0x0
000314EF  0018              add [eax],bl
000314F1  0000              add [eax],al
000314F3  008C010000FFF9    add [ecx+eax-0x6010000],cl
000314FA  FF                db 0xff
000314FB  FF                db 0xff
000314FC  D800              fadd dword [eax]
000314FE  0000              add [eax],al
00031500  00410E            add [ecx+0xe],al
00031503  088502420D05      or [ebp+0x50d4202],al
00031509  0000              add [eax],al
0003150B  0018              add [eax],bl
0003150D  0000              add [eax],al
0003150F  00A8010000BB      add [eax-0x44ffffff],ch
00031515  FA                cli
00031516  FF                db 0xff
00031517  FF540000          call dword [eax+eax+0x0]
0003151B  0000              add [eax],al
0003151D  41                inc ecx
0003151E  0E                push cs
0003151F  088502420D05      or [ebp+0x50d4202],al
00031525  0000              add [eax],al
00031527  004743            add [edi+0x43],al
0003152A  43                inc ebx
0003152B  3A20              cmp ah,[eax]
0003152D  285562            sub [ebp+0x62],dl
00031530  756E              jnz 0x315a0
00031532  7475              jz 0x315a9
00031534  20352E342E30      and [dword 0x302e342e],dh
0003153A  2D36756275        sub eax,0x75627536
0003153F  6E                outsb
00031540  7475              jz 0x315b7
00031542  317E31            xor [esi+0x31],edi
00031545  362E30342E        xor [cs:esi+ebp],dh
0003154A  3429              xor al,0x29
0003154C  20352E342E30      and [dword 0x302e342e],dh
00031552  2032              and [edx],dh
00031554  3031              xor [ecx],dh
00031556  363036            xor [ss:esi],dh
00031559  3039              xor [ecx],bh
0003155B  0000              add [eax],al
0003155D  2E7368            cs jnc 0x315c8
00031560  7374              jnc 0x315d6
00031562  7274              jc 0x315d8
00031564  61                popad
00031565  6200              bound eax,[eax]
00031567  2E7465            cs jz 0x315cf
0003156A  7874              js 0x315e0
0003156C  002E              add [esi],ch
0003156E  726F              jc 0x315df
00031570  6461              fs popad
00031572  7461              jz 0x315d5
00031574  002E              add [esi],ch
00031576  65685F667261      gs push dword 0x6172665f
0003157C  6D                insd
0003157D  65002E            add [gs:esi],ch
00031580  62                db 0x62
00031581  7373              jnc 0x315f6
00031583  002E              add [esi],ch
00031585  636F6D            arpl [edi+0x6d],bp
00031588  6D                insd
00031589  656E              gs outsb
0003158B  7400              jz 0x3158d
0003158D  0000              add [eax],al
0003158F  0000              add [eax],al
00031591  0000              add [eax],al
00031593  0000              add [eax],al
00031595  0000              add [eax],al
00031597  0000              add [eax],al
00031599  0000              add [eax],al
0003159B  0000              add [eax],al
0003159D  0000              add [eax],al
0003159F  0000              add [eax],al
000315A1  0000              add [eax],al
000315A3  0000              add [eax],al
000315A5  0000              add [eax],al
000315A7  0000              add [eax],al
000315A9  0000              add [eax],al
000315AB  0000              add [eax],al
000315AD  0000              add [eax],al
000315AF  0000              add [eax],al
000315B1  0000              add [eax],al
000315B3  0000              add [eax],al
000315B5  0000              add [eax],al
000315B7  000B              add [ebx],cl
000315B9  0000              add [eax],al
000315BB  0001              add [ecx],al
000315BD  0000              add [eax],al
000315BF  0006              add [esi],al
000315C1  0000              add [eax],al
000315C3  0000              add [eax],al
000315C5  0403              add al,0x3
000315C7  0000              add [eax],al
000315C9  0400              add al,0x0
000315CB  0023              add [ebx],ah
000315CD  0C00              or al,0x0
000315CF  0000              add [eax],al
000315D1  0000              add [eax],al
000315D3  0000              add [eax],al
000315D5  0000              add [eax],al
000315D7  0010              add [eax],dl
000315D9  0000              add [eax],al
000315DB  0000              add [eax],al
000315DD  0000              add [eax],al
000315DF  0011              add [ecx],dl
000315E1  0000              add [eax],al
000315E3  0001              add [ecx],al
000315E5  0000              add [eax],al
000315E7  0002              add [edx],al
000315E9  0000              add [eax],al
000315EB  004010            add [eax+0x10],al
000315EE  0300              add eax,[eax]
000315F0  40                inc eax
000315F1  1000              adc [eax],al
000315F3  0028              add [eax],ch
000315F5  0300              add eax,[eax]
000315F7  0000              add [eax],al
000315F9  0000              add [eax],al
000315FB  0000              add [eax],al
000315FD  0000              add [eax],al
000315FF  0020              add [eax],ah
00031601  0000              add [eax],al
00031603  0000              add [eax],al
00031605  0000              add [eax],al
00031607  0019              add [ecx],bl
00031609  0000              add [eax],al
0003160B  0001              add [ecx],al
0003160D  0000              add [eax],al
0003160F  0002              add [edx],al
00031611  0000              add [eax],al
00031613  006813            add [eax+0x13],ch
00031616  0300              add eax,[eax]
00031618  68130000C0        push dword 0xc0000013
0003161D  0100              add [eax],eax
0003161F  0000              add [eax],al
00031621  0000              add [eax],al
00031623  0000              add [eax],al
00031625  0000              add [eax],al
00031627  000400            add [eax+eax],al
0003162A  0000              add [eax],al
0003162C  0000              add [eax],al
0003162E  0000              add [eax],al
00031630  2300              and eax,[eax]
00031632  0000              add [eax],al
00031634  0800              or [eax],al
00031636  0000              add [eax],al
00031638  0300              add eax,[eax]
0003163A  0000              add [eax],al
0003163C  40                inc eax
0003163D  2503004015        and eax,0x15400003
00031642  0000              add [eax],al
00031644  309500000000      xor [ebp+0x0],dl
0003164A  0000              add [eax],al
0003164C  0000              add [eax],al
0003164E  0000              add [eax],al
00031650  2000              and [eax],al
00031652  0000              add [eax],al
00031654  0000              add [eax],al
00031656  0000              add [eax],al
00031658  2800              sub [eax],al
0003165A  0000              add [eax],al
0003165C  0100              add [eax],eax
0003165E  0000              add [eax],al
00031660  3000              xor [eax],al
00031662  0000              add [eax],al
00031664  0000              add [eax],al
00031666  0000              add [eax],al
00031668  281500003400      sub [dword 0x340000],dl
0003166E  0000              add [eax],al
00031670  0000              add [eax],al
00031672  0000              add [eax],al
00031674  0000              add [eax],al
00031676  0000              add [eax],al
00031678  0100              add [eax],eax
0003167A  0000              add [eax],al
0003167C  0100              add [eax],eax
0003167E  0000              add [eax],al
00031680  0100              add [eax],eax
00031682  0000              add [eax],al
00031684  0300              add eax,[eax]
00031686  0000              add [eax],al
00031688  0000              add [eax],al
0003168A  0000              add [eax],al
0003168C  0000              add [eax],al
0003168E  0000              add [eax],al
00031690  5C                pop esp
00031691  1500003100        adc eax,0x310000
00031696  0000              add [eax],al
00031698  0000              add [eax],al
0003169A  0000              add [eax],al
0003169C  0000              add [eax],al
0003169E  0000              add [eax],al
000316A0  0100              add [eax],eax
000316A2  0000              add [eax],al
000316A4  0000              add [eax],al
000316A6  0000              add [eax],al
