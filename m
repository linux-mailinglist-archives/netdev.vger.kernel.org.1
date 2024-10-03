Return-Path: <netdev+bounces-131748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9598F6B7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A09EB22B2D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC61AB6DC;
	Thu,  3 Oct 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vxk2xksv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFE1AAE22;
	Thu,  3 Oct 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982286; cv=none; b=MdQB9qEzYc62Keg6cz7wpS/DoitwEvQR8XzV7T65YrbMi4fLPB6rZ0C8c3YThhndCyHurxhIHHBYlgGPleO2hnW9OPZ7Hl99goLHwZDD11K+4Nz4DumDfOl9k87eJWQUJdZ7VeWkIij4Ye5Jk5I4vZ4uatVT8cYc5qd+nbFCdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982286; c=relaxed/simple;
	bh=XXOSoKply04OXCCHeyvZV2aeJRtPaohAybFXopWwh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImmEXukVABGMsYRw85cxh1nXYgkow1jbAaUHmECcv3IKRBNsLg1dpbAfhX1gXBfeIF+oOqnmUn8O8/0rTs9/xrp9MPiuLn2Iui2zkpVDtmxzrern8Yr+yGEllCfJWSExevVesPlrFam3XIOBD3hFAbmncy3QMd0Gnb/6zOpoIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Vxk2xksv; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wR6hsMJnof2aawR6hsEXbG; Thu, 03 Oct 2024 21:03:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727982206;
	bh=FHin4MgzcrzJlbIGdi5U/3UwMturuccMifx89qRydKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Vxk2xksvNhkHkdSFdn4FcgnoRB3yq1sf4vqggSYAwpanalJJPpfbRCh54mfjfO9Ty
	 Nr8M5VnvYzeX6FoIm4T/Rc4FH0Yhs/MjF4S9qliztQeH/3BZoEaVdCoRnzH9v2rvjZ
	 6bwaprfDcBLF7prq62Xwl1USG4QEzZ8340ZHTiaEUci01MmVNmEraoOHrxZuil0tZF
	 9DbtfVTlPtmkqLu1KebCndIswQoLttAPLJrOfp0zrHSEGh4cz4a8yqNBmqcbrrsmyC
	 Ugga9/n6uhmPNPbf6PqzuGAfy0uPXwl8uS/+7a+2pWPF0UYUAO8jM3IJQXmuvzUreE
	 1fOHrcFBiK6Tw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Oct 2024 21:03:26 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phy: bcm84881: Fix some error handling paths
Date: Thu,  3 Oct 2024 21:03:21 +0200
Message-ID: <3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If phy_read_mmd() fails, the error code stored in 'bmsr' should be returned
instead of 'val' which is likely to be 0.

Fixes: 75f4d8d10e01 ("net: phy: add Broadcom BCM84881 PHY driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
---
 drivers/net/phy/bcm84881.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index f1d47c264058..97da3aee4942 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -132,7 +132,7 @@ static int bcm84881_aneg_done(struct phy_device *phydev)
 
 	bmsr = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_C22 + MII_BMSR);
 	if (bmsr < 0)
-		return val;
+		return bmsr;
 
 	return !!(val & MDIO_AN_STAT1_COMPLETE) &&
 	       !!(bmsr & BMSR_ANEGCOMPLETE);
@@ -158,7 +158,7 @@ static int bcm84881_read_status(struct phy_device *phydev)
 
 	bmsr = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_C22 + MII_BMSR);
 	if (bmsr < 0)
-		return val;
+		return bmsr;
 
 	phydev->autoneg_complete = !!(val & MDIO_AN_STAT1_COMPLETE) &&
 				   !!(bmsr & BMSR_ANEGCOMPLETE);
-- 
2.46.2


