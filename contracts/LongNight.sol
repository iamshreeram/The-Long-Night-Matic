// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "@opengsn/gsn/contracts/BaseRelayRecipient.sol";
import "@opengsn/gsn/contracts/interfaces/IKnowForwarderAddress.sol";

contract LongNight is BaseRelayRecipient, IKnowForwarderAddress {
    address payable public admin;

    constructor(address _forwarder) public {
        admin = _msgSender();
        trustedForwarder = _forwarder;
    }

    struct Game {
        address payable first_user;
        address payable second_user;
        uint256 bet_amount;
        address payable winner;
        uint256 star;
    }

    mapping(uint256 => Game) public long_night;
    uint256 public id = 1;

    function create_game() public payable {
        long_night[id].first_user = _msgSender();
        long_night[id].bet_amount = msg.value;
        id++;
    }

    function join_game(uint256 _id) public payable {
        long_night[_id].first_user = _msgSender();
    }

    function close_game(
        uint256 _id,
        address payable _winner,
        uint256 _star,
        uint256 _status
    ) public {
        long_night[_id].winner = _winner;
        long_night[_id].star = _star;
        if (_status == 0) {
            long_night[_id].first_user.transfer(long_night[_id].bet_amount);
        } else if (_status == 1) {
            if (_star == 1) {
                _winner.transfer(
                    (long_night[_id].bet_amount +
                        ((long_night[_id].bet_amount / 100) * 50))
                );
                admin.transfer((long_night[_id].bet_amount / 100) * 50);
            } else if (_star == 2) {
                _winner.transfer(
                    (long_night[_id].bet_amount +
                        ((long_night[_id].bet_amount / 100) * 70))
                );
                admin.transfer((long_night[_id].bet_amount / 100) * 30);
            } else if (_star == 3) {
                _winner.transfer(
                    (long_night[_id].bet_amount +
                        ((long_night[_id].bet_amount / 100) * 90))
                );
                admin.transfer((long_night[_id].bet_amount / 100) * 10);
            }
        }
    }

    function versionRecipient()
        external
        virtual
        override
        view
        returns (string memory)
    {
        return "1.0";
    }

    function getTrustedForwarder() public override view returns (address) {
        return trustedForwarder;
    }
}
