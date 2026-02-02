Return-Path: <netdev+bounces-255798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SME/FkdxgGkw8QIAu9opvQ
	(envelope-from <netdev+bounces-255798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:41:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14ECCA34C
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09FE53015A6A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09B2D836D;
	Mon,  2 Feb 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DSpSiXG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507532D3739
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025258; cv=none; b=dHP5ppBDJWwCRgw7zce7SPnHdjdinGxVeVyqEZXm0xTFMwVjtPMdEyFqJQCeX7oFkGSXbhukb9nkvKLYGWZJVfYIE9NMj8e6ZH8a20xV6rezQV6xlshTDAFl6h0BMP37NCA+UcQhEu3bB+4MErVTBGTRsGpwEC4vBpmX9/N6UKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025258; c=relaxed/simple;
	bh=WnnZNkv4/bdK2PXwl6Fb5EzFIu1jXM4NKoHQKxkTHKE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RIksyKLKjBXjBIYlsLrfsiX/f9qDsNY+/ycRYh2zgtpCKjhJbfbPX9rW+AzWWoox+lfz6bHoxy0iwjRvwFSohAdPTpEq9rUrGLHBYYIboRunQMPhwJsPFY53Y8udwn0m0U1LQFKtNzTAFbb2PTKrWVdncbsabACur8EREwNB93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DSpSiXG3; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770025247; x=1770284447;
	bh=rqGqb+IxeWQlKZ6Q2axTSQaxisBiUXtIfS/L5evgJjo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DSpSiXG3d/eU1wiwqEUUgkJiHtZEMtxgPKZnD96akNshYllKflg00hioEk02yXPSI
	 cYB2qh2w5ucze+QyUXFT/DiYn8SVc6jrQahhE1H96YTBkfSz1hI3CMmafz1meHiT7C
	 awgfi8vD1FToaTYJC/dm4gWBdDDqUZy4fwYYRPb7WDRWJ0wp4q07rx+Q+7E2I5LJzB
	 uB+nnvsjua0Wc6IhNROZR1WJhankCB9pMuHYBfjcw3jDGDdDi+JUc515QG8+LC4/tL
	 dY5wdL7jNRlzeQ5mFlLlOV2fF3jARIyGC4sMxM5pn6Zi4K/FGIKbkzJ2YBPXl6Ixs/
	 5VVrhlbCQWrsg==
Date: Mon, 02 Feb 2026 09:40:42 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v7 0/5] doc/netlink: Expand nftables specification
Message-ID: <20260202093928.742879-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: c8afe568ce52d80bf5f1c42a61bd96d27e0bc21f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,vger.kernel.org,protonmail.com];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: C14ECCA34C
X-Rspamd-Action: no action

Getting out some changes I've accumulated while making nftables work
with Rust netlink-bindings. Hopefully, this will be useful upstream.

v7:
- Drop "getcompat" operation.
- Fix formatting of lists of attrsets.

v6: https://lore.kernel.org/netdev/20260121184621.198537-1-one-d-wide@proto=
nmail.com/
- Sort sub-messages.
- Add description for "Add max check" commit.
- Fix doc comment for expr-bitwise-attrs to match one in nf_tables.h (thank=
s Donald)

v5: https://lore.kernel.org/netdev/20251120151754.1111675-1-one-d-wide@prot=
onmail.com/
- Fix docgen warnings in enums (avoid interleaving strings and attrsets in =
a list).
- Remove "# defined in ..." comments in favor of explicit "header" tag.
- Split into smaller commits.

v4: https://lore.kernel.org/netdev/cover.1763574466.git.one-d-wide@protonma=
il.com/
- Move changes to netlink-raw.yaml into a separate commit.

v3: https://lore.kernel.org/netdev/20251009203324.1444367-1-one-d-wide@prot=
onmail.com/
- Fill out missing attributes in each operation (removing todo comments fro=
m v1).
- Add missing annotations: dump ops, byte-order, checks.
- Add max check to netlink-raw specification (suggested by Donald Hunter).
- Revert changes to ynl_gen_rst.py.

v2: https://lore.kernel.org/netdev/20251003175510.1074239-1-one-d-wide@prot=
onmail.com/
- Handle empty request/reply attributes in ynl_gen_rst.py script.

v1: https://lore.kernel.org/netdev/20251002184950.1033210-1-one-d-wide@prot=
onmail.com/
- Add missing byte order annotations.
- Fill out attributes in some operations.
- Replace non-existent "name" attribute with todo comment.
- Add some missing sub-messages (and associated attributes).
- Add (copy over) documentation for some attributes / enum entries.
- Add "getcompat" operation.

Remy D. Farley (5):
  doc/netlink: netlink-raw: Add max check
  doc/netlink: nftables: Add definitions
  doc/netlink: nftables: Update attribute sets
  doc/netlink: nftables: Add sub-messages
  doc/netlink: nftables: Fill out operation attributes

 Documentation/netlink/netlink-raw.yaml    |  11 +-
 Documentation/netlink/specs/nftables.yaml | 694 ++++++++++++++++++++--
 2 files changed, 655 insertions(+), 50 deletions(-)

--=20
2.51.2



