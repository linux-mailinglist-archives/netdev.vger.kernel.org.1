Return-Path: <netdev+bounces-156747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D8A07C11
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF6E164606
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA65219A68;
	Thu,  9 Jan 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIR6fX8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C52AD25
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436837; cv=none; b=Vc6vEkqeREqLiNkldgci5c+WUR5j8MnqSg3QPhaS09bB08dQhY7l2V+KkuP0t3nmZwjCk4PzrKVsVchxmmxNUbVV66Uprc1YI1MlT87V2+NFrcZiGHIlyoq/fuBDhDEy0fXnuiNv7VjUQ577Fr6sw1aVTBEcVU5cFH/qcvY62UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436837; c=relaxed/simple;
	bh=O7LaC3DfuTOwBrZ0drryjWpyaCBt1pK4l1QLCiAO4NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OY9GUl/YZbFInaERUAm3wyiUn/YuL0Fu7S2Y5SwXW7ywc8Q4Wf/JqvKpVf3v9JNWU9iUfmlOnt8Yh8y75SYL0qsqOHGIy/lSzu/E8awUtLULTf+TKVhn3Qo0O5kJ5m2bTn3Vaj4/A6aKdM4kqp6JjiXwOnys9nSHCjBSS8lAIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIR6fX8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5EAC4CED2;
	Thu,  9 Jan 2025 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436837;
	bh=O7LaC3DfuTOwBrZ0drryjWpyaCBt1pK4l1QLCiAO4NQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OIR6fX8QAOK6y4A/WXl0PK9mL5QqGm3vC4YEof8Uj+lj2hJotOllnkJ3yUlZD7OZZ
	 QexoQqB8L2W9O05zmcF9F6FVR+Pg/XrY6Hsx63eCZREA5LM26vipZB06AinV+2y3w7
	 oUWnhncQUMN++jbulwfiV6sd24kTFHfMpS06h4/hbs0fZELp1+KPX8gsHVb0fSkJE8
	 Zt54TY/WJK6lOcFnnmh9t4t71pmKORBFmXIbakc0gQZ7Uk2EuBZk6cC9EDSEUntzMz
	 6QLlP+FT9Vhfbk/qZtr83+npDyerMakp0QHIi3TqwQPaDD5iOEP4IVRHw8Sx79ct43
	 s/76pXeH3u3AA==
Message-ID: <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org>
Date: Thu, 9 Jan 2025 08:33:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast
 addresses
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250109072245.2928832-1-yuyanghuang@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250109072245.2928832-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 12:22 AM, Yuyang Huang wrote:
> @@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *net)
>  	return res;
>  }
>  
> -static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
> +			  enum addr_type_t type)
>  {
>  	const struct nlmsghdr *nlh = cb->nlh;
>  	struct inet_fill_args fillargs = {
>  		.portid = NETLINK_CB(cb->skb).portid,
>  		.seq = nlh->nlmsg_seq,
> -		.event = RTM_NEWADDR,
>  		.flags = NLM_F_MULTI,
>  		.netnsid = -1,
> +		.type = type,

my comment meant that this `type` should be removed and the wrappers
below just call the intended function. No need for the extra layers.

>  	};
>  	struct net *net = sock_net(skb->sk);
>  	struct net *tgt_net = net;
> @@ -1949,6 +1996,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
>  	return err;
>  }
>  
> +static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = UNICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);
> +}
> +
> +static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	enum addr_type_t type = MULTICAST_ADDR;
> +
> +	return inet_dump_addr(skb, cb, type);
> +}
> +
>  static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
>  		      u32 portid)
>  {


