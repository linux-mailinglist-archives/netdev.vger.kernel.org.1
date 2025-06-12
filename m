Return-Path: <netdev+bounces-197025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45CAD762E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79A13AFEE3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82A2BE7D7;
	Thu, 12 Jun 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PL4Y6FU9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C2BDC20
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741710; cv=none; b=W7s+AFcMTh9nelBUFZJwpGwXRLwJ6gDO3vaIAQsy3Yz97qK1ZBMn55IdPPe2hCAQNkYurQ7Os+pgAEdVN0tYCKVbScXSmZVIg87lJI6EbiqwCbKEFiizMVv+MTpuTQi9HRzsl632uD2gYKnwcz4I7EeGPCnnACfavwft/d8w7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741710; c=relaxed/simple;
	bh=C27uzBY/5giXLYc56htreVHxWtSgQcC7JXv5wcOo1S0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=kZlAkubg1tgsqHUlu1PvhF+MGDw61yZ1R8qBLkwGxjnua3Wsd23kGXyPniN8/Up1R68dQDW38cncUtLP20LopTIsSD6I0t0hTL8xRG9jADQmJ+I+emIfCI/5sT7wxBoVGEgDSDjGIHHAPJ2h1PgPfwenYO0OpOLsXFFGQfsiSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PL4Y6FU9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZtPIHPS9HP/yCp2B/zsVNVJgXEBEjD1S4iWZWQchBiM=; b=PL4Y6FU9831PsMzgZ8a8oKcgJI
	33MHejtb10Ggmi+ySUVACBHBzA0kcgaEDTlYIsbESRhpAw2N+aR3me85EWEKrZ7Hm9JPVc3VYW1QV
	znkCrVxBy1uGSC1RORqwZFUuqUwx/4AXQtg9HiJSf7eVSwK5JOne8A87+4Bx50CzTsyKIFd7f+myU
	2I8fCNJ+LzFNt+1AbNbypF8ugoa3ia9chmVaAF3pLsJVz6Eq0FRBKNyXrJMnKQwl/mihbkhBA8jby
	0s4xBhFOPypliMZ+YFnfkIWHn1JHndyIDUGP8HP4U+K+lC5azrk1Iaz9uzwt83R/zIYXJNhRyOBCx
	HASCZLRg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51128 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPjkO-00081Q-2J;
	Thu, 12 Jun 2025 16:21:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPjjk-0049pI-MD; Thu, 12 Jun 2025 16:21:04 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: phy: improve rgmii_clock() documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPjjk-0049pI-MD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:21:04 +0100

Improve the rgmii_clock() documentation to indicate that it can also
be used for MII, GMII and RMII modes as well as RGMII as the required
clock rates are identical, but note that it won't error out for 1G
speeds for MII and RMII.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phy.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..802f3015f235 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -269,8 +269,10 @@ static inline const char *phy_modes(phy_interface_t interface)
  * rgmii_clock - map link speed to the clock rate
  * @speed: link speed value
  *
- * Description: maps RGMII supported link speeds
- * into the clock rates.
+ * Description: maps RGMII supported link speeds into the clock rates.
+ * This can also be used for MII, GMII, and RMII interface modes as the
+ * clock rates are indentical, but the caller must be aware that errors
+ * for unsupported clock rates will not be signalled.
  *
  * Returns: clock rate or negative errno
  */
-- 
2.30.2


