# Support Matching Type

This match_users.eb file resolved conflicts in a single CSV file by identifying duplicate emails and/or phone numbers using a predefined priority list.

---

## What It Does

- Reads a single input CSV file (e.g., `input1.csv`)
- Outputs a cleaned-up version (e.g., `input1_output.csv`) with only one row per unique ID

---

## File Structure

For each input CSV:
- `inputX.csv` → your original data
- `inputX_output.csv` → cleaned and de-duplicated version

---

## 💡 How It Works
In each below example you will need to update the input CSV #

Match users based on email run: 
`ruby match_users.rb email input1.csv`

Match users based on phone run:
 `ruby match_users.rb phone input1.csv`

Match users based on email and phone run: 
`ruby match_users.rb email phone input1.csv`
