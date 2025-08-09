#!/bin/bash


# 1. Top 5 Contributors by Commit Count
cut -d',' -f2 vscode_gitlog.csv | sort | uniq -c | sort -nr | head -5 > top_authors.dat

# 2. Most Active Commit Days (Top 5)
cut -d',' -f3 vscode_gitlog.csv | sort | uniq -c | sort -nr | head -5 > op_days.dat

# 3. Commit Count Per Month
cut -d',' -f3 vscode_gitlog.csv | cut -c1-7 | sort | uniq -c | sort -k2 > commits_per_month.dat

# 4. Commits by Each Author (Alphabetical)
cut -d',' -f2 vscode_gitlog.csv | sort | uniq -c | sort -k2 > author_commits.dat

# 5. Commits Per Year
cut -d',' -f3 vscode_gitlog.csv | cut -c1-4 | sort | uniq -c > commits_per_year.dat

# 6. Count Commits with "fix" in Message
grep -i 'fix' vscode_gitlog.csv | wc -l 

# 7. List of All Commit Hashes (Short)
cut -d',' -f1 vscode_gitlog.csv | cut -c1-7 | head

# 8. Search for Commits Containing Keyword 
grep -i 'Hello' vscode_gitlog.csv 
# 9. Total Number of Commits
wc -l < vscode_gitlog.csv 

# 10. All Unique Commit Messages
cut -d',' -f4 vscode_gitlog.csv | sort | uniq 

# ---------------------
# Graphs using gnuplot
# ---------------------

gnuplot <<EOF
set terminal png size 800,600
set output 'top_authors.png'
set style data histogram
set style fill solid 1.00 border -1
set boxwidth 0.6
set title "Top 5 Contributors by Commit Count"
set xlabel "Author"
set ylabel "Commits"
set xtics rotate by -45
plot ‘top_authors.dat' using 1:xtic(2) title ''


gnuplot <<EOF
set terminal png size 800,600
set output 'top_days.png'
set style data histogram
set boxwidth 0.5
set title "Most Active Commit Days"
set xlabel "Date"
set ylabel "Commits"
set xtics rotate by -45
plot 'top_days.dat' using 1:xtic(2) title ''


gnuplot <<EOF
set terminal png size 1000,400
set output 'commits_per_month.png'
set xdata time
set timefmt "%Y-%m"
set format x "%Y-%m"
set title "Commits Per Month"
set xlabel "Month"
set ylabel "Commits"
set grid
plot 'commits_per_month.dat' using 2:1 with linespoints title 'Commits'


gnuplot <<EOF
set terminal png size 1000,600
set output 'author_commits.png'
set style data histograms
set style fill solid 1.0 border -1
set boxwidth 0.6
set title "Commits by Author"
set xlabel "Author"
set ylabel "Commits"
set xtics rotate by -45
plot 'author_commits.dat' using 1:xtic(2) notitle


gnuplot <<EOF
set terminal png size 800,600
set output 'commits_per_year.png'
set style data histogram
set title "Commits per Year"
set xlabel "Year"
set ylabel "Commits"
plot 'commits_per_year.dat' using 1:xtic(2) with boxes notitle

