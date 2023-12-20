Return-Path: <netdev+bounces-59179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F159D819B14
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1691C22213
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6B1CAA7;
	Wed, 20 Dec 2023 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2cQHZ2CR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753811F5E4
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553b3ee88c0so1153582a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1703063056; x=1703667856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNrhw/CtB6HBjPsyzRsg5bg1nYBtuWVDL8RmBJ988xw=;
        b=2cQHZ2CRjpaN6Dgz3AL5pQ/LMi6aAJ9ELUmP48X72bJt4Mj7wW9NFxK/iarU5ZvAjE
         /MypDNwa5J99TaXTntimRO9fxjpuq4pyn2kvuNjqnMp++o7O/LwDE53GP/0TXnWCAq2i
         mZMLxGjwyszZd/7ADvq0Fr72tBV8JP4c+uWDSeuudMrYFoVzv3LFsRrF9/pptW0iOgYL
         4/nlEy4xP2Mn46dMLNwXsnmUR9fLTX4TR84JImh/qFRKLDLv0SyBYFWz1sTyKEVnwJSm
         ST3XkCa7+bvA6+M8L2CPJQ9/87kPfJ1EDNSQK3CW6pnB4jpKXMiuGIFTGK7scgUswcUI
         htGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063056; x=1703667856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNrhw/CtB6HBjPsyzRsg5bg1nYBtuWVDL8RmBJ988xw=;
        b=tZeMZa/46pFF57f1J9LlNH0vGxiDhOwOJLIkpPOZHhu4B+ujv/O4izfT3qCT11cZzW
         6ViL15Sfdd9epB5r91Z9dwWtUC50xdyB/nqIlw5rDYkRdyZN5ILTQhIO64BoZhPk14Fu
         x7B/eG7X/CHW8qAB8LSuAaH3MDWwMeJIz1y+Kp7WW0VEFXUfJgaU9KO2Bb0XHJL/pxfy
         3Y+GT4opKz6JM9wp1L7drltLcBJox8oreK4oyMUCUfwkTXjkA/vLTFhH0IYPRbQJuebT
         Dco4yngJW3YGa5MkuVpPlUDgvVCESI/Xho40/QEPGcrHGAHxrksdTU6Q9wxTlrYhobMX
         b6pw==
X-Gm-Message-State: AOJu0YziFJZTxX1q5Ft9sX98Af1UOX3q64RLTZZ9rhW4CIAqpmcuVbjI
	18hyIozP7gfCPW8NWkqirCom/wwOx/IZtxfsd8s=
X-Google-Smtp-Source: AGHT+IG3bX8RIcGRXVGS9ruivNRfXbdaMKez8RKUUx63rp3ZVCCdP3FZGdahAgs8e1hgP5n9Fa50yg==
X-Received: by 2002:a50:85c6:0:b0:54c:7b90:f40a with SMTP id q6-20020a5085c6000000b0054c7b90f40amr12847384edh.4.1703063055638;
        Wed, 20 Dec 2023 01:04:15 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e7-20020a50fb87000000b005532b0414aesm3679895edq.51.2023.12.20.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:04:15 -0800 (PST)
Date: Wed, 20 Dec 2023 10:04:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 3/5] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZYKuDmMh_PyouG8K@nanopsycho>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220014747.1508581-4-dw@davidwei.uk>

Wed, Dec 20, 2023 at 02:47:45AM CET, dw@davidwei.uk wrote:
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
>concurrent calls to linking two netdevsims together.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/netdev.c    | 25 ++++++++++++++++++++++---
> drivers/net/netdevsim/netdevsim.h |  1 +
> 2 files changed, 23 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index 434322f6a565..00ab3098eb9f 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -29,6 +29,8 @@
> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct netdevsim *ns = netdev_priv(dev);
>+	struct netdevsim *peer_ns;
>+	int ret = NETDEV_TX_OK;
> 
> 	if (!nsim_ipsec_tx(ns, skb))
> 		goto out;
>@@ -36,12 +38,29 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> 	u64_stats_update_begin(&ns->syncp);
> 	ns->tx_packets++;
> 	ns->tx_bytes += skb->len;
>+
>+	rcu_read_lock();
>+	peer_ns = rcu_dereference(ns->peer);
>+	if (!peer_ns)
>+		goto out_stats;
>+
>+	skb_tx_timestamp(skb);
>+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP)) {
>+		ret = NET_XMIT_DROP;
>+		ns->tx_dropped++;

Idk, does not look fine to me to be in u64_stats_update section while
calling dev_forward_skb()


>+	}
>+
>+	rcu_read_unlock();
> 	u64_stats_update_end(&ns->syncp);
> 
>+	return ret;
>+
>+out_stats:
>+	rcu_read_unlock();
>+	u64_stats_update_end(&ns->syncp);
> out:
> 	dev_kfree_skb(skb);
>-
>-	return NETDEV_TX_OK;
>+	return ret;
> }
> 
> static void nsim_set_rx_mode(struct net_device *dev)
>@@ -70,6 +89,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> 		start = u64_stats_fetch_begin(&ns->syncp);
> 		stats->tx_bytes = ns->tx_bytes;
> 		stats->tx_packets = ns->tx_packets;
>+		stats->tx_dropped = ns->tx_dropped;
> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
> }
> 
>@@ -302,7 +322,6 @@ static void nsim_setup(struct net_device *dev)
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

