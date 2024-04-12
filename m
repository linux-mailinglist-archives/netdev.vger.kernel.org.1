Return-Path: <netdev+bounces-87442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5F8A3229
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D081F25169
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07541509A9;
	Fri, 12 Apr 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uUFjUxj0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0112149C74
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934921; cv=none; b=Vr1oPny6U++rIdVIyj5lFoRABB2XqthsnlyVGywwZT3bNioXQRv2NMSgnQFvMC1HoNGP0OYFg2nflSornjn7yprmxd/QdZ6JWCYUdjrGYNToL7y824nUkDNZ9aS6ZxXGgIz2iMjpzI12zZnDFtmtEuVV/Kp+GLdKMBHT13OiFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934921; c=relaxed/simple;
	bh=5J6XS6AtLClqmvZU6PvLp/2UVtoyIbJCP3F2YGOHQ7I=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=mz59mo0pNYVxoD/mhh/RN+9936gM3kB96acPv8xuzJ3FQyGsHrks4J4bGqd8qzJE7JltUQCgBlAFoxeh0oFBiPnFcRI2N6riU+dAvsBo9+4EaSzAOlgPtrcywVRE9VWuNUK+Gzk7Zij3s4oIW/BG37oA6c4l+G107vDet8UJMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uUFjUxj0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1IowwP+4BB9KyZXRDwt0GxdiJvt1JE+G76huQb8NJRU=; b=uUFjUxj0awD/O3woBMq+84Pj57
	onUGXmkcXkf9zfl6pfHAeJ+owO7VPrdfttNBQPFlSjWhS88clv39y6Y4aSqzbC8Pncv1F8kC86aaK
	CE0nxq9DTnl+pYmqYdNo6FAnWjwSiAA/LxIzaSxKfgc0DdNVpHLZKGNj2PRMp/t9npiUVFm4+Hfkt
	nlRI32ZLtojmqY7+BSD0O5yW8DOER5MZJWvQMH2iG3w1FR9gu6k+N3D92U32WbrhFtvnAj1jfXVFt
	ZXucobu8R7HtVIYwoyuaGiSzbgoUOZ1jiAq8ce8eQ620XEFXzMm6HgIvRhA2jYrg393n1OW7ona+/
	kHK0gqgQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47780 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcT-0002c6-06;
	Fri, 12 Apr 2024 16:15:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIcT-006bQW-S3; Fri, 12 Apr 2024 16:15:13 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: sja1105: provide own phylink MAC
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:13 +0100

Convert sja1105 to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index fc262348a134..ee0fb1c343f1 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1358,10 +1358,11 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
 }
 
 static struct phylink_pcs *
-sja1105_mac_select_pcs(struct dsa_switch *ds, int port, phy_interface_t iface)
+sja1105_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
-	struct sja1105_private *priv = ds->priv;
-	struct dw_xpcs *xpcs = priv->xpcs[port];
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct sja1105_private *priv = dp->ds->priv;
+	struct dw_xpcs *xpcs = priv->xpcs[dp->index];
 
 	if (xpcs)
 		return &xpcs->pcs;
@@ -1369,21 +1370,31 @@ sja1105_mac_select_pcs(struct dsa_switch *ds, int port, phy_interface_t iface)
 	return NULL;
 }
 
-static void sja1105_mac_link_down(struct dsa_switch *ds, int port,
+static void sja1105_mac_config(struct phylink_config *config,
+			       unsigned int mode,
+			       const struct phylink_link_state *state)
+{
+}
+
+static void sja1105_mac_link_down(struct phylink_config *config,
 				  unsigned int mode,
 				  phy_interface_t interface)
 {
-	sja1105_inhibit_tx(ds->priv, BIT(port), true);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	sja1105_inhibit_tx(dp->ds->priv, BIT(dp->index), true);
 }
 
-static void sja1105_mac_link_up(struct dsa_switch *ds, int port,
+static void sja1105_mac_link_up(struct phylink_config *config,
+				struct phy_device *phydev,
 				unsigned int mode,
 				phy_interface_t interface,
-				struct phy_device *phydev,
 				int speed, int duplex,
 				bool tx_pause, bool rx_pause)
 {
-	struct sja1105_private *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct sja1105_private *priv = dp->ds->priv;
+	int port = dp->index;
 
 	sja1105_adjust_port_config(priv, port, speed);
 
@@ -3198,6 +3209,13 @@ static void sja1105_teardown(struct dsa_switch *ds)
 	sja1105_static_config_free(&priv->static_config);
 }
 
+static const struct phylink_mac_ops sja1105_phylink_mac_ops = {
+	.mac_select_pcs	= sja1105_mac_select_pcs,
+	.mac_config	= sja1105_mac_config,
+	.mac_link_up	= sja1105_mac_link_up,
+	.mac_link_down	= sja1105_mac_link_down,
+};
+
 static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.connect_tag_protocol	= sja1105_connect_tag_protocol,
@@ -3207,9 +3225,6 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_change_mtu	= sja1105_change_mtu,
 	.port_max_mtu		= sja1105_get_max_mtu,
 	.phylink_get_caps	= sja1105_phylink_get_caps,
-	.phylink_mac_select_pcs	= sja1105_mac_select_pcs,
-	.phylink_mac_link_up	= sja1105_mac_link_up,
-	.phylink_mac_link_down	= sja1105_mac_link_down,
 	.get_strings		= sja1105_get_strings,
 	.get_ethtool_stats	= sja1105_get_ethtool_stats,
 	.get_sset_count		= sja1105_get_sset_count,
@@ -3375,6 +3390,7 @@ static int sja1105_probe(struct spi_device *spi)
 	ds->dev = dev;
 	ds->num_ports = priv->info->num_ports;
 	ds->ops = &sja1105_switch_ops;
+	ds->phylink_mac_ops = &sja1105_phylink_mac_ops;
 	ds->priv = priv;
 	priv->ds = ds;
 
-- 
2.30.2


