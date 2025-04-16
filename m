Return-Path: <netdev+bounces-183378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A51A90883
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36707189FD9F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBD20101D;
	Wed, 16 Apr 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qUEAw2Re"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0891C27
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820206; cv=none; b=CxvXasUrbuYkplm44g8f/q0uWABYyonEkRsn4aYgN+AH0Qhhv36Hep7qJRd/d+WIe6rDlObvfOSv/+xxPg/g9nhjyKVx4zbYB66Aof3bgowAymSiylz+8h8B1Cou7FcGxyRadpqeSKHq7++V1TieoYcRoyrU3NdHQYKpuHeko/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820206; c=relaxed/simple;
	bh=WxGPIaBP7SlPU61ycn7EkEPDTts+Y13/cRgO7QAtjzo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rC0ar+Lzx7M5kp/dbEzBd0zzKWHubaNWisf4OzN8UkmILg2rUGmH9IZyj15xlxi8mFspTvfW45lCaQLryY0Y2QVjPv9XYJ48gb4/F/odm5P9rgoEn0Qa4XRvpy4/lxRemj0271zrGMetiyV49dRON5uTAwF/cdze6w1QjbPD0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qUEAw2Re; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VRBSzzTdTZPbtyBVErfwZjzgy20zrDVRX0f0olerif8=; b=qUEAw2Reaohe8sc7oRBy00DJ32
	GXAoeL+a38VB4j4MubUevig8m0ncLbNTIL9VgIu5u312bKVQ6VRdEKiLvnQcM4oByicCEdQEjXVUW
	1nvDVRvDxY5H2iumJelDTrvAY2k92P+lqHzsl7int97RZag3zhDep4Er3uJM1b21GXEA40QeDX5XV
	Xf1VLE1Q5NcYuxrdr4qmCXzapCD+7n5EC76qNkHW+Kz/Vgp3fjuwroqMLaTt/Swuu12VXSuJY2J1Q
	EppttgljDQg9FWfGjQ7SVQdC8lPrcUSpVlj/I/+Rpa6KNJW+nB6iK37yEkZ6LmfemjKu2ED3HCT+m
	7EOb03yQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36598 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u55RH-0001ce-0u;
	Wed, 16 Apr 2025 17:16:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u55Qf-0016RN-PA; Wed, 16 Apr 2025 17:16:01 +0100
In-Reply-To: <Z__URcfITnra19xy@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 17:16:01 +0100

When WoL is enabled, we update the software state in phylink to
indicate that the link is down, and disable the resolver from
bringing the link back up.

On resume, we attempt to bring the overall state into consistency
by calling the .mac_link_down() method, but this is wrong if the
link was already down, as phylink strictly orders the .mac_link_up()
and .mac_link_down() methods - and this would break that ordering.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

To fix the suspend/resume with link down, this is what I think we
should do. Untested at the moment.

 drivers/net/phy/phylink.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 69ca765485db..d2c59ee16ebc 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -81,6 +81,7 @@ struct phylink {
 	unsigned int pcs_state;
 
 	bool link_failed;
+	bool suspend_link_up;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
@@ -2545,14 +2546,16 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 		/* Stop the resolver bringing the link up */
 		__set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
 
-		/* Disable the carrier, to prevent transmit timeouts,
-		 * but one would hope all packets have been sent. This
-		 * also means phylink_resolve() will do nothing.
-		 */
-		if (pl->netdev)
-			netif_carrier_off(pl->netdev);
-		else
+		pl->suspend_link_up = phylink_link_is_up(pl);
+		if (pl->suspend_link_up) {
+			/* Disable the carrier, to prevent transmit timeouts,
+			 * but one would hope all packets have been sent. This
+			 * also means phylink_resolve() will do nothing.
+			 */
+			if (pl->netdev)
+				netif_carrier_off(pl->netdev);
 			pl->old_link_state = false;
+		}
 
 		/* We do not call mac_link_down() here as we want the
 		 * link to remain up to receive the WoL packets.
@@ -2603,15 +2606,18 @@ void phylink_resume(struct phylink *pl)
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
-		/* Call mac_link_down() so we keep the overall state balanced.
-		 * Do this under the state_mutex lock for consistency. This
-		 * will cause a "Link Down" message to be printed during
-		 * resume, which is harmless - the true link state will be
-		 * printed when we run a resolve.
-		 */
-		mutex_lock(&pl->state_mutex);
-		phylink_link_down(pl);
-		mutex_unlock(&pl->state_mutex);
+		if (pl->suspend_link_up) {
+			/* Call mac_link_down() so we keep the overall state
+			 * balanced. Do this under the state_mutex lock for
+			 * consistency. This will cause a "Link Down" message
+			 * to be printed during resume, which is harmless -
+			 * the true link state will be printed when we run a
+			 * resolve.
+			 */
+			mutex_lock(&pl->state_mutex);
+			phylink_link_down(pl);
+			mutex_unlock(&pl->state_mutex);
+		}
 
 		/* Re-apply the link parameters so that all the settings get
 		 * restored to the MAC.
-- 
2.30.2


