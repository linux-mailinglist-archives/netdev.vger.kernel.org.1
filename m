Return-Path: <netdev+bounces-259059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKr8FNt+lGmnFAIAu9opvQ
	(envelope-from <netdev+bounces-259059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:44:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E78BA14D431
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35FF303D664
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBDF36C584;
	Tue, 17 Feb 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i528Wg91";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXsARvan"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18733372D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339449; cv=none; b=H/nDTypNpBztJXXPKDkSmaWGiIZKm7Q00wZ75aVl1gmCw+phmgIsn40MQH03U+QIsfdu/wonxoPaiXiBlkZhNy350crqj/pRPqyH2M8BOC5D2xfvlyzqQm1n/tLwhVbGpG9FlC/Cegfd1mGrY2JvKhnYgTPCAJdwtz4dH/9FwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339449; c=relaxed/simple;
	bh=rSLvWPDU/D7bC63EuOP4KRlL2TySHGb/lghhtL7NpmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtrxWw3EopeEfFRv9k8PoUShx3IKCZqGWWtBI7tgqZ394vQltz6rELsmKz+zQraUnnuZDp3zQVHRQUCpqcaNf5sjZGr5JefVQcJAEFSnQK5NDWl10S+yuj9CNjnzxiRh1+dkvchiWhUxgxZCmv4OKi32LqsAJymzw4qIVJBVIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i528Wg91; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXsARvan; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 15:44:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771339446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnTVUPXIybIY/Hjz9QRQhHyyRBgJ5JgIBQoZkunP6ts=;
	b=i528Wg915RaKHtg4XD9AIH/ASeHfP1PwB8lnvUTsNBN/lDiKvlvLjmoO2EXMC/O0Np55Jy
	QOxoNkvyYt/Fn1aAUM5wZD80Fz5RRIXg1ucGsjCYFhPhhz3Y8rqw/r3ObacjNELUc62hVi
	NwRuhV36lmuMj0i8QQoxF7VQUEx9IgmlQQv/hKj8X39uH1VP7fiWiLwFYcrKpb/P2FLGzK
	vt6V3x5JhtmUKwyXAY+PX3WeQyLmrbUMxyDQAn6p5ddSHIUkla6PtUAE/DdIvE/vbxU+yM
	Fcsw8GHjs0lfcgqCRV3qIjOrce/ADBI8oe7sSOLbRi6sNIiHxPHNuF8PQnI3fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771339446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnTVUPXIybIY/Hjz9QRQhHyyRBgJ5JgIBQoZkunP6ts=;
	b=AXsARvanuRxBVH6knyKL9K+5Gv5jHgqvPMqQ2/evZ90bUjXjFdtRzuMi6wBqX9EvSVG6Jq
	xIdwzEXdL6b2h6Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260217144404.qTWlJBxw@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
 <CAL+tcoAN_T8c4z5wN82FD-skyY=gJedX5X4VK=QDaQWz0isocg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL+tcoAN_T8c4z5wN82FD-skyY=gJedX5X4VK=QDaQWz0isocg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259059-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: E78BA14D431
X-Rspamd-Action: no action

On 2026-02-17 15:48:11 [+0800], Jason Xing wrote:
> Hi Sebastian,
Hi,

> > sock_alloc() allocates a struct socket_alloc which contains the struct
> > socket and struct inode (sock_alloc_inode()). This the sk_socket in
> > struct sock. Once you close the socket via the close syscall and the
> > last reference is gone then you end up in __fput(). The invoked
> > ->release() callback is sock_close(). Here socket::file gets NULLed and
> > proto::release should sock_orphan() the sock where sock::sk_socket gets
> > NULLed (I don't see where else and packet_release() does so). The
> > "struct sock" remains around because the skb has a reference on.
> > Otherwise it would go, too.
> 
> If skb still exists, there is no way to do the real destruction of its
> socket, at least I know it works for TCP. That means IIUC TCP doesn't
> have such an issue?

There is struct sock and struct socket. socket will be removed once the
fd goes. sock remains until the last skb is gone.

> I roughly know what you meant here, but still wondering if you can
> provide a specific call trace or case where the socket using socket
> timestamping feature leads to this NULL-pointer problem?

So assuming we delay the timestamp delivery and as soon as ptp4l
complains, we kill it. Then we see this on ptp4l's side:
| ptp4l[89.480]: port 1 (enp4s0): delay timeout
| ptp4l[89.490]: timed out while polling for tx timestamp
| ptp4l[89.490]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
|CTRL-C

and delay delivery in igc:

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 89a321a344d2..5bfd4a442b16 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1546,6 +1546,7 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
 		if (tstamp->skb)
 			continue;
 
+		trace_printk("skb %px dest %pS\n", skb, skb->destructor);
 		tstamp->skb = skb_get(skb);
 		tstamp->start = jiffies;
 		*flags = tstamp->flags;
@@ -5563,6 +5564,21 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
+struct delayed_ptp {
+	struct delayed_work dw;
+	struct igc_adapter *adapter;
+};
+
+static void delayed_ts(struct work_struct *work)
+{
+	struct delayed_ptp *dtp = container_of(work, struct delayed_ptp, dw.work);
+
+	/* retrieve hardware timestamp */
+	trace_printk("\n");
+	igc_ptp_tx_tstamp_event(dtp->adapter);
+	kfree(dtp);
+}
+
 static void igc_tsync_interrupt(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -5579,8 +5595,15 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 	}
 
 	if (tsicr & IGC_TSICR_TXTS) {
-		/* retrieve hardware timestamp */
-		igc_ptp_tx_tstamp_event(adapter);
+		struct delayed_ptp *dtp;
+
+		dtp = kmalloc(sizeof(*dtp), GFP_ATOMIC);
+		if (dtp) {
+			INIT_DELAYED_WORK(&dtp->dw, delayed_ts);
+			dtp->adapter = adapter;
+			trace_printk("\n");
+			schedule_delayed_work(&dtp->dw, HZ * 10);
+		}
 	}
 
 	if (tsicr & IGC_TSICR_TT0) {

and few more in net/, I end up with:

|          ptp4l-745     [005] .....    88.609323: packet_create: sock ffff8ba689e28680 sk ffff8ba6822f8800
|          ptp4l-745     [005] .....    88.609325: sock_alloc_file: sock ffff8ba689e28680 sk ffff8ba6822f8800 file ffff8ba689575d80
socket allocation

|         <idle>-0       [004] dNh1.    89.645405: igc_tsync_interrupt:
TX TS delayed

|          ptp4l-745     [005] .....    89.655483: __sock_release: packet_release+0x0/0x490 sock ffff8ba689e28680, file is NULL
|          ptp4l-745     [005] .....    89.655484: packet_release: sock ffff8ba689e28680 sk ffff8ba6822f8800
|          ptp4l-745     [005] .....    89.669111: packet_release: gone ffff8ba689e28680

ptp4l closed socket, sock->sk = sk->sk_socket = NULL.

|    kworker/0:1-11      [000] .....    99.769061: delayed_ts:
The worked kicked in

|    kworker/0:1-11      [000] d..1.    99.769068: __skb_tstamp_tx: sk ffff8ba6822f8800 socket 0000000000000000
the NULL socket.

|    kworker/0:1-11      [000] d..1.    99.769070: __skb_complete_tx_timestamp: added to ffff8ba6822f8800
|    ksoftirqd/0-14      [000] ..s..    99.769081: __sk_destruct: sk ffff8ba6822f8800
|    ksoftirqd/0-14      [000] ..s..    99.769082: packet_sock_destruct: sk ffff8ba6822f8800

This is the RCU free of sock after the skb was released.

Does this make sense?

> Thanks,
> Jason

Sebastian

