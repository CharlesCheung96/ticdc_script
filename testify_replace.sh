#!/bin/bash

# Run routine:
#(1) read pattern file and get all patterns
#(2) read the dir and get all *_test.go file
#(3) apply all patterns to file line
# Example:
#	sed -i 's/.*c.Assert(\(.*\), check.IsNil).*/\trequire.Nil(t, \1)/g' feed_state_manager_test.go
#	sed -i -e  's/.*c.Assert(\(.*\), check.IsNil).*/\trequire.Nil(t, \1)/g' -e 's/.*c.Assert(\(.*\), check.Equals, \(.*\)).*/\trequire.Equal(t, \1, \2)/g' feed_state_manager_test.go

Usage() {
	echo -e "Usage:"
	echo -e "\t./testify_replace.sh replace_dir(file)  pattern_file"
	echo -e "\t./testify_replace.sh replace_dir(file)"
}


GetAllTestFile() {
	replaceDirOrFile=$1
	echo "1:"$replaceDirOrFile
	if [ -f $replaceDirOrFile ]
	then
   		allTestFiles=$replaceDirOrFile
		echo "2:"$allTestFiles
	elif [ -d $replaceDirOrFile ]
	then
		allTestFiles=$(find $replaceDirOrFil -name "*_test.go")
		echo "3:"$allTestFiles
	fi
}

GetAllPatterns() {
	patternFile=$1
	echo "4:"$patternFile
	allPatterns=$(cat $patternFile|grep -v '^#'|grep -v '^$') 
}


echo "paraNum:"$#
echo "para1:"$1
echo "para2:"$2


paraNum=$#
replaceDirOrFile=$1
patternFile='testify.pattern'
allTestFiles=
allPatterns=

if [[ $paraNum -ne 1 && $paraNum -ne 2 ]]
then
	Usage
	exit 1
fi

if [[ $paraNum -eq 2 ]]
then
	patternFile=$2
fi

GetAllTestFile $replaceDirOrFile
GetAllPatterns $patternFile

echo "5:"$allTestFiles
echo "6:"$allPatterns

for file in $allTestFiles
do
	echo "file:"$file
	#concat the sed command as example 
	sedString="sed -i "
	for pat in $allPatterns
	do
		echo "pat:"$pat
		sedString=$sedString" -e \'"$pat"\'"
		echo $sedString
	done

	sedString="$sedString  $file"
	echo $sedString

	#exec $sedString 
	`$sedString`
done

