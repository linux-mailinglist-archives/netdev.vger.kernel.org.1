Return-Path: <netdev+bounces-307458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HI8yGyQzVmoZ1QAAu9opvQ
	(envelope-from <netdev+bounces-307458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:01:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1F754CC4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lwn.net header.s=20201203 header.b="rZ/lK5jD";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307458-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lwn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C8E43009CD8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF14450906;
	Tue, 14 Jul 2026 13:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8973612DB;
	Tue, 14 Jul 2026 13:01:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034077; cv=none; b=mxOLyjkTZodjzf5lQfEmmSAkTmFSuzfLXx38bUjbzdwct0Xf67jeMpgNDemtUvXKYmi6MJzPjy1xd+Jl1VjjyWjDTCUcecMDitj8bQE1czQCFPso+Y/s6ODtEGiIx1v7TRwPqI3YDmMsxy6XU9IK4bzWwT17lyA1HMS3AW4GJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034077; c=relaxed/simple;
	bh=7CeV2JqxygSEcV7QVYtBYJkoFG8rn1xPd64XyHQGA9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M532kVrTeyogswW3xuOpqqnoVi4qwYSW8G//M3vAnLsNO6OpcHKVZhgqZr4ApO9y7FPy61I477ptYUIH4+FhSPRxEmgXTYg4ZXxxeRdEx2apr0+Z8uG+XMoRBm5skF0BaKblxj6R1ecwSPLhKe0rlS4ioWqtGuBgYKB7cA4Ly7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rZ/lK5jD; arc=none smtp.client-ip=45.79.88.28
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C6D3410E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784034074; bh=N7EMk0B6AUtZUiM/QA5lBMqbPP1I3abAcQ9/YZ6+Tzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rZ/lK5jDFFbj57Sl/24gU1iFuYlaluvoVZ5Ug1idxSk24WOPCmZ88zIRW5f+YEzVX
	 OzhkNgXiPh9OlddACJ4HW/nAE0hrweCLvZ3Br47g8RTMD/2YI7NWfraTs/0jrI5bfA
	 wxL1aA/kuV0bUH9ibIbKx8O5AkiBKjJbp6cqIqHf+4LNGJdlv4surZ7bloLjRvWGDB
	 gXaXax69FImiTwDeRIWMhBVy8YdBnFw7wCtTCrrj/dpLNvTlQrRPsZ3LTIwCxxYc0E
	 X363mMGut+t5vLTp43fHZdEuLl9FLOjoLmIz4ZpDAr5I/3Uz8a9+z0JZRgQeW/b/we
	 S28cEuHBv0YFQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3C6D3410E2;
	Tue, 14 Jul 2026 13:01:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David 'equinox' Lamparter <equinox@diac24.net>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Fernando
 Fernandez Mancera <fmancera@suse.de>, Lorenzo Colitti
 <lorenzo@google.com>, Maciej =?utf-8?Q?=C5=BBenczykowski?=
 <maze@google.com>, Patrick Rohr
 <prohr@google.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, David 'equinox' Lamparter
 <equinox@diac24.net>
Subject: Re: [PATCH net-next 9/9] net: document RFC6724 rule 5.5 implementation
In-Reply-To: <20260714094030.136317-10-equinox@diac24.net>
References: <20260714094030.136317-1-equinox@diac24.net>
 <20260714094030.136317-10-equinox@diac24.net>
Date: Tue, 14 Jul 2026 07:01:13 -0600
Message-ID: <87zeztg1ye.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:equinox@diac24.net,m:pabeni@redhat.com,m:kuba@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:skhan@linuxfoundation.org,m:fmancera@suse.de,m:lorenzo@google.com,m:maze@google.com,m:prohr@google.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307458-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[trenco.lwn.net:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lwn.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1A1F754CC4

David 'equinox' Lamparter <equinox@diac24.net> writes:

> RFC6724 rule 5.5 is anything but obvious, especially if trying to do it
> well.  (RFC8028 and its errata kinda proves the point.)
>
> This documents what exactly the Linux kernel does for RFC6724 rule 5.5,
> especially what the routing table needs to look like for it to work.
>
> Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
> ---
>  Documentation/networking/ipv6-addrsel.rst | 75 +++++++++++++++++++++++
>  MAINTAINERS                               |  1 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/networking/ipv6-addrsel.rst

You need to add this new document to the index.rst file or it won't be
part of the docs build...you should have seen a warning when you built
the docs.

> diff --git a/Documentation/networking/ipv6-addrsel.rst b/Documentation/networking/ipv6-addrsel.rst
> new file mode 100644
> index 000000000000..bed032e69570
> --- /dev/null
> +++ b/Documentation/networking/ipv6-addrsel.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +IPv6 source address selection trivia
> +====================================
> +
> +
> +RFC6724 rule 5.5 support
> +------------------------

Please stick with the section markup guidelines in
Documentation/doc-guide/sphinx.rst. 

> +RFC6724 rule 5.5 is a very short paragraph in a complex RFC that has turned
> +out quite tricky, but also immensely useful in multihoming scenarios.  For
> +reference, it says:
> +
> +::

You'll likely get more visually pleasing results if you just leave out
the "::" here; you don't need literal formatting.

> +   Rule 5.5: Prefer addresses in a prefix advertised by the next-hop.
> +   If SA or SA's prefix is assigned by the selected next-hop that will
> +   be used to send to D and SB or SB's prefix is assigned by a different
> +   next-hop, then prefer SA.  Similarly, if SB or SB's prefix is
> +   assigned by the next-hop that will be used to send to D and SA or
> +   SA's prefix is assigned by a different next-hop, then prefer SB.
> +
> +The way this works on Linux is as follows:
> +
> +- prior to any source address selection happening, when receiving a RA, more
> +  than the installation of a default route (or ::/128 route) needs to happen:
> +  for each PIO, a source-specific (subtree) route is *additionally* installed.
> +  The effect of this is that *after* a source address has been selected, one
> +  of the routers that advertised it will remain in use (this is *not* RFC 6724
> +  related, but rather RFC 8028.)  At the same time, these extra routes serve
> +  to remember which router advertised what.
> +
> +- per usual, a route lookup for the IPv6 destination address in consideration
> +  is done first.  This is passed around in kernel as a dst_entry.
> +
> +- the source address selection code iterates through the various rules in
> +  RFC 6724.
> +
> +- if/when rule 5.5 is reached, first of all, there is a check if *any* source
> +  specific routes exist in the routing table.  If there are none, the entire
> +  code for 5.5 is skipped because it cannot have any effect, but is not free
> +  to execute (can involve multiple routing lookups.)  **In applications that
> +  use a lot of unbound (e.g. UDP) sockets, installing subtree routes should
> +  therefore be avoided to not incur this cost on each source address selection
> +  pass.**  Alternatively, applications should bind their sockets to a specific
> +  source address such that the selection code is never hit.
> +
> +- if subtree routes do exist, the source address selection code now repeats
> +  the routing lookup done before source address selection is entered, except
> +  with the source address under consideration filled in.  This lookup will hit
> +  the subtree routes that were installed (see first item), giving a fresh
> +  dst_entry.  If the new dst_entry matches the original dst_entry, that means
> +  the original router has in fact sent RAs with PIOs for this source address,
> +  so it is preferred.  Otherwise it is not.
> +
> +
> +There are a few caveats to consider:
> +
> +- the kernel currently does not create the subtree routes mentioned in the
> +  first item.  This is a separate work item, partially done at the time of
> +  writing this.  But this can equally well be performed in userspace processing
> +  of RAs, e.g. NetworkManager or plain static configuration.
> +
> +- since addresses can also be acquired from DHCPv6, even RA/PIO combinations
> +  that didn't result in the creation of any addresses (e.g. A=0) should have
> +  subtree routes added.  Those routes *may* be relevant for DHCPv6-generated
> +  addresses.
> +
> +- the "announce check" lookup does not backtrack.  Only the destination prefix
> +  that provided the "unspecific" (::/128) match is checked for source prefixes
> +  to see what routers advertised what.  This means that for e.g. RIOs, subtree
> +  routes also have to be created.  (Backtracking for this case would further
> +  increase the cost of source address selection, for a pretty rare situation
> +  that has an easy fix/workaround.)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3218abefd0c..4edf48362a07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18912,6 +18912,7 @@ F:	Documentation/netlink/specs/rt-addr.yaml
>  F:	Documentation/netlink/specs/rt-neigh.yaml
>  F:	Documentation/netlink/specs/rt-route.yaml
>  F:	Documentation/netlink/specs/rt-rule.yaml
> +F:	Documentation/networking/ipv6-addrsel.rst

It seems weird to add this one file here - I wonder why there isn't just
an entry for Documentation/networking ?

Thanks,

jon

