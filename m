Return-Path: <netdev+bounces-262735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLY4HSu+pWn8FQAAu9opvQ
	(envelope-from <netdev+bounces-262735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:43:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB01DD1CA
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3750A3022C04
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825C38F654;
	Mon,  2 Mar 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0k1EuqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVax5Apm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EB3E5576
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468797; cv=none; b=Wsc/4iyHCS8VAjq0tZbi92xh735+zOEW3CORgUkqJO3CenC8ThFC4ryF8Bf6IUHNfrLHhfhy7wTIf3ZES87jf7KD/MaaX+o1dPbOYItUVLSJiv8IWkt5FKwOO70GYhHgji389OPXu1xkONY65HUHeLJr/3UPohz1I6r2MZhHVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468797; c=relaxed/simple;
	bh=V3SViL4lPICKN6GU/uI0IFYHB1nXntB22iXJSmlO+9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aI+fL5Lghf2NQtYP9gsxjthu4H0EXcPFH5YhpmabkBMSaojoEpmIQWdDRKWq78EcGKb37j8CjtoA4hI/EyX+fVRAvsUTxPIHssXvTfAkHSZ0UmDsHhGjockpwEioVLoBmGxa1ws1Wfd1wHJfO79i1J+l3D6ts0wWGpOZffYLkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0k1EuqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVax5Apm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Mar 2026 17:26:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772468792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DD7U+cb49ITBgd44g6DXMqTARgAR+Ihq2g4OJp+Mw0M=;
	b=m0k1EuqU1KCcnr4E2FtmILyXKGIotOQz53LxCXZ9wdp7NUuVdCBne+wRDjycjAEHOELzUv
	FwQk81lHlfKr/gmK09YmqlFmqa8jXo1v4BTpZdnpYqw6PLmLj+CUVOEl/1/F9HBnVl4WXn
	W2AszZyc+iG8jgYovgZlf6UBAVZlbXiAK49WnJ5xZIDXNDcj4mRwWGL+jYmif0ILezJtgi
	3OFDWCoC+YeoymatC1XL2o4DshEicHm/587OppY0VlbqX+iRzD7XULO/mnoxyhESQtrTgk
	sdtLmWYfw80MpKI85q1WmUXGk7Dho6td4uIrIu6AvJyrnwGGbL7aYik6UROfkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772468792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DD7U+cb49ITBgd44g6DXMqTARgAR+Ihq2g4OJp+Mw0M=;
	b=KVax5ApmAUaoThxuSEnEVlJ0tlTqmrw6jb89CO+XjH2BV4D+k4VoiDHjj7IaTO0ZMrcJoL
	fKTWwQW322KxB9BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bert Karwatzki <spasswolf@web.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH net] net: Provide a PREEMPT_RT specific check for
 netdev_queue::_xmit_lock
Message-ID: <20260302162631.uGUyIqDT@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: A1AB01DD1CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,web.de,kernel.org,google.com,redhat.com,goodmis.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-262735-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

After acquiring netdev_queue::_xmit_lock the number of the CPU owning
the lock is recorded in netdev_queue::xmit_lock_owner. This works as
long as the BH context is not preemptible.

On PREEMPT_RT the softirq context is preemptible and without the
softirq-lock it is possible to have multiple user in __dev_queue_xmit()
submitting a skb on the same CPU. This is fine in general but this means
also that the current CPU is recorded as netdev_queue::xmit_lock_owner.
This in turn leads to the recursion alert and the skb is dropped.

Instead checking the for CPU number, that owns the lock, PREEMPT_RT can
check if the lockowner matches the current task.

Add netif_tx_owned() which returns true if the current context owns the
lock by comparing the provided CPU number with the recorded number. This
resembles the current check by negating the condition (the current check
returns true if the lock is not owned).
On PREEMPT_RT use rt_mutex_owner() to return the lock owner and compare
the current task against it.
Use the new helper in __dev_queue_xmit() and netif_local_xmit_active()
which provides a similar check.
Update comments regarding pairing READ_ONCE().

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20260216134333.412332-1-spasswolf@web.de
Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 27 ++++++++++++++++++++++-----
 net/core/dev.c            |  5 +----
 net/core/netpoll.c        |  2 +-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a7..67e25f6d15a47 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4711,7 +4711,7 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, cpu);
 }
 
@@ -4729,7 +4729,7 @@ static inline void __netif_tx_release(struct netdev_queue *txq)
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
 }
 
@@ -4738,7 +4738,7 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 	bool ok = spin_trylock(&txq->_xmit_lock);
 
 	if (likely(ok)) {
-		/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+		/* Pairs with READ_ONCE() in netif_tx_owned() */
 		WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
 	}
 	return ok;
@@ -4746,14 +4746,14 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
@@ -4846,6 +4846,23 @@ static inline void netif_tx_disable(struct net_device *dev)
 	local_bh_enable();
 }
 
+#ifndef CONFIG_PREEMPT_RT
+static inline bool netif_tx_owned(struct netdev_queue *txq, unsigned int cpu)
+{
+	/* Other cpus might concurrently change txq->xmit_lock_owner
+	 * to -1 or to their cpu id, but not to our id.
+	 */
+	return READ_ONCE(txq->xmit_lock_owner) == cpu;
+}
+
+#else
+static inline bool netif_tx_owned(struct netdev_queue *txq, unsigned int cpu)
+{
+	return rt_mutex_owner(&txq->_xmit_lock.lock) == current;
+}
+
+#endif
+
 static inline void netif_addr_lock(struct net_device *dev)
 {
 	unsigned char nest_level = 0;
diff --git a/net/core/dev.c b/net/core/dev.c
index c1a9f7fdcffa9..e9ca0b1fd7900 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4818,10 +4818,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	if (dev->flags & IFF_UP) {
 		int cpu = smp_processor_id(); /* ok because BHs are off */
 
-		/* Other cpus might concurrently change txq->xmit_lock_owner
-		 * to -1 or to their cpu id, but not to our id.
-		 */
-		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+		if (!netif_tx_owned(txq, cpu)) {
 			bool is_list = false;
 
 			if (dev_xmit_recursion())
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a8558a52884f9..cd74beffd209c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -132,7 +132,7 @@ static int netif_local_xmit_active(struct net_device *dev)
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
 
-		if (READ_ONCE(txq->xmit_lock_owner) == smp_processor_id())
+		if (netif_tx_owned(txq, smp_processor_id()))
 			return 1;
 	}
 
-- 
2.53.0


