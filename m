Return-Path: <netdev+bounces-218565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32754B3D466
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EF2189AFAD
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F74258EE9;
	Sun, 31 Aug 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BptajjWv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A522578A
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658299; cv=none; b=lfKeYd1yDX0ceuZg8chEiiaGgDMqaDIIOLKOLSSqTpfYtivQTRk7h+kBsZDDaoEDTsISXyV2cgg9IeCC+iy+tfmndToceuVFTupoocw3UMejs271E2P+LJkInwi6CiLJ7G05sERqdbI11nU1ASvWeaJ8v6JTcM+PUCTLtfA9Ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658299; c=relaxed/simple;
	bh=n+dgtDp1h8vTV9QpLl1sgweHFLJa85xRWI2TqwCT/Go=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=GTy77P1CqDn9MWmwi4RZMiJtLcZshKU4Mze+Wivxt2UmIpNAYfItc0njaDYO5kAk1HOTLmN1eSinIFsOS7OZPn7aBC9zNsnstu8psAqf8WpkHU+NYrBOyu8RVqxRkZJbUkfyq4bI9o/lr6nBfbxoghzAZx26xjtx1e2HQvlxZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BptajjWv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TSoheSwU2YENeomNGV2R8v0yUFqKXrHz6uvQKob28zg=; b=BptajjWvgt4Q1KAxsCdkkDLWQE
	d1q2LxRHieTK+awc//F5pJC6l5E2VyaxP0siPMTXpFv49ZDFAeE1AZ84f787ZsHGgxyi+x4camKkJ
	u8+eAGGnonefow/4pwu+XLsQ2Y2BAO9T3bpSMemse0VsfSaLQxNH/+p74HC5VgLiBgUiHtO+zX95B
	S+nPt9P+ARRUElknLydqVY6EP2wwP5NeICRPIbdDBOADEG36oW4iuqRW0FGrOTVFYtSvX5jLxQTy6
	PBw9qxcdkuztAnbvuCnePzLt0yXgG2I1GHg2styLxMZjLrcLDRTYY1YGEBtUTMLumPA0wofBIyaf1
	iy3hXByg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52136 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1usl4G-0000000055O-0zPR;
	Sun, 31 Aug 2025 17:38:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1usl4F-00000001M0g-1rHO;
	Sun, 31 Aug 2025 17:38:11 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net] net: phy: fix phy_uses_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 31 Aug 2025 17:38:11 +0100

phy_uses_state_machine() is called from the resume path (see
mdio_bus_phy_resume()) which will be called for all devices whether
they are connected to a network device or not.

phydev->phy_link_change is initialised by phy_attach_direct(), and
overridden by phylink. This means that a never-connected PHY will
have phydev->phy_link_change set to NULL, which causes
phy_uses_state_machine() to return true. This is incorrect.

Fix the case where phydev->phy_link_change is NULL.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
The provided Link: rather than Closes: is because there were two issues
identified in that thread, and this patch only addresses one of them.
Therefore, it is not correct to mark that issue closed.

Xu Yang reported this fixed the problem for him, and it is an oversight
in the phy_uses_state_machine() test.

 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7556aa3dd7ee..e6a673faabe6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -288,7 +288,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
 		return phydev->attached_dev && phydev->adjust_link;
 
 	/* phydev->phy_link_change is implicitly phylink_phy_change() */
-	return true;
+	return !!phydev->phy_link_change;
 }
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
-- 
2.47.2


