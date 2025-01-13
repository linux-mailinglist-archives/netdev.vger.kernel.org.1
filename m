Return-Path: <netdev+bounces-157662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE828A0B29E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62D23A3538
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C4234999;
	Mon, 13 Jan 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mRLDcjT2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAB231CA3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760184; cv=none; b=jr2uysnEw3MHCO8i8IcTTR8qrUUZErOH5ymj8XvVVlMX64aLa1tD3fsiChRr1IXFnbYcTWPAcXvN095QsB8EXYQZc5K445pt+0jZbukvmlrpoLVKc2pKWwmO7uLByEg2v83/fcweExkGRl7NqPNJXOH1D5Aqv1ztYzClGBhwJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760184; c=relaxed/simple;
	bh=6or8X6BFImoEtnZaZLdhV3SQPOSS9fu0Fgiuy70IwFQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UAVTIXe3WEKOUBkkwNaPVLbI6SkHmPSegPOx8y6p09SE18ebAhGsoBC6ABcHxpK/rzWUHo9nnhf7IxQS8sF2tecOtqUrw5i7PwqY6qelF2TbxecP3CfyambFkcRrPc+rihlYjyl9iBJJd8ghQt/G63rexesZwDpqL00UE5MPXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mRLDcjT2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rr7rETNDvpeIgqIwf5EqcCB/yWw4eNp8t13fgc5Qq7k=; b=mRLDcjT2LmTwN9Em6twYy2HQLy
	lnW6MjJNG+qxyOyyjgiMJkSmkR11PDvDviGM2so/p2e4bCVz8X5Bg/po3BTYrnc98wRJXjXzyzgwv
	cHTxjDLNd/R86YbfR4WrepjGx1FvBTxYJu1LmMzlLSS5vn8LqhBH1brgYPZrBnv3gAPPfdWH6CIZx
	I41wHKlLEbex+bBIirBem2kESKwxxVuZa5m5KB+tF/0cRPBkMQz5sgnG+Qmv6zcJb2i29Mlg23Wvp
	l9bdRb4S3uOYNXXHSMyepE/DdwGaYY64Hi6fWA2BL3q/ooTmvHnfDkpaP6MmItlZc3a/ITaCQEA8D
	5BMpRcrQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36320 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXGeh-0006Gx-0A;
	Mon, 13 Jan 2025 09:22:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXGeO-000Esx-0r; Mon, 13 Jan 2025 09:22:24 +0000
In-Reply-To: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH net-next v2 1/5] net: phylink: use pcs_neg_mode in
 phylink_mac_pcs_get_state()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXGeO-000Esx-0r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 09:22:24 +0000

As in-band AN no longer just depends on MLO_AN_INBAND + Autoneg bit,
we need to take account of the pcs_neg_mode when deciding how to
initialise the speed, duplex and pause state members before calling
into the .pcs_neg_mode() method. Add this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 31754d5fd659..31f2d8a8ff19 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1492,12 +1492,24 @@ static int phylink_change_inband_advert(struct phylink *pl)
 static void phylink_mac_pcs_get_state(struct phylink *pl,
 				      struct phylink_link_state *state)
 {
+	struct phylink_pcs *pcs;
+	bool autoneg;
+
 	linkmode_copy(state->advertising, pl->link_config.advertising);
 	linkmode_zero(state->lp_advertising);
 	state->interface = pl->link_config.interface;
 	state->rate_matching = pl->link_config.rate_matching;
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-			      state->advertising)) {
+	state->an_complete = 0;
+	state->link = 1;
+
+	pcs = pl->pcs;
+	if (!pcs || pcs->neg_mode)
+		autoneg = pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
+	else
+		autoneg = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					    state->advertising);
+
+	if (autoneg) {
 		state->speed = SPEED_UNKNOWN;
 		state->duplex = DUPLEX_UNKNOWN;
 		state->pause = MLO_PAUSE_NONE;
@@ -1506,11 +1518,9 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
 		state->duplex = pl->link_config.duplex;
 		state->pause = pl->link_config.pause;
 	}
-	state->an_complete = 0;
-	state->link = 1;
 
-	if (pl->pcs)
-		pl->pcs->ops->pcs_get_state(pl->pcs, state);
+	if (pcs)
+		pcs->ops->pcs_get_state(pcs, state);
 	else
 		state->link = 0;
 }
-- 
2.30.2


