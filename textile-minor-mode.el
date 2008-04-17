Content-Type: text/enriched
Text-Width: 70

;;; <x-color><param>Firebrick</param>textile-mode.el --- Textile markup editing major mode

</x-color>

;; <x-color><param>Firebrick</param>Copyright (C) 2006 Free Software Foundation, Inc.

</x-color>

;; <x-color><param>Firebrick</param>Modified by Vadim Atlygin <<vadim.atlygin@gmail.com>

</x-color>

;; <x-color><param>Firebrick</param>Author: Julien Barnier <<julien@nozav.org>
</x-color>;; <x-color><param>Firebrick</param>$Id: textile-mode.el 6 2006-03-30 22:37:08Z juba $

</x-color>

;; <x-color><param>Firebrick</param>This file is free software; you can redistribute it and/or modify
</x-color>;; <x-color><param>Firebrick</param>it under the terms of the GNU General Public License as published by
</x-color>;; <x-color><param>Firebrick</param>the Free Software Foundation; either version 2, or (at your option)
</x-color>;; <x-color><param>Firebrick</param>any later version.

</x-color>

;; <x-color><param>Firebrick</param>This file is distributed in the hope that it will be useful,
</x-color>;; <x-color><param>Firebrick</param>but WITHOUT ANY WARRANTY; without even the implied warranty of
</x-color>;; <x-color><param>Firebrick</param>MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
</x-color>;; <x-color><param>Firebrick</param>GNU General Public License for more details.

</x-color>

;; <x-color><param>Firebrick</param>You should have received a copy of the GNU General Public License
</x-color>;; <x-color><param>Firebrick</param>along with GNU Emacs; see the file COPYING.	If not, write to
</x-color>;; <x-color><param>Firebrick</param>the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
</x-color>;; <x-color><param>Firebrick</param>Boston, MA 02111-1307, USA.

</x-color>

;;; <x-color><param>Firebrick</param>Commentary:

</x-color>

;;<x-color><param>Firebrick</param>

</x-color>


;; <x-color><param>Firebrick</param>Known bugs or limitations:

</x-color>

;; <x-color><param>Firebrick</param>- if several {style}, [lang] or (class) attributes are given for
</x-color>;;<x-color><param>Firebrick</param>	 the same block, only the first one of each type will be
</x-color>;;<x-color><param>Firebrick</param>	 highlighted.
</x-color>;;<x-color><param>Firebrick</param>
</x-color>;; <x-color><param>Firebrick</param>- some complex imbrications of inline markup and attributes are
</x-color>;;<x-color><param>Firebrick</param>	 not well-rendered (for example, *strong *{something}notstrong*)
</x-color>;;<x-color><param>Firebrick</param>

</x-color>


;;; <x-color><param>Firebrick</param>Code:

</x-color>



(<x-color><param>Purple</param>defvar</x-color> <x-color><param>DarkGoldenrod</param>textile-mode-map</x-color>
  (<x-color><param>Purple</param>let</x-color> ((map (make-sparse-keymap)))
	(define-key map [foo] 'textile-do-foo)
	map)
  "Keymap for `<x-color><param>CadetBlue</param>textile-mode</x-color>'.")



(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-re-concat</x-color> (l)
  "Concatenate the elements of a list with a \\| separator and
non-matching parentheses"
  (concat
   <x-color><param>RosyBrown</param>"</x-color><x-color><param>RosyBrown</param>\\(?:</x-color><x-color><param>RosyBrown</param>"</x-color>
   (mapconcat 'identity l <x-color><param>RosyBrown</param>"</x-color><x-color><param>RosyBrown</param>\\|</x-color><x-color><param>RosyBrown</param>"</x-color>)
   <x-color><param>RosyBrown</param>"</x-color><x-color><param>RosyBrown</param>\\)</x-color><x-color><param>RosyBrown</param>"</x-color>))



(setq textile-attributes
	  '(<x-color><param>RosyBrown</param>"{[</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>}]*}"</x-color> <x-color><param>RosyBrown</param>"([</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>)]*)"</x-color> <x-color><param>RosyBrown</param>"\\[[</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>]]*\\]"</x-color>))


(setq textile-blocks
	  '(<x-color><param>RosyBrown</param>"^h1"</x-color> <x-color><param>RosyBrown</param>"^h2"</x-color> <x-color><param>RosyBrown</param>"^h3"</x-color> <x-color><param>RosyBrown</param>"^h4"</x-color> <x-color><param>RosyBrown</param>"^h5"</x-color> <x-color><param>RosyBrown</param>"^h6"</x-color> <x-color><param>RosyBrown</param>"^p"</x-color> <x-color><param>RosyBrown</param>"^bq"</x-color> <x-color><param>RosyBrown</param>"^fn[0-9]+"</x-color> <x-color><param>RosyBrown</param>"^#+ "</x-color> <x-color><param>RosyBrown</param>"^\\*+ "</x-color> <x-color><param>RosyBrown</param>"^table"</x-color>))


(setq textile-inline-markup
	  '(<x-color><param>RosyBrown</param>"\\*"</x-color> <x-color><param>RosyBrown</param>"\\*\\*"</x-color> <x-color><param>RosyBrown</param>"_"</x-color> <x-color><param>RosyBrown</param>"__"</x-color> <x-color><param>RosyBrown</param>"\\?\\?"</x-color> <x-color><param>RosyBrown</param>"@"</x-color> <x-color><param>RosyBrown</param>"-"</x-color> <x-color><param>RosyBrown</param>"\\+"</x-color> <x-color><param>RosyBrown</param>"^"</x-color> <x-color><param>RosyBrown</param>"~"</x-color> <x-color><param>RosyBrown</param>"%"</x-color>))


(setq textile-alignments
	  '( <x-color><param>RosyBrown</param>"<<>"</x-color> <x-color><param>RosyBrown</param>"<<"</x-color> <x-color><param>RosyBrown</param>">"</x-color> <x-color><param>RosyBrown</param>"="</x-color> <x-color><param>RosyBrown</param>"(+"</x-color> <x-color><param>RosyBrown</param>")+"</x-color>))


(setq textile-table-alignments
	  '( <x-color><param>RosyBrown</param>"<<>"</x-color> <x-color><param>RosyBrown</param>"<<"</x-color> <x-color><param>RosyBrown</param>">"</x-color> <x-color><param>RosyBrown</param>"="</x-color> <x-color><param>RosyBrown</param>"_"</x-color> <x-color><param>RosyBrown</param>"\\^"</x-color> <x-color><param>RosyBrown</param>"~"</x-color> <x-color><param>RosyBrown</param>"\\\\[</x-color><x-color><param>CadetBlue</param><x-color><param>RosyBrown</param>0-9</x-color></x-color><x-color><param>RosyBrown</param>]+"</x-color> <x-color><param>RosyBrown</param>"/[0-9]+"</x-color>))


; <x-color><param>Firebrick</param>from gnus-button-url-regexp
</x-color>(setq textile-url-regexp <x-color><param>RosyBrown</param>"\\b\\(\\(www\\.\\|\\(s?https?\\|ftp\\|file\\|gopher\\|nntp\\|news\\|telnet\\|wais\\|mailto\\|info\\):\\)\\(//[-a-z0-9_.]+:[0-9]*\\)?[-a-z0-9_=!?#$@~%&*+\\/:;.,[:word:]]+[-a-z0-9_=#$@~%&*+\\/[:word:]]\\)"</x-color>)



(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-block-matcher</x-color> (bloc)
  "Return the matcher regexp for a block element"
  (concat
   <x-color><param>RosyBrown</param>"^"</x-color>
   bloc
   (textile-re-concat textile-alignments) <x-color><param>RosyBrown</param>"?"</x-color>
   (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color>
   <x-color><param>RosyBrown</param>"\\. "</x-color>
   <x-color><param>RosyBrown</param>"\\(\\(?:.\\|\n\\)*?\\)\n\n"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-attribute-matcher</x-color> (attr-start attr-end)
  "Return the matcher regexp for an attribute"
  (concat
   (textile-re-concat (append textile-blocks textile-inline-markup))
   (textile-re-concat textile-alignments) <x-color><param>RosyBrown</param>"*"</x-color>
   (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color>
   <x-color><param>RosyBrown</param>"\\("</x-color> attr-start <x-color><param>RosyBrown</param>"[^"</x-color>
   (<x-color><param>Purple</param>if</x-color> (string-equal attr-end <x-color><param>RosyBrown</param>"\\]"</x-color>) <x-color><param>RosyBrown</param>"]"</x-color> attr-end)
   <x-color><param>RosyBrown</param>"]*"</x-color> attr-end <x-color><param>RosyBrown</param>"\\)"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-inline-markup-matcher</x-color> (markup)
  "Return the matcher regexp for an inline markup"
  (concat
	<x-color><param>RosyBrown</param>"\\W\\("</x-color>
   markup
   <x-color><param>RosyBrown</param>"\\(\\w\\|\\w.*?\\w\\|[[{(].*?\\w\\)"</x-color>
   markup
	<x-color><param>RosyBrown</param>"\\)\\W"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-list-bullet-matcher</x-color> (bullet)
  "Return the matcher regexp for a list bullet"
  (concat
   <x-color><param>RosyBrown</param>"^\\("</x-color> bullet <x-color><param>RosyBrown</param>"\\)"</x-color>
   (textile-re-concat textile-alignments) <x-color><param>RosyBrown</param>"*"</x-color>
   (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-alignments-matcher</x-color> ()
  "Return the matcher regexp for an alignments or indentation"
  (concat
   <x-color><param>RosyBrown</param>"\\(?:"</x-color> (textile-re-concat textile-blocks) <x-color><param>RosyBrown</param>"\\|"</x-color> <x-color><param>RosyBrown</param>"!"</x-color> <x-color><param>RosyBrown</param>"\\)"</x-color>
   <x-color><param>RosyBrown</param>"\\("</x-color> (textile-re-concat textile-alignments) <x-color><param>RosyBrown</param>"+"</x-color> <x-color><param>RosyBrown</param>"\\)"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-table-matcher</x-color> ()
  "Return the matcher regexp for a table row or header"
  (concat
   <x-color><param>RosyBrown</param>"\\(?:"</x-color>
   <x-color><param>RosyBrown</param>"^table"</x-color> (textile-re-concat textile-table-alignments) <x-color><param>RosyBrown</param>"*"</x-color> (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color> <x-color><param>RosyBrown</param>"\\. *$"</x-color>
   <x-color><param>RosyBrown</param>"\\|"</x-color>
   <x-color><param>RosyBrown</param>"^"</x-color> (textile-re-concat textile-table-alignments) <x-color><param>RosyBrown</param>"*"</x-color> (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color> <x-color><param>RosyBrown</param>"\\(?:\\. *|\\)"</x-color>
   <x-color><param>RosyBrown</param>"\\|"</x-color>
   <x-color><param>RosyBrown</param>"|"</x-color> (textile-re-concat textile-table-alignments) <x-color><param>RosyBrown</param>"*"</x-color> (textile-re-concat textile-attributes) <x-color><param>RosyBrown</param>"*"</x-color> <x-color><param>RosyBrown</param>"\\(?:\\. \\)?"</x-color>
   <x-color><param>RosyBrown</param>"\\|"</x-color>
   <x-color><param>RosyBrown</param>"| *$"</x-color>
   <x-color><param>RosyBrown</param>"\\)"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-link-matcher</x-color> ()
  "Return the matcher regexp for a link"
  (concat
   <x-color><param>RosyBrown</param>"\\(?:"</x-color>
   <x-color><param>RosyBrown</param>"\\(?:"</x-color>

   <x-color><param>RosyBrown</param>"\"\\(.*?\\)\":?"</x-color>

   <x-color><param>RosyBrown</param>"\\|"</x-color>

   <x-color><param>RosyBrown</param>"\\[\\(.*?\\)\\]"</x-color>

   <x-color><param>RosyBrown</param>"\\)?"</x-color>
   textile-url-regexp
	<x-color><param>RosyBrown</param>"\\|"</x-color>
	<x-color><param>RosyBrown</param>"\".*?\":[^ \n\t]+"</x-color>
   <x-color><param>RosyBrown</param>"\\)"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-image-matcher</x-color> ()
  "Return the matcher regexp for an image link"
  (concat
   <x-color><param>RosyBrown</param>"!"</x-color>
   (textile-re-concat textile-alignments) <x-color><param>RosyBrown</param>"*"</x-color>
   <x-color><param>RosyBrown</param>"/?\\w[^ \n\t]*?\\(?: *(.*?)\\|\\w\\)"</x-color>
   <x-color><param>RosyBrown</param>"!:?"</x-color>))


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-acronym-matcher</x-color> ()
  "Return the matcher regexp for an acronym"
  (concat
   <x-color><param>RosyBrown</param>"\\w+"</x-color> <x-color><param>RosyBrown</param>"(.*?)"</x-color>))


(<x-color><param>Purple</param>defvar</x-color> <x-color><param>DarkGoldenrod</param>textile-font-lock-keywords</x-color>
	  (list
	   ;; <x-color><param>Firebrick</param>headers
</x-color>	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h1"</x-color>) 1 'textile-h1-face t t)
	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h2"</x-color>) 1 'textile-h2-face t t)
	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h3"</x-color>) 1 'textile-h3-face t t)
	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h4"</x-color>) 1 'textile-h4-face t t)
	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h5"</x-color>) 1 'textile-h5-face t t)
	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"h6"</x-color>) 1 'textile-h6-face t t)
	   ;; <x-color><param>Firebrick</param>blockquotes
</x-color>	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"bq"</x-color>) 1 'textile-blockquote-face t t)
	   ;; <x-color><param>Firebrick</param>footnotes
</x-color>	   `(,(textile-block-matcher <x-color><param>RosyBrown</param>"fn[0-9]+"</x-color>) 1 'textile-footnote-face t t)
	   ;; <x-color><param>Firebrick</param>footnote marks
</x-color>	   '(<x-color><param>RosyBrown</param>"\\w\\([[0-9]+]\\)"</x-color> 1 'textile-footnotemark-face prepend t)
	   ;; <x-color><param>Firebrick</param>acronyms
</x-color>	   `(,(textile-acronym-matcher) 0 'textile-acronym-face t t)


	   ;; <x-color><param>Firebrick</param>emphasis
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"__"</x-color>) 1 'textile-emph-face prepend t)
	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"_"</x-color>) 1 'textile-emph-face prepend t)
	   '(<x-color><param>RosyBrown</param>"<<em>\\(.\\|\n\\)*?<</em>"</x-color> 0 'textile-emph-face prepend t)
	   ;; <x-color><param>Firebrick</param>strength
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\*\\*"</x-color>) 1 'textile-strong-face prepend t)
	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\*"</x-color>) 1 'textile-strong-face prepend t)
	   '(<x-color><param>RosyBrown</param>"<<strong>\\(.\\|\n\\)*?<</strong>"</x-color> 0 'textile-strong-face prepend t)
	   ;; <x-color><param>Firebrick</param>citation
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\?\\?"</x-color>) 1 'textile-citation-face prepend t)
	   ;; <x-color><param>Firebrick</param>code
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"@"</x-color>) 1 'textile-code-face prepend t)
	   ;; <x-color><param>Firebrick</param>deletion
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"-"</x-color>) 1 'textile-deleted-face prepend t)
	   ;; <x-color><param>Firebrick</param>insertion
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\+"</x-color>) 1 'textile-inserted-face prepend t)
	   ;; <x-color><param>Firebrick</param>superscript
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\^"</x-color>) 1 'textile-superscript-face prepend t)
	   ;; <x-color><param>Firebrick</param>subscript
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"~"</x-color>) 1 'textile-subscript-face prepend t)
	   ;; <x-color><param>Firebrick</param>span
</x-color>	   `(,(textile-inline-markup-matcher <x-color><param>RosyBrown</param>"%"</x-color>) 1 'textile-span-face prepend t)


	   ;; <x-color><param>Firebrick</param>image link
</x-color>	   `(,(textile-image-matcher) 0 'textile-image-face t t)


	   ;; <x-color><param>Firebrick</param>ordered list bullet
</x-color>	   `(,(textile-list-bullet-matcher <x-color><param>RosyBrown</param>"#+"</x-color>) 1 'textile-ol-bullet-face)
	   ;; <x-color><param>Firebrick</param>unordered list bullet
</x-color>	   `(,(textile-list-bullet-matcher <x-color><param>RosyBrown</param>"\\*+"</x-color>) 1 'textile-ul-bullet-face)


	   ;; <x-color><param>Firebrick</param>style
</x-color>	   `(,(textile-attribute-matcher <x-color><param>RosyBrown</param>"{"</x-color> <x-color><param>RosyBrown</param>"}"</x-color>) 1 'textile-style-face t t)
	   ;; <x-color><param>Firebrick</param>class
</x-color>	   `(,(textile-attribute-matcher <x-color><param>RosyBrown</param>"("</x-color> <x-color><param>RosyBrown</param>")"</x-color>) 1 'textile-class-face t t)
	   ;; <x-color><param>Firebrick</param>lang
</x-color>	   `(,(textile-attribute-matcher <x-color><param>RosyBrown</param>"\\["</x-color> <x-color><param>RosyBrown</param>"\\]"</x-color>) 1 'textile-lang-face t t)


	   ;; <x-color><param>Firebrick</param>alignments and indentation
</x-color>	   `(,(textile-alignments-matcher) 1 'textile-alignments-face t t)


	   ;; <x-color><param>Firebrick</param>tables
</x-color>	   `(,(textile-table-matcher) 0 'textile-table-face t t)


	   ;; <x-color><param>Firebrick</param>links
</x-color>	   `(,(textile-link-matcher) 0 'textile-link-face t t)


		;; <x-color><param>Firebrick</param><<pre> blocks
</x-color>	   '(<x-color><param>RosyBrown</param>"<<pre>\\(.\\|\n\\)*?<</pre>"</x-color> 0 'textile-pre-face t t)
	   ;; <x-color><param>Firebrick</param><<code> blocks
</x-color>	   '(<x-color><param>RosyBrown</param>"<<code>\\(.\\|\n\\)*?<</code>"</x-color> 0 'textile-code-face t t))
	  "Keywords/Regexp for fontlocking of textile-mode")



;; <x-color><param>Firebrick</param>(defvar textile-imenu-generic-expression
</x-color>;; <x-color><param>Firebrick</param>...)

</x-color>

;; <x-color><param>Firebrick</param>(defvar textile-outline-regexp
</x-color>;;<x-color><param>Firebrick</param>	 ...)

</x-color>


(<x-color><param>Purple</param>define-minor-mode</x-color> <x-color><param>Blue1</param>textile-minor-mode</x-color>
  "Textile minor mode"
  ;; <x-color><param>Firebrick</param>the initial value
</x-color>  nil
  ;; <x-color><param>Firebrick</param>the indicator for the mode line
</x-color>  <x-color><param>RosyBrown</param>" Textile"</x-color>
  ;; <x-color><param>Firebrick</param>the keymap
</x-color>  nil
  ;; <x-color><param>Firebrick</param>the body
</x-color>  (<x-color><param>Purple</param>if</x-color> textile-minor-mode
	  (<x-color><param>Purple</param>progn</x-color>
		(make-local-variable 'textile-minor-mode-initial-font-lock-keywords)
		(setq textile-minor-mode-initial-font-lock-keywords font-lock-keywords)
		(font-lock-add-keywords nil textile-font-lock-keywords)
		(font-lock-fontify-buffer))
	(<x-color><param>Purple</param>progn</x-color>
	  (setq font-lock-keywords textile-minor-mode-initial-font-lock-keywords)
	  (font-lock-fontify-buffer))))

;; <x-color><param>Firebrick</param>FACES

</x-color>

(<x-color><param>Purple</param>defgroup</x-color> <x-color><param>ForestGreen</param>textile-faces</x-color> nil
  "Faces used by textile-mode for syntax highlighting"
  <x-color><param>Orchid</param>:group</x-color> 'faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h1-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 2.0 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h1 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h2-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.75 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h2 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h3-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.6 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h3 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h4-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.35 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h4 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h5-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.2 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h5 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-h6-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.0 <x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight h6 headers."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-blockquote-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"ivory4"</x-color>)))
  "Face used to highlight bq blocks."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-footnote-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"orange red"</x-color>)))
  "Face used to highlight footnote blocks."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-footnotemark-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"orange red"</x-color>)))
  "Face used to highlight footnote marks."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-style-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"sandy brown"</x-color>)))
  "Face used to highlight style parameters."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-class-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"yellow green"</x-color>)))
  "Face used to highlight class and id parameters."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-lang-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"sky blue"</x-color>)))
  "Face used to highlight lang parameters."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-emph-face</x-color>
  '((t (<x-color><param>Orchid</param>:slant</x-color> italic)))
  "Face used to highlight emphasized words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-strong-face</x-color>
  '((t (<x-color><param>Orchid</param>:weight</x-color> bold)))
  "Face used to highlight strong words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-code-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"ivory3"</x-color>)))
  "Face used to highlight inline code."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-citation-face</x-color>
  '((t (<x-color><param>Orchid</param>:slant</x-color> italic)))
  "Face used to highlight citations."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-deleted-face</x-color>
  '((t (<x-color><param>Orchid</param>:strike-through</x-color> t)))
  "Face used to highlight deleted words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-inserted-face</x-color>
  '((t (<x-color><param>Orchid</param>:underline</x-color> t)))
  "Face used to highlight inserted words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-superscript-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 1.1)))
  "Face used to highlight superscript words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-subscript-face</x-color>
  '((t (<x-color><param>Orchid</param>:height</x-color> 0.8)))
  "Face used to highlight subscript words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-span-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"pink"</x-color>)))
  "Face used to highlight span words."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-alignments-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"cyan"</x-color>)))
  "Face used to highlight alignments."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-ol-bullet-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"red"</x-color>)))
  "Face used to highlight ordered lists bullets."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-ul-bullet-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"blue"</x-color>)))
  "Face used to highlight unordered list bullets."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-pre-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"green"</x-color>)))
  "Face used to highlight <<pre> blocks."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-code-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"yellow"</x-color>)))
  "Face used to highlight <<code> blocks."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-table-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"red"</x-color>)))
  "Face used to highlight tables."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-link-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"blue"</x-color>)))
  "Face used to highlight links."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-image-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"pink"</x-color>)))
  "Face used to highlight image links."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)


(<x-color><param>Purple</param>defface</x-color> <x-color><param>DarkGoldenrod</param>textile-acronym-face</x-color>
  '((t (<x-color><param>Orchid</param>:foreground</x-color> <x-color><param>RosyBrown</param>"cyan"</x-color>)))
  "Face used to highlight acronyms links."
  <x-color><param>Orchid</param>:group</x-color> 'textile-faces)



(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-replace</x-color> (regexp tostring subexpr)

  "Replaces all the occurrences of regexp in the buffer"

  (beginning-of-buffer)

  (<x-color><param>Purple</param>while</x-color> (re-search-forward regexp nil t)
	(replace-match tostring nil nil nil subexpr))
)


(<x-color><param>Purple</param>defun</x-color> <x-color><param>Blue1</param>textile-to-html-buffer</x-color> ()

  "Converts current buffer to HTML"

  (interactive)

  (<x-color><param>Purple</param>save-excursion</x-color>

	(textile-replace (textile-inline-markup-matcher <x-color><param>RosyBrown</param>"_"</x-color>) <x-color><param>RosyBrown</param>"<<em>\\2<</em>"</x-color> 1)

	(textile-replace (textile-inline-markup-matcher <x-color><param>RosyBrown</param>"__"</x-color>) <x-color><param>RosyBrown</param>"<<em>\\2<</em>"</x-color> 1)

	(textile-replace (textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\*"</x-color>) <x-color><param>RosyBrown</param>"<<strong>\\2<</strong>"</x-color> 1)

	(textile-replace (textile-inline-markup-matcher <x-color><param>RosyBrown</param>"\\*\\*"</x-color>) <x-color><param>RosyBrown</param>"<<strong>\\2<</strong>"</x-color> 1)

	(textile-replace (textile-link-matcher) <x-color><param>RosyBrown</param>"<<a href='\\3'>\\1\\2<</a>"</x-color> nil)

	(textile-replace <x-color><param>RosyBrown</param>"\n[</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>#].*\n</x-color><x-color><param>RosyBrown</param>\\(\\)</x-color><x-color><param>RosyBrown</param>#"</x-color> <x-color><param>RosyBrown</param>"<<ol>\n"</x-color> 1)

	(textile-replace <x-color><param>RosyBrown</param>"\n#.*\n</x-color><x-color><param>RosyBrown</param>\\(\\)</x-color><x-color><param>RosyBrown</param>\n"</x-color> <x-color><param>RosyBrown</param>"<</ol>\n"</x-color> 1)

	(textile-replace <x-color><param>RosyBrown</param>"\n[</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>*].*\n</x-color><x-color><param>RosyBrown</param>\\(\\)</x-color><x-color><param>RosyBrown</param>\\*"</x-color> <x-color><param>RosyBrown</param>"<<ul>\n"</x-color> 1)

	(textile-replace <x-color><param>RosyBrown</param>"\n\\*.*\n</x-color><x-color><param>RosyBrown</param>\\(\\)</x-color><x-color><param>RosyBrown</param>[\n\']"</x-color> <x-color><param>RosyBrown</param>"<</ul>\n"</x-color> 1)

	(textile-replace <x-color><param>RosyBrown</param>"^[#*] </x-color><x-color><param>RosyBrown</param>\\(</x-color><x-color><param>RosyBrown</param>.*</x-color><x-color><param>RosyBrown</param>\\)</x-color><x-color><param>RosyBrown</param>$"</x-color> <x-color><param>RosyBrown</param>"<<li>\\1<</li>"</x-color> nil)

	(textile-replace <x-color><param>RosyBrown</param>"\n</x-color><x-color><param>RosyBrown</param>\\(\\(?:</x-color><x-color><param>RosyBrown</param>.</x-color><x-color><param>RosyBrown</param>\\|</x-color><x-color><param>RosyBrown</param>\n[</x-color><x-color><param>RosyBrown</param>^</x-color><x-color><param>RosyBrown</param>\n]</x-color><x-color><param>RosyBrown</param>\\)</x-color><x-color><param>RosyBrown</param>*</x-color><x-color><param>RosyBrown</param>\\)</x-color><x-color><param>RosyBrown</param>\n"</x-color> <x-color><param>RosyBrown</param>"\n<<p>\\1<</p>\n"</x-color> nil)

	)

  )


(<x-color><param>Purple</param>provide</x-color> '<x-color><param>CadetBlue</param>textile-minor-mode</x-color>)
 ;;; <x-color><param>Firebrick</param>textile-mode.el ends here</x-color>