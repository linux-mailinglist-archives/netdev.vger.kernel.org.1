Return-Path: <netdev+bounces-281066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAt2GwHx62nWTAAAu9opvQ
	(envelope-from <netdev+bounces-281066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:38:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D885F463D62
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67E5F302B525
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083035F5F2;
	Fri, 24 Apr 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="FKY6UCyJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="Oq57a5Ad"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf117.lhr1.oracleemaildelivery.com (acj35aaf117.lhr1.oracleemaildelivery.com [130.35.116.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F6346773
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070320; cv=none; b=IkOQnVWgCdqIiZHMwexRg+T378Of2GGo3CgytjnheYjXeNyvHKrYdb9chf9a65jbHqqWObFH01Mz694GHDQnDDGOuQ59eODQanAIkB3+KmPh/156K/yMT7szGSpyd5TM0SOxEPlTsEE79VPvnpT+e88/Njh6uytrl3aW3iBnavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070320; c=relaxed/simple;
	bh=zrEaQXJOnRtTwiX8P7n+eoTvFGca0wOSI8W/6X0TFgs=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=lDO9DqxGB0BVRcAFvgogelxQkM4nRStG4+PLAY9B+RxHXQf+onSyH0e4kzOOROtrGelLrSGWgAdI2MHDHxoRZFk4niPbiBzjap3FIr247XEANY2C1vdbzQa+WkJU+DKPoSCV8YMz/BAs2M0sNOHAdrng7sJO30cr3Mu6qeDxOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=FKY6UCyJ; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=Oq57a5Ad; arc=none smtp.client-ip=130.35.116.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=GnmvqSve67mSROwu3/beMnE8wPFOEh4SB0WFOJvTNDI=;
 b=FKY6UCyJZZ/luMAgMHPW9Njr9rnkAtaw/lF1i5j1/7iHEoMy1yJcDXlMKdYPd7FD1T6VEKMY0/Fr
   rfwbYXR2uuwVlp0C5MYKMl7q2J2h2aaKSqCPfhI3lX9fXPbDIVg0425c+LRZLinE+KUSOP3uxV7c
   kStRj7LDLv6qY/ze3VmVAKmT++u/Siw7nnIx2l87nfksJ2+FmfktiHuib/7mg69Nnuz3DlEBedtJ
   rxStQwXdjFT6dEM6uJtn8FYkVk3+JMgEn+Zg+6blcMpkysHx01RkL6sfJ+IM1zG6bGlyaHQWVUpw
   a58AgMAY/L7hFO6oB8H6N1JUwI5g/llzgP+94g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=GnmvqSve67mSROwu3/beMnE8wPFOEh4SB0WFOJvTNDI=;
 b=Oq57a5AddkgtJldue3aL29TW2evaaHPLhLGIZLsa5hi9NxpVfLg2ZMub3GxWQzPc3pNTmFTu7dQQ
   pv3xiy9p1RW7ZwY0GhFf4IY1EH7zL+LNmHP9N6vvv0zwV51AizuU5ObE97OafwlQNXMEFNuSMovE
   TfhAin9IGM1xQR2VVdpALeabOK+LJnpUjWlhMC37LblPtKG038LJQfOeIdajrMzu3j9Vr+mIqUet
   v+ramGeKqCS2o+YWvlftG76NaaBo3I3Mvs/ypy64hyaXacehSTFMZvLUJhyqcO6I7zVlB5xnpeV2
   KTpzFAR5nx50o1ONOOCwzGp7ky11EQVANudDGQ==
Received: by omta-ad3-fd2-401-uk-london-1.omtaad3.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TE00024FS8AJF80@omta-ad3-fd2-401-uk-london-1.omtaad3.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 24 Apr 2026 22:38:35 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH net-next 3/3] net: macb: add TX stall watchdog as
 defence-in-depth safety net
Date: Fri, 24 Apr 2026 23:38:33 +0100
Message-id:
 <c0469642f42ada85d91a8a685eb7c0e04cb99131.1777064117.git.lukasz@raczylo.com>
X-Mailer: git-send-email 2.53.0
In-reply-to: <cover.1777064117.git.lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFzDiYTuS9jvqSCDQoXiqVnkU2yDl7DFh57yZB8VktRLO86c1eFyO5ekvNWCLwV
 PHyd9gw8WA5srfV/TRAb0XPcqN0ckK5QcJLip4IUF21Eocg6OwUPltPJrq9RIbOD
 4+z9vED4Ay96BtR1GJd5RgiYuG39BqApAkXu83Cn92EArqPSe6ZDwDBXhwfxWd4b
 C5z06k+p1AI8Ke6pZhjxbIHTyOacua9ARDtC/w4DNM+Xef1soA/JcJCFuvqdmyYc
 iGpke1lDidE6fs48cPmNEo+vbODYSGXjlR7KTErshP5Q2DyAEpd/GgOGme7A2JF/
 tyQgyuug2q2P7TdpqcnhBTXq9fvI00sjGo1WxjuVybhgY7Ylhlo053ojkzgj8hhg
 V0Eoj9uaAoAv7Xk/4ARVRDvjiwHi9jns8FPvHmXgxsIyt+t83Eny5+gBVCh5
X-Rspamd-Queue-Id: D885F463D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-281066-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	NEURAL_HAM(-0.00)[-0.787];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,raczylo.com:mid,raczylo.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Patches 1/3 and 2/3 address two candidate races that could lead
to a TCOMP completion being missed on PCIe-attached macb
instances.  This patch adds a defence-in-depth safety net, in
case a further race remains that we have not identified.

The watchdog is a per-queue delayed_work that runs once per
second.  It snapshots queue->tx_tail; if the ring is non-empty
(queue->tx_head != queue->tx_tail) and tx_tail has not advanced
since the previous tick, it calls macb_tx_restart().

No new recovery logic is introduced.  macb_tx_restart() already
exists in this file, is correctly locked (tx_ptr_lock, bp->lock),
and verifies that the hardware's TBQP is behind the driver's
head index before re-asserting TSTART.  On a healthy ring it is
a no-op at the hardware level; the watchdog only supplies the
missing trigger.

On a healthy queue the per-tick cost is one spin_lock_irqsave()
/ spin_unlock_irqrestore() and one branch.  The delayed_work is
only scheduled between macb_open() and macb_close(), and is
cancelled synchronously on close.

Context for submission: on our 24-node Raspberry Pi 5 fleet,
before this series, an out-of-band user-space watchdog
(monitoring tx_packets from /sys/class/net/.../statistics and
toggling the link down/up when it froze) was required to keep
nodes usable.  We include this kernel-side watchdog as a cleaner
in-kernel equivalent for any residual stall that patches 1 and
2 do not cover.  We are willing to drop this patch if the view
is that 1 and 2 should stand alone.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb.h      |  5 ++
 drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017e..9115f2b47 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1278,6 +1278,11 @@ struct macb_queue {
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
+
+	/* TX stall watchdog -- see macb_tx_stall_watchdog() in macb_main.c */
+	struct delayed_work	tx_stall_watchdog_work;
+	unsigned int		tx_stall_last_tail;
+
 	struct napi_struct	napi_tx;
 
 	dma_addr_t		rx_ring_dma;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ea231b1c5..ea2306ef7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2002,6 +2002,59 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+#define MACB_TX_STALL_INTERVAL_MS	1000
+
+/*
+ * TX stall watchdog.
+ *
+ * Defence-in-depth against lost TCOMP interrupts.  macb already has a
+ * recovery chain (tx_pending -> txubr_pending -> macb_tx_restart())
+ * that fires on TCOMP; if TCOMP itself is lost the TX ring stalls
+ * silently until something else kicks TSTART.  This watchdog runs
+ * once per second per queue, snapshots tx_tail, and calls
+ * macb_tx_restart() if the ring is non-empty and tx_tail has not
+ * advanced since the previous tick.
+ *
+ * macb_tx_restart() already checks the hardware's TBQP against the
+ * driver's head index before re-asserting TSTART, so on a healthy
+ * ring this is a no-op at the hardware level.  The watchdog only
+ * adds the missing trigger.
+ */
+static void macb_tx_stall_watchdog(struct work_struct *work)
+{
+	struct macb_queue *queue = container_of(to_delayed_work(work),
+						struct macb_queue,
+						tx_stall_watchdog_work);
+	struct macb *bp = queue->bp;
+	unsigned int cur_tail, cur_head;
+	bool stalled = false;
+	unsigned long flags;
+
+	if (!netif_running(bp->dev))
+		return;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	cur_tail = queue->tx_tail;
+	cur_head = queue->tx_head;
+	if (cur_head != cur_tail &&
+	    cur_tail == queue->tx_stall_last_tail)
+		stalled = true;
+	else
+		queue->tx_stall_last_tail = cur_tail;
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
+
+	if (stalled) {
+		netdev_warn_once(bp->dev,
+				 "TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
+				 (unsigned int)(queue - bp->queues),
+				 cur_tail, cur_head);
+		macb_tx_restart(queue);
+	}
+
+	schedule_delayed_work(&queue->tx_stall_watchdog_work,
+			      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
+}
+
 static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
@@ -3190,6 +3243,9 @@ static int macb_open(struct net_device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
+		queue->tx_stall_last_tail = queue->tx_tail;
+		schedule_delayed_work(&queue->tx_stall_watchdog_work,
+				      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
 	}
 
 	macb_init_hw(bp);
@@ -3240,6 +3296,7 @@ static int macb_close(struct net_device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
+		cancel_delayed_work_sync(&queue->tx_stall_watchdog_work);
 		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
@@ -4802,6 +4859,8 @@ static int macb_init_dflt(struct platform_device *pdev)
 		}
 
 		INIT_WORK(&queue->tx_error_task, macb_tx_error_task);
+		INIT_DELAYED_WORK(&queue->tx_stall_watchdog_work,
+				  macb_tx_stall_watchdog);
 		q++;
 	}
 
-- 
2.53.0


