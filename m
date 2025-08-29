Return-Path: <netdev+bounces-218177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E3B3B69A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9204018918FA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05DC2E36E6;
	Fri, 29 Aug 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PcS1jOtT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4562BEC27
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458172; cv=none; b=pWcv0bjwZ1g5Gqt32nmtsc4VZwv36zNTdRgA9FaIJiDdcenqzqs1KwOQ34mOhsEq+wGb9+IYHotcUEwKI3WZGkYa381+cXYhUQzDJpYLlqzpoSmRTUlDGGBXpY4LwYnAoJVUxw8xl0wX4AeerIgifQpNDQwM1yE9y6j74QXXRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458172; c=relaxed/simple;
	bh=n+GZCSnjDamW12Dj8PMBgCC8Hh/BMTXcp5NnJMShiog=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=WZ+7DluCNVulHklzlmLO+ZgnakTFOkKnM52pQvGYgC1UKqNr+PlXpEAatTMZTKqaciiBqke7Mn+NEvp/ZTG+xP5zfh/9coEG5lGzgw/y+6SRXILhSLEG2ZSDQhqF6MITNrQK28XhO9l2WMDRdCGf7Sxl/hyAqrg87ixjwJyTCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PcS1jOtT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vy6YAO+9ijcxerFDApcAmJBpLGwTnAOTEL8tEqUKCDY=; b=PcS1jOtT0ZJ4xMvfp+zOSTYqCp
	vXHpAITooj7Uecu9PRmfUiscGy4obgyJDi6Ckjaw9QDqVE3qDTvxx19yyeKKKqVIKkrG80iPNiPxs
	rJs4uqt4gvLlEOf8CST/78rry+iP0JMSqFbwveXH+/eWGNKycl5kLZBlssJeni0rxWCCBI/nOfmZ8
	ivOR0uHoFMGc1MciGs9FhRlGqxFlEj130/WNyJGXDfL59aw/mCDMWMM3bNijRH/IFiodxdLHoxEiI
	a2QTALzZ81kKTtV1HW0hsieE5gfPAJHGzxDabLcQE80qi6nWIPSfP7mzhbO0OToNopp5ZAAupiIz2
	zoaXcwiQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38032 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1urv0A-000000002Yh-2DaM;
	Fri, 29 Aug 2025 10:02:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1urv09-00000000gJ1-3SxO;
	Fri, 29 Aug 2025 10:02:29 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: mdio: update runtime PM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1urv09-00000000gJ1-3SxO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 29 Aug 2025 10:02:29 +0100

Commit 3c7826d0b106 ("net: stmmac: Separate C22 and C45 transactions
for xgmac") missed a change that happened in commit e2d0acd40c87
("net: stmmac: using pm_runtime_resume_and_get instead of
pm_runtime_get_sync").

Update the two clause 45 functions that didn't get switched to
pm_runtime_resume_and_get().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
I don't have any way to test this on real hardware as the Jetson Xavier
NX doesn't have a C45 PHY.

 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index da4542be756a..0a302b711bc2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -303,11 +303,9 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 	u32 value = MII_BUSY;
 	int data = 0;
 
-	data = pm_runtime_get_sync(priv->device);
-	if (data < 0) {
-		pm_runtime_put_noidle(priv->device);
+	data = pm_runtime_resume_and_get(priv->device);
+	if (data < 0)
 		return data;
-	}
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
@@ -399,11 +397,9 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 	int ret, data = phydata;
 	u32 value = MII_BUSY;
 
-	ret = pm_runtime_get_sync(priv->device);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->device);
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
 		return ret;
-	}
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
-- 
2.47.2


