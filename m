Return-Path: <netdev+bounces-272761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN3xHAerx2mAaQUAu9opvQ
	(envelope-from <netdev+bounces-272761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E334E0C1
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 944413034A02
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F653859F4;
	Sat, 28 Mar 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdjPUmU1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32727B343
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693104; cv=none; b=gMPEgpJyNmW5KE0igdm+F7H7aWKwu4LdLJTNbW+lRQMvURXv8R7Qf2IEDbaq2qMTuVEDKUX0M5it0Xq5A4Z8+j5x6g0V3r67dxyaPkaDilcVpR5684WgeoMN1Iwynvm6pP/hJ3Dhj4sId9GBMwdRrIBJXFBScTJE064ZfW2lP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693104; c=relaxed/simple;
	bh=CyzZ3BNb5kvPDuETKM/UWxf2clvx5aeLjK+w7tkbq5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+Dv19DAv0ZjROYzHVcVWNmMej0/DndnGDBcrb6hNjrTz7wOibXwh12+e0zBnT+iLCvofICWNAAE2FdA489zaBR/m6ozkzNlzu2OeceISU9fGIqx/GeixWF9Tpu9z1BEB+4UQ77Z6IJEvm3q4BZCdhGOO81wQNKeYbaVqSXqd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdjPUmU1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5091d71aa11so34431641cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693102; x=1775297902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulJj7u5OH1E4QTZvYX5+FTKS0U184wymGA/yQQuQhIc=;
        b=TdjPUmU1kksv7ZI/vpfvTDrky0iP0FQi15hA+ho/+FQF5YBZ0QvuMtPHviMTsqakhC
         Lt3nUhHltmEZjLhmrU9gbfgCikKDLPEAgzMqdQIZieb0k+s+R8/xFajNlWjxY2waqfJ3
         c//tjZ5q4FwbX8Od2I8Jk0jG7/EbXqHMubF5MCmEUuRXYlAWceVZPyAXWCgq3kNemXCB
         tbSfjoj0GGJskY04ceA7kaXoZ8RiX/SYZ7Y899j02cIqA//uWq3FKPVkYSxrSipJB9Xn
         6Dww9osqWrpD3AclS+SLj0+QR6IR4QP3ECdHopwWrinQEJUvTN2o8/RM6BT33RbNhGUj
         IFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693102; x=1775297902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulJj7u5OH1E4QTZvYX5+FTKS0U184wymGA/yQQuQhIc=;
        b=dHEBgdV8YENqPceHvL1t+hRzNcGnaja7xD+H1SdACaYQzdy4n2zpA4mHFgKl15blYS
         IHXMc9t8sTbDBliq+k2omLuUBRljCBfazMTglEfArvdwPLyB1otC/Wo80CAgxbs+RPfV
         siLUJHV+5XNH2/76Hb75nHUrLpANyxiTUSutbMF1T/HlxvYSStyIzfrnGTejrNYqhJsg
         Zb4YrO6OfMKMudPPYTA2KBqkvpgDuYCoTVbR7S39X1wCtsA++chPTqcpHHUSBBHMFm4E
         RgDnRyR8B/zPDUqPuGjimH8rCrNLLmkJ5XjnNQQggacCmG1WDVvkTMTBoDnXSGk1/1zO
         Qc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeyoP1UD5usVDT0DAJ8Gc+skyh9hA47mo1zZwOG2gxKet7NdbzyozQi5hMcwb6Z61ghCUDj+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrS2Ka6hoWUwg1EA9tUGHlyPDUg5fF22nFHTECREOi4CAx/YDO
	S43pC5Ck/BFezkkpvxy4I5HZl3w+6eT9sFb/bdEk9pe2lAmrpx/j1CG8
X-Gm-Gg: ATEYQzwEwuOS5RlLJ8pVR+FJNVj6XeL4kREUmKjBuScixKig86IuhSPZ6A5SASwTZvG
	CJyrSkdqpbihuqwPTuwZ/CCK6yPaC/nY+AiPxEmXTuYC+EZS82bQprdq8Oeh+RQj7iCf7bfaqvc
	8uURAYh5GYufFKNj8O7e+JsXKnxkKLQfMIBoXsybDTNZWgOxpmYAWU8Nm+AZRbId2M0zQ7BkGX1
	/elGQGLs16lC7FfHF0a9nuw1TBcoeHiuv8r90knXIO4lBvcKvS2xnCWKt/D3w3xT7h9vqV617Hk
	Cskxfjy4n4ApLwJUKDiiA06D0bhCcFGCgrimDpj5BLOTLc+pxIxb6f0xgmmcycsURZMaoF3UAnr
	qg5LJ56fW/xnQgIfSTLoKlWyC+FsSFGo/3VQKMTXh/tRRHjaJqVjpSjpGn+qB2wxO9+vmJ5IwG1
	yNV0LJhwblTHQnJF/nm1/n1JeU131nR0wF
X-Received: by 2002:ac8:7f06:0:b0:50b:8676:3cb7 with SMTP id d75a77b69052e-50b9938e74dmr105337771cf.1.1774693101948;
        Sat, 28 Mar 2026 03:18:21 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e17372sm15490681cf.24.2026.03.28.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:18:21 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 28 Mar 2026 18:17:47 +0800
Subject: [PATCH net-next 3/4] net: macb: Factor out the handling of non-hot
 IRQ events into a separate function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-macb-irq-v1-3-7b3e622fb46c@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-272761-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: EB8E334E0C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the current code, the IRQ handler checks each IRQ event sequentially.
Since most IRQ events are related to TX/RX operations, while other
events occur infrequently, this approach introduces unnecessary overhead
in the hot path for TX/RX processing. This patch reduces such overhead
by extracting the handling of all non-TX/RX events into a new function
and consolidating these events under a new flag. As a result, only a
single check is required to determine whether any non-TX/RX events have
occurred. If such events exist, the handler jumps to the new function.
This optimization reduces four conditional checks to one and prevents
the instruction cache from being polluted with rarely used code in the
hot path.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 123 ++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 743abe11324c690c11993d7be9ed5b73422dd17c..c53b28b42a46489722461957625e8377be63e427 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -70,6 +70,9 @@ struct sifive_fu540_macb_mgmt {
 #define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP)	\
 					| MACB_BIT(TXUBR))
 
+#define MACB_INT_MISC_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(RXUBR) | \
+				 MACB_BIT(ISR_ROVR) | MACB_BIT(HRESP))
+
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
 #define MACB_MAX_TX_LEN		((unsigned int)((1 << MACB_TX_FRMLEN_SIZE) - 1) & ~((unsigned int)(MACB_TX_LEN_ALIGN - 1)))
@@ -2082,12 +2085,77 @@ static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
+{
+	struct macb *bp = queue->bp;
+	struct net_device *dev;
+	bool isr_clear;
+	u32 ctrl;
+
+	dev = bp->dev;
+	isr_clear = bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE;
+
+	if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
+		queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
+		schedule_work(&queue->tx_error_task);
+
+		if (isr_clear)
+			queue_writel(queue, ISR, MACB_TX_ERR_FLAGS);
+
+		return -1;
+	}
+
+	/* Link change detection isn't possible with RMII, so we'll
+	 * add that if/when we get our hands on a full-blown MII PHY.
+	 */
+
+	/* There is a hardware issue under heavy load where DMA can
+	 * stop, this causes endless "used buffer descriptor read"
+	 * interrupts but it can be cleared by re-enabling RX. See
+	 * the at91rm9200 manual, section 41.3.1 or the Zynq manual
+	 * section 16.7.4 for details. RXUBR is only enabled for
+	 * these two versions.
+	 */
+	if (status & MACB_BIT(RXUBR)) {
+		ctrl = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
+		wmb();
+		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
+
+		if (isr_clear)
+			queue_writel(queue, ISR, MACB_BIT(RXUBR));
+	}
+
+	if (status & MACB_BIT(ISR_ROVR)) {
+		/* We missed at least one packet */
+		spin_lock(&bp->stats_lock);
+		if (macb_is_gem(bp))
+			bp->hw_stats.gem.rx_overruns++;
+		else
+			bp->hw_stats.macb.rx_overruns++;
+		spin_unlock(&bp->stats_lock);
+
+		if (isr_clear)
+			queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
+	}
+
+	if (status & MACB_BIT(HRESP)) {
+		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
+		netdev_err(dev, "DMA bus error: HRESP not OK\n");
+
+		if (isr_clear)
+			queue_writel(queue, ISR, MACB_BIT(HRESP));
+	}
+
+	return 0;
+}
+
 static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
 	struct net_device *dev = bp->dev;
-	u32 status, ctrl;
+	u32 status;
 	bool isr_clear;
 
 	status = queue_readl(queue, ISR);
@@ -2141,57 +2209,10 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			napi_schedule(&queue->napi_tx);
 		}
 
-		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
-			queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
-			schedule_work(&queue->tx_error_task);
+		if (unlikely(status & MACB_INT_MISC_FLAGS))
+			if (macb_interrupt_misc(queue, status))
+				break;
 
-			if (isr_clear)
-				queue_writel(queue, ISR, MACB_TX_ERR_FLAGS);
-
-			break;
-		}
-
-		/* Link change detection isn't possible with RMII, so we'll
-		 * add that if/when we get our hands on a full-blown MII PHY.
-		 */
-
-		/* There is a hardware issue under heavy load where DMA can
-		 * stop, this causes endless "used buffer descriptor read"
-		 * interrupts but it can be cleared by re-enabling RX. See
-		 * the at91rm9200 manual, section 41.3.1 or the Zynq manual
-		 * section 16.7.4 for details. RXUBR is only enabled for
-		 * these two versions.
-		 */
-		if (status & MACB_BIT(RXUBR)) {
-			ctrl = macb_readl(bp, NCR);
-			macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
-			wmb();
-			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
-
-			if (isr_clear)
-				queue_writel(queue, ISR, MACB_BIT(RXUBR));
-		}
-
-		if (status & MACB_BIT(ISR_ROVR)) {
-			/* We missed at least one packet */
-			spin_lock(&bp->stats_lock);
-			if (macb_is_gem(bp))
-				bp->hw_stats.gem.rx_overruns++;
-			else
-				bp->hw_stats.macb.rx_overruns++;
-			spin_unlock(&bp->stats_lock);
-
-			if (isr_clear)
-				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
-		}
-
-		if (status & MACB_BIT(HRESP)) {
-			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-			netdev_err(dev, "DMA bus error: HRESP not OK\n");
-
-			if (isr_clear)
-				queue_writel(queue, ISR, MACB_BIT(HRESP));
-		}
 		status = queue_readl(queue, ISR);
 	}
 

-- 
2.53.0


