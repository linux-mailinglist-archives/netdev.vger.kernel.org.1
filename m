Return-Path: <netdev+bounces-294601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqqILCHWH2r/qgAAu9opvQ
	(envelope-from <netdev+bounces-294601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE7635275
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=qQT3wKbt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294601-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CB4430E82AC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE7410D0E;
	Wed,  3 Jun 2026 06:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE3405859;
	Wed,  3 Jun 2026 06:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=gqD5USeWkkLD9zGTeNtBXDP16hCOGWtvXAZ4bb+I4cwxXD3Kwls4aeaJTWqkWqDr+QRMb85HxYrrre4SUSmfnrKsacIMKlvzj1nQ3qJtVbZ5OkYT773zIK5n4jBPZDuWfyx5i0eWCAQqztSHxSpcIrjSS+QBH59u7/sqBAc6Tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=pPNUiYrjMIEBwZstBviOnw4phku5qQl0xxmvyGH0UPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsK0cb4yuM7j8wEZWtuhYFQ6Gz/MqmBN1lg91mSpVMM7yhY1U4FTexoctQ+AgBMdw+GLFhoHRSoQkTohu3REUc4f8zRgyBR8+K75Bzod8ANIss0NnKwzNEa0UnGPQ3WGwNQPoeAqYKJRfq1iyrcwcb63VIxOYKgmrpbayOgQapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=qQT3wKbt; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xJ0313643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469959;
	bh=t0GvNxBMhKyRWxDJ2RCTEFxWje9u4/Uta+PytWPsayg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qQT3wKbtCimH9lF/Aj96LOMrGFjdeocG7QjQf4of5JIdEqUGsE1HR1EgJqDJ0iN1Y
	 WSVs0+7tzRoHfyukiBLtWzbr6M0bHDS+pFBiHQoVynR6vNWVcTb/+O6XNUNOiQMxXF
	 PSVIVY1hIqVIgcMchkLzw61DZ7LoUReJbOqhCWID3bQEWsQpJcZjPZRNUlU0/JbyuB
	 PQO3uq6yExBMXI/CEiicv7Gq23FzZb9iykLlw3/Q6mpfQBnMYdHw8H3zIS+uAruOoN
	 zx6Ft5HPQ2PRssQOaCnXB/3ZQ7+5xMbiIMmXQUkIy0jIxTZ2bt1NHSCMNYQeCoI9EW
	 QUqjRZyi2xUSg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xJ0313643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:19 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/5] r8169: move funcitons forward
Date: Wed, 3 Jun 2026 14:59:13 +0800
Message-ID: <20260603065916.334-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260603065916.334-1-javen_xu@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294601-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1EE7635275

From: Javen Xu <javen_xu@realsil.com.cn>

Move some functions forward to avoid adding a forward declaration.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 84 +++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..1e2e4074d343 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1113,6 +1113,23 @@ DECLARE_RTL_COND(rtl_ocp_gphy_cond)
 	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
 }
 
+/* Work around a hw issue with RTL8168g PHY, the quirk disables
+ * PHY MCU interrupts before PHY power-down.
+ */
+static void rtl8168g_phy_suspend_quirk(struct rtl8169_private *tp, int value)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_40:
+		if (value & BMCR_RESET || !(value & BMCR_PDOWN))
+			rtl_eri_set_bits(tp, 0x1a8, 0xfc000000);
+		else
+			rtl_eri_clear_bits(tp, 0x1a8, 0xfc000000);
+		break;
+	default:
+		break;
+	}
+};
+
 static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	if (rtl_ocp_reg_failure(reg))
@@ -1123,19 +1140,20 @@ static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 	rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
 }
 
-static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
 {
-	if (rtl_ocp_reg_failure(reg))
-		return 0;
+	if (reg == 0x1f) {
+		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
+		return;
+	}
 
-	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
-		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
+	if (tp->ocp_base != OCP_STD_PHY_BASE)
+		reg -= 0x10;
 
-	RTL_W32(tp, GPHY_OCP, reg << 15);
+	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMCR)
+		rtl8168g_phy_suspend_quirk(tp, value);
 
-	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
-		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
+	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
 }
 
 static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
@@ -1177,6 +1195,21 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 	return val;
 }
 
+static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+{
+	if (rtl_ocp_reg_failure(reg))
+		return 0;
+
+	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
+	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
+
+	RTL_W32(tp, GPHY_OCP, reg << 15);
+
+	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
+		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
+}
+
 static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 				 u16 set)
 {
@@ -1229,39 +1262,6 @@ static void rtl_sfp_reset(struct rtl8169_private *tp)
 		r8127_sfp_sds_phy_reset(tp);
 }
 
-/* Work around a hw issue with RTL8168g PHY, the quirk disables
- * PHY MCU interrupts before PHY power-down.
- */
-static void rtl8168g_phy_suspend_quirk(struct rtl8169_private *tp, int value)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_40:
-		if (value & BMCR_RESET || !(value & BMCR_PDOWN))
-			rtl_eri_set_bits(tp, 0x1a8, 0xfc000000);
-		else
-			rtl_eri_clear_bits(tp, 0x1a8, 0xfc000000);
-		break;
-	default:
-		break;
-	}
-};
-
-static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	if (reg == 0x1f) {
-		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
-		return;
-	}
-
-	if (tp->ocp_base != OCP_STD_PHY_BASE)
-		reg -= 0x10;
-
-	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMCR)
-		rtl8168g_phy_suspend_quirk(tp, value);
-
-	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
-}
-
 static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
 {
 	if (reg == 0x1f)
-- 
2.43.0


