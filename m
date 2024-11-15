Return-Path: <netdev+bounces-145225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA269CDBF8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F1B25AB0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CD192D6B;
	Fri, 15 Nov 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Atwaw1Sf"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDF18F2DB;
	Fri, 15 Nov 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664591; cv=none; b=DWTF1iLQfyQ64yu27ocSk2r1VYVFcolJ+UYxdZ/r3v0lIW+sSXMfuxp+9qvG/NPzfbZ9/hXWA/E0angWzUYLDdHtUyKhNzwqvLHksVYlBV8jMhx4syEWm6v3Uvr93VyOo02nBESLrIAzx7Nm2Ogzfro/NqpS5CAqdvd8d4a81xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664591; c=relaxed/simple;
	bh=rlK6/TKWzQfmmePLCrYCt+4gkQOodUnsoIGZbd96Vkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1Cp1fCoOE17m+MI9rvgMkJ1ORNiPnw19P9No9KFvaKp4yYssXPcUnqwyrnGKDBoyWcfwwp1LEnP1/FAVB4RLknCzO0lwAHOOysl9IW+RHtZtLDBRqNZTKdas3/DUqfp12NWvIlKWObzjJy8zgjqRH6jjH0Wqn3/0Gf5MXxjYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Atwaw1Sf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF9uEdQ5291473, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731664574; bh=rlK6/TKWzQfmmePLCrYCt+4gkQOodUnsoIGZbd96Vkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Atwaw1Sfle4b4nug4+l/z2z/cJkd+vuqXZRp1jYAPLEdiIOwNAXHzDpKTXJCeJNBL
	 CJUSSqUqv2VUSbKDPOn0B083R8cIhCndzKR9pjy4N9RuZ9GZ0Ged4NljnuuXJx1iGs
	 9J/34Q6xN8aOoTxLJz4hqg/Tpe8+Zm1QFrVwZQnIadxJ7PJ2Wdw5r1WdI75XYgZ6J0
	 eCZ65l+mTrKbKdZI/P1BmHa6qdnB6gE6AsSAPNT2WGX3sYRObSJYErNWykwd4MOeaa
	 VUS9ySMGxyvpoyvy+n6RR+VLzC+SxkPh1p6a8ieBvpUjSj9n0RnnCQdIjU3Fv0GAMV
	 UNtxXYaQXnUNA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF9uEdQ5291473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:56:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 17:56:14 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Nov
 2024 17:56:14 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 5/5] rtase: Add defines for hardware version id
Date: Fri, 15 Nov 2024 17:54:29 +0800
Message-ID: <20241115095429.399029-6-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115095429.399029-1-justinlai0215@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
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
 drivers/net/ethernet/realtek/rtase/rtase.h      |  6 +++++-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 547c71937b01..6dfb839d78f0 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -9,7 +9,11 @@
 #ifndef RTASE_H
 #define RTASE_H
 
-#define RTASE_HW_VER_MASK 0x7C800000
+#define RTASE_HW_VER_MASK     0x7C800000
+#define RTASE_HW_VER_906X_7XA 0x00800000
+#define RTASE_HW_VER_906X_7XC 0x04000000
+#define RTASE_HW_VER_907XD_V1 0x04800000
+#define RTASE_HW_VER_907XD_VA 0x08000000
 
 #define RTASE_RX_DMA_BURST_256       4
 #define RTASE_TX_DMA_BURST_UNLIMITED 7
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 91ad19e80f67..d352e25fd9af 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1720,12 +1720,12 @@ static int rtase_get_settings(struct net_device *dev,
 						supported);
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
 		cmd->base.speed = SPEED_5000;
 		break;
-	case 0x04800000:
-	case 0x08000000:
+	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
 		cmd->base.speed = SPEED_10000;
 		break;
 	}
@@ -1991,10 +1991,10 @@ static int rtase_check_mac_version_valid(struct rtase_private *tp)
 	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
-	case 0x04800000:
-	case 0x08000000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
 		ret = 0;
 		break;
 	}
-- 
2.34.1


