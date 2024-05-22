Return-Path: <netdev+bounces-97578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E08CC2CD
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17284285B63
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6613FD8B;
	Wed, 22 May 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MaazTArG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96F43AAB;
	Wed, 22 May 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386991; cv=none; b=B8XfHu4K/Zhjx/Mwqhe3QjnP/j3GHLIfv4xqGjB0YgCh9VM0ToWY+7cgT9LI13Xi69BeDNry90XY4qbwk/aSv0EX8nx2VRJx7o96wJFrAuEJDm6VkLhfwEhgyegzCeu/WD6d6adqZ3iw2hOrJU9Nlzy+8ew8716hpc51fczYV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386991; c=relaxed/simple;
	bh=mDWoM0y/9NZiwZeSsw6wupj4kpFKNhJbzUYHPgjsHrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWYv2LHrgnOYdhdxBglOjhFQmzbzJZ7nA3N/pCmXWvw4Hxasbu24LdaZWyLj8hb/vX7qKBkB8OuvDHZop7yKI9Sm0WyjaMoVuGHXNiqVsxfF6JC/b4T6hD/NUrYihPkCPzsE4pnuCLsyago65p5jJLZAyeHCd+RzyTdOBVLrakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MaazTArG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716386989; x=1747922989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mDWoM0y/9NZiwZeSsw6wupj4kpFKNhJbzUYHPgjsHrc=;
  b=MaazTArGUOYa1Euz8VBENkEZXIdY5Vyd51ridQcYBT+4dBe4iypfW/yy
   HlwfZRO5wwc7/r+giHglMb+HRJsuwvkJLuUJX0rx6s7KypAvp2LWwLRSo
   IfpqDQ1nRV475I8y0P8UHbjXzvgj9k/8A38wgBI0JaTYYxKSh7layKFuV
   bariD9bnduHq/DwGmLBpIFi41QXzOqu2DZwxX+DRcBQyIRBJibSRUHdya
   kN6+BsCsX61aqPUe4T+Bhny9kPk6VOxLQ2UOYfCKWQ8bL9No+RlFL2b7d
   YfW3dM3g05bBIJ0NR0X68zUkEECZMg28uxoLUyHwnzr71R+GwmcVLq73W
   g==;
X-CSE-ConnectionGUID: YDHWVVWpTDmNhpERICjMxw==
X-CSE-MsgGUID: TeHhQJ9vQwif+nar/DGvUg==
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="25744430"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2024 07:08:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 May 2024 07:08:26 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 22 May 2024 07:08:22 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <steve.glendinning@shawell.net>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH] net: usb: smsc95xx: configure external LEDs function for EVB-LAN8670-USB
Date: Wed, 22 May 2024 19:38:17 +0530
Message-ID: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

By default, LAN9500A configures the external LEDs to the below function.
nSPD_LED -> Speed Indicator
nLNKA_LED -> Link and Activity Indicator
nFDX_LED -> Full Duplex Link Indicator

But, EVB-LAN8670-USB uses the below external LEDs function which can be
enabled by writing 1 to the LED Select (LED_SEL) bit in the LAN9500A.
nSPD_LED -> Speed Indicator
nLNKA_LED -> Link Indicator
nFDX_LED -> Activity Indicator

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/usb/smsc95xx.c | 12 ++++++++++++
 drivers/net/usb/smsc95xx.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index cbea24666479..05975461bf10 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1006,6 +1006,18 @@ static int smsc95xx_reset(struct usbnet *dev)
 	/* Configure GPIO pins as LED outputs */
 	write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
 		LED_GPIO_CFG_FDX_LED;
+
+	/* Set LED Select (LED_SEL) bit for the external LED pins functionality
+	 * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which
+	 * uses the below LED function.
+	 * nSPD_LED -> Speed Indicator
+	 * nLNKA_LED -> Link Indicator
+	 * nFDX_LED -> Activity Indicator
+	 */
+	if (dev->udev->descriptor.idVendor == 0x184F &&
+	    dev->udev->descriptor.idProduct == 0x0051)
+		write_buf |= LED_GPIO_CFG_LED_SEL;
+
 	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/usb/smsc95xx.h b/drivers/net/usb/smsc95xx.h
index 013bf42e27f2..134f3c2fddd9 100644
--- a/drivers/net/usb/smsc95xx.h
+++ b/drivers/net/usb/smsc95xx.h
@@ -114,6 +114,7 @@
 
 /* LED General Purpose IO Configuration Register */
 #define LED_GPIO_CFG		(0x24)
+#define LED_GPIO_CFG_LED_SEL	BIT(31)		/* Separate Link/Act LEDs */
 #define LED_GPIO_CFG_SPD_LED	(0x01000000)	/* GPIOz as Speed LED */
 #define LED_GPIO_CFG_LNK_LED	(0x00100000)	/* GPIOy as Link LED */
 #define LED_GPIO_CFG_FDX_LED	(0x00010000)	/* GPIOx as Full Duplex LED */

base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
-- 
2.34.1


