Return-Path: <netdev+bounces-146791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11B9D5DF8
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF98B273C3
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D961DE3DF;
	Fri, 22 Nov 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p5b+mwyk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E917E00E
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274519; cv=none; b=G4d9ZgJxAkve+s2h5Z23QijulPOhBeNkzajEaf21Qr4bRnHedHuWBaMlFmOAYMrVH2KIYNaKHM12uPvAgGEG0bU2qzfInzP4iOnCKNpNklhsIvi82gOJJTbpqFK8UDh2mc5F1EzE4MLGox6HanX4xaZ3jVZLuBVSiJlmSszCDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274519; c=relaxed/simple;
	bh=AXB6qb6RDIsTzCWl0EUW0nkGztJDvOo9mGeQKJz63QE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=fMQh+sHQ0h0dP0twmAQsmUibA9qGq8biHvWzF3nchU1v9G7HmH0ukLca6LkuwFH/A/lHp9OhNY11lKTYlmS5F/3BgRxdRoiOdHDHNf6FaB+FpnxqkkL5L1Ka5zK46z7h4BcWDnMOlUmoUh3F3/68ZO6p9StO8ihtauCVlCftyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p5b+mwyk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uy1ysEXSuRIKOUxF2LGxCn//LIyrJqNRdWvSAf8MRg0=; b=p5b+mwyk5QeVvoUTLtnAjBasHe
	EnR5Is2m3ofsJy52w8SyPXr+K/03ygkLm903MWvTZFTVgT6igkjVgU/Sen3n3HrR2hF14ymeYUy0K
	hUxQBi0yHGlIlvREufjzFdnGXF8BcLU1CUzGjL8GoQ5ZksGqj8fQMhB0MhrjiTKYOQjQpMGMKudMs
	Vog2/NCKDT1YNQyqsD4MKWWyOB8/jQ01ATu1Yg3sBr1tz15U5PdDEwDnL378wYR4ZIPcPw5rwTzJu
	C7nNRC5P3tOBUo759hvxI7/SuWT75PdReY31PkkoPWSrOfAfg2Qapz2Zw61p4+RqFTwbrNflSTsuP
	aP/04Mnw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37668 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tERjM-0000Pb-0K;
	Fri, 22 Nov 2024 11:21:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tERjL-004Wax-En; Fri, 22 Nov 2024 11:21:43 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phy: fix phy_ethtool_set_eee() incorrectly enabling
 LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tERjL-004Wax-En@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 22 Nov 2024 11:21:43 +0000

When phy_ethtool_set_eee_noneg() detects a change in the LPI
parameters, it attempts to update phylib state and trigger the link
to cycle so the MAC sees the updated parameters.

However, in doing so, it sets phydev->enable_tx_lpi depending on
whether the EEE configuration allows the MAC to generate LPI without
taking into account the result of negotiation.

This can be demonstrated with a 1000base-T FD interface by:

 # ethtool --set-eee eno0 advertise 8	# cause EEE to be not negotiated
 # ethtool --set-eee eno0 tx-lpi off
 # ethtool --set-eee eno0 tx-lpi on

This results in being true, despite EEE not having been negotiated and:
 # ethtool --show-eee eno0
	EEE status: enabled - inactive
	Tx LPI: 250 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

Fix this by keeping track of whether EEE was negotiated via a new
eee_active member in struct phy_device, and include this state in
the decision whether phydev->enable_tx_lpi should be set.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c |  2 +-
 drivers/net/phy/phy.c     | 32 ++++++++++++++++++--------------
 include/linux/phy.h       |  1 +
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 96d0b3a5a9d3..944ae98ad110 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 		return ret;
 
 	data->eee_enabled = is_enabled;
-	data->eee_active = ret;
+	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
 
 	return 0;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..d03fe59cf1f3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
 		phydev->state = PHY_RUNNING;
 		err = genphy_c45_eee_is_active(phydev,
 					       NULL, NULL, NULL);
-		if (err <= 0)
-			phydev->enable_tx_lpi = false;
-		else
-			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
+		phydev->eee_active = err <= 0;
+		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
+					phydev->eee_active;
 
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
+		phydev->eee_active = false;
 		phydev->enable_tx_lpi = false;
 		phy_link_down(phydev);
 	}
@@ -1685,16 +1685,20 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
 				      struct ethtool_keee *data)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
-	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
-		eee_to_eeecfg(&phydev->eee_cfg, data);
-		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
-		if (phydev->link) {
-			phydev->link = false;
-			phy_link_down(phydev);
-			phydev->link = true;
-			phy_link_up(phydev);
-		}
+	bool enable_tx_lpi = data->tx_lpi_enabled &&
+			     phydev->eee_active;
+
+	eee_to_eeecfg(&phydev->eee_cfg, data);
+
+	if ((phydev->enable_tx_lpi != enable_tx_lpi ||
+	     phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) &&
+	    phydev->link) {
+		phydev->enable_tx_lpi = false;
+		phydev->link = false;
+		phy_link_down(phydev);
+		phydev->enable_tx_lpi = enable_tx_lpi;
+		phydev->link = true;
+		phy_link_up(phydev);
 	}
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 77c6d6451638..6a17cc05f876 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -723,6 +723,7 @@ struct phy_device {
 	/* Energy efficient ethernet modes which should be prohibited */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
 	bool enable_tx_lpi;
+	bool eee_active;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
-- 
2.30.2


