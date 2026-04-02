Return-Path: <netdev+bounces-274558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALuuBFF0zmkpnwYAu9opvQ
	(envelope-from <netdev+bounces-274558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:51:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742C38A092
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB8C30FDF62
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41000344040;
	Thu,  2 Apr 2026 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0w+ZiPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F530DD3C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137342; cv=none; b=KQA2rod4ZZh6QEdmuE/SeYoEHSifaFhtOksds/LiX3d+WQNlD6KlAYvGIB3w2YZNxKdjSqk5SvZpXV+N9xxKPKojxaT7VuPSxyPPTraXnvqv9y0Tuvp182CBJ60WwTscABU4ImmvKSkU9IrhI8HbwaOy60b7Ou9lXk7px6flqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137342; c=relaxed/simple;
	bh=ggbMyFNI4oR5jXTpuMssIaiIJjkIK1Al+TR0Q7cDQ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cut21za2oDiP7k5pLVnz3VIzcUhQ3ul9+5A2GMhCyX5E+yq2W/UscIG/CK3lzBWpyEE+GswQ4yQaQAJKTHT/2fpuTEwVMtdq/J4Dp0S1vLCWo0z+oOiPTc3FMtVVBspnHO2mi+tefScZI9wlRfuolfzquRePMyjLXrWoToSWRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0w+ZiPr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a05c388b27so16359506d6.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137340; x=1775742140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL2fekYDuWvWPoY7tEE3cu+9puC9Reyu9saYkqON9gc=;
        b=B0w+ZiPrn93DUJ7KZUBlZqUKvTpKW4vUl6OC81Y8K+X2Kfz7pjhh24ENomStqH0Ks+
         gjwlR5QepFJI6W+IA19DYjNNB+WGeDJ3HnQjpPW2B5HiXlLmWTUnOhk5TvfTSkEhDFAv
         5wR3XQhWqcpcJ/AY9u+2uLeeFAC06U6YzG0ILaWvoiiu5q9Hi8y9yjClNBhl5/WAYnVj
         HsVFeP6mh04XqkvTLnduC7X6kustcwHi51ibF2DkVfq2+goZgEZPZPu1qtGDSE/Fvab/
         tMnlwnk611xvh2SFzplZc5xQGO5idrsQl0kdpFhxrb6Zy5rbmBjEMUzHTCzdlyb7Yga0
         QOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137340; x=1775742140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QL2fekYDuWvWPoY7tEE3cu+9puC9Reyu9saYkqON9gc=;
        b=CBEHCmCBMDlmDh8ubYgQBXlgWkXqiKE8qyDCd6eCG40TohkOOSYhSc8FcPwSHh2NzB
         SDCJVG/Kd/d5LF5wDsqafHCPd/rq+guUq8tSq+G7XGLhWl8bLQkig4Xq3I5lE2vLzPVQ
         LkzN5mAe85OQTTWPyasSCzgDND6dYS/Ab7znnE1GRipiWfIrZaknjvyZAjXaljnSHikt
         lNNH/x7Wfye373dnnrF3Vc0QMQcN5J56ZmD7wU6zWjJb/cdmjT1/lxOmRyl1deXCGwoC
         CQOid3OxsJ1XsZA5nEG9b3VhIr99AZ1AhQbA3g5eE0Vb77Weg9Zy2apYSLAmA9PJqoUV
         HWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG+YcBNNH8/aY9fccLYUePzUGA6dUK5sk8xxq9SGLmElv1FABq45/JYoGtevnD2yTPtgWHQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0mTHY4Pc88PQihxV3Ep7XfNhZs6mBXUDTYHgP7YRQ5PB8M6a
	gSZ8bax0Kw8BNX5tTR3yP/CMNHMyMIxL71wn8um9+xVMFA+epY14YcJF
X-Gm-Gg: AeBDiettT1pWbU97oDwPND+5SEULx+4nDKiS8YfRSSYoyM/o6Jyz1uhlss0L7V2Rq7U
	tHpH7A43Xf0/OFJy8RrQpdxKBJLPiz0IxQL3c2nR/hWrGDtaf4WJolW+kcRXgGRlKzfdO/mpwIa
	9MPlnfFBRMlTtrF5PFa4nTU2ge49Nb8rWnGP7ej8oFRW4qtLuDiFQRHcD8q/17zLc6Gzv/i+t40
	SnCD3jTtLpZcdWhTWp89w5wfh6zVnXpnAGVtjil9qpHs9yGFDJUeHNJE/TrVtmvohbsi0xqx3+X
	Pg0k7fFDrUeK4S9NSkrYLHrus9eXt8Iqjwu3bbRRxCK/XwY6J3uDLaAefxe67QbDO5eIC7kgX/V
	ArBtUhIsRc7GCkrlq4+82M8XSzwWX4reFHh7omj6oUucKVeYOBU3ElCT8rddC78NewTDixWmBnW
	N2K5vM24IoceZSBrex4mWnaH4Hj7d8Nq+N
X-Received: by 2002:a05:6214:3316:b0:89c:de0e:263b with SMTP id 6a1803df08f44-8a439b98c26mr99279426d6.42.1775137339433;
        Thu, 02 Apr 2026 06:42:19 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm22636786d6.16.2026.04.02.06.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:42:19 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 02 Apr 2026 21:41:25 +0800
Subject: [PATCH net-next v2 4/4] net: macb: Remove dedicated IRQ handler
 for WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-macb-irq-v2-4-942d98ab1154@gmail.com>
References: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
In-Reply-To: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274558-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd-zynqmp:email]
X-Rspamd-Queue-Id: 7742C38A092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the current implementation, the suspend/resume path frees the
existing IRQ handler and sets up a dedicated WoL IRQ handler, then
restores the original handler upon resume. This approach is not used
by any other Ethernet driver and unnecessarily complicates the
suspend/resume process. After adjusting the IRQ handler in the previous
patches, we can now handle WoL interrupts without introducing any
overhead in the TX/RX hot path. Therefore, the dedicated WoL IRQ
handler is removed.

I have verified WoL functionality on my AMD ZynqMP board using the
following steps:
  root@amd-zynqmp:~# ifconfig end0 192.168.3.3
  root@amd-zynqmp:~# ethtool -s end0 wol a
  root@amd-zynqmp:~# echo mem >/sys/power/state

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 112 ++++++++-----------------------
 1 file changed, 27 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 98da191a2428b471ff9ac54e1f24beb3a882c546..a4961abb95ae7fa2e40e61b5a8f0da5a83572131 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -71,7 +71,8 @@ struct sifive_fu540_macb_mgmt {
 					| MACB_BIT(TXUBR))
 
 #define MACB_INT_MISC_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(RXUBR) | \
-				 MACB_BIT(ISR_ROVR) | MACB_BIT(HRESP))
+				 MACB_BIT(ISR_ROVR) | MACB_BIT(HRESP) | \
+				 GEM_BIT(WOL) | MACB_BIT(WOL))
 
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
@@ -2025,60 +2026,30 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_start_all_queues(dev);
 }
 
-static irqreturn_t macb_wol_interrupt(int irq, void *dev_id)
+static void macb_wol_interrupt(struct macb_queue *queue, u32 status)
 {
-	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
-	u32 status;
 
-	status = queue_readl(queue, ISR);
-
-	if (unlikely(!status))
-		return IRQ_NONE;
-
-	spin_lock(&bp->lock);
-
-	if (status & MACB_BIT(WOL)) {
-		queue_writel(queue, IDR, MACB_BIT(WOL));
-		macb_writel(bp, WOL, 0);
-		netdev_vdbg(bp->dev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
-			    (unsigned int)(queue - bp->queues),
-			    (unsigned long)status);
-		macb_queue_isr_clear(bp, queue, MACB_BIT(WOL));
-		pm_wakeup_event(&bp->pdev->dev, 0);
-	}
-
-	spin_unlock(&bp->lock);
-
-	return IRQ_HANDLED;
+	queue_writel(queue, IDR, MACB_BIT(WOL));
+	macb_writel(bp, WOL, 0);
+	netdev_vdbg(bp->dev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
+		    (unsigned int)(queue - bp->queues),
+		    (unsigned long)status);
+	macb_queue_isr_clear(bp, queue, MACB_BIT(WOL));
+	pm_wakeup_event(&bp->pdev->dev, 0);
 }
 
-static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
+static void gem_wol_interrupt(struct macb_queue *queue, u32 status)
 {
-	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
-	u32 status;
 
-	status = queue_readl(queue, ISR);
-
-	if (unlikely(!status))
-		return IRQ_NONE;
-
-	spin_lock(&bp->lock);
-
-	if (status & GEM_BIT(WOL)) {
-		queue_writel(queue, IDR, GEM_BIT(WOL));
-		gem_writel(bp, WOL, 0);
-		netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
-			    (unsigned int)(queue - bp->queues),
-			    (unsigned long)status);
-		macb_queue_isr_clear(bp, queue, GEM_BIT(WOL));
-		pm_wakeup_event(&bp->pdev->dev, 0);
-	}
-
-	spin_unlock(&bp->lock);
-
-	return IRQ_HANDLED;
+	queue_writel(queue, IDR, GEM_BIT(WOL));
+	gem_writel(bp, WOL, 0);
+	netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
+		    (unsigned int)(queue - bp->queues),
+		    (unsigned long)status);
+	macb_queue_isr_clear(bp, queue, GEM_BIT(WOL));
+	pm_wakeup_event(&bp->pdev->dev, 0);
 }
 
 static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
@@ -2132,6 +2103,14 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
+	if (macb_is_gem(bp)) {
+		if (status & GEM_BIT(WOL))
+			gem_wol_interrupt(queue, status);
+	} else {
+		if (status & MACB_BIT(WOL))
+			macb_wol_interrupt(queue, status);
+	}
+
 	return 0;
 }
 
@@ -6004,7 +5983,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned long flags;
 	u32 tmp, ifa_local;
 	unsigned int q;
-	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->phy);
@@ -6067,39 +6045,15 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* write IP address into register */
 			tmp |= MACB_BFEXT(IP, ifa_local);
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
-		/* Change interrupt handler and
-		 * Enable WoL IRQ on queue 0
-		 */
-		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
 		if (macb_is_gem(bp)) {
-			err = devm_request_irq(dev, bp->queues[0].irq, gem_wol_interrupt,
-					       IRQF_SHARED, netdev->name, bp->queues);
-			if (err) {
-				dev_err(dev,
-					"Unable to request IRQ %d (error %d)\n",
-					bp->queues[0].irq, err);
-				return err;
-			}
-			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, tmp);
-			spin_unlock_irqrestore(&bp->lock, flags);
 		} else {
-			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
-					       IRQF_SHARED, netdev->name, bp->queues);
-			if (err) {
-				dev_err(dev,
-					"Unable to request IRQ %d (error %d)\n",
-					bp->queues[0].irq, err);
-				return err;
-			}
-			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
 			macb_writel(bp, WOL, tmp);
-			spin_unlock_irqrestore(&bp->lock, flags);
 		}
+		spin_unlock_irqrestore(&bp->lock, flags);
 
 		enable_irq_wake(bp->queues[0].irq);
 	}
@@ -6141,7 +6095,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
-	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_init(bp->phy);
@@ -6167,17 +6120,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 		macb_queue_isr_clear(bp, bp->queues, -1);
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-		/* Replace interrupt handler on queue 0 */
-		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
-		err = devm_request_irq(dev, bp->queues[0].irq, macb_interrupt,
-				       IRQF_SHARED, netdev->name, bp->queues);
-		if (err) {
-			dev_err(dev,
-				"Unable to request IRQ %d (error %d)\n",
-				bp->queues[0].irq, err);
-			return err;
-		}
-
 		disable_irq_wake(bp->queues[0].irq);
 
 		/* Now make sure we disable phy before moving

-- 
2.53.0


