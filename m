Return-Path: <netdev+bounces-158120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8AA10821
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3201887780
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EBE382;
	Tue, 14 Jan 2025 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bIiLZq1J"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93121232437
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862590; cv=none; b=NK4X2sqBmgSZOxQioCgzoEm5XlhILsjEoiYKs9UdYPkPwn3tCv1YhP2Xypr9V+mPEu8ujtuUVJ4yNk9tv/2IibLdf/+0g8QZmPECELpw/+zz0M0TQEZ2q6EU73UV/Fa4NsF2SnIgXiQiQM2XTwL6fzSwpWpb5tNTnNmGGLTawHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862590; c=relaxed/simple;
	bh=wSCAcnNN7JhMTWbGl2eNEsoZrTXnlSTwviuQPrP7Gtc=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=UdR5t9gijeTPPigaT4LCmkf6Ef0U2ukKWQBVfZJzFv08LVYhRf/TiT7ZzMleGBGJ390asi1/IJb9d+qZM344/zC87RxtyzNpnLqCBQMgMwH+CE+zT03SfbRbPOmuhLSx89V7cx9Vux5zjRK33tI1lxlxbDJHKl8LifDr5QfOFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bIiLZq1J; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ku/gr3wvhZD6eUiLcFNuyFIHBNLBvvyFFbGiFma1q04=; b=bIiLZq1JmYqO3X85Gmhjp478rq
	VncL2wNrpAv2/qw5SviTW+kLpYc2hCvh6ED2FJmAFhv6PsnI7lzDJpRlK8JcFpyfWNaNbT2b2CzAO
	0W29FSr0psvgqBmnA3wRLtTNriL3T5P12C24/TIPAnw9Hhr7n7JMA2ijS9/NyuAad2a+Cb3HM5BdY
	4epok2HO0izahd5ebR5dGfHHQsE8GE7VE3C1yNnPprptU+8zIwrYGPguR3ZWUtBT/bfgx3v4U7HaL
	E7w91ta4MAwVRoR+9QKcBN9bU/MBNEUVBe0DICnWC1q9Y2cJJhXnHSDUxs4WIGuAOBQCudNI9nTkq
	7yNJl8gQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50604 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXhIc-00087t-2o;
	Tue, 14 Jan 2025 13:49:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXhIJ-000me6-SA; Tue, 14 Jan 2025 13:49:23 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next] net: phylink: always do a major config when
 attaching a SFP PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXhIJ-000me6-SA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 13:49:23 +0000

Background: https://lore.kernel.org/r/20250107123615.161095-1-ericwouds@gmail.com

Since adding negotiation of in-band capabilities, it is no longer
sufficient to just look at the MLO_AN_xxx mode and PHY interface to
decide whether to do a major configuration, since the result now
depends on the capabilities of the attaching PHY.

Always trigger a major configuration in this case.

Reported-by: Eric Woudstra <ericwouds@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This follows on from https://lore.kernel.org/r/Z4TbR93B-X8A8iHe@shell.armlinux.org.uk "net: phylink: fix PCS without autoneg"

 drivers/net/phy/phylink.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ff0efb52189f..7d64182cf802 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3412,12 +3412,11 @@ static phy_interface_t phylink_choose_sfp_interface(struct phylink *pl,
 	return interface;
 }
 
-static void phylink_sfp_set_config(struct phylink *pl,
-				   unsigned long *supported,
-				   struct phylink_link_state *state)
+static void phylink_sfp_set_config(struct phylink *pl, unsigned long *supported,
+				   struct phylink_link_state *state,
+				   bool changed)
 {
 	u8 mode = MLO_AN_INBAND;
-	bool changed = false;
 
 	phylink_dbg(pl, "requesting link mode %s/%s with support %*pb\n",
 		    phylink_an_mode_str(mode), phy_modes(state->interface),
@@ -3494,7 +3493,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, support, &config);
+	phylink_sfp_set_config(pl, support, &config, true);
 
 	return 0;
 }
@@ -3569,7 +3568,7 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, pl->sfp_support, &config);
+	phylink_sfp_set_config(pl, pl->sfp_support, &config, false);
 
 	return 0;
 }
-- 
2.30.2


