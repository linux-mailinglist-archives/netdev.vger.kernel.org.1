Return-Path: <netdev+bounces-275568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KODJN4aP02lWjAcAu9opvQ
	(envelope-from <netdev+bounces-275568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCA3A2E90
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970C730131C7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08AA2E974D;
	Mon,  6 Apr 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT1ynYE6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92629AB1A;
	Mon,  6 Apr 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472514; cv=none; b=BFT5FhCGP5yh5ItIy4/oOXLLSYjhCAaPcr0KBVHI1jYGGx2Qd0FYgUJ0cT2185ej92/SZqcJUDjWQMl0WXimFGkitNIn3aLcO5pu4a65w1ON0Ygko6UDO7uveerOYq6ZdN+IyrLIIaftl7Og+Ajh1nE5gSDIiOdTnQeO9WXO+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472514; c=relaxed/simple;
	bh=wRknuBZkIqancIXrcQUTPJJqXUPLtdGU/WPeK77mUCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFUoyJyWcCv0He1LjQ+p2xaMPfajB5WFg7+rzp2ftuytxopUg92Ic28E7nWy69AqCdu5xb50m4S5YxCk7+DyqVFwX69muwcEyL4i5inRD0+KNKy/xXtc2DffJNZb/SWOefJkjqwhbSILPz6YVc7bgg/iwLCbdPgEgGuyEkUKsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT1ynYE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0BAC4CEF7;
	Mon,  6 Apr 2026 10:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775472514;
	bh=wRknuBZkIqancIXrcQUTPJJqXUPLtdGU/WPeK77mUCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iT1ynYE6p+F7HyEqgt2dXGYoKGYtu3h9lZ+AiaWJDtul1mTFwoZceCGyVHY5+seSH
	 wmRzDsPYRCmgjbc+J3XqqDJnpTI1+K0FbK0OnVXOK9yVvd+7QqpAz6m5VY9SKFH84X
	 1DEOnQfvtu3PLkVhiQ6tuNEWHe1sNIY/7pAfJXr8KYyOO0JZ7coE8Vv8yJ6g6Xq7qB
	 E6HJFxPM91eOYIvylJfjEBtgfx8Ks1lD8aTV+m8yBVw8hyqwUI927fWXkfevWHPOnF
	 3TvEZzG4sET7gg7iQINg227rqTj6irqA/eVAbU2zpqurl60ZRp87EcwkOQLH8AbEzV
	 R4YOCeDhKaz1Q==
Message-ID: <c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
Date: Mon, 6 Apr 2026 12:48:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in icmp_build_probe():
 manual merge
Content-Language: fr
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260402070419.2291578-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8CDCA3A2E90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

+cc linux-next

On 02/04/2026 09:04, Yiqi Sun wrote:
> ipv6_stub->ipv6_dev_find() may return ERR_PTR(-EAFNOSUPPORT) when the
> IPv6 stack is not active (CONFIG_IPV6=m and not loaded), and passing
> this error pointer to dev_hold() will cause a kernel crash with
> null-ptr-deref.
> 
> Instead, silently discard the request. RFC 8335 does not appear to
> define a specific response for the case where an IPv6 interface
> identifier is syntactically valid but the implementation cannot perform
> the lookup at runtime, and silently dropping the request may safer than
> misreporting "No Such Interface".

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in icmp_build_probe()")

and this one from 'net-next':

  d98adfbdd5c0 ("ipv4: drop ipv6_stub usage and use direct function calls")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Rerere cache is available in [2].

1: https://github.com/multipath-tcp/mptcp_net-next/commit/c14d8597c9a0
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/d4699ea

> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 568bd1e95d44..d294666c68d9 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c

(...)

>  bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
> @@ -1346,6 +1347,13 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
>  			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
>  				goto send_mal_query;
>  			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);

The conflict was in the context: the commit in net-next modified this
line above, while the one in net added this block below.

> +			/*
> +			 * If IPv6 identifier lookup is unavailable, silently
> +			 * discard the request instead of misreporting NO_IF.
> +			 */
> +			if (IS_ERR(dev))
> +				return false;
> +
>  			dev_hold(dev);
>  			break;
>  #endif

----------------------- 8< -----------------------
diff --cc net/ipv4/icmp.c
index 2f4fac22d1ab,4e2a6c70dcd8..f1c715cc3800
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@@ -1342,7 -1345,14 +1342,14 @@@ bool icmp_build_probe(struct sk_buff *s
  		case ICMP_AFI_IP6:
  			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
  				goto send_mal_query;
 -			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
 +			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+ 			/*
+ 			 * If IPv6 identifier lookup is unavailable, silently
+ 			 * discard the request instead of misreporting NO_IF.
+ 			 */
+ 			if (IS_ERR(dev))
+ 				return false;
+ 
  			dev_hold(dev);
  			break;
  #endif
----------------------- 8< -----------------------

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

