Return-Path: <netdev+bounces-161531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF84A2219E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B7216819D
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729311DF268;
	Wed, 29 Jan 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="T6Ct2xtt"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4481DF250
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167595; cv=none; b=XvzkHBKDryBo6hwCnHMBnKQZCETrn58pf3sMU1f4WEsG8ygV1yzQnvgO93vrdXSFoYsIy7khs9jzs5gI4V1M3ktxY3vl8lgsCbXKPJDIiUGiZTwz55ZWD4uw5kVt1SZH0R7rOwd6+mhmdyAkP+y8g1SX5MTCwXXUhdkzrsPyY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167595; c=relaxed/simple;
	bh=GTeykiNC/qdml3wD1IEZx2fYlZKOq0tA1ceG3wD+sGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPOe9zCOuqTWj7HXOxo347WD/xdu5X00YD8oPTcutsG7CSBToseJ0zTdVl7Wxd9Sv7RBQCo7V4BQMrTRfjtnn5S8UVcBFaOVNbWDmqDPURwdTOB7f59+hUbYNpV9m1zEywGTsHBbjG5bvAylORXaJFpYMZt+RVMeQ/TSl54XwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=T6Ct2xtt; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4A4AF2031871;
	Wed, 29 Jan 2025 17:10:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4A4AF2031871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738167026;
	bh=Tqvwtyv4wPaaG4TiejGs361FlC9tdbZtZSaEWbolcAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T6Ct2xttR09F/tqWwoP+emtTJ+x/YRxtWsXiQW/UQSna89iuIuDSfGcpqLf8xjg5y
	 5AIWymQR6MJb8XRsYeytXbeYYlIIHNIJjN/hIkFjD8XAXgZGPIOxLiy6tl3WiBL/4Y
	 vHXe2kerEuYik4Fq3+8Rin+o9F2mmJEpjvB9tpVgbsIrWezFuvwRcZ2Er6PqJHHmoN
	 mNDAB6ez6/8jS448xVLUzgM23wwFDlKqVGlEDg4Tp2VEc05m+cUQAS0b14kXpBQiBg
	 05M6tLs13BDu0ZjQ8b8aGhjAa+gmZJmx//tKf4UId/t91l9tkY3DhFH+YXwWxQj4Gi
	 YTCDaULx7Wp8A==
Message-ID: <738be35e-c891-48a2-9267-ca2dfd8fa650@uliege.be>
Date: Wed, 29 Jan 2025 17:10:25 +0100
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
> 
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

Reviewed-by: Justin Iurman <justin.iurman@uliege.be>

Thanks Jakub!

