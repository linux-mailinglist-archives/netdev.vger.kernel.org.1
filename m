Return-Path: <netdev+bounces-59829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D838681C27C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90071286308
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111EA53;
	Fri, 22 Dec 2023 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jVmhShe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EEA23
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3aa0321b5so11996815ad.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703206711; x=1703811511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A+TjkUWIwQ6TSSjVf/ogRxUA7iSKOeOZ2zirRp12rk=;
        b=jVmhShe6q0vwD2bKKxm7hJGfWESeG6XuSVhNnSHfZKUh2+8KfHRt+jDx3zxOisjCHm
         pgRg5dmxQj/4bwR77D74gy/CenxRtcTK/Ko7aBHFmlqY+gqGkBBJUkYE7K08fGtm4HHB
         b/WxJIm5dHSiKk1y44+Gnj/WZnAKJH23BAJ15G+YN18rl6ZLX9wUmiDm+IBM6HSyh5Dt
         JICBCZs8HKrnussEMfllLTpuuHQ5zn23G248XiPYNoaZggr87cJW5gd9O6yk7ahcnMMY
         fvF/NRBWD10NuazB51Zpuu9GvK0CJyaDKtx/usgeM7mE65QIHr+aRCCcKxCO5QupeT2q
         XyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206711; x=1703811511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A+TjkUWIwQ6TSSjVf/ogRxUA7iSKOeOZ2zirRp12rk=;
        b=ndWivCGD3GNFVrOlEQV3pQtc1ADiH+0of+w6zJ0zUeJPAw73U55B0Dl9ZJ9cQAASvv
         7veTaIEKdj4+C8skPhUTlJf3VYcedQG906z4snnZBTBjHGrHTXm7rNyqkn+qIHG9F4Rr
         uLGZoWmZf7UMbuq7TsO8zH9F8iGOW6N5iP4XGS59RNIfKvlLejpsnnfQo2rzVV1YDoCu
         +nqIwuzC44Dyf/9e7s7Wq2fQ9lLhYX/dnqxW85uJWANoiRuuym+rEeARD0hTEOmFi09w
         vgkP4/6wPXRf5VGFkuZ64v0XCs8Z+U+WwdzospRPovYwykL9c2Zy+hjfQ/9YWjXVTwgP
         g22A==
X-Gm-Message-State: AOJu0YzFN5PxNrFacRXBDOHft1P+ksELgS9YVF57xNn2ZGI4mTrezAqf
	f/knQrvbU8tLAdHsluQRvi7lEvPTkk2Z1g==
X-Google-Smtp-Source: AGHT+IG3i4mBFiSNX9ntkMr3bk7SVdUSm0InbqJ8XMVeGQuAORVEyzJwcfSKT6vwpI4sZ0fmk2dSwQ==
X-Received: by 2002:a17:902:ef93:b0:1d3:fa43:6a08 with SMTP id iz19-20020a170902ef9300b001d3fa436a08mr449570plb.44.1703206711135;
        Thu, 21 Dec 2023 16:58:31 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::14f8? ([2620:10d:c090:400::4:865e])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001d34126d64dsm281563plg.222.2023.12.21.16.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 16:58:30 -0800 (PST)
Message-ID: <7694087c-6867-45ec-ba72-cc0c12933903@davidwei.uk>
Date: Thu, 21 Dec 2023 16:58:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-4-dw@davidwei.uk> <ZYKuDmMh_PyouG8K@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZYKuDmMh_PyouG8K@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-20 01:04, Jiri Pirko wrote:
> Wed, Dec 20, 2023 at 02:47:45AM CET, dw@davidwei.uk wrote:
>> Forward skbs sent from one netdevsim port to its connected netdevsim
>> port using dev_forward_skb, in a spirit similar to veth.
>>
>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>> skbs that could not be forwarded using dev_forward_skb().
>>
>> The xmit() function accessing the peer ptr is protected by an RCU read
>> critical section. The rcu_read_lock() is functionally redundant as since
>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>> useful for human readers.
>>
>> If another CPU is concurrently in nsim_destroy(), then it will first set
>> the peer ptr to NULL. This does not affect any existing readers that
>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>> a synchronize_rcu() before the netdev is actually unregistered and
>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>> peer will complete before the netdev is freed.
>>
>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>> will dereference NULL, making it safe.
>>
>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
>> concurrent calls to linking two netdevsims together.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/netdev.c    | 25 ++++++++++++++++++++++---
>> drivers/net/netdevsim/netdevsim.h |  1 +
>> 2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 434322f6a565..00ab3098eb9f 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -29,6 +29,8 @@
>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> {
>> 	struct netdevsim *ns = netdev_priv(dev);
>> +	struct netdevsim *peer_ns;
>> +	int ret = NETDEV_TX_OK;
>>
>> 	if (!nsim_ipsec_tx(ns, skb))
>> 		goto out;
>> @@ -36,12 +38,29 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> 	u64_stats_update_begin(&ns->syncp);
>> 	ns->tx_packets++;
>> 	ns->tx_bytes += skb->len;
>> +
>> +	rcu_read_lock();
>> +	peer_ns = rcu_dereference(ns->peer);
>> +	if (!peer_ns)
>> +		goto out_stats;
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP)) {
>> +		ret = NET_XMIT_DROP;
>> +		ns->tx_dropped++;
> 
> Idk, does not look fine to me to be in u64_stats_update section while
> calling dev_forward_skb()

I see, it's a type of spinlock. I will fix this.

> 
> 
>> +	}
>> +
>> +	rcu_read_unlock();
>> 	u64_stats_update_end(&ns->syncp);
>>
>> +	return ret;
>> +
>> +out_stats:
>> +	rcu_read_unlock();
>> +	u64_stats_update_end(&ns->syncp);
>> out:
>> 	dev_kfree_skb(skb);
>> -
>> -	return NETDEV_TX_OK;
>> +	return ret;
>> }
>>
>> static void nsim_set_rx_mode(struct net_device *dev)
>> @@ -70,6 +89,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>> 		start = u64_stats_fetch_begin(&ns->syncp);
>> 		stats->tx_bytes = ns->tx_bytes;
>> 		stats->tx_packets = ns->tx_packets;
>> +		stats->tx_dropped = ns->tx_dropped;
>> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
>> }
>>
>> @@ -302,7 +322,6 @@ static void nsim_setup(struct net_device *dev)
>> 	eth_hw_addr_random(dev);
>>
>> 	dev->tx_queue_len = 0;
>> -	dev->flags |= IFF_NOARP;
>> 	dev->flags &= ~IFF_MULTICAST;
>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>> 			   IFF_NO_QUEUE;
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 24fc3fbda791..083b1ee7a1a2 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -98,6 +98,7 @@ struct netdevsim {
>>
>> 	u64 tx_packets;
>> 	u64 tx_bytes;
>> +	u64 tx_dropped;
>> 	struct u64_stats_sync syncp;
>>
>> 	struct nsim_bus_dev *nsim_bus_dev;
>> -- 
>> 2.39.3
>>

