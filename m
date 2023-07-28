Return-Path: <netdev+bounces-22178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4598766646
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036A81C21225
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49411198;
	Fri, 28 Jul 2023 07:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C7125D2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:59:21 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE33C06
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:59:03 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMw-0008NZ-Pe
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DB04F1FD276
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B1F791FD1D1;
	Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dfdc1984;
	Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/21] can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
Date: Fri, 28 Jul 2023 09:56:04 +0200
Message-Id: <20230728075614.1014117-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
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

To ease readability and maintainability uniformly use the variable
name "parent" for the struct gs_usb in the gs_usb driver.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-4-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1e08d38b0f96..441143ad740b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -524,7 +524,7 @@ static void gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
 
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
-	struct gs_usb *usbcan = urb->context;
+	struct gs_usb *parent = urb->context;
 	struct gs_can *dev;
 	struct net_device *netdev;
 	int rc;
@@ -535,7 +535,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	struct canfd_frame *cfd;
 	struct sk_buff *skb;
 
-	BUG_ON(!usbcan);
+	BUG_ON(!parent);
 
 	switch (urb->status) {
 	case 0: /* success */
@@ -552,7 +552,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->channel >= GS_MAX_INTF)
 		goto device_detach;
 
-	dev = usbcan->canch[hf->channel];
+	dev = parent->canch[hf->channel];
 
 	netdev = dev->netdev;
 	stats = &netdev->stats;
@@ -644,10 +644,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 resubmit_urb:
-	usb_fill_bulk_urb(urb, usbcan->udev,
-			  usb_rcvbulkpipe(usbcan->udev, GS_USB_ENDPOINT_IN),
+	usb_fill_bulk_urb(urb, parent->udev,
+			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
 			  hf, dev->parent->hf_size_rx,
-			  gs_usb_receive_bulk_callback, usbcan);
+			  gs_usb_receive_bulk_callback, parent);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
@@ -655,8 +655,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (rc == -ENODEV) {
 device_detach:
 		for (rc = 0; rc < GS_MAX_INTF; rc++) {
-			if (usbcan->canch[rc])
-				netif_device_detach(usbcan->canch[rc]->netdev);
+			if (parent->canch[rc])
+				netif_device_detach(parent->canch[rc]->netdev);
 		}
 	}
 }
@@ -1369,7 +1369,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct gs_host_frame *hf;
-	struct gs_usb *dev;
+	struct gs_usb *parent;
 	struct gs_host_config hconf = {
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
@@ -1412,49 +1412,49 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return -EINVAL;
 	}
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	if (!parent)
 		return -ENOMEM;
 
-	init_usb_anchor(&dev->rx_submitted);
+	init_usb_anchor(&parent->rx_submitted);
 
-	usb_set_intfdata(intf, dev);
-	dev->udev = udev;
+	usb_set_intfdata(intf, parent);
+	parent->udev = udev;
 
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-		dev->canch[i] = gs_make_candev(i, intf, &dconf);
-		if (IS_ERR_OR_NULL(dev->canch[i])) {
+		parent->canch[i] = gs_make_candev(i, intf, &dconf);
+		if (IS_ERR_OR_NULL(parent->canch[i])) {
 			/* save error code to return later */
-			rc = PTR_ERR(dev->canch[i]);
+			rc = PTR_ERR(parent->canch[i]);
 
 			/* on failure destroy previously created candevs */
 			icount = i;
 			for (i = 0; i < icount; i++)
-				gs_destroy_candev(dev->canch[i]);
+				gs_destroy_candev(parent->canch[i]);
 
-			usb_kill_anchored_urbs(&dev->rx_submitted);
-			kfree(dev);
+			usb_kill_anchored_urbs(&parent->rx_submitted);
+			kfree(parent);
 			return rc;
 		}
-		dev->canch[i]->parent = dev;
+		parent->canch[i]->parent = parent;
 
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
-			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
 			else
 				hf_size_rx = struct_size(hf, canfd, 1);
 		} else {
-			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, classic_can_ts, 1);
 			else
 				hf_size_rx = struct_size(hf, classic_can, 1);
 		}
-		dev->hf_size_rx = max(dev->hf_size_rx, hf_size_rx);
+		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
 	return 0;
@@ -1462,22 +1462,22 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 static void gs_usb_disconnect(struct usb_interface *intf)
 {
-	struct gs_usb *dev = usb_get_intfdata(intf);
+	struct gs_usb *parent = usb_get_intfdata(intf);
 	unsigned int i;
 
 	usb_set_intfdata(intf, NULL);
 
-	if (!dev) {
+	if (!parent) {
 		dev_err(&intf->dev, "Disconnect (nodata)\n");
 		return;
 	}
 
 	for (i = 0; i < GS_MAX_INTF; i++)
-		if (dev->canch[i])
-			gs_destroy_candev(dev->canch[i]);
+		if (parent->canch[i])
+			gs_destroy_candev(parent->canch[i]);
 
-	usb_kill_anchored_urbs(&dev->rx_submitted);
-	kfree(dev);
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+	kfree(parent);
 }
 
 static const struct usb_device_id gs_usb_table[] = {
-- 
2.40.1



