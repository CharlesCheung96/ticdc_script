### Overview
Ticdc is migrating its test-infra from gocheck to testify, and this Script is used for it. We can add other sed regexs to replace some repetitive and boring works.

### Usage
```
	./testify_replace.sh replace_dir(file)  pattern_file
	./testify_replace.sh replace_dir(file)
```

### Example
```
	./testify_replace.sh client_test.go testify.pattern
	./testify_replace.sh client_test.go
	./testify_replace.sh ./cdc/kv testify.pattern
	./testify_replace.sh ./cdc/kv
```

### Extention
Refer to the examples in the testify.pattern
