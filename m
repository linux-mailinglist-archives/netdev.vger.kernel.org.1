Return-Path: <netdev+bounces-303935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +H0OOCrZRWoRGAsAu9opvQ
	(envelope-from <netdev+bounces-303935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 691936F332B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b="Lj0D/tcf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DC0301DC3B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C83126B2;
	Thu,  2 Jul 2026 03:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D643101B6;
	Thu,  2 Jul 2026 03:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962468; cv=none; b=DOw+QWL7bXmo+iW0hrF/RJLwYWhiGzjYjeZMYW7kMg50eb9vqsvwB+ebv8aANW0bqCxz2r9NuS/rR17wuBPd5CMEBydY4y65IYRGE3M2IQH1lzZpOmdA6gddr9Vnc5E/bKZ11o/gWbpMhKgxQhtZcJVkt/xt+MkAIeguCGsrF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962468; c=relaxed/simple;
	bh=cRDoagvK/5R79hhFBgOVk5pVWBLNINfknZo5j7Igte0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqAxg7kyJ8wh7ebaVTNvahKVRTzFcvYvhdUp217VMxTXgH2I1qENikoPai5At+ver4xFmLdI5l+ShTg3A0nkFsYhsVcwv9IpMLi8pUXq6RlZceoHWIy6x1ptewXURN9/27jtMoUPE0FhpJx1e1/JCTjHR7R5ayQ2vr1Zlb6iqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Lj0D/tcf; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6623KND201649089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782962424;
	bh=+spHcLhYI+1IViC6SjBtwdbqWIq8c7qFMItApfpuISA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Lj0D/tcfT4s2N9COgggSV7sFawcjl1WSYUm6ybIiMRfCeczLN3s0jbtICGXZgiA2U
	 sBTqErDAlKpU4Rugbb2RsoxzwOR7lQAl8z2nrMStfW31rZaAlcEMw6TdZ9oqgVvLXd
	 Bti4VPhW8r4yBGaHIjh0k0t4Cu3vt1j/t8l+oOYdsGsQuT8Rj/dOh1xMdmrgHlX7JU
	 Zr893b/N3eOAMwKggmlOBuBNYxRhMRzQ5a13WDBvpeQG5H0lFdqPi+qPtQRw6CdSGT
	 FOa8yFr66GkDetha/RoSxSypxy+un0InBZeGNe1KKmEmWLU5mJodHEs31GMkDtNi5C
	 WqVQlmGRql4uw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6623KND201649089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 11:20:24 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Jul 2026 11:20:23 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Jul 2026 11:20:23 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 2/4] net: phy: c45: add setup and read master/slave helpers
Date: Thu, 2 Jul 2026 11:20:17 +0800
Message-ID: <20260702032020.589-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260702032020.589-1-javen_xu@realsil.com.cn>
References: <20260702032020.589-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303935-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 691936F332B

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
---
 drivers/net/phy/phy-c45.c | 103 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mdio.h |   5 ++
 2 files changed, 108 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 60d044156a83..df682d3ebd5a 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -406,6 +406,97 @@ int genphy_c45_soft_reset(struct phy_device *phydev)
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


