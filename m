Return-Path: <netdev+bounces-165688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E652A330EE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345BC3A8907
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A512201017;
	Wed, 12 Feb 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="NEsZKwt0"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959981FBC81
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392967; cv=none; b=apO65FlsM3SuFz8TZESPif/v2RU6tXdF47NE6QQqDKBUhVti6sSiOKhdgWIOaeeyNYRM/ycsqvFx73bYpU2A3bwhWe4MBhNLA81sur8zdD5fGpPtjSwfsLktW1DUcIXYmfI6vYsjAehnEkU/8AOekqs5vtW8hd3nsVhRwVaTDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392967; c=relaxed/simple;
	bh=dL1lFvtlIKOPMddeilTJpyswrOtazG35QLX/MYSc/r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o95LL7hq1YQLusYhUdFcMniiTnoODgJ4giKuhCNhV1yRW/YgGzVBh/Ksxu+NuDQxNrKu5KcMJIxgZ8ZuJqEYu+/+lu6gz7MRhAlykf9WtgCwvjOFkadtjJHmR3ueMOPTTW5jljLr/luUi8qAiDoNq+TbmxNov0MqRscL8VxoMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=NEsZKwt0; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.128.60] (unknown [213.230.40.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 08D44200DBB5;
	Wed, 12 Feb 2025 21:42:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 08D44200DBB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739392962;
	bh=96wdAhtfD8vyKQwIB/YHqzHyj4UujTJrwhw7YJhpPvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NEsZKwt0+PqaF9DJqZaV+i7bzWXZD5xkc2pLknwWC9/pwLFVwMi4ppkbKpSZ7k3F5
	 2UuMskQPVtvmc037J2cKimlDaOO3qsN0AjwH/wLOfFpEwJqn9B0qLueyPYitcDtuMA
	 SdZLedkSfK4jVRiRf7Vb12fiVQefWP0Faa01oVRT54ngs+7mZnsukkWtzzddo+Q1LL
	 HjirouT8oKVKWJTDMM2YUOkJWWY72Xg1NQj2AKng3JFkhi1Q2hd4dKxEaPLV0h/NN3
	 rLV5qvvoLyNWREsNgnE3F1umBxZifXRxQXuICw5ZMJIFzizcMpFUsqtzACNQZ0Mv44
	 +1ZJq4bggJ9cg==
Message-ID: <2fd5f5d7-a338-41b7-bff5-faae92553a2b@uliege.be>
Date: Wed, 12 Feb 2025 21:42:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl
 and seg6
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Alexander Aring <alex.aring@gmail.com>, David Lebrun <dlebrun@google.com>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250211221624.18435-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 23:16, Justin Iurman wrote:
> When the destination is the same post-transformation, we enter a
> lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
> seg6_iptunnel, in both input() and output() handlers respectively, where
> either dst_input() or dst_output() is called at the end. It happens for
> instance with the ioam6 inline mode, but can also happen for any of them
> as long as the post-transformation destination still matches the fib
> entry. Note that ioam6_iptunnel was already comparing the old and new
> destination address to prevent the loop, but it is not enough (e.g.,
> other addresses can still match the same subnet).
> 
> Here is an example for rpl_input():
> 
> dump_stack_lvl+0x60/0x80
> rpl_input+0x9d/0x320
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> [...]
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> lwtunnel_input+0x64/0xa0
> ip6_sublist_rcv_finish+0x85/0x90
> ip6_sublist_rcv+0x236/0x2f0
> 
> ... until rpl_do_srh() fails, which means skb_cow_head() failed.
> 
> This patch prevents that kind of loop by redirecting to the origin
> input() or output() when the destination is the same
> post-transformation.
> 
> Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: David Lebrun <dlebrun@google.com>
> ---
>   net/ipv6/ioam6_iptunnel.c |  6 ++----
>   net/ipv6/rpl_iptunnel.c   | 10 ++++++++++
>   net/ipv6/seg6_iptunnel.c  | 33 +++++++++++++++++++++++++++------
>   3 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 2c383c12a431..6c61b306f2e9 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -337,7 +337,6 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>   static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
> -	struct in6_addr orig_daddr;
>   	struct ioam6_lwt *ilwt;
>   	int err = -EINVAL;
>   	u32 pkt_cnt;
> @@ -352,8 +351,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   	if (pkt_cnt % ilwt->freq.n >= ilwt->freq.k)
>   		goto out;
>   
> -	orig_daddr = ipv6_hdr(skb)->daddr;
> -
>   	local_bh_disable();
>   	cache_dst = dst_cache_get(&ilwt->cache);
>   	local_bh_enable();
> @@ -422,7 +419,8 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   			goto drop;
>   	}
>   
> -	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
> +	/* avoid a lwtunnel_input() loop when dst_entry is the same */

sigh... Should be lwtunnel_output() in the comment, let me know if I 
need to re-spin.

