Return-Path: <netdev+bounces-155553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B78A02F55
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B8D3A4481
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272481DEFE9;
	Mon,  6 Jan 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWP0FYl3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B81DE4EB
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185999; cv=none; b=JKyOq5/XKG8Ucmr45BpLjrZ7JAyFA0VY1kidRAE3Zz0P+mW6ENr6dlPrmb9LvQxhmU+UpNWgGSGrIDNJIVnAXHMSlmVE6I+paFIOMALFKPFjfXX/v3wg1ulk90l3pR/nhe3Vt5TuBDx5vnK4sV1swzABYwIpP2Md/0w6arE/z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185999; c=relaxed/simple;
	bh=jXfIxVo+zZE75Tam5ruwm8K5DEbslhEZwbl5onCG8R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/FixNlWjFB1G3M//js3HHteJ5tbPBChPOQkD0HfnT/kMGMa+jXw1JT45KGYqHRstNTBtZ0xrcjkxXFVfcO8RJXyIMPVRJfZjtxlZOLKbFWunuyPzrngChRrnN/EkBX7dLOmITRniTpxUk8+0axWpyzw93+HKGS7fQo47ORZqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWP0FYl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE845C4CEDF;
	Mon,  6 Jan 2025 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736185998;
	bh=jXfIxVo+zZE75Tam5ruwm8K5DEbslhEZwbl5onCG8R0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SWP0FYl3DEDB765SUieVN1h2ZHFaWg76MrAf5EA/O0zmgwddpZeh4/ulsAgpc0+cc
	 26aFvH6lUk2a/guy0hxBDQ6uJODiyRcY1GE8YlTBbxuE32bMyVEYcqqQTo02fqKEQN
	 iJnm0sBSO2/Cvt7NMvFDjNoOEJoCvSjOEV79n9Q3LLNsA/dx31V7ly0d/Akr9wW6Zq
	 sXZDwKlNMxA9S7/UdFw26GvlhPrjyqqc26unHZfRHAFGAiD9uKMetiJEnwGG9L4lLk
	 d+OjCdfXLAHrXj8nEaY5omfokxL+Eq4eN5/O7WDcFkF3dLxwhAG0lKTdHixRGGTFo2
	 +E1/lYrP9fFOQ==
Message-ID: <cf625a44-0db1-421d-acf9-e7ec60677697@kernel.org>
Date: Mon, 6 Jan 2025 10:53:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next] netlink: add IPv6 anycast join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250105020016.699698-1-yuyanghuang@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250105020016.699698-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 7:00 PM, Yuyang Huang wrote:
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index 562cace50ca9..6793ff436986 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -278,6 +278,40 @@ static struct ifacaddr6 *aca_alloc(struct fib6_info *f6i,
>  	return aca;
>  }
>  
> +static void inet6_ifacaddr_notify(struct net_device *dev,
> +				  const struct ifacaddr6 *ifaca, int event)
> +{
> +	struct inet6_fill_args fillargs = {
> +		.portid = 0,
> +		.seq = 0,
> +		.event = event,
> +		.flags = 0,

0 initializations are not needed.

> +		.netnsid = -1,
> +	};
> +	struct net *net = dev_net(dev);
> +	struct sk_buff *skb;
> +	int err = -ENOMEM;
> +
> +	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> +			nla_total_size(sizeof(struct in6_addr)) +
> +			nla_total_size(sizeof(struct ifa_cacheinfo)),
> +			GFP_KERNEL);
> +	if (!skb)
> +		goto error;
> +
> +	err = inet6_fill_ifacaddr(skb, ifaca, &fillargs);
> +	if (err < 0) {
> +		WARN_ON_ONCE(err == -EMSGSIZE);

simple error message should suffice; stack trace does not provide
additional value.

> +		nlmsg_free(skb);
> +		goto error;
> +	}
> +
> +	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ACADDR, NULL, GFP_KERNEL);
> +	return;
> +error:
> +	rtnl_set_sk_err(net, RTNLGRP_IPV6_ACADDR, err);
> +}
> +
>  /*
>   *	device anycast group inc (add if not found)
>   */


