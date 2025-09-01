Return-Path: <netdev+bounces-218735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC3B3E212
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F1443CD8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532F32143E;
	Mon,  1 Sep 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="twLnsvm6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77131A042
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727584; cv=none; b=dtclY7FQqLMAtbFcDYMIKXyiCqziTH9PZTGWzZGiWJd7jCfZ6z20YNmoaJBWzaXarua8BWJCwH46+7PgdHn+tfHPeFRN0qO1y+L3M7es1itr+h4Jqhug9kGPLKcAbWX/edzFtDC6K+yetJGWAOh9NLCI+9FDavr5Vg4jQQjOIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727584; c=relaxed/simple;
	bh=0uKLX0YbM6FwYZjGn87RG6rl2N0ibBbeEp6RBbc6Ku4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=WMk9r7rdwdTymJ+AhjyZI1x7VhM4kelJksL/Ehzo9kR7qEz+X4N31XPW0xelyYcPQbg+V94F4p6n5cy+9ndcjSbKPorNA6waNYKiWXYQViM6e1DVtXsQudp8x0O9Wtneq6J8u8TsNWES5RGa1H/+fN9yaRuAoVsbm694mNq38is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=twLnsvm6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ymsNJ3PTEC4q7MWeN6obBBZRJCmBiH354Kb/NAJ1Ukw=; b=twLnsvm6IbpA8F2HlcBNMCmnBC
	E6v2HX7F2hr3qgpffCDaVPqzn+Y97Kafb1Nn6F0AsTd/S6s+wVtzjnB+5KXf7GbeZVENFEVw7ivxS
	w7+9G9/cv4bwisDDh30o0Qe/QjNxuoAOVmBgRH5x1BxjHfFhbj0t79Y1N/n1XS7fQAk+VuqFDOma6
	pTyQH9T7njMt5Q6YbsscTwxqFWTlSqcVbP5A6B5u1tpqQfgVQ3BRQRN9gkLYw9iNs7081AukDKcYm
	CxYbBdVvstVJf9eTPD1pWOh3YASCRw1TSUloDkQF+qowlfB4zfFB4y1hLvD6gmQKB3djL65IpGyCq
	6CwbdlTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35678 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ut35k-0000000067U-3YRM;
	Mon, 01 Sep 2025 12:52:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ut35k-00000001UEl-0iq6;
	Mon, 01 Sep 2025 12:52:56 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: phylink: move PHY interrupt request to non-fail path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ut35k-00000001UEl-0iq6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Sep 2025 12:52:56 +0100

The blamed commit added code which could return an error after we
requested the PHY interrupt. When we return an error, the caller
will call phy_detach() which fails to free the interrupt.

Rearrange the code such that failing operations happen before the
interrupt is requested, thereby allowing phy_detach() to be used.

Note that replacing phy_detach() with phy_disconnect() in these
paths could lead to freeing an interrupt which was never requested.

Fixes: 1942b1c6f687 ("net: phylink: make configuring clock-stop dependent on MAC support")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..9a39478d9841 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2132,9 +2132,6 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		    __ETHTOOL_LINK_MODE_MASK_NBITS, pl->supported,
 		    __ETHTOOL_LINK_MODE_MASK_NBITS, phy->advertising);
 
-	if (phy_interrupt_is_valid(phy))
-		phy_request_interrupt(phy);
-
 	if (pl->config->mac_managed_pm)
 		phy->mac_managed_pm = true;
 
@@ -2151,6 +2148,9 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 			ret = 0;
 	}
 
+	if (ret == 0 && phy_interrupt_is_valid(phy))
+		phy_request_interrupt(phy);
+
 	return ret;
 }
 
-- 
2.47.2


