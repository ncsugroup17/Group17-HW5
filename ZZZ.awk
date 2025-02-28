BEGIN {
    split("challenging do key and data example aspect engineering we", top_words)
    for (i in top_words) {
        word_order[top_words[i]] = i
    }
    para = 0
}

{
    para++
    for (word in word_order) {
        count[para, word] = 0
    }
    
    split(tolower($0), words)
    for (i in words) {
        if (words[i] in word_order) {
            count[para, words[i]]++
        }
    }
}

END {
    for (i = 1; i <= length(top_words); i++) {
        printf "%s,", top_words[i]
    }
    printf "\n"
    
    for (p = 1; p <= para; p++) {
        for (i = 1; i <= length(top_words); i++) {
            printf "%d,", count[p, top_words[i]]
        }
        printf "\n"
    }
}