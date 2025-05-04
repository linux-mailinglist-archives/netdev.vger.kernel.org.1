Return-Path: <netdev+bounces-187651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF7AA88A5
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA4A189A4D1
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC11FDA82;
	Sun,  4 May 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="G6D4A68x";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="voEqFNAG"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0C1FDA6A;
	Sun,  4 May 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380138; cv=pass; b=UXzdp08JDRXC+V7GE9e7M0NM0kSHN6H/V2J0hoDfmHk12EOqeX0GBUndzz61Ylyz+ckVaOW29ZPmCWkZwEfZB1cHpDLSTSnC67uJC8xQVwa+kPxSbutXS4wEJXmfvINtxKwkiSdruTDEcDhGIMBGpVKGb188EDFd1jFo9Yfwr7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380138; c=relaxed/simple;
	bh=STrK0dUvieUlDqNzFLtU0MIwRwcJdX2k7ODG2/WDDpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIaLrbY4Rn1dhYKbjJ8iYgN6/5A0exZPIlAsaNbvAFNaAnsfUnWNVB90hy+NrKKVHDPtVBCrs8uM+6YNJZPaqajT4YgRiNf+mucecOKwaouYV01Bum8B2fN6+5fOSqaZah9N/F8+h847571mhPAvmZF6XYTXIFixnzyW+1IbmTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=G6D4A68x; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=voEqFNAG; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379773; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q6H3ym13n9VQ5z9+qlzO0onLytXqxgXKOxbMLPeoCgUdAPucRweeb4Il5TSzq47uk4
    rl304SN7Vin0lq36UCk5MYiJKd1R5R8gbIh1CcIHRIxrMOxQYSGTzDzHJq4yLLgar6Vb
    WzZY3okh0sm+Sq+iHRi8UnR8AfKrd32EnJ8fXY6J5C0+ZoMzCimltOklcna6yI3iqOsG
    LyL/OWm9T62mz0DzjkioZ30lkzPbOG072cvKx/Y/9IeSor6SrTM5lQDks5dhRy7VHD3x
    /RZAxb9u1Qqkx1rzhKBm3FdlNf2vXObUkttjLCWX44NsiBVox+mKHEz37i3TFP8QTLBj
    tKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379773;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F9rl3sGsvxYu9uIDxZf1Ei5eQdwD714ERFq5snEb+vE=;
    b=GFwXXrxk0F8wb9b3SN3D7MgDWqVQpMB+6mWMfmo9nEcDKBngjD8PymccN1+kKi2rCf
    vJx+a4sS+oppYxoVK0XIeXj/jdZs2M9e7oqa5thGh+uNRHd4uPkvhIWg6f7MGjxGTHva
    Ly5zlil60ApFp+imD/Kxkhhkk9/fIRRwAcxvb9TRaBqqkf2d3lbpkzwTzYf1/0ryPm6J
    WnasVeZjexw4acjtUb/ikVa/gW4qdJv5i5GhFZHxCktYqDF384h96idz8r0E4d1idKcr
    jkjxB+nsvf8c+bki8t2z1oeiDVlLrdy4DeDFBnB2UHyKSvw3zS3r5ytTEMZdI+FKbFEq
    oPdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379773;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F9rl3sGsvxYu9uIDxZf1Ei5eQdwD714ERFq5snEb+vE=;
    b=G6D4A68xi/cgBuTqyUQl1d004B++1Wc6Do5vDDM5oIWjizFK/ZuIx6wt2b/4nXhd7V
    fIi9Dd1lqvBrbhLMK1Flcct5sBRt8AFuyupHixejzGGVpX/ETTgkC/yWvo6SKIE8ICKu
    ZzRp/0BtrlZfjKechX4OCI9upHDat4re1bRJ/wNLQhOkEbBp+VowWGPHaOheGU6gpsUc
    zYc1jlPcBmJkNYecqym6uck4RrGwJw1ZT5HZRUpFNDuOct1DuOHBAXempOnxEa8CBdCb
    MzxQhHalMnMWemz+gN0KGV9O1pPSJ7ne021fqkF+vEASBgQV2q8wLAFdVZZeAJ7fRc6+
    Jkzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379773;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F9rl3sGsvxYu9uIDxZf1Ei5eQdwD714ERFq5snEb+vE=;
    b=voEqFNAG0YmToV145Ik0f8S39WkQMNKCnf96ORJ1YrgbbS7x0OUiGP0vtUiHQ5h6U9
    +1+bollSVGgC86h7kyCA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTXz9J
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:33 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9f-0004OJ-27;
	Sun, 04 May 2025 19:29:31 +0200
Received: (nullmailer pid 243278 invoked by uid 502);
	Sun, 04 May 2025 17:29:31 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 4/6] net: phy: realtek: Group RTL82* macro definitions
Date: Sun,  4 May 2025 19:29:14 +0200
Message-Id: <20250504172916.243185-5-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504172916.243185-1-michael@fossekall.de>
References: <20250504172916.243185-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Group macro definitions by PHY in lexicographic order. Within each PHY
block, definitions are order by page number and then register number.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 72 +++++++++++++-------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ca6d2903b1c9..e01b13a9b5c3 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -18,6 +18,16 @@
 
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
 #define RTL821x_INER				0x12
 #define RTL8211B_INER_INIT			0x6400
 #define RTL8211E_INER_LINK_STATUS		BIT(10)
@@ -30,9 +40,21 @@
 #define RTL821x_PAGE_SELECT			0x1f
 #define RTL821x_SET_EXT_PAGE			0x07
 
+/* RTL8211E extension page 164/0xa4 */
+#define RTL8211E_RGMII_EXT_PAGE			0xa4
+#define RTL8211E_RGMII_DELAY			0x1c
+#define RTL8211E_CTRL_DELAY			BIT(13)
+#define RTL8211E_TX_DELAY			BIT(12)
+#define RTL8211E_RX_DELAY			BIT(11)
+#define RTL8211E_DELAY_MASK			GENMASK(13, 11)
+
 /* RTL8211F PHY configuration */
 #define RTL8211F_PHYCR_PAGE			0xa43
 #define RTL8211F_PHYCR1				0x18
+#define RTL8211F_ALDPS_PLL_OFF			BIT(1)
+#define RTL8211F_ALDPS_ENABLE			BIT(2)
+#define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
+
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
@@ -40,24 +62,6 @@
 #define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
-/* RTL8211F WOL interrupt configuration */
-#define RTL8211F_INTBCR_PAGE			0xd40
-#define RTL8211F_INTBCR				0x16
-#define RTL8211F_INTBCR_INTB_PMEB		BIT(5)
-
-/* RTL8211F WOL settings */
-#define RTL8211F_WOL_SETTINGS_PAGE		0xd8a
-#define RTL8211F_WOL_SETTINGS_EVENTS		16
-#define RTL8211F_WOL_EVENT_MAGIC		BIT(12)
-#define RTL8211F_WOL_SETTINGS_STATUS		17
-#define RTL8211F_WOL_STATUS_RESET		(BIT(15) | 0x1fff)
-
-/* RTL8211F Unique phyiscal and multicast address (WOL) */
-#define RTL8211F_PHYSICAL_ADDR_PAGE		0xd8c
-#define RTL8211F_PHYSICAL_ADDR_WORD0		16
-#define RTL8211F_PHYSICAL_ADDR_WORD1		17
-#define RTL8211F_PHYSICAL_ADDR_WORD2		18
-
 /* RTL8211F LED configuration */
 #define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
@@ -78,25 +82,23 @@
 #define RTL8211F_RXCR				0x15
 #define RTL8211F_RX_DELAY			BIT(3)
 
-#define RTL8211F_ALDPS_PLL_OFF			BIT(1)
-#define RTL8211F_ALDPS_ENABLE			BIT(2)
-#define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
+/* RTL8211F WOL interrupt configuration */
+#define RTL8211F_INTBCR_PAGE			0xd40
+#define RTL8211F_INTBCR				0x16
+#define RTL8211F_INTBCR_INTB_PMEB		BIT(5)
 
-#define RTL8211E_RGMII_EXT_PAGE			0xa4
-#define RTL8211E_RGMII_DELAY			0x1c
-#define RTL8211E_CTRL_DELAY			BIT(13)
-#define RTL8211E_TX_DELAY			BIT(12)
-#define RTL8211E_RX_DELAY			BIT(11)
-#define RTL8211E_DELAY_MASK			GENMASK(13, 11)
+/* RTL8211F WOL settings */
+#define RTL8211F_WOL_SETTINGS_PAGE		0xd8a
+#define RTL8211F_WOL_SETTINGS_EVENTS		16
+#define RTL8211F_WOL_EVENT_MAGIC		BIT(12)
+#define RTL8211F_WOL_SETTINGS_STATUS		17
+#define RTL8211F_WOL_STATUS_RESET		(BIT(15) | 0x1fff)
 
-#define RTL8201F_ISR				0x1e
-#define RTL8201F_ISR_ANERR			BIT(15)
-#define RTL8201F_ISR_DUPLEX			BIT(13)
-#define RTL8201F_ISR_LINK			BIT(11)
-#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
-						 RTL8201F_ISR_DUPLEX | \
-						 RTL8201F_ISR_LINK)
-#define RTL8201F_IER				0x13
+/* RTL8211F Unique phyiscal and multicast address (WOL) */
+#define RTL8211F_PHYSICAL_ADDR_PAGE		0xd8c
+#define RTL8211F_PHYSICAL_ADDR_WORD0		16
+#define RTL8211F_PHYSICAL_ADDR_WORD1		17
+#define RTL8211F_PHYSICAL_ADDR_WORD2		18
 
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
-- 
2.39.5


