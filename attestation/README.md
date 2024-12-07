# community.lexicon.attestation

A collection of types enabling record signatures and attestation.

> The act of attesting; testimony; witness; a solemn or official declaration, verbal or written, in support of a fact; evidence. The truth appears from the attestation of witnesses, or of the proper officer. The subscription of a name to a writing as a witness, is an attestation. 

# Background and Context

DID documents contain cryptographic key data[^didmethodkey] that can be used to create signatures. From the [did-core](https://www.w3.org/TR/did-core/) spec:

> A DID document can express verification methods, such as cryptographic public keys, which can be used to authenticate or authorize interactions with the DID subject or associated parties.

These are currently used in AT Protocol for repository signatures. The typical behavior is to create a did-method-key entry in `verificationMethods` with the ID fragment `#atproto` resulting in a verification method with the ID `did:plc:cbk...fq2#atproto`.


# NSID community.lexicon.attestation

## Type: Signature

The `community.lexicon.attestation.defs#signature` type contains signature payloads with the following required fields:

* `signature` (`string`) -- The signature of the record, see [Creating Signatures](#Creating-Signatures)
* `issuer` (`string:did`) -- The identity that created the signature.

Any additional fields are included as-is in the creation of the signature.

## Type: Revocation

The `community.lexicon.attestation.revocation` type is a record used to create multi-factor verification that a signature is still valid.

* `revoked` (required, `bool`) -- A boolean value that is `true` if the signature referenced by this record has been revoked and is no longer valid. `false` if the signature is valid and has not been revoked.
* `message` (`string`) -- An optional message by the revocation record holder.

## Trait: Signed

This NSID includes the trait type `community.lexicon.attestation.signed`. This record trait is used to create typed attributes for records that include the signature collections.

***Note***: Traits are not a formally adopted pattern. Implementation and use may vary.

# Creating Signatures

Neat

[^didmethodkey]: [https://w3c-ccg.github.io/did-method-key/](https://w3c-ccg.github.io/did-method-key/)
