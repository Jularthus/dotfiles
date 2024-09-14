commit() {
  # Change directory for the root of the Git repository
  cd $(git rev-parse --show-toplevel)

  # Find all executable files in the repository
  executables=$(find $(git rev-parse --show-toplevel) -type f -perm -u=x)

  for file in $executables; do
    # Remove leading './' if present
    file_cleaned=$(echo "$file" | sed 's|^\./||')

    # Check if the file isn't already in .gitignore
    if ! grep -qxF "$file_cleaned" .gitignore; then
      echo "Adding $file_cleaned to .gitignore"
      echo "$file_cleaned" >> .gitignore
      git add .gitignore
    fi
  done

  git add -A
  echo -n "Enter commit name: "
  read commitName
  git commit -m "$commitName"
  git push
}
