;-------------------------------------------------------------------------------
; コンパイルオプション
#packopt name "t6worm.exe"
#packopt type 0
#packopt xsize 320
#packopt ysize 480
#pack "fon_cha1.png"
#pack "fon_cha2.png"

;-------------------------------------------------------------------------------

; フォント画像の分割サイズ
#const global g_font_png_x 16
#const global g_font_png_y 32

; フォントサイズ（スクリーンサイズ比）
;#const global g_font_x 12
;#const global g_font_y 24
g_font_x = ginfo_winx / 25
g_font_y = ginfo_winy / 20

; スクリーンサイズ
;#const global g_screen_x 320
;#const global g_screen_y 480
g_screen_x = ginfo_winx
g_screen_y = ginfo_winy

; ブランド名 tan6°
g_tan6 = "tan6 "
poke g_tan6, 4, 127

#module
#defcfunc log10 int _x
	; log10(x)
	; 常用対数（切捨て）を返す
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
	;	(画像を使用したフォント表示を行ないます)
	;	"message" : 表示するメッセージ
	;	表示座標は、posで指定した位置から
	;	半角カナは全角フォント画像より読み取る
	;
	i = 0: st = _p1
	fx = double( 1.0 * g_font_x@ / g_font_png_x@ )
	fy = double( 1.0 * g_font_y@ / g_font_png_y@ )

	gmode 5, 0, 0, _alpha

	repeat
		a1 = peek(st, i) :i++
		if a1 = 0 :break
		if a1 = 13 { ; 改行
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
