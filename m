Return-Path: <netdev+bounces-223072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D13B57D4A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7941AA3715
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A130DD06;
	Mon, 15 Sep 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sLwDyji0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558002FA0F1;
	Mon, 15 Sep 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943122; cv=none; b=ObgjbUtty6zEc3KJFYo7M0b4VMekFC/bXv1qdEfmp4sJ7Gz/omLrr7nBwBIgRfAqZua0vYgw7RTOq1SlbtKrVt1IyBFZf7LwPPiDoNOX3blA24/jAH/kmJLIA+5AT3AyMskk4go/BlxT9ZBmYVwPK0rI0fLPXlI+kp6pj7Kw6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943122; c=relaxed/simple;
	bh=e1rHcBVF+YZYuCQrxRhC/xrumTeIZvjbnhpiesTY4as=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Z2jttC2f5DhNZTddH1K5ys0K3lBLKoaWaax2tlq5ZzjF9bcolCcRAcmyC62g+Eng1veqrDoAoiSQVbjPIe5jXqWSnGaQajoRo0gFAs25GT7fXB2oaAtdV9lecqzO2KEZ5z756EShnAuFccBf3GIABh7x5LoqfBhh2JAlQO9tWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sLwDyji0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/3mdIQDysxeOAowQR35ts8iHS6O7ek0TyK8VO0v+2oI=; b=sLwDyji03xKkQw4hNADpTLT6ey
	jhjnZzHndW6S/nFsESWIM8m88ufAPltQWdXn57UCYTwz8dEpMGQUGZBEtVGIrgN1EPpdD9h4GMEWZ
	i90K/zJMA1faftEAqhgzwyzleGgM+rmjB5ACdpw6hv9tRTMTS98monyUifmhjY3ANEv9tfbQFlTgL
	3Kazwspkj6kHn3ALLR+u3hurSFkgZvYtSvPy7E2HJjbzfDzoVi3vrLNvNKZsfzGQJXva7V8LeOsE6
	Qfx3u0/GA9WtL4a1hoor/xy8366o1jVVnLU9LHuvR4QfsIlqpy2zpxaX23p06pXUaOrtn12f7uxqK
	S+1QyTJA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46968 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy9JE-000000000Mc-1JBf;
	Mon, 15 Sep 2025 14:31:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy9JD-00000005jg7-2GBc;
	Mon, 15 Sep 2025 14:31:55 +0100
In-Reply-To: <aMgRwdtmDPNqbx4n@shell.armlinux.org.uk>
References: <aMgRwdtmDPNqbx4n@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	"Marek Beh__n" <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/7] net: sfp: convert sfp quirks to modify struct
 sfp_module_support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy9JD-00000005jg7-2GBc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 14:31:55 +0100

In order to provide extensible module support properties, arrange for
the SFP quirks to modify any member of the sfp_module_support struct,
rather than just the ethtool link modes and interfaces.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c |  5 ++--
 drivers/net/phy/sfp.c     | 49 +++++++++++++++++++--------------------
 drivers/net/phy/sfp.h     |  4 ++--
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 18e5d3de63a8..b7275ecdf19b 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -373,9 +373,8 @@ static void sfp_init_module(struct sfp_bus *bus,
 	sfp_module_parse_port(bus, id);
 	sfp_module_may_have_phy(bus, id);
 
-	if (quirk && quirk->modes)
-		quirk->modes(id, bus->caps.link_modes,
-			     bus->caps.interfaces);
+	if (quirk && quirk->support)
+		quirk->support(id, &bus->caps);
 }
 
 /**
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4cd1d6c51dc2..d49f91ac2e50 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -440,45 +440,44 @@ static void sfp_fixup_rollball_cc(struct sfp *sfp)
 }
 
 static void sfp_quirk_2500basex(const struct sfp_eeprom_id *id,
-				unsigned long *modes,
-				unsigned long *interfaces)
+				struct sfp_module_caps *caps)
 {
-	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, modes);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
+			 caps->link_modes);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
 }
 
 static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
-				      unsigned long *modes,
-				      unsigned long *interfaces)
+				      struct sfp_module_caps *caps)
 {
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, modes);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, caps->link_modes);
 }
 
 static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
-			       unsigned long *modes,
-			       unsigned long *interfaces)
+			       struct sfp_module_caps *caps)
 {
 	/* Copper 2.5G SFP */
-	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, modes);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
-	sfp_quirk_disable_autoneg(id, modes, interfaces);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 caps->link_modes);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
+	sfp_quirk_disable_autoneg(id, caps);
 }
 
 static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
-				      unsigned long *modes,
-				      unsigned long *interfaces)
+				      struct sfp_module_caps *caps)
 {
 	/* Ubiquiti U-Fiber Instant module claims that support all transceiver
 	 * types including 10G Ethernet which is not truth. So clear all claimed
 	 * modes and set only one mode which module supports: 1000baseX_Full.
 	 */
-	linkmode_zero(modes);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, modes);
+	linkmode_zero(caps->link_modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+			 caps->link_modes);
 }
 
-#define SFP_QUIRK(_v, _p, _m, _f) \
-	{ .vendor = _v, .part = _p, .modes = _m, .fixup = _f, }
-#define SFP_QUIRK_M(_v, _p, _m) SFP_QUIRK(_v, _p, _m, NULL)
+#define SFP_QUIRK(_v, _p, _s, _f) \
+	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
+#define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
 #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
 
 static const struct sfp_quirk sfp_quirks[] = {
@@ -514,7 +513,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
 	// 2600MBd in their EERPOM
-	SFP_QUIRK_M("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),
+	SFP_QUIRK_S("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),
 
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
@@ -523,9 +522,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
-	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
+	SFP_QUIRK_S("Lantech", "8330-262D-E", sfp_quirk_2500basex),
 
-	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
+	SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
 	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
 	// Rollball protocol to talk to the PHY.
@@ -538,9 +537,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
-	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
-	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
-	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index 1fd097dccb9f..879dff7afe6a 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -9,8 +9,8 @@ struct sfp;
 struct sfp_quirk {
 	const char *vendor;
 	const char *part;
-	void (*modes)(const struct sfp_eeprom_id *id, unsigned long *modes,
-		      unsigned long *interfaces);
+	void (*support)(const struct sfp_eeprom_id *id,
+			struct sfp_module_caps *caps);
 	void (*fixup)(struct sfp *sfp);
 };
 
-- 
2.47.3


