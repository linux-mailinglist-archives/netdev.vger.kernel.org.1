Return-Path: <netdev+bounces-22171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25B76662F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CC1C20340
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147FC8F9;
	Fri, 28 Jul 2023 07:59:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720D10949
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:59:16 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F435B7
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:58:57 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMt-0008JF-B0
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9B0DB1FD25D
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 538301FD1B4;
	Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5dd4b066;
	Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/21] can: gs_usb: remove leading space from goto labels
Date: Fri, 28 Jul 2023 09:56:01 +0200
Message-Id: <20230728075614.1014117-9-mkl@pengutronix.de>
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

Remove leading spaces from goto labels in accordance with the kernel
encoding style.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-1-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bd9eb066ecf1..c604377138fd 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -645,7 +645,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_rx(skb);
 	}
 
- resubmit_urb:
+resubmit_urb:
 	usb_fill_bulk_urb(urb, usbcan->udev,
 			  usb_rcvbulkpipe(usbcan->udev, GS_USB_ENDPOINT_IN),
 			  hf, dev->parent->hf_size_rx,
@@ -655,7 +655,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
- device_detach:
+device_detach:
 		for (rc = 0; rc < GS_MAX_INTF; rc++) {
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
@@ -818,12 +818,12 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- badidx:
+badidx:
 	kfree(hf);
- nomem_hf:
+nomem_hf:
 	usb_free_urb(urb);
 
- nomem_urb:
+nomem_urb:
 	gs_free_tx_context(txc);
 	dev_kfree_skb(skb);
 	stats->tx_dropped++;
@@ -1354,7 +1354,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	return dev;
 
- out_free_candev:
+out_free_candev:
 	free_candev(dev->netdev);
 	return ERR_PTR(rc);
 }
-- 
2.40.1



