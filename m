Return-Path: <netdev+bounces-146175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2C9D22EB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69CC1F229BB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505971B86DC;
	Tue, 19 Nov 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eUkf8HW0"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFE156887;
	Tue, 19 Nov 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010377; cv=none; b=YhNpXcny6zrWmGbS0HUk/XJLCY6fLAQb1WTDbRsR+aglowiEnJYU9wDEF8Hd3x6fuiUIwMnxZ7dCVJScVphz465DLxdVWdgLcqU1COXKoKrBFplDfatNdde6TftFED+rryT+a1dRomcNG9lLYtH+TbGrnjr35yioVAv6t+Btxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010377; c=relaxed/simple;
	bh=ow1vGg4eO+2OEbxNFP6nOJmj1FB88Ng9OVoBewOdaRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA5bepcHGDPF591MCnZPULyCC+K7M1BCGtHF4aIA7Kd51ctn59yhoqDSQNpJFcXCPHp09oqJb4gn33PatUCOPTPYmK08JJkCgrva4GkXEm5R8gO9DsLZml9ZeUqVTI62Izpy3lBLWZHDJD85qpYJrpv8qXOMz0WQcYw5dhKyon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eUkf8HW0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ9xI4K12265836, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732010358; bh=ow1vGg4eO+2OEbxNFP6nOJmj1FB88Ng9OVoBewOdaRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eUkf8HW0nHcv9oNB59S1G2BbDKLPoLrAzftDoxDL6sUBEqLmEqKBUnbQrdFG3eC7V
	 NA8tSWXpmwEIVN1cK77scrQaVW4JSZyE5XaFDbNPelrcAoJ+XtYvz1AYtZ/uuJg2A4
	 rQ+4998iYA6FyFbQoxOBwDtt1tubhzj0EFetezPjZ6YAPq34ylKZFjIIQj5lrWsxOP
	 AWODr6AL+0FClChd6Vp3bc+9PPixj2A5OzlNQZw0nVYj0BKUajNJZPDBfyDsV4/+YE
	 PdUO+scllkXQW0Bh8yiiIiy6n2Meij2K7wqQda82nK3aMJps+TFBteD8+WEE1487kA
	 t4HPEIpjDsIZg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ9xI4K12265836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:59:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 17:59:19 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Nov
 2024 17:59:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4 4/4] rtase: Add defines for hardware version id
Date: Tue, 19 Nov 2024 17:57:06 +0800
Message-ID: <20241119095706.480752-5-justinlai0215@realtek.com>
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

Add defines for hardware version id.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 547c71937b01..4a4434869b10 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -9,7 +9,10 @@
 #ifndef RTASE_H
 #define RTASE_H
 
-#define RTASE_HW_VER_MASK 0x7C800000
+#define RTASE_HW_VER_MASK     0x7C800000
+#define RTASE_HW_VER_906X_7XA 0x00800000
+#define RTASE_HW_VER_906X_7XC 0x04000000
+#define RTASE_HW_VER_907XD_V1 0x04800000
 
 #define RTASE_RX_DMA_BURST_256       4
 #define RTASE_TX_DMA_BURST_UNLIMITED 7
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 26331a2b7b2d..1bfe5ef40c52 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1720,11 +1720,11 @@ static int rtase_get_settings(struct net_device *dev,
 						supported);
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
 		cmd->base.speed = SPEED_5000;
 		break;
-	case 0x04800000:
+	case RTASE_HW_VER_907XD_V1:
 		cmd->base.speed = SPEED_10000;
 		break;
 	}
@@ -1990,9 +1990,9 @@ static int rtase_check_mac_version_valid(struct rtase_private *tp)
 	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
-	case 0x04800000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+	case RTASE_HW_VER_907XD_V1:
 		ret = 0;
 		break;
 	}
-- 
2.34.1


