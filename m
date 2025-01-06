Return-Path: <netdev+bounces-155423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79759A024A8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601CD164B0F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D361DC9B8;
	Mon,  6 Jan 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Goh2vXIt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE41DB943
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164765; cv=none; b=ug959QiBfAJy8V/JGMSNOFM2U4ytlA606wgxi7pj/OsbnctWnITUYpuJVIY1iNoxuKBBTjbSnq34UAQPea7p9C4yfdHRBrHkzYCE7WJR846lWBHOQqU2sN5YIYtFun+GqaDXXb31It+zHmyuOJrwEUmLe7UIRloXrh82IUZHfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164765; c=relaxed/simple;
	bh=aTakWuSrbdXTqkjry27m70fNxHHLDrw+0HMqz56fvSc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=grFevqSbc7P8n6Z0m5CNPCQMckHwG1MKQPEItBfOsd/tlG+af5YFDD/nRGCIgfZw1NLUPFWVyw/KnWZGeMc35iQrlAtQFgChCk5kSnf62umT8zOYtpFA2iE6CFnuyYpofm+NOf3hjfMBLRAT5XH4W/XErRNXM15fO08PmD+TJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Goh2vXIt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I4HcR+uk2k+/haMI6YVeZlGnK63mLuRugXFx+MkSpyg=; b=Goh2vXItiH09PqezFLHuJQtp2U
	P5zntrSx/FulA4azPuWyssK9DSZkHWpfo/qXKi8WPl0pv9V7JF88R7yEqMOUiySACtCw8IhnCNJw6
	46dWShQc7xK1+yEHClakI+TTmY93FuyK7V768Q6uvnXhsXmuT3o8X698Derh7Z5ju6t9/eT9v+E3N
	APIhdprS9XPGzzNrfRCIHOh/wwbWrceRsY2rzLVeJAgBPvc7SxcS7WxGF+rYBn2eiSIZ9ulerxVyN
	HdZbewK24C5+tamDhfHvIYsDvHtHnPT4oVsffv7AYuG60oXNBySqKdqERLI3BEEmK/RniBvi9PXj1
	ik5tXUlw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37114 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUllI-0005lR-1Q;
	Mon, 06 Jan 2025 11:59:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUllF-007Uz3-95; Mon, 06 Jan 2025 11:59:09 +0000
In-Reply-To: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 6/9] net: dsa: mt753x: remove ksz_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUllF-007Uz3-95@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:59:09 +0000

mt753x_get_mac_eee() is no longer called by the core DSA code. Remove
it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mt7530.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4c78d049b9f4..d2d0f091e49e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3085,12 +3085,6 @@ mt753x_setup(struct dsa_switch *ds)
 	return ret;
 }
 
-static int mt753x_get_mac_eee(struct dsa_switch *ds, int port,
-			      struct ethtool_keee *e)
-{
-	return 0;
-}
-
 static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 			      struct ethtool_keee *e)
 {
@@ -3233,7 +3227,6 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.port_mirror_del	= mt753x_port_mirror_del,
 	.phylink_get_caps	= mt753x_phylink_get_caps,
 	.support_eee		= dsa_supports_eee,
-	.get_mac_eee		= mt753x_get_mac_eee,
 	.set_mac_eee		= mt753x_set_mac_eee,
 	.conduit_state_change	= mt753x_conduit_state_change,
 	.port_setup_tc		= mt753x_setup_tc,
-- 
2.30.2


