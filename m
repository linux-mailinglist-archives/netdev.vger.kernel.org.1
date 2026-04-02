Return-Path: <netdev+bounces-274557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOl2DsByzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A02389F18
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05E25302D14B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A503612F0;
	Thu,  2 Apr 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L96TY6w8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8B322DB7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137338; cv=none; b=eQNAg0NKn6FstERWQ+nhMGUyyQGfkvYN+QAJX10HjqRI3LH2LcrGUSt7we7IIlT9OkJ6HMfTc/rf/wsRAaQR8O5aGZVxpPXs6wvsP5TuidsM8s+FTzvIl9sJYoUIA8zCqE0Gj9lX9j2dsFMkCNLuZFEa3ogQwQPmfcAyz9aKHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137338; c=relaxed/simple;
	bh=Yhegt7iU5rV6n8tWQ8XcSc+1i6PCYAHTe/z9RabDIkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETsVj7Hm4vWFRBN97S6oVkiGcw2ET68SfFZj0CQuqTV+ymcOA4gUFH+G+17sGZNhS4SwIhKhJh8a5eyBfcoMi5YYu8p0UL/xQsmwWN83vqgKxk5QL5a+fmZVr3hwsMlrsy1Z9euraN0hkDgWR06eogVgAj4GotlNOFPsghMq/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L96TY6w8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a56ca653ceso8986666d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137336; x=1775742136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD0JpGCIUJCZt+e3PHlWs2HiuWiKIa27B0E9SKBDPpU=;
        b=L96TY6w8b06yGByHB3oonfpFW1GyiQ9BYQB1lv1S2r7d8gtNVritr2GRZ5ezqzLsXe
         EZLzgvU4btWNJYyugxjcEnLybK4FDJjgslvMXIgPRKixD2wLeg7+xQ+4T8yWtiItoUxS
         OCiiqWf/Ywp7Rf1NTHskiTg7Hj2cESdu7o2dbaLmYsF1wJ9J1j1TuEiFic2WsVOiGBBc
         fOf/d3EyU/P18NMwLXxY/psNsLT27J9OfLEm9LQt/DRU6kQQ6rVSr711DlHPDMtRzK30
         z+dLBD/w/B5MI/B4FF4kkr9TSQk2V9M/g96JIFZMEpgr8aYaJ5M5o9uiVZsifnQxv9RA
         WXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137336; x=1775742136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vD0JpGCIUJCZt+e3PHlWs2HiuWiKIa27B0E9SKBDPpU=;
        b=S5se3Kh0i8BoM+1n8J4l2s7L3JJZVWkzBsweuBMS+2FipDghkVZKhCBR/5WcjE6sJL
         uJRsyFMaXpVOeu6WQWga9G1uJq7Sg9PUNgYxJHe1EKDIViLWzshU6WhTxUiCM9d0iyj6
         Y6h4QxIqynuqHQ1gAD3N4KJHLeg/lzkJ4/Zx0UgI4AI2wNIhDRYPEqb2A/2AZ7HMMcOD
         2/TYCrei69qfFk+bpkWmsSmg0OeTumSRFYj/BMXYmlz/HNVw19/SYhgMggKib0/f9hjI
         DGl1tD3kK7VBhLZfVnbAb9akDguZRUcXNCh30UUHFItJ1cMdu0KmqRZl/sTthcMHkHBL
         a0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXApVaJtQca1YsttjIDXmajy889nP3Am7zDFa6b6gpfHQm9eksr53JyAh4RZQ0WCmYFEYhupW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1qk7ti57NYvMyMA/hxcljn5gFSvG5aqMXQaPNOBpXFxm6+Jh
	2t9cZYRhu62T8zC8Be2sTeuaHe0volSSTsrkt9hJO/FOCN1k7G74w25B
X-Gm-Gg: AeBDies2u2oQ9W49miw/7I2+OI8PsAh7sO2afaNY+6ZZsA1pdbjLBBPtF6QQJIZmz7y
	k25L6foM6dS4UBw1aB1ygLXGf4vUa6/3Zp7PY89kk6G3jCz/paYG1sObjARXn6+6cRpyTnld6SA
	mq4G3fqu9twsjseHLelLcSWq13RHAMwOOvQjNFmjHkKMy3Ri7GqbUSkm5rKBJB6KhlLhIkxFBaN
	VKcySvt9ZxUI5bpz4IeYZ08GZBrVZTh0fw4QUBHdjXeMWqQd7YR8D+e2QL9aHF3eDih0c7qmla2
	g9QMDPsWju0VsqXOvmqpHdjF+EqKfchVqTjzL76znfEzIDXO4Is8bmjKG5iZ/6tYeimiIuP/xLD
	+tbPdPizxcP9uLk3JR8vz3FPjaMocIRyBD+2wY9mc8uQlQuVMzM1W4zygCVhdY5EOMXYOtNmDYJ
	VlvtwgW3JG6ugNhcNKXglI80B5xBg9vKJEmeCel6SiIrQ=
X-Received: by 2002:a0c:f09b:0:b0:8a0:f8b7:391d with SMTP id 6a1803df08f44-8a43999b698mr104207136d6.31.1775137335592;
        Thu, 02 Apr 2026 06:42:15 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm22636786d6.16.2026.04.02.06.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:42:15 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 02 Apr 2026 21:41:24 +0800
Subject: [PATCH net-next v2 3/4] net: macb: Factor out the handling of
 non-hot IRQ events into a separate function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-macb-irq-v2-3-942d98ab1154@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274557-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18A02389F18
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
 drivers/net/ethernet/cadence/macb_main.c | 103 ++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index aa25bfed67b67b1dc059e7aefcfb351bc298b3b1..98da191a2428b471ff9ac54e1f24beb3a882c546 100644
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
@@ -2078,12 +2081,66 @@ static irqreturn_t gem_wol_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
+{
+	struct macb *bp = queue->bp;
+	struct net_device *dev;
+	u32 ctrl;
+
+	dev = bp->dev;
+
+	if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
+		queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
+		schedule_work(&queue->tx_error_task);
+		macb_queue_isr_clear(bp, queue, MACB_TX_ERR_FLAGS);
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
+		macb_queue_isr_clear(bp, queue, MACB_BIT(RXUBR));
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
+		macb_queue_isr_clear(bp, queue, MACB_BIT(ISR_ROVR));
+	}
+
+	if (status & MACB_BIT(HRESP)) {
+		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
+		netdev_err(dev, "DMA bus error: HRESP not OK\n");
+		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
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
 
 	status = queue_readl(queue, ISR);
 
@@ -2129,48 +2186,10 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			napi_schedule(&queue->napi_tx);
 		}
 
-		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
-			queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
-			schedule_work(&queue->tx_error_task);
-			macb_queue_isr_clear(bp, queue, MACB_TX_ERR_FLAGS);
-			break;
-		}
+		if (unlikely(status & MACB_INT_MISC_FLAGS))
+			if (macb_interrupt_misc(queue, status))
+				break;
 
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
-			macb_queue_isr_clear(bp, queue, MACB_BIT(RXUBR));
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
-			macb_queue_isr_clear(bp, queue, MACB_BIT(ISR_ROVR));
-		}
-
-		if (status & MACB_BIT(HRESP)) {
-			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-			netdev_err(dev, "DMA bus error: HRESP not OK\n");
-			macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
-		}
 		status = queue_readl(queue, ISR);
 	}
 

-- 
2.53.0


