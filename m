Return-Path: <netdev+bounces-305374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N5FAE7DITGropgEAu9opvQ
	(envelope-from <netdev+bounces-305374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D900719DE8
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:36:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=BOuJ6arj;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305374-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305374-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153B630EC5FB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8639734A;
	Tue,  7 Jul 2026 09:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2703396B8C;
	Tue,  7 Jul 2026 09:22:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416164; cv=none; b=kunemKKQjFoB0kdBHvQ0rWsWJsZRwLVPUDMN9XbG05xhOOt9yGM7UHVVeIHq1O310zB6n4PFwL+9tZ8BHQkaPRkNO0AyqCBWpztEdwh+AUKFafrohUgzA9GDZMOVnuLtVIwwJvIBkyXmUQFT8mUPxDAR9VfGaodu0PGQTk2SUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416164; c=relaxed/simple;
	bh=zEW02xdNxdxtVLbHHrXCgDgvPJRsJc476xqLIoKrsU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atnUNTeFEBQjaLHTh3sG/pYMKoVAssXvJC8oyPU6qROfVSTgSFWeJAz+fK0nUIEnVo334fSkQt0WoVAiHzTM98aaOGyw8pICYA/Bmkk7isWrZYDNTNk5URbUy2+MDLDM8/azhF+cX07jDwLDOYGGuXE8sXzvmPnULYOgk+FHML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=BOuJ6arj; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GdowE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415800;
	bh=0/u5yFqgeBiCDpXpLLiaSBsrFkSiy48Oz+dvZzdt/JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BOuJ6arjyg69wMdxMLtoeab7IBCca9VU/LksXB9cv4scxZS4kmv+K8Bw7+/P/Nygb
	 TiVXuG4CCTLSiL8zj4ZxboxK/QXMk7ZJ8v8w0JmWq2zNHayshEcKV2pkVAAVzRYhGt
	 WiMHv+ZRFKfjM6qkFtLgFaqFUKkchVzi8hx6FXN0dD7houdEZsdbtS6ZR/2ccmYiow
	 MTA/QQ0Tbi89IbXv7MW4DQ8pDwPlywUkveAmkI1YL2mPIRSQQ6l/JvbNRyvH97shwy
	 6Zgs/kHcu5liCDuL4JOXlAGiuysc7h+lY9zl3KlES9rT4oOo0jx7WrtIOcVyzJkrd/
	 oYzmXIl2hjWIQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GdowE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:39 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:39 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:39 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 2/8] net: phy: phylink: add helper to modify pause
Date: Tue, 7 Jul 2026 17:16:30 +0800
Message-ID: <20260707091637.371-3-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305374-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D900719DE8

From: Javen Xu <javen_xu@realsil.com.cn>

For Realtek nics, when we enable jumbo, pause are not supported. So we
must check the pause capabilities from ourself and lp.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v5:
 - no changes, new file
---
 drivers/net/phy/phylink.c | 66 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..c450ee33b75c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1828,6 +1828,72 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+/**
+ * phylink_set_mac_capabilities() - Dynamically update MAC capabilities
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ * @mac_capabilities: the new MAC capabilities mask
+ *
+ * This function allows a MAC driver to dynamically change its capabilities,
+ * such as losing/gaining Pause frame support based on MTU size.
+ * It recalculates supported link modes and triggers renegotiation if needed.
+ */
+void phylink_set_mac_capabilities(struct phylink *pl, unsigned long mac_capabilities)
+{
+	struct phylink_link_state *config = &pl->link_config;
+	unsigned long caps_added, caps_removed;
+
+	ASSERT_RTNL();
+
+	caps_added = mac_capabilities & ~pl->config->mac_capabilities;
+	caps_removed = pl->config->mac_capabilities & ~mac_capabilities;
+
+	if (!caps_added && !caps_removed)
+		return;
+
+	mutex_lock(&pl->state_mutex);
+
+	pl->config->mac_capabilities = mac_capabilities;
+
+	if (caps_removed & MAC_SYM_PAUSE)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
+	if (caps_removed & MAC_ASYM_PAUSE)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
+
+	linkmode_and(config->advertising, config->advertising, pl->supported);
+
+	if (caps_added & MAC_SYM_PAUSE) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
+		if (pl->phydev && !phylink_test(pl->phydev->supported, Pause))
+			linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, pl->supported);
+	}
+	if (caps_added & MAC_ASYM_PAUSE) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
+		if (pl->phydev && !phylink_test(pl->phydev->supported, Asym_Pause))
+			linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, pl->supported);
+	}
+
+	linkmode_and(config->advertising, config->advertising, pl->supported);
+
+	if (config->pause & MLO_PAUSE_AN) {
+		if (phylink_test(pl->supported, Pause))
+			linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, config->advertising);
+
+		if (phylink_test(pl->supported, Asym_Pause))
+			linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, config->advertising);
+	}
+
+	if (!pl->phydev)
+		phylink_change_inband_advert(pl);
+
+	mutex_unlock(&pl->state_mutex);
+
+	if (pl->phydev) {
+		linkmode_copy(pl->phydev->advertising, config->advertising);
+		phy_start_aneg(pl->phydev);
+	}
+}
+EXPORT_SYMBOL_GPL(phylink_set_mac_capabilities);
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac..56642ab961a7 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -842,4 +842,6 @@ void phylink_replay_link_begin(struct phylink *pl);
 
 void phylink_replay_link_end(struct phylink *pl);
 
+void phylink_set_mac_capabilities(struct phylink *pl, unsigned long mac_capabilities);
+
 #endif
-- 
2.43.0


