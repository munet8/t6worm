;-------------------------------------------------------------------------------
; �R���p�C���I�v�V����
#packopt name "t6worm.exe"
#packopt type 0
#packopt xsize 320
#packopt ysize 480
#pack "fon_cha1.png"
#pack "fon_cha2.png"

;-------------------------------------------------------------------------------

; �t�H���g�摜�̕����T�C�Y
#const global g_font_png_x 16
#const global g_font_png_y 32

; �t�H���g�T�C�Y�i�X�N���[���T�C�Y��j
;#const global g_font_x 12
;#const global g_font_y 24
g_font_x = ginfo_winx / 25
g_font_y = ginfo_winy / 20

; �X�N���[���T�C�Y
;#const global g_screen_x 320
;#const global g_screen_y 480
g_screen_x = ginfo_winx
g_screen_y = ginfo_winy

; �u�����h�� tan6��
g_tan6 = "tan6 "
poke g_tan6, 4, 127

#module
#defcfunc log10 int _x
	; log10(x)
	; ��p�ΐ��i�؎̂āj��Ԃ�
	if ( _x <= 0 ) {
		ret = 0
	} else {
		ret = int ( logf(_x) / logf(10) )
	}
	return ret
#global

#module
#deffunc fprint str _p1, int _alpha
	;	fprint "message"
	;	(�摜���g�p�����t�H���g�\�����s�Ȃ��܂�)
	;	"message" : �\�����郁�b�Z�[�W
	;	�\�����W�́Apos�Ŏw�肵���ʒu����
	;	���p�J�i�͑S�p�t�H���g�摜���ǂݎ��
	;
	i = 0: st = _p1
	fx = double( 1.0 * g_font_x@ / g_font_png_x@ )
	fy = double( 1.0 * g_font_y@ / g_font_png_y@ )

	gmode 5, 0, 0, _alpha

	repeat
		a1 = peek(st, i) :i++
		if a1 = 0 :break
		if a1 = 13 { ; ���s
			a1 = peek(st, i)
			if a1 = 10 :i++
			continue
		} else {
			if ( a1 & 128 ) {
				celput 3 , a1 - 160, fx, fy
			} else {
				celput 2 , a1 - 32, fx, fy
			}
		}
	loop

	return
#global
