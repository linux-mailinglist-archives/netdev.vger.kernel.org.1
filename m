Return-Path: <netdev+bounces-143340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A39C217F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC695285FF4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE94194085;
	Fri,  8 Nov 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BtUQPoM9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73746194094
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081726; cv=none; b=FNrlB7ze0sqYpKGlre+zhY7v1fh5//tIlWUPzz8lAcsoCrBbR7TDh3NJCOJYvTUaSnnmYaBvqogWng4YMaXm9M3d/2HXWt7Ocwi69JxIS0FY6HWQT4GttMMh49ARh/o+RMxuLtXYbZz6E0LPz7b8I9sahX33f2CqvDLbV/WXtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081726; c=relaxed/simple;
	bh=o/Kci2EeXBwJz8Rd91M05oEi7BOYvyTtP44wdjuJTLw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BLkcPPMnIMT9Rl5O43+YoNBI//J038nxjd5fV64Kfsbb1catUpRDZOUJyDZWE++c9F6R/1UTBZulCIiMIMx+UFRCVBn6oqllKU/MpjhSs9gFxo008gl/G9jcoimUnlakG6kae1yENYC/2v1xUlwtrpN/Thq4eC6C+nYz+N+D7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BtUQPoM9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+lcKJIYbtxg4DfqlAvlMPSdz/HVOSSWl3DpKrEioYSQ=; b=BtUQPoM9mg7sMaU3Rwbjc7Wjrd
	CZAAWwxD8fH8lcNPatbfv+BKhNSNnq05oIqYIhZaQFGhnnlmDdUVkAzKd7ntF/nrW7mOPeHsPL/Lg
	FxvexCRmWXk5qUqoX+ir0l7FKHXfRQJeGFx2HTIx6tus5L5Z1aByPt/ufzsprrDKxZ0GRkfziaWKS
	CcRSfZWiHYvwzvqSIEY5dov2dHTprWYAqsfy9J1H3Hk3mfDh6U2H4DJfLV8+UDdhdlK9X3u3M2gjM
	KXbPwZIiorv6VJS2vwUCFCymsEU676XUdh9nx0GDLHOxGZ3PHswIUAMQ5TUuRDGvZqapbWg8ggY0m
	B4T68e7w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36616 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t9RQt-0005aP-2n;
	Fri, 08 Nov 2024 16:02:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t9RQu-002Fez-AA; Fri, 08 Nov 2024 16:02:00 +0000
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/5] net: phylink: remove switch() statement in
 resolve handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t9RQu-002Fez-AA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Nov 2024 16:02:00 +0000

The switch() statement doesn't sit very well with the preceeding if()
statements, so let's just convert everything to if()s. As a result of
the two preceding commits, there is now only one case in the switch()
statement. Remove the switch statement and reduce the code indentation.
Code reformatting will be in the following commit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 94 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3af6368a9fbf..aaeb8b11e758 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1470,60 +1470,56 @@ static void phylink_resolve(struct work_struct *w)
 		link_state = pl->phy_state;
 		mac_config = link_state.link;
 	} else {
-		switch (pl->cur_link_an_mode) {
-		case MLO_AN_INBAND:
-			phylink_mac_pcs_get_state(pl, &link_state);
-
-			/* The PCS may have a latching link-fail indicator.
-			 * If the link was up, bring the link down and
-			 * re-trigger the resolve. Otherwise, re-read the
-			 * PCS state to get the current status of the link.
+		phylink_mac_pcs_get_state(pl, &link_state);
+
+		/* The PCS may have a latching link-fail indicator.
+		 * If the link was up, bring the link down and
+		 * re-trigger the resolve. Otherwise, re-read the
+		 * PCS state to get the current status of the link.
+		 */
+		if (!link_state.link) {
+			if (cur_link_state)
+				retrigger = true;
+			else
+				phylink_mac_pcs_get_state(pl,
+							  &link_state);
+		}
+
+		/* If we have a phy, the "up" state is the union of
+		 * both the PHY and the MAC
+		 */
+		if (pl->phydev)
+			link_state.link &= pl->phy_state.link;
+
+		/* Only update if the PHY link is up */
+		if (pl->phydev && pl->phy_state.link) {
+			/* If the interface has changed, force a
+			 * link down event if the link isn't already
+			 * down, and re-resolve.
 			 */
-			if (!link_state.link) {
-				if (cur_link_state)
-					retrigger = true;
-				else
-					phylink_mac_pcs_get_state(pl,
-								  &link_state);
+			if (link_state.interface !=
+			    pl->phy_state.interface) {
+				retrigger = true;
+				link_state.link = false;
 			}
+			link_state.interface = pl->phy_state.interface;
 
-			/* If we have a phy, the "up" state is the union of
-			 * both the PHY and the MAC
+			/* If we are doing rate matching, then the
+			 * link speed/duplex comes from the PHY
 			 */
-			if (pl->phydev)
-				link_state.link &= pl->phy_state.link;
-
-			/* Only update if the PHY link is up */
-			if (pl->phydev && pl->phy_state.link) {
-				/* If the interface has changed, force a
-				 * link down event if the link isn't already
-				 * down, and re-resolve.
-				 */
-				if (link_state.interface !=
-				    pl->phy_state.interface) {
-					retrigger = true;
-					link_state.link = false;
-				}
-				link_state.interface = pl->phy_state.interface;
-
-				/* If we are doing rate matching, then the
-				 * link speed/duplex comes from the PHY
-				 */
-				if (pl->phy_state.rate_matching) {
-					link_state.rate_matching =
-						pl->phy_state.rate_matching;
-					link_state.speed = pl->phy_state.speed;
-					link_state.duplex =
-						pl->phy_state.duplex;
-				}
-
-				/* If we have a PHY, we need to update with
-				 * the PHY flow control bits.
-				 */
-				link_state.pause = pl->phy_state.pause;
-				mac_config = true;
+			if (pl->phy_state.rate_matching) {
+				link_state.rate_matching =
+					pl->phy_state.rate_matching;
+				link_state.speed = pl->phy_state.speed;
+				link_state.duplex =
+					pl->phy_state.duplex;
 			}
-			break;
+
+			/* If we have a PHY, we need to update with
+			 * the PHY flow control bits.
+			 */
+			link_state.pause = pl->phy_state.pause;
+			mac_config = true;
 		}
 	}
 
-- 
2.30.2


