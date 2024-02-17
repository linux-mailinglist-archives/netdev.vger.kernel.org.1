Return-Path: <netdev+bounces-72677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84362859230
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 20:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2281F21E7F
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9A7E57F;
	Sat, 17 Feb 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="ITyUKwzq"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1627E580
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199122; cv=pass; b=tq0OHLsU0DuKQ8YnT9S3huzoH+iC3IYwjTQiaaqXrkD9WvImsb69rX9uCEh2gWAiClH3oqmo3qrjxNKTIi6RyN098x98oP1uN3moAB24t1GrpK+MZA9TEwZAtRD96B7/x3t4mWqHLKYWkikDP33kArpaGYo+uK49EawWONEd2To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199122; c=relaxed/simple;
	bh=61m8KhCwLWKX8Uwmu6xhSXzuYlhtjP8TRGJ2+Wv9qaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idxc+Xmjy1ofMz87bzsxBjet7O/VkgozjC19cb6Vwbc7QaXSED/DCmd7xAS2aJbeQahFiTPlSiYIMOxEB6qeTmDACQsE/jkQVt3tibPpS5kUnPR/PEb4E/VZKtBI/r3ZfutCqx1oTQp7LRuHjVnQj6fkIMXzArYZX9Q2gcnJNdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=ITyUKwzq; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1708199110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JCTgYullhQnMz67k5323ra6nScZwYrByNI6z/cpjiVDeu8W04ytBDrH2eKDPQQsIYii7zU2OVLpRxYd51uxwuA1u+eV3LocDn0MJw4TqMUSDIFX2EZNVvBACGJsUPvYZ4n04NFu3f4dBK+KmBzkbfA/HpfHWex8KUf4HXj+LeRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708199110; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hUIyvB6KFwUThe9AqjpFyuQ0/NBkGM5gSp4pMenSoz0=; 
	b=mLyl+BR/YwfYiM500HUXpnbN7+ffONk4qA0XnLNHG+5q7WFfcTJ2et4DX3AgpSemhT68PsiIl/ecrsF55RPYqcEwIkDF1k462/73v3NQuXa+ZB+MyfhVoPU+wAx1s6TalXWfteimA/tcmPZ2S72oTLUBttUqWAt7qzL3PrtaIT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708199110;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hUIyvB6KFwUThe9AqjpFyuQ0/NBkGM5gSp4pMenSoz0=;
	b=ITyUKwzqfy+BAPHr0bwb+qATiGOH7x03V+30tVfgeeGrew1QhCBXrtpPX0PRnzB6
	68HOCEvsLv4pFcQWZFyZoD0mS0GmCFbQQhrGLz/mJbVpFen+cQJ044hdSCS7WDE7VHs
	Vd3DNKc3/IE2nXqRXwiJHqAjZR0uQ8+cinBnxERkORVxbo+BrN08DFztmcwlSCVjtsF
	K2pyHHskXKFDF1C0FHL/qo3yaZldY/ffAQJXuzIdH/QkTV8wbcvnbGrDb21xuSfx+hg
	ym1A0eSKQx7P2nWlryYdt5rGG+NkCsK+IHMWdTSDWLU1yKsGN3pTGkueqZSPnOrb4iP
	NV7M2ePc9Q==
Received: from [192.168.1.222] (83.8.250.194.ipv4.supernova.orange.pl [83.8.250.194]) by mx.zohomail.com
	with SMTPS id 1708199108331711.5260178628429; Sat, 17 Feb 2024 11:45:08 -0800 (PST)
Message-ID: <0d8e7078-63a1-4916-b629-f7c161d48e69@machnikowski.net>
Date: Sat, 17 Feb 2024 20:45:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/4] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240217050418.3125504-1-dw@davidwei.uk>
 <20240217050418.3125504-3-dw@davidwei.uk>
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240217050418.3125504-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 17/02/2024 06:04, David Wei wrote:
> Forward skbs sent from one netdevsim port to its connected netdevsim
> port using dev_forward_skb, in a spirit similar to veth.
> 
> Add a tx_dropped variable to struct netdevsim, tracking the number of
> skbs that could not be forwarded using dev_forward_skb().
> 
> The xmit() function accessing the peer ptr is protected by an RCU read
> critical section. The rcu_read_lock() is functionally redundant as since
> v5.0 all softirqs are implicitly RCU read critical sections; but it is
> useful for human readers.
> 
> If another CPU is concurrently in nsim_destroy(), then it will first set
> the peer ptr to NULL. This does not affect any existing readers that
> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
> a synchronize_rcu() before the netdev is actually unregistered and
> freed. This ensures that any readers i.e. xmit() that got a non-NULL
> peer will complete before the netdev is freed.
> 
> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
> will dereference NULL, making it safe.
> 
> The codepath to nsim_destroy() and nsim_create() takes both the newly
> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
> concurrent calls to linking two netdevsims together.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/netdev.c    | 30 +++++++++++++++++++++++++-----
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 9063f4f2971b..d151859fa2c0 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -29,19 +29,39 @@
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> +	unsigned int len = skb->len;
> +	struct netdevsim *peer_ns;
> +	int ret = NETDEV_TX_OK;
>  
>  	if (!nsim_ipsec_tx(ns, skb))
>  		goto out;
>  
> +	rcu_read_lock();
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns) {
> +		dev_kfree_skb(skb);
> +		goto out_stats;
> +	}
> +
> +	skb_tx_timestamp(skb);
> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
> +		ret = NET_XMIT_DROP;
> +
> +out_stats:
> +	rcu_read_unlock();
>  	u64_stats_update_begin(&ns->syncp);
> -	ns->tx_packets++;
> -	ns->tx_bytes += skb->len;
> +	if (ret == NET_XMIT_DROP) {
> +		ns->tx_dropped++;
> +	} else {
> +		ns->tx_packets++;
> +		ns->tx_bytes += len;
> +	}
>  	u64_stats_update_end(&ns->syncp);
> +	return ret;
>  
>  out:
>  	dev_kfree_skb(skb);
> -
> -	return NETDEV_TX_OK;
> +	return ret;
>  }
>  
>  static void nsim_set_rx_mode(struct net_device *dev)
> @@ -70,6 +90,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  		start = u64_stats_fetch_begin(&ns->syncp);
>  		stats->tx_bytes = ns->tx_bytes;
>  		stats->tx_packets = ns->tx_packets;
> +		stats->tx_dropped = ns->tx_dropped;
>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>  }
>  
> @@ -302,7 +323,6 @@ static void nsim_setup(struct net_device *dev)
>  	eth_hw_addr_random(dev);
>  
>  	dev->tx_queue_len = 0;
> -	dev->flags |= IFF_NOARP;
>  	dev->flags &= ~IFF_MULTICAST;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>  			   IFF_NO_QUEUE;
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index c8b45b0d955e..553c4b9b4f63 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -98,6 +98,7 @@ struct netdevsim {
>  
>  	u64 tx_packets;
>  	u64 tx_bytes;
> +	u64 tx_dropped;
>  	struct u64_stats_sync syncp;
>  
>  	struct nsim_bus_dev *nsim_bus_dev;


Reviewed-by: Maciek Machnikowski <maciek@machnikowski.net>

