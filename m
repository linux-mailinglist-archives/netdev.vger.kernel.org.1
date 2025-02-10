Return-Path: <netdev+bounces-164651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CCA2E9A5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A02188B4BE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899231D5CE8;
	Mon, 10 Feb 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cqSOlErm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E21DE4DC
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183840; cv=none; b=ttgK1hHZePPME/NTujfHCUlwkIMBJII/todXzkqqa3I3/xAZZCoKMpmULfePKtmJ01hv0SiFUlRG97vrkjorILbmkdilho+yrutsShzxq+eWM3bjDJntYMzQg75asdFcOaxynk9u904Jv1VuP/BWlOkyHoF8PbZo8uB13lev42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183840; c=relaxed/simple;
	bh=WnwHMJV6P5qbvli061alplKa3pMKkHS7JMq44LCGfaY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FCAXfAYF3/gFPhCyzA1jYF35EHbLKYT5+ojDSid6vHmwAAXfK9O9UbBF9C2jM/auV4OvLfW9xhneQWBzn3OqPxZ14pkJyvnlKGpGi6mAkK+ycRK9Fm1SrtC0gbist+zQrH9BUcPnuNGkOBbt7eHKEOrgTtfkNSA15L3JeqJkm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cqSOlErm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DlxjZGXanDXKYhqFjk9v56yUdRPX52NKfpEf5gaJfFM=; b=cqSOlErmRjo6dfA7xMOFeKkTuw
	yj4z1UUBURPdHcBahaCr08QjLIyTN2nv9vFXbX1n1EYdiSVtyzFh8v0ZirBkX6n4mO6ULVpZcuNrw
	+UEWuc7My2dGnlIwzJP7YMC1WWHl0g8/q3+RqsaIiCqS9gvn+MHARLwrhOr3bNJoLk3Q1pfgDiFHN
	TCvlmXeBbjJkslgSlcMydggqkwK8A75v1h446Y2VVWOY0AACHowqTXw6G0i/UkCP7308lWJEuMPnZ
	7fAUwivaLa/gEqGJHiP1Bu8uH3CUA9e+RYQCG0LrLfsOJN+IwlIGw6dlRLhb0Sz+JWRNmZ9LPi7j3
	Ge2ErPDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48976 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thRA4-0006RG-2q;
	Mon, 10 Feb 2025 10:37:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thR9l-003vXC-9F; Mon, 10 Feb 2025 10:36:49 +0000
In-Reply-To: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v3 2/3] net: dsa: allow use of phylink managed EEE
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
Message-Id: <E1thR9l-003vXC-9F@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:36:49 +0000

In order to allow DSA drivers to use phylink managed EEE, we need to
change the behaviour of the DSA's .set_eee() ethtool method.
Implementation of the DSA .set_mac_eee() method becomes optional with
phylink managed EEE as it is only used to validate the EEE parameters
supplied from userspace. The rest of the EEE state management should
be left to phylink.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..2296a4ead020 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1243,16 +1243,25 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
-	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev)
-		return -ENODEV;
+	/* If the port is using phylink managed EEE, then an unimplemented
+	 * set_mac_eee() is permissible.
+	 */
+	if (!phylink_mac_implements_lpi(ds->phylink_mac_ops)) {
+		/* Port's PHY and MAC both need to be EEE capable */
+		if (!dev->phydev)
+			return -ENODEV;
 
-	if (!ds->ops->set_mac_eee)
-		return -EOPNOTSUPP;
+		if (!ds->ops->set_mac_eee)
+			return -EOPNOTSUPP;
 
-	ret = ds->ops->set_mac_eee(ds, dp->index, e);
-	if (ret)
-		return ret;
+		ret = ds->ops->set_mac_eee(ds, dp->index, e);
+		if (ret)
+			return ret;
+	} else if (ds->ops->set_mac_eee) {
+		ret = ds->ops->set_mac_eee(ds, dp->index, e);
+		if (ret)
+			return ret;
+	}
 
 	return phylink_ethtool_set_eee(dp->pl, e);
 }
-- 
2.30.2


