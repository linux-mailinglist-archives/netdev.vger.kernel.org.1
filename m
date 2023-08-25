Return-Path: <netdev+bounces-30797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B356789242
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA15D2817D7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7D1AA71;
	Fri, 25 Aug 2023 23:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B85198B2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 23:15:30 +0000 (UTC)
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 16:15:29 PDT
Received: from mx.antonionapolitano.net (host-97-108-136-83.retail.pianetafibra.it [83.136.108.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5742109;
	Fri, 25 Aug 2023 16:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polit.no; s=dkim;
	t=1693004752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8hVBVaP53VtAK42XNl5f1DuEIUO3+COzZI4DkUPvW6c=;
	b=fo+MX7iQl6PLGiS7Pd1ANp4AwP0xVOScgS3yGiu+z8dGezBhoiC7ew5thzkuO+XvhHLb14
	dGUqaCivWkOau1Q+p/TB2GO5reniJq8lA9pwvOLt9j2/hPwdZ2afoy/HeD0Y34Wl/oyM8U
	szhREela6pEWdjyY/4sYJAzc+I0kNHXhN1bMVoI6LR1TUewOfzXZSdUQt6QuvU8IquKtB0
	jpX785x4Rwc6wkHMRP4fUZbwELZ4MkovXLG5B17Ag4wUWbZqHWV5AgDBRM3xjAiMA9PTmA
	a+zRMq++OjtOKGLVgaMUda93Eo875IYUXylRxatwJDdhr2l0kKPRD18Ej34UTg==
Authentication-Results: mx.antonionapolitano.net;
	auth=pass smtp.mailfrom=anton@polit.no
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Aug 2023 01:05:50 +0200
Cc: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] r8152: add vendor/device ID pair for D-Link
 DUB-E250
From: "Antonio Napolitano" <anton@polit.no>
To: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
Message-Id: <CV200KJEEUPC.WPKAHXCQJ05I@mercurius>
X-Spamd-Bar: /
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The D-Link DUB-E250 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Antonio Napolitano <anton@polit.no>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index bb234cf0cea0..332c853ca99b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9832,6 +9832,7 @@ static const struct usb_device_id rtl8152_table[] =3D=
 {
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
+	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
 	{}
 };
=20
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 20d88b1defc3..287e9d83fb8b 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -29,6 +29,7 @@
 #define VENDOR_ID_LINKSYS		0x13b1
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
+#define VENDOR_ID_DLINK			0x2001
=20
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
--=20
2.42.0


