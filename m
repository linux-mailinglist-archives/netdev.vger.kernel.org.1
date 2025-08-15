Return-Path: <netdev+bounces-214043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9CB27F37
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD38AB64CEB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864927FB3E;
	Fri, 15 Aug 2025 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VVhPY4iK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA52857CC
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257563; cv=none; b=dqjwo3vwbNHmRx7/wfP/UMlwIIjF7hIcYPmeis6WDxtFp7xI+YFvwftT6oKfSFQRD+FmrCtigzx8z+HX0Ic08eoH5aLhuc/KKGOVI0sWbOJruUptK6MJ16o4oPWyM8a+PEP9OVDMCz5Or93vZTvHEv/6FkTBbv4UlROftrQICfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257563; c=relaxed/simple;
	bh=mOZu74yAR37nkzjZEGGeiWXde6MsR8NJwh8fhBZwyM8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=K4vC13sCdWVpUbMD1KTrWrqw64PhbsTSvvXg+mmR1A1QfV6TmWDWOdrQOAmqmCjmB2YZvXGiu2NNBsiZA4ZXREGNIkbmsJuNbb4YY9Qmtay0L3LMuDM3upHz8+9amfYP2dbaM2lPXEXsBg1tGVOpvxB9pjs0C95xQw+bdd9OtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VVhPY4iK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9PDEQQVstFPjRei/ldFIp0/nQrs7re/PB3W4I/9pPKE=; b=VVhPY4iK2GzN2+0hSxy3pLbO9t
	T3iD57j6s50is6c+bB+cgdhEb5LhPrf+gWbT//f07oaHYplyB7ki8TB/RRGWx2xDqEjSTKAsnwG6Y
	g2PhmJAdt5W2T8UYMDptpi3Kz+dET9atTzjrLLQC932UvlaenhP/RexFMxi9cn1YRZEPaezOdm6p4
	7lxJLlcgRGIjl66uX2+2MiVrL4+ElSJJqlPtd6tNGFqLOVNm9NC8264qdsiVOGJjzSZGjY9l++8ya
	14Q/RYy95YI0KPajAsAohU9wEnr8hUrE+5vsZzzzLYL+qFAq+Yh4NTK7Y93HiZ8S2SbRKv8umJS3u
	Aj+zq4kQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60688 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsfi-00011I-39;
	Fri, 15 Aug 2025 12:32:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsf0-008vKK-A3; Fri, 15 Aug 2025 12:31:50 +0100
In-Reply-To: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/7] net: stmmac: remove unnecessary checks in
 ethtool eee ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsf0-008vKK-A3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:31:50 +0100

Phylink will check whether the MAC supports the LPI methods in
struct phylink_mac_ops, and return -EOPNOTSUPP if the LPI capabilities
are not provided. stmmac doesn't provide LPI capabilities if
priv->dma_cap.eee is not set.

Therefore, checking the state of priv->dma_cap.eee in the ethtool ops
and returning -EOPNOTSUPP is redundant - let phylink handle this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 77758a7299b4..dda7ba1f524d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -852,9 +852,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!priv->dma_cap.eee)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -863,9 +860,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!priv->dma_cap.eee)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
-- 
2.30.2


