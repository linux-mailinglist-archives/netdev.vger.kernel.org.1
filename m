Return-Path: <netdev+bounces-60845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B06821AB5
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6AEB20DF2
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA6DDBA;
	Tue,  2 Jan 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j+rdqpRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881FE544
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33748c4f33dso286361f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704194020; x=1704798820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/U7tztouYNC9CctiiUOjOlsSdhlfnhCeeIBmPFcIoE=;
        b=j+rdqpReUOIpfBRJ2K5YP6S4AXXDm5Q+2fJuQXD5F414Ku3URnvtrQXyYIbFMAtz+2
         LbehiXQAQ6V0l2yDrSbcx6p7F6eV8lIO03EbR2VSyhi3BJKnNDbeGewAc1/943y/DUjk
         nwjsa1rONemeKemkKETE7D3n3S31Zo9iJ85h/iN4wj+sDSWiXdu2eVMyIYfcA2ZyUsJZ
         Jj4nkD9b9RnJRMSRQLBcEdS7Cz2A8vo5/XNMMapdMkRzmWed5DZzCmRW+it+yqifLpZV
         FufcWLn6JGTmQX3HXiW9x4Wdb6dIlXWHHgctW2O+QEB7VJ+7cQMremVFg+rhzg+t43TE
         gOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194020; x=1704798820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/U7tztouYNC9CctiiUOjOlsSdhlfnhCeeIBmPFcIoE=;
        b=D7J9b2DBAC3Pi3pqIH7BgWNwAEzB/vX7giMFZNLyuDjfeqfD/B1VPS0vKjY+MKg2ea
         VgEzZcrEihohq3sLomMpX+6XHuzCgcC4Opa1Z1+37zUBj2qmqbNNuAnP2iPZ9J6EIpo/
         KI8RO/d9c4HO93OF02MZYaow21yg2khUA2emPxf3oB7p8UtsiGcw8sFH2OfP4t5dAAD6
         J52V0pWy593PeTHqa2Oz118t8hC6WwMkYyLfEluhpizZ0nAXL+Ypma3cKSRPMfqRyWjD
         1CdOTdD1iZ1cbXT6Wgxs8mwvmGWnvFZtWkp3yMuWe4f36cbuVcb5qTu6Kg2zC4V2nXg5
         Kang==
X-Gm-Message-State: AOJu0YxH95r1QYGgBw6n3+Za3K2N2+2RoVis8rGi7rpPEsaySL5mjglI
	OlrkrNZXi4loGRw7QhTFGcELIOUoXC8B4cOf0b7gK4lL6nbC8A==
X-Google-Smtp-Source: AGHT+IEslHXec6kRKjdSPt4sDBtDT/d53//djYc8KBS1deIo5fnBFf/5fTzkVeqCD27SAriKZI/SUA==
X-Received: by 2002:a5d:40c8:0:b0:336:6eba:b0ff with SMTP id b8-20020a5d40c8000000b003366ebab0ffmr8657586wrq.94.1704194020599;
        Tue, 02 Jan 2024 03:13:40 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id df2-20020a5d5b82000000b00336be33649csm20858218wrb.9.2024.01.02.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:13:40 -0800 (PST)
Date: Tue, 2 Jan 2024 12:13:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 3/5] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZZPv42K9VRTao735@nanopsycho>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014633.3256862-4-dw@davidwei.uk>

Thu, Dec 28, 2023 at 02:46:31AM CET, dw@davidwei.uk wrote:
>Forward skbs sent from one netdevsim port to its connected netdevsim
>port using dev_forward_skb, in a spirit similar to veth.
>
>Add a tx_dropped variable to struct netdevsim, tracking the number of
>skbs that could not be forwarded using dev_forward_skb().
>
>The xmit() function accessing the peer ptr is protected by an RCU read
>critical section. The rcu_read_lock() is functionally redundant as since
>v5.0 all softirqs are implicitly RCU read critical sections; but it is
>useful for human readers.
>
>If another CPU is concurrently in nsim_destroy(), then it will first set
>the peer ptr to NULL. This does not affect any existing readers that
>dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>a synchronize_rcu() before the netdev is actually unregistered and
>freed. This ensures that any readers i.e. xmit() that got a non-NULL
>peer will complete before the netdev is freed.
>
>Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>will dereference NULL, making it safe.
>
>The codepath to nsim_destroy() and nsim_create() takes both the newly
>added nsim_dev_list_lock and rtnl_lock. This makes it safe with

I don't see the rtnl_lock take in those functions.


Otherwise, this patch looks fine to me.


>concurrent calls to linking two netdevsims together.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
> drivers/net/netdevsim/netdevsim.h |  1 +
> 2 files changed, 19 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index 434322f6a565..0009d0f1243f 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -29,19 +29,34 @@
> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct netdevsim *ns = netdev_priv(dev);
>+	struct netdevsim *peer_ns;
>+	int ret = NETDEV_TX_OK;
> 
> 	if (!nsim_ipsec_tx(ns, skb))
> 		goto out;
> 
>+	rcu_read_lock();
>+	peer_ns = rcu_dereference(ns->peer);
>+	if (!peer_ns)
>+		goto out_stats;
>+
>+	skb_tx_timestamp(skb);
>+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>+		ret = NET_XMIT_DROP;
>+
>+out_stats:
>+	rcu_read_unlock();
> 	u64_stats_update_begin(&ns->syncp);
> 	ns->tx_packets++;
> 	ns->tx_bytes += skb->len;
>+	if (ret == NET_XMIT_DROP)
>+		ns->tx_dropped++;
> 	u64_stats_update_end(&ns->syncp);
>+	return ret;
> 
> out:
> 	dev_kfree_skb(skb);
>-
>-	return NETDEV_TX_OK;
>+	return ret;
> }
> 
> static void nsim_set_rx_mode(struct net_device *dev)
>@@ -70,6 +85,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> 		start = u64_stats_fetch_begin(&ns->syncp);
> 		stats->tx_bytes = ns->tx_bytes;
> 		stats->tx_packets = ns->tx_packets;
>+		stats->tx_dropped = ns->tx_dropped;
> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
> }
> 
>@@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
> 	eth_hw_addr_random(dev);
> 
> 	dev->tx_queue_len = 0;
>-	dev->flags |= IFF_NOARP;
> 	dev->flags &= ~IFF_MULTICAST;
> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
> 			   IFF_NO_QUEUE;
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index 24fc3fbda791..083b1ee7a1a2 100644
>--- a/drivers/net/netdevsim/netdevsim.h
>+++ b/drivers/net/netdevsim/netdevsim.h
>@@ -98,6 +98,7 @@ struct netdevsim {
> 
> 	u64 tx_packets;
> 	u64 tx_bytes;
>+	u64 tx_dropped;
> 	struct u64_stats_sync syncp;
> 
> 	struct nsim_bus_dev *nsim_bus_dev;
>-- 
>2.39.3
>

