Return-Path: <netdev+bounces-187650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68980AA889F
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8938C3B73EA
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB61F9F51;
	Sun,  4 May 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="R5JY5B7b";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="tB698JQP"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0381EFFB9;
	Sun,  4 May 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379961; cv=pass; b=jbyiNLYp9LJrTMlbaLC4DrVp6Xlgi+UfSlDaMzQlZVPVm6GXpFv7iYmRBZQtqMYSTV8Bh4IDi5egfUHDhfET3F3XGEtTyLpgmwrcZmjZbYQy6lcBM0JJB4UH19TAesXbwN+2uyylrpgEgwiFXlU2lXt7CvPWLg0tFfnK7cUKglg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379961; c=relaxed/simple;
	bh=lZrcURQp3hFYZcQF2RUCCJd01uEC7fp2q7+yTxbCikA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNOzEF6BMHyoMhgTqww0YXRcbokLCQPtiPmiahMkeHUMFEwl8CMiBa9ejgP5JVseQIvAG2CZ837ZKShJYN4rg7Q53sGNmOmP7m9nRbSenpczbNO2ajLA62KUjVBPNPgjtBZ0FPYtwEgH3KXPNlVrv2VF54MHFJxzuSOCziRE3Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=R5JY5B7b; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=tB698JQP; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379772; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oucz0ipkaTUbNAfBp5SWb7N71WU7PZuGfAzAcPtESLCkjD45ykAtlTFzmMt9a2eXXj
    Gxb+Y1svZpGez81lNS3vaceC0TDZ+IKEtpdTXJ+qGFcbkdbIe3fXIt/pN1uvJhqc6wHP
    MeAx6rAtO3Pszcon8Eki8nu2l5DUJelh+K4y1+75XaXgszXpe1K/EO3yCnrMn21xsT3C
    l2JSUggOvg5YzRCERBev3bhiaBldQYfPQb86yf3TTIF/awCjE1lD3dxKbDJq4rAeswxS
    Lsttnpq8gEbIXnDUBMKGMqakQPVpFmz5eYg3PZH5OSIJImN0ZPLkVJ5gPgwwCUlMQu2h
    orBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4gn5mtjL0evEuszrzHHSPLmxmhO1acntVa5VhV3cvOU=;
    b=oVziW4m8En44zetcHo1wlDpT9AfK+E0zzcKImsBFseiVwcxTnUrgqo9+TzVuANbVT8
    BoY2+VNbdrtZhPcuUAp33kjov4Y9gnvCtBFfbQMMlQ1XvWg5sCIUnFB0dBSrOjDLoltv
    YuHgOrk62jA0y59kNFG0chCQeKB/6f7IixyKHekytul/p/hDWzlUt0SIExfzPNcsFtBt
    8ygm+HN0nxppLigAt7Oa7cS6urPb0x5DC9V5M320zGz3FleRZovif+xwbev0vAPCm+Lq
    Na+fWhVmIZv8a3zf8v7f0a4rzKrtPNG2QWcVtrLxL0NbbIP5+OunqhcSAEvaa/K5JlzO
    0CPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4gn5mtjL0evEuszrzHHSPLmxmhO1acntVa5VhV3cvOU=;
    b=R5JY5B7bpguq5kw3AQc8zsUPqYDtw8kQ50q4zu5Y1H1SDSU1EmOXdpEWX8U22ROPN7
    Gc7QEeOBuzE1yXGxpPrF6yknROjqXRNfuUTgDt/wOy1aDfx45pm56z4weMSLRREjOOLn
    qIDfGImQBfeoOPpDpFlj8NH33SOyPlKIHLTfr5bAdk2D1vWUj00r8HM84aPObH8QUsML
    75AkNaVePTFmJF9G0WjgNeIdiMox5z0rOE70dbmN1uojtT+oPg39vUuWt28+AFzqP581
    qElio1PyuRVrCbCTdTr/YdCNdp5DIB1vH+CxUupdTV3N4EZxJmjNzT440yB4pu4EtGOW
    KQrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379772;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4gn5mtjL0evEuszrzHHSPLmxmhO1acntVa5VhV3cvOU=;
    b=tB698JQPgvc5UhJjEThUrdW5/xRFUbxR04N8CHuD/MGyBIcQ8qjl6g5pujtHk6/R/W
    Og0O69Qr2FSVlZyoWSDw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTWz9H
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:32 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9e-0004Nc-10;
	Sun, 04 May 2025 19:29:30 +0200
Received: (nullmailer pid 243250 invoked by uid 502);
	Sun, 04 May 2025 17:29:30 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 2/6] net: phy: realtek: Clean up RTL821x ExtPage access
Date: Sun,  4 May 2025 19:29:12 +0200
Message-Id: <20250504172916.243185-3-michael@fossekall.de>
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

Factor out RTL8211E extension page access code to
rtl821x_modify_ext_page() and clean up rtl8211e_config_init()

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 38 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index a6d21dfb1073..0f005a449719 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -26,7 +26,9 @@
 #define RTL821x_INSR				0x13
 
 #define RTL821x_EXT_PAGE_SELECT			0x1e
+
 #define RTL821x_PAGE_SELECT			0x1f
+#define RTL821x_SET_EXT_PAGE			0x07
 
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
@@ -69,9 +71,12 @@
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
 #define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
 
+#define RTL8211E_RGMII_EXT_PAGE			0xa4
+#define RTL8211E_RGMII_DELAY			0x1c
 #define RTL8211E_CTRL_DELAY			BIT(13)
 #define RTL8211E_TX_DELAY			BIT(12)
 #define RTL8211E_RX_DELAY			BIT(11)
+#define RTL8211E_DELAY_MASK			GENMASK(13, 11)
 
 #define RTL8201F_ISR				0x1e
 #define RTL8201F_ISR_ANERR			BIT(15)
@@ -151,6 +156,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
+				   u32 regnum, u16 mask, u16 set)
+{
+	int oldpage, ret = 0;
+
+	oldpage = phy_select_page(phydev, RTL821x_SET_EXT_PAGE);
+	if (oldpage >= 0) {
+		ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, ext_page);
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
@@ -670,7 +690,6 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -700,20 +719,9 @@ static int rtl8211e_config_init(struct phy_device *phydev)
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
+	return rtl821x_modify_ext_page(phydev, RTL8211E_RGMII_EXT_PAGE,
+				       RTL8211E_RGMII_DELAY,
+				       RTL8211E_DELAY_MASK, val);
 }
 
 static int rtl8211b_suspend(struct phy_device *phydev)
-- 
2.39.5


