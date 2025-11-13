Return-Path: <netdev+bounces-238352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E0C57B06
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85173A69DF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14C2FF14F;
	Thu, 13 Nov 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="aQXRg6r/"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44B33F8D2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040190; cv=none; b=Xje55qUNGQ7c2dD0wgsWIvoh5dts6IG9La+oE84gnWsrCV+Sfzi/n7KMYWUo6Ddi+iQ2cSgnThE0NtE4BDl1EsAC4QsmTF4Tv1Fo7HtVwFxKW2/X6Ub3bferrcgs/8cckRQO1/5w19z3+CZsQvjrwJNJQUeWQvK3Z3NwpQWSeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040190; c=relaxed/simple;
	bh=+Hpc+pv2NkSbOWc0j/J62TYoWlD1PiGIuDsdtKgQXQQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L5Iu1G03xhLHJHQHzdX72pY2eroH1xPYID3pe2sEYAQcjflJSBnrP4q5ttDzkBJW9sYjNfWd5pIZAhmw2LHb4wgSV4Z6Ogmima3hB9SoZkQHwLEDMD+YfdCINJi1DE84KPxXZF6f4RDTAskXZt5Fhi438QY21XuV+e+ntovRGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=aQXRg6r/; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 91410200C96F;
	Thu, 13 Nov 2025 14:17:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 91410200C96F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763039845;
	bh=YL3VSqeMGQ5w9q/ULgB2RYHZKCq9C7ZbyvpXxiORaUU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=aQXRg6r/axuqytfnXN/X1aspSfW/FQXs5sxwc/tXfe8r89Hs4lnkuJ1BffjmdnMos
	 NMqibgZvHnBhJulufuNp2j73C5aNJa7HcIjKqS1KJo17xsICGVw7ABQoqj38QTKJN8
	 7GRLKTdbaHaGqSy/K4H4NR+wrtTebEyhDJ2eMDVYImAj9X8mGsTawYpEOIUDwCHj3V
	 c/rzJDKUgi4w255Efz5U+aBoRd4IGQ8wn81Ut+KBBQdmeec5vXRjZw2LhVw7bTnhpv
	 /aNDE2v9jkYY+xx+AZ0fyRR6uMyHe/Mk/9CRXlUsXB5DbYpAJyDAKWPvgFQtxrYNwG
	 XOpJXcfiO/fLw==
Message-ID: <553d867e-b95a-40fc-8f82-03449e3781e3@uliege.be>
Date: Thu, 13 Nov 2025 14:17:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [RFC net-next 1/3] ipv6: Check of max HBH or DestOp sysctl is
 zero and drop if it is
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
Cc: justin.iurman@uliege.be
References: <20251112001744.24479-1-tom@herbertland.com>
 <20251112001744.24479-2-tom@herbertland.com>
Content-Language: en-US
In-Reply-To: <20251112001744.24479-2-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 01:15, Tom Herbert wrote:
> In IPv6 destitaion options processing function check if

s/destitaion/destination

> net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If is zero then
> drop the packet since Destination Options processing is disabled.
> 
> Similarly, in IPv6 hop-by-hop options processing function check if
> net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If is zero then
> drop the packet since Hop-by-Hop Options processing is disabled.
> ---
>   net/ipv6/exthdrs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index a23eb8734e15..11ff3d4df129 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
>   	struct net *net = dev_net(skb->dev);
>   	int extlen;
>   
> -	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> +	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
> +	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
>   	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
> @@ -1040,7 +1041,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
>   	 * sizeof(struct ipv6hdr) by definition of
>   	 * hop-by-hop options.
>   	 */
> -	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> +	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
> +	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
>   	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
>   				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
>   fail_and_free:

IMO, this patch is necessary, whether or not this series is applied at 
some point.

Despite being an RFC:

Reviewed-by: Justin Iurman <justin.iurman@uliege.be>

