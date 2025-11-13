Return-Path: <netdev+bounces-238308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB4C57346
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95F3D350692
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0933C520;
	Thu, 13 Nov 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LDOOtc0/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615033B6D2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033391; cv=none; b=ZyWzzTyh2SLG6Ndyb5/KpdhBnJeoN7F0v53aCCkCHTKncln2BgWmnLCdiflhPLTntDdwcypUAQu2XG5wdUjXbZwGcqHfV7VlUv24obU/Qfp9oPzhCv4d/UELpJKSq2l8jlJ0aKC/8INLw1Q57NDRu7BtXLY+EpqdpeT8GJMAXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033391; c=relaxed/simple;
	bh=zpwJJEYMDpA1daBy29HTos5Icq35qbAzfSv0HZIblD0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OoMFs12JvyxStyvE04bLLD3I39RhmPuIlrxWfq1KiZvMndEVWX3/c1N2/1Tm4y7ZI5hSZs9Z1dhXCFknwWr6ZRXQ8Ea/ay/S3beGzTEqnfPWqxrPNIKb+45/Sb8MJMdufvlNyAZJ0orFzBDYXezpPKg804oI3JicxTMtSZka1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LDOOtc0/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nt5Ih5y+5l7DRX8cRLOgxqkvR/TIVgs5wg8XnWFMROA=; b=LDOOtc0/4zWixoPJZXuIs7wtDD
	x4FucKBIZxxSTeGAh81m6qf1heHVbac+6dlb1ac3blSbQ+qJ664ei5X9joZmBnMm3iNQk15GG7gcI
	GyLkC6XIWUGI2Iv3jgO0Xu6mXQaOSieiFsllvYUzN3JebV3tDHl9FNKyS3V6dIGHHC2GA2jbycyAB
	rZevtOr+OxxrTaVKFlz4gI/aFBOTVKp7aQ/ExqmPlrLBCg8BhCyxbXNYpr0GpoMyJS78ort+MIIUU
	EL8vRwqMnxtzo9rCtqj2LxmNB9zevhVrFfLqRomVWT9ztM2VYwUycDUwXhcRA1TtM79OL1FQs10gi
	GMlYqQPQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57458 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJVWL-000000005MO-04mJ;
	Thu, 13 Nov 2025 11:29:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJVWK-0000000E5F8-14Cq;
	Thu, 13 Nov 2025 11:29:44 +0000
In-Reply-To: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
References: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] net: phy: TI PHYs use
 phy_get_features_no_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJVWK-0000000E5F8-14Cq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 11:29:44 +0000

As TI Gigabit PHYs do not support EEE, use the newly introduced
phy_get_features_no_eee() to read the features but mark EEE as
disabled.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/dp83867.c | 1 +
 drivers/net/phy/dp83869.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 36a0c1b7f59c..da055ff861be 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1124,6 +1124,7 @@ static struct phy_driver dp83867_driver[] = {
 		/* PHY_GBIT_FEATURES */
 
 		.probe          = dp83867_probe,
+		.get_features	= phy_get_features_no_eee,
 		.config_init	= dp83867_config_init,
 		.soft_reset	= dp83867_phy_reset,
 
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..4400654b0f72 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -906,6 +906,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	PHY_ID_MATCH_MODEL(_id),				\
 	.name		= (_name),				\
 	.probe          = dp83869_probe,			\
+	.get_features	= phy_get_features_no_eee,		\
 	.config_init	= dp83869_config_init,			\
 	.soft_reset	= dp83869_phy_reset,			\
 	.config_intr	= dp83869_config_intr,			\
-- 
2.47.3


