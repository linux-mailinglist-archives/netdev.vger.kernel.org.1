Return-Path: <netdev+bounces-240703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7AC78092
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4D4DA2C39A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2633E344;
	Fri, 21 Nov 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="KN3AuEAh"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23093385B6;
	Fri, 21 Nov 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715705; cv=none; b=MkNNpmp5cJky6+e1TpBuyGI7dvStqhAetE6bkQfaeIxR5rn5oYkda5V/PRVnFfoSRkFHPCfRs+liBDMMZnJiybfyfVlETHqImJ59Q6HtUJUwiDp0trlyX1jRH2G5HX2IhO8PF1Nr6qpsCjPR4JcRYeBUI+Elg+Bzh+fozmfFKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715705; c=relaxed/simple;
	bh=s33B46/YG3Ae/KHvI7x5uGM6AbNBg1sUvTzL0tPaUGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AHXKExso0dej6J271EipYvoq049FRBDprVrrodCuOVNQo9ygUSUU1czUJtxKXBoA8A5deaFu8qvwQOmga0uBVWJiWADP/SAWcXHXAerEzYgPB+L3iBXjPOIeRT8p+jxXPZEnA9i+R47lqZpvMs3Y+gfZs9CFHwjg8Uzy7JExTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=KN3AuEAh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL916iQ43290234, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1763715667;
	bh=nijRuWpr9kcEM7mz58cLAdPohd2LpCUI5CKUXlzoH+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KN3AuEAhtOHkC/yfQSC9Wue2ahyPjbrjwErUo9E42/GEIJXWn7BNxrLTfKBs3ok3g
	 9tMjniY4NReW1FyiFX84Z+kPzXNI5eY3lIv3m7kJbjKU2ivMbWNo/qUP0G0YjbGlu9
	 xGPjutIwlIpmj0gbHfMK6Lv1JcivGWxQ9qOKgV0+tT8Rso/GTrjk7H3C+zsN2XMmNA
	 D3eRp+SL2R7GLgHWrK7IJVaSDKNzON/mX7UkDL9DVklO0YhOmEdbKZE/1prw4/kYKp
	 1+JXojk47aRdwnPdCKUrVKxMh5s8oGEDk7/wYFLqlzP//l5vnTK/AfXtRBPVenFUtU
	 LK1IJnGnjHeEg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL916iQ43290234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 17:01:07 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 21 Nov 2025 17:01:07 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 21 Nov 2025 17:01:06 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3] r8169: add support for RTL9151A
Date: Fri, 21 Nov 2025 17:01:04 +0800
Message-ID: <20251121090104.3753-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
basd on the one with XID 0x688, but with different firmware file.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

---
v2: Rebase to master, no content changes.
v3: Rebase to net-next, no content changes.
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index de304d1eb477..9fd0ca399d5f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -59,6 +59,7 @@
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
 #define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
+#define FIRMWARE_9151A_1	"rtl_nic/rtl9151a-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 #define FIRMWARE_8127A_1	"rtl_nic/rtl8127a-1.fw"
@@ -111,6 +112,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
 
 	/* 8125D family. */
+	{ 0x7cf, 0x68b, RTL_GIGA_MAC_VER_64, "RTL9151A", FIRMWARE_9151A_1 },
 	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 },
 	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
 	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
@@ -774,6 +776,7 @@ MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8125K_1);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
+MODULE_FIRMWARE(FIRMWARE_9151A_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 MODULE_FIRMWARE(FIRMWARE_8127A_1);
-- 
2.34.1


