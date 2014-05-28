;;; Compiled snippets and support files for `php+-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'php+-mode
                     '(("priv" "// @var ${1:string}\nprivate \\$${2:field};$0\n\n/**\n* @return $1\n*/\npublic function get${2:$(upcase-initials text)}()\n{\n	return \\$this->$2;\n}\n\n/**\n*\n*/\npublic function set${2:$(upcase-initials text)}(\\$value)\n{\n	\\$this->$2 = \\$value;\n}" "classvar" nil nil
                        ((yas/indent-line 'auto))
                        nil nil nil)
                       ("dump" "error_log(\"${1}\" . print_r(\\$${2}, true));" "dump" nil nil
                        ((yas/indent-line 'auto))
                        nil nil nil)
                       ("ent" "protected \\$${1:field};$0\n\n/**\n* @return $1\n*/\npublic function get${1:$(upcase-initials text)}()\n{\n	return \\$this->$1;\n}\n\n/**\n* @param $1\n*/\npublic function set${1:$(upcase-initials text)}(\\$$1)\n{\n	\\$this->$1 = \\$$1;\n}" "Entity instance var" nil nil
                        ((yas/indent-line 'auto)
                         (yas/also-auto-indent-first-line 'y))
                        nil nil nil)
                       ("err" "error_log(\"${msg}\");" "error_log" nil nil
                        ((yas/indent-line 'auto))
                        nil nil nil)
                       ("stack" "$e = new \\Exception;\nerror_log(print_r(\\$e->getTraceAsString(), TRUE));" "stack" nil nil
                        ((yas/indent-line 'auto))
                        nil nil nil)))


;;; Do not edit! File generated at Mon May 12 15:35:14 2014
