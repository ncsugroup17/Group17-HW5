BEGIN {
    FS = "[ \t\n\r,.!?;:()\"]+"  # Define field separator to split words properly

    # First Pass: Read the list of top words
    if (PASS == 1) {
        while (getline word < ARGV[1]) {
            top_words[tolower(word)] = 1  # Store words in an array
        }
        close(ARGV[1])  # Close the top words file
        delete ARGV[1]  # Remove the processed file from ARGV to avoid errors
    }
}

# Second Pass: Process cleaned text file and count word frequencies per paragraph
PASS == 2 {
    paragraph_number++  # Increment paragraph count

    # Initialize a dictionary to store word frequencies
    for (word in top_words) {
        word_count[word] = 0
    }

    # Read the current paragraph and count words
    for (i = 1; i <= NF; i++) {
        word = tolower($i)  # Convert to lowercase
        if (word in top_words) {
            word_count[word]++  # Increment count if it's a top word
        }
    }

    # Print the results
    printf("Paragraph %d:\n", paragraph_number)
    for (word in top_words) {
        printf("%s: %d\n", word, word_count[word])
    }
    print "-------------------"
}