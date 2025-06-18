Return-Path: <netdev+bounces-198866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8FADE10B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2EF189B400
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF218CC1C;
	Wed, 18 Jun 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byoVeCZu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0512E5B;
	Wed, 18 Jun 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750213120; cv=none; b=SoUYm/lEIfPd8K2acVqHfWAK3f1oQIV34dChwYmGB56dSUoGuVE7KweTxXgoLaOYFgkdq+9Ve1rsz7zbjE/hAHPektGyY0GUkM0KfNU7bTOqGTAXC7I4EtrKvV8Ct5Y41gQmFEJGk3r57ak0LpPGqUpu9HsduMzbOHMXxKZ4itM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750213120; c=relaxed/simple;
	bh=FeQphIc5D1myg11vQruSQmO3Z93PdqqImp9iOYt4LXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYmAK9JRqb9qpSGO3f08vcO8OX9rfjpWLwa0djAJG/8rLTr3G3P85dK4RrTnzs+W9sJ+OlRqyf+ScyMq/eBLqIz1iJXRkQ3+0dgyot+Wq09FaZI6r48mRSF3/Vsp1Nz2pA3HJRbnn6MIZacrqwGpYDnWW50L1vboOyOh+SB3OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byoVeCZu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750213119; x=1781749119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FeQphIc5D1myg11vQruSQmO3Z93PdqqImp9iOYt4LXA=;
  b=byoVeCZuDYHFVtLDQatUw0Rzb6CtBFeA5oyXVIg9qYQGcDsRpMYizpld
   ZgPVOYhAphvnKk4KZSEJKWDI3UFRNkFj6ZPwtcm++iixAjpU/XVJ1ofav
   s0iL656Q49cIWaUCFXw7EjRUvgJlgrmVOKBs7gDRabs0lRDLp7JH3TWt6
   YwCOrxL6cBUioY+sQGyW4HdSqadRvExYFF+f24E3O86GojZdvHgEWWV+m
   UahXiWkCnNsjlnqfiPaeCXIiSFLIze7xWF2Zk1HfNtWtOJkrb7hiSTgUs
   s2IX975vlOiyMJP8+mcSRLPCi/Fz1HReVskkOvKST2MvLn23uUz4tMtaY
   w==;
X-CSE-ConnectionGUID: hJPn5559RF2GEpqUwXu6mg==
X-CSE-MsgGUID: qOJyEes4S3CErVtZTxfOdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56217704"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="56217704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 19:18:38 -0700
X-CSE-ConnectionGUID: PVpardVjR1eUwYbuL/jfqg==
X-CSE-MsgGUID: 4lRf095TRCO1+tzLM2P/TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="153918946"
Received: from unknown (HELO CannotLeaveINTEL.bj.intel.com) ([10.238.153.146])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jun 2025 19:18:35 -0700
From: Jun Miao <jun.miao@intel.com>
To: kuba@kernel.org,
	sbhatta@marvell.com,
	oneukum@suse.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev,
	jun.miao@intel.com
Subject: [PATCH v5] net: usb: Convert tasklet API to new bottom half workqueue mechanism
Date: Wed, 18 Jun 2025 01:05:59 -0400
Message-ID: <20250618050559.64974-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the usbnet driver. This transition ensures compatibility
with the latest design and enhances performance.

As suggested by Jakub, we have used the system workqueue to schedule on
(system_bh_wq), so the action performed is usbnet_bh_work() instead of
usbnet_bh_workqueue() to replace the usbnet_bh_tasklet().

Signed-off-by: Jun Miao <jun.miao@intel.com>
---
v1->v2:
    Check patch warning, delete the more spaces.
v2->v3:
    Fix the kernel test robot noticed the following build errors:
    >> drivers/net/usb/usbnet.c:1974:47: error: 'struct usbnet' has no member named 'bh'
v3->v4:
	Keep "GFP_ATOMIC" flag as it is.
	If someone want to change the flags (which Im not sure is correct) it should be a separate commit.

v4->v5:
	As suggested by Jakub, we have used the system workqueue to schedule on(system_bh_wq), 
	replace the workqueue with work in usbnet_bh_workqueue() and the comments.
---
 drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
 include/linux/usb/usbnet.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index c39dfa17813a..234d47bbfec8 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -461,7 +461,7 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
 
 	__skb_queue_tail(&dev->done, skb);
 	if (dev->done.qlen == 1)
-		tasklet_schedule(&dev->bh);
+		queue_work(system_bh_wq, &dev->bh_work);
 	spin_unlock(&dev->done.lock);
 	spin_unlock_irqrestore(&list->lock, flags);
 	return old_state;
@@ -549,7 +549,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 		default:
 			netif_dbg(dev, rx_err, dev->net,
 				  "rx submit, %d\n", retval);
-			tasklet_schedule (&dev->bh);
+			queue_work(system_bh_wq, &dev->bh_work);
 			break;
 		case 0:
 			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
@@ -709,7 +709,7 @@ void usbnet_resume_rx(struct usbnet *dev)
 		num++;
 	}
 
-	tasklet_schedule(&dev->bh);
+	queue_work(system_bh_wq, &dev->bh_work);
 
 	netif_dbg(dev, rx_status, dev->net,
 		  "paused rx queue disabled, %d skbs requeued\n", num);
@@ -778,7 +778,7 @@ void usbnet_unlink_rx_urbs(struct usbnet *dev)
 {
 	if (netif_running(dev->net)) {
 		(void) unlink_urbs (dev, &dev->rxq);
-		tasklet_schedule(&dev->bh);
+		queue_work(system_bh_wq, &dev->bh_work);
 	}
 }
 EXPORT_SYMBOL_GPL(usbnet_unlink_rx_urbs);
@@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
 	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
 	timer_delete_sync(&dev->delay);
-	tasklet_kill(&dev->bh);
+	disable_work_sync(&dev->bh_work);
 	cancel_work_sync(&dev->kevent);
 
 	/* We have cyclic dependencies. Those calls are needed
 	 * to break a cycle. We cannot fall into the gaps because
 	 * we have a flag
 	 */
-	tasklet_kill(&dev->bh);
+	disable_work_sync(&dev->bh_work);
 	timer_delete_sync(&dev->delay);
 	cancel_work_sync(&dev->kevent);
 
@@ -955,7 +955,7 @@ int usbnet_open (struct net_device *net)
 	clear_bit(EVENT_RX_KILL, &dev->flags);
 
 	// delay posting reads until we're fully open
-	tasklet_schedule (&dev->bh);
+	queue_work(system_bh_wq, &dev->bh_work);
 	if (info->manage_power) {
 		retval = info->manage_power(dev, 1);
 		if (retval < 0) {
@@ -1123,7 +1123,7 @@ static void __handle_link_change(struct usbnet *dev)
 		 */
 	} else {
 		/* submitting URBs for reading packets */
-		tasklet_schedule(&dev->bh);
+		queue_work(system_bh_wq, &dev->bh_work);
 	}
 
 	/* hard_mtu or rx_urb_size may change during link change */
@@ -1198,11 +1198,11 @@ usbnet_deferred_kevent (struct work_struct *work)
 		} else {
 			clear_bit (EVENT_RX_HALT, &dev->flags);
 			if (!usbnet_going_away(dev))
-				tasklet_schedule(&dev->bh);
+				queue_work(system_bh_wq, &dev->bh_work);
 		}
 	}
 
-	/* tasklet could resubmit itself forever if memory is tight */
+	/* work could resubmit itself forever if memory is tight */
 	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
 		struct urb	*urb = NULL;
 		int resched = 1;
@@ -1224,7 +1224,7 @@ usbnet_deferred_kevent (struct work_struct *work)
 fail_lowmem:
 			if (resched)
 				if (!usbnet_going_away(dev))
-					tasklet_schedule(&dev->bh);
+					queue_work(system_bh_wq, &dev->bh_work);
 		}
 	}
 
@@ -1325,7 +1325,7 @@ void usbnet_tx_timeout (struct net_device *net, unsigned int txqueue)
 	struct usbnet		*dev = netdev_priv(net);
 
 	unlink_urbs (dev, &dev->txq);
-	tasklet_schedule (&dev->bh);
+	queue_work(system_bh_wq, &dev->bh_work);
 	/* this needs to be handled individually because the generic layer
 	 * doesn't know what is sufficient and could not restore private
 	 * information if a remedy of an unconditional reset were used.
@@ -1547,7 +1547,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
 
 /*-------------------------------------------------------------------------*/
 
-// tasklet (work deferred from completions, in_irq) or timer
+// work (work deferred from completions, in_irq) or timer
 
 static void usbnet_bh (struct timer_list *t)
 {
@@ -1601,16 +1601,16 @@ static void usbnet_bh (struct timer_list *t)
 					  "rxqlen %d --> %d\n",
 					  temp, dev->rxq.qlen);
 			if (dev->rxq.qlen < RX_QLEN(dev))
-				tasklet_schedule (&dev->bh);
+				queue_work(system_bh_wq, &dev->bh_work);
 		}
 		if (dev->txq.qlen < TX_QLEN (dev))
 			netif_wake_queue (dev->net);
 	}
 }
 
-static void usbnet_bh_tasklet(struct tasklet_struct *t)
+static void usbnet_bh_work(struct work_struct *work)
 {
-	struct usbnet *dev = from_tasklet(dev, t, bh);
+	struct usbnet *dev = from_work(dev, work, bh_work);
 
 	usbnet_bh(&dev->delay);
 }
@@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	skb_queue_head_init (&dev->txq);
 	skb_queue_head_init (&dev->done);
 	skb_queue_head_init(&dev->rxq_pause);
-	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
+	INIT_WORK(&dev->bh_work, usbnet_bh_work);
 	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
 	init_usb_anchor(&dev->deferred);
 	timer_setup(&dev->delay, usbnet_bh, 0);
@@ -1971,7 +1971,7 @@ int usbnet_resume (struct usb_interface *intf)
 
 			if (!(dev->txq.qlen >= TX_QLEN(dev)))
 				netif_tx_wake_all_queues(dev->net);
-			tasklet_schedule (&dev->bh);
+			queue_work(system_bh_wq, &dev->bh_work);
 		}
 	}
 
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 0b9f1e598e3a..208682f77179 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -58,7 +58,7 @@ struct usbnet {
 	unsigned		interrupt_count;
 	struct mutex		interrupt_mutex;
 	struct usb_anchor	deferred;
-	struct tasklet_struct	bh;
+	struct work_struct	bh_work;
 
 	struct work_struct	kevent;
 	unsigned long		flags;
-- 
2.43.0


