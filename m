Return-Path: <netdev+bounces-148439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519859E1956
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F291641EB
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58561E22E9;
	Tue,  3 Dec 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ggZFKTuZ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131591E0DEB;
	Tue,  3 Dec 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221968; cv=none; b=A69L/DF+H7jmhr3qp2LfQRqfiuanKsw0ekiRpyQMQIlj/5QSnH88NwZwTmwgLOPkhPa1ZB5FBWviBfa+1eME1wc/lqHEBeBJK8mu2nAzwe9NcAL+/8oeBmFZcQEfedxWROLUTRSO+RvnqEDEDQ5qJxDkdFQdxDa0JFKq8cUQpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221968; c=relaxed/simple;
	bh=lfZk1PHy+4P1YFdjNi2bdTEnABvSnKLOXNwj20uCDiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZdG3yqIz3P/xzm0Q3+oSdFRf7T4ZpWKGy+U0G4+XXPt/Tl13TyP4h3maGl/UMLwtkDauv9uFt1WFJvXXijQM9++wNbi0QRqXbma+Nxr0x2Ige4qJCGcTNdAtbnpSH8lx4tA4dQzfFvhLGPrg+An2+nAG2kch8TbXBO1VGbrz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ggZFKTuZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B3AVuBZ23707200, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733221916; bh=lfZk1PHy+4P1YFdjNi2bdTEnABvSnKLOXNwj20uCDiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ggZFKTuZjxm9b9Nand76k6UGBNujO3hWp/6eO3U+P17yQhBu0GtkmeqFzjBYniBgi
	 MIF3+D+lQS3j3DYaRPRpCVHcjwsdFoZzeWP6c+HApY7xars+Yd2PVwEvCA1ygd+k7/
	 R1RXtB6tD8/hC8VYpEGB4HUL9+OrIwqQTJhzc7gO0XuuLvjrqCSsVVCC7w4Y24Qp/e
	 oCODJl2MzqDUIFMKYnFbkiDfJf8oLaLK8/YLlQdgPI5jlKQeVybhawtJDaNEN1F7J8
	 GC/wyRdbVpzXy0au5qcPSAWRWovhpxTU1kq1maXQ/OoKfvY0mUUlFZtIAsU6b8Nbzf
	 bNfy5QhMkncIQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B3AVuBZ23707200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 18:31:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 18:31:56 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 3 Dec
 2024 18:31:55 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>,
        <michal.kubiak@intel.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next] rtase: Add support for RTL907XD-VA PCIe port
Date: Tue, 3 Dec 2024 18:31:46 +0800
Message-ID: <20241203103146.734516-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Add RTL907XD-VA hardware version id.
2. Add the reported speed for RTL907XD-VA.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h      | 1 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index dbc3f92eebc4..2bbfcad613ab 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -13,6 +13,7 @@
 #define RTASE_HW_VER_906X_7XA 0x00800000
 #define RTASE_HW_VER_906X_7XC 0x04000000
 #define RTASE_HW_VER_907XD_V1 0x04800000
+#define RTASE_HW_VER_907XD_VA 0x08000000
 
 #define RTASE_RX_DMA_BURST_256       4
 #define RTASE_TX_DMA_BURST_UNLIMITED 7
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index de7f11232593..6106aa5333bc 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1725,6 +1725,7 @@ static int rtase_get_settings(struct net_device *dev,
 		cmd->base.speed = SPEED_5000;
 		break;
 	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
 		cmd->base.speed = SPEED_10000;
 		break;
 	}
@@ -1993,6 +1994,7 @@ static int rtase_check_mac_version_valid(struct rtase_private *tp)
 	case RTASE_HW_VER_906X_7XA:
 	case RTASE_HW_VER_906X_7XC:
 	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
 		ret = 0;
 		break;
 	}
-- 
2.34.1


