Return-Path: <netdev+bounces-304355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wT/IJ+BNR2pMVwAAu9opvQ
	(envelope-from <netdev+bounces-304355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 356626FED8E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=ayZaZwHJ;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304355-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304355-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 530F93031904
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F038B388363;
	Fri,  3 Jul 2026 05:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0137A82D;
	Fri,  3 Jul 2026 05:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057711; cv=none; b=QsVin5FujFbNpeDDbyF67jDV6QqGL8hfGrDwJMZmgC3sSOUr0AEoAw15dAL2FRY9rpUSev3+2OkTV4jXwlDZUYphe93YKCNGSPOA3wpYVG4FaQBord/4EV2KNy1EykvWn1ofU9T7hTD/n7udEtPIpjA+yMhNXgaY8ksY5uK4/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057711; c=relaxed/simple;
	bh=8z/8/IYXD+GAAbZDDugRV9ofo7FOPESv0OxCEvxpTcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vgribr0gcwoPyNm0jqK3kCrgKrzzifhut5dWFqWu4rgtPmEyLy8PQUaWOFXq50rD5XetzAswnGYAI6K0XcmL73qMNB/yrElu1snrpzeu3tvBGJkpkUw34Sceojr1gkzOaxcI3/YjuOd3KGLNuFqbKNADtlKD8vuTbi2yofRtc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ayZaZwHJ; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057673;
	bh=MUQ95yMyKJD1s3lExqEHHR/s+SqEo3gcwnIsA/XOS3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ayZaZwHJ2TEoUVtjec+KdjBIbCQFql+Q9/87vkO9dfjYpFMujRDuMYlqB1Wj060r6
	 Iy8yI3qXzMmvHBHK+d6HjUzOr6EYPK29Oi58lcR1Bn3dHZf6TE56fWd/kqgl/KPgzF
	 UymY/wf9H36r2GYjh9hDTUIfrLgdcclHHad1XU6viO14qZfQ7cDjQinlw6xQ4Mvlem
	 s3n/ry4GPGmaXZpjEoEu8ByOvv0HIOxGdyTsuAHz07fRXh5aR/CPycZXaVb/p7lcZj
	 kQaU0QHyMy9XWABHgf3CAc2Jt7A7Hd5moYkeu8heXW++pL/u/Nxk10HvIm0iOG7Mqm
	 n0BQ8ARCrrKYQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0ACB966296; Fri,  3 Jul 2026 13:47:53 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:31 +0800
Subject: [PATCH net-next v2 11/12] net: mctp: usb: enable v1.1 packet
 spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-11-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dmtf.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 356626FED8E

Now that mctp-usblib supports DSP0283 v1.1 packet spanning, enable it in
our host-side transport driver.

Add a match for the new device subclass (0x02), and indicating spanning
mode to the usblib rx/tx implementation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index e071c2f6daea..4bf5546d520c 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -3,9 +3,9 @@
  * mctp-usb.c - MCTP-over-USB (DMTF DSP0283) transport binding driver.
  *
  * DSP0283 is available at:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
- * Copyright (C) 2024-2025 Code Construct Pty Ltd
+ * Copyright (C) 2024-2026 Code Construct Pty Ltd
  */
 
 #include <linux/module.h>
@@ -22,6 +22,7 @@
 struct mctp_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
+	bool span;
 
 	struct net_device *netdev;
 
@@ -40,6 +41,11 @@ struct mctp_usb {
 	struct usb_anchor tx_anchor;
 };
 
+enum {
+	MCTP_USB_SUBCLASS_BASE = 0x00,
+	MCTP_USB_SUBCLASS_SPAN = 0x02,
+};
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
@@ -68,6 +74,9 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			  usb_sndbulkpipe(mctp_usb->usbdev, mctp_usb->ep_out),
 			  data, len, mctp_usb_out_complete, tx_ctx);
 
+	if (mctp_usb->span)
+		urb->transfer_flags |= URB_ZERO_PACKET;
+
 	netif_stop_queue(mctp_usb->netdev);
 
 	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
@@ -246,6 +255,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *iface_desc;
 	struct net_device *netdev;
 	struct mctp_usb *dev;
+	bool span;
 	int rc;
 
 	/* only one alternate */
@@ -257,6 +267,8 @@ static int mctp_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	span = iface_desc->desc.bInterfaceSubClass == MCTP_USB_SUBCLASS_SPAN;
+
 	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
 			      mctp_usb_netdev_setup);
 	if (!netdev)
@@ -264,14 +276,17 @@ static int mctp_usb_probe(struct usb_interface *intf,
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	dev = netdev_priv(netdev);
+	dev->span = span;
 	dev->netdev = netdev;
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
+	if (dev->span)
+		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
 	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx, false);
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
+	mctp_usblib_rx_init(&dev->rx, dev->span);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, dev->span);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
@@ -312,7 +327,8 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id mctp_usb_devices[] = {
-	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, 0x0, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_BASE, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_SPAN, 0x1) },
 	{ 0 },
 };
 

-- 
2.47.3


