Return-Path: <netdev+bounces-177846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978DA720BC
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C59172FDA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49B25B678;
	Wed, 26 Mar 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="VCGSD6Cz";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="KtvvhQWT"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32B24EF7C;
	Wed, 26 Mar 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024282; cv=pass; b=fBDtsAXvsxLYV74B1T/iGEHg7pEoqfG5xl/By4n+Klp+NjnEMgRAH88hm6vElXt74CgffBR0VgnTM7wSgutv9d1YCQLDNKr2zYgAWx9zs/GKcqIe81waz3RoFXBgWVij5oV5wIiAzOPpVD5kb4pHe43tNsMU5ouBkJIA4amgU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024282; c=relaxed/simple;
	bh=U/3mjJa7+vRHonlRAAZfA88e/j7vMnEK9dHvRxvTqMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwhzSXwR71rgNf0U1xeOU+iQXbkDEe4J7CrWY/sSxrMTXWRJZsGjz77NSUBqKgLGR/Z1Gr3QE9A4GTi3AxfLVPDxMzPD1rO3Pibw/PSkeP5WnhJNzVAna1+Qz80uJ53G2i50BNax8koPkH3QT/ffFC6IiJ16ctXrfLQDP76plSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=VCGSD6Cz; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=KtvvhQWT; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1743024093; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XaZHl9z85Fxzptv/bmPKYvI80a1dd/aR4c+a2Kq1vN9cyhr1lM2bbmlNJ/W0eSR0Lr
    a3y/3TXK4cb+fhjqJTCG5ndeJtM/Kf8CHTd7tGwONwhBC70eaP0bb8iYbm3uyUbxZsDL
    zKvDruCl49KCwteunNpicFwNytf9dTzH3lkJjfcvjVEyWNxrS0MZbUn9jNzwscOzGwmg
    XcJDybHMoXGMWCUsPDptGn7VGTXwBeOPyRkw+FawUhN2f8nWdNfO0gEfoXEgwr16ZUYs
    uP5kxXO9V3iJHMrmA1CzgATS0u7QvXYfKlGIto81Ru5b4PA6M6PI2Ag8nHfXbgfOSGo/
    B0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024093;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=tyJbQxf95lhnK8YXsL7il8g5JQZGiqcLlSC+FE3RrgK9Nz5a2/e+NDdbQWXgA1PZ0S
    9to9sOqO8iXcou9vDtK2MpITnyYhpYw3VJDVXIfJ2rWeGXFDR0peuX6QNCw2JJz6C2bY
    asJ+3ntBTPwyB/yvHAUh2cAG2Uw14MDeV0kwm5Cne7M4gIrziX32mLTpwj3G+VUfnWSP
    CU8aRizVE7ewQP4QDSxiUpD5/im0uN869nePRvz73GgJPi2t5VyEUpjXWBv2+VWY4ruG
    nDqdXX6ZSSpUOmyz6pxKQAlV5uzWG5LuLJjDKVtN+uVa8oMtpbGIzXvRkIgXl0itR3a0
    r8Mw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024093;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=VCGSD6CzNO+mHwgx9gqwfDNAQcSLAlmCKLLU2Vg+PWmxIKdaOxPq68r2qYigzSW/zr
    L9h3ctqhZorsa2eBh0tV3PVavDPc4bSYgKWVZJqbfoBIBjT6J2AYzm4tQ7VpVmv5GNas
    szS9403qmaqTqBZNEo/dW/kjL0p9atL97Fn8fNYr4w2slxoH+QjMDb/9SPFQxugKWlmn
    xTrlPwVABaIx9nlS29BPs2qutelf/rkzTzzG38Xe07kzivvZJBEOFNpiXGBbJizgqp3m
    rh6eYc4+Vio/l3Xn8IAudnm/rn7babPdhepII57igP1vUHqfsC5Hv2Ftf++qiPKGQvR6
    qJ3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743024093;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4WusYsCr3PnM/I7INx3XdhXuW9evRki5Ti1YpCs2K0Y=;
    b=KtvvhQWTQMYcBATaPFLVAR3O5A63pKNethE4nvrMjezmJloeJo1r1q8c7c3fLp6gV7
    a/m9NBEJbRRXTE8uCuDQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512QLLX1Hz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Mar 2025 22:21:33 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1txYBn-0000iF-2R;
	Wed, 26 Mar 2025 22:21:31 +0100
Received: (nullmailer pid 100282 invoked by uid 502);
	Wed, 26 Mar 2025 21:21:31 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v5 2/4] net: phy: realtek: Clean up RTL8211E ExtPage access
Date: Wed, 26 Mar 2025 22:21:23 +0100
Message-Id: <20250326212125.100218-3-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326212125.100218-1-michael@fossekall.de>
References: <20250326212125.100218-1-michael@fossekall.de>
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


