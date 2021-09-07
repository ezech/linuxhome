set background=dark
set nu
imap jj <Esc>
nmap =j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"
nmap =x :%!xmllint --format %
nmap =s :%s/[ ]*$//
set laststatus=2
set showtabline=2
set noshowmode
set t_Co=256
