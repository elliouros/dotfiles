# config.nu

$env.LANG = 'en_US.UTF-8'

$env.VISUAL = 'helix'
$env.config.buffer_editor = 'helix'
$env.config.edit_mode = 'vi'

$env.config.filesize.unit = 'binary'

$env.config.history.file_format = 'sqlite'

$env.PROMPT_COMMAND = {
  const colors = [
    "\e[34m"
    "\e[38;5;211m"
    "\e[97m"
    "\e[38;5;211m"
  ]
  const meta = '([\\\^\$\.\|\?\*\+\(\)\[\]\{\}])'
  # To show all directories fully, set $env.nu_full_dirs to true
  # To use default behavior, either hide-env nu_full_dirs or set it to 1
  # To show x amount of directories, set nu_full_dirs to x
  let full_dirs = $env.nu_full_dirs? | default 1
  pwd
  | str replace -r $'^($nu.home-path | str replace -ar $meta '\$1')' '~'
  | if ($full_dirs == true) {return $in} else {$in}
  | path split
  | [
    ...(
      $in
      | drop $full_dirs
      | each {
        str replace -r '^(\.?.).*$' '$1'
      }
    )
    ...($in | last $full_dirs)
  ]
  | enumerate
  | each {|dir|
    $colors
    | get ($dir.index mod ($colors | length))
    | $in ++ (
      match $dir.item { '/' => {''}, $x => {$x} }
    )
  }
  | str join '/'
  | if ($in | ansi strip | is-empty) {$'($in)/'} else {$in}
}

$env.PROMPT_COMMAND_RIGHT = {
  $env.LAST_EXIT_CODE
  | if $in != 0 { $'(ansi rb)[($in)]' }
}

$env.PATH ++= [
  '~/.local/share/gem/ruby/3.4.0/bin'
  '~/.local/bin'
  '~/.bin'
] | path expand
$env.PATH ++= ['.']
$env.PATH = $env.PATH | uniq

def banner [] {
  source ~/.config/nushell/greet.nu
}
