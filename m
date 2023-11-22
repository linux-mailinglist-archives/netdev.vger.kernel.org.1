Return-Path: <netdev+bounces-50112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C607F4A47
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E38128124E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB55646A;
	Wed, 22 Nov 2023 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jaGL0fCX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CE10E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M0s/UfKnGwvZebudgpO9NZspbWxD1Gk1Ise+RtEkfdA=; b=jaGL0fCXUcGGQYBRRZSFzY18IW
	uKIJib81uEauL7FUNIh4b8NiwDF4Rac1+OHjjVpx02lhl6vFjY9kLCLPBJycYJWBRDFxfxJfRBJ+D
	Dc6dPw6VyorGaDBH75iuuUWecnY9aJFtqIC+OXGr+NwIcwTxRLoRml5vcPDFkq01/8O3groZf+PTq
	m5Uq7pT0XfwwQoG3qw70xLfUebQLoYCH5UkroOUzPL0Hrn9bf+0CgNNCKSdAC6T+gRnAQanA0gnZn
	iwfNSPqD8HMJ48EQkzMynF2F+dQ5Aol77kid2c1ukMMZgO9+4dIphPm1+oR0D1t9nXmr/cKLBKFsN
	+hMXYwWQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44082 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pCO-0000L7-1D;
	Wed, 22 Nov 2023 15:31:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCQ-00DAHD-BJ; Wed, 22 Nov 2023 15:31:34 +0000
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 04/10] net: phy: bcm84881: fill in
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
Message-Id: <E1r5pCQ-00DAHD-BJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:31:34 +0000

Fill in the possible_interfaces member. This PHY driver only supports
a single configuration found on SFPs.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/bcm84881.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 9717a1626f3f..f1d47c264058 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -29,8 +29,19 @@ static int bcm84881_wait_init(struct phy_device *phydev)
 					 100000, 2000000, false);
 }
 
+static void bcm84881_fill_possible_interfaces(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+	__set_bit(PHY_INTERFACE_MODE_10GBASER, possible);
+}
+
 static int bcm84881_config_init(struct phy_device *phydev)
 {
+	bcm84881_fill_possible_interfaces(phydev);
+
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_2500BASEX:
@@ -39,6 +50,7 @@ static int bcm84881_config_init(struct phy_device *phydev)
 	default:
 		return -ENODEV;
 	}
+
 	return 0;
 }
 
-- 
2.30.2


