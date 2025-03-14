Return-Path: <netdev+bounces-174845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60880A60FAF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D6517E24E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C931FCFEF;
	Fri, 14 Mar 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="XUdn0MCw";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="DnafzTJg"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D0145A11;
	Fri, 14 Mar 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951008; cv=pass; b=RWqfZMDJLcoPQ0NskJfp81oqVtn3ufSvCFPS0Nxwj8WWaCpTYkzL1zhSYJN+SC8AddvzvbcRYTR5BcTQR9WhZz6Fmg07I1MMiZYGbP+bCHZN98f6v74VB9dJgbF9j2uJ5VFyGU+HSbPuLnwBuSjwsW+8tXDXB6GRGkk2Hn+Q3Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951008; c=relaxed/simple;
	bh=+PYcjoktx+DO0SoHiLHxaPx4ZqFF55Gbww8pYaq+hjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM04zTBqy9JOXVAyJFDil7oilwaq30/thhAkY3JdOa8GelJxOHYjOgxVUApEIikhlzCEAfnFlBbBGTqBcvUNPqrVZYjZPODYjQPzRowFLIhNPAqFRx9UAQfQVWRLaixeKLoscxdlPws28ueuz96f8e4aVOHLHf7V3XdDFGjoF1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=XUdn0MCw; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=DnafzTJg; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1741950995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eXHGtXE/ff+F805gvtKsj9CXfYfMen9brdT0hPg8heG+sMyq4pOLCl8sjZLhuJa8P2
    LaqKassDTL0iSzYOLAWeKpsyt74eEwtmzOJbeQ9jhjcL8Uw1L/bWseS6n7+o0aDw+08G
    lWMqXUw0R6nlIxyo+XRanD/1S7iBAklHmEpExP+zGAyIrLfZnXziqPvWgE4Ju2WhcK9C
    qN02BMxP5LASd80W7c0qIjdayy6WwpNKX/HQCQL1Oh1iB97qBp/keNZnPU1mkE/U7WOT
    PypZmvtblCMAb8V7045eAlRjmvufzZEJ0pIiwV2SJV8FvaONy7MPRqPCI+P8QZmfuViO
    efPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741950995;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6M2eNNuf6vg09XfgE6JMubfeiWpsxsqRMl05u87rSw=;
    b=bW0zpu3hEvA7weLr3r60RPZutwa6MSwRuw+GUsLCCAPUQnswBz1v3AviAvGntkSnv5
    Kgv3kQ5AFhDrRG3cfU4eDPswfNoFMWz7p980ZPVL15QUu88zZpqU/yk1qac73o+7u6dv
    vQd23grq4DWhNqg0z5odEBajU2UpEdP1hphXncNXZBpshJQDvrtfLQN7N0bhmhoKquCS
    k0Xy/+IV20Ogqt5MTpy/H0vsRrDlgFcuHAHH6GTMv2gTHhcrX5aPlaO2yVIdPlLvkVvS
    v2gQ6Z4P/4cm4QcKmvLpvPr8MraZKKYGtlJz8ae/8jfktzNmmfXdJXDMAuVj8FeELwfa
    6gIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741950995;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6M2eNNuf6vg09XfgE6JMubfeiWpsxsqRMl05u87rSw=;
    b=XUdn0MCwGZn4sGm0jzvSHg042uYr6jlbmvLROAtkYPy4IunxTfZ5ZQp7fRo/P6N/Ch
    1KXLLvv70wJXFU+t3HDMZtfmsa/hwDh8C3f8ajPc7K9sH1NTuMpIJs/CSqCmccATTF3j
    b91ZA3g3T4YuNTknG5wYMS8s9LaAyX0pEF4Cs0VpGhgYVCAw8sQcoYhczVLSWYl88Fjw
    uC1uIYpdJqpze917QTiylfrjbFpYDPzlGOBSA7XR7Bkp+wwv9WkEC5o9ahFTkstSTPeQ
    xtZUjltlPU4X3Saevfjo2jcjd0HT61IC4WtdKpOee5jCzVr1eWCRA2sWKOJA5s8d8sLw
    uIng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741950995;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F6M2eNNuf6vg09XfgE6JMubfeiWpsxsqRMl05u87rSw=;
    b=DnafzTJgZC0CBL3XSSAxk6diwTF9tGPQAlQ68WdNJXtqSqaJf2DpNNCRDPz6KuUpx8
    uNEJajldD4VdefU3L+CQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512EBGZts4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Mar 2025 12:16:35 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tt31m-0000Id-00;
	Fri, 14 Mar 2025 12:16:34 +0100
Received: (nullmailer pid 84461 invoked by uid 502);
	Fri, 14 Mar 2025 11:16:33 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next,v2,1/2] net: phy: realtek: Clean up RTL8211E ExtPage access
Date: Fri, 14 Mar 2025 12:15:44 +0100
Message-Id: <20250314111545.84350-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314111545.84350-1-michael@fossekall.de>
References: <20250314111545.84350-1-michael@fossekall.de>
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
 drivers/net/phy/realtek/realtek_main.c | 64 +++++++++++++++++---------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 7a0b19d66aca..abea2291b0f4 100644
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
@@ -134,6 +136,36 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
 }
 
+static int rtl8211e_read_ext_page(struct phy_device *phydev, u16 ext_page,
+				  u32 regnum)
+{
+	int oldpage, ret = 0;
+
+	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
+	if (oldpage >= 0) {
+		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
+		if (!ret)
+			ret = __phy_read(phydev, regnum);
+	}
+
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
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
@@ -600,7 +632,8 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static int rtl8211e_config_init(struct phy_device *phydev)
 {
-	int ret = 0, oldpage;
+	const u16 delay_mask = RTL8211E_CTRL_DELAY |
+		RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
 	u16 val;
 
 	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
@@ -630,20 +663,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
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


