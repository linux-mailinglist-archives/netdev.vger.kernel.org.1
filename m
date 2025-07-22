Return-Path: <netdev+bounces-208761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A075B0CFC8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 04:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BF416D4EC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1218BC3B;
	Tue, 22 Jul 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZbNB9dBH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78FE4A28;
	Tue, 22 Jul 2025 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151606; cv=none; b=J7yi1XSKT0EMevHZlIrDfwgz+rI2843bg2wcR13X8w5kNz1tyKJ1z3PciTqB+o3VtsrTqdKgE529NZ7wyItfXlAdf+R2aLZ8RttaLv951dPa9ahN7FTkceDwNNiRp/8bIyX7U6LtdeYVt2u5dn6W5WJxkAmlSnDui4axW7IOQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151606; c=relaxed/simple;
	bh=N3MXY2Fzjkg4G+DrFG1Q8s+wMHcTyoteRvEv3mFkgW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHRcGINrQ67sWja+iKi+YZoYOpg2/n/vYB+oHiIEjlSSlS+OhFiV9xd56KmIpbqJ+Nrwi3Hh9QFrqwd0So8/IB6rvuefb8n+NUFVfB2QWAce+xaqLWBDTncC8BR5t+mFA4uS/8Nigkgrt31t0CyyCAeWQFGJkSTNBV9Zp5Dw+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZbNB9dBH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9A
	U9dZoI0f6Jev1bYbRTNKC2OiKt3QBUegFrMIzyg8o=; b=ZbNB9dBHmyXo8uAYWv
	yph6g0WR3W3LqNagv4JKF58ZXNLh+WE6/eaShavAYxsgDK+cO0SQjNjKK0LBSsWD
	HiQqrUsh+s9Pai472m9y2hEH8cMalPM8YMGslZXfuz+afmpZd+dQ7jIwVELM9fpE
	YMObrv7/JW2cuxOLG7HZrb8ZI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnsFxh+H5oPaiWAQ--.58916S2;
	Tue, 22 Jul 2025 10:33:08 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH] net: cdc_ncm: Fix spelling mistakes
Date: Tue, 22 Jul 2025 10:32:59 +0800
Message-Id: <20250722023259.1228935-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnsFxh+H5oPaiWAQ--.58916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryftFy8tF13tr1rJr1UWrg_yoW8XF13pF
	WkCrZ8Gr17GrW5Za18Kw4xury5Xas8GFWUt3y8Z3Z5uFnIyan7Za1jqay2ywnFqrWUGFy2
	vF1UKrW7W39Yyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jJwIhUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzRuS22h++EoDBwAAs-

From: Yi Cong <yicong@kylinos.cn>

According to the Universal Serial Bus Class Definitions for
Communications Devices v1.2, in chapter 6.3.3 table-21:
DLBitRate(downlink bit rate) seems like spelling error.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/cdc_ncm.c    | 2 +-
 include/uapi/linux/usb/cdc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 34e82f1e37d9..057ad1cf0820 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1847,7 +1847,7 @@ cdc_ncm_speed_change(struct usbnet *dev,
 		     struct usb_cdc_speed_change *data)
 {
 	/* RTL8156 shipped before 2021 sends notification about every 32ms. */
-	dev->rx_speed = le32_to_cpu(data->DLBitRRate);
+	dev->rx_speed = le32_to_cpu(data->DLBitRate);
 	dev->tx_speed = le32_to_cpu(data->ULBitRate);
 }
 
diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
index 1924cf665448..f528c8e0a04e 100644
--- a/include/uapi/linux/usb/cdc.h
+++ b/include/uapi/linux/usb/cdc.h
@@ -316,7 +316,7 @@ struct usb_cdc_notification {
 #define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
 
 struct usb_cdc_speed_change {
-	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
+	__le32	DLBitRate;	/* contains the downlink bit rate (IN pipe) */
 	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
 } __attribute__ ((packed));
 
-- 
2.25.1


