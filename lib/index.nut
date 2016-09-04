/**
 * Helper function for including
 * all needed files (look at dat filestructure tho!)
 * why underscores? - we are worried about global namespace!
 */
function __orm_include(filename) {
    return dofile("./lib/" + filename + ".nut", true);
}

/**
 * Undefined constant
 * used all over the code
 * @type {String}
 */
const UNDEFINED = "UNDEFINED";

/**
 * Defining our
 * glorious namespace
 */
ORM <- {
    Trait = {}
    Field = {}
    Utils = {}
};

/**
 * Marvelous includes
 * First of all fields
 * then traits
 * then utils
 * and then all the main stuff
 */
__orm_include("Field/Basic");
__orm_include("Field/Integer");
__orm_include("Field/Float");
__orm_include("Field/String");
__orm_include("Field/Text");
__orm_include("Field/Bool");
__orm_include("Field/Id");
__orm_include("Field/Password");
__orm_include("Field/Timestamp");

__orm_include("Trait/Interface");
__orm_include("Trait/Positionable");

__orm_include("Utils/String");
__orm_include("Utils/Array");
__orm_include("Utils/GUID");
__orm_include("Utils/ChangeTracker");

__orm_include("Driver");
__orm_include("Query");
__orm_include("Entity");

/**
 * Now, global namespace is populated
 * (polluted with this ORM shit :D )
 * and ready to work!
 */