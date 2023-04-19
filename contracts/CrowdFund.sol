//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./SageToken.sol";

contract CrowdFund {
    // launch a campaign (creator, amountDonated, id, status, startAt, endAt)
    struct Campaign {
        address creator;
        uint donation;
        uint id;
        uint goal;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }    
    Campaign[] public campaigns;
    
    function launch(uint _goal, uint _startAt, uint _startEnd) external {

    }

    function cancel(uint _id) external{}
    function pledge(uint _id) external{}
    function unpledge(uint _id) external{}
    function claim(uint _id) external{}
    function refund(uint _id) external{}
}