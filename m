Return-Path: <netdev+bounces-221301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF536B5019E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C47BDFDE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479B37058D;
	Tue,  9 Sep 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VO9nbsU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69E36CC96;
	Tue,  9 Sep 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431703; cv=none; b=HOPbSnIoHYj64Bci9lLwHhYEkResITAHw8ZFwbmlyKfDci3OpCSOQvR5RMsJeupcayZy0tKdaW8rYXFGZwk5dUC/uueas2NUO8jJYx0Jnr/e16zXajEWr+rNQCpwEEpt9NUjqKDmj9JyTgC3xqZ9bmVAbTiJ/PoNCB2QODxlfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431703; c=relaxed/simple;
	bh=0bMr2A2pzskdMOhBYUrXhySn2vY1g744UUV/+yzluss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohOv32smL60wRZsQB2qzrGRJUXGxDSqYKpL+w2Zl242LTmDxn0fePMSfk9UYkbEci5FkuDxQYN4oGEC4NU97ymSAWR+RSV2B6SFLqRUR6Do3eBlzRv3VPpKEvkt7OPCg+sKK/5Ymq0schV7FLCZ1bafBqZL2EtZPqtyY7SdVy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VO9nbsU7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9BF2B1A087F;
	Tue,  9 Sep 2025 15:28:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7083B60630;
	Tue,  9 Sep 2025 15:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C9AF102F29F0;
	Tue,  9 Sep 2025 17:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757431698; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bzmYOPr3hvVZTl1uon2prlEWvF1qYLbpQgHjwaF8RLM=;
	b=VO9nbsU7k7iEhxszjmqeDdS1pPJDKPGty0lxqL/hzenvhu9adKQ3WtQkSdHjKjkcsOETd7
	A6jzWalJOoTQv6kc2WyEbBzWp5znEhEKcQULpeUCd3u18LjWsu1McXMfGi1r82hV7DNsE0
	bYrzwgtEhpJ1fMVQM/5upGTGLo2DEqyHVPtD6kCywwsq7qeMc3PCFuxk8SRmFhIcByS7ZF
	aho66eMdsqgPNGnn5tC2M1+JAd4f1Ic3evYUIp9QkaPTXnLxXhGFJzpEcPxxrfhO9YExr4
	kegv5DXaNq6ufTrHnCEv4cfle9zWgkKo7ThS5v423rZADgKyol8B+VFobtlQKg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v12 17/18] net: phy: dp83822: Add SFP support through the phy_port interface
Date: Tue,  9 Sep 2025 17:26:13 +0200
Message-ID: <20250909152617.119554-18-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909152617.119554-1-maxime.chevallier@bootlin.com>
References: <20250909152617.119554-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The DP83822 can support 100BaseFX. This mode was only accessible through
custom DT properties, but there also exist SFP modules that support
these modes. As this only requires setting the relevant supported
interface in the driver, expose the port capability with the new
phy_port API, allowing SFP support.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/dp83822.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c6e5b7244658..94036e5af242 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -980,6 +980,13 @@ static int dp83822_attach_mdi_port(struct phy_device *phydev,
 		}
 	}
 
+	/* If attached from SFP, is_mii is set, but not the mediums. */
+	if (port->is_mii)
+		dp83822->fx_enabled = true;
+
+	if (dp83822->fx_enabled)
+		__set_bit(PHY_INTERFACE_MODE_100BASEX, port->interfaces);
+
 	return 0;
 }
 
-- 
2.49.0


