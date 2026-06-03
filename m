Return-Path: <netdev+bounces-294603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCDpD6XSH2rEqQAAu9opvQ
	(envelope-from <netdev+bounces-294603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:07:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC3634FD5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:07:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=dCgbqgfQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294603-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294603-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D0E2307BB7C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D06423146;
	Wed,  3 Jun 2026 06:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF1405874;
	Wed,  3 Jun 2026 06:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469986; cv=none; b=dD7RqucCmGoJ3mO6URWxtUnog8saCMI9+3PVeBe6QGbunnNuR1hKCwpkS9r+o6svQ7PHQ4kMAbw1QJDr+5e//G6nZwCenXCDq1qlsibmjWTIUEfZ/AN0Jbnh8RQ4Ean2RQcao8wf6lQA+VYeLHYQrDPgj/pJ/sFCEyWUtpcf278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469986; c=relaxed/simple;
	bh=FCaxCnHUNBLytx1qTehEeuA0qhUzKqnQxc/0700VcrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1rOFnO90A1ksdJnE8QXLe4FMMFv0x7iwdWuVWlsN9VBjD/7+6p7/En98MgKkWhKq5t20kyBJfFcMcb2WlufqlUGh/Bw/AM9f6acxf50peTXfPd+lJ0FmCsnyLGWxq7RLXDl6GHcP6Z1eyUSch9G9UOjjRBNTlnpLdsZ8bhxyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dCgbqgfQ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xJ0213643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469959;
	bh=Yx6ZtT/WPpSKU82LHR5gK89KHZT7iZS78k/qRj3b7n4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dCgbqgfQjB7jGMC7YkmsSFc5+kgze3woxRR8JvRzYk+0P5lkeehtbOEn45cqiBaFH
	 PnUE+4sXIY4Gkbz47dfOrwx6bDcBPv/GMzHpAsIv+v7ZVqZmlcjyVZ/6VuJnZa0YMV
	 LpBg5K2uSnfvUIYcfvZNU/iLHKnP8qAjL9z/keQB5krC1EmId+0Gi0ItkNa+Yu61zU
	 E+SalevNg6XIN8KZOvLEnY2DAgoKaxH3Q5Y3Og84Z3PnuQYvJf0YdCYAKB8g4JFIh9
	 +WUHLbbtaeUeIDuVp4h1PXlxkzRrpZzaYVcNToBs8+4DR8zNwFvRf3x7GrmO025ODM
	 mxdzDGCeG0jig==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xJ0213643786
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
Subject: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy phy
Date: Wed, 3 Jun 2026 14:59:12 +0800
Message-ID: <20260603065916.334-2-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294603-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5EC3634FD5

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for rtl8116af dummy phy driver, match phy id and read link
speed from MII_BMCR.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
 include/net/phy/realtek_phy.h          |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..9b92828c49d9 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -2659,6 +2659,47 @@ static int rtlgen_sfp_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8116af_sfp_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 phydev->supported);
+
+	phydev->speed = SPEED_1000;
+	phydev->duplex = DUPLEX_FULL;
+
+	phydev->port = PORT_FIBRE;
+
+	return 0;
+}
+
+static int rtl8116af_sfp_read_status(struct phy_device *phydev)
+{
+	int val, err;
+
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	if (!phydev->link)
+		return 0;
+
+	val = phy_read(phydev, MII_BMCR);
+	if (val < 0)
+		return val;
+
+	if (val & BMCR_SPEED1000)
+		phydev->speed = SPEED_1000;
+	else if (val & BMCR_SPEED100)
+		phydev->speed = SPEED_100;
+
+	if (val & BMCR_FULLDPLX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	return 0;
+}
+
 static int rtlgen_sfp_read_status(struct phy_device *phydev)
 {
 	int val, err;
@@ -2947,6 +2988,19 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
+	}, {
+		PHY_ID_MATCH_EXACT(PHY_ID_RTL8116AF_DUMMY),
+		.name		= "RTL8116af PHY Mode",
+		.flags		= PHY_IS_INTERNAL,
+		.get_features	= rtl8116af_sfp_get_features,
+		.config_aneg	= rtlgen_sfp_config_aneg,
+		.read_status	= rtl8116af_sfp_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
+		.read_mmd	= rtl822x_read_mmd,
+		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
diff --git a/include/net/phy/realtek_phy.h b/include/net/phy/realtek_phy.h
index d683bc1b0659..cbf91af0ead6 100644
--- a/include/net/phy/realtek_phy.h
+++ b/include/net/phy/realtek_phy.h
@@ -3,5 +3,6 @@
 #define _REALTEK_PHY_H
 
 #define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
+#define PHY_ID_RTL8116AF_DUMMY  0x001ccbfe
 
 #endif /* _REALTEK_PHY_H */
-- 
2.43.0


