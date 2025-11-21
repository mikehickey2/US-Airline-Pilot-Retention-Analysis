#!/bin/bash
# Render the article and move output to correct location

# Render the article
quarto render scripts/analysis/ret_age_gender_art.qmd --output-dir output/reports

# Move files from nested directory to flat structure
if [ -d "output/reports/scripts/analysis" ]; then
    mv output/reports/scripts/analysis/*.docx output/reports/ 2>/dev/null || true
    mv output/reports/scripts/analysis/*.html output/reports/ 2>/dev/null || true
    rm -rf output/reports/scripts
    echo "✓ Files moved to output/reports/"
fi

echo "✓ Render complete!"
echo "  Output: output/reports/ret_age_gender_art.docx"
echo "  Output: output/reports/ret_age_gender_art.html"
