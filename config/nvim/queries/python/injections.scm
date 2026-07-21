;; extends

((comment) @injection.content
  (#lua-match? @injection.content "%$")
  (#set! injection.language "latex"))

((string_content) @injection.content
  (#lua-match? @injection.content "%$")
  (#set! injection.language "latex"))
