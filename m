Return-Path: <netdev+bounces-146172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E179D22E1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905191F227A2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F251C1F19;
	Tue, 19 Nov 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qWOjv1wJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A31B6D16;
	Tue, 19 Nov 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010267; cv=none; b=dhl0ChYPKnW5/g/bsibYj7FVHpxVFncdTMyTEZJIR0le0vZCoMvL6bpi8C8t9XFYFaLHr16zt1ogdzfnqasXtE79o5KK6UfIIFoE2+1EF06dmf5G4v0j9Db8UdkjSSa1WyhWX7dLc01pmkqXoNIl3MxhLmKDQbEF63yBd+MltAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010267; c=relaxed/simple;
	bh=5s86hWDe+U82KtdF5WrQaPbjjkspLRQDfBJ+/bNeLD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jofJrTcaSO61xFXgZMvWVwrthsbLP7a49V13erLvNGwPNF99jTrlqEsUzJze3XzqXv9T4teSeGVlH/mKmjrvbiwWqgEkWahuDGReQY8S34k71Yy7V80nKyC9iURXwfN0g//PYttpoT34h4nqMircEg1BKgA9T/r/uILPQNEnx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qWOjv1wJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ9vQAo92265168, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732010247; bh=5s86hWDe+U82KtdF5WrQaPbjjkspLRQDfBJ+/bNeLD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qWOjv1wJRMoO4dkHAoi0Id+FaVGTqIzbeNH0UIG7sDMxOu8HPNGzvrqz3v+r+zSau
	 2a+D0q48WC86WdX9LIFJSE1KdbVEE/Hle7R/UC6IC0PyWEL+uol32UsI/PiCW6GZkG
	 DsBLR3rbfY90UL6MZ7q2jKKXTaPdTRMU837MbkGdrIB0QQtXEMnXWE+8Pv7CwPFa+v
	 L/UxvCwVL2dHDKnPHMHRQjQob2l7oePk0QtEuffhdNI2WNoYa+af0UxHPBN5ecT5We
	 +Sxl+zcS7N38o8hpTgQK8OpPmbkXohlzDDmX+rgUXmIx5OtUUv8jJpwCgWKsRzoM19
	 MTKLTEpXx2l3w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ9vQAo92265168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:57:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 17:57:27 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Nov
 2024 17:57:26 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4 1/4] rtase: Refactor the rtase_check_mac_version_valid() function
Date: Tue, 19 Nov 2024 17:57:03 +0800
Message-ID: <20241119095706.480752-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119095706.480752-1-justinlai0215@realtek.com>
References: <20241119095706.480752-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Different hardware requires different configurations, and this distinction
was not made previously. Additionally, the error message was not clear
enough. Therefore, in this patch, the following changes have been made to
address these issues:
1. Sets tp->hw_ver.
2. Changes the return type from bool to int.
3. Modify the error message for an invalid hardware version id.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 22 +++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 583c33930f88..547c71937b01 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -327,6 +327,8 @@ struct rtase_private {
 	u16 int_nums;
 	u16 tx_int_mit;
 	u16 rx_int_mit;
+
+	u32 hw_ver;
 };
 
 #define RTASE_LSO_64K 64000
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f8777b7663d3..0c19c5645d53 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
 	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
 }
 
-static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+static int rtase_check_mac_version_valid(struct rtase_private *tp)
 {
-	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
-	bool known_ver = false;
+	int ret = -ENODEV;
 
-	switch (hw_ver) {
+	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
+
+	switch (tp->hw_ver) {
 	case 0x00800000:
 	case 0x04000000:
 	case 0x04800000:
-		known_ver = true;
+		ret = 0;
 		break;
 	}
 
-	return known_ver;
+	return ret;
 }
 
 static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
@@ -2105,9 +2106,12 @@ static int rtase_init_one(struct pci_dev *pdev,
 	tp->pdev = pdev;
 
 	/* identify chip attached to board */
-	if (!rtase_check_mac_version_valid(tp))
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	ret = rtase_check_mac_version_valid(tp);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
+			tp->hw_ver);
+	}
 
 	rtase_init_software_variable(pdev, tp);
 	rtase_init_hardware(tp);
-- 
2.34.1


