Return-Path: <netdev+bounces-18449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8787570D1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 02:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D321C20BDA
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE57EA;
	Tue, 18 Jul 2023 00:17:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07D19C
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:17:06 +0000 (UTC)
Received: from exhmta17.bpe.bigpond.com (exhmta17.bpe.bigpond.com [203.42.40.161])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0A188;
	Mon, 17 Jul 2023 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bigpond.com
	; s=202303; h=Content-Type:MIME-Version:Date:Message-ID:To:Subject:From;
	bh=Q0ZgKzQZd4FX/D+rysn1QvJp6Cn5FgznCU7I/mWePQ4=; b=BdTVojFH19bpzxzE0yOoEysqxW
	nTsF+DV2Pr+MJz6UwYbf9h68cp8N1BhSi+33fVlWx65wYuynKeNI+gHNM4WV7TnD3dQfmu+gAVb02
	uah9YwcrdlIKxPc9gX1avo+sCG8WSUmhndLtUR2kkHm+Gkdi9e+5iAEH9VV0N140Jj4ibE37FR7aI
	jsNUsFbtOuTjHo+Ad51RW6kQeUflRz4shuX3jv6eal4ymAZ0rRFft2GcEh2Q7LooMKtUH+0pVRg/l
	XmcO1o3bvM/bYvdvI8PSHG4qZiq1hQuJc9Xy1hFTx20ItoyHuaKYi/J3KqdBmmEqZm6IypnucEAlm
	y22YvjeQ==;
Received: from exhprdcmr03
	 by exhprdomr17 with esmtp
	 (envelope-from <bids.7405@bigpond.com>)
	 id 1qLYOh-0007Hk-1c
	 for ;
	Tue, 18 Jul 2023 10:16:59 +1000
Received: from [101.191.138.223] (helo=[10.0.0.38])
	 by exhprdcmr03 with esmtpa
	(envelope-from <bids.7405@bigpond.com>)
	id 1qLYOh-0008eX-0y;
	Tue, 18 Jul 2023 10:16:59 +1000
From: Ross Maynard <bids.7405@bigpond.com>
Subject: [PATCH] USB: zaurus: 3 broken Zaurus devices
To: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Message-ID: <4963f4df-e36d-94e2-a045-48469ab2a892@bigpond.com>
Date: Tue, 18 Jul 2023 10:16:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D0D6B9EE406C3C126D1D9B9D"
Content-Language: en-US
X-tce-id: bids.7405@bigpond.com
X-tce-ares-id: e{574c812c-f7a5-4f03-878b-cf17a3d432d5}1
X-tce-spam-action: no action
X-tce-spam-score: 0.0
X-Cm-Analysis: v=2.4 cv=PNXJu9mC c=1 sm=1 tr=0 ts=64b5d9fb a=I+ymoOSk5yzZBOYXmf4WnA==:117 a=I+ymoOSk5yzZBOYXmf4WnA==:17 a=ws7JD89P4LkA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8 a=vca9FNj1airBrpF0sQMA:9 a=QEXdDO2ut3YA:10 a=1IlZJK9HAAAA:8 a=iXZdpN1a21TaRPcZ4IIA:9 a=B2y7HmGcmWMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Cm-Envelope: MS4xfFavOt6c0+/h0YKaw/uC8Di/Vg708bI+MXh28FIG7Xg911w3ZUQsfPpxhK6xb2OJyNSiVtiFOzuZ7tEhBItCM2PWoe7y5ky4CaXdB/IXmvL3/rOBRvxr 43RBBWMk7IfE/W9GRC4sLFQHdfQfmLECNB0PCIwINoafXlRpb3rlXINp3EcjS5MYiKoO2Gu3cq1cNA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------D0D6B9EE406C3C126D1D9B9D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

This is related to Oliver Neukum's patch 
6605cc67ca18b9d583eb96e18a20f5f4e726103c (USB: zaurus: support another 
broken Zaurus) which you committed in 2022 to fix broken support for the 
Zaurus SL-6000.

Prior to that I had been able to track down the original offending patch 
using git bisect as you had suggested to me: 
16adf5d07987d93675945f3cecf0e33706566005 (usbnet: Remove over-broad 
module alias from zaurus).

It turns out that the offending patch also broke support for 3 other 
Zaurus models: A300, C700 and B500/SL-5600. My patch adds the 3 device 
IDs to the driver in the same way Oliver added the SL-6000 ID in his patch.

Could you please review the attached patch? I tested it on all 3 devices 
and it fixed the problem. For your reference, the associated bug URL is 
https://bugzilla.kernel.org/show_bug.cgi?id=217632.

Thank you.

Regards,

Ross


--------------D0D6B9EE406C3C126D1D9B9D
Content-Type: text/x-patch; charset=UTF-8;
 name="3-broken-zaurus-devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="3-broken-zaurus-devices.patch"

Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
Reported-by: Ross Maynard <bids.7405@bigpond.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
---
 drivers/net/usb/cdc_ether.c | 21 +++++++++++++++++++++
 drivers/net/usb/zaurus.c    | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -616,6 +616,13 @@ static const struct usb_device_id	products[] = {
 }, {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,   /* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
@@ -623,12 +630,26 @@ static const struct usb_device_id	products[] = {
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,   /* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,   /* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -289,9 +289,23 @@ static const struct usb_device_id	products [] = {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,	/* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,	/* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 	          | USB_DEVICE_ID_MATCH_DEVICE,
@@ -301,6 +315,13 @@ static const struct usb_device_id	products [] = {
 	.driver_info = ZAURUS_PXA_INFO,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,	/* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */


--------------D0D6B9EE406C3C126D1D9B9D--

