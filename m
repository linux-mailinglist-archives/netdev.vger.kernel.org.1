Return-Path: <netdev+bounces-76258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861C86D055
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D231C21337
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641338DEA;
	Thu, 29 Feb 2024 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="MjeBua36"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293F16065F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227069; cv=pass; b=aAxI9B7RnxM15y8aYhVPo6h4XGYZV2ojDmp8xCgb7kz5Y0WdTlD1CIxaaGaNK3/opAqTfj2Vuk89yQ4cHhLPd5EXSoTrxam93nrdNo/bFdZn7zX8wzqhQ211FqliALmmvMd5rHFZQhhqtuQQcqjfusvYdz1hcSlQ7NFSs5IhfAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227069; c=relaxed/simple;
	bh=R73Bicu6ZGZRz7n5be53eNdvjKnlo9Pe593ZSEck91A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDKUzBGTFSTt9Wy6nOoSVjVFPkB+pLKrgdpvrnraNfz/at+iOY24ZWxyCjzJIx3CT3DuVGW6Ur0qIYom2CV3QN8kiU7Q82Bc4vX6kphdEFZq3NLQRLmjyHUZOQSj3JzzTRAo8rkRsDUmwsXlSfRPJIkxLKO7kykh/f8QuwIvx0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=MjeBua36; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1709227059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SqJe0wsDuQQ10fNhp261q7yBKWtHIREsfvIEJNONBG14OmKXi1zdXmaKiuLiMmQ352ZsJdBaReHEGTRbTGv49ys8s7/8K7Gd8k3IenEhJA07QCBP2SjyOpBKNH2kuCiVBczZnyVHJFXqQNZ2G7A0J9ZZx02HSjmFjV+rSzgkl8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709227059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WF8tQXFqSlQrzvNq741VODGgDIItA8olLGsrXfyaflw=; 
	b=RTnf1zmYIf/pHeiPUCFasVXBe8ddsMgkYZco/r5QVesxhYtOY2UjXDahCUgdagygshUYaKsPFRFH61URsDN74jKlmmXXLMmnRm4aBcbuTh0+oS7mhf6q1bYJlGMlLaVrJuEEpR4X71xiYV4y3Sp0adIIqEddl4svKVGTcBhOI3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709227059;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WF8tQXFqSlQrzvNq741VODGgDIItA8olLGsrXfyaflw=;
	b=MjeBua36bcc2Gy4RCUaBKIoSvunIEmILyc+0a1H7IkGSoYFbHzNlWilq+ZdEzKA4
	dnn7Q+RZ6HzK0xpG2pl9MKdriVFYWsWQyaalzP1RLNiujc+/18vozcgKpb+mJguILQg
	NUUf0I6/jxP3hsw3uBO69clZYP6OiSMYnMyPSleNA7LNSwhNUUNBqrhrbaC/Bgb3NR5
	nM4KTrq5S8PY1SIry7cucZKEKcyMUG1pO+/qWDnTIo564nSu601rkc7ghe1Py2ECoFB
	a5pXM/TCcq9Rf1bUj+DEnpVBlEvlnnvnjtTbUi++WBI9VPwR/iFkvlqTjkUDn3KQJVJ
	Oq/zZJPcsA==
Received: from [192.168.5.82] (public-gprs530213.centertel.pl [31.61.190.102]) by mx.zohomail.com
	with SMTPS id 1709227058592212.13037473679367; Thu, 29 Feb 2024 09:17:38 -0800 (PST)
Message-ID: <9d306e6a-a636-4948-80fa-ec4d7f6b5582@machnikowski.net>
Date: Thu, 29 Feb 2024 18:17:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/5] netdevsim: forward skbs from one connected port
 to another
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 horms@kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240228232253.2875900-1-dw@davidwei.uk>
 <20240228232253.2875900-3-dw@davidwei.uk>
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240228232253.2875900-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 29/02/2024 00:22, David Wei wrote:
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
>  drivers/net/netdevsim/netdev.c    | 27 ++++++++++++++++++++++-----
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 9063f4f2971b..c3f3fda5fdc0 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -29,18 +29,35 @@
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> +	unsigned int len = skb->len;
> +	struct netdevsim *peer_ns;
>  
> +	rcu_read_lock();
>  	if (!nsim_ipsec_tx(ns, skb))
> -		goto out;
> +		goto out_drop_free;
>  
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns)
> +		goto out_drop_free;
> +
> +	skb_tx_timestamp(skb);
> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
> +		goto out_drop_cnt;
> +
> +	rcu_read_unlock();
>  	u64_stats_update_begin(&ns->syncp);
>  	ns->tx_packets++;
> -	ns->tx_bytes += skb->len;
> +	ns->tx_bytes += len;
>  	u64_stats_update_end(&ns->syncp);
> +	return NETDEV_TX_OK;
>  
> -out:
> +out_drop_free:
>  	dev_kfree_skb(skb);
> -
> +out_drop_cnt:
> +	rcu_read_unlock();
> +	u64_stats_update_begin(&ns->syncp);
> +	ns->tx_dropped++;
> +	u64_stats_update_end(&ns->syncp);
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -70,6 +87,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  		start = u64_stats_fetch_begin(&ns->syncp);
>  		stats->tx_bytes = ns->tx_bytes;
>  		stats->tx_packets = ns->tx_packets;
> +		stats->tx_dropped = ns->tx_dropped;
>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>  }
>  
> @@ -302,7 +320,6 @@ static void nsim_setup(struct net_device *dev)
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

