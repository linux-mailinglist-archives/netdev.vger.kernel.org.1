Return-Path: <netdev+bounces-181875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33FA86BAF
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FB819E7628
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5272E1957E4;
	Sat, 12 Apr 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zvUMD39H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C41AAC9;
	Sat, 12 Apr 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744444442; cv=none; b=NtE/fVG71PvG9OXkNx0Hzx67zQPRqT9HHvIrpsraty2bvmu+NSeqd4LRttBB2KwKoK7B5vLNbC0p1rHqK7z9awvjswZEE9fji7ZLcP9qj1Yt1AZAEy7PjsRV7rZOqDr7zOXFWJyGszdPOpGgS3+s2g++Ti6QYo7VExFF/46oQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744444442; c=relaxed/simple;
	bh=ZlMjZKOMPTKoJ9ZpP7cOl5PKRQ8ruKoFNZq1WWN8Xas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTqHiT+Yw4YF2NC+hflCuREOVAC/vwkf5q45armf2fQio/UP5UxWsf5KhapOfgIxZ3Lh2GocsTsb8AqqIVoCRfX0pR0VTb12qJAddC17ju0ld2CaJQ7L6D8duA/NvcgOQ4elYrwjB5EIFTQzCxMMD8N2zGmsGrgZA4YqP6QXdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zvUMD39H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3g5bQIvSn2V0cfGaFO0najpQyajeV6gzRWql/UeFGts=; b=zvUMD39HnpCyz2RJ16Kfczifr5
	gzAQgCQret9xwZHgNiMYiV+v/ywX8Nrkuh6BjOiQNbISf+MF3Jm/XeIX8LpwbJ1rrMuXz6mn80QoX
	OfbxqeqYy3+c3rgz+k7cqz+Jawv2IDd2DOvTuZFCZdZ9irftrjJ+pSs+bo9Xja7vP3RqjYbIbZGwU
	w2xkK8iS7YHKyDumuJKIK2ashrEjtV8EtnSTalH6NiAI4OQBz2MsehWNNeTpZQ+mmnEDZ1KRsfGdH
	gRq6Qdvx/G2rqcy/wDXoHxtofcry+u/o22u5wOHHGPXb+fulTGjpH8/eF2nhtAEvCZktGSWHKtV6i
	TomYi2pQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3VgV-0004Kv-0S;
	Sat, 12 Apr 2025 08:53:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3VgS-0005Ui-0q;
	Sat, 12 Apr 2025 08:53:48 +0100
Date: Sat, 12 Apr 2025 08:53:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v6 1/4] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <Z_ocDCQIHqO0HLkw@shell.armlinux.org.uk>
References: <20250411062426.8820-1-michael@fossekall.de>
 <20250411062426.8820-2-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411062426.8820-2-michael@fossekall.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 08:24:23AM +0200, Michael Klein wrote:
> Group macro definitions by chip number in lexicographic order.

Even after your patch, the registers aren't sorted as you describe.

My recommendation would be:

- group register field definitions below register number definitions.
  let's call these register definition blocks.
- group register definition blocks by prefix (so blocks for the same PHY
  are together.)
- within each PHY block, order by page number and then register number.
- keep definitions that aren't registers separate.

The reason is, when someone comes along and adds more definitions, they
aren't going to be using the register definition to determine whether
it already exists or not, they're going to be using the register number
and/or bitfield.

So something like the below. It could do with more definitions for
register numbers and/or page numbers.

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 893c82479671..e61a29c54f78 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -17,6 +17,16 @@
 
 #include "realtek.h"
 
+#define RTL8201F_IER				0x13
+
+#define RTL8201F_ISR				0x1e
+#define RTL8201F_ISR_ANERR			BIT(15)
+#define RTL8201F_ISR_DUPLEX			BIT(13)
+#define RTL8201F_ISR_LINK			BIT(11)
+#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
+						 RTL8201F_ISR_DUPLEX | \
+						 RTL8201F_ISR_LINK)
+
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
 #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
@@ -31,13 +41,26 @@
 #define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+/* 0x1c */
+#define RTL8211E_CTRL_DELAY			BIT(13)
+#define RTL8211E_TX_DELAY			BIT(12)
+#define RTL8211E_RX_DELAY			BIT(11)
+
+/* page 0xa43 */
 #define RTL8211F_PHYCR1				0x18
+#define RTL8211F_ALDPS_PLL_OFF			BIT(1)
+#define RTL8211F_ALDPS_ENABLE			BIT(2)
+#define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
+
+/* page 0xa43 */
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
 
+/* page 0xa43 */
 #define RTL8211F_INSR				0x1d
 
+/* page 0xd04 */
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
 #define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
@@ -47,25 +70,11 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+/* page 0xd08 reg 0x11 */
 #define RTL8211F_TX_DELAY			BIT(8)
-#define RTL8211F_RX_DELAY			BIT(3)
-
-#define RTL8211F_ALDPS_PLL_OFF			BIT(1)
-#define RTL8211F_ALDPS_ENABLE			BIT(2)
-#define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
-
-#define RTL8211E_CTRL_DELAY			BIT(13)
-#define RTL8211E_TX_DELAY			BIT(12)
-#define RTL8211E_RX_DELAY			BIT(11)
 
-#define RTL8201F_ISR				0x1e
-#define RTL8201F_ISR_ANERR			BIT(15)
-#define RTL8201F_ISR_DUPLEX			BIT(13)
-#define RTL8201F_ISR_LINK			BIT(11)
-#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
-						 RTL8201F_ISR_DUPLEX | \
-						 RTL8201F_ISR_LINK)
-#define RTL8201F_IER				0x13
+/* page 0xd08 reg 0x15 */
+#define RTL8211F_RX_DELAY			BIT(3)
 
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

