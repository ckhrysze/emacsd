<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: el-expectations.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=el-expectations.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: el-expectations.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=el-expectations.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for el-expectations.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=el-expectations.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22el-expectations.el%22">el-expectations.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="download/el-expectations.el">Download</a></p><pre class="code"><span class="linecomment">;;; el-expectations.el --- minimalist unit testing framework</span>
<span class="linecomment">;; $Id: el-expectations.el,v 1.61 2010/05/04 08:48:22 rubikitch Exp $</span>

<span class="linecomment">;; Copyright (C) 2008, 2009, 2010  rubikitch</span>

<span class="linecomment">;; Author: rubikitch &lt;rubikitch@ruby-lang.org&gt;</span>
<span class="linecomment">;; Keywords: lisp, testing, unittest</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el</span>

<span class="linecomment">;; This file is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2, or (at your option)</span>
<span class="linecomment">;; any later version.</span>

<span class="linecomment">;; This file is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with GNU Emacs; see the file COPYING.  If not, write to</span>
<span class="linecomment">;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,</span>
<span class="linecomment">;; Boston, MA 02110-1301, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; Emacs Lisp Expectations framework is a minimalist unit testing</span>
<span class="linecomment">;; framework in Emacs Lisp.</span>

<span class="linecomment">;;; Commands:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Below are complete command list:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;  `expectations-execute'</span>
<span class="linecomment">;;    Execute last-defined `expectations' test.</span>
<span class="linecomment">;;  `exps-next-error'</span>
<span class="linecomment">;;    Move to the Nth (default 1) next failure/error in *expectations result* buffer.</span>
<span class="linecomment">;;  `expectations-eval-defun'</span>
<span class="linecomment">;;    Do `eval-defun'.</span>
<span class="linecomment">;;  `batch-expectations-in-emacs'</span>
<span class="linecomment">;;    Execute expectations in current file with batch mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;; Customizable Options:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Below are customizable option list:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;  `expectations-execute-at-once'</span>
<span class="linecomment">;;    If non-nil, execute selected expectation when pressing C-M-x.</span>
<span class="linecomment">;;    default = (quote all)</span>

<span class="linecomment">;; I love Jay Fields' expectations unit testing framework in Ruby. It</span>
<span class="linecomment">;; provides one syntax and can define various assertions. So I created</span>
<span class="linecomment">;; Emacs Lisp Expectations modeled after expectations in Ruby.</span>
<span class="linecomment">;; Testing policy is same as the original expectations in Ruby. Visit</span>
<span class="linecomment">;; expectations site in rubyforge.</span>
<span class="linecomment">;; http://expectations.rubyforge.org/</span>

<span class="linecomment">;; With Emacs Lisp Mock (el-mock.el), Emacs Lisp Expectations supports</span>
<span class="linecomment">;; mock and stub, ie. behavior based testing.</span>
<span class="linecomment">;; You can get it from EmacsWiki</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el</span>

<span class="linecomment">;;; Usage:</span>

<span class="linecomment">;; 1. Evaluate an expectations sexp.</span>
<span class="linecomment">;; 2. `M-x expectations-execute' to execute a test.</span>
<span class="linecomment">;; 3. If there are any errors, use M-x next-error (C-x `) and M-x previous-error</span>
<span class="linecomment">;;    to go to expect sexp in error.</span>

<span class="linecomment">;; If you evaluated expectations by C-M-x, it is automatically executed.</span>
<span class="linecomment">;; If you type C-u C-u C-M-x, execute expectations with batch-mode.</span>

<span class="linecomment">;; For further information: see docstring of `expectations'.</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'expectations)</span>

<span class="linecomment">;;; Batch Mode:</span>

<span class="linecomment">;; Batch mode can be used with this shell script (el-expectations).</span>
<span class="linecomment">;; Of course, EMACS/OPTIONS/OUTPUT can be customized.</span>

<span class="linecomment">;; ATTENTION! This script is slightly changed since v1.32.</span>

<span class="linecomment">;; #!/bin/sh</span>
<span class="linecomment">;; EMACS=emacs</span>
<span class="linecomment">;; OPTIONS="-L . -L $HOME/emacs/lisp"</span>
<span class="linecomment">;; OUTPUT=/tmp/.el-expectations</span>
<span class="linecomment">;; $EMACS -q --no-site-file --batch $OPTIONS -l el-expectations -f batch-expectations $OUTPUT "$@"</span>
<span class="linecomment">;; ret=$?</span>
<span class="linecomment">;; cat $OUTPUT</span>
<span class="linecomment">;; rm $OUTPUT</span>
<span class="linecomment">;; exit $ret</span>

<span class="linecomment">;; $ el-expectations el-expectations-failure-sample.el</span>

<span class="linecomment">;;; Embedded test:</span>

<span class="linecomment">;; You can embed test using `fboundp' and `dont-compile'. dont-compile</span>
<span class="linecomment">;; is needed to prevent unit tests from being byte-compiled.</span>

<span class="linecomment">;; (dont-compile</span>
<span class="linecomment">;;   (when (fboundp 'expectations)</span>
<span class="linecomment">;;     (expectations</span>
<span class="linecomment">;;       (expect ...)</span>
<span class="linecomment">;;       ...</span>
<span class="linecomment">;; )))</span>

<span class="linecomment">;;; Limitation:</span>

<span class="linecomment">;; * `expectations-execute' can execute one test (sexp).</span>

<span class="linecomment">;;; Examples:</span>

<span class="linecomment">;; Example code is in the EmacsWiki.</span>

<span class="linecomment">;; Success example http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations-success-sample.el</span>
<span class="linecomment">;; Failure example http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations-failure-sample.el</span>


<span class="linecomment">;;; Bug Report:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; If you have problem, send a bug report via M-x exps-send-bug-report.</span>
<span class="linecomment">;; The step is:</span>
<span class="linecomment">;;  0) Setup mail in Emacs, the easiest way is:</span>
<span class="linecomment">;;       (setq user-mail-address "your@mail.address")</span>
<span class="linecomment">;;       (setq user-full-name "Your Full Name")</span>
<span class="linecomment">;;       (setq smtpmail-smtp-server "your.smtp.server.jp")</span>
<span class="linecomment">;;       (setq mail-user-agent 'message-user-agent)</span>
<span class="linecomment">;;       (setq message-send-mail-function 'message-smtpmail-send-it)</span>
<span class="linecomment">;;  1) Be sure to use the LATEST version of el-expectations.el.</span>
<span class="linecomment">;;  2) Enable debugger. M-x toggle-debug-on-error or (setq debug-on-error t)</span>
<span class="linecomment">;;  3) Use Lisp version instead of compiled one: (load "el-expectations.el")</span>
<span class="linecomment">;;  4) Do it!</span>
<span class="linecomment">;;  5) If you got an error, please do not close *Backtrace* buffer.</span>
<span class="linecomment">;;  6) M-x exps-send-bug-report and M-x insert-buffer *Backtrace*</span>
<span class="linecomment">;;  7) Describe the bug using a precise recipe.</span>
<span class="linecomment">;;  8) Type C-c C-c to send.</span>
<span class="linecomment">;;  # If you are a Japanese, please write in Japanese:-)</span>

<span class="linecomment">;;; History:</span>

<span class="linecomment">;; $Log: el-expectations.el,v $</span>
<span class="linecomment">;; Revision 1.61  2010/05/04 08:48:22  rubikitch</span>
<span class="linecomment">;; Added bug report command</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.60  2010/04/10 22:00:51  rubikitch</span>
<span class="linecomment">;; avoid test duplication</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.59  2010/04/05 21:50:19  rubikitch</span>
<span class="linecomment">;; C-M-x executes unit tests only when the current defun is expectations.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.58  2010/04/02 22:01:43  rubikitch</span>
<span class="linecomment">;; Set default `expectations-execute-at-once' to 'all.</span>
<span class="linecomment">;; Execute all expectations blocks by C-M-x by default.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.57  2010/04/02 21:57:46  rubikitch</span>
<span class="linecomment">;; `next-error' for multiple expectations block</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.56  2010/04/02 20:22:29  rubikitch</span>
<span class="linecomment">;; `expectations-eval-defun': Execute all expectations in this file if (eq expectations-execute-at-once 'all)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.55  2010/04/02 19:58:08  rubikitch</span>
<span class="linecomment">;; add a newline (no code change)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.54  2010/04/01 01:12:52  rubikitch</span>
<span class="linecomment">;; Enter debugger when error occurs in (eq debug-on-error t)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.53  2010/03/26 00:36:30  rubikitch</span>
<span class="linecomment">;; no-error assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.52  2010/03/26 00:23:57  rubikitch</span>
<span class="linecomment">;; small fix</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.51  2010/03/20 21:42:54  rubikitch</span>
<span class="linecomment">;; Apply patch by DanielHackney:</span>
<span class="linecomment">;; Allow (error) expectation to accept an optional second argument,</span>
<span class="linecomment">;; the symbol `*', to ignore an error message.</span>
<span class="linecomment">;; It would be used as (error error *), and would pass for the body (error "some string").</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.50  2010/02/13 20:20:53  rubikitch</span>
<span class="linecomment">;; font-lock support for lisp-interaction-mode</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.49  2009/10/10 09:19:40  rubikitch</span>
<span class="linecomment">;; Fixed a displabug of `exps-display'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.48  2008/12/22 16:44:54  rubikitch</span>
<span class="linecomment">;; `expr-desc': replace padding with highlight face.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.47  2008/08/28 19:28:37  rubikitch</span>
<span class="linecomment">;; not-called assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.46  2008/08/28 19:06:24  rubikitch</span>
<span class="linecomment">;; `exps-padding': use `window-width'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.45  2008/08/24 20:36:37  rubikitch</span>
<span class="linecomment">;; mention `dont-compile'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.44  2008/08/22 20:48:52  rubikitch</span>
<span class="linecomment">;; fixed a stupid bug</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.43  2008/08/22 20:43:00  rubikitch</span>
<span class="linecomment">;; non-nil (true) assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.42  2008/04/14 07:54:27  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.41  2008/04/14 06:58:20  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.40  2008/04/14 06:52:39  rubikitch</span>
<span class="linecomment">;; better font-lock</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.39  2008/04/13 11:49:08  rubikitch</span>
<span class="linecomment">;; C-u M-x expectations-execute -&gt; batch-expectations-in-emacs</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.38  2008/04/13 11:39:51  rubikitch</span>
<span class="linecomment">;; better result display.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.37  2008/04/13 11:30:17  rubikitch</span>
<span class="linecomment">;; expectations-eval-defun</span>
<span class="linecomment">;; batch-expectations-in-emacs</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.36  2008/04/12 18:44:24  rubikitch</span>
<span class="linecomment">;; extend `type' assertion to use predicates.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.35  2008/04/12 14:10:00  rubikitch</span>
<span class="linecomment">;; updated el-mock info.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.34  2008/04/12 14:08:28  rubikitch</span>
<span class="linecomment">;; * (require 'el-mock nil t)</span>
<span class="linecomment">;; * updated `expectations' docstring</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.33  2008/04/12 09:49:27  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.32  2008/04/12 09:44:23  rubikitch</span>
<span class="linecomment">;; batch-mode: handle multiple lisp files.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.31  2008/04/12 09:34:32  rubikitch</span>
<span class="linecomment">;; colorize result summary</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.30  2008/04/12 09:19:42  rubikitch</span>
<span class="linecomment">;; show result summary at the top.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.29  2008/04/12 03:19:06  rubikitch</span>
<span class="linecomment">;; Execute all expectations in batch mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.28  2008/04/12 03:07:43  rubikitch</span>
<span class="linecomment">;; update doc.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.27  2008/04/10 17:02:40  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.26  2008/04/10 14:27:47  rubikitch</span>
<span class="linecomment">;; arranged code</span>
<span class="linecomment">;; font-lock support</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.25  2008/04/10 12:45:57  rubikitch</span>
<span class="linecomment">;; mock assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.24  2008/04/10 08:46:19  rubikitch</span>
<span class="linecomment">;; integration of `stub' in el-mock.el</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.23  2008/04/10 07:11:40  rubikitch</span>
<span class="linecomment">;; error data is evaluated.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.22  2008/04/10 06:14:12  rubikitch</span>
<span class="linecomment">;; added finish message with current time.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.21  2008/04/09 20:45:41  rubikitch</span>
<span class="linecomment">;; error assertion: with error data</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.20  2008/04/09 20:02:46  rubikitch</span>
<span class="linecomment">;; error-message assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.19  2008/04/09 15:07:29  rubikitch</span>
<span class="linecomment">;; expectations-execute-at-once, eval-defun advice</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.18  2008/04/09 08:57:37  rubikitch</span>
<span class="linecomment">;; Batch Mode documentation</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.17  2008/04/09 08:52:34  rubikitch</span>
<span class="linecomment">;; * (eval-when-compile (require 'cl))</span>
<span class="linecomment">;; * avoid a warning</span>
<span class="linecomment">;; * count expectations/failures/errors</span>
<span class="linecomment">;; * exitstatus = failures + errors (batch mode)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.16  2008/04/09 04:03:11  rubikitch</span>
<span class="linecomment">;; batch-expectations: use command-line-args-left</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.15  2008/04/09 03:54:00  rubikitch</span>
<span class="linecomment">;; refactored</span>
<span class="linecomment">;; batch-expectations</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.14  2008/04/08 17:54:02  rubikitch</span>
<span class="linecomment">;; fixed typo</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.13  2008/04/08 17:45:08  rubikitch</span>
<span class="linecomment">;; documentation.</span>
<span class="linecomment">;; renamed: expectations.el -&gt; el-expectations.el</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.12  2008/04/08 16:54:50  rubikitch</span>
<span class="linecomment">;; changed output format slightly</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.11  2008/04/08 16:37:53  rubikitch</span>
<span class="linecomment">;; error assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.10  2008/04/08 15:52:14  rubikitch</span>
<span class="linecomment">;; refactored</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.9  2008/04/08 15:39:06  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.8  2008/04/08 15:38:03  rubikitch</span>
<span class="linecomment">;; reimplementation of exps-assert-*</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.7  2008/04/08 15:06:42  rubikitch</span>
<span class="linecomment">;; better failure handling</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.6  2008/04/08 14:45:58  rubikitch</span>
<span class="linecomment">;; buffer assertion</span>
<span class="linecomment">;; regexp assertion</span>
<span class="linecomment">;; type assertion</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.5  2008/04/08 13:16:16  rubikitch</span>
<span class="linecomment">;; removed elk-test dependency</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.4  2008/04/08 12:55:15  rubikitch</span>
<span class="linecomment">;; next-error/occur-like interface</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.3  2008/04/08 09:08:54  rubikitch</span>
<span class="linecomment">;; prettier `desc' display</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.2  2008/04/08 08:45:46  rubikitch</span>
<span class="linecomment">;; exps-last-filename</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.1  2008/04/08 07:52:30  rubikitch</span>
<span class="linecomment">;; Initial revision</span>
<span class="linecomment">;;</span>

<span class="linecomment">;;; Code:</span>

(eval-when-compile (require 'cl))
(require 'el-mock nil t)

(defgroup el-expectations nil
  "<span class="quote">Emacs Lisp Expectations - minimalist unit testing framework.</span>"
  :group 'lisp)

(defvar exps-last-testcase nil)
(defvar exps-last-filename nil)
(defvar exps-last-position nil)
(defvar expectations-result-buffer "<span class="quote">*expectations result*</span>")

(defcustom expectations-execute-at-once 'all
  "<span class="quote">If non-nil, execute selected expectation when pressing C-M-x.
If 'all, execute all expectations blocks in current file.
If other non-nil value, execute current expectations block.</span>"
  :group 'el-expectations)

(defmacro expectations (&rest body)
  "<span class="quote">Define a expectations test case.
Use `expect' and `desc' to verify the code.
Note that these are neither functions nor macros.
These are keywords in expectations Domain Specific Language(DSL).

Synopsis:
* (expect EXPECTED-VALUE BODY ...)
  Assert that the evaluation result of BODY is `equal' to EXPECTED-VALUE.
* (desc DESCRIPTION)
  Description of a test. It is treated only as a delimiter comment.

Synopsis of EXPECTED-VALUE:
* (non-nil)
* (true)
  Any non-nil value, eg. t, 1, '(1).

* (buffer BUFFER-NAME)
  Body should eq buffer object of BUFFER-NAME.

  Example:
    (expect (buffer \"*scratch*\")
      (with-current-buffer \"*scratch*\"
        (current-buffer)))
* (regexp REGEXP)
  Body should match REGEXP.

  Example:
    (expect (regexp \"o\")
      \"hoge\")
* (type TYPE-SYMBOL)
  Body should be a TYPE-SYMBOL.
  TYPE-SYMBOL may be one of symbols returned by `type-of' function.
   `symbol', `integer', `float', `string', `cons', `vector',
   `char-table', `bool-vector', `subr', `compiled-function',
   `marker', `overlay', `window', `buffer', `frame', `process',
   `window-configuration'
  Otherwise using predicate naming TYPE-SYMBOL and \"p\".
  For example, `(type sequence)' uses `sequencep' predicate.
  `(type char-or-string)' uses `char-or-string-p' predicate.

  Example:
    (expect (type buffer)
      (current-buffer))
    (expect (type sequence)
      nil)
    (expect (type char-or-string)
      \"a\")

* (error)
  Body should raise any error.

  Example:
    (expect (error)
      (/ 1 0))
* (error ERROR-SYMBOL)
  Body should raise ERROR-SYMBOL error.

  Example:
    (expect (error arith-error)
      (/ 1 0))
* (error ERROR-SYMBOL ERROR-DATA)
  Body should raise ERROR-SYMBOL error with ERROR-DATA.
  ERROR-DATA is 2nd argument of `signal' function. If ERROR-DATA
  is the special symbol `*', then it will match any error data.

  Example:
    (expect (error wrong-number-of-arguments '(= 3))
      (= 1 2 3 ))

    (expect (error error *)
      (error \"message\"))

* (error-message ERROR-MESSAGE)
  Body should raise any error with ERROR-MESSAGE.

  Example:
    (expect (error-message \"ERROR!!\")
      (error \"ERROR!!\"))

* (no-error)
  Body should not raise any error.

  Example:
    (expect (no-error)
      1)

* (mock MOCK-FUNCTION-SPEC =&gt; MOCK-RETURN-VALUE)
  Body should call MOCK-FUNCTION-SPEC and returns MOCK-RETURN-VALUE.
  Mock assertion depends on `el-mock' library.
  If available, you do not have to require it: el-expectations detects it.

  Synopsis of MOCK-FUNCTION-SPEC:
    (FUNCTION ARGUMENT ...)
    MOCK-FUNCTION-SPEC is almost same as normal function call.
    If you should specify `*' as ARGUMENT, any value is accepted.
    Otherwise, body should call FUNCTION with specified ARGUMENTs.

  Example:
    (expect (mock (foo * 3) =&gt; nil)
      (foo 9 3))

* (not-called FUNCTION)
  Body should not call FUNCTION.
  Not-called assertion depends on `el-mock' library.
  If available, you do not have to require it: el-expectations detects it.

  Example:
    (expect (not-called hoge)
      1)

* any other SEXP
  Body should equal (eval SEXP).

  Example:
    (expect '(1 2)
      (list 1 2))

Extending EXPECTED-VALUE is easy. See el-expectations.el source code.

Example:
 (expectations
   (desc \"simple expectation\")
   (expect 3
     (+ 1 2))
   (expect \"hoge\"
     (concat \"ho\" \"ge\"))
   (expect \"fuga\"
     (set-buffer (get-buffer-create \"tmp\"))
     (erase-buffer)
     (insert \"fuga\")
     (buffer-string))

   (desc \"extended expectation\")
   (expect (buffer \"*scratch*\")
     (with-current-buffer \"*scratch*\"
       (current-buffer)))
   (expect (regexp \"o\")
     \"hoge\")
   (expect (type integer)
     3)

   (desc \"error expectation\")
   (expect (error arith-error)
     (/ 1 0))
   (expect (error)
     (/ 1 0))
   (desc \"mock with stub\")
   (expect (mock (foo 5 * 7) =&gt; nil)
     ;; Stub function `hoge', which accepts any arguments and returns 3.
     (stub hoge =&gt; 3)
     (foo (+ 2 (hoge 10)) 6 7))
   )
</span>"
  (if (or noninteractive
          (eq expectations-execute-at-once 'all))
      `(setq exps-last-testcase
             ',(append exps-last-testcase
                       '((new-expectations 1))
                      body)
             exps-last-filename ,(or load-file-name buffer-file-name))
    `(setq exps-last-testcase ',body
           exps-last-filename ,(or load-file-name buffer-file-name))))

(defvar exps-new-expectations-message "<span class="quote">+++++ New expectations +++++</span>")

(defun exps-execute-test (test)
  (destructuring-bind (expect expected . actual)
      test
    (case expect
      (expect
          (if debug-on-error
              (exps-assert expected actual)
            (condition-case e
                (exps-assert expected actual)
              (error (cons 'error e)))))
      (desc
       (cons 'desc expected))
      (new-expectations
       (cons 'desc (concat exps-new-expectations-message))))))


(defvar exps-last-error-position nil)
(defun expectations-execute (&optional testcase)
  "<span class="quote">Execute last-defined `expectations' test.
With prefix argument, do `batch-expectations-in-emacs'.</span>"
  (interactive)
  (setq exps-last-error-position nil)
  (if current-prefix-arg
      (batch-expectations-in-emacs)
    (exps-display
     (mapcar 'exps-execute-test (or testcase exps-last-testcase)))))

<span class="linecomment">;;;; assertions</span>
(defvar exps-assert-functions
  '(exps-assert-non-nil
    exps-assert-true
    exps-assert-buffer
    exps-assert-regexp
    exps-assert-type
    exps-assert-error
    exps-assert-error-message
    exps-assert-no-error
    exps-assert-mock
    exps-assert-not-called
    exps-assert-equal-eval))

(defun exps-do-assertion (expected actual symbol evalp test-func msg-func &optional expected-get-func)
  (and (consp expected)
       (eq symbol (car expected))
       (exps-do-assertion-1 (funcall (or expected-get-func #'cadr) expected)
                            actual evalp test-func msg-func)))

(defun exps-do-assertion-1 (expected actual evalp test-func msg-func)
  (if evalp (setq actual (exps-eval-sexps actual)))
  (if (funcall test-func expected actual)
      '(pass)
    (cons 'fail (funcall msg-func expected actual))))

(defun exps-eval-sexps (sexps)
  (let ((fn (lambda () (eval `(progn ,@sexps)))))
    (if (fboundp 'mock-protect)
        (mock-protect fn)
      (funcall fn))))

(defun exps-assert-non-nil (expected actual)
  (exps-do-assertion
   expected actual 'non-nil t
   (lambda (e a) (not (null a)))
   (lambda (e a) (format "<span class="quote">FAIL: Expected non-nil but was nil</span>"))))

(defun exps-assert-true (expected actual)
  (exps-do-assertion
   expected actual 'true t
   (lambda (e a) (not (null a)))
   (lambda (e a) (format "<span class="quote">FAIL: Expected non-nil but was nil</span>"))))
(defun exps-assert-buffer (expected actual)
  (exps-do-assertion
   expected actual 'buffer t
   (lambda (e a) (eq (get-buffer e) a))
   (lambda (e a) (format "<span class="quote">FAIL: Expected &lt;#&lt;buffer %s&gt;&gt; but was &lt;%S&gt;</span>" e a))))

(defun exps-assert-regexp (expected actual)
  (exps-do-assertion
   expected actual 'regexp t
   (lambda (e a) (string-match e a))
   (lambda (e a) (format "<span class="quote">FAIL: %S should match /%s/</span>" a e))))

(defun exps-assert-type (expected actual)
  (exps-do-assertion
   expected actual 'type t
   (lambda (e a) (or (eq (type-of a) e)
                     (let* ((name (symbol-name e))
                            (pred (intern
                                   (concat name (if (string-match "<span class="quote">-</span>" name)
                                                    "<span class="quote">-p</span>"
                                                  "<span class="quote">p</span>")))))
                     (when (fboundp pred)
                       (funcall pred a)))))
   (lambda (e a) (format "<span class="quote">FAIL: %S is not a %s</span>" a e))))

(defun exps-assert-error (expected actual)
  (let (actual-error actual-errdata)
    (exps-do-assertion
     expected actual 'error nil
     (lambda (e a)
       (condition-case err
           (progn (exps-eval-sexps a) nil)
         (error
          (setq actual-error err)
          (cond ((cadr e)
                 (and (eq (car e) (car err))
                      (or (eq (cadr e) '*)
                          (equal (setq actual-errdata (eval (cadr e)))
                                 (cdr err)))))
                (e
                 (equal e err))
                (t
                 t)))))
     (lambda (e a)
       (let ((error-type (car e))
             (actual-err-string
              (if actual-error
                  (format "<span class="quote">, but raised &lt;%S&gt;</span>" actual-error)
                "<span class="quote">, but no error was raised</span>")))
         (cond ((and error-type (eq error-type (car actual-error)))
                (format "<span class="quote">FAIL: Expected errdata &lt;%S&gt;, but was &lt;%S&gt;</span>" actual-errdata (cdr actual-error)))
               (error-type
                (format "<span class="quote">FAIL: should raise &lt;%s&gt;%s</span>" error-type actual-err-string))
               (t
                (format "<span class="quote">FAIL: should raise any error%s</span>" actual-err-string)))))
     #'cdr)))

(defun exps-assert-no-error (expected actual)
  (let (actual-error-string)
    (exps-do-assertion
     expected actual 'no-error nil
     (lambda (e a)
       (condition-case err
           (progn (exps-eval-sexps a) t)
         (error
          (setq actual-error-string (error-message-string err))
          nil)))
     (lambda (e a)
       (format "<span class="quote">FAIL: Expected no error, but error &lt;%s&gt; was raised</span>" actual-error-string)))))

(defun exps-assert-error-message (expected actual)
  (let (actual-error-string)
    (exps-do-assertion
     expected actual 'error-message nil
     (lambda (e a)
       (condition-case err
           (progn (exps-eval-sexps a) nil)
         (error
          (setq actual-error-string (error-message-string err))
          (equal e actual-error-string))))
     (lambda (e a)
       (if actual-error-string
           (format "<span class="quote">FAIL: Expected errmsg &lt;%s&gt;, but was &lt;%s&gt;</span>" e actual-error-string)
         (format "<span class="quote">FAIL: Expected errmsg &lt;%s&gt;, but no error was raised</span>" e))))))


(defun exps-assert-mock (expected actual)
  (let (err)
    (exps-do-assertion
     expected actual 'mock nil
     (lambda (e a)
       (condition-case me
           (progn
             (mock-protect
              (lambda ()
                (eval `(mock ,@e))
                (eval `(progn ,@a))))
             t)
         (mock-error (setq err me) nil))
       (if err nil t))
     (lambda (e a)
       (if (eq 'not-called (cadr err))
           (format "<span class="quote">FAIL: Expected function call &lt;%S&gt;</span>" e)
         (destructuring-bind (_  e-args  a-args) err
           (format "<span class="quote">FAIL: Expected call &lt;%S&gt;, but was &lt;%S&gt;</span>" e-args a-args))))
     #'cdr)))

(defun exps-assert-not-called (expected actual)
  (let (err)
    (exps-do-assertion
     expected actual 'not-called nil
     (lambda (e a)
       (condition-case me
           (progn
             (mock-protect
              (lambda ()
                (eval `(not-called ,@e))
                (eval `(progn ,@a))))
             t)
         (mock-error (setq err me) nil))
       (if err nil t))
     (lambda (e a)
       (if (eq 'called (cadr err))
           (format "<span class="quote">FAIL: Expected not-called &lt;%S&gt;</span>" e)))
     #'cdr)))
(defun exps-assert-equal-eval (expected actual)
  (exps-do-assertion-1
   (eval expected) actual t
   (lambda (e a) (equal e a))
   (lambda (e a) (format "<span class="quote">FAIL: Expected &lt;%S&gt; but was &lt;%S&gt;</span>" expected a))))

(defun exps-assert (expected actual)
  (run-hook-with-args-until-success 'exps-assert-functions expected actual))

<span class="linecomment">;;;; next-error interface / occur-mode-like interface</span>
(define-derived-mode exps-display-mode fundamental-mode "<span class="quote">EXPECT</span>"
  (buffer-disable-undo)
  (setq next-error-function 'exps-next-error)
  (setq next-error-last-buffer (current-buffer))
  (define-key exps-display-mode-map "<span class="quote">\C-m</span>" 'exps-goto-expect)
  (define-key exps-display-mode-map "<span class="quote">\C-c\C-c</span>" 'exps-goto-expect))

(defun exps-desc (desc)
  (propertize desc 'face 'highlight))

(defface expectations-red
  '((t (:foreground "<span class="quote">Red</span>" :bold t)))
  "<span class="quote">Face for expectations with failure.</span>"
  :group 'el-expectations)
(defface expectations-green
  '((t (:foreground "<span class="quote">Green</span>" :bold t)))
  "<span class="quote">Face for successful expectations.</span>"
  :group 'el-expectations)
(defvar exps-red-face 'expectations-red)
(defvar exps-green-face 'expectations-green)
(defun exps-result-string (s f e)
  (let ((msg1 (format "<span class="quote">%d expectations, %d failures, %d errors\n</span>"
                      (+ s f e) f e))
        (msg2 (format "<span class="quote">Expectations finished at %s\n</span>"  (current-time-string))))
    (put-text-property 0 (length msg1) 'face
                       (if (zerop (+ f e))
                           exps-green-face
                         exps-red-face) msg1)
    (concat msg1 msg2)))

(defun exps-display (results)
  (with-current-buffer (get-buffer-create expectations-result-buffer)
    (erase-buffer)
    (exps-display-mode)
    (insert (format "<span class="quote">Executing expectations in %s...\n</span>" exps-last-filename))
    (loop for result in results
          for i from 1
          do (insert
              (format
               "<span class="quote">%-3d:%s\n</span>" i
               (if (consp result)
                   (case (car result)
                     (pass "<span class="quote">OK</span>")
                     (fail (cdr result))
                     (error (format "<span class="quote">ERROR: %s</span>" (cdr result)))
                     (desc (exps-desc (cdr result)))
                     (t "<span class="quote">not happened!</span>"))
                 result))))
    (insert "<span class="quote">\n</span>")
    (loop for result in results
          for status = (car result)
          when (eq 'pass status) collecting result into successes
          when (eq 'fail status) collecting result into failures
          when (eq 'error status) collecting result into errors
          with summary
          finally
          (destructuring-bind (s f e)
              (mapcar #'length (list successes failures errors))
            (setq summary (exps-result-string s f e))
            (insert summary)
            (goto-char (point-min))
            (forward-line 1)
            (insert summary)
            (goto-char (point-min))
            (return (+ f e))))
    (display-buffer (current-buffer))))

(defun exps-goto-expect ()
  (interactive)
  <span class="linecomment">;; assumes that current-buffer is *expectations result*</span>
  (let ((expectations-count 0)
        (pt (point))
        (n (exps-current-no))
        this-new-expectations)
    (when exps-last-filename
      (save-excursion
        (goto-char (point-min))
        (while (search-forward exps-new-expectations-message pt t) <span class="linecomment">;TODO accurate message</span>
          (incf expectations-count))
        (setq this-new-expectations
              (exps-current-no)))

      (with-current-buffer (find-file-noselect exps-last-filename)
        (if (eq expectations-execute-at-once 'all)
            (goto-char (point-min))
          (goto-char exps-last-position)
          (beginning-of-defun))
        (when this-new-expectations
          (decf n this-new-expectations)
          (dotimes (i (1- this-new-expectations))
            (search-forward "<span class="quote">(expectations\n</span>" nil t)))
        (pop-to-buffer (current-buffer))
        (search-forward "<span class="quote">(expectations\n</span>" nil t)
        (forward-sexp n)
        (forward-sexp -1)))))

(defun exps-current-no ()
  (with-current-buffer (exps-result-buffer)
    (and (forward-line 0)
         (looking-at "<span class="quote">^[0-9]+</span>")
         (string-to-number (match-string 0)))))

(defun exps-result-buffer ()
  (if (next-error-buffer-p (current-buffer))
      (current-buffer)
    (next-error-find-buffer nil nil
                            (lambda ()
                              (eq major-mode 'exps-display-mode)))))

(defun exps-next-error (&optional argp reset)
  "<span class="quote">Move to the Nth (default 1) next failure/error in *expectations result* buffer.
Compatibility function for \\[next-error] invocations.</span>"
  (interactive "<span class="quote">p</span>")
  <span class="linecomment">;; we need to run exps-find-failure from within the *expectations result* buffer</span>
  (with-current-buffer (exps-result-buffer) 
    <span class="linecomment">;; In case the *expectations result* buffer is visible in a nonselected window.</span>
    (let ((win (get-buffer-window (current-buffer) t)))
      (if win (set-window-point win (point))))
    (and exps-last-error-position (goto-char exps-last-error-position))
    (goto-char (cond (reset (point-min))
		     ((&lt; argp 0) (line-beginning-position))
		     ((&lt; 0 argp) (line-end-position))
		     ((point))))
    <span class="linecomment">;; (message (format "argp=%d reset=%S %s"argp reset (buffer-substring-no-properties (point-at-bol) (point-at-eol))))</span>
    (exps-find-failure
     (abs argp)
     (if (&lt; argp 0)
	 #'re-search-backward
       #'re-search-forward)
     "<span class="quote">No more failures</span>")
    <span class="linecomment">;; (message (format "argp=%d reset=%S %s"argp reset (buffer-substring-no-properties (point-at-bol) (point-at-eol))))</span>
    (exps-goto-expect)
    (setq exps-last-error-position (point))))

(defun exps-find-failure (n search-func errmsg)
  (loop repeat n do
        (unless (funcall search-func "<span class="quote">^[0-9]+ *:\\(ERROR\\|FAIL\\)</span>" nil t)
          (error errmsg)))
  (point))

<span class="linecomment">;;;; edit support</span>
(put 'expect 'lisp-indent-function 1)
(put 'expectations 'lisp-indent-function 0)

<span class="linecomment">;; (edit-list (quote font-lock-keywords-alist))</span>
(dolist (mode '(emacs-lisp-mode lisp-interaction-mode))
  (font-lock-add-keywords
   mode
   '(("<span class="quote">\\&lt;\\(expectations\\|expect\\)\\&gt;</span>" 0 font-lock-keyword-face)
     (exps-font-lock-desc 0 font-lock-warning-face prepend)
     (exps-font-lock-expected-value 0 font-lock-function-name-face prepend))))

(defun exps-font-lock-desc (limit)
  (when (re-search-forward "<span class="quote">(desc\\s </span>" limit t)
    (backward-up-list 1)
    (set-match-data (list (point) (progn (forward-sexp 1) (point))))
    t))

<span class="linecomment">;; I think expected value is so-called function name of `expect'.</span>
(defun exps-font-lock-expected-value (limit)
  (when (re-search-forward "<span class="quote">(expect\\s </span>" limit t)
    (forward-sexp 1)
    (let ((e (point)))
      (forward-sexp -1)
      (set-match-data (list (point) e))
        t)))

(defun expectations-eval-defun (arg)
  "<span class="quote">Do `eval-defun'.
If `expectations-execute-at-once' is non-nil, execute expectations if it is an expectations form.</span>"
  (interactive "<span class="quote">P</span>")
  (setq exps-last-position (point))
  (eval-defun arg)
  (when (exps-current-form-is-expectations)
    (when (eq expectations-execute-at-once 'all)
      (setq exps-last-testcase nil)
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward "<span class="quote">^\\s-*(expectations\n</span>" nil t)
          (eval-defun arg))))
    (expectations-execute)))

(defun exps-current-form-is-expectations ()
  (save-excursion
    (beginning-of-defun)
    (looking-at "<span class="quote">(expectations\\|(.+(fboundp 'expectations)\\|(dont-compile\n.*expectations</span>")))

(substitute-key-definition 'eval-defun 'expectations-eval-defun emacs-lisp-mode-map)
(substitute-key-definition 'eval-defun 'expectations-eval-defun lisp-interaction-mode-map)

<span class="linecomment">;;;; To avoid test duplication</span>
(defadvice load (before el-expectations activate)
  (and (equal exps-last-filename (locate-library (ad-get-arg 0)))
       (setq exps-last-testcase nil)))
<span class="linecomment">;; (progn (ad-disable-advice 'load 'before 'el-expectations) (ad-update 'load))</span>

(defadvice eval-buffer (before el-expectations activate)
  (and buffer-file-name
       (equal exps-last-filename buffer-file-name)
       (setq exps-last-testcase nil)))
<span class="linecomment">;; (progn (ad-disable-advice 'eval-buffer 'before 'el-expectations) (ad-update 'eval-buffer))</span>
<span class="linecomment">;;;; batch mode</span>
(defun batch-expectations ()
  (if (not noninteractive)
      (error "<span class="quote">`batch-expectations' is to be used only with -batch</span>"))
  (destructuring-bind (output-file . lispfiles)
      command-line-args-left
    (dolist (lispfile lispfiles)
      (load lispfile nil t))
    (let ((fail-and-errors (expectations-execute)))
      (with-current-buffer expectations-result-buffer
        (write-region (point-min) (point-max) output-file nil 'nodisp))
      (kill-emacs fail-and-errors))))

(defun batch-expectations-in-emacs ()
  "<span class="quote">Execute expectations in current file with batch mode.</span>"
  (interactive)
  (shell-command (concat "<span class="quote">el-expectations </span>" exps-last-filename)
                 expectations-result-buffer)
  (with-current-buffer expectations-result-buffer
    (goto-char (point-min))
    (while (re-search-forward "<span class="quote">^[0-9].+\\([0-9]\\) failures, \\([0-9]+\\) errors</span>" nil t)
      (put-text-property (match-beginning 0) (match-end 0)
                         'face
                         (if (and (string= "<span class="quote">0</span>" (match-string 1))
                                  (string= "<span class="quote">0</span>" (match-string 2)))
                             exps-green-face
                           exps-red-face)))))

<span class="linecomment">;;;; Bug report</span>
(defvar exps-maintainer-mail-address
  (concat "<span class="quote">rubiki</span>" "<span class="quote">tch@ru</span>" "<span class="quote">by-lang.org</span>"))
(defvar exps-bug-report-salutation
  "<span class="quote">Describe bug below, using a precise recipe.

When I executed M-x ...

How to send a bug report:
  1) Be sure to use the LATEST version of el-expectations.el.
  2) Enable debugger. M-x toggle-debug-on-error or (setq debug-on-error t)
  3) Use Lisp version instead of compiled one: (load \"el-expectations.el\")
  4) If you got an error, please paste *Backtrace* buffer.
  5) Type C-c C-c to send.
# If you are a Japanese, please write in Japanese:-)</span>")
(defun exps-send-bug-report ()
  (interactive)
  (reporter-submit-bug-report
   exps-maintainer-mail-address
   "<span class="quote">el-expectations.el</span>"
   (apropos-internal "<span class="quote">^exps-</span>" 'boundp)
   nil nil
   exps-bug-report-salutation))


(provide 'el-expectations)

<span class="linecomment">;; How to save (DO NOT REMOVE!!)</span>
<span class="linecomment">;; (emacswiki-post "el-expectations.el")</span>
<span class="linecomment">;;; el-expectations.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=el-expectations.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=el-expectations.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=el-expectations.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=el-expectations.el">Administration</a></span><span class="time"><br /> Last edited 2010-05-04 08:48 UTC by <a class="author" title="from 124-144-92-34.rev.home.ne.jp" href="http://www.emacswiki.org/emacs/rubikitch">rubikitch</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=el-expectations.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
