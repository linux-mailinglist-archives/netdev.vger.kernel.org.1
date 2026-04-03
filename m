Return-Path: <netdev+bounces-274959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NxbEQiEz2n4wwYAu9opvQ
	(envelope-from <netdev+bounces-274959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:10:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB6392A0A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB8CE30489DF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B1389452;
	Fri,  3 Apr 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="SHUlefJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5E386554;
	Fri,  3 Apr 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207278; cv=none; b=p/A+jpybbjSE0Sa9U4zCFwuu+TTSYF1c+j+f23OjgtET8xt+cIkBXMonxyNT5Oy/DNeYF05bEREP9nPB8Hj6RrmZLus26Nva1jwrNYztwMxg2VZGGYvuvLCT47dCdktWuq7c9PSt6rc8urNS7Jt8pe599JJoGBvobf+SaCjv5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207278; c=relaxed/simple;
	bh=x+Qg86ngmxvdCWSlsCOUUWdvTgT/jqF42u/ZJKIPiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSw51xHErsY/zy0CXMaLINmdQJI5jdQYtM0pvi/bWc3cMwaOCUwXDd6zLhddcu274D2BkiNx9Y7A6CKo82u579DirGgsAhIiDG2xv4+lGx35CCXHvos25D9r/6nDkZWs4a9sOMAjjc26zogqzhwFyJ+TjS3Z89H9o/WstE57duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=SHUlefJz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44125A587E;
	Fri,  3 Apr 2026 11:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775207256; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iYmb1sSjS17BlK3cv6eC6Ie996k3le0BSTTtjEJ6ogE=;
	b=SHUlefJzwml17QAV/sPsW2OoZjpkVjWRw0ZuPdAs18aD4AE40MLgd7vcCBidw9wwt9K1od
	h1vZiTULSJrOef2FQKU7v+nvZm4+90IjG9pJ71j0qxMuu7UMi8LqTp3yIf9mwXRUila+A7
	2X/Nrbc5nR/+ZIp0XL52H0JQMljlyqwbNsG278HURxNR5c+Cd900s9+fOUjOtBDARoCZp5
	7uljS3nYv+uqFdD1L5K4cSdggmHUI3Kmfw+po8Y93IX/VpHxVCpm8GmsREOckpZf40BInT
	XY1KK2SH3oqdel2x24mpo9R9vlQ0ItNT8JH434KxBM/X/JkUGKGlFlbv2DFFlw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/3] net: phy: add support for disabling PHY-autonomous EEE
Date: Fri,  3 Apr 2026 11:06:51 +0200
Message-ID: <20260403090656.733985-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403090656.733985-1-nb@tipi-net.de>
References: <20260403090656.733985-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274959-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,broadcom.com,tipi-net.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 8DCB6392A0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some PHYs (e.g. Broadcom BCM54xx, Realtek RTL8211F) implement
autonomous EEE where the PHY manages LPI signaling without forwarding
it to the MAC. This conflicts with MAC drivers that implement their own
LPI control.

Add a .disable_autonomous_eee callback to struct phy_driver and call it
from phy_support_eee(). When a MAC driver indicates it supports EEE via
phy_support_eee(), the PHY's autonomous EEE is automatically disabled so
the MAC can manage LPI entry/exit.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy_device.c | 22 ++++++++++++++++++++++
 include/linux/phy.h          | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0edff47478c2..cda4abf4e68c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1375,6 +1375,14 @@ int phy_init_hw(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Re-apply autonomous EEE disable after soft reset */
+	if (phydev->autonomous_eee_disabled &&
+	    phydev->drv->disable_autonomous_eee) {
+		ret = phydev->drv->disable_autonomous_eee(phydev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(phy_init_hw);
@@ -2898,6 +2906,20 @@ void phy_support_eee(struct phy_device *phydev)
 	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
+
+	/* If the PHY supports autonomous EEE, disable it so the MAC can
+	 * manage LPI signaling instead. The flag is stored so it can be
+	 * re-applied after a PHY soft reset (e.g. suspend/resume).
+	 */
+	if (phydev->drv && phydev->drv->disable_autonomous_eee) {
+		int ret = phydev->drv->disable_autonomous_eee(phydev);
+
+		if (ret)
+			phydev_warn(phydev, "Failed to disable autonomous EEE: %pe\n",
+				    ERR_PTR(ret));
+		else
+			phydev->autonomous_eee_disabled = true;
+	}
 }
 EXPORT_SYMBOL(phy_support_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5de4b172cd0b..55d9cc6c3605 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -612,6 +612,8 @@ struct phy_oatc14_sqi_capability {
  * @advertising_eee: Currently advertised EEE linkmodes
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_active: phylib private state, indicating that EEE has been negotiated
+ * @autonomous_eee_disabled: Set when autonomous EEE has been disabled via
+ *	phy_support_eee(), used to re-apply after PHY soft reset
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
@@ -739,6 +741,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
 	bool enable_tx_lpi;
 	bool eee_active;
+	bool autonomous_eee_disabled;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
@@ -1359,6 +1362,21 @@ struct phy_driver {
 	void (*get_stats)(struct phy_device *dev,
 			  struct ethtool_stats *stats, u64 *data);
 
+	/**
+	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
+	 *
+	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
+	 * signaling to the MAC. This callback disables autonomous EEE so
+	 * that the MAC can control LPI entry/exit.
+	 *
+	 * Called by phy_support_eee() when the MAC indicates it supports
+	 * EEE. PHY drivers that implement autonomous EEE should provide
+	 * this callback.
+	 *
+	 * Return: 0 on success, negative errno on failure.
+	 */
+	int (*disable_autonomous_eee)(struct phy_device *dev);
+
 	/* Get and Set PHY tunables */
 	/** @get_tunable: Return the value of a tunable */
 	int (*get_tunable)(struct phy_device *dev,
-- 
2.51.0


