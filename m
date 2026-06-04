Return-Path: <netdev+bounces-295073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6scfKyotIWqGAAEAu9opvQ
	(envelope-from <netdev+bounces-295073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:45:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B863DB7E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=ucYemEry;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295073-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6F43043FFA
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2843988F9;
	Thu,  4 Jun 2026 07:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89E394788;
	Thu,  4 Jun 2026 07:42:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558972; cv=none; b=XKPLn9B4vvhSOOtcJP6K5n2wONomXkcC09eEmR7XssURh5KMfhs5Uywj+joPMBWXTH9RLro63/eoCIlpb/ac3bnoTkXVexo4CRL5MAI9L9n39jvFXYiWbhhLCytu6HQBvux8M6N1Rj8XdM2Rl2SdqM4YQKwSqcK/uK9zc5FLj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558972; c=relaxed/simple;
	bh=TnMIemFlNZga1NcA05eZMeODmw+F/dtvCz3ialD0qh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhmgvjdNbe3VjXI46Lv/GHSID6zxyYUbeJA9L8FN+logQz8jinGJ7Aahed70befq0tl3ab1J9Yo9Rxp+D0UaazcbxSPEzqdyC1FBr4oAIwOS9mQEXoA7p2UnUbHaAgonDDTzTw++9+/kYvJ73x5P969qDfMm1L7t4BT1/VgKyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ucYemEry; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547gCosD206040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558932;
	bh=EwdlIooH6T36HcqnKhFk40dIknqRzenkj9VLa93ZvVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ucYemErynuH/IPO/nn7dJGSWFAw1G8ADxFzbmzB7JxazO5c9VCkJ4FAKeNw/nJW34
	 KMmmIhjXRwuvzNOh/HGagDPqjnq/SkigAoogllCpLBX8SoCubIdouEJeGsD5ZbNdo2
	 oGW60aWlN+VtgfGrSV0ys0MLLNJRzI1RXjztTr5ep7ez2stx8wk8x7pM/BR+AW37SS
	 krgegkyIbwzqEuxeW0wUl4XtE0FLY8bidUrP10rgBmzu9D8QIDQVt+WO/JbJfMu7rT
	 f9mwX/1MwbZXFnWqkklR9aIWsajjGF1Vz4C6WxQ5uOZR7gyIRp08DRH3NcfZFL8v25
	 La2KNGoAfAxEw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547gCosD206040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:42:12 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:42:11 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 15:42:11 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 1/4] net: phy: c45: add genphy_c45_soft_reset()
Date: Thu, 4 Jun 2026 15:42:06 +0800
Message-ID: <20260604074209.93-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604074209.93-1-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295073-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 068B863DB7E

From: Javen Xu <javen_xu@realsil.com.cn>

Add a generic Clause 45 software reset helper. The helper sets the reset
bit in the PMA/PMD control register and waits until the bit is cleared by
hardware.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 126951741428..216a2cb9e3f0 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -330,6 +330,28 @@ int genphy_c45_an_disable_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_an_disable_aneg);
 
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
+					 5000, 100000, true);
+}
+EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
+
 /**
  * genphy_c45_restart_aneg - Enable and restart auto-negotiation
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


