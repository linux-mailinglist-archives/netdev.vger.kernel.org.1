Return-Path: <netdev+bounces-166764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699CA373C4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 11:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C116B7F6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36818DB1A;
	Sun, 16 Feb 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z3+Fvj93"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77954F8C
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739701272; cv=none; b=JyY07mhp6joTChDLckWE0HK+gnBfLK7ytGQHq6nbd8y6Y9eNeEUq79fMts6E/w+LFQEbAemKsKXSBQ3ouYpOv/JplL3xeYH6f8sUzaVnqSBM7+d9H4koNSMtndBegqd/5Aq6L3nG/5Dqy7Jmri975OO8gmsGxaWBc4oqrJz0Tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739701272; c=relaxed/simple;
	bh=dWscY8tUOJUNlB4lFVJNy4OycVUtNdPgnUJuw5hmWug=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=EhId0AnwCQUsyY7ZkRjkVF6GDsmMtqEremlIHZQbJav8uAl025BEXorpxINVrOTQldEjBpizFi0HrgRxT86cH8b5kxSPyDIAsPcntzcmVzDOJaw1NgF9YFRKaGgjJp91BUQ/lAYWFlKzgV+wmLdNXvUQBHCFcKbTJypRHjm/lBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z3+Fvj93; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t0EvxuftoNBlZuzZvC5/AGF04/SaKmF4F/991w3Itbk=; b=Z3+Fvj93t1c4P4+kb+DDXo4z8v
	WycKffYUp71lVm0p4Kwn52VxEDL6t/0j8IBnJRXkS22oT4B+HDdxTbMadodvvXxZ04sgHC+19fBkP
	uBOOxlXC6FLwgoBpqCPN2g/hM/naBzPyfTJ7K41qEluGFpZFMmWr38vBGNcwXVhisVY0hOyeTmUDR
	pYLTJXpz+RvSNjVTc9+9ry9ncFhNvB/i7Gby2QSHLRBo/GM5WzuoUWZunYlsP7Yz5Gj1TZWZoNdgU
	XLSyL8XhYxyQ/yk6EeYjHCrj+HNqe/Y093BtuH1Oqu/O4zkcjX6SC0y5+em5/43dUBrRYz7o3o2TW
	c69sieCA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38548 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tjbll-0002uh-37;
	Sun, 16 Feb 2025 10:21:02 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tjblS-00448F-8v; Sun, 16 Feb 2025 10:20:42 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: xpcs: rearrange register definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tjblS-00448F-8v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 16 Feb 2025 10:20:42 +0000

Place register number definitions immediately above their field
definitions and order by register number.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.h | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 39d3f517b557..929fa238445e 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -55,23 +55,11 @@
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_DIG_CTRL1		0x8000
-#define DW_VR_MII_AN_CTRL		0x8001
-#define DW_VR_MII_AN_INTR_STS		0x8002
-/* EEE Mode Control Register */
-#define DW_VR_MII_EEE_MCTRL0		0x8006
-#define DW_VR_MII_EEE_MCTRL1		0x800b
-#define DW_VR_MII_DIG_CTRL2		0x80e1
-
-/* VR_MII_DIG_CTRL1 */
 #define DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW		BIT(9)
 #define DW_VR_MII_DIG_CTRL1_2G5_EN		BIT(2)
 #define DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL	BIT(0)
 
-/* VR_MII_DIG_CTRL2 */
-#define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
-#define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
-
-/* VR_MII_AN_CTRL */
+#define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
@@ -81,7 +69,7 @@
 #define DW_VR_MII_PCS_MODE_C37_SGMII		0x2
 #define DW_VR_MII_AN_INTR_EN			BIT(0)
 
-/* VR_MII_AN_INTR_STS */
+#define DW_VR_MII_AN_INTR_STS		0x8002
 #define DW_VR_MII_AN_STS_C37_ANCMPLT_INTR	BIT(0)
 #define DW_VR_MII_AN_STS_C37_ANSGM_FD		BIT(1)
 #define DW_VR_MII_AN_STS_C37_ANSGM_SP		GENMASK(3, 2)
@@ -90,19 +78,22 @@
 #define DW_VR_MII_C37_ANSGM_SP_1000		0x2
 #define DW_VR_MII_C37_ANSGM_SP_LNKSTS		BIT(4)
 
-/* VR MII EEE Control 0 defines */
+#define DW_VR_MII_EEE_MCTRL0		0x8006
 #define DW_VR_MII_EEE_LTX_EN			BIT(0)  /* LPI Tx Enable */
 #define DW_VR_MII_EEE_LRX_EN			BIT(1)  /* LPI Rx Enable */
 #define DW_VR_MII_EEE_TX_QUIET_EN		BIT(2)  /* Tx Quiet Enable */
 #define DW_VR_MII_EEE_RX_QUIET_EN		BIT(3)  /* Rx Quiet Enable */
 #define DW_VR_MII_EEE_TX_EN_CTRL		BIT(4)  /* Tx Control Enable */
 #define DW_VR_MII_EEE_RX_EN_CTRL		BIT(7)  /* Rx Control Enable */
-
 #define DW_VR_MII_EEE_MULT_FACT_100NS		GENMASK(11, 8)
 
-/* VR MII EEE Control 1 defines */
+#define DW_VR_MII_EEE_MCTRL1		0x800b
 #define DW_VR_MII_EEE_TRN_LPI		BIT(0)	/* Transparent Mode Enable */
 
+#define DW_VR_MII_DIG_CTRL2		0x80e1
+#define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
+#define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
-- 
2.30.2


