Return-Path: <netdev+bounces-285148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9tt+Lvsi/GnHLwAAu9opvQ
	(envelope-from <netdev+bounces-285148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F04E318F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00CAC301990C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16492D662F;
	Thu,  7 May 2026 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="Gzfkbbis"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD21B78F3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131703; cv=none; b=NJmKPMm6qfzcwreGI7AG0i7HxzZ/zDDhyAZiuY+G4KJn5HIFUPqASuk8H53n30vUBQOUXlfowAYQB2uQnL11kzl1B+1vXDrDdoTmZTkJXclQi8pNivIA1kHMBT5O0LOxu2ZuCptXNqG0yeP83LWYWwij9PKr0c4YA52qp+DW+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131703; c=relaxed/simple;
	bh=ruOlJ//09seGHSmKY2teRq5HlldEQlYcszhlGAHMVgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ5dopR4WRxEZBFDqYKk4B5tKjFVAHF6YCwZauuMnMs7BWYJl8AzMvIZkgOBNwnyN/2kmgrCiMtKPvf/eJS1qQmOrxjE2pvDkA9BGiu2B85rHhFs362q27WRaedINLvVbTUnCq5ALueCbuwVIfP5oPMEtGro+X0GR5hXjRG7YpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=Gzfkbbis; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1778131320; x=1778995321; bh=ruOl
	J//09seGHSmKY2teRq5HlldEQlYcszhlGAHMVgI=; b=Gzfkbbis0DxlZA9noej1
	039zVggU+Oazur7MRxDDroCCf0HrZ0TZ44BbLrCyIB7xbe99AVdbfOje3ZtA4wKV
	KJNvNh3qbn8SX9SmvpHp0HmNwPtXbQHbhX5/1Gh0h0Z2g1FFt7gv+j8YThYcJruG
	ot8E1jePd5DMN6+Q/YiQnU32T+ZvaXDFsCK1OjPHJ98KttYYWrGCYhQWK8xxVYqL
	RKPw2dvSjXcTGSdiPA3LYAjg8YWcLqudv6zHoHnVtaeXzGXnl8zBoNhqEvTQfw9m
	59ZKAZdUgJBuERfxyhX36drWzqZ8st9XwHcGREA84i0FfJNUbwpASGhOO91RhqPd
	Bw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 07 May 2026 07:21:59 +0200 (CEST)
Date: Thu, 7 May 2026 06:21:57 +0100
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] xfrm: Use regular error handling instead of
 BUG_ON() in the netlink API.
Message-ID: <afwhdRPx-Mko28yM@Antony2201.local>
References: <aftnl6d59WUM_Dfm@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftnl6d59WUM_Dfm@secunet.com>
X-Rspamd-Queue-Id: ED4F04E318F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[phenome.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phenome.org:dkim,Antony2201.local:mid]
X-Rspamd-Action: no action

wHi Steffen,

Thanks Steffen, I was hit by this in the new XFRM_MIGRATE_STATE I am adding.
I am glad to see we are addressing this.

On Wed, May 06, 2026 at 06:08:55PM +0200, Steffen Klassert via Devel wrote:
> The xfrm netlink API uses BUG_ON() on failures since it exists.
> However all these error are uncritical and can be handled
> with regular error handling. This fixes machine crashes
> in situations where an emergency break is not needed.

While BUG_ON is an extreme measure for a recoverable netlink error, it does
have diagnostic value: it leaves a stack trace. The patch trades
a crash + stack trace for a silent error return, which loses observability.

Would you consider using WARN_ONCE instead of a bare if (err < 0)?

-     BUG_ON(err < 0);
+     if (WARN_ONCE(err < 0, "xfrm: build_spdinfo failed: %d\n", err)) {
+         kfree_skb(r_skb);
+         return err;
+     }


Something like the above would preserve the "shouldn't happen" signal with a 
stack trace on first occurrence, without panicking the machine.
Or are there better signaling  styles in Kernel?

> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/xfrm_user.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index d56450f61669..b24a0f9e91d5 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1734,7 +1734,10 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -ENOMEM;
>  
>  	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(r_skb);
> +		return err;
> +	}
>  
>  	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
>  }
> @@ -1794,7 +1797,11 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -ENOMEM;
>  
>  	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(r_skb);
> +		return err;
> +	}
> +
>  
>  	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
>  }
> @@ -3285,7 +3292,10 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  
>  	/* build migrate */
>  	err = build_migrate(skb, m, num_migrate, k, sel, encap, dir, type);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
>  }
> @@ -3623,7 +3633,10 @@ static int xfrm_aevent_state_notify(struct xfrm_state *x, const struct km_event
>  		return -ENOMEM;
>  
>  	err = build_aevent(skb, x, c);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_AEVENTS);
>  }
> @@ -3862,7 +3875,10 @@ static int xfrm_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *xt,
>  		return -ENOMEM;
>  
>  	err = build_acquire(skb, x, xt, xp);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
>  }
> @@ -3984,7 +4000,10 @@ static int xfrm_exp_policy_notify(struct xfrm_policy *xp, int dir, const struct
>  		return -ENOMEM;
>  
>  	err = build_polexpire(skb, xp, dir, c);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
>  }
> @@ -4151,7 +4170,8 @@ static int xfrm_send_report(struct net *net, u8 proto,
>  		return -ENOMEM;
>  
>  	err = build_report(skb, proto, sel, addr);
> -	BUG_ON(err < 0);
> +	if (err < 0)
> +		return err;
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_REPORT);
>  }
> @@ -4206,7 +4226,10 @@ static int xfrm_send_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
>  		return -ENOMEM;
>  
>  	err = build_mapping(skb, x, ipaddr, sport);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MAPPING);
>  }
> -- 
> 2.43.0
> 

