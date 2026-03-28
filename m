Return-Path: <netdev+bounces-272762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ChTDv2qx2mAaQUAu9opvQ
	(envelope-from <netdev+bounces-272762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D650834E0BA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97F2302690D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4B38655D;
	Sat, 28 Mar 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8rm2Poj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C227B343
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693108; cv=none; b=KJhZQVYmY7Xr3Q0el0Pc1VRLv1iSz4G0AXXtmlZEO2zDSUTK587ReCJ6jtzwM9reNr0+y/vG4BbxgPzcbIZPsCDH+Bz9jLLWBW/6qgv6LDhcSCQLW9YIyrCwt7FcAsBJLdE4MgCE8Bl6kBjnoh5AlmrG0lR74TJrhO0y+FVydDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693108; c=relaxed/simple;
	bh=z3Q6Ub6eZntdR+yjtMU1sOruGYzB+66LUEFvDVoYVTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpdJ9hc/sORarvPA5s3DRPIyQu9wPEwFoxY66pqbb0UIJEHmwbA/IEEteKDo3tZKlR9uyRGZ0O/sjk4/45z8wGLi9OZ4kgtfytSpuCaIRAtWx0sf4oYHkR2/34tcwsMHcJ2WlLtjOr7AQKxNYlgafZ2azQWGe+3LebnCmOv5klA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8rm2Poj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509217e84a3so24434901cf.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693106; x=1775297906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rff8AXpzD8NbsmqMfMlyjp8BORw8w2LjOLxO5njrPs=;
        b=s8rm2PojZO5amf6SyirZYwRvQej6lcdmy9088SB1KxbwpS0lwEJdvkZ7Vre0qFh2lN
         j+Y2NWzY2bX2R4aR3HjvMq8Npt4ynbxsiFaAgyzM2TsfQFS/EAjoMp3FdKwYMua8ujJ/
         8a7rTilr2q9MGl7WeXXGZwRh4gjpgut2t2312rhSRFfMTKhVT3JmQHPZxYVw4A0560X1
         0M+Bhp9fkTVxBY60zSr+gPAj22xMLhSIk/pwI+I8rylZaBwRhYp8Tx18XuAALO52FzTk
         97lbS1xGt0A8uc54CRKggA2V3jKaEgV43xuocao7IIBDjbGu9+eQ0O/aB3qwAkA//e0i
         3QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693106; x=1775297906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rff8AXpzD8NbsmqMfMlyjp8BORw8w2LjOLxO5njrPs=;
        b=Dq5M0jocfe3ygiPkDbD6wrvWmXxZcYvEH4U8ApB6FPj2yp21Hgz7wNtQfyvhyO80rI
         EY3I7ulMcFPUlhhLAuDlHqY5HBhXHtItVufZpvF2A3VQPlxGItpK51CN+cwTXjknbdg6
         KhWmVeqAEgxMLJqlddstrK21VXQNbLy1O5LBDfy81cZGIdAzlEF+ZMUEYwSLCPCjC0cr
         RPPi/3+mmBxVhuXC8zFIdh3FoPa78MvwDxK1IFe43zF6STCrpr/qBvSSqUP6aH3hbZ0G
         IUC4mWpfE106pKT6zVOGaNTJKXI7mC8iDPcShwXxN5zna8y6qyYQELcBDf/9ZJDzZZEq
         Aj/g==
X-Forwarded-Encrypted: i=1; AJvYcCWKlwtxXZr5MbQ712DfB+rY28ekfTJ+ljDHtpOm2qMuzPBLN9g7D0Dzu6QS8OCYfKjOeWDMyLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5nB8o9H1DoTB9HZAWRWwmCuCE7OLw3A8WaLVSruG57MvQo3R
	F3+sQv7yYNqpRPxZE8khGjpEfbYOpGaVCy6FBvfyd5u4ac7h1QtOYV+6
X-Gm-Gg: ATEYQzxfRwQiQ4Nh7/dhvavtKwgBzg6cUhQ6g4m/WXtGf7UlEEja9N7MmkHlFYggeVG
	83d2rFfxeP5iYjxztTXc6FjSBBv31RuV2yGSBMiEuq/Y73EaI24aszP57s3TbcJO4BKhQaAvRfy
	j5fQgssE/y+THvmW5W+lhywqy6p0AHRE0gx2uHVvo/lR/yjG9aj/aiEQe9WB/f86+0vwNP3g776
	FiJSG4MX0wdtX42CUqXB5oe75eF4oJ5Jq79mNYSoKTdnvN4dv1QSk2DrE+Rv/j7UFoDp+EQN3tC
	Un4wDRiodqC2aqrgRhIdYi7inyyq21YCZUR6ANGY4g4ny1rLqRbo/H+syycsLwaLqQHWhg0BDcT
	Eh9yVbZfsbbbxk4tQ2YD8X+5KtBBVy5RwuGJ4xrCZN5beWBKoHYT0WmnnqLQeTt7byMesSq7Ape
	SYusNGtHL09eYbdrFRfJvUNg3c73heNErQ4U3Zil7MM4w=
X-Received: by 2002:ac8:5814:0:b0:50b:51f7:c660 with SMTP id d75a77b69052e-50ba398f849mr74156431cf.61.1774693105530;
        Sat, 28 Mar 2026 03:18:25 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e17372sm15490681cf.24.2026.03.28.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:18:25 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 28 Mar 2026 18:17:48 +0800
Subject: [PATCH net-next 4/4] net: macb: Remove dedicated IRQ handler for
 WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-macb-irq-v1-4-7b3e622fb46c@gmail.com>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
In-Reply-To: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272762-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D650834E0BA
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

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 116 ++++++++-----------------------
 1 file changed, 29 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c53b28b42a46489722461957625e8377be63e427..de166dd9e637f5e436274b99f2c5eef99dcdb351 100644
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
@@ -2027,62 +2028,32 @@ static void macb_hresp_error_task(struct work_struct *work)
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
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, MACB_BIT(WOL));
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
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, MACB_BIT(WOL));
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
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, GEM_BIT(WOL));
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
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, GEM_BIT(WOL));
+	pm_wakeup_event(&bp->pdev->dev, 0);
 }
 
 static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
@@ -2147,6 +2118,14 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 			queue_writel(queue, ISR, MACB_BIT(HRESP));
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
 
@@ -5943,7 +5922,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned long flags;
 	u32 tmp, ifa_local;
 	unsigned int q;
-	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->phy);
@@ -6007,39 +5985,15 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -6081,7 +6035,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
-	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_init(bp->phy);
@@ -6108,17 +6061,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 			queue_writel(bp->queues, ISR, -1);
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


