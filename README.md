# Conditionally Released Digital Credentials (CRDC)

This repository contains the source for the IETF Internet-Draft:
**Conditionally Released Digital Credentials** (`draft-campbell-crdc`).

* **Author:** Lee Campbell (`leecam@google.com`), Google
* **Source (`kramdown-rfc`):** [`draft-campbell-crdc.md`](draft-campbell-crdc.md)
* **Latest Generated Specification (from last check-in):**
  * **HTML:** [`draft-campbell-crdc-00.html` (GitHub Pages)](https://leecam.github.io/crdc/draft-campbell-crdc-00.html) · [View Source](https://github.com/leecam/crdc/blob/gh-pages/draft-campbell-crdc-00.html)
  * **Readable Markdown:** [`draft-campbell-crdc-00.md`](https://github.com/leecam/crdc/blob/gh-pages/draft-campbell-crdc-00.md)
  * **Plain Text (IETF RFC):** [`draft-campbell-crdc-00.txt`](https://raw.githubusercontent.com/leecam/crdc/gh-pages/draft-campbell-crdc-00.txt) · [View on GitHub](https://github.com/leecam/crdc/blob/gh-pages/draft-campbell-crdc-00.txt)
  * **RFCXML v3:** [`draft-campbell-crdc-00.xml`](https://raw.githubusercontent.com/leecam/crdc/gh-pages/draft-campbell-crdc-00.xml) · [View on GitHub](https://github.com/leecam/crdc/blob/gh-pages/draft-campbell-crdc-00.xml)

## Abstract

Digital Credentials (DCs), such as Selective Disclosure for JSON Web Tokens (SD-JWTs) and ISO/IEC 18013-5 mobile documents (mdocs), are issued by Issuers to Credential Managers (wallets) held by Holders. Verifiers can then request these credentials from the Credential Manager using presentation protocols such as OpenID for Verifiable Presentations (OpenID4VP) and browser APIs such as the W3C Digital Credentials API. A foundational privacy property of this three-party model is Issuer unlinkability: the Issuer does not learn when, where, or to which Verifier a given credential is presented. However, in many commercial and regulatory ecosystems, Issuers require a mechanism to charge or authorize Verifiers for credential presentations.

This specification defines a credential-format-agnostic mechanism for Conditionally Released Digital Credentials (CRDCs). During presentation, the Credential Manager encrypts a standard Digital Credential presentation using a one-time ephemeral Content Encryption Key (CEK) to produce a Releasable Credential, and encrypts the CEK under an Issuer Release Public Key alongside Issuer routing metadata to produce a Release Token. The Verifier presents the Release Token to the Issuer's Release Endpoint to authorize (and optionally bill for) the presentation and obtain the decrypted CEK, which the Verifier then uses to decrypt and validate the underlying Digital Credential—all while strictly preserving the privacy property that the Issuer never learns which Holder is presenting the credential.

## Building the IETF Draft Locally

This repository uses [`kramdown-rfc`](https://github.com/cabo/kramdown-rfc), [`xml2rfc`](https://pypi.org/project/xml2rfc/), and [`pandoc`](https://pandoc.org/) to compile the `kramdown-rfc` source into validated IETF RFCXML v3 (`.xml`), plain text (`.txt`), HTML (`.html`), and standalone readable GitHub-Flavored Markdown (`draft-campbell-crdc-00.md`).

```bash
gem install kramdown-rfc2629
pip install xml2rfc
make all check
```

## GitHub Actions CI & Datatracker Submission

On every push and pull request, the [`.github/workflows/ietf-draft.yml`](.github/workflows/ietf-draft.yml) workflow:
1. Compiles `draft-campbell-crdc.md` into RFCXML v3 (`draft-campbell-crdc-00.xml`).
2. Validates the XML structure and renders `draft-campbell-crdc-00.txt` and `draft-campbell-crdc-00.html` using `xml2rfc --v3`.
3. Converts the rendered specification into standalone readable GitHub-Flavored Markdown (`draft-campbell-crdc-00.md`) using `pandoc`.
4. Runs IETF `idnits` checks.
5. Uploads the `.xml`, `.txt`, `.html`, and readable `.md` build artifacts (ready for direct upload to [IETF Datatracker Submit](https://datatracker.ietf.org/submit/)).
6. On pushes to `main` (or `draft-*` tags), publishes the latest generated `.html`, `.md`, `.txt`, and `.xml` files to the `gh-pages` branch.

