Return-Path: <netdev+bounces-113210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9193D357
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E52B23181
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B917DE13;
	Fri, 26 Jul 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PyKQftA5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5C17C7A5;
	Fri, 26 Jul 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997654; cv=none; b=sX4kXpeiXYLmclqDesEYy8jWjw4cNqMAwcrUFj6SjvO8C5YOBLtMAugZBaXTNFVTBX/bcDzHvMggNCXJ3qknXvwZN5GEfe+Z4lvYXTjcaE5bvnH5H7PNtb6nDeuqlqtPIpx2krij8ogZlaUutuLBaDVWbD+JEVrDPTql9Of4Bho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997654; c=relaxed/simple;
	bh=aZZNr0IaAHboVvRP/at7LfaxkzVEEgoRWECisEn29jQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr82ZXPQE5NrMxJbECOqX5AuYSni1USJjsU/DnFMrGdDIof5qVIeud0mhLyXDmTlCJ90/RCeuln3p55+AuJRvsnb2sm7Ov9ei4bqI3hpz+us8ObmTy/lq9/Px/6vD/JL3I4qUYluN2nvbrnuN//4y+KNxgqhr2KcxT4aSbPjmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PyKQftA5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721997653; x=1753533653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZZNr0IaAHboVvRP/at7LfaxkzVEEgoRWECisEn29jQ=;
  b=PyKQftA5Nk23A12RekwMDGTkLM8rnDryVLN8jnRmArlO1xlBZY1l3Ymp
   avIdbUm2hQDI36YXq41t37s9RKQ2pyAMiJXckn7JsSxJUfKIPx2eUKvpr
   xzHY2jSC873WqVgmji+sIOd4mPq72zfDzShYTEMUvTlPZF+GDSwybdu9T
   q4Jby2S/uiCzjz+Yy1EX0QWEeCIuFeP+CzvqXJSaE7JY7Kc/XO3l5uz8r
   zuXkuqnm1dnczrwxZfb+azQ+E+4fniRuoqa+rjQpBkXp51X9GcUtRJKiV
   MwSbI0VbE9/m13vlT3rAEI1wTlEjxqLmaabztPOoD+2aOkWiVvmrqr126
   A==;
X-CSE-ConnectionGUID: Pz8rc0X+RQWRNn1lO8SO4A==
X-CSE-MsgGUID: HAEBIjfuQ7iCcLOKfr+GEA==
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="30386974"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2024 05:40:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jul 2024 05:40:28 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jul 2024 05:40:19 -0700
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
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 12/14] net: ethernet: oa_tc6: add helper function to enable zero align rx frame
Date: Fri, 26 Jul 2024 18:09:05 +0530
Message-ID: <20240726123907.566348-13-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
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

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 23 +++++++++++++++++++++++
 include/linux/oa_tc6.h        |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 7f684b542bb1..9a60f25e8de6 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -23,6 +23,7 @@
 /* Configuration Register #0 */
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -1152,6 +1153,28 @@ static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * oa_tc6_zero_align_receive_frame_enable - function to enable zero align receive
+ * frame feature.
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


