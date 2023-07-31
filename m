Return-Path: <netdev+bounces-22681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C26768B55
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702DB1C20AA8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FB810;
	Mon, 31 Jul 2023 05:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E37F3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 05:42:11 +0000 (UTC)
Received: from clamta20.bpe.bigpond.com (clamta20.bpe.bigpond.com [203.42.22.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCDE6A;
	Sun, 30 Jul 2023 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bigpond.com
	; s=202303; h=Content-Type:MIME-Version:Date:Message-ID:To:Subject:From;
	bh=RB+chPmKnAg5u6srg0dT76jjVkV17G3szFyN0GGa6zA=; b=nXeIzq0EmBgrUiJ0NZgrEF1oA+
	YqA45sm7oDnx759lz+RgANiX97w1j1eEWzp0nhHV3K7drkoz4mEnBl92oJVKy1hMeV8+XKZbtTKa8
	2m6U1htuplBnfNlW+z7Pq9kFIsOP47WztVaFZePNzjbsvRG/Y0N4GT7LMMzmbbqSf4IXliczHzTeb
	wRUBx3bJQiL9IdNgK6sKCWBiQUb5J5dV9y+TaQjBYHk3vChjD4K+1kYycljXcKmSf/0XEzriVGCDH
	RhfJ/J+vJ9Yi4KnaAL7q0HJkOKk5E4mFuyOXNQqOjDqWCQ0hlgOiGwVR7SGWRTx5PZjFSDhR5cwRV
	hcH0rjnA==;
Received: from claprdcmr06
	 by claprdomr20 with esmtp
	 (envelope-from <bids.7405@bigpond.com>)
	 id 1qQLfS-000EZe-2y
	 for ;
	Mon, 31 Jul 2023 15:42:06 +1000
Received: from [101.191.138.223] (helo=[10.0.0.38])
	 by claprdcmr06 with esmtpa
	(envelope-from <bids.7405@bigpond.com>)
	id 1qQLfS-000EQk-2T;
	Mon, 31 Jul 2023 15:42:06 +1000
From: Ross Maynard <bids.7405@bigpond.com>
Subject: [PATCH v2] USB: zaurus: Add ID for A-300/B-500/C-700
To: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Message-ID: <69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com>
Date: Mon, 31 Jul 2023 15:42:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-tce-id: bids.7405@bigpond.com
X-tce-ares-id: e{4fd04bcb-085f-45d8-bcef-eae48b3b2713}1
X-tce-spam-action: no action
X-tce-spam-score: 0.0
X-Cm-Analysis: v=2.4 cv=XK72CytE c=1 sm=1 tr=0 ts=64c749ae a=I+ymoOSk5yzZBOYXmf4WnA==:117 a=I+ymoOSk5yzZBOYXmf4WnA==:17 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=VwQbUJbxAAAA:8 a=1IlZJK9HAAAA:8 a=zblBDeNr1pAM3S_0FrwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Cm-Envelope: MS4xfANFe97pK+FzezDbm1skrpAjpLUXoLR/qdyHvv5trtfXBk34EskU3dFShyq8E7zo8EeXSQ2lvxNZNo8EuSWwQIXsro0ivseEI6Y+QfaGiUP/+e/gocsi oG/NEjpjYhlOT0+GF9ebs5EUGnkgdAi6kD2WbisimVFqOsIoFRBbGfGRdouETI3jiVN0zN1HSDt4OA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The SL-A300, B500/5600, and C700 devices no longer auto-load because of
"usbnet: Remove over-broad module alias from zaurus."
This patch adds IDs for those 3 devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
Fixes: 16adf5d07987 ("usbnet: Remove over-broad module alias from zaurus.")
Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
Cc: stable@vger.kernel.org
---
v2: removed reported-by since bug reporter and patch author are the same person

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

