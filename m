Return-Path: <netdev+bounces-252144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BybOkuKcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8F60DCE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E515C867E49
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D932AAA0;
	Thu, 22 Jan 2026 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAc00jR3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F030EF97
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048475; cv=none; b=RcTIte1FChKPzAQfJq4k1qR0yhiVTy4KnVLYPdhA5iPRSj6o+YxDEfHuBgcDfBfkDRltHsa5LjTRxB+tTzgrgwa7mNJID2WAVQVuaygZHmxSSIYN+K49DlYh2ehfb0s02OiqaJ04xo4Wbq/B1BcHeJMDzmBbO2MO465XSDjswpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048475; c=relaxed/simple;
	bh=Te6JyfZsSETTDHZ07TOnvhmBEyCZYHJrThFridC1oEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqDiVRGWRnJ5rH5IcI95QUwWGhRBVSnJdFRVZC+33C3KRU+mDkNUpZvdveSKPAdjyq6WZeW66zdcuLUhVVLYZTdfX5qdSMAYaBeyZswDF4GVxALzGlvZEBFhwtUxIXKdj3UnN5+i9i3zGW1ElHA2Y1ntC3taNC4qG590WRRHe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAc00jR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C3C4CEF1;
	Thu, 22 Jan 2026 02:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769048474;
	bh=Te6JyfZsSETTDHZ07TOnvhmBEyCZYHJrThFridC1oEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAc00jR3AlrI2hMTRfuZi0R6J6oNLbIhKipBr++frqWoqTN66SVo7yzFG3EfyYt7P
	 qKSp2RpKV99OhYRPzxnwkdfMC0QBD1OaZ/1Eo0xIODiaLmGz/fPR9Vwm88mGfM+Frg
	 asrQBgy8EF1qa6XH7jA2Mcx5WafRRx9m3t6m/+efACzjRGFS2v4HloI3G4jGzgxUNh
	 2IEIPGoEYEa0CEeBx94FTCh1tUSgi9/xeIsXZJG5p4Xp43VepAuSyOZwsI0lmaGvzY
	 W3yLiXpt2Jk7nbcO0a40RoUyhSfREUjCfhV96cp+QUXg2B1zqNud61D79CKYEXdunq
	 Zrthg2RT87jFA==
From: Jakub Kicinski <kuba@kernel.org>
To: mmietus97@yahoo.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	sd@queasysnail.net
Subject: Re: [net-next,v6,04/11] net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
Date: Wed, 21 Jan 2026 18:21:06 -0800
Message-ID: <20260122022106.2528669-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120162451.23512-5-mmietus97@yahoo.com>
References: <20260120162451.23512-5-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252144-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 69A8F60DCE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup

This commit updates udp_tunnel{,6}_dst_lookup to return noref dsts when
possible. All callers are updated to properly use the new noref argument
and conditionally release the dst based on whether they own a reference.

> diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
> index 92ee4a36f86f..1aa3d5d74a84 100644
> --- a/drivers/net/bareudp.c
> +++ b/drivers/net/bareudp.c
> @@ -315,6 +315,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  	int min_headroom;
>  	__u8 tos, ttl;
>  	__be32 saddr;
> +	bool noref;
>  	int err;

[ ... ]

> @@ -329,7 +330,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
>  				   sport, bareudp->port, key->tos,
>  				   use_cache ?
> -				   (struct dst_cache *)&info->dst_cache : NULL);
> +				   (struct dst_cache *)&info->dst_cache : NULL,
> +				   &noref);

[ ... ]

> @@ -364,7 +366,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
>  			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
>  			    0);
> -	ip_rt_put(rt);
> +	if (!noref)
> +		ip_rt_put(rt);
>  	return 0;
>
>  free_dst:
>  	dst_release(&rt->dst);
            ^^^^^^^^^^^^^^^^^^^^

The success path above correctly checks if (!noref) before calling
ip_rt_put(), but the free_dst error path still unconditionally calls
dst_release(). When the dst comes from the cache (noref == true) and an
error occurs in the operations between the lookup and xmit, this would
decrement a refcount we do not own.

For comparison, bareudp6_xmit_skb() in this same patch correctly wraps
both its success and error paths with if (!noref) checks:

> @@ -434,11 +439,13 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  			     !test_bit(IP_TUNNEL_CSUM_BIT,
>  				       info->key.tun_flags),
>  			     0);
> -	dst_release(dst);
> +	if (!noref)
> +		dst_release(dst);
>  	return 0;
>
>  free_dst:
> -	dst_release(dst);
> +	if (!noref)
> +		dst_release(dst);
>  	return err;

Should the free_dst label in bareudp_xmit_skb() also be wrapped with
if (!noref)?

