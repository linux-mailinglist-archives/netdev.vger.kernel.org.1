Return-Path: <netdev+bounces-164249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD615A2D20A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07C2188F20F
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7414900F;
	Sat,  8 Feb 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMyPPTdY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83114830A;
	Sat,  8 Feb 2025 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974440; cv=none; b=rwNtDn7kFro21Rzh85ymoijR5ig5n1tSNRbC7u6WgRleV1WbPjlS2m9zgFEQzZjq++I5wtCpN1J/ucsmqXNR5XHJ2As8B2iFYys4wJd2J/vHHUaAObvwKeWLkoKHIXecXRX6gAw+Encc219/ABFT4YdBYzvZaatMpbuVNt0lw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974440; c=relaxed/simple;
	bh=umE6t0joR8G2vFmBUYWVjILv26oDiwZvq+HbzaQDyfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ethqa9HTT4lIxV7npFcGa5tnBKUzB7nAvdPzm8WkaLrWA/ndzrFbOhwtsa8EXI/xHmGZu9iWLH0N5dx+OqYZVewmTMqrgJHs3AWiRz0g+03Cuxngpm22G31ftPkui2tBsarnZaRzWBdkSkHL271PKgODauz6ytyvcDHnV7DZEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMyPPTdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCDBC4CED1;
	Sat,  8 Feb 2025 00:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738974439;
	bh=umE6t0joR8G2vFmBUYWVjILv26oDiwZvq+HbzaQDyfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IMyPPTdYpqHmRZmeFFzM1Ii1zTiU1+16yBmvVkVLn8slx4VvSvQNnyd2Zzi/OvY1w
	 UtKmXyH4BStcv2x8I63DNZuuZAyqxNZHDROrbD2MJRd7WZHXh0kQ5scaTgh/3K18uD
	 bxMGtsfC94j9mPDhhvI+vXmDw8YourWQiQ+WZvfrOFjz4KFULJ9vK4JAkBv5fPzwAF
	 52uyD0Z7F5LKzgFkGNJHN8+ehvecKIakWoSs0O2GTRElHY3TkWJknMREiCaNJv9a58
	 mDz53NDRsCa423mzls8pkd0limpxlh9l/OGfYnzHMB5UVii9gw2CWsGNaLu145CYZB
	 3oUjBaZQje/rA==
Date: Fri, 7 Feb 2025 16:27:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, kuniyu@amazon.com, ushankar@purestorage.com
Subject: Re: [PATCH RFC net-next] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250207162718.4f26219e@kernel.org>
In-Reply-To: <20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org>
References: <20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Feb 2025 04:11:34 -0800 Breno Leitao wrote:
> +static bool dev_comp_addr(struct net_device *dev,
> +			  unsigned short type,
> +			  const char *ha)

Weird indentation.

static bool 
dev_comp_addr(struct net_device *dev,  unsigned short type, const char *ha)

or

static bool dev_comp_addr(struct net_device *dev, unsigned short type,
			  const char *ha)

> +{
> +	if (dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len))
> +		return true;
> +
> +	return false;

	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);

> +}

> +/**
> + *	dev_getbyhwaddr_rtnl - find a device by its hardware address

I guess Eric suggested the _rtnl() suffix, tho it's quite uncommon.
Most function are either function() or function_rcu() in networking.

> + *	@net: the applicable net namespace
> + *	@type: media type of device
> + *	@ha: hardware address
> + *
> + *	Similar to dev_getbyhwaddr_rcu(), but, the owner needs to hold

unnecessary , after but

> + *	RTNL.

rtnl_lock. RTNL is short for RTNetLink

> + *

document the return value kdoc style:

	Return: pointer to the net_device, or NULL if not found

> + */
> +struct net_device *dev_getbyhwaddr_rtnl(struct net *net, unsigned short type,
> +					const char *ha)

You missed adding this to a header file?

