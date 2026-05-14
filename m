Return-Path: <netdev+bounces-288087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPIDHXlGBmo3hwIAu9opvQ
	(envelope-from <netdev+bounces-288087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:02:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E75474D9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E8F303AFA3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD53D1CA5;
	Thu, 14 May 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="Ng9HiP6Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="1b4ILIQw"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf118.lhr1.oracleemaildelivery.com (acj35aaf118.lhr1.oracleemaildelivery.com [130.35.116.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D43D0BF6
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795703; cv=none; b=ICVRor+PHvCjWIaBdRwutse3O/ENLimv+KpYBmNcJwqbVBCb3JgxB8cqbkO/0m0B5HjMgxDhctyY6jCVT4swmVBe23GUQ/qbEzef3FnJi0ujQSEN0iUzDRVQ4yvJgfajB31qs9QFsoHJYl/LexQ/i9biBPj3alYH/c2levkkwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795703; c=relaxed/simple;
	bh=hjqTGOSRTsvyFi96iTPVeEMiFJQRH9CDDZHee5KQ090=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=VS0HELmX2kS9K/n7jgpgTFkaPyBHISc4q4DaHk0Hl8OO0xujly8wKoM8+4ms84zvcyCJCzy2s33qc7i0s/6czsjh2IqXlU+CXDEY4FWhlVUWstRPGZfyzS0/M+BfP0xtvIH2sjGmzyOR1EBqCAh3d5j0hUFvb4dpWzIUcRmGYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=Ng9HiP6Y; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=1b4ILIQw; arc=none smtp.client-ip=130.35.116.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=tv8aCOtDxJxEXVixI/3l1McdtDLsb1UTPzit6MpIk3Q=;
 b=Ng9HiP6YAXzJuBcjL/htI6kYUtgsF6o8cp1XXQto6wDoNKr3spbgHBDlfF+rLMHxmsidWPMHSK+J
   uoC1SOrAuSo/BpmXhDQ3ThXusyAuk1C6FGdoweU0mHsnwpYhRY0zGSbsfHevuscad9ZtpJzIiu7X
   loeQrvJ8Qhci+5d+H8VsJtBqGjFPgWuHcQfuwiGy5YGgG5wmpSAIOijBfrABayFVDcf0E26oN7HH
   ZFiBSMLjJZelY2OKFzhCt2n0w3UGs8+4/KmvMjO6X9H3gN5AVaTYHU1n377VzZqvdKB7dJoR6amA
   bSAapR4mwTfzdrt4x4br6+F4scp/97nd2sP8kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=tv8aCOtDxJxEXVixI/3l1McdtDLsb1UTPzit6MpIk3Q=;
 b=1b4ILIQwtUDXkJ55CoZlzWTaPbyPetV+MI5vCX4iUBq6CRndZaKtsN40OEkJNcSwCsFtJURpYK0Z
   BVnjRF453HkY+6L52XjpU0PRlKmccWHaNvkgHK6LJL4mUUcbQ7vGf1wOFngciukjh6o05j+Cd1RK
   LM248yBp8yNliMUtHkjPSqPODNbZQdgtMiSoc6KYZXN/LGY0QXMH7Myh7PmtZvtFNyO0RPCyxNZ8
   mAMW3NV70XdbztNLxu8OBTj06UJKISCojhph4RPy952A2QdvUfJ3HwfLzan8CnlaYS74DO/u2cCb
   0fq5jz632KZgoJXnSGZTl1k9yCS42aYBqjQaIA==
Received: by omta-ad3-fd1-1402-uk-london-1.omtaad3.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF1045AFRJPCD60@omta-ad3-fd1-1402-uk-london-1.omtaad3.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Thu, 14 May 2026 21:55:01 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH net-next v2 3/3] net: macb: add TX stall watchdog to recover
 from lost TCOMP interrupts
Date: Thu, 14 May 2026 22:54:59 +0100
Message-id: <20260514215459.36109-4-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <20260514215459.36109-1-lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHf+Z0YX8zBMsksb6gSGL9ZV3VCbo9am2PhbSO1iipMaVnbSZPP4U7YWpbXzRHK
 g669lhZ1JQctwueluqmOYAuNG1sS6Qw9c22ExjCMg3z9O/REMp2eI4Y5hPDVkMNp
 uclZO21YYxY80Z9NssdyVaz8vJOP5AT52CqkCEaJJJ5+8jLS96LEQElS6e2+drv0
 LtvtLFiihHusUv9GYjCJTc+lacpFKcQ1x/WaIAoM5Uu9piaWHdYNmCqs24lx38r+
 bp+CshRZwIhV9sIo0TNcxG7Vk1z4lulQarVDBE3juoMZkv+iwA8ZDdckzynQ5sKC
 FviGN4OTtGDreBULVB7uO5FIF6qFI6VtCRFXtXW8fKuu8xlxOJ810AwOAk50SC0F
 4mMc/hBHLeWX8yHkg7vlomv76w3pTGv6ChAxzQaFdON3pmu+cG75xtwNvQvHaQ==
X-Rspamd-Queue-Id: 0F6E75474D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288087-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.937];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,raczylo.com:email,raczylo.com:mid,launchpad.net:url]
X-Rspamd-Action: no action

On PCIe-attached macb instances (BCM2712 + RP1 PCIe south bridge
on Raspberry Pi 5 is the case I have in front of me), a TCOMP
interrupt can be lost: the TSTART doorbell can be lost in the
posted-write fabric (addressed by an earlier patch), or the
descriptor TX_USED DMA write can be observed late by the driver
(also addressed earlier).  When that happens the TX ring stalls
silently until something else kicks TSTART.

Add a per-queue delayed_work that runs once per second.  It
detects forward progress on the TX completion path via a per-queue
bool tx_stall_tail_moved that macb_tx_complete() sets when tx_tail
advances and the watchdog clears on each tick.  If the ring is
non-empty (queue->tx_head != queue->tx_tail) and the flag is
unset when the tick runs, the watchdog calls the existing
macb_tx_restart() to re-assert TSTART.

The bool form (rather than a tx_tail snapshot) sidesteps any
concern about ring-index aliasing between ticks and is the form
suggested by Phil Elwell when reviewing the same series anchored
against rpi-6.18.y at raspberrypi/linux#7340 (merged 2026-05-08).

No new recovery logic is introduced.  macb_tx_restart() already
exists in this file, is correctly locked (tx_ptr_lock, bp->lock),
and verifies that the hardware's TBQP is behind the driver's head
index before re-asserting TSTART.  On a healthy ring it is a
no-op at the hardware level.

Cost on a healthy queue: one spin_lock_irqsave / spin_unlock and
two field assignments per tick.  The delayed_work is only
scheduled between macb_open() and macb_close() and is cancelled
synchronously on close.

A netif_carrier_ok() gate at the top of the tick skips the stall
check when there is no carrier (no completion is possible without
a link), eliminating a boot-time false positive where queue->tx_head
can advance from kernel-queued packets between macb_open() and link
autoneg completion, while tx_tail stays unchanged because no TCOMPs
have arrived yet.

netdev_warn_ratelimited() is used rather than netdev_warn_once() so
operators can count occurrences across the lifetime of the netdev.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Link: https://github.com/raspberrypi/linux/pull/7340
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb.h      | 10 ++++
 drivers/net/ethernet/cadence/macb_main.c | 72 ++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ce9037f9e..75df0f75b 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1282,6 +1282,16 @@ struct macb_queue {
 	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
+
+	/* TX stall watchdog -- see macb_tx_stall_watchdog() in macb_main.c.
+	 * tx_stall_tail_moved is set by macb_tx_complete() when tx_tail
+	 * advances and cleared by the watchdog tick on each pass (both
+	 * under tx_ptr_lock).  Using a bool sidesteps any ring-index
+	 * aliasing concern between ticks.
+	 */
+	struct delayed_work	tx_stall_watchdog_work;
+	bool			tx_stall_tail_moved;
+
 	struct napi_struct	napi_tx;
 
 	dma_addr_t		rx_ring_dma;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f7fa9e7ad..8245c69e1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1473,6 +1473,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				  packets, bytes);
 
 	queue->tx_tail = tail;
+	if (packets)
+		queue->tx_stall_tail_moved = true;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
@@ -2003,6 +2005,70 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+#define MACB_TX_STALL_INTERVAL_MS	1000
+
+/*
+ * TX stall watchdog.
+ *
+ * Recovers from lost TCOMP interrupts on PCIe-attached macb
+ * instances.  macb already has a recovery chain
+ * (txubr_pending -> macb_tx_restart()) that fires on TCOMP; if
+ * TCOMP itself is lost the TX ring stalls silently until something
+ * else kicks TSTART.  This watchdog runs once per second per queue
+ * and calls macb_tx_restart() if the ring is non-empty and
+ * tx_tail has not advanced since the previous tick.
+ *
+ * Movement is tracked via the tx_stall_tail_moved boolean rather
+ * than a tx_tail snapshot, sidestepping any ring-index aliasing
+ * concern.  The bool is set by macb_tx_complete() when tx_tail
+ * advances and cleared here on each tick; both writes are under
+ * tx_ptr_lock so no atomic is required.
+ *
+ * macb_tx_restart() already checks the hardware's TBQP against
+ * the driver's head index before re-asserting TSTART, so on a
+ * healthy ring this is a no-op at the hardware level.  The
+ * watchdog only supplies the missing trigger.
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
+	/* No carrier => no completion is possible.  Skip the check
+	 * but keep the watchdog ticking for when carrier comes up.
+	 */
+	if (!netif_carrier_ok(bp->dev))
+		goto reschedule;
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	cur_tail = queue->tx_tail;
+	cur_head = queue->tx_head;
+	if (cur_head != cur_tail && !queue->tx_stall_tail_moved)
+		stalled = true;
+	queue->tx_stall_tail_moved = false;
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
+
+	if (stalled) {
+		netdev_warn_ratelimited(bp->dev,
+					"TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
+					(unsigned int)(queue - bp->queues),
+					cur_tail, cur_head);
+		macb_tx_restart(queue);
+	}
+
+reschedule:
+	schedule_delayed_work(&queue->tx_stall_watchdog_work,
+			      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
+}
+
 static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
@@ -3192,6 +3258,9 @@ static int macb_open(struct net_device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
+		queue->tx_stall_tail_moved = true;
+		schedule_delayed_work(&queue->tx_stall_watchdog_work,
+				      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
 	}
 
 	macb_init_hw(bp);
@@ -3242,6 +3311,7 @@ static int macb_close(struct net_device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
+		cancel_delayed_work_sync(&queue->tx_stall_watchdog_work);
 		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
 	}
 
@@ -4804,6 +4874,8 @@ static int macb_init_dflt(struct platform_device *pdev)
 		}
 
 		INIT_WORK(&queue->tx_error_task, macb_tx_error_task);
+		INIT_DELAYED_WORK(&queue->tx_stall_watchdog_work,
+				  macb_tx_stall_watchdog);
 		q++;
 	}
 
-- 
2.54.0


