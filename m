Return-Path: <netdev+bounces-304487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xc8dK8ySR2qwbQAAu9opvQ
	(envelope-from <netdev+bounces-304487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F242970160A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=YuHT4YqA;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304487-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304487-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7993930AFCDD
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255C3CF20A;
	Fri,  3 Jul 2026 10:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281993BB112;
	Fri,  3 Jul 2026 10:37:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075051; cv=none; b=tbWpTGmrurYR6mKFmEmPDypbqh0kQdPN/Bvu675Y/CMYHx7Yfc7MxkOyKPSd5jD02x6415mtqaMd/t+0mIXijIWjck6ApsiyR5clCG1MjzeBy4GPTLLZjgu4F9JYlGA7ToC67JnAYw/5GsvPFZ4IFeG1Bgzv1xXbldDqgm10QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075051; c=relaxed/simple;
	bh=FIHGltDdsStjXthVrLzFN5Sb3wUcchH2XfTvl0wphmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIZvvc1oko9rEq/3zcBs5pWTy8cSnG0yIwYYxhT0MeRBG29tfSz69FoOmpcAGLgoOE2lSfao43Mp0gKFPJJcMRtWcMmipoA5Z0gvK0p84zJHSt8eHreOqJo8S1AnxXZf5g23jU02Foq1y6SqPzCCYCKi1ROlAlrcvm9Zeu2DL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=YuHT4YqA; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783074846;
	bh=8Vqu7qo86uboPK0E+YWqGhRGPatXsW0pkzTIpq567mk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YuHT4YqA9G8ILRleku6i56+yd0K5vSo7ts6iGhc2DUDvWTGU2SZ1NCsk0XSX7GfI0
	 XaQvBfIWlPBNDjjkdu/ZXsgrp/Oij0Sf/UVgx0MdW8Ig48HYn9fi+uKDyA22y1aBNk
	 fTCZa7HeF4eI+pPAkVcnSf287b2w3A6upnIgcdTE=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 663AY4eR020961
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 3 Jul 2026 12:34:05 +0200 (CEST)
Message-ID: <8e3af7e0-09f9-453d-a818-2bb4c3aaaec6@tu-dortmund.de>
Date: Fri, 3 Jul 2026 12:34:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Brett Sheffield <bacs@librecast.net>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
 <20260702183435-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260702183435-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304487-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tu-dortmund.de:from_mime,tu-dortmund.de:dkim,tu-dortmund.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F242970160A

On 7/3/26 00:44, Michael S. Tsirkin wrote:
> Well, the issue was with host to guest right?
> Then testing what does bql do might be interesting.
> Might help.
> Something like this? Lightly tested.

Your approach calls netdev_tx_completed_queue() per individual packet
which is wrong and will cause a constant BQL limit of 2 as we have seen
in [1], causing a regression *100%*.
Citing the documentation of netdev_tx_completed_queue() in netdevice.h:

 * Must be called at most once per TX completion round (and not per
 * individual packet), so that BQL can adjust its limits appropriately.

[1] Link: https://lore.kernel.org/all/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/

> 
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index bfa49fa9e3a1..abc46354c107 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1076,6 +1076,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	queue = netdev_get_tx_queue(dev, txq);
>  
>  	spin_lock(&tfile->tx_ring.producer_lock);
> +	netdev_tx_sent_queue(queue, len);
>  	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
>  	if (!qdisc_txq_has_no_queue(queue) &&
>  	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
> @@ -1088,6 +1089,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	spin_unlock(&tfile->tx_ring.producer_lock);
>  
>  	if (ret) {
> +		netdev_tx_completed_queue(queue, 1, len);
>  		/* This should be a rare case if a qdisc is present, but
>  		 * can happen due to lltx.
>  		 * Since skb_tx_timestamp(), skb_orphan(),
> @@ -2148,15 +2150,19 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  
>  /* Callers must hold ring.consumer_lock */
>  static void __tun_wake_queue(struct tun_struct *tun,
> -			     struct tun_file *tfile, int consumed)
> +			     struct tun_file *tfile,
> +			     unsigned int pkts, unsigned int bytes)
>  {
>  	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
>  						tfile->queue_index);
>  
> +	if (bytes)
> +		netdev_tx_completed_queue(txq, pkts, bytes);
> +


Right here.



>  	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
>  	smp_mb();
>  	if (netif_tx_queue_stopped(txq)) {
> -		tfile->cons_cnt += consumed;
> +		tfile->cons_cnt += pkts;
>  		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
>  		    __ptr_ring_empty(&tfile->tx_ring)) {
>  			netif_tx_wake_queue(txq);
> @@ -2167,12 +2173,16 @@ static void __tun_wake_queue(struct tun_struct *tun,
>  
>  static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
>  {
> +	unsigned int bytes = 0;
>  	void *ptr;
>  
>  	spin_lock(&tfile->tx_ring.consumer_lock);
>  	ptr = __ptr_ring_consume(&tfile->tx_ring);
> -	if (ptr)
> -		__tun_wake_queue(tun, tfile, 1);
> +	if (ptr) {
> +		if (!tun_is_xdp_frame(ptr))
> +			bytes = ((struct sk_buff *)ptr)->len;
> +		__tun_wake_queue(tun, tfile, 1, bytes);
> +	}
>  
>  	spin_unlock(&tfile->tx_ring.consumer_lock);
>  	return ptr;
> @@ -3805,7 +3815,7 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>  
>  /* Callers must hold ring.consumer_lock */
> -void tun_wake_queue(struct file *file, int consumed)
> +void tun_wake_queue(struct file *file, unsigned int pkts, unsigned int bytes)
>  {
>  	struct tun_file *tfile;
>  	struct tun_struct *tun;
> @@ -3821,7 +3831,7 @@ void tun_wake_queue(struct file *file, int consumed)
>  
>  	tun = rcu_dereference(tfile->tun);
>  	if (tun)
> -		__tun_wake_queue(tun, tfile, consumed);
> +		__tun_wake_queue(tun, tfile, pkts, bytes);
>  
>  	rcu_read_unlock();
>  }
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index db341c922673..5267b323bd59 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -181,14 +181,23 @@ static int vhost_net_buf_produce(struct sock *sk,
>  {
>  	struct file *file = sk->sk_socket->file;
>  	struct vhost_net_buf *rxq = &nvq->rxq;
> +	unsigned int bytes = 0;
> +	int i;
>  
>  	rxq->head = 0;
>  	spin_lock(&nvq->rx_ring->consumer_lock);
>  	rxq->tail = __ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>  					       VHOST_NET_BATCH);
>  
> -	if (rxq->tail)
> -		tun_wake_queue(file, rxq->tail);
> +	if (rxq->tail) {
> +		for (i = 0; i < rxq->tail; i++) {
> +			void *ptr = rxq->queue[i];
> +
> +			if (!tun_is_xdp_frame(ptr))
> +				bytes += ((struct sk_buff *)ptr)->len;
> +		}
> +		tun_wake_queue(file, rxq->tail, bytes);
> +	}
>  
>  	spin_unlock(&nvq->rx_ring->consumer_lock);
>  	return rxq->tail;
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 5f3e206c7a73..49b85bf4f828 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,7 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> -void tun_wake_queue(struct file *file, int consumed);
> +void tun_wake_queue(struct file *file, unsigned int pkts, unsigned int bytes);
>  
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -56,7 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> -static inline void tun_wake_queue(struct file *f, int consumed) {}
> +static inline void tun_wake_queue(struct file *f,
> +				  unsigned int pkts, unsigned int bytes) {}
>  
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> 

