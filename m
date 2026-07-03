Return-Path: <netdev+bounces-304387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9LRIHoFhR2rjXQAAu9opvQ
	(envelope-from <netdev+bounces-304387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E719C6FF75B
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=d32y7Bhy;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304387-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C219C3022F57
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F38B131;
	Fri,  3 Jul 2026 07:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE22385D75;
	Fri,  3 Jul 2026 07:15:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062907; cv=none; b=fdYfoLGi3t4It5TVhwzgfQwY/lAbJAi1ZzWrZWtROB6VUQ5dzTWg9e8aZgMksAA3vZZaKBXAA5YcYXjTyebY+1iz1r1IPKX63z4M4AEskncEc9GlsYA82NXI+NSrEJlQX7iiFtkXAVp+rFXr4rDewlNzSCnzQ2DFCu/puLX+1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062907; c=relaxed/simple;
	bh=9Y+VtSZ5+2FDTJYqL6iqvKkS5LLuHdMfWyEtf4vQIVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNltssHXIgUf0uzth44OxOcmvbwhSnoUNd9l1kRTo2i7PNxciJW0wNk/VkFHZuduzT1JUKjXafz0Fa41kqndYh8ywTtAqB8HC1vVA/pamcix1DbDpvwd5TOUJeY5Dt8qyA6HgFDuj6Ht1xhzb7PhbPTatMeTVzVHRYQae//PkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=d32y7Bhy; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6637DXlT42503821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783062814;
	bh=CUgf1xo/HXVyBqs+SDToFOxYBjeBnyuC4ZTFl7Ul17w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d32y7Bhy6u8yjETnKvGBC+SMMW/+Uoh0906t2WHCe0e+nrLIJjLdNVQIHbJAv5egI
	 pP2eez+jTThJD8hQnDvRDSw2EPtBoml76PAx3a3viYJsam4ZOc/O6Nlq4xQ7Xik3tt
	 dQu9oZOlg7Ze/MsbQR3iHFm1XjcvYwY72MH4PXCGuw9Ac4iAjXcH7rUhhAEiG60H/6
	 C6V33wPOEwJeRecxR6KAq91W6HuJCydFKQPl8TmAUMPdoIp3R6TlcIszLEckvDLKDN
	 IchbmEcHP4HVEnvmWh2ZVzFMWcQ6jQs+29l/qs1Gi2+9HqYdCZGUV+qz1pIhMUa5IU
	 fZHHln50g1huw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6637DXlT42503821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 15:13:34 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 15:13:32 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 15:13:32 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v9 1/4] net: phy: c45: add genphy_c45_pma_soft_reset()
Date: Fri, 3 Jul 2026 15:13:27 +0800
Message-ID: <20260703071330.1707-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260703071330.1707-1-javen_xu@realsil.com.cn>
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304387-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E719C6FF75B

From: Javen Xu <javen_xu@realsil.com.cn>

Add a generic Clause 45 software reset helper. The helper sets the reset
bit in the PMA/PMD control register and waits until the bit is cleared by
hardware.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file

Changes in v3:
 - re-order function according to the order in phy-c45.c

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - increase timeout to 600ms

Changes in v7:
 - no changes

Changes in v8:
 - no changes

Changes in v9:
 - rename genphy_c45_soft_reset to genphy_c45_pma_soft_reset
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 126951741428..c1f817a59739 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -384,6 +384,28 @@ int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_check_and_restart_aneg);
 
+/**
+ * genphy_c45_pma_soft_reset - software reset the PHY via Clause 45 PMA/PMD control register
+ * @phydev: target phy_device struct
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int genphy_c45_pma_soft_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			       MDIO_CTRL1_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
+					 MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 600000, true);
+}
+EXPORT_SYMBOL_GPL(genphy_c45_pma_soft_reset);
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..d6bc19931fb8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2309,6 +2309,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
+int genphy_c45_pma_soft_reset(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
-- 
2.43.0


