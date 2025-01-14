Return-Path: <netdev+bounces-158132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17141A1086E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81258188282A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5857132C38;
	Tue, 14 Jan 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="znlQ3enA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CCC8C07
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863399; cv=none; b=RfwQy1XkGzELO5TwbqJC6UN3d2orz0NCnJUMtunGevq0Y9aes/R3QMv+aLCrjWYtqfPYRJqUR3qUxfNaFu2VCyhuvJOONaWcVKDPVPHk8hGLETPHavoeCdLTz8jzxv/kDLQ30HKlm2+vOE+diHDdT1k+vIKUd5hfpU1PVeFD9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863399; c=relaxed/simple;
	bh=dAFd8KNDC190OuBfdivOOCZpQ+dw7eDdR7bL+2ChSGU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rHsbtCF4Co5IyYrpc1QBJb9UfN73764r03T5yMQzoKZ+tHN+IcLGK9nyHiz0Nuf1DpKTeiz6qOm96Qvm4lAFJjC8PRK0uvYTvxQBC+FEupnjUMVnV1QVvBbBXpcvOGE6e3EzLvJiFo/BFN8TMYkIOTQy4gclNVKLRc79+UDTICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=znlQ3enA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bSpEFY7EzrjMbPzAvp+SMli9ZoKwwgJN9BbiOeWW6CY=; b=znlQ3enAOM8n0X/HgNA9XpNIai
	vXHqjdRRV+WwS0OY/lDVrWGROTwSRAEIKdjbeybiZYZ278+ckMm1JcBbJfZTcym6DpeLQg3XJ5Ggf
	pWJsYihDy7Wfk+/jSVqVZl+qMIb3H2B71U8jxZehL4rmXNBWAGqS61sdO4HFmDEk2UM26XBu024Bh
	NiU6gXvBvXkuiaMsqmRAaHXGz3WwlGr8/2mdWMz6C3U3IRay2su8MaYflCHiblpZwrzT0UNFh+LJa
	yLYekRAyZH7Tue1KjM/8km096fGd/j5ZjMlcOZrkV89j2ZZMl1qaPeuXhmvKWZ09jwjAHWt36QTqy
	ED9sHvCw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54652 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXhVd-0008BT-1m;
	Tue, 14 Jan 2025 14:03:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXhVK-000n18-3C; Tue, 14 Jan 2025 14:02:50 +0000
In-Reply-To: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 10/10] net: dsa: allow use of phylink managed EEE
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXhVK-000n18-3C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 14:02:50 +0000

In order to allow DSA drivers to use phylink managed EEE, changes are
necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
make use of phylink managed EEE, these should just pass the method on
to their phylink implementation without calling the DSA specific
operations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c74f2b2b92de..6912d2d57486 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1233,16 +1233,23 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
-	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev)
-		return -ENODEV;
-
-	if (!ds->ops->set_mac_eee)
-		return -EOPNOTSUPP;
+	/* If the port is using phylink managed EEE, then get_mac_eee is
+	 * unnecessary.
+	 */
+	if (!ds->phylink_mac_ops ||
+	    !ds->phylink_mac_ops->mac_disable_tx_lpi ||
+	    !ds->phylink_mac_ops->mac_enable_tx_lpi) {
+		/* Port's PHY and MAC both need to be EEE capable */
+		if (!dev->phydev)
+			return -ENODEV;
+
+		if (!ds->ops->set_mac_eee)
+			return -EOPNOTSUPP;
 
-	ret = ds->ops->set_mac_eee(ds, dp->index, e);
-	if (ret)
-		return ret;
+		ret = ds->ops->set_mac_eee(ds, dp->index, e);
+		if (ret)
+			return ret;
+	}
 
 	return phylink_ethtool_set_eee(dp->pl, e);
 }
-- 
2.30.2


