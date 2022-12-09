module ctfmovement::sample {
    use std::signer;
    use aptos_framework::account;
    use aptos_framework::event;

    struct FlagHandler has key {
        events: event::EventHandle<Flag>,
    }

    struct Flag has drop, store {
        user: address,
        flag: bool
    }

    public entry fun get_flag(sender: signer) acquires FlagHandler {
        let addr = signer::address_of(&sender);
        if (!exists<FlagHandler>(addr)) {
            move_to(&sender, FlagHandler {
                events: account::new_event_handle<Flag>(&sender),
            });
        };

        let flag_holder = borrow_global_mut<FlagHandler>(addr);
        event::emit_event(&mut flag_holder.events, Flag {
            user: addr,
            flag: true
        });
    }
}

