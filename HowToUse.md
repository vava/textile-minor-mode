Emacs is a great text editor, the best there is. Although you have to commit couple of months of pretty painful experiences with it but after that you wouldn’t change it for anything else. Especially if you don’t have mouse.

Sometimes though it is missing some features but then if you are the programmer it’s when Emacs great power of exensibility comes to rescue. You can do everything and it’s not just figure of speech. Want to highlight your self made language? Change the formatting rules? Parse JavaScript? Nothing stopping you except maybe your own laziness.

So since I decided to use that great editor as a tool for my blogging I was trying to make it as useful for me as possible. First of all I used weblogger.el which is a really handy tool for writing and publishing the articles (you could find a little how-to here). But it lacks one really important feature - you have to write your posts with HTML markup. And it is really annoying. So I wondered around a little and found couple of different text formatting techniques which are supported by Emacs, that is Textile and Markdown. Textile is looking a little bit better from my perspective so I found a mode for it and gave it a try. It looked nice, but it was a major mode so I couldn’t use it directly with weblogger and it doesn’t have a translation to HTML which makes it kind of useless for my tasks.

Nonetheless I remembered that I am a developer for gods sake so I could fix it. And I did. I’ve created a textile-minor-mode. It doesn’t do much yet and I don’t think it’ll become big anytime soon but it does work for my needs fine and it my work for yours too. By the way if you think it is limited you are welcome to write me a letter and I would give you the rights to code repository so you could fix it :)

So here is little guide how to use it. First of all you download it from there and put it in your site-lisp directory (or anywhere where it could be discovered by Emacs automatically, site-lisp have this property by default). Then you add following code into your .emacs file

```
(require 'textile-minor-mode)

(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)
```

First line just loads mode into Emacs and the second one starts it when weblogger starts.
By the way you don’t have to restart Emacs to try this new code, just select it and `M-x eval-region` and you’re ready.

Try it out, start new blog post with `M-x weblogger-start-entry` and then use textile all over. It gets nicely highlighted. When you’re done, call `M-x textile-to-html-buffer-respect-weblogger` and check generated markup. Then just press `C-x C-s` and your post is out there!

PS. Just for the sake of it, the code from my .emacs that helping me with blogging

```
(require 'weblogger)
;;Saving is just an instinct, it happens every 5 sec,
;; I don't want to publish that often.
(define-key weblogger-entry-mode-map "\C-x\C-s" 'weblogger-send-entry)

(require 'textile-minor-mode)

(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry)
 )
```