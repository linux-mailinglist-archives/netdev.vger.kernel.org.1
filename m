Return-Path: <netdev+bounces-225205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EEB8FEF2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 001C14E2098
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83B3009DA;
	Mon, 22 Sep 2025 10:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE82FE569
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535766; cv=none; b=HrytOzfBPWqF2E6KM0U4TJgeAAfRBMi2hEOdbblES5cZ6Vi+VSJLx+2ZiNvNMtajo1MJaoX+Stc5QuGRb3Y60/C8XNHA8GYVFFJJvRNSAGC2ZewtyArVWpIC8PQePXHz7WWQM3LpPCwCEgoBVMwBXYSqiRTx2+FhrCBlMEcFXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535766; c=relaxed/simple;
	bh=3Ioq8g5JzziKDp1afhnQk7995z/AAUZ3ScoJiWjuhMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu6UlbYGwIhoKGPoGNOcxGX9bywiUF5krkBB03ANdPtTCybzchiS9RjyE0HYVd921tky8FUbsyrYa/iS2OmzaYDVh4aDzFg3xs1KOfL6xa+YK5Sax0JYh4Us2YoiQD29IGlEVG5ixz2wOqJb4OZOLicBFGNhoNC4YxXMNboG5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU2-0006zn-7C
	for netdev@vger.kernel.org; Mon, 22 Sep 2025 12:09:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU0-002ZXT-3A
	for netdev@vger.kernel.org;
	Mon, 22 Sep 2025 12:09:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A83C9476D31
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:09:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CFC67476CF2;
	Mon, 22 Sep 2025 10:09:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 267672ab;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/10] can: esd_usb: Add watermark handling for TX jobs
Date: Mon, 22 Sep 2025 12:07:40 +0200
Message-ID: <20250922100913.392916-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922100913.392916-1-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

The driver tried to keep as much CAN frames as possible submitted to the
USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
context" error messages in high load situations like with
"cangen -g 0 -p 10 canX".

Now call netif_stop_queue() already if the number of active jobs
reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS. The
netif_start_queue() is called in esd_usb_tx_done_msg() only if the
number of active jobs is <= ESD_USB_TX_URBS_LO_WM.

This change eliminates the occasional error messages and significantly
reduces the number of calls to netif_start_queue() and
netif_stop_queue().

The watermark limits have been chosen with the CAN-USB/Micro in mind to
not to compromise its TX throughput. This device is running on USB 1.1
only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
value below 9 decreases the TX throughput.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-4-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index efc96619ee9a..40ffac0e73e9 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -98,6 +98,8 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
+#define ESD_USB_TX_URBS_HI_WM		((15 * ESD_USB_MAX_TX_URBS) / 16)
+#define ESD_USB_TX_URBS_LO_WM		((9 * ESD_USB_MAX_TX_URBS) / 16)
 #define ESD_USB_DRAIN_TIMEOUT_MS	100
 
 /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
@@ -478,7 +480,8 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	if (!netif_device_present(netdev))
 		return;
 
-	netif_wake_queue(netdev);
+	if (atomic_read(&priv->active_tx_jobs) <= ESD_USB_TX_URBS_LO_WM)
+		netif_wake_queue(netdev);
 }
 
 static void esd_usb_read_bulk_callback(struct urb *urb)
@@ -987,7 +990,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->priv = priv;
 	context->echo_index = i;
 
-	/* hnd must not be 0 - MSB is stripped in txdone handling */
+	/* hnd must not be 0 - MSB is stripped in TX done handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
@@ -1002,8 +1005,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 
 	atomic_inc(&priv->active_tx_jobs);
 
-	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_MAX_TX_URBS)
+	/* Slow down TX path */
+	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_TX_URBS_HI_WM)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.51.0



