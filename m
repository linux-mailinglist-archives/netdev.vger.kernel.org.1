Return-Path: <netdev+bounces-305377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id po5BEbXITGrppgEAu9opvQ
	(envelope-from <netdev+bounces-305377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:36:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0670719DEB
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=QM1guWiT;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305377-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305377-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84EC9307DAE8
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F333AEF30;
	Tue,  7 Jul 2026 09:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE539657B;
	Tue,  7 Jul 2026 09:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416165; cv=none; b=BVTYXqeUk87uA7scVTmD6ijyxfueg++LQFHg1TmbH9vMgocH0pVicpDtu6KI7V+Bx8n36aBdb714SQiEvai0NTdXZgwqz2iPKlzEmLaW0dzhK06WzqBhVZbREcfwunGQfCrc/Lf3VuulbXtpiJvNL21Dn2QxaWzVPSL5a6ceowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416165; c=relaxed/simple;
	bh=kiD49pLC7avospIgiMy+1krZuvox9XcKLXICr916tmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNYMQxBElDeyQOssOQZjnJ3Gpz5X5HJAXR6WZuWLD0CebDq3uO873hPh2HvHktAs16h3ic0sO35S8WqtEEg+8JUxNmFa3ZNiRxG1inMivyXBTcc6Ge356num8xj88iPAi6aGRU8n+TVe2agDKIHQBKF+cbP8uJMyoJiyum6hu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=QM1guWiT; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GfovE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415801;
	bh=5AyFq8CHDRpwKtS+EVw2PRiTlgBfrfxRLXwiIFfvz/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QM1guWiTKHdhRXkBoyT/ieEax0YjIQcuiUUp96bcyEKS/nPUpnZrzYhV8NDMJCous
	 7S9RrozLJvZ6ZzvBIlUkjbGbpJLIh0aglXIiZ6EHx7eCFvPBSOLwFIs+ZFQ4iHseFU
	 DCUhvOTQlLUUQaoRDBT/9RGHVJrk4pTSpRcZ2EVaYgRbbpxlOlFZWnHphZ856DScBL
	 OFfc7QJVi8xiMNlYfUS0/W76EU92HiYAelVohdymzpCX0ySojFUw4e7OeCmqEyy0IM
	 NxpSxv+7rKaWo0A8ecFYW9OSAyYH40GkmeyeWJeViBiJQ4+Hgti2Z9GL7FQwn7PFcw
	 FbWZB3IWJxCIA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GfovE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:41 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:40 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:40 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 8/8] r8169: add 1g support for RTL8127atf
Date: Tue, 7 Jul 2026 17:16:36 +0800
Message-ID: <20260707091637.371-9-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260707091637.371-1-javen_xu@realsil.com.cn>
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305377-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp,realsil.com.cn];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0670719DEB

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds 1g support for RTL8127atf, which is fiber mode.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v5:
 - no changes, new file
---
 drivers/net/ethernet/realtek/r8169_main.c | 85 ++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 44dd1a5554ff..12e073b9a614 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -111,6 +111,12 @@
 #define RTL8116AF_FUNC_PM_CSR		0x80
 #define RTL8116AF_FUNC_EXP_LNKCTL	0x44
 #define RTL_PM_D3HOT			GENMASK(1, 0)
+#define R8127_SDS_CMD			0x2348
+#define R8127_SDS_ADDR			0x234a
+#define R8127_SDS_DATA_IN		0x234c
+#define R8127_SDS_DATA_OUT		0x234e
+#define R8127_SDS_CMD_EXEC		BIT(0)
+#define R8127_SDS_CMD_WE		BIT(1)
 
 static const struct rtl_chip_info {
 	u32 mask;
@@ -1225,6 +1231,67 @@ static void r8127_sfp_sds_phy_reset(struct rtl8169_private *tp)
 	usleep_range(10, 20);
 }
 
+DECLARE_RTL_COND(r8127_sds_cmd_cond)
+{
+	return RTL_R16(tp, R8127_SDS_CMD) & R8127_SDS_CMD_EXEC;
+}
+
+static u16 r8127_sds_read(struct rtl8169_private *tp, u16 index, u16 page, u16 reg)
+{
+	u16 addr = (index << 11) | (page << 5) | reg;
+
+	RTL_W16(tp, R8127_SDS_ADDR, addr);
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC);
+
+	if (rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100))
+		return RTL_R16(tp, R8127_SDS_DATA_OUT);
+
+	return 0xffff;
+}
+
+static void r8127_sds_write(struct rtl8169_private *tp, u16 index, u16 page,
+			    u16 reg, u16 val)
+{
+	u16 addr = (index << 11) | (page << 5) | reg;
+
+	RTL_W16(tp, R8127_SDS_DATA_IN, val);
+	RTL_W16(tp, R8127_SDS_ADDR, addr);
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC | R8127_SDS_CMD_WE);
+
+	rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100);
+}
+
+static void r8127_sds_modify(struct rtl8169_private *tp, u16 index, u16 page,
+			     u16 reg, u16 clearmask, u16 setmask)
+{
+	u16 val = r8127_sds_read(tp, index, page, reg);
+
+	val = (val & ~clearmask) | setmask;
+	r8127_sds_write(tp, index, page, reg, val);
+}
+
+static void r8127_sfp_init_1g(struct rtl8169_private *tp)
+{
+	int val;
+
+	r8127_sfp_sds_phy_reset(tp);
+
+	r8127_sds_modify(tp, 0, 1, 31, 0, BIT(3));
+	r8127_sds_modify(tp, 0, 2,  0, BIT(13) | BIT(12) | BIT(6), BIT(12) | BIT(6));
+	r8127_sds_modify(tp, 0, 0,  4, 0, BIT(2));
+
+	RTL_W16(tp, 0x233a, 0x8004);
+	RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x0002);
+
+	r8168_phy_ocp_write(tp, 0xc40a, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc466, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc808, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc80a, 0x0000);
+
+	val = r8168_phy_ocp_read(tp, 0xc804);
+	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
+}
+
 static void r8127_sfp_init_10g(struct rtl8169_private *tp)
 {
 	int val;
@@ -5756,8 +5823,20 @@ static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
 {
 	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
 
-	if (tp->sfp_mode == RTL_SFP_8127_ATF)
-		r8127_sfp_init_10g(tp);
+	if (tp->sfp_mode == RTL_SFP_8127_ATF) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_10GBASER:
+			r8127_sfp_init_10g(tp);
+			break;
+		case PHY_INTERFACE_MODE_1000BASEX:
+			r8127_sfp_init_1g(tp);
+			break;
+		default:
+			netdev_err(tp->dev, "Unsupported SFP interface mode: %s\n",
+				   phy_modes(interface));
+			return -EOPNOTSUPP;
+		}
+	}
 
 	return 0;
 }
@@ -5848,7 +5927,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 		tp->pcs.ops = &r8169_pcs_ops;
 		phy_mode = PHY_INTERFACE_MODE_10GBASER;
 		tp->phylink_config.default_an_inband = true;
-		tp->phylink_config.mac_capabilities |= MAC_10000FD;
+		tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_10000FD;
 		break;
 	default:
 		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
-- 
2.43.0


