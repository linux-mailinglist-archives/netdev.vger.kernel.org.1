Return-Path: <netdev+bounces-181508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7ABA8541B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8154A0883
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABDB27CCCF;
	Fri, 11 Apr 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="QEwNlC26";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="/xucxOZu"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE821EFF9C;
	Fri, 11 Apr 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352866; cv=pass; b=nsoIpIscURmzf6Dj3cJZNJ5pSc0Ye0lpqWE2gDIU06/nT/V3VBDP0I+G7aZ4jqmQMkVwHduFXxkjjO3XVXLX+xZDi1vB+EgmdfgjKu4riY9A9/x1sg2Hd0KjN6SYsYzxKo5suM4NmHBJqR4K1FZer6PWe2J4PVG3kPh0d8VHe6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352866; c=relaxed/simple;
	bh=+K6YHjvkbari11VbJs9ues3NAMomaotXfMS3OiznqhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb6nxim/zeCdclIzNN4PiaFJLMq5718wJHgxNr9VyDh+McA7srSHjKfdLbmZEj4voOXzqzm6l/vcyZb9SOmzppOrgqm9NpK+wSZLf3Od96znUVZryX1tL8PiY+3A4fdX8jt4mBHhntB2ghlb1yO7mVRP/MIji5QrvKVpaCUhJks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=QEwNlC26; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=/xucxOZu; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744352674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZUqjoEZoRVuDdO4CH+VYQhF44yj6oUJwtjOn2fxRDdAlJ+FyHTlnxgVEZLGsh4L4W0
    1npNxGuBJraNYCkiH5IHNNb0HgF3aJtsFL8VsD4kKFXb/84LvIYy8qWgVjO25yVSRj5w
    7tQfMy2OiEAoVak/N9GcN80+WdkZWxE0fdvHQZfSSKP0p1lyiBcO/CZ/i0XNW2UEKqek
    WE5IOnP0HouhxQTFmJsTxRAUuCtdE4WXKtu2c0tMpDXfyEhU08S7tzHHSzxRDUCkky+u
    yTl2xOik9VsDL+egEP1e9QaZKkwCtcOHMB+dC/Dj+CtsqmpQMZynKEpq+uy61WA69o+B
    AYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352674;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tkaNobdjZa50PTheeyfzhzE2mQpO9JIwD7JBFoLI1z8=;
    b=fm0NSHno1URXn6JhgeZogoMhHRdRktFJoLr4YqXrS1O+UlHHaRkL9OpV1MCOpcahfA
    xSDT8P9jmYAbi6x+QeZeDDD/8D+kXIOYwjY7QJz2GNdntaaFp7+VAbIg222k+K4R5kTN
    3Jk/Lhl4UfmYl3BG5JzZpiqMYd5s5zRNqevym2Xmbk2wf/bmw86/HfCF/7CwpkdJCiWX
    bdZkbV+axB7Bj60tIS/SCZltMnr7EJirHrMTWFoEOXcZYygtWxvt4jBZpvZUp50x9CNw
    L0r6vgNu+fSf9xee5Gois71oNdKBMG9RUjRsax2D+816bQN1selbXHHWrKc+dBwAGoR3
    yaKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352674;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tkaNobdjZa50PTheeyfzhzE2mQpO9JIwD7JBFoLI1z8=;
    b=QEwNlC26dexDFcinM5eIx4sk3ny/ke2/0Vr/01zj2nmQ2N05KV+onJkVF56WcdiO3x
    /iYue5KwOhmpa+Rn0VKMOs5UFl/Du9DwlZs2eRm9g33XITuHVcCjtLl8fyPZNSDGp2an
    eDLIiWwqblxWmfVBrWmDXBim5eQ7NF0VEWOOpSjZoJgt/8uzpa8TfkRHj7r9MOtkA6ZH
    D5YrvkzVap0qatdElLNCiIr85U+T7QfmkmMY1Tb1HqYztohopSc4kWw0Lg7Oz/UY2xV4
    ++uCqplTMD6gc1hdsvIAk6vfh2bz2QgVppTs4XcZa8D48FtilIRup1XPUFUy0C8p/Wf3
    iNXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744352674;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tkaNobdjZa50PTheeyfzhzE2mQpO9JIwD7JBFoLI1z8=;
    b=/xucxOZu4EGrd/cHu1M/QGUcQTA5kI4gngiOloo+JMFTotsIIdeQXjlIDbEZ98VE++
    CDTy80Xa+BJHWK7ggsCQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513B6OYHab
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 08:24:34 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u37oX-0000NC-00;
	Fri, 11 Apr 2025 08:24:33 +0200
Received: (nullmailer pid 8883 invoked by uid 502);
	Fri, 11 Apr 2025 06:24:32 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v6 2/4] net: phy: realtek: Clean up RTL8211E ExtPage access
Date: Fri, 11 Apr 2025 08:24:24 +0200
Message-Id: <20250411062426.8820-3-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411062426.8820-1-michael@fossekall.de>
References: <20250411062426.8820-1-michael@fossekall.de>
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
 drivers/net/phy/realtek/realtek_main.c | 40 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index f6e402bf78bf..b06d53867b99 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -38,12 +38,17 @@
 
 #define RTL821x_INSR				0x13
 
-#define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+#define RTL8211E_EXT_PAGE_SELECT		0x1e
+#define RTL8211E_SET_EXT_PAGE			0x07
+
+#define RTL8211E_RGMII_EXT_PAGE			0xa4
+#define RTL8211E_RGMII_DELAY			0x1c
 #define RTL8211E_CTRL_DELAY			BIT(13)
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
+#define RTL8211E_DELAY_MASK			GENMASK(13, 11)
 
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
@@ -136,6 +141,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
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
@@ -608,7 +628,6 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -638,20 +657,9 @@ static int rtl8211e_config_init(struct phy_device *phydev)
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
+	return rtl8211e_modify_ext_page(phydev, RTL8211E_RGMII_EXT_PAGE,
+					RTL8211E_RGMII_DELAY,
+					RTL8211E_DELAY_MASK, val);
 }
 
 static int rtl8211b_suspend(struct phy_device *phydev)
-- 
2.39.5


