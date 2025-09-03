Return-Path: <netdev+bounces-219566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898BB41F62
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3136E7B5658
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A62FE56B;
	Wed,  3 Sep 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tx+1w+mh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207E2FF654
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903199; cv=none; b=ktuGBbcOKNnn8P3gBofsZ4G5jBDeK+xg98MV3yNHy/TGolvcwi+oKmNDKO03CdmlDZ5C9l0kyJYzZLaIiu2/bzslxiyOgCDLrDx4Q9N0xXB7ZMRFzzXG0f9C58BrL++9UKV1a0udJpuRXrL2yCpC0fq7pFUzY5Ju/QX//oNGNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903199; c=relaxed/simple;
	bh=VbcQ1kjR9rZgh2hXEZmkInsvcqJCW/fhAAocLj/85K0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GBGE3YJ9V+UsB25lKUXD9NMBZ7gbLxyRQ1Onn8T4OS29TNkMHAyEYTff0Z2fAiAiMASjfNOi0MBluPyEwIrXHY3WkFG8xcl+hnGq74SN/QFEAucLIr1PqsKfzcZ3sMKJr1jdf2fOfcE+rh0hNLJy/i+Q7lq4igEa9jC11Ng9y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tx+1w+mh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lx+cIhNFbytMcZVMSFDTNPjoD4jGqQcNILJcA51HUIY=; b=Tx+1w+mhyZ2tk6KiNHfSWcQ07w
	mXkqcuUPlUFmE/QjXnraxnee9GKKxI6y0UaW8X8xImXaBy81uJRguU+MskQ22w6qaXwcKTjkXoaXc
	pmIodrGIIPctHfaW2zYzUZzlQYeFfLuAq+cWR20H8/9iHucbl98qi/HyBdu7nbg+mlabZQzKWH++4
	4H3laV9nygevZyYuE4mmSS69T/K1DjI9PJ6CNgqYvRaMREwq1s8Z3m8YfC5t3LIJahPu81aBSKqub
	yD0EYqymzKbhiNs3EAGWOo7DkkD4PKFCis4/zsxY/E/lGkhrIaXzpms065F/dYA1AzrJchAJLtFTk
	jw4+7WpA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55354 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmmF-000000000WQ-0h0c;
	Wed, 03 Sep 2025 13:39:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmmD-00000001s0f-2yUs;
	Wed, 03 Sep 2025 13:39:49 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 07/11] net: stmmac: mdio: improve mdio register field
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmmD-00000001s0f-2yUs@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:39:49 +0100

Include the register name in the definitions, and use a name which
more closely resembles that used in documentation, while still being
descriptive.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 2d6a5d40e2c1..4d0de3c269a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -23,9 +23,9 @@
 #include "dwxgmac2.h"
 #include "stmmac.h"
 
-#define MII_BUSY 0x00000001
-#define MII_WRITE 0x00000002
-#define MII_DATA_MASK GENMASK(15, 0)
+#define MII_ADDR_GBUSY			BIT(0)
+#define MII_ADDR_GWRITE			BIT(1)
+#define MII_DATA_GD_MASK		GENMASK(15, 0)
 
 /* GMAC4 defines */
 #define MII_GMAC4_GOC_SHIFT		2
@@ -235,7 +235,7 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 	return ((pa << mii_regs->addr_shift) & mii_regs->addr_mask) |
 	       ((gr << mii_regs->reg_shift) & mii_regs->reg_mask) |
 	       priv->gmii_address_bus_config |
-	       MII_BUSY;
+	       MII_ADDR_GBUSY;
 }
 
 static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
@@ -250,7 +250,7 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 	if (ret < 0)
 		return ret;
 
-	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
+	ret = stmmac_mdio_wait(mii_address, MII_ADDR_GBUSY);
 	if (ret)
 		goto out;
 
@@ -259,12 +259,12 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 	writel(data, mii_data);
 	writel(addr, mii_address);
 
-	ret = stmmac_mdio_wait(mii_address, MII_BUSY);
+	ret = stmmac_mdio_wait(mii_address, MII_ADDR_GBUSY);
 	if (ret)
 		goto out;
 
 	/* Read the data from the MII data register if in read mode */
-	ret = read ? readl(mii_data) & MII_DATA_MASK : 0;
+	ret = read ? readl(mii_data) & MII_DATA_GD_MASK : 0;
 
 out:
 	pm_runtime_put(priv->device);
@@ -345,7 +345,7 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 	if (priv->plat->has_gmac4)
 		cmd = MII_GMAC4_WRITE;
 	else
-		cmd = MII_WRITE;
+		cmd = MII_ADDR_GWRITE;
 
 	return stmmac_mdio_write(priv, phyaddr, phyreg, cmd, phydata);
 }
-- 
2.47.2


