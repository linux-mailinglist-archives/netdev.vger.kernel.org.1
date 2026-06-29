Return-Path: <netdev+bounces-302471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PzBpOHEVQmqEzwkAu9opvQ
	(envelope-from <netdev+bounces-302471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D8D6D683C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=JCywNqHV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302471-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F36783018751
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59F3AC0EB;
	Mon, 29 Jun 2026 06:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943973905F0;
	Mon, 29 Jun 2026 06:49:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715748; cv=none; b=QggSUtZEWOBw/nc4gB3dGyrX9PL+N0Gk5Dj5K7DH/jxcTeaFZtsz9P1tXGgX1U56DDVF2yaZ89lqjo8S7Pa4bgwzb3r3n1WHFjL1UNiMU1eAkZLo+vZDKc3xmBqe9h9si+pMq3SFlRIhUQgcKAVUer06XhSoQ5TBHp1csmCiWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715748; c=relaxed/simple;
	bh=6KmcwiDyX99vO1BDNAwyvmb2o8Y6QQ68nKwKx+XzeiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj5WADqfxyUNsWJTKD3PqQGwSCW42heaZQRBQYif8xUcVxJE1sJecILwRkMVbhECEkLUrXriTIaZKs6qAIpD0Lxak36X3caOZ+Rv+wBfdBFPz3PqscgFph647rZF0KS6JIMowagcYrNN+AXGxsWqd05sIXRU9Z1ZF5c7CHMd72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=JCywNqHV; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T6lKHl93483096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782715641;
	bh=NI3K/TqgCKTcmndsch8juEbFhwp4yoGxUCxMC1v0EWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JCywNqHVIXygmzydOGQQSN/GTCsZFsRCgrCEPDrmGW9Hd01s5cgG0Bm7qsoX11CzW
	 6+63H//PWHYd8fx6b8BZ+OXzs52/8QRMLOI1kG8Jxj3STETHckwkTeHB8agdI5G4VB
	 d48GltF52fiGy1ixKCZXca8SfNnjRIcZcsaAWUUvz+ZiE2JoS01AxcRRqMExTu4hNv
	 UchDHmjQqlK9R4fwL6CCbZqhVvhT/tcnIKi9YtKctnVgYoEqFabkcU2Wpa4qQ+rXIy
	 0rWNea/etKeKauIq9BNwtGeWSAwsIiLtH4XVxSMzxC7MXKVA6l3gUlK2ULIGdXm73N
	 kjBrsBFfPOlUg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T6lKHl93483096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:47:20 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:47:20 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:47:20 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, <nic_swsd@realtek.com>,
	Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 1/4] net: phy: c45: add genphy_c45_soft_reset()
Date: Mon, 29 Jun 2026 14:47:15 +0800
Message-ID: <20260629064718.1349-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260629064718.1349-1-javen_xu@realsil.com.cn>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
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
	TAGGED_FROM(0.00)[bounces-302471-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:nic_swsd@realtek.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75D8D6D683C

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
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 126951741428..60d044156a83 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -384,6 +384,28 @@ int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_check_and_restart_aneg);
 
+/**
+ * genphy_c45_soft_reset - software reset the PHY via Clause 45 PMA/PMD control register
+ * @phydev: target phy_device struct
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int genphy_c45_soft_reset(struct phy_device *phydev)
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
+EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..25a66320df56 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2309,6 +2309,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
+int genphy_c45_soft_reset(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
-- 
2.43.0


