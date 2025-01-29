Return-Path: <netdev+bounces-161537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC3A22221
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67C2165634
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A091DF75C;
	Wed, 29 Jan 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="i54/j1K1"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47D1DF960
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169418; cv=none; b=sSTg4BE0JA3lGZ24ch33u+pBRmbsVjji1wS294ZwrNMh3GI7rjUxjMZL95RfCOPSPlne1lEtZKsqszaVRD6luIdsBDA1qFnd4IuKPssVWhIbSYqbtnkVStAzlKpSSiy1ctFzWxk7NJTuJuQCNO3aWVGo2aDuDoE2jene32POAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169418; c=relaxed/simple;
	bh=2DsBIe8pHkCYCltKuLG4w8jcvYuYNYm8nCJSW4r1gGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yhku/f4vIijIOP47gJ3gfLYueAcMY8HNw9o2GV+tIoXRlHkkx7ltY1tTwno/k9VwNzjs7yODKHduoVxjUAystJSTidVRjv8ebrSdc6AGGr+KNwtZRpvY73k5FWetX7iNUqO1iA8jvgWJArPNEOVI2uW11ssL0tgPSEGmN0pmUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=i54/j1K1; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 3A1D22012344;
	Wed, 29 Jan 2025 17:50:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 3A1D22012344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738169414;
	bh=Rn3v1QZv6u8sk+oBqa1no3+QgSmpwemxDchvb2/8LAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i54/j1K1KbqgtiLOVYsp2/H2YSymncb5UeXxpS8bxVbbSyeg67Ab9RxVdmGuj4dPe
	 3K31wxLyMzAEW0ZWlIIA3QXmZP5sAlOoMaVlt/7lb/Gv17KbfcJ72dfUvQtG4+Z3u6
	 nnR8RK+XAc+8vn7ELACoMPdLduxYD8RboXNllbIuUoW4Nwhm88TgFxti75OkgEVq+y
	 6sLLQ64jj5gLT+JiltwcXPc1ZvYMTfzGUlX9d9VHG5NzxSyxaIReOOx1p1hzje8iw8
	 EVDh/1uGaIhvh4IeyLUT0bYwtLjQ4aqV9K8mfMnpGd5SXG/3zwhIAw2OubEnXnUTdl
	 XwxtHnXIU4Xwg==
Message-ID: <4a30a0aa-2893-4f6a-a858-61e51b2430b2@uliege.be>
Date: Wed, 29 Jan 2025 17:50:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, dsahern@kernel.org
References: <20250129021346.2333089-1-kuba@kernel.org>
 <20250129021346.2333089-2-kuba@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250129021346.2333089-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 03:13, Jakub Kicinski wrote:
> Some lwtunnels have a dst cache for post-transformation dst.
> If the packet destination did not change we may end up recording
> a reference to the lwtunnel in its own cache, and the lwtunnel
> state will never be freed.
> 
> Discovered by the ioam6.sh test, kmemleak was recently fixed
> to catch per-cpu memory leaks. I'm not sure if rpl and seg6
> can actually hit this, but in principle I don't see why not.

Agree, both can theoretically hit this too.

> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: justin.iurman@uliege.be
> ---
>   net/ipv6/ioam6_iptunnel.c | 9 ++++++---
>   net/ipv6/rpl_iptunnel.c   | 9 ++++++---
>   net/ipv6/seg6_iptunnel.c  | 9 ++++++---
>   3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 3936c137a572..0279f1327ad5 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -410,9 +410,12 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   			goto drop;
>   		}
>   
> -		local_bh_disable();
> -		dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
> -		local_bh_enable();
> +		/* cache only if we don't create a dst refrence loop */

s/refrence/reference

> +		if (dst->lwtstate != cache_dst->lwtstate) {
> +			local_bh_disable();
> +			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
> +			local_bh_enable();
> +		}

I agree the above patch fixes what kmemleak reported. However, I think 
it'd bring the double-reallocation issue back when the packet 
destination did not change (i.e., cache will always be empty). I'll try 
to come up with a solution...

>   
>   		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
>   		if (unlikely(err))
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 9b7d03563115..f3febe4881a5 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -235,9 +235,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   			goto drop;
>   		}
>   
> -		local_bh_disable();
> -		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
> -		local_bh_enable();
> +		/* cache only if we don't create a dst refrence loop */

s/refrence/reference

Same comment as above.

> +		if (orig_dst->lwtstate != dst->lwtstate) {
> +			local_bh_disable();
> +			dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
> +			local_bh_enable();
> +		}
>   
>   		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
>   		if (unlikely(err))
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index eacc4e91b48e..0da989f07376 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -576,9 +576,12 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>   			goto drop;
>   		}
>   
> -		local_bh_disable();
> -		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
> -		local_bh_enable();
> +		/* cache only if we don't create a dst refrence loop */

s/refrence/reference

Same comment as above.

> +		if (orig_dst->lwtstate != dst->lwtstate) {
> +			local_bh_disable();
> +			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
> +			local_bh_enable();
> +		}
>   
>   		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
>   		if (unlikely(err))

