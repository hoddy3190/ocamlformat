#!/bin/perl

use warnings;
use strict;
use utf8;

my $opt_src_list = [
    [qw/ --align-constructors-decl --align-variants-decl --align-cases --break-cases=all align_cases.ml /],
    [qw/ --align-constructors-decl --align-variants-decl --align-cases align_cases.ml /],
    [qw/ --break-infix=fit-or-vertical align_infix.ml /],
    [qw/ --assignment-operator=begin-line assignment_operator.ml /],
    [qw/ --break-before-in=auto break_before_in.ml /],
    [qw/ --break-before-in=fit-or-vertical break_before_in.ml /],
    [qw/ --nested-match=align --break-cases=all break_cases.ml /],
    [qw/ --break-cases=all break_cases.ml /],
    [qw/ --break-cases=all --indicate-multiline-delimiters=closing-on-separate-line break_cases.ml /],
    [qw/ --break-cases=all --indicate-multiline-delimiters=closing-on-separate-line --leading-nested-match-parens break_cases.ml /],
    [qw/ --break-cases=all --indicate-multiline-delimiters=closing-on-separate-line --leading-nested-match-parens --cases-matching-exp-indent=normal break_cases.ml /],
    [qw/ --break-cases=fit-or-vertical break_cases.ml /],
    [qw/ --break-cases=nested break_cases.ml /],
    [qw/ --cases-matching-exp-indent=normal --break-cases=all break_cases.ml /],
    [qw/ --break-cases=toplevel --max-iter=4 break_cases.ml /],
    [qw/ --break-cases=fit --max-iter=4 break_cases.ml /],
    [qw/ --break-fun-decl=fit-or-vertical --break-fun-sig=fit-or-vertical break_fun_decl.ml /],
    [qw/ --break-fun-decl=smart --break-fun-sig=smart break_fun_decl.ml /],
    [qw/ --break-fun-decl=wrap --break-fun-sig=wrap break_fun_decl.ml /],
    [qw/ --profile=janestreet --margin=58 break_record.ml /],
    [qw/ --break-separators=after --max-iter=3 break_separators.ml /],
    [qw/ --break-separators=after --dock-collection-brackets --max-iter=3 break_separators.ml /],
    [qw/ --break-separators=after --break-collection-expressions=wrap --dock-collection-brackets break_separators.ml /],
    [qw/ --break-separators=after --break-collection-expressions=wrap break_separators.ml /],
    [qw/ --break-separators=before --dock-collection-brackets --max-iter=3 break_separators.ml /],
    [qw/ --break-separators=before --break-collection-expressions=wrap --dock-collection-brackets break_separators.ml /],
    [qw/ --break-separators=before --break-collection-expressions=wrap break_separators.ml /],
    [qw/ --break-separators=before --max-iter=3 break_separators.ml /],
    [qw/ --break-string-literals=never break_string_literals.ml /],
    [qw/ --break-string-literals=wrap break_string_literals.ml /],
    [qw/ --break-string-literals=auto break_string_literals.ml /],
    [qw/ --config=module-item-spacing=compact --module-item-spacing=sparse cmdline_override.ml /],
    [qw/ --module-item-spacing=sparse --config=module-item-spacing=compact cmdline_override2.ml /],
    [qw/ --max-iter=4 comments.ml /],
    [qw/ --max-iter=4 comments_args.ml /],
    [qw/ --disable disabled.ml /],
    [qw/ --doc-comments=after-when-possible doc_comments.ml /],
    [qw/ --doc-comments=before-except-val doc_comments.ml /],
    [qw/ --doc-comments=before doc_comments.ml /],
    [qw/ --no-comment-check error4.ml /],
    [qw/ --exp-grouping=parens exp_grouping.ml /],
    [qw/ --exp-grouping=preserve exp_grouping.ml /],
    [qw/ --max-iters=3 --extension-indent=5 --stritem-extension-indent=3 extensions.ml /],
    [qw/ --extension-indent=5 --stritem-extension-indent=3 extensions.mli /],
    [qw/ --max-iters=3 --extension-sugar=always extensions.ml /],
    [qw/ --max-iters=3 extensions.ml /],
    [qw/ --assignment-operator=begin-line field.ml /],
    [qw/ --format-invalid-files=auto format_invalid_files.ml /],
    [qw/ --function-indent=4 --function-indent-nested=never function_indent.ml /],
    [qw/ --function-indent=4 --function-indent-nested=always function_indent.ml /],
    [qw/ --break-infix=wrap --break-infix-before-func infix_bind.ml /],
    [qw/ --break-infix=fit-or-vertical --break-infix-before-func infix_bind.ml /],
    [qw/ --break-infix=fit-or-vertical --no-break-infix-before-func infix_bind.ml /],
    [qw/ --break-infix=wrap --no-break-infix-before-func infix_bind.ml /],
    [qw/ --infix-precedence=parens infix_precedence.ml /],
    [qw/ --if-then-else=compact ite.ml /],
    [qw/ --if-then-else=compact --indicate-multiline-delimiters=closing-on-separate-line ite.ml /],
    [qw/ --if-then-else=fit-or-vertical ite.ml /],
    [qw/ --if-then-else fit-or-vertical --indicate-multiline-delimiters=closing-on-separate-line ite.ml /],
    [qw/ --if-then-else=fit-or-vertical --indicate-multiline-delimiters=no ite.ml /],
    [qw/ --if-then-else=k-r --max-iters=3 ite.ml /],
    [qw/ --if-then-else=k-r --max-iters=3 --indicate-multiline-delimiters=closing-on-separate-line ite.ml /],
    [qw/ --if-then-else=keyword-first ite.ml /],
    [qw/ --if-then-else keyword-first --indicate-multiline-delimiters=closing-on-separate-line ite.ml /],
    [qw/ --if-then-else=keyword-first --indicate-multiline-delimiters=no ite.ml /],
    [qw/ --if-then-else=compact --indicate-multiline-delimiters=no ite.ml /],
    [qw/ --if-then-else=compact ite.ml /],
    [qw/ --profile=janestreet js_sig.mli /],
    [qw/ --max-iters=3 --profile=janestreet js_source.ml /],
    [qw/ --max-iters=4 label_option_default_args.ml /],
    [qw/ --indent-after-in=4 let_binding.ml /],
    [qw/ --let-binding-indent=6 let_binding.ml /],
    [qw/ --let-module=sparse let_module.ml /],
    [qw/ --let-module=compact let_module.ml /],
    [qw/ --space-around-arrays --space-around-lists --space-around-records --space-around-variants list.ml /],
    [qw/ --margin=80 margin_80.ml /],
    [qw/ --leading-nested-match-parens match2.ml /],
    [qw/ --match-indent=4 --match-indent-nested=never match_indent.ml /],
    [qw/ --match-indent=4 --match-indent-nested=always match_indent.ml /],
    [qw/ --max-indent=2 max_indent.ml /],
    [qw/ --max-iter=3 --module-item-spacing=preserve module_item_spacing.ml /],
    [qw/ --max-iter=3 --module-item-spacing=sparse module_item_spacing.ml /],
    [qw/ --max-iter=3 --module-item-spacing=compact module_item_spacing.ml /],
    [qw/ --max-iter=3 module_item_spacing.mli /],
    [qw/ --max-iters=1 need_format.ml /],
    [qw/ --ocp-indent-config ocp_indent_options.ml /],
    [qw/ --let-open=auto open.ml /],
    [qw/ --let-open=long open.ml /],
    [qw/ --let-open=preserve open.ml /],
    [qw/ --let-open=short open.ml /],
    [qw/ --config=margin=20 --profile=janestreet --module-item-spacing=sparse profiles.ml /],
    [qw/ --profile=janestreet profiles2.ml /],
    [qw/ --field-space=loose record.ml /],
    [qw/ --field-space=tight-decl record.ml /],
    [qw/ --field-space=tight record.ml /],
    [qw/ --max-iter=2 reformat_string.ml /],
    [qw/ --sequence-blank-line=preserve-one --max-iter=3 sequence.ml /],
    [qw/ --sequence-blank-line=compact --max-iter=3 sequence.ml /],
    [qw/ --max-iters=3 source.ml /],
    [qw/ --parens-tuple=always tuple.ml /],
    [qw/ --parens-tuple=multi-line-only tuple_less_parens.ml /],
    [qw/ --type-decl=compact --space-around-arrays --space-around-lists --space-around-records --space-around-variants --break-separators=after --dock-collection-brackets types.ml /],
    [qw/ --type-decl=compact --space-around-arrays --space-around-lists --space-around-records --space-around-variants types.ml /],
    [qw/ --type-decl=compact types.ml /],
    [qw/ --type-decl-indent=6 types.ml /],
    [qw/ --type-decl=sparse --space-around-arrays --space-around-lists --space-around-records --space-around-variants types.ml /],
    [qw/ --type-decl=sparse types.ml /],
    [qw/ --margin=80 --wrap-comments unicode.ml /],
    [qw/ --no-wrap-fun-args --margin=67 wrap_comments_break.ml /],
    [qw/ --disambiguate-non-breaking-match align_cases.ml/ ]
];

my $opt_src_hash = {};

for my $opt_src (@$opt_src_list) {
    my $src = pop @$opt_src;
    for my $opt (@$opt_src) {
        $opt_src_hash->{$opt} = $src;
    }
}

system ("echo '' > ../../formatSample.md");
for my $opt (sort keys $opt_src_hash) {
    my $src = $opt_src_hash->{$opt};
    system ("echo \'\<details\>\<summary\>$opt $src\<\/summary\>\' >> ../../formatSample.md");
    system ("echo '' >> ../../formatSample.md");
    system ("echo \'\`\`\`\' >> ../../formatSample.md");
    system ("ocamlformat $opt $src > fuga.txt; diff -u -L origin -L formatted $src fuga.txt >> ../../formatSample.md");
    system ("echo \'\`\`\`\' >> ../../formatSample.md");
    system ("echo \"\n\<\/details\>\" >> ../../formatSample.md");
}
