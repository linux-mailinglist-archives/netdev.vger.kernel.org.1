Return-Path: <netdev+bounces-107888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55091CC7B
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E433E1F2203E
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B316EB51;
	Sat, 29 Jun 2024 11:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D95579F
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661228; cv=none; b=V4Bgrse89rYnjavM0xhumFA5ClYfj9x7GZJikwTqjMujua57n4JRAReIhRCzXmhV4jquguZ27AuQk+LzHw8+oW8eBPzy9M5Ufur06+1JlIKJCVF/KZn7MLWiy39H/gpjCMTe4NDOgPxRoaX5vqbWIs62ze/0XJC/Dh9Mz/t2ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661228; c=relaxed/simple;
	bh=h2lZvZzN/jcl4O/IBSq2f60yL0+XAHVvSGL2GyKYGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ45+OOvjQCBbly8WuXdKXS5Jeu8ffzWPhoyT/Lrw/iFKm4S2UII3NahodlDRuhffG4+hCnFX9S/Tu6748ZfYXYAHJhhLaw8nRYtJdPLC5cC+RJDpCp7O8U9YoYr5c+Ev+XjbeG2x8Qv3g98u55yi9P8tq9fj/lnsibrCkwyN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRL-00036L-W3
	for netdev@vger.kernel.org; Sat, 29 Jun 2024 13:40:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRK-005pYu-Bz
	for netdev@vger.kernel.org; Sat, 29 Jun 2024 13:40:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 090FD2F646C
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5D9CB2F643D;
	Sat, 29 Jun 2024 11:40:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 72ff2a2e;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Andy Jackson <andy@xylanta.com>,
	Ken Aitchison <ken@xylanta.com>
Subject: [PATCH net-next 05/14] can: gs_usb: add VID/PID for Xylanta SAINT3 product family
Date: Sat, 29 Jun 2024 13:36:19 +0200
Message-ID: <20240629114017.1080160-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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

Add support for the Xylanta SAINT3 product family.

Cc: Andy Jackson <andy@xylanta.com>
Cc: Ken Aitchison <ken@xylanta.com>
Tested-by: Andy Jackson <andy@xylanta.com>
Link: https://lore.kernel.org/all/20240625140353.769373-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 65c962f76898..340297e3bec7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -40,6 +40,9 @@
 #define USB_ABE_CANDEBUGGER_FD_VENDOR_ID 0x16d0
 #define USB_ABE_CANDEBUGGER_FD_PRODUCT_ID 0x10b8
 
+#define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
+#define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
+
 #define GS_USB_ENDPOINT_IN 1
 #define GS_USB_ENDPOINT_OUT 2
 
@@ -1530,6 +1533,8 @@ static const struct usb_device_id gs_usb_table[] = {
 				      USB_CES_CANEXT_FD_PRODUCT_ID, 0) },
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_ABE_CANDEBUGGER_FD_VENDOR_ID,
 				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
+				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
 
-- 
2.43.0



