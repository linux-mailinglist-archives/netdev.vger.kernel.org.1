Return-Path: <netdev+bounces-115978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD4948A7A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6883D1F23929
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E061BDA99;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EB3C092
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930468; cv=none; b=bnrRcBIdn+1Q4Q38UjUf9LPx2TxF7++YPcZaYTmy1AvGItpQMSFWPqd432lqOEzsFwtCIEHpKbOC1aGeS+8EUsv27Oha70olAGA8OteHxgFix1O509a5Qrf7zYYBkh6iqGmCIXRTS4Vxs74hpZoYcbesnCOJJa+8g07pBIEBA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930468; c=relaxed/simple;
	bh=QJFlA2ufLT6/xwQKH92UqUp7mkt3X+CDXcdalSxBxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ6Klr8RBgnfeTdea/MyBVmIo4bTufWHpTC5VjEPELD3rl00TgY2k3ymiUCQOhav7ZlJjQDJQ0o+TvPiwllHwtj9YOZgNzn991GvZoMSo0OB4WOhCgzRANyOhspGdNN1a+2CiAJic42VAcHcjHCLVS3MxGXg1sDxjvaIjWLgYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-00047q-GN
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-004tu4-7C
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C4AE93179FE
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 708F6317985;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 286e16dd;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/20] can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
Date: Tue,  6 Aug 2024 09:42:03 +0200
Message-ID: <20240806074731.1905378-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add new struct kvaser_usb_dev_cfg constants,
kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz,
for M32C based leaf devices.

Note that the bittiming parameters are always calculated for 16MHz clock,
while the timestamps are in the actual clock frequency of the device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-8-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 00fe7410e36d..3245471e906b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -471,11 +471,27 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_usbcan_dev_cfg = {
 	.bittiming_const = &kvaser_usb_leaf_m16c_bittiming_const,
 };
 
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg = {
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_16mhz = {
 	.clock = {
 		.freq = 16 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 16,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_24mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 24,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_32mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 32,
 	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
 };
 
@@ -686,8 +702,19 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 	if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
 		/* Firmware expects bittiming parameters calculated for 16MHz
 		 * clock, regardless of the actual clock
+		 * Though, the reported freq is used for timestamps
 		 */
-		dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg;
+		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_16mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_24mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_32mhz;
+			break;
+		}
 	} else {
 		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
 		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
-- 
2.43.0



