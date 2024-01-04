Return-Path: <netdev+bounces-61464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038DE823EAD
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8703C286281
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737FC208A8;
	Thu,  4 Jan 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kMLuOjME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEF208BC
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso304871e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 01:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704360717; x=1704965517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONoic3hRyrsOtSLoSfqkG9TTgr22TgwSzWM+OzngmyI=;
        b=kMLuOjMErFXJCQo56glZZHDB6GPWNkfSNCto+n+GFUvhunEIQiZqRTd+QlNMYB5l2w
         iUZbShUEmCTxMYZh1Iy50CQyLkRJTUYjLsbAZc9ItV2UuNT2mSv8tBfdm5g09/ZTBIMm
         OBXaXx9QMDgFuxojUs2KvNRuFRhAbkEL/swDdYPkkGM7ZOjpBCTI5ww746nb1irAdpzl
         0XYaAddzf53qcR5hUIkfxB4ESCW0w2W1X83RG8MRyouneYTpWTWLOx83NLs9bWiNzyyr
         zJ0eTEHH9DgPbJOwip4snUwbuiAg4JIS97alnFJftVmn5rA66znjs03IjQ4JnL+0ppxY
         kSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360717; x=1704965517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONoic3hRyrsOtSLoSfqkG9TTgr22TgwSzWM+OzngmyI=;
        b=I72brVCNjx9KSlCcI8nlhKQRfQUrOzj6SBbF3qLWgFsCdU6H+cBfqH073FfpvRS0zO
         vLotkXlrmRufpY33L13amXlKsXBKjZhWrnQ6barh8MVehyAMxsSwbe5uQBpkEYzCSoYa
         Zd8Zt3RFJa+Z5tARQC/tKxBGTO24nk+Hq4V4rbSV141d0vDLwCmUh9tnyT5eEopEaL93
         KoBuQ7GSBpuowjTvXtgdsMRurC4Mj/zmeZ5oVp8VOO8+HWR/t11WJXQSrVHCgOw3z4iB
         Efw/kJ+qFS8K8B0C7QlUVrAP0AoSEHLF6BczIw7ahI2RqDRaCkV1CzWJ6mvYFeiRU6VD
         MyzA==
X-Gm-Message-State: AOJu0Ywn7WBJrwXMjehEfPSaq3O9u5no7s/28ot5VxwcLBrclTfdFosg
	Hvp36Me0Q3dVKHaHXVaeqZytt4PU6cSfXA==
X-Google-Smtp-Source: AGHT+IFxAYRV/ylxXesH/yrfr+duNGMJ4ZaZcjwUxniabyW0DWPu2eO4qi7oXE2yQsxaJkDvEn6hiw==
X-Received: by 2002:ac2:43cf:0:b0:50e:8eaf:9479 with SMTP id u15-20020ac243cf000000b0050e8eaf9479mr147390lfl.56.1704360716548;
        Thu, 04 Jan 2024 01:31:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id be11-20020a05600c1e8b00b0040d90536582sm4930402wmb.21.2024.01.04.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:31:56 -0800 (PST)
Date: Thu, 4 Jan 2024 10:31:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 3/5] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZZZ7C0dhg2KzaNfi@nanopsycho>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-4-dw@davidwei.uk>
 <ZZPv42K9VRTao735@nanopsycho>
 <bf4760df-a78f-431d-8c33-b7a2f7fb393d@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4760df-a78f-431d-8c33-b7a2f7fb393d@davidwei.uk>

Wed, Jan 03, 2024 at 11:36:36PM CET, dw@davidwei.uk wrote:
>On 2024-01-02 03:13, Jiri Pirko wrote:
>> Thu, Dec 28, 2023 at 02:46:31AM CET, dw@davidwei.uk wrote:
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
>> 
>> I don't see the rtnl_lock take in those functions.
>> 
>> 
>> Otherwise, this patch looks fine to me.
>
>For nsim_create(), rtnl_lock is taken in nsim_init_netdevsim(). For
>nsim_destroy(), rtnl_lock is taken directly in the function.
>
>What I mean here is, in the netdevsim device modification paths locks
>are taken in this order:
>
>devl_lock -> rtnl_lock
>
>nsim_dev_list_lock is taken outside (not nested) of these.
>
>In nsim_dev_peer_write() where two ports are linked, locks are taken in
>this order:
>
>nsim_dev_list_lock -> devl_lock -> rtnl_lock
>
>This will not cause deadlocks and ensures that two ports being linked
>are both valid.

Okay. Perhaps would be good to document this in a comment somewhere in
the code?


>
>> 
>> 
>>> concurrent calls to linking two netdevsims together.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
>>> drivers/net/netdevsim/netdevsim.h |  1 +
>>> 2 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index 434322f6a565..0009d0f1243f 100644
>>> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
>>> @@ -29,19 +29,34 @@
>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> {
>>> 	struct netdevsim *ns = netdev_priv(dev);
>>> +	struct netdevsim *peer_ns;
>>> +	int ret = NETDEV_TX_OK;
>>>
>>> 	if (!nsim_ipsec_tx(ns, skb))
>>> 		goto out;
>>>
>>> +	rcu_read_lock();
>>> +	peer_ns = rcu_dereference(ns->peer);
>>> +	if (!peer_ns)
>>> +		goto out_stats;
>>> +
>>> +	skb_tx_timestamp(skb);
>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>> +		ret = NET_XMIT_DROP;
>>> +
>>> +out_stats:
>>> +	rcu_read_unlock();
>>> 	u64_stats_update_begin(&ns->syncp);
>>> 	ns->tx_packets++;
>>> 	ns->tx_bytes += skb->len;
>>> +	if (ret == NET_XMIT_DROP)
>>> +		ns->tx_dropped++;
>>> 	u64_stats_update_end(&ns->syncp);
>>> +	return ret;
>>>
>>> out:
>>> 	dev_kfree_skb(skb);
>>> -
>>> -	return NETDEV_TX_OK;
>>> +	return ret;
>>> }
>>>
>>> static void nsim_set_rx_mode(struct net_device *dev)
>>> @@ -70,6 +85,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>> 		start = u64_stats_fetch_begin(&ns->syncp);
>>> 		stats->tx_bytes = ns->tx_bytes;
>>> 		stats->tx_packets = ns->tx_packets;
>>> +		stats->tx_dropped = ns->tx_dropped;
>>> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
>>> }
>>>
>>> @@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
>>> 	eth_hw_addr_random(dev);
>>>
>>> 	dev->tx_queue_len = 0;
>>> -	dev->flags |= IFF_NOARP;
>>> 	dev->flags &= ~IFF_MULTICAST;
>>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>> 			   IFF_NO_QUEUE;
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index 24fc3fbda791..083b1ee7a1a2 100644
>>> --- a/drivers/net/netdevsim/netdevsim.h
>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>> @@ -98,6 +98,7 @@ struct netdevsim {
>>>
>>> 	u64 tx_packets;
>>> 	u64 tx_bytes;
>>> +	u64 tx_dropped;
>>> 	struct u64_stats_sync syncp;
>>>
>>> 	struct nsim_bus_dev *nsim_bus_dev;
>>> -- 
>>> 2.39.3
>>>

