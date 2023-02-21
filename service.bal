
import ballerinax/mysql;
import ballerina/http;
import ballerinax/mysql.driver as _;

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database="shiro_db"
);

//SELECT Code, Title, Includes, Intended_for, Color, Material, Price, Quantity
//FROM shiro_db.items;

# catalog item
public type Item record {|
    int code?;
    string title;
    string includes;
    string intended_for;
    string color;
    string material;    
    float price;
    int quantity;
|};

# order entry ID, Item_Code, price, amount, total, customer, card
public type Order record {|
    int id?;
    int item_code;
    float price;
    int amount;
    int total;
    string customer;
    string card;
|};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - hello message or error
    resource function get greeting() returns string|error {
        // Send a response back to the caller.
        return "Hello !!";
    }

    # a resource to get all items in the catalog    
    # + return - json array of items in the catalog or error
    resource function get catalog() returns Item[]|error {
        // Send a response back to the caller.
        return getAllItems();
    }

    # a resource to get all orders in the database
    # + return - json array of orders in the database or error
    resource function get orders() returns Order[]|error {
        // Send a response back to the caller.
        return getAllOrders();
    }
}