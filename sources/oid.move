// Copyright (c) SDV Consulting srls.
// SPDX-License-Identifier: AGPLv3
// The use of this software is permitted for non-commercial purposes only, unless a separate commercial license is obtained from the author.

#[allow(lint(custom_state_change, self_transfer))]

module objectId::oid_object {

    use iota::clock::Clock;
    use std::string::String;
    use iota::token::{Token, TokenPolicy};
    use iota_identity::controller::{ControllerCap, controller_of};
    
    public struct OIDFood has key, store {
        id: UID, // Unique identifier for the object
        epc: String, // Global Trade Item Number
        lot_number: String, // Lot number
        expiration_date: String, // Expiration date in ISO 8601 format
        shop: String,
    }



    public struct OIDObject<T> has key, store {
        id: UID, // Unique identifier for the object
        description: String, // Description of the object
        creation_date: u64, // Creation date in ISO 8601 format
        product_url: String, // web page of the product
        producer_url: String, // domain name where the dApp look for onj-type TXT entry to validate the object type
        ro_creator: address, // address of the real object creator
        ro_owner: address, // address of the real object current owner. Set to 0x0 if the product is never been sold.
        geo_location: String, // geographic coordinate where the physical product is
        w_obj: T  //wrapped object
    }


    public fun create_food_object(
        ccap:  &ControllerCap,
        description: String,
        producer_url: String,
        product_url: String,
        geo_location: String,
        clock: &Clock,
        epc: String,
        lot_number: String,
        expiration_date: String,
        shop: String,
        ctx: &mut TxContext,
    ) 
    {
        let creation_date = clock.timestamp_ms();
        let caller = tx_context::sender(ctx);
        let ro_creator = caller;
        let ro_owner: address = caller;


        let food = OIDFood {
            id: object::new(ctx),
            epc,
            lot_number,
            expiration_date,
            shop
        };

        let identity_id = controller_of(ccap);

        let object = OIDObject<OIDFood> {
            id: object::new(ctx),
            description,
            creation_date,
            producer_url,
            product_url,
            ro_creator,
            ro_owner,
            geo_location,
            w_obj: food,
        };

        transfer::share_object(object);
    }

/*



    public struct OIDBox has key, store {
        id: UID, // Unique identifier for the object
        serial_number: String, // Global Trade Item Number
        weight: String,
        height: String,
        width: String,
        depth: String,
        expiration_date: String, // Expiration date in ISO 8601 format
        shop: String,
    }

    public struct Apparel has store {
        category: vector<u8>,  // categoria (es: scarpe, borsa, giacca, ecc.)
        size: vector<u8>,      // taglia (es: S, M, L, 42, ecc.)
        color: vector<u8>,     // colore prodotto
        material: vector<u8>,  // materiale (es: cotone, pelle, ecc.)
    }



    public fun update_ro_owner<T>(  
        object: &mut OIDObject<T>,
        new_ro_owner: address,
        ctx: &mut TxContext,
        )
        {
            let caller = tx_context::sender(ctx);
            assert!(caller == object.ro_owner, 1, );
            object.ro_owner = new_ro_owner;
        }

    public fun update_geo_location<T>(
        object: &mut OIDObject<T>, 
        new_location: String, 
        ctx: &mut TxContext
        ) 
        {
            let caller = tx_context::sender(ctx);
            assert!(caller == object.ro_owner,1,);
            object.geo_location = new_location;
        }

public fun update_lot_number(
    object: &mut OIDObject<OIDFood>,
    new_lot_number: String,
    ctx: &mut TxContext
) {
    let caller = tx_context::sender(ctx);
    assert!(caller == object.ro_owner, 1); 

    object.w_obj.lot_number = new_lot_number;
}




    public fun delete_object<T: drop>(
        object: OIDObject<T>, 
        //w_obj: T,  //wrapped object
        ctx: &mut TxContext
        ) 
        {
            let caller = tx_context::sender(ctx);
            assert!(caller == object.ro_owner,1,);
            let OIDObject { id, .. } = object;
            object::delete(id);
        }

*/


}

