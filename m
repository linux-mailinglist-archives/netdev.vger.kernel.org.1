Return-Path: <netdev+bounces-175434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D958A65EB0
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2871883C37
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AD1D5ADA;
	Mon, 17 Mar 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Cac2+CLl";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="7iLd6Nzb"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1579E1;
	Mon, 17 Mar 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241944; cv=pass; b=M+JdsfHsgkb4U1sR8EBT2SXpAaX403jttp1VvdJFXB/yHIYuNBo/plLePlW+xE8PzxouEkZBtf1uZ7FhTsiFQ6nX25dczFWlYRnzUarl632ZIbBZH6s9iyrn0ai1MUyu06N3fjAiSPXYd0xUzeML5AUCWaWfV1uQkY/77axfA6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241944; c=relaxed/simple;
	bh=U6GrnPSi2yFmpgTKSdcqG84giw5n2Hxx/Ub9Os6ddrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCH5L9mUROQdYhjZL8iY3+twlrww5i1oDMuHdO0Mt0ebxVOlgv85v0ghbgxJGtzXKqaPLZkBht0v6DAuOYu2Qohj0BRoYfo0WpUi278VwV2ChZQL5hxcA/C2QGojMwX4nJaD6VdX/wXLd6qA6D+8+/csHN5R3j1Oza8qluH4eGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Cac2+CLl; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=7iLd6Nzb; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742241939; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iMaN/0r9fiKsQjO4zTbmKe41l7f7uYypplty658bV7ICObCTk765thwPK3NarMsrvU
    gm+wzAUVxhZqNwcH6R0PQ8F4CuWtnszhSWFyspZ33TShFOCQLsjsTAV23BmCD5g1Jj7m
    IC31BMIe/orZZ0M7NaVc78AAlDbls78DKb4gnUCtMLCxdK/GzQFQ+3SAtPFNJFtuLI8q
    /KGPt+sGC20aMHo3KD6FqrsextiVDxKoarGQ+vibDtYArNTjJYs4ercUTHVsE1IObf+x
    P5k8BdJmHPT1WFJVta0sWWvGmtNP5G0yy4Hk9JKdOHN5ET+umnVhG5GxUO6yOtNa5KZV
    mpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241939;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3kkBE2FADa1BSfO/iHOVTvgNaF7Wi7L3lOA9hYb6Sxg=;
    b=LAmQMt9GD2imJ5RQRFZ6hErwewcLTxQmgc6FYojsj2A/5wmrAuCBfv3H/OIMAzKQRr
    VpqgSguT9ZgC+GvhoA3Mqn7u36vXOPx0FgGUIGs3HkPMvlTCwkP1OAsoFzPDlEwonDj2
    o032h/btULbxojf6DxECckCZKVCi7bCGr6gLUqUfJEFRqiJBLdpHjcDzFQL9jTGQmR5R
    8eF40EcxX8gXdxSOIg/2mawHakCf/9KZR4s9W4Dhqns/4iwFYlAqurzfPKoZ3QEHHG6t
    h2GXQtpbhpMOz5iG6/ct+REL3EqriJ2s1StzygdFDIpZsHnrotid+tIMxGwUzNOFeSMf
    tFqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241939;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3kkBE2FADa1BSfO/iHOVTvgNaF7Wi7L3lOA9hYb6Sxg=;
    b=Cac2+CLlV+INs33cHUh4EGOzAZyXQgxW5ea5i1pFGu4zsQKM1sVVHb1f7NUimHeoIy
    UqcbRi0kuzQWjY6/LkrrCE6XorXe6aGfeRFFt19lF5r3//jrzu5yn+3mUk8spZ80lNvc
    Rg1TIXPptcdDMZQqSMeZKa8Rf6Wz6dAPIwbeSy5ZTdKyBjyoeKgCXxEoDmcwuuQYAbOh
    VJaIeHyJfJ47wiO9EciALFrocRZ1H5kxOq7SKlTgqJ+Ko7zPonT8t4tf1HefGMHxNIBw
    naZVP4x2R3AwcgB0o+ANGlBSmftvNT5bPyQzVdZnJk3gC8OFK01t/LG0P15IWvyek4hg
    wREg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742241939;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3kkBE2FADa1BSfO/iHOVTvgNaF7Wi7L3lOA9hYb6Sxg=;
    b=7iLd6Nzb9gOrTv5iwwKfJoTyI5Lsunwwxt+GZUC6WeHSOv7k6zQPDpUMrjef+IujnL
    BpVNJIupFdVgYQ5+0/Aw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512HK5cFzz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 21:05:38 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tuGiN-00085O-1C;
	Mon, 17 Mar 2025 21:05:35 +0100
Received: (nullmailer pid 93665 invoked by uid 502);
	Mon, 17 Mar 2025 20:05:35 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v4 1/3] net: phy: realtek: Clean up RTL8211E ExtPage access
Date: Mon, 17 Mar 2025 21:05:30 +0100
Message-Id: <20250317200532.93620-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317200532.93620-1-michael@fossekall.de>
References: <20250317200532.93620-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

- Factor out RTL8211E extension page access code to
  rtl8211e_modify_ext_page()/rtl8211e_read_ext_page() and add some
  related #define:s
- Group RTL8211E_* and RTL8211F_* #define:s
- Clean up rtl8211e_config_init()

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 49 ++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 7a0b19d66aca..58ec16cc8061 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -28,13 +28,21 @@
 
 #define RTL821x_INSR				0x13
 
-#define RTL821x_EXT_PAGE_SELECT			0x1e
+#define RTL8211E_EXT_PAGE_SELECT		0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+#define RTL8211E_SET_EXT_PAGE			0x07
+
+#define RTL8211E_CTRL_DELAY			BIT(13)
+#define RTL8211E_TX_DELAY			BIT(12)
+#define RTL8211E_RX_DELAY			BIT(11)
+
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_INSR				0x1d
 
+#define RTL8211F_CLKOUT_EN			BIT(0)
+
 #define RTL8211F_LEDCR				0x10
 #define RTL8211F_LEDCR_MODE			BIT(15)
 #define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
@@ -51,12 +59,6 @@
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
 #define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
 
-#define RTL8211E_CTRL_DELAY			BIT(13)
-#define RTL8211E_TX_DELAY			BIT(12)
-#define RTL8211E_RX_DELAY			BIT(11)
-
-#define RTL8211F_CLKOUT_EN			BIT(0)
-
 #define RTL8201F_ISR				0x1e
 #define RTL8201F_ISR_ANERR			BIT(15)
 #define RTL8201F_ISR_DUPLEX			BIT(13)
@@ -134,6 +136,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
+				    u32 regnum, u16 mask, u16 set)
+{
+	int oldpage, ret = 0;
+
+	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
+	if (oldpage >= 0) {
+		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
+		if (ret == 0)
+			ret = __phy_modify(phydev, regnum, mask, set);
+	}
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -600,7 +617,8 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
+	const u16 delay_mask = RTL8211E_CTRL_DELAY |
+		RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -630,20 +648,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
 	 * 12 = RX Delay, 11 = TX Delay
 	 * 10:0 = Test && debug settings reserved by realtek
 	 */
-	oldpage = phy_select_page(phydev, 0x7);
-	if (oldpage < 0)
-		goto err_restore_page;
-
-	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
-	if (ret)
-		goto err_restore_page;
-
-	ret = __phy_modify(phydev, 0x1c, RTL8211E_CTRL_DELAY
-			   | RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
-			   val);
-
-err_restore_page:
-	return phy_restore_page(phydev, oldpage, ret);
+	return rtl8211e_modify_ext_page(phydev, 0xa4, 0x1c, delay_mask, val);
 }
 
 static int rtl8211b_suspend(struct phy_device *phydev)
-- 
2.39.5


