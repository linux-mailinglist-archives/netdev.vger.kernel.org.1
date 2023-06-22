Return-Path: <netdev+bounces-12971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA17399B8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216342818BC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA921E508;
	Thu, 22 Jun 2023 08:27:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703351E505
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:33 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36026A1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFeo-0002Zp-1H
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A0CF41DF3B9
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0827B1DF350;
	Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id da398c40;
	Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/33] can: esd_usb: Make use of kernel macros BIT() and GENMASK()
Date: Thu, 22 Jun 2023 10:26:34 +0200
Message-Id: <20230622082658.571150-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Frank Jungclaus <frank.jungclaus@esd.eu>

Make use of kernel macros BIT() and GENMASK().

Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230523173105.3175086-2-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 1399b832ea3f..d40a04db7458 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -67,23 +67,23 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_TRIPLE_SAMPLES	BIT(23)
 
 /* esd IDADD message */
-#define ESD_USB_ID_ENABLE	0x80
+#define ESD_USB_ID_ENABLE	BIT(7)
 #define ESD_USB_MAX_ID_SEGMENT	64
 
 /* SJA1000 ECC register (emulated by usb firmware) */
-#define ESD_USB_SJA1000_ECC_SEG		0x1F
-#define ESD_USB_SJA1000_ECC_DIR		0x20
-#define ESD_USB_SJA1000_ECC_ERR		0x06
+#define ESD_USB_SJA1000_ECC_SEG		GENMASK(4, 0)
+#define ESD_USB_SJA1000_ECC_DIR		BIT(5)
+#define ESD_USB_SJA1000_ECC_ERR		BIT(2, 1)
 #define ESD_USB_SJA1000_ECC_BIT		0x00
-#define ESD_USB_SJA1000_ECC_FORM	0x40
-#define ESD_USB_SJA1000_ECC_STUFF	0x80
-#define ESD_USB_SJA1000_ECC_MASK	0xc0
+#define ESD_USB_SJA1000_ECC_FORM	BIT(6)
+#define ESD_USB_SJA1000_ECC_STUFF	BIT(7)
+#define ESD_USB_SJA1000_ECC_MASK	GENMASK(7, 6)
 
 /* esd bus state event codes */
-#define ESD_USB_BUSSTATE_MASK	0xc0
-#define ESD_USB_BUSSTATE_WARN	0x40
-#define ESD_USB_BUSSTATE_ERRPASSIVE	0x80
-#define ESD_USB_BUSSTATE_BUSOFF	0xc0
+#define ESD_USB_BUSSTATE_MASK	GENMASK(7, 6)
+#define ESD_USB_BUSSTATE_WARN	BIT(6)
+#define ESD_USB_BUSSTATE_ERRPASSIVE	BIT(7)
+#define ESD_USB_BUSSTATE_BUSOFF	GENMASK(7, 6)
 
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
@@ -652,9 +652,9 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	msg->filter.net = priv->index;
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i < ESD_USB_MAX_ID_SEGMENT; i++)
-		msg->filter.mask[i] = cpu_to_le32(0xffffffff);
+		msg->filter.mask[i] = cpu_to_le32(GENMASK(31, 0));
 	/* enable 29bit extended IDs */
-	msg->filter.mask[ESD_USB_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
+	msg->filter.mask[ESD_USB_MAX_ID_SEGMENT] = cpu_to_le32(BIT(0));
 
 	err = esd_usb_send_msg(dev, msg);
 	if (err)
@@ -796,7 +796,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->echo_index = i;
 
 	/* hnd must not be 0 - MSB is stripped in txdone handling */
-	msg->tx.hnd = 0x80000000 | i; /* returned in TX done message */
+	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
 			  msg->hdr.len * sizeof(u32), /* convert to # of bytes */
-- 
2.40.1



