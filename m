Return-Path: <netdev+bounces-131572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1C98EE86
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787FDB2181D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B0154458;
	Thu,  3 Oct 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xMu2y/C5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675726AD4
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956351; cv=none; b=NmKGdb2QgALQAMlnEiEfvr2g3Ry1cof/eFzcLR7CZY8QgOcCsNotzrY5ISr6sebVg5wOemU9YCO4N1fr4JiXvBUyr8T0otI5ubokUczv3Dx9ccCJPhyDgNY53ShhzMNErEjKIP89dcj5aLqW3f0nRNe1d+ZDqaUP9QYNEYY5+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956351; c=relaxed/simple;
	bh=aVMwpwzol0Bd/timJkeQDgEriCTzyeDfGWi3/UcXhhE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=baWooEqrfgqzr7huyNb3nvIuuL+fnk8+UuuTsxXbCd4yznlFaIpL4+HYB9EgBBR3dy+1xltPJJMBFadXw2IIzyAIj4XzJPb9qP0SYgQGyllczH0pjzWkOP376W94LeLKe1NXWHwmqPF+SKJszqrNa0utSNJncYgQeD4YY5tAGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xMu2y/C5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lMMFRYeHvljkDLOpbdf6JtFgZ6rzmOa9NzWKqDOm4JE=; b=xMu2y/C5bfRxPbD/3UbZamShe5
	Vm08kyT5Ow1CVIHr08qddJkwW4HlLv3AnbUUYb1Hmc4gI5z2Nt2CrKIOXsDJeA/S/zvHBVV/7H0n6
	W9JJgW0tJZtu/lKeHClP2CL3dGBGq0yvQwZBsEw8uqEZhgmfsUyd2Gc7n7Y/NReXqg5ff8N5FsdWy
	WDBzShxN+LIZyNXhC4pTq9tarLJiMf1+Mxs+ItjYXohBo9UMZy/epon1oLWnnY5bwBMYbKVgKUsay
	MH43aHB3hLjffS0PBwSNpm1nupxAJeACxRYa8krZYn5Wege5Dvqw46Dz7aRWf8Sz5CnltmC/r0mdk
	5snFg7uA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40302 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swKNW-0000Pk-1r;
	Thu, 03 Oct 2024 12:52:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swKNV-0060oN-1b; Thu, 03 Oct 2024 12:52:17 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: remove obsolete phylink dsa_switch
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
Message-Id: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 03 Oct 2024 12:52:17 +0100

No driver now uses the DSA switch phylink members, so we can now remove
the method pointers, but we need to leave empty shim functions to allow
those drivers that do not provide phylink MAC operations structure to
continue functioning.

Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since v1 (a while ago):
 - don't remove the shim functions and ops structure which will break
   some DSA drivers that do not provide a phylink_mac_ops struct as
   pointed out by Vladimir (thanks.)

 include/net/dsa.h | 15 ---------------
 net/dsa/dsa.c     |  8 --------
 net/dsa/port.c    | 34 +---------------------------------
 3 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d7a6c2930277..72ae65e7246a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -885,21 +885,6 @@ struct dsa_switch_ops {
 	 */
 	void	(*phylink_get_caps)(struct dsa_switch *ds, int port,
 				    struct phylink_config *config);
-	struct phylink_pcs *(*phylink_mac_select_pcs)(struct dsa_switch *ds,
-						      int port,
-						      phy_interface_t iface);
-	void	(*phylink_mac_config)(struct dsa_switch *ds, int port,
-				      unsigned int mode,
-				      const struct phylink_link_state *state);
-	void	(*phylink_mac_link_down)(struct dsa_switch *ds, int port,
-					 unsigned int mode,
-					 phy_interface_t interface);
-	void	(*phylink_mac_link_up)(struct dsa_switch *ds, int port,
-				       unsigned int mode,
-				       phy_interface_t interface,
-				       struct phy_device *phydev,
-				       int speed, int duplex,
-				       bool tx_pause, bool rx_pause);
 	void	(*phylink_fixed_state)(struct dsa_switch *ds, int port,
 				       struct phylink_link_state *state);
 	/*
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..09d2f5d4b3dd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1505,14 +1505,6 @@ static int dsa_switch_probe(struct dsa_switch *ds)
 	if (!ds->num_ports)
 		return -EINVAL;
 
-	if (ds->phylink_mac_ops) {
-		if (ds->ops->phylink_mac_select_pcs ||
-		    ds->ops->phylink_mac_config ||
-		    ds->ops->phylink_mac_link_down ||
-		    ds->ops->phylink_mac_link_up)
-			return -EINVAL;
-	}
-
 	if (np) {
 		err = dsa_switch_parse_of(ds, np);
 		if (err)
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 25258b33e59e..f1e96706a701 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1579,40 +1579,19 @@ static struct phylink_pcs *
 dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
 				phy_interface_t interface)
 {
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
-	struct dsa_switch *ds = dp->ds;
-
-	if (ds->ops->phylink_mac_select_pcs)
-		pcs = ds->ops->phylink_mac_select_pcs(ds, dp->index, interface);
-
-	return pcs;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
 {
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_config)
-		return;
-
-	ds->ops->phylink_mac_config(ds, dp->index, mode, state);
 }
 
 static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 					   unsigned int mode,
 					   phy_interface_t interface)
 {
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_link_down)
-		return;
-
-	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
 }
 
 static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
@@ -1622,14 +1601,6 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 					 int speed, int duplex,
 					 bool tx_pause, bool rx_pause)
 {
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_link_up)
-		return;
-
-	ds->ops->phylink_mac_link_up(ds, dp->index, mode, interface, phydev,
-				     speed, duplex, tx_pause, rx_pause);
 }
 
 static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
@@ -1871,9 +1842,6 @@ static void dsa_shared_port_link_down(struct dsa_port *dp)
 	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down)
 		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
 						   PHY_INTERFACE_MODE_NA);
-	else if (ds->ops->phylink_mac_link_down)
-		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
-					       PHY_INTERFACE_MODE_NA);
 }
 
 int dsa_shared_port_link_register_of(struct dsa_port *dp)
-- 
2.30.2


