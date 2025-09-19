# Web Monetization on AT Protocol

## Background

[Web Monetization](https://webmonetization.org/) is a set of standards and APIs that let web publishers and viewers send each other payments. Publishers can advertise their wallet addresses, users can discover and pay them via the [Open Payments API](https://openpayments.dev/), and browsers can use standard events to manage the discovery and payment lifecycle.

Wallet addresses are simple HTTPS URLs. Web Monetization specifies that wallet addresses may be advertised:

* [in HTML](https://webmonetization.org/developers/link-element-webpage/), [RSS, and Atom](https://webmonetization.org/developers/rss-atom-jsonfeed/) with `<link rel="monetization">` tags
* [in JSON Feed](https://webmonetization.org/developers/rss-atom-jsonfeed/#json-feed) with a new `_monetization` extension
* [in ActivityStreams 2](https://webmonetization.org/developers/activity-streams/) with a new `monetization` property in the `https://webmonetization.org/ns.jsonld` namespace

These are all extremely simple and minimal. The only data they provide is one or more string wallet address URLs. Additional information and functionality is provided by the wallets themselves and the web pages, feeds, or objects that contain them.


## Usage

We start with four basic use cases for using Web Monetization in AT Protocol:

* Publish your wallet address(es)
* Discover someone else's wallet address(es)
* Send a payment to someone
* Receive a payment from someone

The first two are provided for by a new [`community.lexicon.payments.webMonetization` lexicon](#lexicon). You can publish and associate a wallet address with your account by creating a record in your ATProto repo with this lexicon. You can publish multiple wallet addresses by creating multiple records. You can change or delete an address later by editing or deleting the corresponding record.

To discover an ATProto account's wallet addresses, you can call the [`com.atproto.repo.listRecords`](https://docs.bsky.app/docs/api/com-atproto-repo-list-records) API method on their PDS with their repo and `collection=community.lexicon.payments.webMonetization`. This is fairly low level, though. Over time, we hope that [appviews](https://docs.bsky.app/docs/advanced-guides/federation-architecture#app-views) will add native support and bundle wallet addresses into their user profile objects.

ATProto clients can display users' wallet addresses in their profiles. They should [fetch each wallet](https://openpayments.dev/apis/wallet-address-server/operations/get-wallet-address/#200) and display its name ([background](#bidirectional-verification)), along with an appropriate visual indicator, eg 💵, and optionally the user's note for the wallet.

Clients that support making payments can let users add, edit, and remove their wallet addresses. Clients can also use the Open Payments API to let users send and receive payments. Web-based clients may also use Web Monetization events and related APIs. [See the docs](https://webmonetization.org/docs/) for details.

You can also use the [sidecar record pattern](https://docs.bsky.app/blog/pinned-posts#current-recommendations) to attach wallet addresses to individual posts and other records. When you create a post, create `community.lexicon.payments.webMonetization` in the same repo with the same rkey as the post. When wallet-aware clients then load that post, they'd also look for a `webMonetization` with the same rkey, and if it exists, render it as the attached wallet address.


## Lexicon

We propose a new [`community.lexicon.payments.webMonetization` lexicon](https://github.com/lexicon-community/lexicon/blob/main/community/lexicon/monetization/) for Web Monetization wallet addresses that supports these use cases. It consists of two strings, a wallet address and an optional note. Here's an example:

```json
{
  "$type": "community.lexicon.payments.webMonetization",
  "address": "https://wallet.example/alice",
  "note": "Alice's personal wallet"
}
```


## Future directions

### Bidirectional verification

Wallet addresses are just URLs. Anyone can publish a wallet address and claim it's theirs, or anyone else's. The threat model for publishing wallet addresses is limited - if you have a wallet address, you can only send payments to it, not from it - but in the public cryptocurrency world, paying someone can imply a form of association, so attackers sometimes trick unsuspecting users into sending payments to undesirable wallets and forming unexpected associations.

Web Monetization and Open Payments don't have public ledgers like cryptocurrencies, so this threat model doesn't apply in the same way, but we can still address it. To verify that an ATProto account owns a given wallet, we sketch a form of bidirectional verification here using [`alsoKnownAs`](https://www.w3.org/TR/did-core/#dfn-alsoknownas), similar to [rel=me verification](https://microformats.org/wiki/rel-me#domain_verification) and [ATProto handle resolution](https://atproto.com/specs/handle#handle-resolution).

1. [Fetch the wallet address URL.](https://openpayments.dev/apis/wallet-address-server/operations/get-wallet-address/#200)
1. Extract its `alsoKnownAs` value. It may be a string URL or a list of string URLs. (This is not an explicit part of Web Monetization, but [additional properties are allowed in the wallet response](https://openpayments.dev/apis/wallet-address-server/operations/get-wallet-address/#200), without needing an extension.)
1. If the ATProto account's DID is one of the `alsoKnownAs` values, then they are legitimately associated with the wallet. Otherwise, it may be someone else's wallet that they're referring to, eg their favorite charity.

Clients can perform this bidirectional verification and indicate verified wallet addresses with different visible indicators.


### History

Unlike most cryptocurrency ledgers, Web Monetization/Open Payments transaction histories are private. Some apps may be interested in storing payment history and transaction data in ATProto. However, this data is often sensitive, and while there are efforts underway to add access control and private data to ATProto, right now it only supports fully public data. So, apps should tread carefully here.

Still, there are use cases for public payment data. Venmo, Kickstarter, Patreon, Twitch, etc are all well-known examples, among others.

Defining a lexicon for payment history is beyond the scope of this working group, but it's a worthwhile direction for future work. Web Monetization's [`MonetizationEvent` interface](https://webmonetization.org/specification/#monetizationevent-interface) could be one starting point.
