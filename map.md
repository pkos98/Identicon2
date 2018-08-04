Maps
====

**Key facts**:  

* Associative data structure
* Keys & values can be of any type
* Keys in a map can have different types
* No duplicates of key allowed

**Usage**:  

* Basic syntax for instantiation:  
`%{:key => :value, "key" => "value"}` 
* Syntactic sugar for keys that are atoms:  
    `%{key: 1} === %{:key => 1}`
* Acessing a map`s value through:
  * `Map.fetch(map, :key)`
  * `map[:a]` 
  * `map.key` if `key` is an `atom`
* Update an existing value with the `|` operator:
    ```
    iex> map = %{one: 1, two: 2} 
    iex> %{map | one: "one"}
      %{one: "one", two: 2}
    ```
sasd
