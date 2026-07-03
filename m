Return-Path: <netdev+bounces-304390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nRHDAu1hR2r6XQAAu9opvQ
	(envelope-from <netdev+bounces-304390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F15036FF78E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=lBS16biX;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304390-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304390-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C7683011388
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA037189B;
	Fri,  3 Jul 2026 07:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE8386450;
	Fri,  3 Jul 2026 07:15:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062907; cv=none; b=dVi8ahAGLU4P11kO9yWFG7D4BxcM2FQTh2ovK2js9bOh/YyWrvBwnJSu1Scr7ezXyH4UBTjVvAYlME1AFJi9RAFq17wHESxFSii0bnvsI2JKvtBltKSNpbq2ueGAGXm0dFSLC0kJAyApRs0vOVMVcMf+oFq0BioWWHLepnY/lhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062907; c=relaxed/simple;
	bh=e8XK2FE/LwDEacBSAc2QG9iwbWozyEzHa2onC0PeQ8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qnx4ZU2PkFuh06WneuMGGYIeQv2dRb17o1avqXmQdFaLWXqu4HyIBJM4T7S0Yu15811ee4mie3I1AQN/qER9UwvbxS0uZK3FtOrf3STg5s9bKRHhfze5Tpa4Rh2RCUUTLygwCtDHixgV9AT1ud9ppXKar3qpa1orGguWSVvhYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=lBS16biX; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6637DYlR42503821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783062814;
	bh=ZIcpfKge3qwaFzZvppSkbm0OcMNQU6RnoGxgisXwl6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=lBS16biXqYgeSYqnBIF1y7I4yCAtTGtgp3v6nS6qUiKT1IHKm1DwOdomRP8jPnG6/
	 uBxdk32UBf1aPFB1OKB9AUTqroql9agMz8VazEqAFU0o8e71lBe64AXB0wp+PYOoJo
	 jwILVu6vTIoJf3+4YWZmpWqLOZAnKhWFGM3XGC3X73X2H6yd28Iqr+rHlvBbqo0fXr
	 b13CjiFoLHmXnwgJ/jEImh5hv9TsCj54Bfjix4KqV8m5H88SDXr8vfX3iaud6bs6uU
	 /7E8ysxTKLSv8x7nLlIUPuCSkYD+1SeK6Uq1tgi31RdSGiF0axrKfiSR5gNMm18Ow4
	 SEFAHvJvaQTKQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6637DYlR42503821
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
Subject: [PATCH net-next v9 2/4] net: phy: c45: add setup and read master/slave helpers
Date: Fri, 3 Jul 2026 15:13:28 +0800
Message-ID: <20260703071330.1707-3-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-304390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F15036FF78E

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds two static helpers in drivers/net/phy/phy-c45.c to
configure and read back master-slave roles for non BASE-T1 Clause 45
PHYs via the 10GBASE-T AN control/status registers.
These helpers are wired into genphy_c45_config_aneg() and
genphy_c45_read_status(). This changes the observable ethtool output
for drivers using the generic c45 read path.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

Changes in v6:
 - add colon in the function description
 - add genphy_c45_read_master_slave in read function

Changes in v7:
 - when phydev->link is down, just return UNKNOWN
 - modify commit message

Changes in v8:
 - no changes

Changes in v9:
 - no changes
---
 drivers/net/phy/phy-c45.c | 103 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mdio.h |   5 ++
 2 files changed, 108 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c1f817a59739..870920311f9a 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -406,6 +406,97 @@ int genphy_c45_pma_soft_reset(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_soft_reset);
 
+/**
+ * genphy_c45_an_setup_master_slave - Configure Master/Slave setting for C45 PHYs
+ * @phydev: target phy_device struct
+ *
+ * Description: Configure the forced or preferred Master/Slave role
+ * 10GBASE-T control register (MMD 7, Register 0x0020) according to
+ * IEEE 802.3 standards.
+ *
+ * Return: negative errno code on failure, 0 if Master/Slave didn't change,
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
+/**
+ * genphy_c45_read_master_slave - read master/slave status
+ * @phydev: target phy_device struct
+ *
+ * Description: Read the Master/Slave configuration and status
+ * from 10GBASE-T control/status registers (MMD 7, Reg 0x0020 and 0x0021).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int genphy_c45_read_master_slave(struct phy_device *phydev)
+{
+	int val;
+
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_AN_10GBT_CTRL_MS_ENABLE) {
+		if (val & MDIO_AN_10GBT_CTRL_MS_VALUE)
+			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
+		else
+			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	} else {
+		if (val & MDIO_AN_10GBT_CTRL_MS_PORT_TYPE)
+			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_PREFERRED;
+		else
+			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_PREFERRED;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_AN_10GBT_STAT_MS_FAULT) {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
+	} else if (phydev->link) {
+		if (val & MDIO_AN_10GBT_STAT_MS_RES)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+		else
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	} else {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+	}
+
+	return 0;
+}
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
@@ -1214,6 +1305,10 @@ int genphy_c45_read_status(struct phy_device *phydev)
 			ret = genphy_c45_baset1_read_status(phydev);
 			if (ret < 0)
 				return ret;
+		} else {
+			ret = genphy_c45_read_master_slave(phydev);
+			if (ret < 0)
+				return ret;
 		}
 
 		phy_resolve_aneg_linkmode(phydev);
@@ -1247,6 +1342,14 @@ int genphy_c45_config_aneg(struct phy_device *phydev)
 	if (ret > 0)
 		changed = true;
 
+	if (!genphy_c45_baset1_able(phydev)) {
+		ret = genphy_c45_an_setup_master_slave(phydev);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			changed = true;
+	}
+
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 EXPORT_SYMBOL_GPL(genphy_c45_config_aneg);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..06f4bc3c20c7 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,8 +332,13 @@
 #define MDIO_AN_10GBT_CTRL_ADV2_5G	0x0080	/* Advertise 2.5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
+#define MDIO_AN_10GBT_CTRL_MS_ENABLE	0x8000	/* Master/slave manual config enable */
+#define MDIO_AN_10GBT_CTRL_MS_VALUE	0x4000	/* Master/slave config value (1=Master) */
+#define MDIO_AN_10GBT_CTRL_MS_PORT_TYPE	0x2000	/* Master Preferred Type */
 
 /* AN 10GBASE-T status register. */
+#define MDIO_AN_10GBT_STAT_MS_FAULT	0x8000	/* Master/slave fault */
+#define MDIO_AN_10GBT_STAT_MS_RES	0x4000	/* Master/slave resolution (1=Master) */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
 #define MDIO_AN_10GBT_STAT_LP5G		0x0040  /* LP is 5GBT capable */
 #define MDIO_AN_10GBT_STAT_LPTRR	0x0200	/* LP training reset req. */
-- 
2.43.0


