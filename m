Return-Path: <netdev+bounces-174950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D6A618F1
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B9A7A6712
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE91FF615;
	Fri, 14 Mar 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tgCW5XDH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F415ADB4
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975398; cv=none; b=O6yiGCYg00ED/upWTHgmhbCC67E8yH9ZJwCJnPSp/tnmgo8LfxcxP60nCdhmaHrkD/5WbzDSXoL+GENYx4NOodEBvXj1SGDn19mcRbnL1bjWULF86sUReUGiL270dDC3xOwsZAPnGihuvecKeC5rRwdHGEd1zJ51BOdKXDULPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975398; c=relaxed/simple;
	bh=/PBlYoYoPiVBkIVh1GooR9no0jFcOokQ0sr6aAVm1FE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=X9mAxzVJ8HACNA+QNHV511v+WSbpIKoX9qBzfuc6g5w1SZ52guBxIT22r98XADhPLUaMDbwzMgbkxxX5vgmGd89ON/BAmVxylxXq0v9/Dlv7+K+41p6cP1eZyGQMb3ziPd6RY2eGqmJ9dvod/iCaiL8CJRv8VZVSW/izK85Hzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tgCW5XDH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TgHfgZdfHwr3VmPVenW/lrNRZErmyNxPVMe0JcfQ1QY=; b=tgCW5XDH3faGlWtg3QVF6uope3
	kDyVymeZhDdoTIRHMZm2ZgbkIU3NSKYuUdk4dcFb1gdTeIeCAHhoI68mJR9N9srnLZlxPKIkeDRf/
	icp1oXrp+44SVSIPnvYGsFkAzsJURuJda1WDOAl5u+QbvabMLf5dKv7/oArVqgAAq2/e2Hpd3cKde
	23nvDnH82EE0MjxWWQy2zABD3BR2piwFeBBeUZr+COkpIuBWKcuiEuOai1DJQipwx3T0PFgbefuc6
	9AWmgACO78bc+n0mei+87fAIvLZhSPK34nLqFpu11R/0JO7qZYdF32P7MIguKZRYS3JlyssvtRgVp
	TD+zshhw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59374 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tt9NB-0000fU-28;
	Fri, 14 Mar 2025 18:03:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tt9Mq-006xIG-IC; Fri, 14 Mar 2025 18:02:44 +0000
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
Subject: [PATCH net-next] net: stmmac: remove unnecessary stmmac_mac_set() in
 stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tt9Mq-006xIG-IC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Mar 2025 18:02:44 +0000

stmmac_release() calls phylink_stop() and then goes on to call
stmmac_mac_set(, false). However, phylink_stop() will call
stmmac_mac_link_down() before returning, which will do this work.
Remove this unnecessary call.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ee6c0af3fd..839ecebf5f5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4129,9 +4129,6 @@ static int stmmac_release(struct net_device *dev)
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* Powerdown Serdes if there is */
 	if (priv->plat->serdes_powerdown)
 		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);
-- 
2.30.2


