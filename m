Return-Path: <netdev+bounces-108588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05927924745
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C88B211A1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF21BB6A1;
	Tue,  2 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="gBVBB012"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E515B0FE;
	Tue,  2 Jul 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945017; cv=none; b=KwyG8/ADV0Vul4P3COKOh5uLwVa/mn0dvOdv58bfmcdryXfHgr4yNFmVwqgEcR8hZSeeAoLpBxQ5kW0yar6iN8kdA4467ufra/4MjDUo1lF4o28N9Ue6dPc/jp7uIX/P7GMwvN5gMjanluNFZV+WCnYfEuWIbGwgtO7AAWokP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945017; c=relaxed/simple;
	bh=mkzx4GZZ7v8MlE2lFXruNChUcVJJStgHKf+MnqgVCR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNGKjNU7YaijzPc7mjeJbP+ULAQjuLOwBnHC5tB102gOefKT6jsaveUHcbv+Y5bySz6/YMKevetKXEmqiVrV2XhxigyZfg4V6zfbroyuKzNeC9zfXlYhcEmSiALkip4OwTvHDNqJjfMx1QFkM206kQvzs96RFRvCdc1PCd0VuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=gBVBB012; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.17] (48.39-182-91.adsl-dyn.isp.belgacom.be [91.182.39.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 5E284200BFE3;
	Tue,  2 Jul 2024 20:30:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 5E284200BFE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1719945013;
	bh=CpgYOOQn+M4Cm6o301G6/udMHGrxro4JJRy3+oFtaWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gBVBB012lEDPO6Jyy2ptZRyUkRcfyyCrJ4A2Rj2ieZ31jKUcK21q7rJQ6jDL+1UUd
	 fZgR2e/UAwHCmGOWnmCC0FHkuRR7nNn/KAXRhPiBGvcN6zcJLZMx3cg05X3YS5RaSq
	 DYFYYe3yXXNOhEmw1Z2l7j0/Ju7SqrqG52qUsKQGwnY3rTQGdVaqgEvnwpkrjIvUOG
	 BixgyyExB/WgKoucf/755mBk3EsTtZDzVmihhoAR2uHMdL1BEH36F63w7bDLDp21rd
	 hWNT6CscRNvlue4COzSnFk8zTlbhn8ZdE8c6Aiz9hT/vWbytj19+H09MKDaAewAMaO
	 Wkh1nzQILnFvA==
Message-ID: <d6b0d5ff-d3b0-4eda-b6ed-11add69f4dff@uliege.be>
Date: Tue, 2 Jul 2024 20:30:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ioam6: mitigate the two reallocations
 problem
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 justin.iurman@uliege.be
References: <20240702174451.22735-1-justin.iurman@uliege.be>
 <20240702174451.22735-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240702174451.22735-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 19:44, Justin Iurman wrote:
> Get the cache _before_ adding bytes. This way, we provide the dst entry
> to skb_cow_head(), so that we call LL_RESERVED_SPACE() on it and avoid
> two reallocations in some specific cases. We cannot do much when the dst
> entry is empty (cache is empty, this is the first time): in that case,
> we use skb->mac_len by default and two reallocations will happen in
> those specific cases. However, it will only happen once, not every
> single time.

This fix could also be applied to seg6 and rpl. Not sure if the problem 
would show up though (I did some quick computations, seems unlikely), 
but still... would probably be interesting to have it there too, just in 
case. Any opinion?

> Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   net/ipv6/ioam6_iptunnel.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index b08c13550144..e5a7e7472b71 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -220,14 +220,16 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
>   }
>   
>   static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
> -			   struct ioam6_lwt_encap *tuninfo)
> +			   struct ioam6_lwt_encap *tuninfo,
> +			   struct dst_entry *dst)
>   {
>   	struct ipv6hdr *oldhdr, *hdr;
>   	int hdrlen, err;
>   
>   	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>   
> -	err = skb_cow_head(skb, hdrlen + skb->mac_len);
> +	err = skb_cow_head(skb, hdrlen + (!dst ? skb->mac_len
> +					       : LL_RESERVED_SPACE(dst->dev)));
>   	if (unlikely(err))
>   		return err;
>   
> @@ -256,16 +258,17 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>   
>   static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>   			  struct ioam6_lwt_encap *tuninfo,
> -			  struct in6_addr *tundst)
> +			  struct in6_addr *tundst,
> +			  struct dst_entry *dst)
>   {
> -	struct dst_entry *dst = skb_dst(skb);
>   	struct ipv6hdr *hdr, *inner_hdr;
>   	int hdrlen, len, err;
>   
>   	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>   	len = sizeof(*hdr) + hdrlen;
>   
> -	err = skb_cow_head(skb, len + skb->mac_len);
> +	err = skb_cow_head(skb, len + (!dst ? skb->mac_len
> +					    : LL_RESERVED_SPACE(dst->dev)));
>   	if (unlikely(err))
>   		return err;
>   
> @@ -285,7 +288,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>   	hdr->nexthdr = NEXTHDR_HOP;
>   	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
>   	hdr->daddr = *tundst;
> -	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
> +	ipv6_dev_get_saddr(net, skb_dst(skb)->dev, &hdr->daddr,
>   			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
>   
>   	skb_postpush_rcsum(skb, hdr, len);
> @@ -313,6 +316,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   
>   	orig_daddr = ipv6_hdr(skb)->daddr;
>   
> +	local_bh_disable();
> +	dst = dst_cache_get(&ilwt->cache);
> +	local_bh_enable();
> +
>   	switch (ilwt->mode) {
>   	case IOAM6_IPTUNNEL_MODE_INLINE:
>   do_inline:
> @@ -320,7 +327,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
>   			goto out;
>   
> -		err = ioam6_do_inline(net, skb, &ilwt->tuninfo);
> +		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
>   		if (unlikely(err))
>   			goto drop;
>   
> @@ -328,7 +335,8 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   	case IOAM6_IPTUNNEL_MODE_ENCAP:
>   do_encap:
>   		/* Encapsulation (ip6ip6) */
> -		err = ioam6_do_encap(net, skb, &ilwt->tuninfo, &ilwt->tundst);
> +		err = ioam6_do_encap(net, skb,
> +				     &ilwt->tuninfo, &ilwt->tundst, dst);
>   		if (unlikely(err))
>   			goto drop;
>   
> @@ -346,10 +354,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		goto drop;
>   	}
>   
> -	local_bh_disable();
> -	dst = dst_cache_get(&ilwt->cache);
> -	local_bh_enable();
> -
>   	if (unlikely(!dst)) {
>   		struct ipv6hdr *hdr = ipv6_hdr(skb);
>   		struct flowi6 fl6;
> @@ -371,15 +375,15 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		local_bh_disable();
>   		dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
>   		local_bh_enable();
> +
> +		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> +		if (unlikely(err))
> +			goto drop;
>   	}
>   
>   	skb_dst_drop(skb);
>   	skb_dst_set(skb, dst);
>   
> -	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> -	if (unlikely(err))
> -		goto drop;
> -
>   	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr))
>   		return dst_output(net, sk, skb);
>   out:

