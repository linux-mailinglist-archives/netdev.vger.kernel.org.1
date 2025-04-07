Return-Path: <netdev+bounces-179851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEFBA7EBDD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2894018958CD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A625D539;
	Mon,  7 Apr 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="RQu2kvlx";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="dXCj3elT"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78827257D;
	Mon,  7 Apr 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050512; cv=pass; b=R7rFcFe2C6zxQka8+IbVN9QF+Qo2cOvcLSgZvmJwneHtZ0ZRSVQ3V/zVnEoXhvt64k0WPHdM+BniAhsRUaJELyB/kQl3H33TGGzmzaFk5DnWW/2xhpK8jxYrfc9QHcNbxwlZ0bZo0KYsZagq79IWz+9tRkewMflqxt/AJDKz6mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050512; c=relaxed/simple;
	bh=U/3mjJa7+vRHonlRAAZfA88e/j7vMnEK9dHvRxvTqMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwzvNry88lI3G0BDnI8o4DpExLE4J1pI7XFrrlqNTf/FYchs7Sy36P2hVec/czHKjc+GLDbx7xY2Umw4mGoHQFIvTA+eOXDQ2CJ6k/NNitUAswik9eA5GgJfgWMVze3U6DuH5zjdpSy1Fx3xJl5NipzXuCEk0rbig3XXrrs9ccc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=RQu2kvlx; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=dXCj3elT; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744050144; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wv4Xiy4oMg6Lgcd/bbuQKd5EdE/tTxrLqRiJWua6iu3lok0RMzO8xemCGp8d3x5D7H
    EgV72M5f7sCHqj2SU8wv31sD8iESFyDzpyjFzo17VP2wnQ8QyVi2sBHaPa84ayw3bcby
    bVvVqp//YRGgrWbzFkxDRSK3Q1faGBUjLNaJDyEu7wyGNC83BvBYVAtuoYf+pCNRaKEy
    ZWNBb2c90l9nLgDci7yTK/8hmobbmulygf/NMOzwRURs4C8pHTfG5ohtEH1pQNAmpEfs
    by70YfOE6ljgTqz3FailwMTZtSPAQorlNKXsLPG3QHN9jgf50Wctx8oqo+Me2o+G13Zx
    6dGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050144;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=CrKfY5ZVABxKLyOKnchmOergPPZIMNUMCkfOmxY/a1rSAB3SyIXsjuPSfTZMti1ZCm
    AgM8dSTKmQYByFEV5k089bLIHKNtVkLSLHLxXyGJKfIgHVX4C4+Jk/pAwBs8YMTY3Sib
    rOUpL6GGXO/4X77KaZV3TEs3XFC+Z+kViThfmQUBCKOJPBI08byF3lrjOu4xmiRmM3OK
    a/MuHoV5x7pVVuos2zkiFLUFb9/8xzMz0+4e8Pc5kwCHZsd9oKI76gbVfPqdppspXHyG
    buTdWV64nQMehHWzZOAzWtVQerxMrjNSX3zRLDK3DK9OCPyOxAq/yE55rwg4Gd9LKSHx
    siVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050144;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=RQu2kvlxcPguqO2mk2waw54WMS3k1Kaq0aYIq+pvjcpzmwUpHmKYsT/PcNOs/KGKrQ
    i6H8G2ewlZJyxkHyzSRA+UAYPMmZQBm9K1SCAkRMC4n3lCzanFKFebR37nZJVGGNoqG/
    WGm5xlCdaJuJKnWHQQSNlwLNQzlsSoip3PAneGxqU2J6I3GsSjS8zZ6aIv5JylF2J8pD
    ylxFbLHaYs8YLMWnR62MlVQ51HJavZSSB3G3aZee/J+pR3E5jnAhV4LrJVJHWhYtyfdr
    CtVXLThq2qsPdkK8OZPWPbObeKne2LsSXVE5NsG1l0+aDNeK1v5L1iMYj4uiIaKZm4OL
    TcDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744050144;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=dXCj3elTgekOpOyn+6yUAQQDElbGVaDjyLe0a+E6EZ7aR6SByifnadlaWkZC4SkhGh
    c70/6HTzrF5lk33NZkCg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35137IMOyOq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 20:22:24 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u1r71-0003y8-1a;
	Mon, 07 Apr 2025 20:22:23 +0200
Received: (nullmailer pid 15050 invoked by uid 502);
	Mon, 07 Apr 2025 18:22:23 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND net-next v5 2/4] net: phy: realtek: Clean up RTL8211E  ExtPage access
Date: Mon,  7 Apr 2025 20:21:41 +0200
Message-Id: <20250407182155.14925-3-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407182155.14925-1-michael@fossekall.de>
References: <20250407182155.14925-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

- Factor out RTL8211E extension page access code to
  rtl8211e_modify_ext_page() and clean up rtl8211e_config_init()

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 38 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index b27c0f995e56..e60c18551a4e 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -37,9 +37,11 @@
 
 #define RTL821x_INSR				0x13
 
-#define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+#define RTL8211E_EXT_PAGE_SELECT		0x1e
+#define RTL8211E_SET_EXT_PAGE			0x07
+
 #define RTL8211E_CTRL_DELAY			BIT(13)
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
@@ -135,6 +137,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
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
@@ -607,7 +624,9 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
+	const u16 delay_mask = RTL8211E_CTRL_DELAY |
+			       RTL8211E_TX_DELAY |
+			       RTL8211E_RX_DELAY;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -637,20 +656,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
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


