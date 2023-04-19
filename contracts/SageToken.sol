//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SageToken is IERC20{
    
    // Define the name of token, symbol and total Suppply
    // define the owner of the token
    // see balance, transfer, approve, transfer from, allowance.
    // @dev: For the burn and the mint function

    // Define Variables
    address public owner;
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public override totalSupply;
    mapping (address => uint256) private balances;
    mapping(address => mapping(address => uint256)) allowed;
    mapping(address => bool) public blacklists;

    constructor(){
        owner =  msg.sender;
        name = 'Sage';
        symbol = 'SAG';
        decimals = 18;
        totalSupply =  10000000 * 10**18;
        balances[owner] = totalSupply;
    }

     // modifiers
    modifier OnlyAdmin(){
        require(msg.sender == owner, "Only owner has permission");
        _;  
    }

    // Functions
    function balanceOf(address tokenAddress) public override view returns (uint256){
            return balances[tokenAddress];    
    }
    function transfer(address to, uint256 tokens) public override returns (bool){
        require(blacklists[to] == false, "Your account is blacklisted, Contact the owner");
       require(balances[msg.sender] >= tokens, "Insufficient Token Amount");
        balances[to] += tokens;
        balances[msg.sender] -=  tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function allowance(address _owner, address spender) public override  view returns (uint256){
        return allowed[_owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool){
       
        require(balances[msg.sender] >= amount,"Insufficient Token Amount");
        allowed[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);

        return true;

    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool){

        require(blacklists[to] == false, "Your account as blacklisted, Contact the owner");
        require(allowed[from][msg.sender] >= amount, "Insufficient Token Amount");
        require(balances[from] >= amount, "Insufficient Token Amount");

        balances[from] -= amount;
        allowed[from][msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address _to, uint256 _amount) public OnlyAdmin {
        
        require(_to != address(0), "0 Address");

        balances[_to] += _amount;
        totalSupply += _amount;
    }

   
    function burn(uint256 _amount) public OnlyAdmin {

        require(msg.sender != address(0), "0 Address");
        
        totalSupply -= _amount;
        balances[msg.sender] -= _amount;
    }

    function blacklistUser(address _user) public OnlyAdmin returns(bool){
        blacklists[_user] = true;
        return true;
    }

    function removeFromBlacklist(address _user) public OnlyAdmin{
        blacklists[_user] = false;
    }

}