Return-Path: <netdev+bounces-233701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D8DC1774F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 989CD4EB6A4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C15F9E8;
	Wed, 29 Oct 2025 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HLWd9ou7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880D20322
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696215; cv=none; b=FLtcIsrWXHKqNeNvYkwRbRINQG7EVUpspqVeXZEtfs08Jh38fi8CTFjCklfpxrrFBEK/1wl1f0mers59xpNaV3Xb7OZetF37y2yNSRj26WNRttzu07yZFkg11R0uMij8KdgwQ30nicaaYFXrB/jumf2sflJOW6uhfarnwktQiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696215; c=relaxed/simple;
	bh=p7iSEvY3374kt+AXlc3OKxo3um5Ah2KFub6lOKVwY/E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hRdxJmawjolb7se58OrtfozuUo24dSF7pVZfPR3t7ZbUEq7yA+WQT973FisL5UjG+LTR8Refedc5ehc2HBrmOR6+QIi9fSVoiro+T4sYjLYrI/fZ9HJ67QZIPWJfrqLToqLsYk1KSDdLBOZdrK/gBULitcbJvV5bwITNKPKmll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HLWd9ou7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P0KRCrbmP1i6u43p8Sa6nKDk67vZ99gOIj0vPnQNZsg=; b=HLWd9ou7iGRoiAyHWxwG7u+GYT
	qxYeMsUSNVV7DQZRFNajyUcWCqgJc8VvLJCireU3ORwN8AjPPysyPmMKJFVP7FYwL+WLIrxBtXGvD
	F8sjg6B/b8lRJ6kmLe1MoRMSusenSw9vNl8dSR7hBp5QM5gWJbVR33Fowu0kOCQ4NJ9qcZKkEiPqp
	MsDaEslDJy3YJn+yxaWbdY4GtheImGAsab8bAfb52+PSdeiIBdKeKcT1WYTmq/5urjX4P/iAbatdY
	7VXn1LUuswXDJJGvm49XDjm5QGe9CwCqkIoNZqP4Z4r6okaotU0G9+5HPqXnTpy+bdY0TCt9SHNt+
	7moY7YqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56216 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtex-000000003hH-0qoM;
	Wed, 29 Oct 2025 00:03:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtew-0000000CCC9-0KeM;
	Wed, 29 Oct 2025 00:03:26 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 4/8] net: stmmac: move stmmac_get_*id() into
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
Message-Id: <E1vDtew-0000000CCC9-0KeM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:26 +0000

Move the contents of both stmmac_get_id() and stmmac_get_dev_id() into
stmmac_get_version() as it no longer makes sense for these to be
separate functions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index ffdc101ce3ce..a4df51a7aef1 100644
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


