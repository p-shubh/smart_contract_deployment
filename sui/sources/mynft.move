module addrx::mynft{
    use sui::object::{Self,ID,UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::string::String;
    use sui::event;


    struct NFT has key,store {
        id: UID,
        name: String,
        description: String,
        url: String,
    }

    /**************** Event Struct **********************/
    struct NFTMinted has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: String,
    }

    public entry fun mint(nft_name: String, nft_description: String, nft_url: String,ctx: &mut TxContext){
        let sender = tx_context::sender(ctx);
        let nft = NFT {
            id: object::new(ctx),
            name: nft_name,
            description: nft_description,
            url: nft_url,
        };

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,
        });
        
        transfer::public_transfer(nft, sender);

    }

}