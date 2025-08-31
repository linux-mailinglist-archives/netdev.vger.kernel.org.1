Return-Path: <netdev+bounces-218570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444AB3D4A3
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E65F189617F
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCAE21E0BA;
	Sun, 31 Aug 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DtJQZq8G"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F872737F9
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661690; cv=none; b=kXRarSEPRInj9dy61GhIhmVBAET1Cp+Kgzg16a5nkGqrubd0uZ1n+cMmU+PHUESZuEJspLDX5fwQi++KnXUSDRwP6KJqWIinfjBakQ5aHi3uBSr8ijB5i3IeRh4Nam+xp+uAnLo46qbd0QYjkNcWvoLFrn/8gMvXxMb+6zzc0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661690; c=relaxed/simple;
	bh=fP+lyoejSWyjWq/CmKLlN/qj6X44AD02ubayr1SyLeE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mn4dGnz22LLQB3owL+HRBl0ajtmRy9iZSZjrUHFo48CR5gCxTArQiiG/ZDgZ5rGoJE22ozVt9nHWEKytomwJx94WVeyTBajR9qYf5hq8DaKEHuX+bqW+Mh7OQcMijqJkA8ceC99rtaPmTdl2vVad9lKQEFbzrUBQgjPdgG3KKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DtJQZq8G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EGswtB4gYWakB1/bUnjEDG0CoH+8hJKX+XyDAFtpNXU=; b=DtJQZq8Gk+IGiZTZz6aqA9YfV0
	dC4Nv3aTc0XNlMC/4goY8jepuCwXKZK5iVnlz57XvJu/wPqvYSBP2SInWBr3sgGN1/MuZSugFBvdM
	s02JNPeRVTdjfxwz87AJJTc24fscrl4nWw/sBTEPeok2G/+f9PHj2eLKM/Unn8bGvEQvAHn+UApaq
	rMtpsrOC5iU86sbXS1nbLkVzb4z/PGSfyjapnMXnEWRYWmvw5Sm4RnhbYwMexXT1jY5liwwgAXJ7g
	WwOl1xI3Xhpg70I09hn+lUsp9yzPG338IzuG5VDzp4ApM6355zxB0iC43w1lBY2b4wNPcaQ/43Q6v
	n9rXFyDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47280 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uslwy-0000000058R-27SR;
	Sun, 31 Aug 2025 18:34:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uslwx-00000001SPB-2kiM;
	Sun, 31 Aug 2025 18:34:43 +0100
In-Reply-To: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 3/3] net: phylink: disable autoneg for interfaces that
 have no inband
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 31 Aug 2025 18:34:43 +0100

Mathew reports that as a result of commit 6561f0e547be ("net: pcs:
pcs-lynx: implement pcs_inband_caps() method"), 10G SFP modules no
longer work with the Lynx PCS.

This problem is not specific to the Lynx PCS, but is caused by commit
df874f9e52c3 ("net: phylink: add pcs_inband_caps() method") which added
validation of the autoneg state to the optical SFP configuration path.

Fix this by handling interface modes that fundamentally have no
inband negotiation more correctly - if we only have a single interface
mode, clear the Autoneg support bit and the advertising mask. If the
module can operate with several different interface modes, autoneg may
be supported for other modes, so leave the support mask alone and just
clear the Autoneg bit in the advertising mask.

This restores 10G optical module functionality with PCS that supply
their inband support, and makes ethtool output look sane.

Reported-by: Mathew McBride <matt@traverse.com.au>
Closes: https://lore.kernel.org/r/025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com
Fixes: df874f9e52c3 ("net: phylink: add pcs_inband_caps() method")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 8283416ccf5d..f1b57e3fdf30 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3634,6 +3634,7 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
 	struct phylink_link_state config;
+	enum inband_type inband_type;
 	phy_interface_t interface;
 	int ret;
 
@@ -3680,6 +3681,23 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	phylink_dbg(pl, "optical SFP: chosen %s interface\n",
 		    phy_modes(interface));
 
+	inband_type = phylink_get_inband_type(interface);
+	if (inband_type == INBAND_NONE) {
+		/* If this is the sole interface, and there is no inband
+		 * support, clear the advertising mask and Autoneg bit in
+		 * the support mask. Otherwise, just clear the Autoneg bit
+		 * in the advertising mask.
+		 */
+		if (phy_interface_weight(pl->sfp_interfaces) == 1) {
+			linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   pl->sfp_support);
+			linkmode_zero(config.advertising);
+		} else {
+			linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   config.advertising);
+		}
+	}
+
 	if (!phylink_validate_pcs_inband_autoneg(pl, interface,
 						 config.advertising)) {
 		phylink_err(pl, "autoneg setting not compatible with PCS");
-- 
2.47.2


