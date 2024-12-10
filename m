Return-Path: <netdev+bounces-150689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD759EB2FB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BA01882F9F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6B78F4E;
	Tue, 10 Dec 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XFfBQAqn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089851A9B3E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840307; cv=none; b=H+QXl8cmtibQH41mKs5R5lJZV6HJABtzL1SQalOuOVqBH3Y5fW5U82pG3Nx5F5STz37F+QKmPlRTbLIJZLtrTvzJLhvK8kYiMg2Sy/WzUA0/KHJiZc27S3Rh0RJHUDZGKTsfk74wK8LLwP4oM2sTjuE/7AsyLbNAFAGKeiqbEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840307; c=relaxed/simple;
	bh=OeKl4ZpSVVRRpPXPiqKuKcrpWXCCjhFFJ6nwV0oBQ5k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G1SPHrexmluVH3KjrzsLw8Cn+qs8l2yZs8XxafeEgxMvcl25G1I8s5YTGVdDYVkLwqNHomzLjgA8RDGAWbI2t1UMN4ZMET5qAx7apuD6sIPem6TnuHhMFshY/Zn3mlCaNHKSbVmv3I5PKEFB6vQww8KSWFNbLJjsG9/prdQQgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XFfBQAqn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=heuIwIaco0ryk9+s/3Tq5BiUJ5G/QcaQOBK21igxZiY=; b=XFfBQAqncOi6+bZnJUa8u14GfE
	UH8WBg+i6wqTKWI8CHNHcSbcGTpgqfjaXailak5EzFeS96sihLJ4ldTDUs2ELiuRgSJmULcN9MHzi
	JzA6UCRt5thLH1p17CcvY6BQn/ITnlPDxkb25ziGJDZ0aPCrJTRmvLEvs3gz1jPbX076UP1hfhh8Z
	pxK29YsRBn34S71NiQIxMRLk9kVB0PaqRfJrc6PBhgwUEMqPTI5RPTn1RQhmEnE5M+MlCVAEyYB5W
	xql3R6UiD2YWN1pCm6XOY1K5hlhZ6yaT7TstmWzy+wt6p9fn8DMVhQ4J/MzmLcw2vPG5EWvwSKW65
	yhKcAAjg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38238 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL140-0002Sc-2g;
	Tue, 10 Dec 2024 14:18:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL13z-006cZ7-BZ; Tue, 10 Dec 2024 14:18:11 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 1/9] net: dsa: remove check for dp->pl in EEE methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL13z-006cZ7-BZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:11 +0000

When user ports are initialised, a phylink instance is always created,
and so dp->pl will always be non-NULL. The EEE methods are only used
for user ports, so checking for dp->pl to be NULL makes no sense. No
other phylink-calling method implements similar checks in DSA. Remove
this unnecessary check.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 06c30a9e29ff..0640247b8f0a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1229,7 +1229,7 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	int ret;
 
 	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev || !dp->pl)
+	if (!dev->phydev)
 		return -ENODEV;
 
 	if (!ds->ops->set_mac_eee)
@@ -1249,7 +1249,7 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	int ret;
 
 	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev || !dp->pl)
+	if (!dev->phydev)
 		return -ENODEV;
 
 	if (!ds->ops->get_mac_eee)
-- 
2.30.2


