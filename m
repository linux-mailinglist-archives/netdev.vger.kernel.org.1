Return-Path: <netdev+bounces-286300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLrKDtqhAGqTLAEAu9opvQ
	(envelope-from <netdev+bounces-286300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B1504C67
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C443013723
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B13A169E;
	Sun, 10 May 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="U5KUi7ac"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3139E19C;
	Sun, 10 May 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426277; cv=none; b=dX8L7OwRO4H4jhJpUdEww5Abf3ciIqgTuBD3aXDxLijhTd85GVdUFyVSrHtbvV6UPmspBdcPWGYmrx7S7dIH9BB1n5QQUP+2LssBy0M0WjST04odfcA8vktWuiJVZ9hlbt2svnZwD5P9fF59Vgp0+5xgkmrfJkHmJJzh3wxdLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426277; c=relaxed/simple;
	bh=Vy7iPcU6h0IBTmamxg16YIZGUkfgxD2PzxMOQTuNbMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6Y43jYXUDM055MqTMnca7puEBIU8pgop+nKeHhDfNA3LAXf9nKNIppnCxCq+ctVyvvMQG1F9XA7kvRTJeEorC99addyCJmEVGrtUP1Q/Q8TCOXa2Ogqyh6zIgLSmN09n2faBv5eWU1XOGXrECuq1gYD1oiSCwJ8VQZ+VG6Jcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=U5KUi7ac; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778426258;
	bh=Vy7iPcU6h0IBTmamxg16YIZGUkfgxD2PzxMOQTuNbMI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=U5KUi7acVUG1pECA697Xe5WTE3SEbtvrBN4yTjHN8ziRo4YnQ4fr1aLsPl6/jwDsY
	 Bz6kttjtfiuD94TbTBByJhgVnXbYAj8lQUgLLlTWEyuz23dKBLpp7GGWhm4/9aq3cA
	 L5dDO10a8vu9zenOAodrGZKV6vyuGavwVtM5ZURc=
Received: from simon-Latitude-5450.fritz.box (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AFHaTA009831
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 17:17:38 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v12 1/4] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Sun, 10 May 2026 17:15:26 +0200
Message-ID: <20260510151529.43895-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA5B1504C67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-286300-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
__tun_wake_queue(). The latter wakes the stopped netdev subqueue once
half of the ring capacity has been consumed, tracked via the new
cons_cnt field in tun_file. As a safety net, the queue is also woken on
the last consumed entry if it leaves the ring empty. The point is to
allow the queue to be stopped when it gets full, which is required for
traffic shaping - implemented by the following "avoid ptr_ring tail-drop
when a qdisc is present".

Some implementation details:
- tun_ring_recv() replaces ptr_ring_consume() with tun_ring_consume()
  to properly wake the queue.
- __tun_detach() locks the tx_ring.consumer_lock to avoid races with
  the consumer on the queue_index.
- The ptr_ring_consume() call in tun_queue_purge() is not replaced with
  tun_ring_consume(). Instead, within the same tx_ring.consumer_lock
  in __tun_detach(), the netdev queue is woken for the ntfile taking
  it over, to avoid a possible stall. This does not matter for
  tun_detach_all(), as it is called during device teardown and no tfile
  takes over any queue.
- Reset cons_cnt in tun_attach() so the half-ring wake threshold is
  valid for the new ring size after ptr_ring_resize().
- tun_queue_resize() wakes all queues after resizing with the proper
  tx_ring.consumer_lock and resets the cons_cnt to avoid a possible
  stale queue.
- The aforementioned upcoming patch explains the pairing of the smp_mb()
  of __tun_wake_queue().

Without the corresponding queue stopping, this patch alone causes no
regression for a tap setup sending to a qemu VM: 1.132 Mpps
to 1.134 Mpps.

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..3dded7c7d12d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,6 +145,8 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	/* Protected by tx_ring.consumer_lock */
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -588,8 +590,13 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		rcu_assign_pointer(tun->tfiles[index],
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
+		spin_lock(&ntfile->tx_ring.consumer_lock);
 		ntfile->queue_index = index;
 		ntfile->xdp_rxq.queue_index = index;
+		ntfile->cons_cnt = 0;
+		if (__ptr_ring_empty(&ntfile->tx_ring))
+			netif_wake_subqueue(tun->dev, index);
+		spin_unlock(&ntfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
@@ -730,6 +737,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
+	spin_lock(&tfile->tx_ring.consumer_lock);
+	tfile->cons_cnt = 0;
+	spin_unlock(&tfile->tx_ring.consumer_lock);
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
 
@@ -2115,13 +2125,46 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+/* Callers must hold ring.consumer_lock */
+static void __tun_wake_queue(struct tun_struct *tun,
+			     struct tun_file *tfile, int consumed)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
+						tfile->queue_index);
+
+	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
+	smp_mb();
+	if (netif_tx_queue_stopped(txq)) {
+		tfile->cons_cnt += consumed;
+		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
+		    __ptr_ring_empty(&tfile->tx_ring)) {
+			netif_tx_wake_queue(txq);
+			tfile->cons_cnt = 0;
+		}
+	}
+}
+
+static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
+{
+	void *ptr;
+
+	spin_lock(&tfile->tx_ring.consumer_lock);
+	ptr = __ptr_ring_consume(&tfile->tx_ring);
+	if (ptr)
+		__tun_wake_queue(tun, tfile, 1);
+
+	spin_unlock(&tfile->tx_ring.consumer_lock);
+	return ptr;
+}
+
+static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
+			   int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	void *ptr = NULL;
 	int error = 0;
 
-	ptr = ptr_ring_consume(&tfile->tx_ring);
+	ptr = tun_ring_consume(tun, tfile);
 	if (ptr)
 		goto out;
 	if (noblock) {
@@ -2133,7 +2176,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2170,7 +2213,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3622,6 +3665,16 @@ static int tun_queue_resize(struct tun_struct *tun)
 					  dev->tx_queue_len, GFP_KERNEL,
 					  tun_ptr_free);
 
+	if (!ret) {
+		for (i = 0; i < tun->numqueues; i++) {
+			tfile = rtnl_dereference(tun->tfiles[i]);
+			spin_lock(&tfile->tx_ring.consumer_lock);
+			netif_wake_subqueue(tun->dev, tfile->queue_index);
+			tfile->cons_cnt = 0;
+			spin_unlock(&tfile->tx_ring.consumer_lock);
+		}
+	}
+
 	kfree(rings);
 	return ret;
 }
-- 
2.43.0


