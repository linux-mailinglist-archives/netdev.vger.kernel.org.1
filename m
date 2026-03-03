Return-Path: <netdev+bounces-263101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG3qDAaupmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:46:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 703141EC121
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E853304A217
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08B3822B2;
	Tue,  3 Mar 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="qYTVBE0M"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13B383C8F;
	Tue,  3 Mar 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531201; cv=none; b=NjJdUpgbHEP/l5EcoVHcdQn6d0uJveAqu1LHZHBFtYkUQSLyU07lTPS9iDqNFADT7OvTrj2FzcCjctMxSi2J4NVNjLDT4Xeo/NIG5tYuRu9/Eqb0a73LkSTySU4LXrzPb2NcLvulTePnMhZ57aW380t12OyTDnNABC2XihV8Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531201; c=relaxed/simple;
	bh=A64hirLlAo+XfMeh4FQI5+tCl9unvCn7Yv7tA0ypPJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhjA5Ymbad0pFwwoKSXj+pWCMkgoxPwvxwN8iqc+ZwZUeOQ1+6XBW768zDHxPuGG5Qiwe2RbZltyJSr1Z0kgJyGfkfz4yTNAJDndw789ztcC/bqDhjh9PfEYe/HOnzMrtkGTAdHJhh6jUe7z9GocvOXngGbdWj5e+0LKsluo97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=qYTVBE0M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6239kEywD900083, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772531174;
	bh=A9h1YWLX/cLaxC41v+MT7SrxV97RCYCoe2a/dfgD9Ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=qYTVBE0Mkgjf/YgVJsk42NSFU/72vR4U3fyUM71SSZYaupZUMtZWLU+d+hOOIho6x
	 pEtYnTZXKiG7xaBbBSMw93A3ca81lxV/16bPzCSzRSi6L/DEEM5KmLA/2WjCaBKdqx
	 J0o32PoDaEPUszlvTgNZrizZCBaPKtf6kwQ23QffHpm6mPjEMzxPEhQcSgB+BgtuC4
	 8MKfCWR7GNtlHKNfdxfXfN+KkXb8br/4hsqxvTbf+ekkOV2E5vzYQpcE6wKZxf2fv6
	 kUfN9kHK+Fnj/l2AiCp4n0Be0sNu8HVhoVG20t1c+0QITBXiPvJJWlx8lF7tb57myU
	 x3MJOGQgQlsug==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6239kEywD900083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Mar 2026 17:46:14 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 3 Mar 2026 17:46:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 3 Mar 2026 17:46:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v6] r8169: add support for RTL8125cp
Date: Tue, 3 Mar 2026 17:46:11 +0800
Message-ID: <20260303094611.450-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 703141EC121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-263101-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
different and firmware for RTL8125cp.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

---
v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.

v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0
means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 means
'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.

v4: Fix some format mistakes.

v5: Rebase on latest net-next. No changes.

v6: Rename some bits of 0x0a43, such as LINK_SPEED_10M_PLL_OFF for
BIT(0) and ALDPS_PLL_OFF for BIT(1). Disable interrupt coalescing for
RTL_GIGA_MAC_VER_65.
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     |  7 +++++
 .../net/ethernet/realtek/r8169_phy_config.c   | 26 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index aed4cf852091..0b9c1d4eb48b 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
+	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_80,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2f7d9809c373..0efec2f86155 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -60,6 +60,7 @@
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
 #define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
+#define FIRMWARE_8125CP_1	"rtl_nic/rtl8125cp-1.fw"
 #define FIRMWARE_9151A_1	"rtl_nic/rtl9151a-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
@@ -112,6 +113,9 @@ static const struct rtl_chip_info {
 	/* 8125BP family. */
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
 
+	/* 8125CP family*/
+	{ 0x7cf, 0x708, RTL_GIGA_MAC_VER_65, "RTL8125CP", FIRMWARE_8125CP_1 },
+
 	/* 8125D family. */
 	{ 0x7cf, 0x68b, RTL_GIGA_MAC_VER_64, "RTL9151A", FIRMWARE_9151A_1 },
 	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 },
@@ -802,6 +806,7 @@ MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8125K_1);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
+MODULE_FIRMWARE(FIRMWARE_8125CP_1);
 MODULE_FIRMWARE(FIRMWARE_9151A_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
@@ -4021,6 +4026,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
+		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
@@ -4040,6 +4046,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
+	case RTL_GIGA_MAC_VER_65:
 	case RTL_GIGA_MAC_VER_66:
 	case RTL_GIGA_MAC_VER_80:
 		for (i = 0xa00; i < 0xb00; i += 4)
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 032d9d2cfa2a..4f1d447136ec 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -14,6 +14,9 @@
 
 #include "r8169.h"
 
+#define LINK_SPEED_10M_PLL_OFF		BIT(0)
+#define ALDPS_PLL_OFF			BIT(1)
+
 typedef void (*rtl_phy_cfg_fct)(struct rtl8169_private *tp,
 				struct phy_device *phydev);
 
@@ -1102,6 +1105,28 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125_config_eee_phy(phydev);
 }
 
+static void rtl8125cp_hw_phy_config(struct rtl8169_private *tp,
+				    struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8168g_enable_gphy_10m(phydev);
+
+	phy_modify_paged(phydev, 0xad0, 0x17, 0x007f, 0x000b);
+	phy_modify_paged(phydev, 0xad7, 0x14, 0x0000, BIT(4));
+	rtl8125_phy_param(phydev, 0x807f, 0xff00, 0x5300);
+	r8168g_phy_param(phydev, 0x81b8, 0xffff, 0x00b4);
+	r8168g_phy_param(phydev, 0x81ba, 0xffff, 0x00e4);
+	r8168g_phy_param(phydev, 0x81c5, 0xffff, 0x0104);
+	r8168g_phy_param(phydev, 0x81d0, 0xffff, 0x054d);
+	phy_modify_paged(phydev, 0x0a43, 0x10, 0x0000,
+			 LINK_SPEED_10M_PLL_OFF | ALDPS_PLL_OFF);
+	phy_modify_paged(phydev, 0x0a44, 0x11, 0x0000, BIT(7));
+
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125_config_eee_phy(phydev);
+}
+
 static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
 				    struct phy_device *phydev)
 {
@@ -1344,6 +1369,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
+		[RTL_GIGA_MAC_VER_65] = rtl8125cp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,
-- 
2.43.0


