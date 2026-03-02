Return-Path: <netdev+bounces-262525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGF9HEkvpWkZ5QUAu9opvQ
	(envelope-from <netdev+bounces-262525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:33:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56A1D37AC
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 161DB300AD78
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB11375AC4;
	Mon,  2 Mar 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="hBpNqnGc"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEB72618;
	Mon,  2 Mar 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433184; cv=none; b=NSVbzy0BcRoH4QGM2faDPWO7aQ1SpBvDTkO51FL6ii0RYOoL5dFg55PBlG3GkPO6GxdvJwVMkzFdjJZy/IW8j6Pgm0IQd8Uo4BndVqcCAyx3AazAvwqthjEcIHDWDMaDe6Ei/8De9nR6ynjBTh4w7eTpTo/eaT+A24o83v07+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433184; c=relaxed/simple;
	bh=exDKFHuVoPT4I5x8qmQXSY6oH3arKMUls+dSQbROPzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C24NuSyM5/uXSuRrIsfsmzyIOXTSwbDcM2JxhylXR2592jk17Z/fuEl4saMI6YWm3zQM0FhBFTWqBlRuT2wlid4JtyrGCijPHKnup4r/ahym4jEYzudfX97b0yJk69xxE/mJOefTbKg8IdLGziXUd43OPr0aABbFJNLt0I8xses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=hBpNqnGc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6226WVjI42520770, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772433151;
	bh=cOwMm0LaDEQUXLcTV1g/RYCruMiXcWjqOtGMOxHa7DQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hBpNqnGcLF1kgT7N9YR0jc4RZXmGmS9hcNqPadZVeSBfp994XG8z2pqNArUwHoZvC
	 c8EYUiv+dqQA+nWuEpxQZ3VgQHhpO62PUQ9vsCpJ7kyUIXTlAE2+qO56SM+nxNwDf2
	 ALNdO+sUBjIYErQpWL+PAN/p4hShJiaxbcGXj6plaQxJ17+ldIfZPJWvWHM90AFEEK
	 lhfIBEIt9Mhw+gb9tOq2xQA+lhWU5ALZrMAOI/ynxauiofR0qZ5Rg/CB99BYjuLF8V
	 UmlhGmj7PIpBJwZAzStRjpv2OAdamwOff2WDgBhR3/Sg+X9QgCsoM2upuR4MEq80Lo
	 Whu1XrsS3W6vQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6226WVjI42520770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 14:32:31 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Mar 2026 14:32:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 2 Mar 2026 14:32:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Date: Mon, 2 Mar 2026 14:32:12 +0800
Message-ID: <20260302063215.1790-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260302063215.1790-1-javen_xu@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262525-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C56A1D37AC
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is a variation of RTL8168fp. It uses SerDes instead of PHY.
But SerDes status will not relect to PHY. So it needs to add sfp mode
for quirk to help reflect SerDes status during PHY read.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 71 ++++++++++++++++++++---
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fb2247a20c36..a5c0d3995328 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -726,6 +726,12 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rtl_sfp_mode {
+	RTL_SFP_NONE,
+	RTL_SFP_8168_AF,
+	RTL_SFP_8127_ATF,
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -734,6 +740,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -760,7 +767,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1126,7 +1132,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		return 0;
 
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1270,6 +1276,34 @@ static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
 	return r8168_phy_ocp_read(tp, tp->ocp_base + reg * 2);
 }
 
+/* The quirk reflects RTL8116af SerDes status. */
+static int r8116af_mdio_read_quirk(struct rtl8169_private *tp, int reg)
+{
+	u8 phyStatus = RTL_R8(tp, PHYstatus);
+
+	if (!(phyStatus & LinkStatus))
+		return 0;
+
+	/* BMSR */
+	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMSR)
+		return BMSR_ANEGCOMPLETE | BMSR_LSTATUS;
+
+	/* PHYSR */
+	if (tp->ocp_base == 0xa430 && reg == 0x12) {
+		if (phyStatus & _1000bpsF)
+			return 0x0028;
+		else if (phyStatus & _100bps)
+			return 0x0018;
+	}
+
+	return 0;
+}
+
+static int r8116af_mdio_read(struct rtl8169_private *tp, int reg)
+{
+	return r8168g_mdio_read(tp, reg) | r8116af_mdio_read_quirk(tp, reg);
+}
+
 static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
 {
 	if (reg == 0x1f) {
@@ -1280,6 +1314,13 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
 	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
 }
 
+static bool rtl_is_8116af(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
+		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
+		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
+}
+
 static int mac_mcu_read(struct rtl8169_private *tp, int reg)
 {
 	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
@@ -1386,7 +1427,10 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
-		return r8168g_mdio_read(tp, location);
+		if (tp->sfp_mode == RTL_SFP_8168_AF)
+			return r8116af_mdio_read(tp, location);
+		else
+			return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
 	}
@@ -1575,6 +1619,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
+{
+	if (rtl_is_8125(tp)) {
+		u16 data = r8168_mac_ocp_read(tp, 0xd006);
+
+		if ((data & 0xff) == 0x07)
+			return RTL_SFP_8127_ATF;
+	} else if (rtl_is_8116af(tp)) {
+		return RTL_SFP_8168_AF;
+	}
+
+	return RTL_SFP_NONE;
+}
+
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
@@ -5693,12 +5751,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	tp->aspm_manageable = !rc;
 
-	if (rtl_is_8125(tp)) {
-		u16 data = r8168_mac_ocp_read(tp, 0xd006);
-
-		if ((data & 0xff) == 0x07)
-			tp->sfp_mode = true;
-	}
+	tp->sfp_mode = rtl_get_sfp_mode(tp);
 
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
-- 
2.43.0


