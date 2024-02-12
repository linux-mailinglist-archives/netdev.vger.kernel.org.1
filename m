Return-Path: <netdev+bounces-71039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA316851C82
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6B6B22553
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7F3FB0A;
	Mon, 12 Feb 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Z7nVv785"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4F3F9FC
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761435; cv=pass; b=iTl9UACrJIaTvHOFEAok4/n1GXI1sr0P7/N5JZdSoU6I1zYcRXf1eumbbMrV7/xzQUDAWy/o9CoxgCfD0cKbANz468lkzX8sqkFEdN3nhopFWFanoUnPqa+xdGJVCIj0OvGCR38WrwSzc9Sfkir+btItf83Vloljb31/EuduXbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761435; c=relaxed/simple;
	bh=eoSyGqY4Pc06EVbqy7l2SwO2kFjHxJQWevn/2ELreuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKlfdKil1MaIefDTSED6xrXxo0aiswLTPKwmuZMSBQMcSA9vsPXOvRc3iqJb9b/TYvgWQlGYztH/thlDWYKbLs/3ejG2fV9HWFK5Xgdab6oKH/x2OX7hARGpcCT30XOSqzXt2nSnLmP4lPWflUBu7hVvYv+t7kQznvbm4Iehz4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Z7nVv785; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1707761423; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EFol9vFBQpYnZUMKqNthurSdVJnh/90S7S/wc18YaK9t73X9mLLwWjTjXiYZoxztp9FoCIZHBzh5UsWI9U83Fd3nUGJaYNle2U4qyiseeaEHJz4JXG2wfyujd3R2rJ5NRZE5qPJz+Gs4z57qFt+ZzZgQHsXB6R15xxgafvRIle8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707761423; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m58EKD1Do3uog5Yl+J6atwpYT+yTzJWlppNw+dIzYlc=; 
	b=SM2fEP5iviKhRqEHcfeamwNa+rFzuBLVJHK30xffROJWkS5YCpgV1rzBoDHP6Fi8B0TrGNfJMSakRUJCXHt03zQBp6dzkOsnV023CRJ/IxgGlCUnh8d/y/oQIHvPxN814MVEkoaWZDfnrtWpmb7IaJ05d3zObpbW6AHu3KCJH8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707761423;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m58EKD1Do3uog5Yl+J6atwpYT+yTzJWlppNw+dIzYlc=;
	b=Z7nVv785Drns5bfUpHAEf6AouCzwPwMcJ8LZ092EVRHfPCA5OdmaeugD61a0MDir
	smzMHWrHe2+Q6CILz1/l8CDMDLxx0nUguR9emZkqgWRh2qvpyd8TYVvA7Z12ny8hxHH
	8qJZlRCX68b5vGRS5YxfbV1q2658QCpRws5nQlmTr+p4zNsW8fY5FmJOO5Zhjcnhsh5
	u8UEiFJOzmVunWKI/ytLkk+ByVLvYC35OKGctrE0N41AYRocOHC9mRT2Bqu5he3R/PD
	dI66Pr9KtkqUSCEjLZMIJZ9plTWAn5OQ3jzN5KZSJTCg9Vuo7aJhNyZSGrL42OtyIIe
	tpKrAvi5Xw==
Received: from [192.168.1.225] (83.8.1.13.ipv4.supernova.orange.pl [83.8.1.13]) by mx.zohomail.com
	with SMTPS id 1707761420026395.2743753411678; Mon, 12 Feb 2024 10:10:20 -0800 (PST)
Message-ID: <49aece93-d9a8-4cd8-be79-2160f375e5af@machnikowski.net>
Date: Mon, 12 Feb 2024 19:10:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] netdevsim: forward skbs from one
 connected port to another
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-3-dw@davidwei.uk>
 <420b3c0a-6321-494b-9181-ff7dd4e1849c@machnikowski.net>
 <5d23bdfe-df0f-4048-b2d1-c0e025fd3efd@davidwei.uk>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <5d23bdfe-df0f-4048-b2d1-c0e025fd3efd@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 12/02/2024 18:32, David Wei wrote:
> On 2024-02-10 13:43, Maciek Machnikowski wrote:
>>
>>
>> On 10/02/2024 01:32, David Wei wrote:
>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>> port using dev_forward_skb, in a spirit similar to veth.
>>>
>>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>>> skbs that could not be forwarded using dev_forward_skb().
>>>
>>> The xmit() function accessing the peer ptr is protected by an RCU read
>>> critical section. The rcu_read_lock() is functionally redundant as since
>>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>>> useful for human readers.
>>>
>>> If another CPU is concurrently in nsim_destroy(), then it will first set
>>> the peer ptr to NULL. This does not affect any existing readers that
>>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>>> a synchronize_rcu() before the netdev is actually unregistered and
>>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>>> peer will complete before the netdev is freed.
>>>
>>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>>> will dereference NULL, making it safe.
>>>
>>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
>>> concurrent calls to linking two netdevsims together.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>>  drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
>>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>>  2 files changed, 24 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index 9063f4f2971b..13d3e1536451 100644
>>> --- a/drivers/net/netdevsim/netdev.c
>>> +++ b/drivers/net/netdevsim/netdev.c
>>> @@ -29,19 +29,37 @@
>>>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  {
>>>  	struct netdevsim *ns = netdev_priv(dev);
>>> +	unsigned int len = skb->len;
>>> +	struct netdevsim *peer_ns;
>>> +	int ret = NETDEV_TX_OK;
>>>  
>>>  	if (!nsim_ipsec_tx(ns, skb))
>>>  		goto out;
>>>  
>>> +	rcu_read_lock();
>>> +	peer_ns = rcu_dereference(ns->peer);
>>> +	if (!peer_ns)
>>> +		goto out_stats;
>> Change ret to NET_XMIT_DROP to correctly count packets as dropped
> 
> Linking and forwarding between two netdevsims is optional, so I don't
> want to always return NET_XMIT_DROP.
> OK - now I see that previously we calculated all packets as TX_OK and
transmitted, so this is OK.

>>
>>> +
>>> +	skb_tx_timestamp(skb);
>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>> +		ret = NET_XMIT_DROP;
>>> +
>>> +out_stats:
>>> +	rcu_read_unlock();
>>>  	u64_stats_update_begin(&ns->syncp);
>>> -	ns->tx_packets++;
>>> -	ns->tx_bytes += skb->len;
>>> +	if (ret == NET_XMIT_DROP) {
>>> +		ns->tx_dropped++;
>> add dev_kfree_skb(skb);
> 
> dev_forward_skb() frees the skb if dropped already.
But the dev_forward_skb() won't be called if there is no peer_ns. In
this case we still need to call dev_kfree_skb().

> 
>>
>> Thanks,
>> Maciek
>>
>>> +	} else {
>>> +		ns->tx_packets++;
>>> +		ns->tx_bytes += len;
>>> +	}
>>>  	u64_stats_update_end(&ns->syncp);
>>> +	return ret;
>>>  
>>>  out:
>>>  	dev_kfree_skb(skb);
>>> -
>>> -	return NETDEV_TX_OK;
>>> +	return ret;
>>>  }
>>>  
>>>  static void nsim_set_rx_mode(struct net_device *dev)
>>> @@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>>  		start = u64_stats_fetch_begin(&ns->syncp);
>>>  		stats->tx_bytes = ns->tx_bytes;
>>>  		stats->tx_packets = ns->tx_packets;
>>> +		stats->tx_dropped = ns->tx_dropped;
>>>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>>>  }
>>>  
>>> @@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
>>>  	eth_hw_addr_random(dev);
>>>  
>>>  	dev->tx_queue_len = 0;
>>> -	dev->flags |= IFF_NOARP;
>>>  	dev->flags &= ~IFF_MULTICAST;
>>>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>>  			   IFF_NO_QUEUE;
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index c8b45b0d955e..553c4b9b4f63 100644
>>> --- a/drivers/net/netdevsim/netdevsim.h
>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>> @@ -98,6 +98,7 @@ struct netdevsim {
>>>  
>>>  	u64 tx_packets;
>>>  	u64 tx_bytes;
>>> +	u64 tx_dropped;
>>>  	struct u64_stats_sync syncp;
>>>  
>>>  	struct nsim_bus_dev *nsim_bus_dev;

