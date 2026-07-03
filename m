Return-Path: <netdev+bounces-304456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PfRHH814R2pEYwAAu9opvQ
	(envelope-from <netdev+bounces-304456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38170700521
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="AR9w7dn/";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304456-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304456-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94DCE3006680
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB8332615;
	Fri,  3 Jul 2026 08:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3A2D5C68
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:54:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068857; cv=none; b=V29i6MTbQbDjiHmX/sgQdQZOCxjS6ujqkYvZJEPt4XQFy4qbwuurA8RGGpMfyKXcLrRVxa4BYv/AaRP+ROb1zgUJH5hUFOhxiZKMVUn3MIaNanGFGkE6YFu8rSn8NxIhuJtVwBLWFC6fthrgW0ib4qAlzL8Z2j6K3w3Sy2vXg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068857; c=relaxed/simple;
	bh=1mp+ykGyfNZeDi07DrfcVudq3ifVmKN7yNrya0YCtdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhQE9q5UpodKjFsZbLZY3+xDvXXyidmT9tDk4f0QRTnVJtzB2AAFUXSmYpJ0O+bxj2Nzg5ZxiHVzI2JYedDufM+zHAshAcEbv98lfrUdl0MxSj5tgKriegHWfrfhEP4uWQSTwhzmKcabKdm/gxJr1vya9gMVpXWuoImrLuLvY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=AR9w7dn/; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 2AA146017D;
	Fri,  3 Jul 2026 10:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783068852;
	bh=uSEMAlcW6Sx1VCM6pJU5+bXjQz4ObU/4mteMM2IBcoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AR9w7dn/sU2qhY+p4Pt3d1HAyNw/Aaw0Q5Do5pq5YB8JKqeR3n49WlfvNAqzGAZuw
	 t0nX4PYcH0Uj3oOdAmnRt1F7KHZEIycqlsLnhguXfYDNI43SRTDMvI1xA1TioUm44z
	 L41P6m/DJcNRvCHOLxkeZBdVi5q+ho4bkqvH529vdVLed9AAY9LDTZLrZSFYcrU2Wy
	 VBIekpmJvY/okyfXXrh0f/NhK/1LGLpdtVW0k45TlqDG3P6hEIS7xqs88HZLynfpZh
	 +dDMa5+UtAI188hRzBuM4vR4j9n5tju3xJqGT6jOobXay8LAfrZ4IGG1ECXWaXQqmw
	 eF7fmkI2tdE9A==
Date: Fri, 3 Jul 2026 10:54:08 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhixing Chen <running910@gmail.com>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] gtp: parse extension headers before reading inner
 protocol
Message-ID: <akd4sLY7qR0597Si@chamomile>
References: <20260703084244.59077-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703084244.59077-1-running910@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304456-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gtp_nsroot_recv.py:url,netfilter.org:from_mime,netfilter.org:dkim,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38170700521

On Fri, Jul 03, 2026 at 04:42:44PM +0800, Zhixing Chen wrote:
> GTPv1-U packets may carry a chain of extension headers before the inner
> IP packet. The receive path already parses and skips these extension
> headers, but it currently reads the inner protocol before doing so.
> 
> As a result, the first extension header byte is interpreted as the inner
> IP version. Packets with extension headers are then dropped before PDP
> lookup.
> 
> Parse the extension header chain before calling gtp_inner_proto(), so the
> inner protocol is read from the actual inner IP header.

Missing Fixes: tag.

> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---
> 
> I noticed this while running a few GTP tunnel tests with a veth pair and a
> peer network namespace.
> 
> The commands below only set up a small GTPv1-U demo and verify that the
> plain tunnel works as expected:
> 
>   ip link add vroot type veth peer name vpeer
>   ip a a 172.0.0.1/24 dev vroot
>   ip link set vroot up
>   ip a a 172.99.0.1/32 dev lo
>   gtp-link add gtp0 ip 172.0.0.1 &
>   gtp-tunnel add gtp0 v1 200 100 172.99.0.2 172.0.0.2
>   ip r a 172.99.0.2/32 dev gtp0
>   ip link set gtp0 mtu 1500
> 
>   ip netns add nspeer
>   ip link set vpeer netns nspeer
>   ip netns exec nspeer ip a a 172.0.0.2/24 dev vpeer
>   ip netns exec nspeer ip link set vpeer up
>   ip netns exec nspeer ip a a 172.99.0.2/32 dev lo
>   ip netns exec nspeer ip link set lo up
> 
>   ip netns exec nspeer gtp-link add gtp1 ip 172.0.0.2 &
>   ip netns exec nspeer gtp-tunnel add gtp1 v1 100 200 172.99.0.1 172.0.0.1
>   ip netns exec nspeer ip r a 172.99.0.1/32 dev gtp1
>   ip netns exec nspeer ip link set gtp1 mtu 1500
> 
> With this setup, plain traffic between 172.99.0.1 and 172.99.0.2 goes
> through the GTP tunnel.
> 
> After that, I used a small sender in the peer namespace to build two
> UDP/2152 packets for the root namespace GTP endpoint. Both packets use TEID
> 200 and carry an inner UDP packet from 172.99.0.2:12345 to
> 172.99.0.1:9999. The first packet is a plain GTPv1-U T-PDU. The second
> packet carries the same inner UDP packet after a GTP extension header.
> 
> Before this fix, a receiver bound to 172.99.0.1:9999 only receives the
> plain packet:
> 
>   root@vm:/# python gtp_nsroot_recv.py
>   listening on 172.99.0.1:9999
>   received #1 from ('172.99.0.2', 12345): b'plain'
> 
> After this fix, it receives both packets:
> 
>   root@vm:/# python gtp_nsroot_recv.py
>   listening on 172.99.0.1:9999
>   received #1 from ('172.99.0.2', 12345): b'plain'
>   received #2 from ('172.99.0.2', 12345): b'extension'
> 
> ---
>  drivers/net/gtp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index a60ef32b35b8..4a8b00548673 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -826,6 +826,10 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
>  	if (!pskb_may_pull(skb, hdrlen))
>  		return -1;
>  
> +	if (gtp1->flags & GTP1_F_EXTHDR &&
> +	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
> +		return -1;
> +
>  	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
>  		netdev_dbg(gtp->dev, "GTP packet does not encapsulate an IP packet\n");
>  		return -1;
> @@ -840,10 +844,6 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
>  		return 1;
>  	}
>  
> -	if (gtp1->flags & GTP1_F_EXTHDR &&
> -	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
> -		return -1;
> -
>  	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
>  }
>  
> -- 
> 2.34.1
> 

