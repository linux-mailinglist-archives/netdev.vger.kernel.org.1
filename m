Return-Path: <netdev+bounces-297258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HynbE3JvKGpcEgMAu9opvQ
	(envelope-from <netdev+bounces-297258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:54:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC128663EEA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=UWDTp8Nw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED0E30A19A0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC924A2E3D;
	Tue,  9 Jun 2026 19:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDF3FD956;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034640; cv=none; b=jtHTbYybF/XdduvpNlMG+XnMfhAxBAvjY16ZRVM3j94z/0/2/afrFhJHKXx+Se74jsgrdCml5FzpUtNTw3cB0oJkTG6JUupEuRnS1xhWTiGM+EXSg9ri2v/zdzpt/flXS0WbxGUUTJiuD+lHFVvRN5yaQyXuNOZO3E1UxdwDn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034640; c=relaxed/simple;
	bh=CwjVDy1c0PArAWwJSXHKyClS4Xeu5WPHX1xEaCP7+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYYklmC77AdQIxGd6gShmSW3WdGrE8MpSmJE/J/UugcSXC45QclHoGPtssc8LvyyhT8Rev+BtUhl/eTgueEN8LkrRn0dYYh+Q3N12PSxTrgU6L7WU2hCJsgIqZMAVWpsxdg1GDL4NyhYuRklfDk507f9AqhZ+rx+s711K6q5b7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWDTp8Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ACB5C2BCB4;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781034639;
	bh=CwjVDy1c0PArAWwJSXHKyClS4Xeu5WPHX1xEaCP7+Bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UWDTp8NwEdPKIU4AIjsR/yHJi7IxXMzhvfRbeSbtx8TwNiINgq3ACJP+ibYcMUv/A
	 mHr/e3h7U8G0jPOh8RGe9TYsqu19iT6Df6JxtjmC0rTLtpZkdiGBD5LZPg3UucJEWA
	 zHHVNuSMd8BAh/KM5hQtzKstomo9PzYEJuxj4Xdze75Y8+ml40N3C9PhyhKHPJJVJy
	 HXoigbgcQUHqQ4UQj3WVmVRutPMpSfZywaZemTsz4jmqqU3OMcWqeAvUK6GqY72V4J
	 BueXMEZ86ggjGcsW9Sa0VIXDbYotjaV8B2SX8CN3N9BhxTDFHSDvEjHlekLqIy0Kat
	 GrDUkS3If+u1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5405DCD8CAD;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Tue, 09 Jun 2026 12:50:24 -0700
Subject: [PATCH net v4 1/4] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-level-trigger-v4-1-6f389abdd192@onsemi.com>
References: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
In-Reply-To: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781034634; l=4799;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=bZcfH7V1Z8MHdt+nWQSb/fIOda9dy2Hl2VbkMljBA1w=;
 b=9gr4xSZH37mafmQ4UaQs9vfCR2Zv/GZ80VUDKHkXRAaQX/4l/8KMF9lXkRThjc1O1Vf/OOBdl
 6eFW5En1j5mBsuYEK9K4b2ldo5qmqXNuvD5DOAu6u7LN71LTZm97g4G
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297258-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:pier.beruto@onsemi.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:replyto,onsemi.com:email,onsemi.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC128663EEA

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

According OPEN Alliance 10BASET1x MAC-PHY Serial Interface
specification, interrupt is active low, level triggered.

Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Changes in v4:
  Interrupt handling mechanism changed to threaded irq because it is
  best suited to handle level triggered interrupt. Threaded irq
  automatically blocks further interrupts until interrupting
  conditions are cleared by its handler.

Changes in v3:
 interrupt registered as level triggerred
---
 drivers/net/ethernet/oa_tc6.c | 61 ++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a7918a..e2c0843207f2 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
+#include <linux/interrupt.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
@@ -121,8 +122,6 @@ struct oa_tc6 {
 	struct sk_buff *ongoing_tx_skb;
 	struct sk_buff *waiting_tx_skb;
 	struct sk_buff *rx_skb;
-	struct task_struct *spi_thread;
-	wait_queue_head_t spi_wq;
 	u16 tx_skb_offset;
 	u16 spi_data_tx_buf_offset;
 	u16 tx_credits;
@@ -1105,29 +1104,18 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 	return 0;
 }
 
-static int oa_tc6_spi_thread_handler(void *data)
+static irqreturn_t oa_tc6_macphy_threaded_irq(int irq, void *data)
 {
 	struct oa_tc6 *tc6 = data;
-	int ret;
-
-	while (likely(!kthread_should_stop())) {
-		/* This kthread will be waken up if there is a tx skb or mac-phy
-		 * interrupt to perform spi transfer with tx chunks.
-		 */
-		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
-					 (tc6->waiting_tx_skb &&
-					 tc6->tx_credits) ||
-					 kthread_should_stop());
-
-		if (kthread_should_stop())
-			break;
+	int ret = 0;
 
+	while (tc6->int_flag || (tc6->waiting_tx_skb && tc6->tx_credits)) {
 		ret = oa_tc6_try_spi_transfer(tc6);
 		if (ret)
-			return ret;
+			break;
 	}
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static int oa_tc6_update_buffer_status_from_register(struct oa_tc6 *tc6)
@@ -1162,10 +1150,8 @@ static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
 	 * - extended status event not reported in the previous rx footer.
 	 */
 	tc6->int_flag = true;
-	/* Wake spi kthread to perform spi transfer */
-	wake_up_interruptible(&tc6->spi_wq);
-
-	return IRQ_HANDLED;
+	/* Wake IRQ thread to perform spi transfer */
+	return IRQ_WAKE_THREAD;
 }
 
 /**
@@ -1217,8 +1203,8 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 	tc6->waiting_tx_skb = skb;
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
-	/* Wake spi kthread to perform spi transfer */
-	wake_up_interruptible(&tc6->spi_wq);
+	/* Wake the threaded IRQ to perform spi transfer. */
+	irq_wake_thread(tc6->spi->irq, tc6);
 
 	return NETDEV_TX_OK;
 }
@@ -1311,24 +1297,15 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		goto phy_exit;
 	}
 
-	init_waitqueue_head(&tc6->spi_wq);
-
-	tc6->spi_thread = kthread_run(oa_tc6_spi_thread_handler, tc6,
-				      "oa-tc6-spi-thread");
-	if (IS_ERR(tc6->spi_thread)) {
-		dev_err(&tc6->spi->dev, "Failed to create SPI thread\n");
-		goto phy_exit;
-	}
-
-	sched_set_fifo(tc6->spi_thread);
-
-	ret = devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_isr,
-			       IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
-			       tc6);
+	ret = devm_request_threaded_irq(&tc6->spi->dev, tc6->spi->irq,
+					oa_tc6_macphy_isr,
+					oa_tc6_macphy_threaded_irq,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					dev_name(&tc6->spi->dev), tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev, "Failed to request macphy isr %d\n",
 			ret);
-		goto kthread_stop;
+		goto phy_exit;
 	}
 
 	/* oa_tc6_sw_reset_macphy() function resets and clears the MAC-PHY reset
@@ -1338,12 +1315,9 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	 * 7.7 and 9.2.8.8 in the OPEN Alliance specification for more details.
 	 */
 	tc6->int_flag = true;
-	wake_up_interruptible(&tc6->spi_wq);
+	irq_wake_thread(tc6->spi->irq, tc6);
 
 	return tc6;
-
-kthread_stop:
-	kthread_stop(tc6->spi_thread);
 phy_exit:
 	oa_tc6_phy_exit(tc6);
 	return NULL;
@@ -1357,7 +1331,6 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
 	oa_tc6_phy_exit(tc6);
-	kthread_stop(tc6->spi_thread);
 	dev_kfree_skb_any(tc6->ongoing_tx_skb);
 	dev_kfree_skb_any(tc6->waiting_tx_skb);
 	dev_kfree_skb_any(tc6->rx_skb);

-- 
2.43.0



