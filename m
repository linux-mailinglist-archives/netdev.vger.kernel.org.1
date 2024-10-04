Return-Path: <netdev+bounces-132145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C4499090A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A9CB29F1B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21D1CACE7;
	Fri,  4 Oct 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="errC3PZ2"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF971C82FC;
	Fri,  4 Oct 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058580; cv=none; b=l09/Oqqu7XCZpYldGKoED5wHMkLfTh05iB+kccQipFR4htmCunnSrX/OQUoR8UnQnjYGjNlVx+sF+xo+CeF1DM7H4RTp6Hy5AgnmlTz3qjI24jy2UkY9ppor3TfQM10uKwnsyk0k7UYMtpW3C9X1M0lfLuUx5aRr7hCIyRQ1QmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058580; c=relaxed/simple;
	bh=P5TebehUaWq4vjDvoTeNxwj6jDSsnkYNxZtOrSq1kao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El8JB6wfN07T+lGJe68Y0bGu/hGkc6pKG6g64XlapQ1NMcIrDDldDE4wLfUi2YEwQIb42gsdWuYkal5HNBNDXM4LliUHmPRwXgtbDSmRgd8ejxFgOl9Ygz3Mp4dW7/qNcaS/49zTILeYXolIAMG1bV2AD7S1Hc+3CiOFkBLiHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=errC3PZ2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B969C2000C;
	Fri,  4 Oct 2024 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dp0DBhFARDfArCSdgYYrzM2jCoA7FW/8kA7NOUCl2/c=;
	b=errC3PZ2jBRAdl7toejcmwvgAChfwyA5o3tRl8Q6lgQT5wNZf9YvCiIg3IWTthRtutbJxv
	gYTwTb0oG60PIMYz00uHYDPjkXEK08mRuLtjugUhc9YWBcr/kHO8BXGY9q4LT8KypSUpFC
	nu5BYhd3TSqqPN02LSPZfWPP8qqLsyg42oSf9fPzTAZqx3XoMyvMcqkHdq8RE1bAf1kRTv
	qWFB8UJS9m4f/QVKtD3C48c/kah5AcJ3ZJuhfZ7DlF/TFMF4CMDIrngvyUovzJVKUIbcsi
	OJzPB2k0jk53GRaP7S/JK7PUt9FCiwjUoe9+tJbVYXBMWsAUypVOvV/YsMokwA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 5/9] net: phy: marvell10g: 88x3310 and 88x3340 don't support isolate mode
Date: Fri,  4 Oct 2024 18:15:55 +0200
Message-ID: <20241004161601.2932901-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The 88x3310 and 88x3340 PHYs don't support the isolation mode,
regardless of the MII mode being used
(SGMII/1000BaseX/2500BaseX/5GBaseR/10GBaseR). Report this through the
.can_isolate() callback.

This was confirmed on the 88x3310 on a MacchiatoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Use callback instead of flag

 drivers/net/phy/marvell10g.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 6642eb642d4b..c1a471f55cd4 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -1422,6 +1422,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		.can_isolate	= genphy_no_isolate,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88X3310,
@@ -1441,6 +1442,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		.can_isolate	= genphy_no_isolate,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
-- 
2.46.1


