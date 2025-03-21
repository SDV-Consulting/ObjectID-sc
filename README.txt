This is experimental Move code aimed at testing object wrapping.

The experiment's goal is to verify whether wrapping an object inside a generic ObjectID structure allows writing general code that manipulates the fields of the ObjectID, independently of the specific wrapped object's type. Ideally, the fields of the wrapped object should either never be amended directly or be modified through dedicated functions only.

However, the test fails because the compiler does not accept passing a generic ObjectID to a function without explicitly declaring the type of the wrapped object. Consequently, each combination of ObjectID and its wrapped object type requires a specific function to handle field manipulation.

A simpler alternative could be to avoid wrapping objects entirely. Instead, adding a unique identifier (UID) field to the ObjectID structure might be more practical, enabling references to any object without introducing additional constraints into the code.