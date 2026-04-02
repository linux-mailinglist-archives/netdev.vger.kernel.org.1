Return-Path: <netdev+bounces-274556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Kz8AzF0zmkpnwYAu9opvQ
	(envelope-from <netdev+bounces-274556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BC38A07B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF0CC310F60E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3531DDBB;
	Thu,  2 Apr 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlTCWIrO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1C31B823
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137334; cv=none; b=JQwDte6dvc1jp7W4/Hlw0zZspmxsUwc9gZuwA6Bt08+yRhfxY4wxoSQJJHwvWxvyoeaI28KZU51fdcgajWrRsfgVa6liVboDMxvdoaROSawYaScZLLWos9PE6xO0mti/XqupvBha3LibWYu8SiDwZNytsa5fiTZivMCYT7tEs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137334; c=relaxed/simple;
	bh=fui2k7W3kzqHbEp2RxjvyLK/uCqTY0twaQHgAjBBcnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOAOZ/c+BLvlf32cU7wVKgqFlKto4fYhEb2W5YlCC8s7Z0uU7wu9wroV0NeuLoH61E0F5imRj8+LcsQ73Cl12NiIKdSDPFE4CVZyS3LqG0xq0L9Driz5RrKAPHjccgp1a2vkUEZS9SVccJYhRV4PMtPs9TWXEeoLLFR7X67AS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlTCWIrO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89f68634786so11250476d6.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137332; x=1775742132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jI9s4pV6axUzNz1v0OmTIzWI9NyLRrETyGajDoGdJf8=;
        b=KlTCWIrOoeqtpdsd1pZtrYFMRGfIocbtjBOc4vvJRMk2W7OoFviKbhBQYBhWJsia6x
         1ACdAIWd/LkV8df5fXG3h5Fo/QNL7Yx/+wcyRl1urgyXT1KdA+gkMBM3Do71Abc1olSA
         PpcHEBVHzm2xen6YwVmbleNrQCspjiGv3VKJHr6+KSunp5WQBo2b4clKZhETmLGPaN3O
         jIE6H9c9Qf/pTqjM6ycadDz55HdQs0X3nskCWvsi45qW1yOOEHHHrdv5rRFSQPzwX5xg
         MKGVU2kQsXyiicVbITzfMYC5WWZXvH333UYjLxnuHIWHcLXkv8zmLVYlvNOblgLv46uy
         jG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137332; x=1775742132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jI9s4pV6axUzNz1v0OmTIzWI9NyLRrETyGajDoGdJf8=;
        b=S5ob1AYntI1BxHenp45TLuzOUlGdx0Op7xcr6CMdJ7GMz1dGEmKOohBeIoYGltVVYK
         0v9mqYfs5ReSGTtMlU2H1IiLo2YSlDCoJ9uwcPnPW+okqW2hEWc2O7DKZtimrKRTEfCF
         TF3JWKfXe6LEI84hOuyL2gVoZvR1jg5iJvWkZ8J6ixFaLgwe0aPC99EzI3Pco1r95HDr
         BDtSt0WulOhCGzwYhYHdz5RBy4e/hKOtWFHbVcNykauLEKTQb8Ww06MrPq8B2LfHGye2
         3F7N7fbiTejh9o4vPxIimdVUbJbrPARsYQ4jbQtvFhiF5bj46PA7zsBMYw1htnSdXE+V
         RBsA==
X-Forwarded-Encrypted: i=1; AJvYcCV02z1dfhVJ3fWg80kQN0Pgntkf9POwTVyr9ELZlu8pQnJp05o6jI2BIj3BrHSkkB6OA5l6iHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kJkaEOaXZ08y9wpujppY9d/Uzj8CzYHr9RWkXKpAKoFeyGES
	dwAlFXJ+mSv9JlvcBseNgreQC6+fDhW6ktu2DhBQbCvkY4xke5LnXWvH
X-Gm-Gg: AeBDieuuy2UBGZilzPTmQrblWrLdtlO7XkfQAnpCELC6I3w0OwJ07EdGHThz2AQlvxa
	RFN1Y6kTiGTjKO/F8yJlGlx5O2/cEBvKBTChwHmFKAxIS6oyPBm4f2OmKdvr+f4uuItXPQLmmm0
	ebDHJTOqVVcqWoibtle52vssUO1hx+vq7RwWkffy5MGNGA1FkIIjXwcyIWsU2MYWE3tkvNZqMEq
	l8FI2qgR9TauJyLBxSNYdxYwlSu1l2V7nQbrdTY5sqoZBDoTzKivUlql8ne6hc4r+cLW2U2Gjwq
	cts4RPLQDxbaO+h4Frck+OSsnFiXBHyMbEs2gRkyJUuHM3+cfb/mpmq2lIt9O5UJ+9w37I3HgV4
	N2WO1xEmISrrCYAS4QutSeq5yA1pr6GtVCQuvw1EuiPaJ76vkW7lnYTblDzj/HxpT2+jg//rsc6
	o/42CrZI5kiQRh0HGqJbVTx52HpH8m5Ae5
X-Received: by 2002:a05:6214:c81:b0:89c:c5cc:4bf4 with SMTP id 6a1803df08f44-8a59f66bc73mr49736506d6.16.1775137331884;
        Thu, 02 Apr 2026 06:42:11 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm22636786d6.16.2026.04.02.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:42:11 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 02 Apr 2026 21:41:23 +0800
Subject: [PATCH net-next v2 2/4] net: macb: Introduce
 macb_queue_isr_clear() helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-macb-irq-v2-2-942d98ab1154@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-274556-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 788BC38A07B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current implementation includes several occurrences of the
following pattern:
	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
		queue_writel(queue, ISR, value);

Introduces a helper function to consolidate these repeated code
segments. No functional changes are made.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb.h      |  7 +++++
 drivers/net/ethernet/cadence/macb_main.c | 51 ++++++++++----------------------
 2 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 16527dbab875dc2f65c74987c54b5b323a0c252c..2de56017ee0d6152dbe2c4ad0d8d7a8dfadbb3d5 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1474,6 +1474,13 @@ static inline bool macb_dma_ptp(struct macb *bp)
 	       bp->caps & MACB_CAPS_DMA_PTP;
 }
 
+static inline void macb_queue_isr_clear(struct macb *bp,
+					struct macb_queue *queue, u32 value)
+{
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, value);
+}
+
 /**
  * struct macb_platform_data - platform data for MACB Ethernet used for PCI registration
  * @pclk:		platform clock
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6bfba329bc9f1c918295d44ebfa38eefe209b648..aa25bfed67b67b1dc059e7aefcfb351bc298b3b1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1887,8 +1887,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 		 */
 		if (macb_rx_pending(queue)) {
 			queue_writel(queue, IDR, bp->rx_intr_mask);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RCOMP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
 			netdev_vdbg(bp->dev, "poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
@@ -1975,8 +1974,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		 */
 		if (macb_tx_complete_pending(queue)) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(TCOMP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
 			netdev_vdbg(bp->dev, "TX poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
@@ -2043,8 +2041,7 @@ static irqreturn_t macb_wol_interrupt(int irq, void *dev_id)
 		netdev_vdbg(bp->dev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, MACB_BIT(WOL));
+		macb_queue_isr_clear(bp, queue, MACB_BIT(WOL));
 		pm_wakeup_event(&bp->pdev->dev, 0);
 	}
 
@@ -2072,8 +2069,7 @@ static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
 		netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, GEM_BIT(WOL));
+		macb_queue_isr_clear(bp, queue, GEM_BIT(WOL));
 		pm_wakeup_event(&bp->pdev->dev, 0);
 	}
 
@@ -2100,8 +2096,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(dev))) {
 			queue_writel(queue, IDR, -1);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, -1);
+			macb_queue_isr_clear(bp, queue, -1);
 			break;
 		}
 
@@ -2117,19 +2112,15 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			 * now.
 			 */
 			queue_writel(queue, IDR, bp->rx_intr_mask);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RCOMP));
-
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
 			napi_schedule(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
 			      MACB_BIT(TXUBR))) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(TCOMP) |
-							 MACB_BIT(TXUBR));
-
+			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
+							MACB_BIT(TXUBR));
 			if (status & MACB_BIT(TXUBR)) {
 				queue->txubr_pending = true;
 				wmb(); // ensure softirq can see update
@@ -2141,10 +2132,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
 			queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
 			schedule_work(&queue->tx_error_task);
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_TX_ERR_FLAGS);
-
+			macb_queue_isr_clear(bp, queue, MACB_TX_ERR_FLAGS);
 			break;
 		}
 
@@ -2164,9 +2152,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 			wmb();
 			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(RXUBR));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(RXUBR));
 		}
 
 		if (status & MACB_BIT(ISR_ROVR)) {
@@ -2177,17 +2163,13 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			else
 				bp->hw_stats.macb.rx_overruns++;
 			spin_unlock(&bp->stats_lock);
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(ISR_ROVR));
 		}
 
 		if (status & MACB_BIT(HRESP)) {
 			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
 			netdev_err(dev, "DMA bus error: HRESP not OK\n");
-
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, MACB_BIT(HRESP));
+			macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 		}
 		status = queue_readl(queue, ISR);
 	}
@@ -2883,8 +2865,7 @@ static void macb_reset_hw(struct macb *bp)
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, -1);
 		queue_readl(queue, ISR);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(queue, ISR, -1);
+		macb_queue_isr_clear(bp, queue, -1);
 	}
 }
 
@@ -6053,8 +6034,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* Disable all interrupts */
 			queue_writel(queue, IDR, -1);
 			queue_readl(queue, ISR);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-				queue_writel(queue, ISR, -1);
+			macb_queue_isr_clear(bp, queue, -1);
 		}
 		/* Enable Receive engine */
 		macb_writel(bp, NCR, tmp | MACB_BIT(RE));
@@ -6165,8 +6145,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		}
 		/* Clear ISR on queue 0 */
 		queue_readl(bp->queues, ISR);
-		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-			queue_writel(bp->queues, ISR, -1);
+		macb_queue_isr_clear(bp, bp->queues, -1);
 		spin_unlock_irqrestore(&bp->lock, flags);
 
 		/* Replace interrupt handler on queue 0 */

-- 
2.53.0


