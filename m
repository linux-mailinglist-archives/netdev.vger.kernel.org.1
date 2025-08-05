Return-Path: <netdev+bounces-211761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D6B1B844
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590A2180137
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE028BABE;
	Tue,  5 Aug 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kokk0EPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB920B215;
	Tue,  5 Aug 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410610; cv=none; b=Rdeyctbj5xwuxOxEryRDQl+MP8Goomtqqzk7nmO03+l9ZOOeyEmUSImCFhMCUzLGh0cHfkrMUweMfye6qVYNelBMCgWkGp+jaXaEY5tCoQxQQGGIiUqdpEucToo84kV1VgZU9QY6ny2C1ifEWTQY7qYhOT22KlQRYIB/XbN8qnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410610; c=relaxed/simple;
	bh=fI7604ALLj+RrEPDua3vTOAjo9vCdKkJLnB95hB24Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2E70TWZYd04fDORUX+YGqkryms8xq+8pogaKhGmlk0SWwucafmmF1BJlOplyIef+x9MrGz+9XiApF33b8oLt5N/lcbkYxiu4XWJDKYVmy/B7tbETQD45OHPMzp2IIt5IGM49jC0gKsWIaY0WfB7EDEHHU7dZHdABq3c/RgOg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kokk0EPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCFBC4CEF0;
	Tue,  5 Aug 2025 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410609;
	bh=fI7604ALLj+RrEPDua3vTOAjo9vCdKkJLnB95hB24Q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kokk0EPnWRUdg7Zlh4Xd+i4bKc0EkWOQ930nLIVBnoKuTJXGXD5orAPpoqqi3MdIF
	 oINe6j447yaBfNdvSzOygoZGshzMwFGqcPwtraXR0VR11XSsZeOJUGdYxuC+qBao7i
	 x8d6UiD/qH7Tmu4IBQrIa3cI11hy5jMQnLPpwXubccDURq/JGja3qdYF3pfyXv5uBA
	 O5im67JQxfyE+GEHpljZ4Y4awWTVGe1RpER6ve/igANy/7lBsGKN5Ij42ieKLh79Pf
	 1yatzwoqJnNcWyoefaoWH3JKSDHIw36rWPs7XnE6Le23bPyMgD23oNiJ4AlsCwlgEn
	 z5ZCai7Q+ofZA==
Message-ID: <0da120c0-4b67-4d0e-9a45-2b1a9170e641@kernel.org>
Date: Tue, 5 Aug 2025 10:16:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
Content-Language: en-US
To: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 2:42 PM, Maksimilijan Marosevic wrote:
> This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
> in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp().
> The author correctly recognises that rt6_qualify_for_ecmp() returns
> false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
> AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
> This means certain malformed entries don't get caught in
> ip6_route_multipath_add().
> 
> This patch reintroduces the AF_UNSPEC check while respecting changes
> of the initial patch.
> 
> Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
> Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().")
> Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>
> ---
>  net/ipv6/route.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 3299cfa12e21..d4b988bed920 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -5456,6 +5456,14 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
>  			goto cleanup;
>  		}
>  
> +		if (rt->fib6_nh->fib_nh_gw_family == AF_UNSPEC) {
> +			err = -EINVAL;
> +			NL_SET_ERR_MSG(extack,
> +				       "Device only routes can not be added for IPv6 using the multipath API.");
> +			fib6_info_release(rt);
> +			goto cleanup;
> +		}
> +
>  		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
>  
>  		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);

can you add another test to the routing selftests to cover this case?

