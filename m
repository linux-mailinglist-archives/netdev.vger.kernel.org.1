Return-Path: <netdev+bounces-272760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPLpM/uqx2mAaQUAu9opvQ
	(envelope-from <netdev+bounces-272760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6134E0B3
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D4C230360B4
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430E3859E9;
	Sat, 28 Mar 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+jXn2G7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830C386425
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693100; cv=none; b=qdgIVfnfNJTKxd8Ky9i/ryok6zLzrV3KB2ZD+y9/Htyk/dWATHzSo7sw5UfTAfWhfUeXjbnWiAwnUvcX/BKUOykcumpkplY8z80Xw+Kdts6ehqGpvgY0IoacTI9VZJ7QPY6I1zVTn6jIhzJBdEzqpFWAJ0uGj3sFVbUmvrjTBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693100; c=relaxed/simple;
	bh=lFN6yORG9X6SztcDFrQiNqfyj84PBmipujaCFp2hx0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0r95lZjRsJkV2x5kIXlu5J1jMN/6ar9fGLZiAh88vhkk2avrMttN3PTP8AjWHJPjw+sz24eKcI/ut1itNP0S0CpqKG6XnjV5c1JWPtm59a6ZczP8Pxx6ZoYEUymNEGf2CURdylQVtDqIc9A+nyxrMYSfzNXNvYDPqXP3gc43R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+jXn2G7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506aa68065eso25703231cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693098; x=1775297898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTPgxs7/Z9PO1OF732RYV+XtQ2JgdbaDYhF0mnq2qF4=;
        b=s+jXn2G7SwOseg0XxvMC7DllPsGlXZsxmPl06egRlnPAUo5wb660wNuK7/ZdcY6UVT
         T+qLKrso6lqHCGTOAjt02spblzKxrnscNJP2i46sXD3b2jvQ9WWGTqlmDZv9zNZhpqDj
         tmmcIt+BQ0PG+vewOihjpp5oIBq1AAgeM3eLNeyEOUblqF2wr1nVyDIkuKlxCaoJHERv
         Uylnc9eQBvQfu4N4RFGTtIjJKhUhSA5JRSbrA/nfgDTgnV9LonTWHb9XHc+aRocWXx8b
         qDggxfFZWGYzsyU6VWcPt/GX9iocye03YqMLNLr651GVwe9Bpr+P/8PVLIaEigyoQpTV
         6ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693098; x=1775297898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TTPgxs7/Z9PO1OF732RYV+XtQ2JgdbaDYhF0mnq2qF4=;
        b=Flgut442sc9lc0ACWRg8SFeTsE1Ns2jX0eNaPLABsy3rKSzJXoLk1Y15KaPVpUGHJr
         TsXIQrSx1kwTikXmtRDbb5k5Jz/DXC+s6dsB3Iju3Ag4AVPNk00YbXCA/yA/AYmyYwM+
         0vMTkzhrngTRgQx3ZBZzaV2oDqt3dVS5zkAk5zeLr2DMng3IZ4u6D30RyaoJAUkhC/rl
         DRmwoPFmotWZJmZ5ptVW3WFOdUGvJI5Dx4bxkVb/AdIv1oVd2cV9XhZHCya2sj7aZO9A
         UGC9GIEn8+i83SEvvbikaeHkoK/p0nfpdk27DdVyfHlV+ylj3kXbCpvj7VkIjYc/IVia
         meBA==
X-Forwarded-Encrypted: i=1; AJvYcCV8m7wlKkWKcQXJCZacKlozUxgp+gbmpAOeCvPq/hIGyduCuEN6rNFFygS0g/fDbILuTUtVjM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IlqLypxfOjr9afgHjLeetWRQwqbGmnQU5bE3jgaa+qDTl8K5
	sOb8CFkKKSWzg2ieaStixjd8SCljqNrR/geKKpebNqjDgKgJroiSoKvH
X-Gm-Gg: ATEYQzy++0vw6abKkSCmUAW1oDyt8iUol8YbwAaFjMtWPcd5StSWy1uuXBJikYO4JU/
	P3AqVBKNsXM3sGxDumqBY5VZZEJCRWtwRXu33djE4rMqEyUxYu6oBfjpKWKXx2pKjKy4ljKuMfK
	0QGhbivzMMQJF8mTA6pzj2nnwi3JDtPl08EQ0FdTMt6JDGdUymbZd0ugYJfUY2gzpq4ZC44Vr1S
	GGLiZwHZt3fmtwUJoBwPrz09iXurHSEe3nGDxD7lgqNH7TuITCtzAGbiC3IBarVWANIsTXvDuZ/
	7OYtbdIwkrF5xyEEStmElegUib/vquu7nV73ZDO8S/C6VxC/2sMLSqtYkFQ/R+q6Pt+FycPm+px
	5Dt7t/sGQWDcl5D+lfwtWRD3pw4A5xqN8JfjmYBVe2AkaUc21D9uQqlkSPcbUp+a+F0D6zZOQMe
	IdpV/KIWMLanF6Q8B1DxNOoK0i7Yx5htcZ
X-Received: by 2002:a05:622a:489b:b0:50b:4bfb:1653 with SMTP id d75a77b69052e-50ba395d2d3mr81261571cf.41.1774693098194;
        Sat, 28 Mar 2026 03:18:18 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e17372sm15490681cf.24.2026.03.28.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:18:17 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 28 Mar 2026 18:17:46 +0800
Subject: [PATCH net-next 2/4] net: macb: Consolidate
 MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-272760-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 41C6134E0B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the MACB_CAPS_ISR_CLEAR_ON_WRITE flag is checked in every
branch of the IRQ handler. This repeated evaluation is unnecessary.
By consolidating the flag check, we eliminate redundant loads of
bp->caps when TX and RX events occur simultaneously, a common scenario
under high network throughput. Additionally, this optimization reduces
the function size from 0x2e8 to 0x2c4.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 886246a6f6bdd0b6a8cb4b86d7788ac181ee602a..743abe11324c690c11993d7be9ed5b73422dd17c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2088,19 +2088,22 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct macb *bp = queue->bp;
 	struct net_device *dev = bp->dev;
 	u32 status, ctrl;
+	bool isr_clear;
 
 	status = queue_readl(queue, ISR);
 
 	if (unlikely(!status))
 		return IRQ_NONE;
 
+	isr_clear = bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE;
+
 	spin_lock(&bp->lock);
 
 	while (status) {
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(dev))) {
 			queue_writel(queue, IDR, -1);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, -1);
 			break;
 		}
@@ -2117,7 +2120,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			 * now.
 			 */
 			queue_writel(queue, IDR, bp->rx_intr_mask);
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
 			napi_schedule(&queue->napi_rx);
@@ -2126,7 +2129,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		if (status & (MACB_BIT(TCOMP) |
 			      MACB_BIT(TXUBR))) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_BIT(TCOMP) |
 							 MACB_BIT(TXUBR));
 
@@ -2142,7 +2145,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
 			schedule_work(&queue->tx_error_task);
 
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_TX_ERR_FLAGS);
 
 			break;
@@ -2165,7 +2168,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			wmb();
 			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_BIT(RXUBR));
 		}
 
@@ -2178,7 +2181,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				bp->hw_stats.macb.rx_overruns++;
 			spin_unlock(&bp->stats_lock);
 
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
 		}
 
@@ -2186,7 +2189,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
 			netdev_err(dev, "DMA bus error: HRESP not OK\n");
 
-			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			if (isr_clear)
 				queue_writel(queue, ISR, MACB_BIT(HRESP));
 		}
 		status = queue_readl(queue, ISR);

-- 
2.53.0


