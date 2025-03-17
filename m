Return-Path: <netdev+bounces-175210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B6A645FC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EBC3B0384
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B1221540;
	Mon, 17 Mar 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KyXyqPC4"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E28634E;
	Mon, 17 Mar 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201000; cv=none; b=uKp22hBNsZeEaHa15+epBcttWJ2YAnNw44j5NvjBhnJ+Xc32dfGBlO4SOvj98uDaUhP9VIPH+8zGqV1GoZLW8QnQq2foccoQ6XHcpvFooe4y0rZjRjlbStFv9HhVSFkmphVMIkNFPwUr1bMEkY9ysHBKssYu6yqZJFVrLVGiazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201000; c=relaxed/simple;
	bh=ydzBUKPxJ3fA3bhlkGN/gob2q7QOFofrL9OaO98ylJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBAA9TGVf9q4UwFePNTPVGeu6jBEpdHF9mSMdu7lzQALIU+mrHjafcgTGOobuDYm0qR63kjd+gBvzPRe3xluoKG8REXz7spddvQ2T4/KNxvY9VAtRP4wrYhGQz3uqXWfLx+Ocg/1oe/h8Z4lVP6ejl47B80dDHSKQAqeoTOYO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KyXyqPC4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H8gnygF225792, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742200969; bh=ydzBUKPxJ3fA3bhlkGN/gob2q7QOFofrL9OaO98ylJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KyXyqPC4pHarwIDMZ0q0nufKeGOJ35NIUPJS2gKUTlOsoNaNvZDki/WiS/N3L+Po0
	 tH5BmodWTg+OvHwvnnRDDsyQVGmzS7rPqW9YbgG0F5EFCI6Q4L3bbt26rPh1iNQD3S
	 G4fcLj7a94pUJCKiLQ2NW2UjYlhT5i+0CL2bIxYznHWf9a/u45Ggi2BU0ceS04bld1
	 DWXujn5WcZyBcNxlY7vfCKEB5hP3jJ9MPQ6E+AVCYjnTCDj45ugEUtigZ2X+v9mbQB
	 K0nhV3KNeruFYDOQLWEDJ1NHjuKQ2ORh+FOcFtJvYKS1XObeXZu2Paa1aeNDLE2H44
	 4AESKfgHqiSDQ==
Received: from RSEXH36502.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H8gnygF225792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Mon, 17 Mar 2025 16:42:49 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Mar 2025 16:42:48 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Mar 2025 16:42:48 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v2 2/2] r8169: disable RTL8126 ZRX-DC timeout
Date: Mon, 17 Mar 2025 16:42:36 +0800
Message-ID: <20250317084236.4499-3-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317084236.4499-1-hau@realtek.com>
References: <20250317084236.4499-1-hau@realtek.com>
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
 drivers/net/ethernet/realtek/r8169_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3c663fca07d3..ad3603cf7595 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2852,6 +2852,25 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
 		RTL_R32(tp, CSIDR) : ~0;
 }
 
+static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u32 csi;
+	u8 val;
+
+#define RTL_GEN3_RELATED_OFF	0x0890
+#define RTL_GEN3_ZRXDC_NONCOMPL	0x1
+	if (pdev->cfg_size > RTL_GEN3_RELATED_OFF &&
+	    pci_read_config_byte(pdev, RTL_GEN3_RELATED_OFF, &val) == PCIBIOS_SUCCESSFUL &&
+	    pci_write_config_byte(pdev, RTL_GEN3_RELATED_OFF, val & ~RTL_GEN3_ZRXDC_NONCOMPL) == PCIBIOS_SUCCESSFUL)
+		return;
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
@@ -3824,6 +3843,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.43.0


