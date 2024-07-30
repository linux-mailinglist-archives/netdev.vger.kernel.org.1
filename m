Return-Path: <netdev+bounces-113929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA775940668
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FA1F23355
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B73160884;
	Tue, 30 Jul 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ICFsW4hN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C315FCEB;
	Tue, 30 Jul 2024 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312668; cv=none; b=ZGpFpJSiyATbcp5o2ikBxh4fZGymY4dEPQR9mUBC9GfTRbI9/eV6WC8pbRvvded8+kmMnSYFEMxVVC/LsjhMyfU4Rgi0V2FefGZWgsipCt2lsb22Jud6Y6ufvmr9TdNTE9sqijrhB53WOyi+tM60S3Z09MHvEhnS4lAk14gSknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312668; c=relaxed/simple;
	bh=mZ6KmIBXRsaBaJM93G1ZEC+0IAZ1SoiJus/tzWLQuMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mavavjjV+GTirV8Z71JeyLmUn3klRqzq6sLPZcLjThV2HDxXdPv8WEmnpDeVCKkr37uzdJRDMa/UJDbu1DOptrZnLiLcLtDcBLPnF1UzlNrMCSY+fguR40q9q29A9R2vkzSLjQ70oziWev/EHXKHZy8eRCdwhxivsNo5hXEWThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ICFsW4hN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312667; x=1753848667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZ6KmIBXRsaBaJM93G1ZEC+0IAZ1SoiJus/tzWLQuMU=;
  b=ICFsW4hNMMpLbGf5zeVxiqWpIPfrgqvoK8uPHLNCWxu9wMGGip7YeL1b
   9JGqy8Q8NROdd9mC/DHfJobtn9N8POVR3gFvxhlatmzc2UlNqJWFv3rnv
   vyIgkD8G7kIQ9q2891xCXEAKtv93uB2/6NCuNkffcSTa8GG81sVzQldSO
   FNzCfNvl1S6LXjQqz9LnyxMHeiJF1TTsi2KzBRDVntoMzqnzLXWwAcjBB
   TQV/sGxkVXppJl8hYmv+8kM2FI+CUBzYYLqstvS3dXyE7wXYt3/+r1LYh
   LfHjIeqY7m+ZYrFdDXr/FZx5N63a6dwGwMOEWJgxMdq7ZlPWrLT/KyUX2
   w==;
X-CSE-ConnectionGUID: mqMfXK64Rdu1Hu7kZRIsuQ==
X-CSE-MsgGUID: tqDX0t00TQWQJ+miWRK70g==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="29844750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:11:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:10:45 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:10:34 -0700
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
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 12/14] net: ethernet: oa_tc6: add helper function to enable zero align rx frame
Date: Tue, 30 Jul 2024 09:39:04 +0530
Message-ID: <20240730040906.53779-13-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
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
 drivers/net/ethernet/oa_tc6.c | 24 ++++++++++++++++++++++++
 include/linux/oa_tc6.h        |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index b55a3347f58f..fbf9d9ad4175 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -23,6 +23,7 @@
 /* Configuration Register #0 */
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -1164,6 +1165,29 @@ static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
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


