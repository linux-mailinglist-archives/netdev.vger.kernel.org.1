Return-Path: <netdev+bounces-98668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C708D201D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820A52855C0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E517084E;
	Tue, 28 May 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ycJXclVn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62116F8E0
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909357; cv=none; b=L+C0v6D/zr5rSzA2I4DQr0a1mEJIcm1WocYHDYHtTojnmvKsq/qqpz2NmYwEvmFgrlpxTr6PhJHMKV4qnVeiqdnGHtHjCrP679qPiSVpZTuaexhzNL+TJFXqzQ9A80SKvmMmAGXc3lcK0uLl7sG10LiJZknc+Kxz2IkPtpUXVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909357; c=relaxed/simple;
	bh=z59CPPVOYmzo/OuFXEgGGJKORWBF1iB/A/L8NdzwZQk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=kVhM20jFmjt85JnXYntz1Bnm/2j049NdMhc16+ZWBfMzLH6oX2Cq9Ow1/ebfWmtv8ulKHwhx4AiItnabFcLD0eBqmI3rJu4kH2fcjy4jpTbOr1A+GBJBMuRJvHSNROmJci9WOfjlDMh4pBuv1gbXgae1EOsUXmSUTJs/SAE0L7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ycJXclVn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rB6NVp7+cndCbj7AZ0U08NjdzEpMsgIkl166PqB0Pns=; b=ycJXclVn2F4nr1fdQ4VcQ9Ikvc
	OwPcANrAFnk8vjpSLeXymMnh3yvXOE/RUmVXg7qHhez/aI6Ercbgbhf0DvURCGkGfoOBDk5XbIsWV
	MYoih4SYdQKMIqTFG6qSQpf8zBrWhFK2J5sEbJXgjGfUlOvu41apYkVlj1yyN4JKU8FzlXxMWNw2+
	wtPELoWw2JGaEgfWFEUaJJv30o4Ford4Q7VBFuopIUwsrsoG2OXthXQ92PnUoMUHlqWINDn20Q0cy
	r8eBFzyiAz+e74Z5E3EjyQJZwUxeIjr+6q6yCPB5y9YKP14WX1GjBlhG1HZGlyEZlGOXW9D273FXx
	EkoahC1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45262 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sByY7-0004zn-36;
	Tue, 28 May 2024 16:15:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sByYA-00EM0y-Jn; Tue, 28 May 2024 16:15:42 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: felix: provide own phylink MAC operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sByYA-00EM0y-Jn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 16:15:42 +0100

Convert felix to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Back in the thread for the previous posting
https://lore.kernel.org/r/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk
it was identified that two other sub-drivers also needed an update,
and through that identical code in each was identified. In the
final message of the sub-thread from Vladimir, Vladimir volunteered
to pick this up and I agreed. However, I haven't seen anything yet.
I guess Vladimir's attention is elsewhere, so I've done the minimal
fixup for this driver.

 drivers/net/dsa/ocelot/felix.c           | 54 ++++++++++++++++--------
 drivers/net/dsa/ocelot/felix.h           |  1 +
 drivers/net/dsa/ocelot/felix_vsc9959.c   |  1 +
 drivers/net/dsa/ocelot/ocelot_ext.c      |  1 +
 drivers/net/dsa/ocelot/seville_vsc9953.c |  1 +
 5 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 61e95487732d..3aa66bf9eafc 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1050,24 +1050,32 @@ static void felix_phylink_get_caps(struct dsa_switch *ds, int port,
 		  config->supported_interfaces);
 }
 
-static void felix_phylink_mac_config(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_config(struct phylink_config *config,
 				     unsigned int mode,
 				     const struct phylink_link_state *state)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	if (felix->info->phylink_mac_config)
 		felix->info->phylink_mac_config(ocelot, port, mode, state);
 }
 
-static struct phylink_pcs *felix_phylink_mac_select_pcs(struct dsa_switch *ds,
-							int port,
-							phy_interface_t iface)
+static struct phylink_pcs *
+felix_phylink_mac_select_pcs(struct phylink_config *config,
+			     phy_interface_t iface)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
 	struct phylink_pcs *pcs = NULL;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	if (felix->pcs && felix->pcs[port])
 		pcs = felix->pcs[port];
@@ -1075,11 +1083,13 @@ static struct phylink_pcs *felix_phylink_mac_select_pcs(struct dsa_switch *ds,
 	return pcs;
 }
 
-static void felix_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_link_down(struct phylink_config *config,
 					unsigned int link_an_mode,
 					phy_interface_t interface)
 {
-	struct ocelot *ocelot = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
 	struct felix *felix;
 
 	felix = ocelot_to_felix(ocelot);
@@ -1088,15 +1098,19 @@ static void felix_phylink_mac_link_down(struct dsa_switch *ds, int port,
 				     felix->info->quirks);
 }
 
-static void felix_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void felix_phylink_mac_link_up(struct phylink_config *config,
+				      struct phy_device *phydev,
 				      unsigned int link_an_mode,
 				      phy_interface_t interface,
-				      struct phy_device *phydev,
 				      int speed, int duplex,
 				      bool tx_pause, bool rx_pause)
 {
-	struct ocelot *ocelot = ds->priv;
-	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ocelot *ocelot = dp->ds->priv;
+	int port = dp->index;
+	struct felix *felix;
+
+	felix = ocelot_to_felix(ocelot);
 
 	ocelot_phylink_mac_link_up(ocelot, port, phydev, link_an_mode,
 				   interface, speed, duplex, tx_pause, rx_pause,
@@ -2083,6 +2097,14 @@ static void felix_get_mm_stats(struct dsa_switch *ds, int port,
 	ocelot_port_get_mm_stats(ocelot, port, stats);
 }
 
+const struct phylink_mac_ops felix_phylink_mac_ops = {
+	.mac_select_pcs		= felix_phylink_mac_select_pcs,
+	.mac_config		= felix_phylink_mac_config,
+	.mac_link_down		= felix_phylink_mac_link_down,
+	.mac_link_up		= felix_phylink_mac_link_up,
+};
+EXPORT_SYMBOL_GPL(felix_phylink_mac_ops);
+
 const struct dsa_switch_ops felix_switch_ops = {
 	.get_tag_protocol		= felix_get_tag_protocol,
 	.change_tag_protocol		= felix_change_tag_protocol,
@@ -2104,10 +2126,6 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.get_sset_count			= felix_get_sset_count,
 	.get_ts_info			= felix_get_ts_info,
 	.phylink_get_caps		= felix_phylink_get_caps,
-	.phylink_mac_config		= felix_phylink_mac_config,
-	.phylink_mac_select_pcs		= felix_phylink_mac_select_pcs,
-	.phylink_mac_link_down		= felix_phylink_mac_link_down,
-	.phylink_mac_link_up		= felix_phylink_mac_link_up,
 	.port_enable			= felix_port_enable,
 	.port_fast_age			= felix_port_fast_age,
 	.port_fdb_dump			= felix_fdb_dump,
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index dbf5872fe367..4d3489aaa659 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -82,6 +82,7 @@ struct felix_tag_proto_ops {
 			      struct netlink_ext_ack *extack);
 };
 
+extern const struct phylink_mac_ops felix_phylink_mac_ops;
 extern const struct dsa_switch_ops felix_switch_ops;
 
 /* DSA glue / front-end for struct ocelot */
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 85952d841f28..d4799a908abc 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2717,6 +2717,7 @@ static int felix_pci_probe(struct pci_dev *pdev,
 	ds->num_ports = felix->info->num_ports;
 	ds->num_tx_queues = felix->info->num_tx_queues;
 	ds->ops = &felix_switch_ops;
+	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
 	felix->ds = ds;
 	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index 22187d831c4b..a8927dc7aca4 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -96,6 +96,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 	ds->num_tx_queues = felix->info->num_tx_queues;
 
 	ds->ops = &felix_switch_ops;
+	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
 	felix->ds = ds;
 	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 049930da0521..5ac8897e232b 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -1009,6 +1009,7 @@ static int seville_probe(struct platform_device *pdev)
 	ds->dev = &pdev->dev;
 	ds->num_ports = felix->info->num_ports;
 	ds->ops = &felix_switch_ops;
+	ds->phylink_mac_ops = &felix_phylink_mac_ops;
 	ds->priv = ocelot;
 	felix->ds = ds;
 	felix->tag_proto = DSA_TAG_PROTO_SEVILLE;
-- 
2.30.2


