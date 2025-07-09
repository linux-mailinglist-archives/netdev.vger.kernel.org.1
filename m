Return-Path: <netdev+bounces-205369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A12CAFE5D5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A0B18948EF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0D27CCE7;
	Wed,  9 Jul 2025 10:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E10258CC9;
	Wed,  9 Jul 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057266; cv=none; b=Wk5VpV/xbhjNwv3GaU3+26SfGPCzJXhnFpbN4LpbfoDuxr7zy5JtD6KEFVl88yzgx0gxjF02MqkwCytQHaWC5i2+Bgeu+SMYEWO2gey7lo+Q181Sgz5JYM827+vytGy0gD2TB0qNfw5rCT4gxngHh6acnnkz1VyWW+4it2EVydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057266; c=relaxed/simple;
	bh=+cxS5MiAAf3humZhyh5TASrZIokPGp5nK7E4WHnrsPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnI+cP4sUY0eQ+Qq9Bhm6bAVMFoihEEa6NEtQYMMDNtw0dZZqqJpqg4bG4jCrivqKlkQkD/9CTfZjxINlJbAlh+okdGzXAMCFYzs8Eiy66xtIyEBFPH+4dr2qIClgQwtX6rSlu0SfjuGgdLf6oH9AVLY9hffLmb7ZLCiRXvlcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1130738066b.1;
        Wed, 09 Jul 2025 03:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057263; x=1752662063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYfFTk4cxPsv8qRd1XaiI9syNTWMKA25j0iuuFRQVKk=;
        b=BXhIi7BZ+X5bTIUyvtq9eXX8iOIU2drBP6E3vApp1xlAB5/nCpKJ535mG5Rfk7yt8v
         6FZQKpZ+Yn+L+3FIDJTE/rCY7FMM/Or0UCiS0P0G86nfMQafX5J+UQommvtHUqHIaFIS
         PEWurJIHAdX+F5T7iCuTY1cKWGj9w9sCnrqxjjKWWlqUDl5oJUbKXvTcI7VFVCFDg3iA
         ebLgWopPZ3GzGKi4pVGH6Kov8ZuUGEdpaPWyBeWmq1n7BFEyap4nWHyZZx2vVM+EClHz
         dK2sGPq+CdtM22dyroRVsBIZekKBlbuUUftzcO5UkVG2TnqpYdzXmu7vYnuUDlF4/F8F
         ceFA==
X-Forwarded-Encrypted: i=1; AJvYcCVRlTzXo1d2XTcwXkG0oCCwFkesroh+9X+X04zEMny3F7se8Ze9VgRamkWyioajmmlqbPkWthxC6gxn9To=@vger.kernel.org, AJvYcCW4zsYOiOOCs91OqCh9wlNesLwtYrMNj0wtWWSnwsA2WB4dZRVpUoLqemILg1X5vQj+2XA/zXrz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4Kh1TsGeqrOGUImY+K2rMI5jwn61kXTg+fo2dt9dNifMpgnm
	00FXzTRMZ7V50DoGAs2dAQ5vitDL3TfwqY1IyLNY7QXE5diaJoDPxWMo
X-Gm-Gg: ASbGncvokAVtJ1F4raat9eBxH/LNAlChRSeG2sTz4QF6TZ50WRxwO3GISU+xzlRbBQi
	oyaX5GO7dUC7ZbU2UL1SngdMRljcdYMYNniIc9kqONBtmTgFLesQFY1jryLbUzmlSpvtLxlRQ6A
	GNcCa8AR94AKazxBQmmQU4Ikhn++2EzskUvUTfX1sV9X0M31xZG5ZCEt+QLjgowT4r7lTzOLOKO
	1g438IETDDijLZs6VWsBV9sSXzDhXlihfgz57lJxrYanri9t8PoIK7wTHJ9emJCMV7QAQsFKsK6
	Bb+cKCnK8wvRWI+NvVc8Gzh1yAENjxuqQ9B7A8XrZUEptwYgcd76
X-Google-Smtp-Source: AGHT+IGOi+B/tTlyqDjPISYuIBxUcZMVAQSNjhZWKRkiN4sDYO+PRKnKXLv+p3W0vyLpZGBziwj+EA==
X-Received: by 2002:a17:907:86a7:b0:ade:9b52:4da0 with SMTP id a640c23a62f3a-ae6cfc8338fmr190623066b.60.1752057262696;
        Wed, 09 Jul 2025 03:34:22 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e8c31sm1090625566b.18.2025.07.09.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:34:22 -0700 (PDT)
Date: Wed, 9 Jul 2025 03:34:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v2] netdevsim: implement peer queue flow control
Message-ID: <aG5FrObkP+S8cRZh@gmail.com>
References: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
 <20250708182718.29c4ae45@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708182718.29c4ae45@kernel.org>

Hello Jakub,

On Tue, Jul 08, 2025 at 06:27:18PM -0700, Jakub Kicinski wrote:
> On Thu, 03 Jul 2025 06:09:31 -0700 Breno Leitao wrote:
> > +static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
> > +			struct sk_buff *skb)
> >  {
> >  	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
> > +		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
> >  		dev_kfree_skb_any(skb);
> >  		return NET_RX_DROP;
> >  	}
> 
> we should probably add:
> 
> 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE)
> 		nsim_stop_tx_queue(dev, rq, skb_get_queue_mapping(skb));
> 
> after enqueuing the skb, so that we stop the queue before any drops
> happen

Agree, we can stop the queue when queueing the packets instead. Since we
need to check for the queue numbers, we cannot call nsim_stop_tx_queue()
straight away. I think we still need to have a helper
(nsim_stop_tx_queue). This is what I have in mind:

	static void nsim_stop_tx_queue(struct net_device *tx_dev,
					struct net_device *rx_dev,
					struct nsim_rq *rq,
					u16 idx)
	{
		/* If different queues size, do not stop, since it is not
		* easy to find which TX queue is mapped here
		*/
		if (rx_dev->real_num_tx_queues != tx_dev->num_rx_queues)
			return;

		/* rq is the queue on the receive side */
		netif_subqueue_try_stop(tx_dev, idx,
					NSIM_RING_SIZE - skb_queue_len(&rq->skb_queue),
					NSIM_RING_SIZE / 2);
	}

	static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
				struct nsim_rq *rq, struct sk_buff *skb)
	{
		if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
			dev_kfree_skb_any(skb);
			return NET_RX_DROP;
		}

		skb_queue_tail(&rq->skb_queue, skb);

		/* Stop the peer TX queue avoiding dropping packets later */
		if (skb_queue_len(&rq->skb_queue) >= NSIM_RING_SIZE)
			nsim_stop_tx_queue(tx_dev, rx_dev, rq,
					skb_get_queue_mapping(skb));

		return NET_RX_SUCCESS;
	}

> > @@ -51,7 +109,7 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> >  static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
> >  			    struct nsim_rq *rq)
> >  {
> > -	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
> > +	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(dev, rq, skb);
> >  }
> >  
> >  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> 
> nsim_start_xmit() has both dev and peer_dev, pass them all the way to
> nsim_stop_peer_tx_queue() so that you don't have to try to dereference
> the peer again.

Sure. This is a good idea. I am using it, as you can see in the snippet
above.

> > +	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
> 
> given that we compare real_num_tx_queues I think we should also kick
> the queues in nsim_set_channels(), like we do in unlink_device_store()

Sure. I suppose something like the following. What do you think?

	nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
	{
		struct netdevsim *ns = netdev_priv(dev);
	+       struct netdevsim *peer;
		int err;

		err = netif_set_real_num_queues(dev, ch->combined_count,
	@@ -113,6 +114,14 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
			return err;

		ns->ethtool.channels = ch->combined_count;
	+
	+	synchronize_net();
	+       netif_tx_wake_all_queues(dev);
	+       rcu_read_lock();
	+       peer = rcu_dereference(ns->peer);
	+       if (peer)
	+               netif_tx_wake_all_queues(peer->netdev);
	+       rcu_read_unlock();
	+
		return 0;
	}


Also, with this patch, we will eventually get the following critical
message:

	net_crit_ratelimited("Virtual device %s asks to queue packet!\n", dev->name);

I am wondering if that alert is not valid anymore, and I can simply
remove it.

Thanks for your review!
--breno

