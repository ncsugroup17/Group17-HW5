BEGIN {
    FS = "[ \t\n]+"
    OFS = ","
}

# First pass: collect top words
PASS == 1 {
    top_words[NR] = $0
    word_count = NR
}

# Second pass: initialize for paragraph processing
PASS == 2 && FNR == 1 {
    # Print header with top words
    for (i = 1; i <= word_count; i++) {
        printf("%s%s", top_words[i], (i < word_count ? OFS : ""))
    }
    print ""
    
    # Initialize counts array for first paragraph
    for (i = 1; i <= word_count; i++) {
        counts[i] = 0
    }
    
    # Initialize paragraph tracking
    para_count = 0
    in_paragraph = 0
}

# Second pass: process paragraphs
PASS == 2 {
    # Empty line indicates paragraph boundary
    if ($0 == "") {
        if (in_paragraph) {
            # Print counts for the current paragraph
            for (i = 1; i <= word_count; i++) {
                printf("%d%s", counts[i], (i < word_count ? OFS : ""))
            }
            print ""
            
            # Reset counts for next paragraph
            for (i = 1; i <= word_count; i++) {
                counts[i] = 0
            }
            
            in_paragraph = 0
        }
    } 
    # Non-empty line - process words
    else {
        in_paragraph = 1
        
        # Process each word in the line
        for (i = 1; i <= NF; i++) {
            # Check if this word matches any top word
            for (j = 1; j <= word_count; j++) {
                if ($i == top_words[j]) {
                    counts[j]++
                }
            }
        }
    }
}

# Handle the last paragraph
END {
    if (PASS == 2 && in_paragraph) {
        # Print counts for the last paragraph
        for (i = 1; i <= word_count; i++) {
            printf("%d%s", counts[i], (i < word_count ? OFS : ""))
        }
        print ""
    }
}
