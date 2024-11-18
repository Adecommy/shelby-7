import Text "mo:base/Text";
import RBTree "mo:base/RBTree";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor Poll{
  var question: Text = "What is your sport?";

   public query func getQuestion() : async Text {
    question
  };

  var votes: RBTree.RBTree<Text, Nat> = RBTree.RBTree(Text.compare);

// query the list of entries and votes for each one
// Example:
//      * JSON that the frontend will receive using the values above:
  public query func getVotes(): async [(Text,Nat)] {
    Iter.toArray(votes.entries());
  };


  public func vote(entry:Text):async [(Text,Nat)] {
    // First we want to check if the entry exists in the RBTree:

    let votes_for_entry : ?Nat = votes.get(entry);

    // Now lets process the data gotten above

    let current_votes_for_entry : Nat = switch votes_for_entry{
      case null 0;
      case (?Nat) Nat;
    };

    // Now we have the data to be processed, let update the data tank.

    votes.put(entry, current_votes_for_entry+1);

    // Now lets return the iterator in form of an array for the frontend
    Iter.toArray(votes.entries())
  };

  // Lets declare an expression to reset the vote count 

  public func resetVotes() : async [(Text, Nat )] {
    votes.put("Football", 0);
      votes.put("Baseball", 0);
      votes.put("Basketball", 0);
      votes.put("Swimming", 0);
      Iter.toArray(votes.entries())
  };
};

