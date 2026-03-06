Return-Path: <netdev+bounces-264710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLTJDgmRqml0TQEAu9opvQ
	(envelope-from <netdev+bounces-264710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:32:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC721D18D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ACB5301547C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE623793CD;
	Fri,  6 Mar 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1uFw0D4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9607296BBA
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785924; cv=none; b=DBA4etlThHZ9ak2Mzg01NftdBBqjB0dvZk403Hq/ME2iSDPiZkYPweMSXQYIl4GUuGVBw7wWGoHi6ZpZtExZudAAur8Qs4DJub2bus/t+3f+wmgcMqSHTMAdCJWhwqGDfh9F341iB8w0xpBA3YqSopWZfpjR+DRhJxHJSyIhJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785924; c=relaxed/simple;
	bh=o/l0QyEd+y89+NuAuZJheEmN07xRWM6znqhi6OlYLUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UshZi8l0UoLSr7QTuQ/rxOqdNrnu3ml4lA+qDydttGpjAmWtVfraqAbOwulXvEOiCep3iCg/s52wYGyfjQb3ACGUObfXaVlZycPv/fJCCDt5a4NaQaNw9uLiDd+jpBAWv9FgTr9vvFBJaThrqfSsWHwQabM3Ef+xbs5wgeNTJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1uFw0D4/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B08AA22EE;
	Fri,  6 Mar 2026 09:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772785917; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8S3hnEeM4DBbONW643lecCeH+T2bm92nTbV7z9bTgBs=;
	b=1uFw0D4/vQT9Tgys0uFHUuWvSkysa3tV2F0u87vVzQsT9YK5x9BzUMs0WYrphNnk8sjGFc
	5hLtGJTXQxrxr4aCAz0lO4YtDIh1RhdYolqLNvqI53xN+8NEuEYvQYQ3an9zaVWub9yC38
	iAzoOdN7VzUX+/9d7xXAfW1fB7ZZttoS7ccNE5taSetMYYPusoOIDmTksKfm770Nib7pw1
	1v5HnEi4JiHTnLtzv2gWlf7nemV112nHgW1THVIlbjBEnsWqydsyzd7jESZZsZukIn20ko
	hCQIT6/r6h1J6U/sbYXDRPiQaCUlNWn/tWPs8DlDJKp9Vb5s0W59HmpR7G21yA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	o.rempel@pengutronix.de,
	rmk+kernel@armlinux.org.uk,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net] net: bcmgenet: fix broken EEE by converting to phylib-managed state
Date: Fri,  6 Mar 2026 09:31:19 +0100
Message-ID: <20260306083120.1076104-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8ACC721D18D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264710-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,armlinux.org.uk,tipi-net.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The bcmgenet EEE implementation is broken in several ways.
phy_support_eee() is never called, so the PHY never advertises EEE
and phylib never sets phydev->enable_tx_lpi.  bcmgenet_mac_config()
checks priv->eee.eee_enabled to decide whether to enable the MAC
LPI logic, but that field is never initialised to true, so the MAC
never enters Low Power Idle even when EEE is negotiated - wasting
the power savings EEE is designed to provide.  The only way to get
EEE working at all is a manual 'ethtool --set-eee eth0 eee on' after
every link-up, and even then bcmgenet_get_eee() immediately clobbers
the reported state because phy_ethtool_get_eee() overwrites
eee_enabled and tx_lpi_enabled with the uninitialised PHY eee_cfg
values.  Finally, bcmgenet_mac_config() is only called on link-up,
so EEE is never disabled in hardware on link-down.

Fix all of this by removing the MAC-side EEE state tracking
(priv->eee) and aligning with the pattern used by other non-phylink
MAC drivers such as FEC.

Call phy_support_eee() in bcmgenet_mii_probe() so the PHY advertises
EEE link modes and phylib tracks negotiation state.  Move the EEE
hardware control to bcmgenet_mii_setup(), which is called on every
link event, and drive it directly from phydev->enable_tx_lpi - the
flag phylib sets when EEE is negotiated and the user has not disabled
it.  This enables EEE automatically once the link partner agrees and
disables it cleanly on link-down.

Make bcmgenet_get_eee() and bcmgenet_set_eee() pure passthroughs to
phy_ethtool_get_eee() and phy_ethtool_set_eee(), with the MAC
hardware register read/written for tx_lpi_timer.  Drop struct
ethtool_keee eee from struct bcmgenet_priv.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Link: https://lore.kernel.org/netdev/d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch/
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This patch supersedes two earlier submissions:
- [1] https://lore.kernel.org/netdev/20260303160225.542613-1-nb@tipi-net.de/
- [2] https://lore.kernel.org/netdev/20260303153918.538902-1-nb@tipi-net.de/

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 32 ++++++++-----------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  5 +--
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 10 +++---
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a71cd729fde6..5cebc663c307 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1342,8 +1342,7 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
-			     bool tx_lpi_enabled)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1363,7 +1362,7 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (tx_lpi_enabled)
+	if (enable)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1382,14 +1381,11 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 		priv->clk_eee_enabled = false;
 	}
 
-	priv->eee.eee_enabled = enable;
-	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_keee *p = &priv->eee;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1397,17 +1393,23 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->tx_lpi_enabled = p->tx_lpi_enabled;
+	int ret;
+
+	ret = phy_ethtool_get_eee(dev->phydev, e);
+	if (ret)
+		return ret;
+
+	/* tx_lpi_timer is maintained by the MAC hardware register; the
+	 * PHY-level eee_cfg timer is not set for GENET.
+	 */
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
-	return phy_ethtool_get_eee(dev->phydev, e);
+	return 0;
 }
 
 static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_keee *p = &priv->eee;
-	bool active;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1415,15 +1417,7 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	p->eee_enabled = e->eee_enabled;
-
-	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false, false);
-	} else {
-		active = phy_init_eee(dev->phydev, false) >= 0;
-		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
-	}
+	bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_set_eee(dev->phydev, e);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 5ec3979779ec..9e4110c7fdf6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -665,8 +665,6 @@ struct bcmgenet_priv {
 	u8 sopass[SOPASS_MAX];
 
 	struct bcmgenet_mib_counters mib;
-
-	struct ethtool_keee eee;
 };
 
 static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)
@@ -749,7 +747,6 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			      enum bcmgenet_power_mode mode);
 
-void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
-			     bool tx_lpi_enabled);
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable);
 
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 38f854b94a79..a4e0d5a68268 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -29,7 +29,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
 	u32 reg, cmd_bits = 0;
-	bool active;
 
 	/* speed */
 	if (phydev->speed == SPEED_1000)
@@ -90,10 +89,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	spin_unlock_bh(&priv->reg_lock);
 
-	active = phy_init_eee(phydev, 0) >= 0;
-	bcmgenet_eee_enable_set(dev,
-				priv->eee.eee_enabled && active,
-				priv->eee.tx_lpi_enabled);
 }
 
 /* setup netdev link state when PHY link status change and
@@ -113,6 +108,8 @@ void bcmgenet_mii_setup(struct net_device *dev)
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 	}
 
+	bcmgenet_eee_enable_set(dev, phydev->enable_tx_lpi);
+
 	phy_print_status(phydev);
 }
 
@@ -412,6 +409,9 @@ int bcmgenet_mii_probe(struct net_device *dev)
 	/* Indicate that the MAC is responsible for PHY PM */
 	dev->phydev->mac_managed_pm = true;
 
+	if (!GENET_IS_V1(priv))
+		phy_support_eee(dev->phydev);
+
 	return 0;
 }
 
-- 
2.51.0


