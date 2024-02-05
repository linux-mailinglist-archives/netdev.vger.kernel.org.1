Return-Path: <netdev+bounces-69025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF4849300
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 05:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D9C1C210E3
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 04:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4F9468;
	Mon,  5 Feb 2024 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy6D5Vwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90581AD22
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108318; cv=none; b=iOp2jZE9TD3T77vVehpx4nL+npqHZo8rPxPPlttmRzU2o0ZRG8XRUbNZx5+lXITODjRqU79MaxzsJU7B2g+vxSjKes7FRALY4qO37kz2HnMjXKXwqT+f1QBdcPwZMkbSO3/EQPaYT6j67811Rrp5E5ZN+K4UDxR+jXkejDbks4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108318; c=relaxed/simple;
	bh=zodg4pjND8pp/3Aql4d4jo/RRU8mCqXSLetSXg1Gc1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfvuSqll/rFZ6iCSIutNuB6+GZNiPuPT30fzH5+BRRcDzEmsIxoQajVNw+5mRTbef9nS9u+hK36S0GhutrS6KL30OsTPzI3llNQPIbJ5YyMBMb3TuUNI4y231SWO3ADSjfL32Bdj34v1t0Weh/fODf3fqqgWTZJV9K8p+94W82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy6D5Vwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525D9C433F1;
	Mon,  5 Feb 2024 04:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707108317;
	bh=zodg4pjND8pp/3Aql4d4jo/RRU8mCqXSLetSXg1Gc1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cy6D5VwqJmoNgZEFz57gxpDEgrqaH3KaNJpdzIbQYC4QtSIVmYG3MFOhXzqwbZu3r
	 7+KgjoI3Hu67RuqIRup0vxec4Ms/82T2fX62EHSlVsPhFUEa1jApjQ4KjTN1vcl7CZ
	 yz1znv9EkrJESNMhjYW2hFCD3EFABrYg5c2I3XYuNC2BBGQ3Gg42FwuzmCiaj/T0pm
	 FDPbMxvvZh/qfQc8LHdRvQOmYAX9gv9Dca6M9qKE3LQAita8SIs7JJgE3JBcuD4Rrn
	 MFCcHDGXy/qDxXkokXib+H5Dx8aqWpnuM5Am4gy+Uk3RDQrQ99IcAnfQeG9ocfIGEQ
	 xKd4gJQ8YYP6w==
Message-ID: <2ddfe75a-45e4-4499-8aae-4d83de90d1ce@kernel.org>
Date: Sun, 4 Feb 2024 21:45:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-4-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240202082200.227031-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 1:21 AM, thinker.li@gmail.com wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 733ace18806c..36bfa987c314 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1255,6 +1255,7 @@ static void
>  cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
>  		     bool del_rt, bool del_peer)
>  {
> +	struct fib6_table *table;
>  	struct fib6_info *f6i;
>  
>  	f6i = addrconf_get_prefix_route(del_peer ? &ifp->peer_addr : &ifp->addr,

addrconf_get_prefix_route walks the table, so you know it is already
there ...

> @@ -1264,8 +1265,18 @@ cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
>  		if (del_rt)
>  			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
>  		else {
> -			if (!(f6i->fib6_flags & RTF_EXPIRES))
> +			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
> +				table = f6i->fib6_table;
> +				spin_lock_bh(&table->tb6_lock);
>  				fib6_set_expires(f6i, expires);
> +				/* If fib6_node is null, the f6i is just
> +				 * removed from the table.
> +				 */
> +				if (rcu_dereference_protected(f6i->fib6_node,

... meaning this check should not be needed

> +							      lockdep_is_held(&table->tb6_lock)))
> +					fib6_add_gc_list(f6i);
> +				spin_unlock_bh(&table->tb6_lock);
> +			}
>  			fib6_info_release(f6i);
>  		}
>  	}
> @@ -2706,6 +2717,7 @@ EXPORT_SYMBOL_GPL(addrconf_prefix_rcv_add_addr);
>  void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
>  {
>  	struct prefix_info *pinfo;
> +	struct fib6_table *table;
>  	__u32 valid_lft;
>  	__u32 prefered_lft;
>  	int addr_type, err;
> @@ -2782,11 +2794,23 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
>  			if (valid_lft == 0) {
>  				ip6_del_rt(net, rt, false);
>  				rt = NULL;
> -			} else if (addrconf_finite_timeout(rt_expires)) {
> -				/* not infinity */
> -				fib6_set_expires(rt, jiffies + rt_expires);
>  			} else {
> -				fib6_clean_expires(rt);
> +				table = rt->fib6_table;
> +				spin_lock_bh(&table->tb6_lock);

when it comes to locking, I prefer the lock and unlock lines to *pop* -
meaning newline on both sides so it is clear and stands out.

> +				if (addrconf_finite_timeout(rt_expires)) {
> +					/* not infinity */
> +					fib6_set_expires(rt, jiffies + rt_expires);
> +					/* If fib6_node is null, the f6i is
> +					 * just removed from the table.
> +					 */
> +					if (rcu_dereference_protected(rt->fib6_node,

similarly here, this code is entered because rt is set based on
addrconf_get_prefix_route.

> +								      lockdep_is_held(&table->tb6_lock)))
> +						fib6_add_gc_list(rt);
> +				} else {
> +					fib6_clean_expires(rt);
> +					fib6_remove_gc_list(rt);
> +				}
> +				spin_unlock_bh(&table->tb6_lock);
>  			}
>  		} else if (valid_lft) {
>  			clock_t expires = 0;
> @@ -4741,6 +4765,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
>  			       unsigned long expires, u32 flags,
>  			       bool modify_peer)
>  {
> +	struct fib6_table *table;
>  	struct fib6_info *f6i;
>  	u32 prio;
>  
> @@ -4761,10 +4786,21 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
>  				      ifp->rt_priority, ifp->idev->dev,
>  				      expires, flags, GFP_KERNEL);
>  	} else {
> -		if (!expires)
> +		table = f6i->fib6_table;
> +		spin_lock_bh(&table->tb6_lock);
> +		if (!expires) {
>  			fib6_clean_expires(f6i);
> -		else
> +			fib6_remove_gc_list(f6i);
> +		} else {
>  			fib6_set_expires(f6i, expires);
> +			/* If fib6_node is null, the f6i is just removed
> +			 * from the table.
> +			 */
> +			if (rcu_dereference_protected(f6i->fib6_node,

and here as well. f6i is set based on a table lookup.

> +						      lockdep_is_held(&table->tb6_lock)))
> +				fib6_add_gc_list(f6i);
> +		}
> +		spin_unlock_bh(&table->tb6_lock);
>  
>  		fib6_info_release(f6i);
>  	}

...

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index a68462668158..5ca9fd4f7945 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1410,8 +1410,17 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  		inet6_rt_notify(RTM_NEWROUTE, rt, &nlinfo, NLM_F_REPLACE);
>  	}
>  
> -	if (rt)
> +	if (rt) {
> +		spin_lock_bh(&rt->fib6_table->tb6_lock);
>  		fib6_set_expires(rt, jiffies + (HZ * lifetime));
> +		/* If fib6_node is null, the f6i is just removed from the
> +		 * table.
> +		 */

How about:
		/* If fib6_node is NULL, the route was removed between
		 * the rt6_get_dflt_router or rt6_add_dflt_router calls
		 * above and here.
		 */

> +		if (rcu_dereference_protected(rt->fib6_node,> +					      lockdep_is_held(&rt->fib6_table->tb6_lock)))
> +			fib6_add_gc_list(rt);
> +		spin_unlock_bh(&rt->fib6_table->tb6_lock);
> +	}
>  	if (in6_dev->cnf.accept_ra_min_hop_limit < 256 &&
>  	    ra_msg->icmph.icmp6_hop_limit) {
>  		if (in6_dev->cnf.accept_ra_min_hop_limit <= ra_msg->icmph.icmp6_hop_limit) {
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index dd6ff5b20918..cfaf226ecf98 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -989,10 +989,20 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
>  				 (rt->fib6_flags & ~RTF_PREF_MASK) | RTF_PREF(pref);
>  
>  	if (rt) {
> -		if (!addrconf_finite_timeout(lifetime))
> +		spin_lock_bh(&rt->fib6_table->tb6_lock);
> +		if (!addrconf_finite_timeout(lifetime)) {
>  			fib6_clean_expires(rt);
> -		else
> +			fib6_remove_gc_list(rt);
> +		} else {
>  			fib6_set_expires(rt, jiffies + HZ * lifetime);
> +			/* If fib6_node is null, the f6i is just removed
> +			 * from the table.
> +			 */

Similarly, enhance the comment:
			/* If fib6_node is NULL, the route was removed
			 * between the get or add calls above and here.
			 */
> +			if (rcu_dereference_protected(rt->fib6_node,
> +						      lockdep_is_held(&rt->fib6_table->tb6_lock)))
> +				fib6_add_gc_list(rt);
> +		}
> +		spin_unlock_bh(&rt->fib6_table->tb6_lock);
>  
>  		fib6_info_release(rt);
>  	}


