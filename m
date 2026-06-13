Return-Path: <netdev+bounces-299044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1GRmMPO/LWq8jQQAu9opvQ
	(envelope-from <netdev+bounces-299044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A267FAA2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:39:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UaNVDPLs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299044-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299044-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04BBF3007F53
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF77342509;
	Sat, 13 Jun 2026 20:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8532C11DF;
	Sat, 13 Jun 2026 20:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383122; cv=none; b=OIjBJ3befYtU8g/C9ORXo7Mjqv6X69jx2KwBStTKQ5Dt1F4Kz0R/Vz2Qo2DKFJv24FC6/0nszfS+TDOYeInivpItNTFUD0s4+kMdGt4eEnJu++S3JwfcyI/+89TA7gjtFrSC5fC4TkliIQNOdVoA+OoTSYjMEZ9lDLpBTc4KTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383122; c=relaxed/simple;
	bh=TMcFnPdnw3SYsADReoQJoyHz6z0B0k3u/pVjFIqAqkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1f3ihFpalCWXH6kS2DBNxgmGMYQQKlIvbw1HXnURXQQb2YdTVFJWcQAenZMCNOQVU9acFx5rALsBY3KrP2QoAuiknys9KxKWV6Ff53BsQplMQamH6HVYaEdrl0cwY4qtRjyoFZSNkAOse7A+HQe2wkPxgvaY9ToM/YTIyfeexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaNVDPLs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125EB1F000E9;
	Sat, 13 Jun 2026 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781383120;
	bh=yAfmC+aX1bZveUBO4giQMJshYhR58JyfWmxpjWM75Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UaNVDPLs4S38PEJb5MaNt4CnxQRTtN2wwd0/OCh0ncEbnLndlZPylw9trPIMeB8F0
	 qC9rmwN8Kzt+R8znR8mg5D9lA5dTxmvkEj5opmF/DZ3sS22SctVfzrMZO8Tt26ccH0
	 hjsYIWSHBbCpnvKp1QeGciz+8Hh+jHgeOgvJySOv0AIcZqwYGKzahjrLGVtT0R17G/
	 MpYAKpw6b2eCzJtslGWfDox38Lfz7dRFBeOwgOUiIPYhYkNDUniZahBKgxs6kUHDrZ
	 WMATMM+M9rOep8AS0PFpgn3L1fTMXiNgTbEAKGpiEIjpTFzIrtt4cIZJ40i9R1Ez3J
	 cnJjSwBdUTxdA==
Date: Sat, 13 Jun 2026 13:38:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marex@denx.de, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 nb@tipi-net.de
Subject: Re: [PATCH net-next v6 3/5] net: dsa: tag_ks8995: Add the KS8995
 tag handling
Message-ID: <20260613133839.6877ed3e@kernel.org>
In-Reply-To: <CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
References: <20260608-ks8995-to-ksz8-v6-3-d91eb43edcc5@kernel.org>
	<20260610153952.1685895-1-kuba@kernel.org>
	<CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299044-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:nb@tipi-net.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,denx.de,armlinux.org.uk,vger.kernel.org,tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A1A267FAA2

On Sat, 13 Jun 2026 18:56:03 +0200 Linus Walleij wrote:
> Which is what I do.
> 
> So yeah. skb_free() will be free:ed twice. The code in tag_8021q.c will
> also do that. But what do you expect ->xmit() to return on error if
> not NULL?
> 
> When user.c does this:
> 
>     /* Transmit function may have to reallocate the original SKB,
>      * in which case it must have freed it. Only free it here on error.
>      */
>     nskb = p->xmit(skb, dev);
>     if (!nskb) {
>         kfree_skb(skb);
>         return NETDEV_TX_OK;
>     }
> 
>     return dsa_enqueue_skb(nskb, dev);
> 
> The only way to get clean out of this branch if you run
> into an error in ->xmit() is to return NULL!

Yes, maybe DSA experts remember the background here, and can guide us
But from a fresh look this and ->rcv have very odd semantics.

  nskb = func(skb);

should assume skb is either freed or returned. Freeing the input param
on failure of func() is a rather strange pattern.

I vote we drop these kfree_skb()s (both xmit and rcv) and fix up any
driver that depended on them (if any)?

