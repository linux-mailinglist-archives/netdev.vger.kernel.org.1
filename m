Return-Path: <netdev+bounces-161529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608AFA2218B
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E61167E7F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB21D61B5;
	Wed, 29 Jan 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="q7QJTTNj"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698371DE4E6
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167452; cv=none; b=b6BZVnnlZdEPx7M6rLpW6EdiEatzzGZaZ1aBhhVpgh2NMRNdzLC7lITWn7GYju8aLLuUhzXX5XbjKbCKMoicMcvGM8fu6rtcffvSneZZDAXzikc25NE3IY6xUyC6PibA07Z0LHb73lJb9phTVyaQRxEmFWEEP0F1azEnjlBYJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167452; c=relaxed/simple;
	bh=rZmEshHoXwZoN2KoEP+XL5rDT5zaWx8DcTuL7uucOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPS800D9aRktWngXWDYUwK7qw/xt7u1kF+3vZ1TEH++Evx5B+ZysvYhh1ssEf8z+U9dgG3+RI2aS8EsxLFuHAOf8GIkBG1U2XIEnXQPYdUcQLNsKmuow8qGG22yxuzC/M/9QkysdD1pnqLo3am22ltJeMvwKoRKuxYZL7mIepTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=q7QJTTNj; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8DB18201222A;
	Wed, 29 Jan 2025 17:17:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8DB18201222A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738167448;
	bh=yQ4MgnjLsUYHsXicBvhg7aoei5f0YoPtmnqfF6/W4Oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q7QJTTNj2HbwmbYARjHbmgZHCrUoOUwxPvf93Dy1GBwldCdjrmt1O1KDfB3Jib5J1
	 iCUbdUpdD89PF4cFKaZtjIHpqCHLCsyEcGdIwJQrn2x9oWnoFGal/IVRhS9oF597U9
	 KAn64T7sZxSse8iRKZId+uaxjBOgOJr005z05EknPTQCujgiG4XjNj8i4GU9Y4t8dN
	 1Zh6GsCTh0Sfe8QX3QCBYMgOpa9bKwYnY6xiCHDcQWt8S7RfdWBE98Vf/MMfa03fDA
	 c3auB169L37M+ZJrDzgzTF7TU+cONcdGikVM/u6ErVG9adDPMKTUtlmu4g+fPMeNYN
	 aXzcnR7R5PG+w==
Message-ID: <d4cb495d-6549-4b5a-bcf4-38dbbdda202e@uliege.be>
Date: Wed, 29 Jan 2025 17:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, dsahern@kernel.org
References: <20250129021346.2333089-1-kuba@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250129021346.2333089-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 03:13, Jakub Kicinski wrote:
> dst_cache_get() gives us a reference, we need to release it.
> 
> Discovered by the ioam6.sh test, kmemleak was recently fixed
> to catch per-cpu memory leaks.
> 
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: justin.iurman@uliege.be
> ---
>   net/ipv6/ioam6_iptunnel.c | 5 +++--
>   net/ipv6/rpl_iptunnel.c   | 6 ++++--
>   net/ipv6/seg6_iptunnel.c  | 6 ++++--
>   3 files changed, 11 insertions(+), 6 deletions(-)

I think both ila_output() and tipc_udp_xmit() should also be patched 
accordingly. Other users seem fine.

> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 28e5a89dc255..3936c137a572 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -336,7 +336,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>   
>   static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
> -	struct dst_entry *dst = skb_dst(skb), *cache_dst;
> +	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
>   	struct in6_addr orig_daddr;
>   	struct ioam6_lwt *ilwt;
>   	int err = -EINVAL;
> @@ -407,7 +407,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		cache_dst = ip6_route_output(net, NULL, &fl6);
>   		if (cache_dst->error) {
>   			err = cache_dst->error;
> -			dst_release(cache_dst);
>   			goto drop;
>   		}
>   
> @@ -426,8 +425,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		return dst_output(net, sk, skb);
>   	}
>   out:
> +	dst_release(cache_dst);
>   	return dst->lwtstate->orig_output(net, sk, skb);
>   drop:
> +	dst_release(cache_dst);
>   	kfree_skb(skb);
>   	return err;
>   }
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 7ba22d2f2bfe..9b7d03563115 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -232,7 +232,6 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   		dst = ip6_route_output(net, NULL, &fl6);
>   		if (dst->error) {
>   			err = dst->error;
> -			dst_release(dst);
>   			goto drop;
>   		}
>   
> @@ -251,6 +250,7 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   	return dst_output(net, sk, skb);
>   
>   drop:
> +	dst_release(dst);
>   	kfree_skb(skb);
>   	return err;
>   }
> @@ -269,8 +269,10 @@ static int rpl_input(struct sk_buff *skb)
>   	local_bh_enable();
>   
>   	err = rpl_do_srh(skb, rlwt, dst);
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> +		dst_release(dst);
>   		goto drop;
> +	}
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 4bf937bfc263..eacc4e91b48e 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -482,8 +482,10 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   	local_bh_enable();
>   
>   	err = seg6_do_srh(skb, dst);
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> +		dst_release(dst);
>   		goto drop;
> +	}
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> @@ -571,7 +573,6 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>   		dst = ip6_route_output(net, NULL, &fl6);
>   		if (dst->error) {
>   			err = dst->error;
> -			dst_release(dst);
>   			goto drop;
>   		}
>   
> @@ -593,6 +594,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>   
>   	return dst_output(net, sk, skb);
>   drop:
> +	dst_release(dst);
>   	kfree_skb(skb);
>   	return err;
>   }

