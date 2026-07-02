Return-Path: <netdev+bounces-304289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GkepE9/pRmrMfQsAu9opvQ
	(envelope-from <netdev+bounces-304289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:44:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A36FD470
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:44:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KQc6peP1;
	dkim=pass header.d=redhat.com header.s=google header.b=R4K6VWVE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3006A3006D7C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A83D0BE1;
	Thu,  2 Jul 2026 22:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D733CFF7F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032280; cv=none; b=oFt3w1/WrE89oohUnJr34u0OzJX7Nw77I03N8/kEX/MJbGwu3tlyMxsbmA2DpUfN0Hfqu9V4LQIWS3sZvtm85teQA8ufBGcWC11j1kVg9q108eyKgCKMRkxvAcezG5U7t/8xzvNf673cfMZ6MqkmWdPxHYkVvh2VWe6xSE4K0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032280; c=relaxed/simple;
	bh=UGDdCtJ3tvCdQ7atMdk9EYMybsWKIi1x/7V26/tC02I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE4hkTAxJWyvAgZMd5jsQmqT2Qw0euMbykiQ1DIQo9MXUVcCYPqrTFZdRq02YAHncxmbYu66FYJnAEA2yuspCIGUSNEjWSxTca25lSsbSR/eKojEbmW5jXQU2BuoZKpiO8QKQB+beDSL9PgQ1e2d1VkTCQseUXPnyC376Ep6qA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQc6peP1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4K6VWVE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783032275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/rbYuZ3JZ8lfJrteK+nOk5ehF4hktz6HEAclFasOjE=;
	b=KQc6peP1w+r3WTKLnOLWO6ukBZ0EyHy5c7xCtSgVqhUvA4XAjC1urhYXKpKMV48p6505+q
	w2WjrOt3w7Los5ugz67ASXk0YpJ+gRUZaBSuCK/uj0/PR879iGpFVwDw2qdblI4LTKCJjN
	jSarRktrx/NGBdwi0YxOz3aMilBPyN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-RTi7xkCBNvG5Dcdol2m1MA-1; Thu, 02 Jul 2026 18:44:34 -0400
X-MC-Unique: RTi7xkCBNvG5Dcdol2m1MA-1
X-Mimecast-MFC-AGG-ID: RTi7xkCBNvG5Dcdol2m1MA_1783032273
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so1772810f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783032273; x=1783637073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rbYuZ3JZ8lfJrteK+nOk5ehF4hktz6HEAclFasOjE=;
        b=R4K6VWVE7kd/Yyy9kU3HO4vjD8de0Eq58gYfmV9NJnkOa6gifMc9rEO4Mn2c+VsTp7
         GnDKJoXvw+EPSqV50iRgv8KuRQDuTabsfHSD7sm4hdXgH7zbywAID+sQE7bxelfQA4Jx
         8xCSMcS5ST2UaA7JeQ9sdqesySzHH1QkN6szt6Ih4hYerXt3MNsHWmy3u5NSgbedKiOt
         k/02yfJGbp/6bIvdUsylV67kOaIdOHcSGCmkMK4Iu/gmUw0jRhtTeEGZyMDAEk0V62V/
         8zbTc5f0Aned89sK/OgetzTR34UQl2zf4h0ioPfB0rQnbQQqOhCR7Lix5jGXjYXkBd0O
         8wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032273; x=1783637073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/rbYuZ3JZ8lfJrteK+nOk5ehF4hktz6HEAclFasOjE=;
        b=UtWEuuH9vOVjCg8Ww8DBvn9TpIBvF0jvBNSAeBmEnXpErhPFTEOMSwLPlMOaDWdBk9
         nk2I2mXh2HiivW2AyDPLP2uWpNBkITDT+vvgxgOYeiXZxPjoCIreq06PaO3w1p9/Q+se
         0Ryl7JXhaH+HkzRJ5DrFnlOZH/BTWSeGmimaSTW+Y+PIhpkF9TX3SI1ERJq9YraQ64DD
         kf1xvXA06iGFa0zepsU/ra4HxBZfG7c+aUPBP4oxwFiTTIRjDqzupVql8Gb1ctva1fcS
         syDUvMc5ChmxoVQWZcR9LoYs2dJ2Bt5EySBkYc5z5gD9a54n84D3n1K3ygrkjz4sb9Qm
         Wmtw==
X-Forwarded-Encrypted: i=1; AHgh+RpSCciOlznR1VyYZ5hhwFwHb/r9AiYE93kyKu6lOVgjg45lDPKEGMZEcK35xd94L1s0SUbDVcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHETA7JMbsQl27oghkUPqOgDx9EmSryHIWMNkKSOGDqy3HgxY
	khGC+OhWmrSJ8W2zTB1rAWIYu2HIWscTmBtS9HIZrCm1qo2HXudxENqM/2U9A3DtNW2rZlgrnxC
	rFWa9G/3Ay0I5pxsX2wnl3f7lLJ1EotBNj3SxoZyPJx7GtMkZTwMfEkS3EQ==
X-Gm-Gg: AfdE7ckmi1tG+4Dqja7zTm5xB6ZLk1SC32Ud32UK1FhVJgeWNBrY7V8kfeb51mSN9v8
	L8XZNRxQsE0xZQ/weZhZvuKrXwlusv0RAfFKM0dM6QVqZQcgdn/GxTunUvqRBeISGar4tB7fsNE
	GU4xQGCXqqy4zRMgNw9IwdRP7idDBFAoySqpgsGKZEN6+eysAmypUPXHlKBDfzdbU5yKQg1Aolv
	nDrejRR4n1zu4Ht7ElLHIB00G6UhDYK+6pNd/V+PqRlTPAhgMobIpUpBtK7RHLM8o5zftn1XTK3
	T/WGLaUOIpFIv7B1mAtSAL+F/DEaNPM7b/sygq3oAbDFlIRVfWnlftkc43I8/W15AYyqBtRCDQ7
	TBzUK7jq70TWuis+5Hu2yFO6gFigJlHkT
X-Received: by 2002:a05:6000:469b:b0:46e:624e:3c2f with SMTP id ffacd0b85a97d-477595684ffmr7982451f8f.47.1783032272527;
        Thu, 02 Jul 2026 15:44:32 -0700 (PDT)
X-Received: by 2002:a05:6000:469b:b0:46e:624e:3c2f with SMTP id ffacd0b85a97d-477595684ffmr7982435f8f.47.1783032271940;
        Thu, 02 Jul 2026 15:44:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cec5sm12205361f8f.19.2026.07.02.15.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:44:31 -0700 (PDT)
Date: Thu, 2 Jul 2026 18:44:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett Sheffield <bacs@librecast.net>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	regressions@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260702183435-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZGg96-Xu9VeGrw@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304289-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:simon.schippers@tu-dortmund.de,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tu-dortmund.de,lists.linux.dev,vger.kernel.org,kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,brettsheffield.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E1A36FD470

On Thu, Jul 02, 2026 at 01:07:47PM +0200, Brett Sheffield wrote:
> On 2026-07-02 09:24, Simon Schippers wrote:
> > On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > > On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> > >> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> > >> significant performance regressions with TAP interfaces and multithreaded
> > >> network code. Please revert.
> > >>
> > >>
> > >> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> > >> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> > >> interface. This test has run successfully on every stable, LTS and mainline RC
> > >> released in the past year. Every kernel with my Tested-by has run this test.
> > >>
> > >> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> > >> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> > >> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> > >>
> > >> Reverting this commit fixes the test.
> > >>
> > >> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> > >> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> > >> reverted.
> > 
> > Thank you very much for your bisect!
> > 
> > As the author, I am sorry for that regression!
> 
> No worries. That's why we test :-)
> 
> > > - does it help to increase the tun queue size?
> > 
> > I agree, this would be great to know.
> > 
> > However, even then we must act. I am considering IFF_BACKPRESSURE
> > as a feature flag, defaulting to off. It would just enable/disable
> > the stopping logic in tun_net_xmit() and the waking logic
> > in __tun_wake_queue(). If disabled, it would result in the same logic
> > as before.
> > 
> > I could provide such a patch as [net] material.
> 
> I'm going to make myself a strong cup of tea and dig into it a bit more here and
> will let you know if I find anything worth reporting.
> 
> If you need me to try re-testing with specific settings or test a patch I'm
> happy to do so.
> 
> Cheers,
> 
> 
> Brett
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/


Well, the issue was with host to guest right?
Then testing what does bql do might be interesting.
Might help.
Something like this? Lightly tested.


diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bfa49fa9e3a1..abc46354c107 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1076,6 +1076,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	queue = netdev_get_tx_queue(dev, txq);
 
 	spin_lock(&tfile->tx_ring.producer_lock);
+	netdev_tx_sent_queue(queue, len);
 	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
 	if (!qdisc_txq_has_no_queue(queue) &&
 	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
@@ -1088,6 +1089,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock(&tfile->tx_ring.producer_lock);
 
 	if (ret) {
+		netdev_tx_completed_queue(queue, 1, len);
 		/* This should be a rare case if a qdisc is present, but
 		 * can happen due to lltx.
 		 * Since skb_tx_timestamp(), skb_orphan(),
@@ -2148,15 +2150,19 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 /* Callers must hold ring.consumer_lock */
 static void __tun_wake_queue(struct tun_struct *tun,
-			     struct tun_file *tfile, int consumed)
+			     struct tun_file *tfile,
+			     unsigned int pkts, unsigned int bytes)
 {
 	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
 						tfile->queue_index);
 
+	if (bytes)
+		netdev_tx_completed_queue(txq, pkts, bytes);
+
 	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
 	smp_mb();
 	if (netif_tx_queue_stopped(txq)) {
-		tfile->cons_cnt += consumed;
+		tfile->cons_cnt += pkts;
 		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
 		    __ptr_ring_empty(&tfile->tx_ring)) {
 			netif_tx_wake_queue(txq);
@@ -2167,12 +2173,16 @@ static void __tun_wake_queue(struct tun_struct *tun,
 
 static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
 {
+	unsigned int bytes = 0;
 	void *ptr;
 
 	spin_lock(&tfile->tx_ring.consumer_lock);
 	ptr = __ptr_ring_consume(&tfile->tx_ring);
-	if (ptr)
-		__tun_wake_queue(tun, tfile, 1);
+	if (ptr) {
+		if (!tun_is_xdp_frame(ptr))
+			bytes = ((struct sk_buff *)ptr)->len;
+		__tun_wake_queue(tun, tfile, 1, bytes);
+	}
 
 	spin_unlock(&tfile->tx_ring.consumer_lock);
 	return ptr;
@@ -3805,7 +3815,7 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
 EXPORT_SYMBOL_GPL(tun_get_tx_ring);
 
 /* Callers must hold ring.consumer_lock */
-void tun_wake_queue(struct file *file, int consumed)
+void tun_wake_queue(struct file *file, unsigned int pkts, unsigned int bytes)
 {
 	struct tun_file *tfile;
 	struct tun_struct *tun;
@@ -3821,7 +3831,7 @@ void tun_wake_queue(struct file *file, int consumed)
 
 	tun = rcu_dereference(tfile->tun);
 	if (tun)
-		__tun_wake_queue(tun, tfile, consumed);
+		__tun_wake_queue(tun, tfile, pkts, bytes);
 
 	rcu_read_unlock();
 }
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index db341c922673..5267b323bd59 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -181,14 +181,23 @@ static int vhost_net_buf_produce(struct sock *sk,
 {
 	struct file *file = sk->sk_socket->file;
 	struct vhost_net_buf *rxq = &nvq->rxq;
+	unsigned int bytes = 0;
+	int i;
 
 	rxq->head = 0;
 	spin_lock(&nvq->rx_ring->consumer_lock);
 	rxq->tail = __ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
 					       VHOST_NET_BATCH);
 
-	if (rxq->tail)
-		tun_wake_queue(file, rxq->tail);
+	if (rxq->tail) {
+		for (i = 0; i < rxq->tail; i++) {
+			void *ptr = rxq->queue[i];
+
+			if (!tun_is_xdp_frame(ptr))
+				bytes += ((struct sk_buff *)ptr)->len;
+		}
+		tun_wake_queue(file, rxq->tail, bytes);
+	}
 
 	spin_unlock(&nvq->rx_ring->consumer_lock);
 	return rxq->tail;
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 5f3e206c7a73..49b85bf4f828 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -22,7 +22,7 @@ struct tun_msg_ctl {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
-void tun_wake_queue(struct file *file, int consumed);
+void tun_wake_queue(struct file *file, unsigned int pkts, unsigned int bytes);
 
 static inline bool tun_is_xdp_frame(void *ptr)
 {
@@ -56,7 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 	return ERR_PTR(-EINVAL);
 }
 
-static inline void tun_wake_queue(struct file *f, int consumed) {}
+static inline void tun_wake_queue(struct file *f,
+				  unsigned int pkts, unsigned int bytes) {}
 
 static inline bool tun_is_xdp_frame(void *ptr)
 {


