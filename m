Return-Path: <netdev+bounces-156425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DABA065A3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FA816394A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D027201262;
	Wed,  8 Jan 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOHLHovD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7019ABB6
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366205; cv=none; b=ln6DagJnScrb/vP5Io91Hg46deipGp3Dm5oa7oVidA2DxzAOi3JZn6QRVsqY9nYCtf+vabA4c5zRdJoyd60mki8YRl0shujgrPoXAQW/as2vMG4PBwZ8uL3pCLJxJUz4lbpwTpF7McI5vZlFWFepCf1xnbIxDrdhsJTMwwYUSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366205; c=relaxed/simple;
	bh=DgozNOirfb1WaQn2HBdAJJ2qek2P5unGCFmo3ubv5m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5s2wtPrS/CpksVwtpFIjiec3xxcGzWX+XyDfkHcFihoGx0AwfVdOYMWNRXfatgjatPobS5mLzgkAYm+L9nFoFyF+sso4N96DJi+hfbJkINT0iY14Sey7WAgjyiGxiCkE9v20NCQFea8Pe0ZqDb4hOOJW6ZSclUN/mDVFJLj4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOHLHovD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0048AC4CED3;
	Wed,  8 Jan 2025 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736366204;
	bh=DgozNOirfb1WaQn2HBdAJJ2qek2P5unGCFmo3ubv5m4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZOHLHovDRoJm39up7H/GChB80A2pghBJ7ktJ+cQ0duKBLVdWWOBWvLpRHmJhdsofW
	 qIRN4S66TYIuzT/Tl37L07vzIrCTMcMVMph892dKXWyXhmNJFaqC7tbSDdDezGIg7c
	 H8HV/tcHzoA42jWFty0kV4aPYaQvM8KySOM8sXaFPMx1SDDuR3LATuVKVwuA38omhH
	 /NCGyE8PtCwCrwMUJ7UKUe/OaiVQDpyAqERHA/5GCwH9MK/ViEhwL10a241dy3wtJU
	 QxGOV9mx1OgzyiihqUkOGJvJ37nqrJ5duYkG7zuu0XoKqvjs8fcy4ySUSgplOEyMIh
	 WgAfWrUKI/NKQ==
Message-ID: <8ba3c7f0-4a14-46bb-82b0-ff9fbc0f71b7@kernel.org>
Date: Wed, 8 Jan 2025 12:56:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next, v3] netlink: support dumping IPv4
 multicast addresses
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
References: <20250105020239.702610-1-yuyanghuang@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250105020239.702610-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 7:02 PM, Yuyang Huang wrote:
> @@ -1850,21 +1851,46 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
>  			    struct netlink_callback *cb, int *s_ip_idx,
>  			    struct inet_fill_args *fillargs)
>  {
> +	struct ip_mc_list *im;
>  	struct in_ifaddr *ifa;
>  	int ip_idx = 0;
>  	int err;
>  
> -	in_dev_for_each_ifa_rcu(ifa, in_dev) {
> -		if (ip_idx < *s_ip_idx) {
> +	switch (fillargs->type) {
> +	case UNICAST_ADDR:
> +		fillargs->event = RTM_NEWADDR;
> +		in_dev_for_each_ifa_rcu(ifa, in_dev) {
> +			if (ip_idx < *s_ip_idx) {
> +				ip_idx++;
> +				continue;
> +			}
> +			err = inet_fill_ifaddr(skb, ifa, fillargs);
> +			if (err < 0)
> +				goto done;
> +
> +			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
>  			ip_idx++;
> -			continue;
>  		}
> -		err = inet_fill_ifaddr(skb, ifa, fillargs);
> -		if (err < 0)
> -			goto done;
> +		break;

Almost all of the logic is under the switch cases, you are not really
saving a lot here. I think it would be simpler just to have simpler
in_dev_dump_addr for each type.

> +	case MULTICAST_ADDR:
> +		for (im = rcu_dereference(in_dev->mc_list);
> +		     im;
> +		     im = rcu_dereference(im->next_rcu)) {
> +			if (ip_idx < *s_ip_idx) {
> +				ip_idx++;
> +				continue;
> +			}
> +			err = inet_fill_ifmcaddr(skb, in_dev->dev, im,
> +						 RTM_GETMULTICAST, NLM_F_MULTI);
> +			if (err < 0)
> +				goto done;
>  
> -		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
> -		ip_idx++;
> +			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
> +			ip_idx++;
> +		}
> +		break;
> +	default:
> +		break;
>  	}
>  	err = 0;
>  	ip_idx = 0;


