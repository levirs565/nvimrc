if exists('g:GuiLoaded')
  GuiFont! JetBrainsMono NF:h9.75
  GuiTabline 0
  GuiPopupmenu 0
endif

if exists('g:fvim_loaded')
  set guifont=JetBrainsMono\ NF:h13
  FVimCustomTitleBar v:true   
  " FVimFontNoBuiltInSymbols v:true
  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontHintLevel 'full'
  FVimFontLigature v:true
  " can be 'default', '14.0', '-1.0' etc.
  FVimFontLineHeight '+1.2' 
  FVimFontNormalWeight 400
  FVimFontBoldWeight 700
  " Try to snap the fonts to the pixels, reduces blur
  " in some situations (e.g. 100% DPI).
  FVimFontSubpixel v:true
  FVimFontAutoSnap v:true
  FVimFontNoBuiltinSymbols v:true 
  " Disable built-in Nerd font symbols
  
  FVimUIPopupMenu v:false 
endif
