Return-Path: <netdev+bounces-257368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOiBC6cthWlR9gMAu9opvQ
	(envelope-from <netdev+bounces-257368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:54:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05EF8707
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4596530160DA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BD33AD9D;
	Thu,  5 Feb 2026 23:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C12C3255;
	Thu,  5 Feb 2026 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335652; cv=none; b=qi7MCHRIJZaw9fFyzelqYparQ3FtDmWCEz/eXoRFn88AgLtJ1Oxfeq8YpTRRDE2OV4bzGZRX5YP52xZ1gfJn8pxi1NFSBqUJmKvbpY2zd1aq08g3K+i/9Ohv8GbHT1tCJFEg9esuZdKAXJQNx3dlAyaI5u+e8aYU24QB4IUfvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335652; c=relaxed/simple;
	bh=ou16QO3sLXbF/QlfOseBPWohDM1dKFADUyaX4h8JOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCHydRLQUvsF9ffWfbrnk7Mj9RBaqgIfoX2mg0CFJ13lna11RPIurbjkn9YEac+qENUt4H4gAdXSxIqB7wKOFPeUSU9mQSRi+JvU3lkflUKUYZE2ssbPTUCvk905B0kz34rg77wqGsWiWamkONyMDM48tqZ+3yfOUJHoAwSmI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2373654CB23;
	Fri,  6 Feb 2026 00:46:40 +0100 (CET)
Date: Fri, 6 Feb 2026 00:46:39 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
Message-ID: <aYUr3_Y41MbygOfv@sellars>
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
 <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
 <aMqb63dWnYDZANdb@shredder>
 <aOEu6uQ4pP4PJH-y@sellars>
 <9cc66694-6fcd-4460-9bce-cdbcb0153a89@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cc66694-6fcd-4460-9bce-cdbcb0153a89@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[c0d3.blue];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257368-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F05EF8707
X-Rspamd-Action: no action

On Mon, Oct 06, 2025 at 11:43:02AM -0400, Huang, Joseph wrote:
> Some systems could not afford to flood multicast traffic. Think of some
> resource-constrained low power sensors connected to a network with high
> volume multicast video traffic for example. The multicast traffic could
> easily choke the sensors and is essentially a DDoS attack.

Just to avoid a misunderstanding, I'm not against the idea of this
patch, to make sure that an MLD query is send as soon as an IPv6
link-local address becomes available.

I also agree that high multicast traffic, as it typically has no congestion
control, can easily saturate low bandwidth links. Annoyingly, WLAN
has a linear backoff time for multicast/broadcast packets while
unicast packets haven an exponential backoff (if I recall
correctly).

> 
> > Which indeed could be optimized and is confusing, this delay could
> > be avoided. Is that that the issue you mean, Joseph?
> > (I'd consider it more an optimization, so for net-next, not
> > net though.)
> > 
> 
> I'm not sure this should be categorized as an optimization. If we never
> intend to send Startup Queries, that's a different story. But if we intend
> to send it but failed, I think that should be a bug.

For net:
https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules
-> "It must either fix a real bug that bothers people or just add a device ID."

(But I'm also not 100% sure if this rule is applicable here.)


> 
> > > In current implementation, :: always wins the election
> > 
> > That would be news to me.
> > 
> > RFC2710, section 5:
> > 
> >     To be valid, the Query message MUST come from a link-
> >     local IPv6 Source Address
> > 
> > RFC3810, section 5.1.14, is even more explicit:
> > 
> >     5.1.14.  Source Addresses for Queries
> > 
> >     All MLDv2 Queries MUST be sent with a valid IPv6 link-local source
> >     address.  If a node (router or host) receives a Query message with
> >     the IPv6 Source Address set to the unspecified address (::), or any
> >     other address that is not a valid IPv6 link-local address, it MUST
> >     silently discard the message and SHOULD log a warning.
> > 
> > So :: can't be used as a source address for an MLD query.
> > And since 2014 with "bridge: multicast: add sanity check for query source addresses"
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6565b9eeef194afbb3beec80d6dd2447f4091f8c)
> > we should be adhering to that requirement? Let me know if I'm missing
> > something.
> > 
> 
> This is what I meant by ":: always wins":
> 
> In br_multicast_select_querier(),
> 
> 	if (ipv6_addr_cmp(&saddr->src.ip6, &querier->addr.src.ip6) <= 0)
> 		goto update;

Did you take into account that a :: query source should not get
until here because such a query should be dropped as invalid in
br_multicast_ipv6_rcv() -> ipv6_mc_check_mld()?

If you've seen a :: MLD query win in the bridge in the wild though,
I'd be very interested in some debug output, that shouldn't be as
intended / would be a serious bug then, as it would violate the RFC
mentioned above. An MLD query with :: source addres simply would not
work. The Linux IPv6 host stack for instance just drops/ignores it here:
https://elixir.bootlin.com/linux/v6.18.6/source/net/ipv6/mcast.c#L1450
Just as the RFC requires.

(And yes, the informational RFC4541, section 3 is also broken in that
regard, where it says "... should use the null IP source address (::) when
sending said [non-querier general query spoofing switch] querier".
That conflicts with RFC3810, section 5.1.14 or RFC2710, section 5.
You won't get the MLD reports you're asking for with ::. Feel free
to try :-). )

> 1. querier->addr.src.ip6 is (un)initialized(?) to 0 (I couldn't find the
> place where ip6_querier.addr is initialized)

br_multicast_update_querier()
-> memcpy(&querier->addr, saddr, sizeof(*saddr))" ?

Regards, Linus

