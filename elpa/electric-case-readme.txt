1. Usage

1.A. Overview

For example, to try electric-case-mode in java-mode, put following expression
into your init file.

  (require 'electric-case)

  (eval-after-load "cc-mode"
    (add-hook 'java-mode-hook electric-case-java-init))

Now, when you type following expression as usual in java-mode,

  public class test-class{
      public void test-method(void){

electric-case will automatically convert it into :

  public class TestClass{
      public void testMethod(void){

Settings for some other languages are also available by default. Try:

  (eval-after-load "cc-mode"
    (add-hook 'c-mode-hook electric-case-c-init))

  (eval-after-load "ahk-mode"
    (add-hook 'ahk-mode-hook electric-case-ahk-init))

  (eval-after-load "scala-mode"
    (add-hook 'scala-mode-hook electric-case-scala-init))

If you want to use electric-case-mode on other languages than above,
you may make your own setting. Read section 2.

1.B. "convert-calls"

electric-case do not convert other expressions than declarations, by default. To
enable conversion for other expressions, set "electric-case-convert-calls" non-nil.

  (setq electric-case-convert-calls t)

This sometimes produces confusing results for novice users. For example,

  foo-bar

is not treated as "foo minus bar", but converted to

  fooBar

To make "-" treated as subtraction or negation, insert whitespace around it.

  foo - bar

I recommend to keep "electric-case-convert-calls" nil, because convert-calls may be
too noisy. Once declared, symbols may be inserted easily using completion. This
script is useful when you TYPE camel-case or snake-case symbols. But in case you do
not need to type, not to type is much better.

1.C. "convert-nums", "convert-beginning", and "convert-end"

Even if "electric-case-convert-calls" is non-nil, numbers, and hyphens at beginning/end of
symbols are not converted.

  -foo-1  =>  -foo-1

You may change this behavior by turning some of three variables to non-nil.

  (setq electric-case-convert-nums t)      hyphens around numbers
  (setq electric-case-convert-beginning t) hyphens at beginning of symbols
  (setq electric-case-convert-end t)       hyphens at end of symbols

When you insert an expression "-foo--1--bar-",

                  +---num
                  |     +--- num
                  V     V
   -  f  o  o  -  -  1  -  -  b  a  r  -
   ^           ^           ^           ^
   |           +--- end    |           +--- end
   +--- beginning          +--- beginning

electric-case will convert it like:

                     num beg end

    -foo--1--bar-    nil nil nil
    -foo-1--bar      nil nil  t
    Foo--1-Bar-      nil  t  nil
    -foo1Bar-         t  nil nil
    Foo1Bar           t   t   t

1.D. overlays

Symbols that may be converted are printed in gray. If this is not confortable for you,
evaluate following expression to disable it.

  (setq electric-case-pending-overlay nil)

Or you may also choose another face for overlay.

  (setq electric-case-pending-overlay 'highlight)

1.E. disable electric-case

If you want to disable electric-case temporally, use command "M-x electric-case-mode"
or evaluate expression below :

  (electric-case-mode -1)

To activate again, call the same command again, or evaluate expression below :

  (electric-case-mode 1)

2. Language Configuration

There are two important buffer-local variables. To add settings for other languages,
configure them.

- electric-case-criteria

  Set a function that defines which case to convert the symbol into. The function
  will be given 2 arguments: the beginning and the end point of the symbol that is
  going to be converted. The function must return one of 'camel, 'ucamel, 'snake,
  'usnake, or nil. When the return value is nil, conversion for the symbol is canceled.

  Remember, that if "electric-case-convert-calls" is nil, symbols not in declarations are
  not expected to be converted. electric-case does not judge if the symbol is in a
  declaration. So criteria function should return nil in that case.

  Here is an example:

    (setq electric-case-criteria
          (lambda (b e n)
            (let ((proper (text-properties-at b)))
              (cond ((member 'font-lock-function-name-face proper) 'snake)
                    ((member 'font-lock-variable-name-face proper)
                     (if (member '(cpp-macro) (c-guess-basic-syntax))
                         'usnake 'snake))
                    (electric-case-convert-calls 'snake)
                    (t nil)))))

  with criteria above, function declarations and variable declarations are converted
  into snake_case. Macro declarations are converted into UP_SNAKE_CASE. Other expressions
  are converted into snake_case, if "electric-case-convert-calls" is non-nil. Otherwise,
  are not converted, even if that contain "-". This may be one of the minimal criterias
  for C-language.

- electric-case-max-iteration

  For example, in Java, the syntactical category of the symbol "what-is-this" below
  is not decidable.

    what-is-this

  But when "symbol;" is added, now "what-is-this" is a name of a class.

    what-is-this symbol;

  So electric-case can convert it.

    WhatIsThis symbol;

  In the example above, the symbol "what-is-this" must be checked twice. Then,
  "electric-case-max-iteration" must be 2 or greater. Otherwise, "what-is-this" is
  not checked twice, and not be converted.
