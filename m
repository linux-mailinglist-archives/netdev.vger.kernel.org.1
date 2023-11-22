Return-Path: <netdev+bounces-50111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB437F4A46
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEEB20D09
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5153813;
	Wed, 22 Nov 2023 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="khhth4ag"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ACA12A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hWKQRnbDJdOABVYD3cdExgGjGvhphZqKrzXnblRs3fg=; b=khhth4agpKhIAml7aOAMYGP4oF
	fONiQTycIn70V9tSK1oENoS6nHBpH2pWLU8m8aCQyvvgym1004tXOnRTEBgZOoMWpssepcZVgZfvR
	qbgZh4a7o7BpQBCO924hwSUJ3rR3eetcbY9c3/fxhV3oR26bxSMNCOdIkZ3Sp4n+iOq5Wp+wzG2qk
	5nd7uEVYgM67yisqqKHKyXj94C68PObx7dPdX1Yz0Bg9V5AHD8/2NbgI6zDkP4TRTMdAaQB3+vxsA
	AF4lIiw+nzuZ9jt+RhqOSvAMQXKFaNdiR9Xg7pqVz3oIK15Pd0JEOGnjkgOdYUZQrps7iUKF1YU98
	9V1QzvXA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44074 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pCJ-0000Kt-0h;
	Wed, 22 Nov 2023 15:31:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCL-00DAH7-6a; Wed, 22 Nov 2023 15:31:29 +0000
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Marek Beh__n" <kabel@kernel.org>
Subject: [PATCH RFC net-next 03/10] net: phy: marvell10g: fill in
 possible_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5pCL-00DAH7-6a@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:31:29 +0000

Fill in the possible_interfaces member according to the selected
mactype mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell10g.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index a880b3375dee..ad43e280930c 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -803,6 +803,22 @@ static const struct mv3310_mactype mv3340_mactypes[] = {
 	},
 };
 
+static void mv3310_fill_possible_interfaces(struct phy_device *phydev)
+{
+	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
+	unsigned long *possible = phydev->possible_interfaces;
+	const struct mv3310_mactype *mactype = priv->mactype;
+
+	if (mactype->interface_10g != PHY_INTERFACE_MODE_NA)
+		__set_bit(priv->mactype->interface_10g, possible);
+
+	if (!mactype->fixed_interface) {
+		__set_bit(PHY_INTERFACE_MODE_5GBASER, possible);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+		__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+	}
+}
+
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
@@ -845,6 +861,8 @@ static int mv3310_config_init(struct phy_device *phydev)
 
 	priv->mactype = &chip->mactypes[mactype];
 
+	mv3310_fill_possible_interfaces(phydev);
+
 	/* Enable EDPD mode - saving 600mW */
 	err = mv3310_set_edpd(phydev, ETHTOOL_PHY_EDPD_DFLT_TX_MSECS);
 	if (err)
-- 
2.30.2


