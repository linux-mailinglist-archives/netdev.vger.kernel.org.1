Return-Path: <netdev+bounces-227288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42373BABF4F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE213A480D
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A262F3636;
	Tue, 30 Sep 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iKR/2yeR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445602C0F71;
	Tue, 30 Sep 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219711; cv=none; b=SXtG6vgHYlTGaiTI93M6R9J8Shk2AGfbJ/F1sKkKlgdYKzl9Hnk5JoeS5XKIlT7YSq5JSjrzd1kjJ95Cbsml+5LRHWD59NmnXF9BRvZLR0QFM6nS2BsgqwI+oM9Rag54Lpv1v3y73bwyMkrUrKOmREMYYWSuXPz0xN5S/Tpo8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219711; c=relaxed/simple;
	bh=9WGAd4vVIKc3s7UlQIBT25/OrUd3rKMdavQMSCnYfy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc+i64xClKG4DAX99wVURSkFmYRgT+2JXIS6o4BAt6XoOauxa7kWlhxkzlVUuMdiwWokzxIJO+0ujV+/v54CBNTHHJhOoMw/BaOId6i4170IGrQdHEohTXTRq1a2NI6oYTyRFGasRAoEDgmVXDCxsDoOVew1JRHiDcllM7kjQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iKR/2yeR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hc
	njkVa6WlJcQUTouHtEfydAEfTLWoPvCPrVuyQadMo=; b=iKR/2yeRB1saUxWgVd
	erJarCUphU1x+2klnWlpDbPzDt3ywdT06gEnxt8k/zkr7WSm5zZxdJnUDqn9TdWU
	CmvSSzTgtu8hv82bHUnrFcOxYyc1oyEMQ3O14Q3NcyrwM1GkeVNF/h1AWPUIJIbK
	i35H+fsCuZ96Op8VDzJvH0MrQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3N+Gvj9towMZUAg--.26308S2;
	Tue, 30 Sep 2025 16:07:12 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	marcan@marcan.st,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: [PATCH v4 1/3] Revert "net: usb: ax88179_178a: Bind only to vendor-specific interface"
Date: Tue, 30 Sep 2025 16:07:07 +0800
Message-Id: <20250930080709.3408463-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC3N+Gvj9towMZUAg--.26308S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWDCw17AFWkKFWkXr4fKrg_yoWrCr43pF
	43KryF9rZxWFW5Krnavr1kua98Aws7K39Ika12gw17Z3Z3JF1SqasxAF47A34UXr4rAw12
	vr97ArW2kF1kGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8kucUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUAnY22jbjZEpYgACs8

From: Yi Cong <yicong@kylinos.cn>

This reverts commit c67cc4315a8e605ec875bd3a1210a549e3562ddc.

Currently, in the Linux kernel, USB NIC with ASIX chips use the cdc_ncm
driver. However, this driver lacks functionality and performs worse than
the vendor's proprietary driver. In my testing, I have identified the
following issues:

1. The cdc_ncm driver does not support changing the link speed via
   ethtool because the corresponding callback function is set to NULL.
2. The CDC protocol does not support retrieving the network duplex status.
3. In TCP_RR and UDP_RR tests, the performance of the cdc_ncm driver
   is significantly lower than that of the vendor's driver:
Average of three netperf runs: `netperf -t {TCP/UDP_RR} -H serverIP -l 120`
- cdc_ncm.ko: TCP_RR: 740, UDP_RR: 750
- ax88179_178a.ko: TCP_RR: 8900, UDP_RR: 9200

Issues related to the vendor's driver ax88179_178a.ko will be addressed
in the next patch.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/ax88179_178a.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b034ef8a73ea..29cbe9ddd610 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1885,55 +1885,55 @@ static const struct driver_info at_umc2000sp_info = {
 static const struct usb_device_id products[] = {
 {
 	/* ASIX AX88179 10/100/1000 */
-	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
+	USB_DEVICE(0x0b95, 0x1790),
 	.driver_info = (unsigned long)&ax88179_info,
 }, {
 	/* ASIX AX88178A 10/100/1000 */
-	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x178a, 0xff, 0xff, 0),
+	USB_DEVICE(0x0b95, 0x178a),
 	.driver_info = (unsigned long)&ax88178a_info,
 }, {
 	/* Cypress GX3 SuperSpeed to Gigabit Ethernet Bridge Controller */
-	USB_DEVICE_AND_INTERFACE_INFO(0x04b4, 0x3610, 0xff, 0xff, 0),
+	USB_DEVICE(0x04b4, 0x3610),
 	.driver_info = (unsigned long)&cypress_GX3_info,
 }, {
 	/* D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x4a00, 0xff, 0xff, 0),
+	USB_DEVICE(0x2001, 0x4a00),
 	.driver_info = (unsigned long)&dlink_dub1312_info,
 }, {
 	/* Sitecom USB 3.0 to Gigabit Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0072, 0xff, 0xff, 0),
+	USB_DEVICE(0x0df6, 0x0072),
 	.driver_info = (unsigned long)&sitecom_info,
 }, {
 	/* Samsung USB Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x04e8, 0xa100, 0xff, 0xff, 0),
+	USB_DEVICE(0x04e8, 0xa100),
 	.driver_info = (unsigned long)&samsung_info,
 }, {
 	/* Lenovo OneLinkDock Gigabit LAN */
-	USB_DEVICE_AND_INTERFACE_INFO(0x17ef, 0x304b, 0xff, 0xff, 0),
+	USB_DEVICE(0x17ef, 0x304b),
 	.driver_info = (unsigned long)&lenovo_info,
 }, {
 	/* Belkin B2B128 USB 3.0 Hub + Gigabit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x0128, 0xff, 0xff, 0),
+	USB_DEVICE(0x050d, 0x0128),
 	.driver_info = (unsigned long)&belkin_info,
 }, {
 	/* Toshiba USB 3.0 GBit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x0930, 0x0a13, 0xff, 0xff, 0),
+	USB_DEVICE(0x0930, 0x0a13),
 	.driver_info = (unsigned long)&toshiba_info,
 }, {
 	/* Magic Control Technology U3-A9003 USB 3.0 Gigabit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x0711, 0x0179, 0xff, 0xff, 0),
+	USB_DEVICE(0x0711, 0x0179),
 	.driver_info = (unsigned long)&mct_info,
 }, {
 	/* Allied Telesis AT-UMC2000 USB 3.0/USB 3.1 Gen 1 to Gigabit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x07c9, 0x000e, 0xff, 0xff, 0),
+	USB_DEVICE(0x07c9, 0x000e),
 	.driver_info = (unsigned long)&at_umc2000_info,
 }, {
 	/* Allied Telesis AT-UMC200 USB 3.0/USB 3.1 Gen 1 to Fast Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x07c9, 0x000f, 0xff, 0xff, 0),
+	USB_DEVICE(0x07c9, 0x000f),
 	.driver_info = (unsigned long)&at_umc200_info,
 }, {
 	/* Allied Telesis AT-UMC2000/SP USB 3.0/USB 3.1 Gen 1 to Gigabit Ethernet Adapter */
-	USB_DEVICE_AND_INTERFACE_INFO(0x07c9, 0x0010, 0xff, 0xff, 0),
+	USB_DEVICE(0x07c9, 0x0010),
 	.driver_info = (unsigned long)&at_umc2000sp_info,
 },
 	{ },
-- 
2.25.1


