Return-Path: <netdev+bounces-76260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FB86D061
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF91C213C1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAE6CBED;
	Thu, 29 Feb 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="jF0hLxGs"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9374692EA
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227203; cv=pass; b=ILuvNiOj2NN0tOfkHbm2CQI5/5xpgvaXf2Av8G+6K7aWkB/gmNk8zxXFi7FJXUaymEbJSUD4ToQfFT7SqCxBLa64AXCnIyImpvqVx6TLhij0hlg8rwIWBhE40p0ioybraD02ybc24JI6ubxuBdgECg3aCa0Er6uYTym21LmRBsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227203; c=relaxed/simple;
	bh=i5M53o/DdubhEIp1KeAQVUojT1EvfltUmnhagh9DB9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5hhkkIepNwttGoi8aMwXxE8pdB6hl8qwm2VDRP6WvyScV5cIM1R8516DaIRQ96mMHNIHsEAJJlfgROdy//JDr3WOLCbbZhxOggJWvXvvC5pmQnLV8l3y2C8Zl4iktv8KLw/tUG4/XgS1lRbaY7l7r5KbFFys3B2rWmtM2KWX40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=jF0hLxGs; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1709227194; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FdOpOA+6OJqqYCWysAsXR+pLcShbzPj/xfrBDQhfsBEEX/JG1jvGzttebeKvbUdNjgOOiqqgExE62tNun+maTmuTXhHswd5XueLQVkiMc2ykYZ63ghny4GGwoHvfmIY7gOrQTBCzggb3HET55TSnIOk+fiBMYD47rE1gFDkJbqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709227194; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=si+g2wDLJnmkKt5gRzfeD9+jGPyMX0UBLZAlTRZG1P4=; 
	b=U3hZ58lNMkMW12DS4OjYT9qvgBac0Jerhkw/SnqnJ0+PuQxDZpAqBq15j3ygqYuzdAUHGP/1YFLHL1Zmv5FO/LTfs1ANLwr+slaTzuux1EnNLS82mLbT9+lUlUtToD/LvrsSgNUQQcu/zHV7PApv1hldxTYUuRoEtLpGrNAo/8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709227194;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=si+g2wDLJnmkKt5gRzfeD9+jGPyMX0UBLZAlTRZG1P4=;
	b=jF0hLxGsD4IWBAXr8kyXJ8ypf8UPW11pzZLj6m4fDqtJArynWsHQUdYgq5ME7Om/
	ovpQGAkBrGB5uc3eqXtGSECe6k2uwFL3Go8aO0FwfirqBkeAJxRrOhWQc9Xf4mG3ZQx
	ooL75ugMbG5H2cKf87+fI0LJh4yjQz/h3DU3RpWxj3yfFOEtYrWGnMyh4kbr+I5G9oa
	gbGx9vJYLYxugFSveCTsuyyqAxFhnuX+FSmeEGIysYogC3D4eYrk3bEqa/QrieJyuZJ
	R4X095cjbiTpRvvHQZsT0FD5SCAsv390A6sieqWTu5vvqC40LZu484XUx8xrJ5S6sa6
	XUeT4lUpUQ==
Received: from [192.168.5.82] (public-gprs530213.centertel.pl [31.61.190.102]) by mx.zohomail.com
	with SMTPS id 170922719318466.1301531522455; Thu, 29 Feb 2024 09:19:53 -0800 (PST)
Message-ID: <82a26c8f-d2d0-4479-b3b0-ec853517e2f9@machnikowski.net>
Date: Thu, 29 Feb 2024 18:19:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/5] netdevsim: add ndo_get_iflink() implementation
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 horms@kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240228232253.2875900-1-dw@davidwei.uk>
 <20240228232253.2875900-4-dw@davidwei.uk>
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240228232253.2875900-4-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 29/02/2024 00:22, David Wei wrote:
> Add an implementation for ndo_get_iflink() in netdevsim that shows the
> ifindex of the linked peer, if any.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/netdev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index c3f3fda5fdc0..8330bc0bcb7e 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -283,6 +283,21 @@ nsim_set_features(struct net_device *dev, netdev_features_t features)
>  	return 0;
>  }
>  
> +static int nsim_get_iflink(const struct net_device *dev)
> +{
> +	struct netdevsim *nsim, *peer;
> +	int iflink;
> +
> +	nsim = netdev_priv(dev);
> +
> +	rcu_read_lock();
> +	peer = rcu_dereference(nsim->peer);
> +	iflink = peer ? READ_ONCE(peer->netdev->ifindex) : 0;
> +	rcu_read_unlock();
> +
> +	return iflink;
> +}
> +
>  static const struct net_device_ops nsim_netdev_ops = {
>  	.ndo_start_xmit		= nsim_start_xmit,
>  	.ndo_set_rx_mode	= nsim_set_rx_mode,
> @@ -300,6 +315,7 @@ static const struct net_device_ops nsim_netdev_ops = {
>  	.ndo_set_vf_rss_query_en = nsim_set_vf_rss_query_en,
>  	.ndo_setup_tc		= nsim_setup_tc,
>  	.ndo_set_features	= nsim_set_features,
> +	.ndo_get_iflink		= nsim_get_iflink,
>  	.ndo_bpf		= nsim_bpf,
>  };
>  
Reviewed-by: Maciek Machnikowski <maciek@machnikowski.net>

