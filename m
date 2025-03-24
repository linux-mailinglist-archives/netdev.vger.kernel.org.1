Return-Path: <netdev+bounces-177097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D811DA6DD61
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC313AF8B7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0426157B;
	Mon, 24 Mar 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fcj2sh+c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D825F963;
	Mon, 24 Mar 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827686; cv=none; b=f60dmhrLs1I1q75ZK70hjCA28Ikuim66CplwVaj54oGORYiXoofODqJi8wi7dVqJhiDPowK+k9jPucGpyOYlgkqAOia/cjjywLO6spjoyFDAFiVfDYH61S4c4VFkCP6kk7Sg7P6BPjv+QfaWzzn99pOFbqtQQq3ysC86KmkWLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827686; c=relaxed/simple;
	bh=3AoBMuDjV81vhPG3ltHHMg8tIknPaFrOKcZl2GSjRig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpss/M/2nmrKFskSU9M+nGn+c684/rSx4h7fagJiiCo3vhovVJJKLbiXngGJePpWqZxqN20nnL3oH3RATqX+CgXzngJX/WWqtsnwKNl1tcXjPKbea7m2xS3YcB8i1x4BXSzhMf7T7OA9XjidSydqZWZ80lHi26KXhby4IonnRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fcj2sh+c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742827685; x=1774363685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3AoBMuDjV81vhPG3ltHHMg8tIknPaFrOKcZl2GSjRig=;
  b=Fcj2sh+cyesTyP4OJkuwF1ducDDIemDjFHzMSQeaGi8WblghF5eeBT2F
   v8qJrytBKZY9o5Jb2OUNJwHtZOf5Wqhfb+Dcc4RB1fc6LFbUUO10K9V7r
   jRThSoqACXWAeyg0hbmnuozCtmFw9vkh92P2M0mzCHVTLiXvuYqQkoucr
   AVjI54oh/KM4HyZnl3U8/Fk3kkFicnkUj5U5pzjdDWG8YMTqgOGYSNgCq
   dvrYmVP0Z3b3orkJR/D0rQOgOu7oJ6yFhO6DMs+JNZ16SMlTIKYzVpYDx
   b5CvCwGhk/FUXVEjhK6LoYk3EgR7ZEPbdg2IOGeM8JZMgkEvG6qsW6pqI
   g==;
X-CSE-ConnectionGUID: 094Xe7flRWOHX1565XYHeg==
X-CSE-MsgGUID: 8H4ssAWyQOuAI9tom9yZxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43911857"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43911857"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:47:57 -0700
X-CSE-ConnectionGUID: zYUpcwEhTdS6aMIWWkSheg==
X-CSE-MsgGUID: NM4llLpORbmPADcLAwli/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124057064"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Mar 2025 07:47:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 012DF2A7; Mon, 24 Mar 2025 16:47:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v3 2/2] net: usb: asix: ax88772: Increase phy_name size
Date: Mon, 24 Mar 2025 16:39:30 +0200
Message-ID: <20250324144751.1271761-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC compiler (Debian 14.2.0-17) is not happy about printing
into a too short buffer (when build with `make W=1`):

 drivers/net/usb/ax88172a.c:311:9: note: ‘snprintf’ output between 4 and 66 bytes into a destination of size 20

Indeed, the buffer size is chosen based on some assumptions,
while in general the assigned name might not fit. Increase
the buffer size to cover the minimum required one. With that,
change snprintf() to use sizeof() instead of the hard coded
value.

While at it, make sure that the PHY address is not bigger than
the allowed maximum.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/usb/ax88172a.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index e47bb125048d..f613e4bc68c8 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -18,8 +18,8 @@
 struct ax88172a_private {
 	struct mii_bus *mdio;
 	struct phy_device *phydev;
-	char phy_name[20];
-	u16 phy_addr;
+	char phy_name[PHY_ID_SIZE];
+	u8 phy_addr;
 	u16 oldmode;
 	int use_embdphy;
 	struct asix_rx_fixup_info rx_fixup_info;
@@ -210,7 +210,11 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = asix_read_phy_addr(dev, priv->use_embdphy);
 	if (ret < 0)
 		goto free;
-
+	if (ret >= PHY_MAX_ADDR) {
+		netdev_err(dev->net, "Invalid PHY address %#x\n", ret);
+		ret = -ENODEV;
+		goto free;
+	}
 	priv->phy_addr = ret;
 
 	ax88172a_reset_phy(dev, priv->use_embdphy);
@@ -308,7 +312,7 @@ static int ax88172a_reset(struct usbnet *dev)
 		   rx_ctl);
 
 	/* Connect to PHY */
-	snprintf(priv->phy_name, 20, PHY_ID_FMT,
+	snprintf(priv->phy_name, sizeof(priv->phy_name), PHY_ID_FMT,
 		 priv->mdio->id, priv->phy_addr);
 
 	priv->phydev = phy_connect(dev->net, priv->phy_name,
-- 
2.47.2


