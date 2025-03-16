Return-Path: <netdev+bounces-175113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD4A63593
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652633B05E0
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED561A76D4;
	Sun, 16 Mar 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Q/YIa3or";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="67GA7Hlp"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602057DA7F;
	Sun, 16 Mar 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127473; cv=pass; b=SzK4S0WZHeudhuILnG9cch1DJx7qON9q0q3h1lRPP4C/xXzS22yoIGC9GzDXUfgTPKjCukzcMFdCqz7YJIFS6/KTVgfx6Ck/inwd7ktSHN9fM3OyWRJC+HhxxlxQl//f88vXzW3ggOK7OtPUfvP3Z3v7ctFZFjA1e9EXagbxQ7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127473; c=relaxed/simple;
	bh=qUChJ+aBYmQ+npMzTXHcJ03ekKRYC+Suhyhm6YinJTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuTDY+hHsAdZGjFyhtujcckKbBq5zPzRB1HUMYtWIrzZ3Gh051k6gVY6c1LZBa+ziagWEZ0I4sj6u3z3LmRFVNNS5s8/zqT5MgfrKx7jQjvdsIzVsRD5n24SEThMKREkTUS0ZjiHTofATPe3gNoB25f0J9feUcFLviIHbCVS0zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Q/YIa3or; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=67GA7Hlp; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742127286; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GpO4ADHsO7vTVZiNUUdmEGKGYwvW3DdOQQvkOE+PJY2Ce0tYhqwxXBs9ckcI3cSzeN
    62Qqt5Q8ql8HtEAwBkgh/kzRIe3iRAfmXyFcOs3PcVIvTF67pQlODFh1VXnQhkAQ0aU0
    3xfTBIxaZgElNTMrd7fuPEZ9XNE+EIUcSbCpAbQIgcPmLKOLncNJb+ZGHOVyWQx3ydvy
    NFiPlOy2k+Mi0i5PCeb5YRDl7z096nrGDcs7BFFJNl2nRKptr4q5p6uBVDkYRCNjBM/O
    oO0PbbefI89VX0KbqumUTcQU1zy9fxilCPsYeP35t1cMT8i6ocSHf52sIVTVU6iilo1O
    GFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742127286;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KqKMgl4Ov031kF7Dm8975X6DQiD3Jrmf+fsSx/Hz4BQ=;
    b=Vvszp9FiM8MOGCZ2T9LJJg+MUvTOMY0RY3ijNEUrc2BRF+mgfTwJdAMBaK84uqtoqN
    iYdzg5AhwwJOMKRk96zamCtQEk791+SLDvL4FAIqzW4ke2i6jI0vIDg8eKJDKLoPJkkX
    PxwNll0szdA3uCuRDe5L4kBLoBu6Z71kWZD7SP2JcMOH5bCBscITPcbUgeTJ9PNV7vUO
    JhN5Zu2LDVSRTrWZQqt0AHwzk5YSjWkSB2oQlz9tJxWG20qu9Z051Aa1jcExvf2BGmyp
    a6KgTVMsdHhOdgHttuDF3CxvYYOLHsHIBoAKlmKajZzGXF/QW5na7angMIGG2/dEppx9
    R2RA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742127286;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KqKMgl4Ov031kF7Dm8975X6DQiD3Jrmf+fsSx/Hz4BQ=;
    b=Q/YIa3oriZOjRCRe0Jn5Evjl3TBZH7XTsLjpcs6BcF2Bbdi0hLZ26A15lxSVFaqyZk
    gpPBcrYTvMrde6rIePcJbaK/PTGzIjgcCVoY5yHc4GoqeHowzUdOne6WTfUrxPeyDxl+
    y+pTW9k3MLnKjkwd/x8f8vsSwXY3PeyysBgsp2KoqoJ9h4A0tAULUr8VpBZEqs4o1c+9
    KCiIu9enb2Kya8J5T2jjM7aI5sQP9ddbQJ7EMysjB26aBElKze+Dai0GAz1Zf8E2lc1I
    VDpNJdZM42ng8y/Djmy4JioAI8g+Bw3QmL4g4QzKB0RAdtt/RoZe/nmDKq32VHwKcOqd
    zn6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742127286;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KqKMgl4Ov031kF7Dm8975X6DQiD3Jrmf+fsSx/Hz4BQ=;
    b=67GA7Hlpn+qwRC2N1bjQADocumsSea3/C/vjVoTQYQthILKSqFSSg5w1ohjfwLI3+r
    D3BQ6r3rHtsS20ciz0Bw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512GCEk8gt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Mar 2025 13:14:46 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1ttmtB-00061z-0Y;
	Sun, 16 Mar 2025 13:14:45 +0100
Received: (nullmailer pid 82554 invoked by uid 502);
	Sun, 16 Mar 2025 12:14:45 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next,v3,1/2] net: phy: realtek: Clean up RTL8211E ExtPage access
Date: Sun, 16 Mar 2025 13:14:22 +0100
Message-Id: <20250316121424.82511-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316121424.82511-1-michael@fossekall.de>
References: <20250316121424.82511-1-michael@fossekall.de>
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
index 7a0b19d66aca..f4ce6457d0ef 100644
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
+		if (!ret)
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


