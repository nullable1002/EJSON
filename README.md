# EJSON
Enhanced JSON is a new JSON format which implement indexing of array,
access to object members and conditionals.

EJSON doesn't use string to refer a value, but simply an identifier.

```json
{
  "myvar": "Hello from json"
}
```

```
//ejson
{
  myvar: "Hello from ejson"
}
```

### Array indexing

You can access an array value with the indexing operator: `[]`

```
//ejson
{
  myarr: [
    1,
    2,
    3,
    4,
    5
  ],
  elem: myarr[0] 
}
```

You can use `[][]...[]` to access matrix or multi-dimensions arrays.

### Access object members

If you want to access a member of an object, use the `.` operator:

```
//ejson
{
  obj: {
    a: "Hello"
  }, 
  a: obj.a 
}
```

### Conditionals

If you need to assign a value based on a condition, use the `?:` operator in the form of
`<condition> ? <value if condition is true> : <value if condition is false>`.

```
//ejson
{
    a: false,
    b: a ? "a is true" : "a is false"
}
```

EJSON has `&&` operator, `||` operator and `!` operator.

```
//ejson
{
    a: true && true
    
    b: !false
}
```

EJSON has also `<`, `<=`, `>`, `>=` operators.

### Comments
JSON doesn't support comments, EJSON fully supports them, both single line comment (`//`) and both 
block line comment (`/*` and `*/`)

```
{
    //line comment
    
    /*
     block comment
    */
}
```

### Math in EJSON

EJSON supports basic math operators: `+`, `-`, `*`, `/` and `%`:

```
//ejson
{
    a: 4,
    b: 9,
    
    results: [
        a + b,
        a - b,
        a * b,
        a / b,
        a % b
    ]
}
```

### Values in EJSON

EJSON fully supports native primary JSON values:
```
false,
true,
null,
3.4,
8.4e-3
.000001
-17
[],
{}
```

EJSON adds binary literal, hexadecimal literal and octal literal:

```
0b1010110
0xA56C
0c635
```

Also, numbers, can be written with an underline, to separate the digits for better reading:

```
{
    a: 123_456_789
}
```