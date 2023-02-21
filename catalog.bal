    # A resource to get all items in the catalog   
    # + return - json array of items in the catalog or error
    function getAllItems() returns Item[]|error {
        // Send a response back to the caller.
        Item[] items = [];
        stream<Item, error?> resultStream = dbClient->query(`SELECT * FROM items`);
        check from Item item in resultStream
        do {
            items.push(item);
        };
        check resultStream.close();
        return items;
    }