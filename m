Return-Path: <netdev+bounces-248809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA14CD0EF68
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332E33007FE6
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C1330D38;
	Sun, 11 Jan 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uh3aa0xR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66233A71E
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137320; cv=none; b=hKeq9adREgkzwHJdtRZWt/OPeeBZWyVXdUeCC46N3oWQ0/pDFA5+MiyUzw6YVwA93woxEZ3hsD0db9fqO3YQ36Jh+vNKOvwrXng40VvRNx7n9RKRMi1mbs8pp4lKJntiSoDLZ/VAZ6aBkpRj8WMSsrzlIjEKfma5jRFjaKzPIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137320; c=relaxed/simple;
	bh=BlQNsHiF122TKeHLj7FeYOSS5bpzjcWvwPdXF6ktgC8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=q/CEq/majOy1bZ573Q9ZyrsnhSp7juCmEChyQyFKIoULuqB2Q4KczE2MVhda0lLRjQgg6ntiidUUDSw2pjiopwpIr+TeiusN8thBxhz2BVri4qUVU1vYoWHZ6MiqjliSZ8K+2zEKNiyT78deLJ6zuIhQwU/vsf7WBhSzAFG+sZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uh3aa0xR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ye1kNdA1HTl0/I4yeBxV9VNMMYaz3lRi+FVt2kspohk=; b=Uh3aa0xRCV8y109kv8en49U4bC
	zi1QfYajNatFCy7BCl/KBsOni0VQM4RC40Twfu5BTsqeQwHDySv8c1z2bc5VPLpoyzCeUvdQ1I99v
	6ty6s+Xmcs0sjjY4Hq+Xm6RXV8V/yO6bsDrL5cwa+ofw3aNtSz0j9hT1tC0yVkb9LAleWKARvHPzS
	3cYK97R4evX9CRiEZhPMOkdk8oLJVnt+KQP/+hAdzdMEMCREcdiTRSy3wmXNS24696srgrEmHUJJi
	dLL7nrGzjEctzd1LBLiSk6xXjq9T4oD/eLq41LVeTK5s/3vweUh7D/3CiRE7CjvrsQKrg6BE+Qet4
	K5o4cbvA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58704 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vevHi-000000005Tz-0lL7;
	Sun, 11 Jan 2026 13:15:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vevHh-00000002YoM-1TYL;
	Sun, 11 Jan 2026 13:15:09 +0000
In-Reply-To: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
References: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/5] net: stmmac: use BIT_U32() and GENMASK_U32() for
 PCS registers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vevHh-00000002YoM-1TYL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 11 Jan 2026 13:15:09 +0000

stmmac registers a 32-bit. u32 is unsigned int. The use of BIT() and
GENMASK() leads to integer promotion to unsigned long in expressions
such as:

	u32 old = foo;

	dev_info(dev, "%08x %08x\n", old, old & BIT(1));

resulting in arg2 being accepted as compatible with the format string
and arg3 warning that the argument does not match (because the former
is unsigned int, and the latter is unsigned long.)

Fix this by defining 32-bit register bits using BIT_U32() and
GENMASK_U32() macros.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index cda93894168e..fd2e2d7d5bd4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -25,27 +25,27 @@
 #define GMAC_TBI(x)		(x + 0x14)	/* TBI extend status */
 
 /* AN Configuration defines */
-#define GMAC_AN_CTRL_RAN	BIT(9)	/* Restart Auto-Negotiation */
-#define GMAC_AN_CTRL_ANE	BIT(12)	/* Auto-Negotiation Enable */
-#define GMAC_AN_CTRL_ELE	BIT(14)	/* External Loopback Enable */
-#define GMAC_AN_CTRL_ECD	BIT(16)	/* Enable Comma Detect */
-#define GMAC_AN_CTRL_LR		BIT(17)	/* Lock to Reference */
-#define GMAC_AN_CTRL_SGMRAL	BIT(18)	/* SGMII RAL Control */
+#define GMAC_AN_CTRL_RAN	BIT_U32(9)	/* Restart Auto-Negotiation */
+#define GMAC_AN_CTRL_ANE	BIT_U32(12)	/* Auto-Negotiation Enable */
+#define GMAC_AN_CTRL_ELE	BIT_U32(14)	/* External Loopback Enable */
+#define GMAC_AN_CTRL_ECD	BIT_U32(16)	/* Enable Comma Detect */
+#define GMAC_AN_CTRL_LR		BIT_U32(17)	/* Lock to Reference */
+#define GMAC_AN_CTRL_SGMRAL	BIT_U32(18)	/* SGMII RAL Control */
 
 /* AN Status defines */
-#define GMAC_AN_STATUS_LS	BIT(2)	/* Link Status 0:down 1:up */
-#define GMAC_AN_STATUS_ANA	BIT(3)	/* Auto-Negotiation Ability */
-#define GMAC_AN_STATUS_ANC	BIT(5)	/* Auto-Negotiation Complete */
-#define GMAC_AN_STATUS_ES	BIT(8)	/* Extended Status */
+#define GMAC_AN_STATUS_LS	BIT_U32(2)	/* Link Status 0:down 1:up */
+#define GMAC_AN_STATUS_ANA	BIT_U32(3)	/* Auto-Negotiation Ability */
+#define GMAC_AN_STATUS_ANC	BIT_U32(5)	/* Auto-Negotiation Complete */
+#define GMAC_AN_STATUS_ES	BIT_U32(8)	/* Extended Status */
 
 /* ADV and LPA defines */
-#define GMAC_ANE_FD		BIT(5)
-#define GMAC_ANE_HD		BIT(6)
-#define GMAC_ANE_PSE		GENMASK(8, 7)
+#define GMAC_ANE_FD		BIT_U32(5)
+#define GMAC_ANE_HD		BIT_U32(6)
+#define GMAC_ANE_PSE		GENMASK_U32(8, 7)
 #define GMAC_ANE_PSE_SHIFT	7
-#define GMAC_ANE_RFE		GENMASK(13, 12)
+#define GMAC_ANE_RFE		GENMASK_U32(13, 12)
 #define GMAC_ANE_RFE_SHIFT	12
-#define GMAC_ANE_ACK		BIT(14)
+#define GMAC_ANE_ACK		BIT_U32(14)
 
 struct stmmac_priv;
 
-- 
2.47.3


