BEGIN {RS=""; FS="[ \n]+"} 
{ 
    for (i=1; i <= NF; i++) 
        if ($i ~ /./) 
            word[$i]++
} 
END { 
    for (w in word) 
        print word[w], w
}