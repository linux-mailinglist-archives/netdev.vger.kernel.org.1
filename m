Return-Path: <netdev+bounces-297911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5cLIGrgqKmoLjgMAu9opvQ
	(envelope-from <netdev+bounces-297911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF94466DF87
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:25:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=GNMWm6Xg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297911-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297911-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601DF3106FD4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635131715C;
	Thu, 11 Jun 2026 03:25:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175F25A2BB;
	Thu, 11 Jun 2026 03:25:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148320; cv=none; b=QUs4GttdisC6lk3vpD0RHJCbFOVGlwC4HfAI9Ssr4oZIyhxSXHKR4nrP0gcOuyHF8kSbMZOJE1kkUYveLJk5K2R0tut4RCJqZCIwKwWYNRL4M4GPcdU9maOBpV/9ByHUIDu+ecLpj9UHu7pOpiAfSN2AxxAAoRYBaY/2gWIM24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148320; c=relaxed/simple;
	bh=J9FaTYX1sUTtX0CWp5PZj9pwjHXcZzYwZhQeqhJeGPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh3o3iUT9NEm9pfHXxrdK91HQfWkSTP3nv8Rv65AhPt9X1iJSdY1LD+2fEX3cDFH8v1sN5weHOQ/ZEjdVfkup5iFy9ZR1tD9sxszKY2j9SAApkH2Ot2NYjhGprxb9uQYo1ThLALgbZ8JltTOZIWncE5+Yd0tVMuZ/5X3YVZBkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=GNMWm6Xg; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B3JUlD41578242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781147971;
	bh=8KV3a9NSG65JBsMrT+thtZZIJYU2UvbLw+6vYOEAU08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GNMWm6XgTdZ0EG/wLVF1FcxwGbX7HvaeOuN83/OA/SghIYku2xNFRjq5/eynyIIYM
	 20zbctpvcbn7ycQpYrWIKJlWG9g5wjh4qweMdwap+CBsRRDaHxyER1WRdAeKuKkkL3
	 Gjh6s0A1ozLVAsegaFgzL5LAan1XNX1BhsaXeL89iIZdY2RycgImfph/Qj+VKZMnF0
	 +SgHNqWJUXQe+0jXDJ5otlUVCi2yBD6qcSGzIFSG/S7LoEq7H1lVUvPo52b7RvMbtY
	 ywEd0v3xlfjTRBwEEsfAq6rmDzOiQYPK0GWX1LChkjghaEfEaRGIsMWGefl6253Zvv
	 n8259W9VW4Eag==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B3JUlD41578242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 11:19:31 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 11:19:30 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 11:19:30 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 2/4] net: phy: c45: add genphy_c45_config_master_slave()
Date: Thu, 11 Jun 2026 11:18:37 +0800
Message-ID: <20260611031839.568-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260611031839.568-1-javen_xu@realsil.com.cn>
References: <20260611031839.568-1-javen_xu@realsil.com.cn>
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
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297911-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF94466DF87

From: Javen Xu <javen_xu@realsil.com.cn>

Add a generic helper to configure forced master/slave mode for Clause 45
PHYs using the 10GBASE-T AN control register.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file

Changes in v3:
 - re-order function according to the order in phy-c45.c
 - add kernel-doc about return value
 - add MASTER_SLAVE_CFG_MASTER_PREFERRED,
   MASTER_SLAVE_CFG_SLAVE_PREFERRED, MASTER_SLAVE_CFG_UNKNOWN,
   MASTER_SLAVE_CFG_UNSUPPORTED, MASTER_SLAVE_CFG_SLAVE_PREFERRED cfg

Changes in v4:
 - no changes

Changes in v5:
 - move genphy_c45_an_setup_master_slave() to genphy_c45_config_aneg(),
   as that C22 does.
---
 drivers/net/phy/phy-c45.c | 47 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mdio.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d8a83179ec40..c7ff46715f03 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -406,6 +406,47 @@ int genphy_c45_soft_reset(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
 
+/**
+ * genphy_c45_an_setup_master_slave - Configure Master/Slave setting for C45 PHYs
+ * @phydev: target phy_device struct
+ *
+ * Description: Configure the forced or preferred Master/Slave role
+ * 10GBASE-T control register (MMD 7, Register 0x0020) according to
+ * IEEE 802.3 standards.
+ *
+ * Returns negative errno code on failure, 0 if Master/Slave didn't change,
+ * or 1 if Master/Slave modes changed.
+ */
+static int genphy_c45_an_setup_master_slave(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+		ctl = MDIO_AN_10GBT_CTRL_MS_PORT_TYPE;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+		break;
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		ctl = MDIO_AN_10GBT_CTRL_MS_ENABLE;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		return 0;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				      MDIO_AN_10GBT_CTRL_MS_ENABLE |
+				      MDIO_AN_10GBT_CTRL_MS_VALUE |
+				      MDIO_AN_10GBT_CTRL_MS_PORT_TYPE, ctl);
+}
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
@@ -1247,6 +1288,12 @@ int genphy_c45_config_aneg(struct phy_device *phydev)
 	if (ret > 0)
 		changed = true;
 
+	ret = genphy_c45_an_setup_master_slave(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 EXPORT_SYMBOL_GPL(genphy_c45_config_aneg);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..ffca03fd82c9 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,6 +332,9 @@
 #define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
+#define MDIO_AN_10GBT_CTRL_MS_ENABLE	0x8000	/* Master/slave manual config enable */
+#define MDIO_AN_10GBT_CTRL_MS_VALUE	0x4000	/* Master/slave config value (1=Master) */
+#define MDIO_AN_10GBT_CTRL_MS_PORT_TYPE	0x2000	/* Master Preferred Type */
 
 /* AN 10GBASE-T status register. */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
-- 
2.43.0


