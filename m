Return-Path: <netdev+bounces-232539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95556C0651A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CF53BDC8E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701C9319616;
	Fri, 24 Oct 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I4l+ZSk6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AE3093D3
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310170; cv=none; b=THAmj3bzLAiVV4ZYt0pBtyMMW5ibrT99vEQU9R2juajtkdFT4O8S2FTNUnqnAFi1zvy1N0vcEbLBrGCB5icAXQRqafPll1LWrhxtwEZTFwd65LPWbsehPRVT5mMVexb/X9zBJ62s5tWl5R5xHqXC0XyeZ1Vsx+Eiu37r+5Hu0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310170; c=relaxed/simple;
	bh=i1vTYGJJ326uyh36/OM3Rj/vrUiOgSYRn1aeS0IzhAU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eNG/vJvBvkcX8pICK6WECerBFC7E30H7NopcrjbHlGD+GiyeLU0nlmlCsvjB501/Bq+t/qhWz6HimYJ/CfMlYvyl03FrdNC69NVEbhwH0I/H7J0OPuG7qi8r68kVoJq4JyI+MObww5u8qfag2IcOGqbkCod9iqrhuM5U+45EbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I4l+ZSk6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XBETHKNkRC/ncD/Rqzzbsi7AlwBDem+TkHmHlyBoMbg=; b=I4l+ZSk6aQbXkxZCrJ+etgUNAN
	Im5UoLqe/H9F9jhri1UH8EjeS8QZmlq6etfeX+H1PG78pjZ1/ei4MjdmN7VocwECwm5j9ZbbhywNe
	rQoMGyAgEOsH3dXS2QjxBaqIPBv1OysimHMejkWrjbPVXM9rbAaxjlbes/Z9TEfxja2jBhQfGYRjp
	bgTZlu9kY+ha+39y8t+YxDlOwHT9VTlmo36iCOEDhGwJ70OnaydsTIkbk0n1u10YVsvQXueTEN9bl
	sOeHwUVsqS3ylMhFQMUlHKjJR5MPHQBV085yYSOOB23cleE0SnkRzHIakcP/4ztK2z9nsLmM9izto
	zu9GzXTw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56358 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vCHEP-000000007aa-12ZY;
	Fri, 24 Oct 2025 13:49:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vCHEO-0000000BPTy-2Bhn;
	Fri, 24 Oct 2025 13:49:20 +0100
In-Reply-To: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v2 4/8] net: stmmac: move stmmac_get_*id() into
 stmmac_get_version()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vCHEO-0000000BPTy-2Bhn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Oct 2025 13:49:20 +0100

Move the contents of both stmmac_get_id() and stmmac_get_dev_id() into
stmmac_get_version() as it no longer makes sense for these to be
separate functions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 699c94acfeff..c156edb54ae6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -18,19 +18,6 @@ struct stmmac_version {
 	u8 dev_id;
 };
 
-static u32 stmmac_get_id(struct stmmac_priv *priv, u32 reg)
-{
-	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
-			(unsigned int)(reg & GENMASK(15, 8)) >> 8,
-			(unsigned int)(reg & GENMASK(7, 0)));
-	return reg & GENMASK(7, 0);
-}
-
-static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 reg)
-{
-	return (reg & GENMASK(15, 8)) >> 8;
-}
-
 static void stmmac_get_version(struct stmmac_priv *priv,
 			       struct stmmac_version *ver)
 {
@@ -55,9 +42,13 @@ static void stmmac_get_version(struct stmmac_priv *priv,
 		return;
 	}
 
-	ver->snpsver = stmmac_get_id(priv, version);
+	dev_info(priv->device, "User ID: 0x%x, Synopsys ID: 0x%x\n",
+		 (unsigned int)(version & GENMASK(15, 8)) >> 8,
+		 (unsigned int)(version & GENMASK(7, 0)));
+
+	ver->snpsver = version & GENMASK(7, 0);
 	if (core_type == DWMAC_CORE_XGMAC)
-		ver->dev_id = stmmac_get_dev_id(priv, version);
+		ver->dev_id = (version & GENMASK(15, 8)) >> 8;
 }
 
 static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
-- 
2.47.3


