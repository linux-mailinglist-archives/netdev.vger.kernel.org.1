Return-Path: <netdev+bounces-57870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637778145E0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F193285631
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37111A717;
	Fri, 15 Dec 2023 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UkonQnDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313F1A711
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a22fb5f71d9so87733766b.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702637136; x=1703241936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwPe/iahY7ApTLD8fcE62eFuVvnVpyt0sw9R5Im/rZI=;
        b=UkonQnDNZ5JHZQKZKUt2Btk7K6CeKSAbNirJgpmwKxIH3HEpavQf/RGOlxhP5djcNt
         o1IpSRk8yxN7bDnctdUZYmFM24EOHOkznZaXDdDPgOrnQ2jU5xGaKE9jtrUoBpYk6Os7
         DEVXL6A5dpDvgKpQUjCmaUb7yd/XK2iE4KQjjl1b8hsg4PhkCRv+Ja1KPUfNcCtq8AD3
         IejqXkPA8l63h5/DlqV2OB8z1MyFRg1xESVf4okhkz7KDe/kN7Ccgoj5nYvKfcES+pVm
         upW+FWJuRdEMlLk4FV3F6a2zcQ8Vka/UDH5e5JoXT/u6pug0jUS9N+uz06o0grY21r+r
         PxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702637136; x=1703241936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwPe/iahY7ApTLD8fcE62eFuVvnVpyt0sw9R5Im/rZI=;
        b=jSr398OSYYTALkFjoCbdd7dGaDKn+pyI7QS1p8IFqlVZtQDZQGvQYWIWuI1Kxsas6O
         nwrxHEq364dpVVZftFwNXrweE9Yr1zbxMP8uwfgbUnlst2DN5M6q7C8CPRZJz9O6sgoQ
         i04TVSmfBHJbxn5D/xWhL9zpweEaJlYwW4q7RY2SJVJs9AKaq55y2dOwFUhWD7LDOf8T
         CK8G9ag7evhq1Te79Dzv0g9V+u4U8o2VTMl//FBSeCyE6hnLH6Xsa3zlsm237KjxtMhY
         Ick661H+Cm2rkJqcuL7BLm7WAXAnU7ugMfXWHN+8Zihcy/eV5fOePPFpweVM6C4usFgR
         +Juw==
X-Gm-Message-State: AOJu0YyCgF5Q4EH1iF7zP9MqxRJ4mnNltDxr3XGsn15ss0N1ggjd0xGz
	KkcC3QHffsLoZPjj3FAFg1DZnQ==
X-Google-Smtp-Source: AGHT+IHPRy1q7dpI9+aFcDwJC+Abbwxcg+uD3eIXFRjn+AHoKXuthX4Ks277S2xvTlrVBTPoPmEEAQ==
X-Received: by 2002:a17:906:ef8b:b0:a1b:619e:53f7 with SMTP id ze11-20020a170906ef8b00b00a1b619e53f7mr11429745ejb.27.1702637135853;
        Fri, 15 Dec 2023 02:45:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ty6-20020a170907c70600b00a1d71c57cb1sm10649563ejc.68.2023.12.15.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:45:35 -0800 (PST)
Date: Fri, 15 Dec 2023 11:45:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/4] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZXwuTRFSbDn_ON_E@nanopsycho>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214212443.3638210-3-dw@davidwei.uk>

Thu, Dec 14, 2023 at 10:24:41PM CET, dw@davidwei.uk wrote:
>Forward skbs sent from one netdevsim port to its connected netdevsim
>port using dev_forward_skb, in a spirit similar to veth.

Perhaps better to write "dev_forward_skb()" to make obvious you talk
about function.


>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index e290c54b0e70..c5f53b1dbdcc 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -29,19 +29,33 @@
> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct netdevsim *ns = netdev_priv(dev);
>+	struct netdevsim *peer_ns;
>+	int ret = NETDEV_TX_OK;
> 
>+	rcu_read_lock();

Why do you need to be in rcu read locked section here?


> 	if (!nsim_ipsec_tx(ns, skb))
>-		goto out;
>+		goto err;

Not sure why you need to rename the label. Why "out" is not okay?

> 
> 	u64_stats_update_begin(&ns->syncp);
> 	ns->tx_packets++;
> 	ns->tx_bytes += skb->len;
> 	u64_stats_update_end(&ns->syncp);
> 
>-out:
>-	dev_kfree_skb(skb);
>+	peer_ns = rcu_dereference(ns->peer);
>+	if (!peer_ns)
>+		goto err;

This is definitelly not an error path, "err" label name is misleading.


>+
>+	skb_tx_timestamp(skb);
>+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>+		ret = NET_XMIT_DROP;

Hmm, can't you track dropped packets in ns->tx_dropped and expose in
nsim_get_stats64() ?


> 
>-	return NETDEV_TX_OK;
>+	rcu_read_unlock();
>+	return ret;
>+
>+err:
>+	rcu_read_unlock();
>+	dev_kfree_skb(skb);
>+	return ret;
> }
> 
> static void nsim_set_rx_mode(struct net_device *dev)
>@@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
> 	eth_hw_addr_random(dev);
> 
> 	dev->tx_queue_len = 0;
>-	dev->flags |= IFF_NOARP;
> 	dev->flags &= ~IFF_MULTICAST;
> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
> 			   IFF_NO_QUEUE;
>-- 
>2.39.3
>

