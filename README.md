# squirrel-orm

Hey everybody. Are you tired of making same actions over and over, creating, formatting and populating those stupid SQL requests, and after all of that, you also need to fetch and transform all the returned data. And do it for every table! 

Today im gonna show you how to make your (your dev team) life easier and happier.

## What is it ?
This is a small library that wraps your data and maps it to the table fields in database. Adding operations for fast access, modifications and saving without any extra work.

### Most of the features are available, but substance is highly unstable. (Still under active development). 

## How it works:

First of all you need to declare your model(s):

```squirrel
class Player extends ORM.Entity {
    
    /**
     * Didn't find any way to get current classname
     * so, we need to set it up manually
     * @type {String}
     */
    static classname = "Player";

    /**
     * Set up table name
     * @type {String}
     */
    static table = "tbl_players";

    /**
     * Set up mapping for different values/columns inside table
     * @type {Array}
     */
    static fields = [
        ORM.Field.String({ name = "username", }),
        ORM.Field.Password({ name = "password" }),
        ORM.Field.Timestamp({ name = "registeredAt" })
    ];

    /**
     * Set up traits
     * (predefined collections of fields)
     * @type {Array}
     */
    static traits = [
        ORM.Trait.Positionable()
    ];
}
```

And now we can access all the beauty of the library; You can use high-level abstractions:

```squirrel
// create new record
local player = Player();

player.username = "John";
player.password = "123123";

player.save();

// find one player by id
Player.findOneBy({ id = 15 }, function(err, player) {
	::print(player.username);
	
	// you can change some fields and save the model right after
	player.username = "newusername";
	player.save();
});

// or delete all of them
Player.findAll(function(err, players) {
	player.remove();
});
```

Or you can show your damn ninja skillz with some SQL:

```squirrel
local q = ORM.Query("
	select 
		p.id,
		p.username as nickname,
		concat(
			'item: ', pi.title,
			' size: ', pi.size
		) as inventory,
		pv.plate as car_plate
		
	from @Player p
	
	left join @PlayerItem pi on pi.player_id = p.id
	left join @PlayerVehicle pv on pv.player_id = p.id
	
	where p.id = :id and pi.id = :item_id
");

q.setParameter('id', 15);
q.setParameter('item_id', 2424);

q.getSingleResult(function(err, data) {
	::print(data["inventory"]);
});
```
Note: **@Player** or **@PlayerItem**, ..., are synonyms for registered model class. They will be replace to a table names described in each entity class.

## Installation:

1. Download in any convinient way to you.
2. Put somewhere not far away from your binary (*.exe)
3. Insert code where you want to use it:

```squirrel
// load lib where you want it to work
// note, path relative to your PWD
// (Process Working Directory)
dofile("./orm/lib/index.nut", true);

// and set up driver (this example uses simple mysql)
ORM.Driver.setProxy(function(queryString, cb) {
    local query = mysql_query(queryString);
    
    // return data inside ORM
    cb(null, mysql_fetch_assoc(query));
    
    // free
    mysql_free_result(query);
});

// now use it!

```

## License
Check out [LICENSE](LICENSE)