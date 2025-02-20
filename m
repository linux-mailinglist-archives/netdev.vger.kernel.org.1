Return-Path: <netdev+bounces-168132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9658A3DA5C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1582319C0625
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA91E1EF0A3;
	Thu, 20 Feb 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yYaw0wop"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729229CE6
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055697; cv=none; b=iZgpNi1q2HlDWc5sKzfTstdgIc0fOf8JuvaJyPHcLcs17YtEBMVPAX55/C+/K99n+9g57/L59DKspdAsPaiKXSA9cJXcoUHv9uPU/evrpNnbIiFhVdyyb6huBVdY6+UlZyD7XQyEnp1AZi/2t3Fo3fm82rZNCSEfxb0ZjZauw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055697; c=relaxed/simple;
	bh=eeyP3648FGYG5B/9mcNo50qNnzOoR+d3kJtPDE+T6nk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=hKkeCTLk5/OFtGKs+zhlpEqeWcVATocAZf7eTofNAvwZ+dwwi4khac0wbFwEodkV90sOZjPJoIQJr5FUQvIEibC7L9WiOwlCch9Z7zN9iuMMbRAGPVVDf6hAeudgSZgoRLfsIwjTEsr3sqkvKNWRs28VvKoDf/plhVzZIvnYnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yYaw0wop; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E5+2puAdJcLcm7GiCQlmphHj1Zhoat9wHQNBgpT3Vbo=; b=yYaw0wopL4OQ7X2EZN1jO6ypLE
	p5HCBBxPl7aE7LDFuHH0XICq1NJRStUIbQvlvqVe7IrRMGv0BjX5rUpVBOWVTmVmBFPzLzwm01F9q
	PcRBWmvgBJ6g04OakL0xBgXxW4O7qTY6r4NaQPuzXNbu9cRjzU2wF7unTUT3CaPlv8GPRjmeuL5MQ
	vh+q7LWxMGUwFkuOhVu5uhH09ZhXekiRslfykjY0b2Gtw1WTJFOdGlpZnLZnpAUrzFkgOnXG3jkvL
	H71apd62aQzGVmuVJ1RSM0l6vXZ5OuM38iUuywjHyx+CkVp5UXl0eTu1yR8drfckJYeWLVkM4e0cC
	18nukHeQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33726 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tl5yK-00010I-3D;
	Thu, 20 Feb 2025 12:48:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tl5y1-004UgG-8X; Thu, 20 Feb 2025 12:47:49 +0000
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
Subject: [PATCH net-next] net: stmmac: print stmmac_init_dma_engine() errors
 using netdev_err()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tl5y1-004UgG-8X@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 20 Feb 2025 12:47:49 +0000

stmmac_init_dma_engine() uses dev_err() which leads to errors being
reported as e.g:

dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed

stmmac_init_dma_engine() is only called from stmmac_hw_setup() which
itself uses netdev_err(), and we will have a net_device setup. So,
change the dev_err() to netdev_err() to give consistent error
messages.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4d542f482ecb..218ecc945e9e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3034,7 +3034,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	int ret = 0;
 
 	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
-		dev_err(priv->device, "Invalid DMA configuration\n");
+		netdev_err(priv->dev, "Invalid DMA configuration\n");
 		return -EINVAL;
 	}
 
@@ -3043,7 +3043,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 
 	ret = stmmac_reset(priv, priv->ioaddr);
 	if (ret) {
-		dev_err(priv->device, "Failed to reset the dma\n");
+		netdev_err(priv->dev, "Failed to reset the dma\n");
 		return ret;
 	}
 
-- 
2.30.2


