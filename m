Return-Path: <netdev+bounces-219926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B858BB43B3C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45431C82DB7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE572E1C6F;
	Thu,  4 Sep 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PZdtOp7m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E92D131D
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987917; cv=none; b=BPaMtSABWUGE4lpVccLQ1zCTA8lKOihgviL55MRC0TGupdmuTWMIJH93xe9C1Yfg7hSvDZBiUz46Oy4Aud7N7xL46a68W2wJa8gP8CWuV1NBDhJ4omz7vm4aEb/0AbkEwpLfU+AKDXKBlj3+Exv0O584uXQrJcuKnF3R1pNTrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987917; c=relaxed/simple;
	bh=rc3s7Gve3oZ9rgKK4UdPJsOpdNk3CWd3HlSmLLfVgpI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=urMk36Ff+DDsPmhxXAcm9LtDKtETk4QMFqavphYpp2QKahR1SA+xQ1OYyNb20/wh3kwxj6UpfELUkSH7j2moS562avFtZ1qyXiitixCR21OLZh5+E88k1pUzXkQmuZDaTsDpem4twr+wJOaXHNu/JR+qdMKFyADfym6ABOct56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PZdtOp7m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iCaCMsSJc416KNNOsR6umJzwEx2Z6ECrOMgYqcR6Xzg=; b=PZdtOp7mwRZsx8WGWLvbliHNE+
	am6UMi13hymA7YzerDEsV4Vt00ZNO7CvNJrKgbwRvBDtSnbXE5pCyDl0yYpO9Cd5hPX8YzpBzlGg5
	GqTNlDUQ9lfZAeYvbjulpTA6z97MSE5BxRZ2xaXX1Pt1NuVi7ig7EVnJwoCO0lkrVNhoPpf3sttqC
	2zPdTyFM4n4laxdYI9aEx5gVh5VKrHq4FEcU2MgUG/0Yol7GdAK+kDsHmkKiINUMAGNKSLkX/vlYm
	4Iu9Lqng9kahEBITvnv9ogD4PeuBzuQXxWn7ITacUWOgwl4vOFwkZPS23e035hWcZ/8PXYca4qkAd
	yxgF8uPA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35666 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8oc-000000001zQ-3wQ9;
	Thu, 04 Sep 2025 13:11:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8oc-00000001vpN-0S1A;
	Thu, 04 Sep 2025 13:11:46 +0100
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 10/11] net: stmmac: mdio: remove redundant clock
 rate tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8oc-00000001vpN-0S1A@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:46 +0100

The pattern:

	... if (v < A)
		...
	else if (v >= A && v < B)
		...

can be simplified to:

	... if (v < A)
		...
	else if (v < B)
		...

which makes the string of ifelse more readable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index e5ca206ee46f..f408737f6fc7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -502,19 +502,19 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 */
 	if (clk_rate < CSR_F_35M)
 		value = STMMAC_CSR_20_35M;
-	else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
+	else if (clk_rate < CSR_F_60M)
 		value = STMMAC_CSR_35_60M;
-	else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
+	else if (clk_rate < CSR_F_100M)
 		value = STMMAC_CSR_60_100M;
-	else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
+	else if (clk_rate < CSR_F_150M)
 		value = STMMAC_CSR_100_150M;
-	else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
+	else if (clk_rate < CSR_F_250M)
 		value = STMMAC_CSR_150_250M;
-	else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
+	else if (clk_rate <= CSR_F_300M)
 		value = STMMAC_CSR_250_300M;
-	else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
+	else if (clk_rate < CSR_F_500M)
 		value = STMMAC_CSR_300_500M;
-	else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
+	else if (clk_rate < CSR_F_800M)
 		value = STMMAC_CSR_500_800M;
 
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-- 
2.47.2


