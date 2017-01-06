
echo "## tests results"
cat $FILE | grep -i "failed"

FAILED=$(cat $FILE | grep -c "failed")
PASSED=$(cat $FILE | grep -c "passed")

rm -rf $FILE

if [[ ( $PASSED -eq 0 ) && ( $FAILED -eq 0 ) ]]; then
    echo "!! no tests"
    exit 1
fi

if [ $FAILED -ne 0 ]; then
    echo "!! failed"
    exit 1
fi


echo ":-) success"
