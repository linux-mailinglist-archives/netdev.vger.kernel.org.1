Return-Path: <netdev+bounces-175620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A952AA66E7B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E794189C1D5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3B205E04;
	Tue, 18 Mar 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HiS2VpWJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713620487F;
	Tue, 18 Mar 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287068; cv=none; b=BLnRdj3r0deYlEmFY8gEHFynMRxWSFePEOvgsgMQjcOsXGUE0FyzEPp5UDj+9oEOeanozhMze/uhcsozQ1PyD7qvUBCwANAvyle7NOU0Jz1PMW8f4gxduXswln4McLtQjOF9uBEuhq9gsWuh2TPCzLAhuJpntDJ+ywqmbxhDaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287068; c=relaxed/simple;
	bh=2bVBK313jrjNadJD+U4gd3CdwF5mvefNVQPOIKdr93M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oURmTWXnDxE9uhCcqTWQIeFPUYAqLKKXej+EXMF4effCzY49O02i0hPjZ8zDNfZUefzilpct2RJ897pDgoQI4yS6hzWif6vX17eDb8LcInXVQ4ofhdEOPA3XljWsB+dOMBDTfgZkTmPH7pGs89g/V/enuwjP45fl2DQIiuIWCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HiS2VpWJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52I8bRl152588614, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742287048; bh=2bVBK313jrjNadJD+U4gd3CdwF5mvefNVQPOIKdr93M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HiS2VpWJ2ftr8Cep/rmN+C1VqNCYtxUg1Tr0a6BpWiViPCy8JOL69Fa9esu4nEaDb
	 pU+OUkxce5FVpGtjtw5p1RbNcAPvKRjmJ3rw8w9nNiAXb0M/kYSY3+r0Wbp9qBCSfm
	 IeJLKZiOOxD3ukR8HQHwgSruH5+/W/S8kFm05SSSOSWTDK3zW5sWoa9mDo5M2EuQ7t
	 Js5jTwmcFisdLYySmXX/7y9yhDEDVmTOpjGOCpCnicEITe/kcozcp5qX0pK0gbUm5q
	 gpE+uKszFeKERHvPMdFIHGo/qHJoOrjyb6+XRKDrCqVwJoh98oO7p030HCshdCvYvj
	 1ITa1FPnDI0bw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52I8bRl152588614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 16:37:28 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 18 Mar 2025 16:37:27 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Mar 2025 16:37:27 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v3 2/2] r8169: disable RTL8126 ZRX-DC timeout
Date: Tue, 18 Mar 2025 16:37:21 +0800
Message-ID: <20250318083721.4127-3-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318083721.4127-1-hau@realtek.com>
References: <20250318083721.4127-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
device will exit L1 substate every 100ms. Disable it for saving more power
in L1 substate.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3c663fca07d3..fcb87059dc5d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2852,6 +2852,32 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
 		RTL_R32(tp, CSIDR) : ~0;
 }
 
+static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u32 csi;
+	int rc;
+	u8 val;
+
+#define RTL_GEN3_RELATED_OFF	0x0890
+#define RTL_GEN3_ZRXDC_NONCOMPL	0x1
+	if (pdev->cfg_size > RTL_GEN3_RELATED_OFF) {
+		rc = pci_read_config_byte(pdev, RTL_GEN3_RELATED_OFF, &val);
+		if (rc == PCIBIOS_SUCCESSFUL) {
+			val &= ~RTL_GEN3_ZRXDC_NONCOMPL;
+			rc = pci_write_config_byte(pdev, RTL_GEN3_RELATED_OFF,
+						   val);
+			if (rc == PCIBIOS_SUCCESSFUL)
+				return;
+		}
+	}
+
+	netdev_notice_once(tp->dev,
+		"No native access to PCI extended config space, falling back to CSI\n");
+	csi = rtl_csi_read(tp, RTL_GEN3_RELATED_OFF);
+	rtl_csi_write(tp, RTL_GEN3_RELATED_OFF, csi & ~RTL_GEN3_ZRXDC_NONCOMPL);
+}
+
 static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -3824,6 +3850,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.43.0


