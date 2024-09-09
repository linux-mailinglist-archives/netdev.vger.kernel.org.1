Return-Path: <netdev+bounces-126421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541F7971218
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F18A1C228FD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71D1B3734;
	Mon,  9 Sep 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VPNz+2Dt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7931B141E;
	Mon,  9 Sep 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870498; cv=none; b=s00GuMO8bmPnkap6iOS9jF2dg+M0Or1WGNHawIeEuC1ak8qQwCOB0ld4uwdIfwnrTYDnd3pAHYqpnqDyyDgqO7bafa1DUbOy6lRJTXIAxkRP/4DtXQZ4xpJdk1meXlykt7wCwibqjka4gKND86JR8pEkURJkEhtxFuSSFN0Jh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870498; c=relaxed/simple;
	bh=h7a40xJEsSy5K3OxX1zTNWZaRI04YfSGn4CI0EKDF8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoxqihjvjGyQt3Fkc2dWi9xJ7igpYooi/G2xPlWuzf9MG8lWGWkACH4M+CRTXT8BFZFul/0jRFIHKHcf7Xh5vyfQQBd5Pp1ulL8ZITRJ/pFzWWGeEGYBOzZgDIjbeSceVApl02nFo3OrGYYj35LAByyuQbU8tiybEMQt9Cf5mGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VPNz+2Dt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870498; x=1757406498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h7a40xJEsSy5K3OxX1zTNWZaRI04YfSGn4CI0EKDF8g=;
  b=VPNz+2Dt7jcPQ+iKLG1x5Ymd2VdijrgOnWzHYGgWBVsQihdXtsJTTxWR
   o+5KINjaPIYTNlkp8f48c5g52naeAbbC8HhuKKwfDLc76MnR9obuz6Gz1
   v8PCXMTo4K8PB0q7VGAkAF8ErcQZOfAhxAm8gAU23wQVBd4ATSWtUZFb1
   +isqXALFymMB0av65u7kSdKXcli3s3yBkJJt+f+hIBFG77RUI0IINggno
   5C1gnR9Fgs+LlqbJsEgtm0JJcwHEZ5qM27Q8MMYWvZPnZsq6hzJwleshv
   +IZSM5Y+GGIxora65zS77QQZDQFp+DGnQjf0DxIAMKL2KcYOX5wERIEgE
   g==;
X-CSE-ConnectionGUID: Z/y7ygwVR+qaQBBhmAQUgg==
X-CSE-MsgGUID: g6yRFxW9Q3epg1iX8o+ZTw==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="31495050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:28:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:27:38 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:27:28 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v8 12/14] net: ethernet: oa_tc6: add helper function to enable zero align rx frame
Date: Mon, 9 Sep 2024 13:55:12 +0530
Message-ID: <20240909082514.262942-13-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
References: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Zero align receive frame feature can be enabled to align all receive
ethernet frames data to start at the beginning of any receive data chunk
payload with a start word offset (SWO) of zero. Receive frames may begin
anywhere within the receive data chunk payload when this feature is not
enabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 24 ++++++++++++++++++++++++
 include/linux/oa_tc6.h        |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index d3510dc19273..f9c0dcd965c2 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -23,6 +23,7 @@
 /* Configuration Register #0 */
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -1163,6 +1164,29 @@ static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * oa_tc6_zero_align_receive_frame_enable - function to enable zero align
+ * receive frame feature.
+ * @tc6: oa_tc6 struct.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &regval);
+	if (ret)
+		return ret;
+
+	/* Set Zero-Align Receive Frame Enable */
+	regval |= CONFIG0_ZARFE_ENABLE;
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, regval);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
+
 /**
  * oa_tc6_start_xmit - function for sending the tx skb which consists ethernet
  * frame.
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 5c7811ac9cbe..15f58e3c56c7 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -21,3 +21,4 @@ int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value);
 int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
+int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
-- 
2.34.1


