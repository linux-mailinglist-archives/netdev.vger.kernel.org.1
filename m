Return-Path: <netdev+bounces-261487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCKLNqJ9oGmXkQQAu9opvQ
	(envelope-from <netdev+bounces-261487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:06:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4C1ABB4D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D93F7320E779
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BB332617;
	Thu, 26 Feb 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FC3BlTxk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380223290D6
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124122; cv=none; b=e6ji+bEwZuN3AN+bvqooLw9E6ffZPY+9L0Dz7Cl3g5nFEETMTUTU2GW/p2sdVyo4xMk+BTfOUSTVCQ3doIEB2JJAgTnxbyViHTeBZZCvW8zKdd64R6bclSr9agerRvNRvPUQmt9uumPSHALJE1cU8u/MiopfIHLUFnZr0xEJXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124122; c=relaxed/simple;
	bh=RYRy5g8W0Xf7Fu2ii+9Dvn7gs9XC+WhAzXnGhEem1q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyzGmkjzoAwKQTkSn/Id7pnqI/2xwg8K00m6lW1R/u8UKCw6MyIWDMsBFXkzlXKiuWT3rOyve6lgPyJLB8O/peyIaSyN93CzJzuo7zTEZkaLvmeuwWXDx7uPJpLXiXXcz1PNhW2T93luBXPSgcqckJZ0y3Nm6nYi4TNckAJdk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FC3BlTxk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E2ACD1A1609;
	Thu, 26 Feb 2026 16:41:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B2DC45FDE9;
	Thu, 26 Feb 2026 16:41:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D77D6103693DF;
	Thu, 26 Feb 2026 17:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772124118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IITRpU+zvv8SCI02oLy3IeJ6AI5N5yaZpXdgBXpsLWg=;
	b=FC3BlTxkSs3TpfWiGZeTncsVoWzc+wyKHx6XCFipnO6idVeYgGkv0yh/zs2uMkYogaBY12
	tomYrSqXn187XFDchwPCBcVIAsEbYn8EVPSJyKn0Nrw8/R3mnDj/ykjNdvyvBunI1ZeO7z
	ibYOInalPTcQF7eX/XTQDESVmTGf3/KRhyoEJfPhsDS0DVfFmq5BgrCDQo0ieeHbqFSDQB
	yOphfg8bJzy3eEOUboQf7oquKb/QDZu+Z/mJmpTZL5OyISE/Eh7xXpnMnYrzmwTSV0/LRY
	HDtSDXAGxJXFfBacoDmI/PE4dQ3MNJpqY7iPQCKkEfT6PK7dEUmZD5oAJ8dXnQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 26 Feb 2026 17:41:48 +0100
Subject: [PATCH net-next v5 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ksz8463-ptp-v5-1-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
In-Reply-To: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 3EA4C1ABB4D
X-Rspamd-Action: no action

KSZ8463's interrupt scheme differs from the others KSZ swicthes. Its
global interrupt handling is done through an 'enable irq' register
instead of a 'mask irq' one, so the bit logic to enable/disable
interrupt is reversed. Also its interrupts registers are 16-bits
registers and don't have the same address.

Add ksz8463-specific global interrupt setup function that still relies
on the ksz_irq_common_setup().
Add a check on the device type in the irq_chip operations to adjust the
bit logic for KSZ8463

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 40 +++++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c517478cc47677544b6523faee113ece036c9ed9..0102b950e09df7d33c8e429d9b34f51375e0ef73 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2817,14 +2817,20 @@ static void ksz_irq_mask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked |= BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked &= ~BIT(d->hwirq);
+	else
+		kirq->masked |= BIT(d->hwirq);
 }
 
 static void ksz_irq_unmask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked &= ~BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked |= BIT(d->hwirq);
+	else
+		kirq->masked &= ~BIT(d->hwirq);
 }
 
 static void ksz_irq_bus_lock(struct irq_data *d)
@@ -2840,7 +2846,10 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
+	if (ksz_is_ksz8463(dev))
+		ret = ksz_write16(dev, kirq->reg_mask, kirq->masked);
+	else
+		ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
@@ -2890,14 +2899,14 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	unsigned int nhandled = 0;
 	struct ksz_device *dev;
 	unsigned int sub_irq;
-	u8 data;
+	u16 data;
 	int ret;
 	u8 n;
 
 	dev = kirq->dev;
 
 	/* Read interrupt status register */
-	ret = ksz_read8(dev, kirq->reg_status, &data);
+	ret = ksz_read16(dev, kirq->reg_status, &data);
 	if (ret)
 		goto out;
 
@@ -2939,6 +2948,22 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	return ret;
 }
 
+static int ksz8463_girq_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_irq *girq = &dev->girq;
+
+	girq->nirqs = 15;
+	girq->reg_mask = KSZ8463_REG_IER;
+	girq->reg_status = KSZ8463_REG_ISR;
+	girq->masked = 0;
+	snprintf(girq->name, sizeof(girq->name), "global_irq");
+
+	girq->irq_num = dev->irq;
+
+	return ksz_irq_common_setup(dev, girq);
+}
+
 static int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
@@ -3044,7 +3069,10 @@ static int ksz_setup(struct dsa_switch *ds)
 	p->learning = true;
 
 	if (dev->irq > 0) {
-		ret = ksz_girq_setup(dev);
+		if (ksz_is_ksz8463(dev))
+			ret = ksz8463_girq_setup(ds);
+		else
+			ret = ksz_girq_setup(dev);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de5254defdc1afb52b224b3898233b..67a488a3b5787f93f9e2a9266ce04f6611b56bf8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -839,6 +839,9 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87XX_INT_PME_MASK		BIT(4)
 
 /* Interrupt */
+#define KSZ8463_REG_ISR			0x190
+#define KSZ8463_REG_IER			0x192
+
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
 

-- 
2.53.0


