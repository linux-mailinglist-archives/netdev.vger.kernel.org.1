Return-Path: <netdev+bounces-199119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1543ADF036
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4209D176C0E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C12EE297;
	Wed, 18 Jun 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kyxde150"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6152EE28F;
	Wed, 18 Jun 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258323; cv=none; b=LRnHrJJgLxISjtnINFZZnMjv6dEJM4/yCMNSel+jcsAgC8u8Yy4pfA+Bl8QBb6n+M866NPrCvEkhTYkRiF95TIjEEkgLM9oXs6bQ054s1ZtSdqPqUZIaffrHUyfJ8jqzqJJTeKF5TVwQ2xoGesGq69Dx4c3Za8Je3Gqf/vXZmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258323; c=relaxed/simple;
	bh=ZR0aYzFLYzw8xtKJTwgv2QhyruI/blScqAFzbyXCJRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qwc0ATRkRBC3P12TYMNHY1MalYbE32+T+TAKQDXj63dZR372mmxgcuccY5nFX8IHLbG7FsG+Yfu29FzAQ+2e6xh10ja04z6eH7r5s1uM8Q7gw85wT40B6kxyuTCwqhpJgN6AC3eL/ok9e2ZiH76QiaQMryA2MvDokgsGEmudWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kyxde150; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750258322; x=1781794322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZR0aYzFLYzw8xtKJTwgv2QhyruI/blScqAFzbyXCJRo=;
  b=Kyxde150Sy6mB5L7x9Tx/xfC5yVSs2P1GPE3/BInT/QooYn8FpwcviRH
   O1g6GK05ewTRyDeHF2nDAVMTEuX1YW4X/fFdUGgA+hAkEKcQEx0DHcgNk
   I4HA+CAfyWnV619tRW6M9xf024rPZaH9gJWMImh5ZATHmsW0aFkKX8WbS
   P7KOz8pxYR58LiTHSiMYFPvnu2eKjo9ZAzkFEarY9GEMnmUIVxNxHtDht
   lYv2eqiDplhLnmFQk18a7PcBzVbknCqi8KbKrsKT7xWpCJZyepnw1CMNM
   pg2D0zLnooljVi+hFMvC3343Mw3PYUd/OoLk7aQUJ3jAiUKerDFKANYWF
   w==;
X-CSE-ConnectionGUID: ejFpLlK1SrWgmU/FLAAnkw==
X-CSE-MsgGUID: /Y9fiyT1Svar6POj0ygo+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63906560"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63906560"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:52:01 -0700
X-CSE-ConnectionGUID: cbVYe/VMSBS5k7xHh7+T1g==
X-CSE-MsgGUID: eJMYhv7SQSuJeDYu6iY72Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="180709387"
Received: from unknown (HELO CannotLeaveINTEL.bj.intel.com) ([10.238.153.146])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2025 07:51:59 -0700
From: Jun Miao <jun.miao@intel.com>
To: sbhatta@marvell.com,
	kuba@kernel.org,
	oneukum@suse.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev,
	jun.miao@intel.com
Subject: [PATCH v6] net: usb: Convert tasklet API to new bottom half workqueue mechanism
Date: Wed, 18 Jun 2025 13:39:23 -0400
Message-ID: <20250618173923.950510-1-jun.miao@intel.com>
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
v5->v6:
	Delete the "suggested by" review comments in commit message.

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


