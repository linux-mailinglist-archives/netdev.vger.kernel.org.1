Return-Path: <netdev+bounces-127529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294F975AD2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E3C1C224A6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43601BA882;
	Wed, 11 Sep 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="RBJyTk1P"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268B1BA29C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082871; cv=none; b=hcJKA6xETFKGgxOE8fwb8D86r5CibOkbpBH1V4D+pyze1B6pH50qOBxB9tGTldNNa4FuqBxC6g/8cBOXfMVNsaPK9IkAR0PWLtA7kWOFocHNpAxvFsms04j+YZUnG9X4QlXE3pTXUmQADHeS0pkOJmJ3WnmJoHbTPZkJ8d7zNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082871; c=relaxed/simple;
	bh=lUOdI08Vx4SefFAuM+p0mEpSr1iSzuxYiI5fqxsjtzw=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=u5dOjx91474BX9m94emPHAAXYkIMzcPVbD/g/waRKhVMEwncZfwtBUTaZoJf1fchC/Rwbsmw1lP0N6Dl2rDmC+dVNxB9HihHPNF2jkXR03NiyzstxWfGxQwYC2X8PE41EmPhEGghAj6PSYGvIpC4aAlReR3Wx+pMOhs0HvQU4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=RBJyTk1P; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726082854; x=1726687654; i=hfdevel@gmx.net;
	bh=Fv1gg/XEC1jWs8cdC4B0MIL9Lzw5Bj+WFa+gSMVEOoU=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RBJyTk1PT2GluHTNBIfqTnNQXEx1RItRP1ZY5OY85aA2wysE3Qwz+kauzEIngh0Y
	 3W8pvKI+N1ypcfrBxXe86h4WQUyJSh2JRH55zKg9u5Z43RTs4505+f1luchFL8Oy2
	 Xi8kL7wmX2fzYZ5ovOMu+y7Qc/MJxirx2M6F/0YJJ+S+LrcSaYQ1lc0bc1OENrop/
	 21R0aMzix9Q3RTZXxh9ZBLaHSEXU0C8EZLZ/lPqrL+k21vc70sSSqzKXubzjmVm5L
	 mxTV8XJPOaQmJGW04EBe5RkVlJlP4kkRj96dUKjrg/jvXLIcFzelAgmsDYSPAdEAI
	 HMhiqqFAU/wow6H68w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:27:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-da86cb70-f227-403a-be94-6e6a3fd0a0ca-1726082854312@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/5] net: phy: aquantia: search for firmware-name
 in fwnode
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:27:34 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:mrjw6ct8KCO1+iQHGsNmo8OJQ2c9Z7GrnSSdIc0PhpkXotDhVbadIxg+gxNQn0Tcu4l3R
 BSEc6IsF1pMk+xKfK2HxqbzNipLYrqgDHW1nZANvo/EtqRI63VpukUUXV0OOsSOqrL8AIupKp5El
 Ep40gJUeEsqbRogdOulQ7Nk+dL2xp7VYRd26QthzfDL+URVVvhB3KkqLLM2z+qbsYdafoZ2/FmHP
 Kk1AIGfCaCYsykMkarcYFVdKeuJty7btRbmKAsVYTz70gd3cpmYCUlrMCLMxbxNme19N6f4am18+
 U4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TQ1U5C2TOP0=;jJwaKw3sfrn99dXFbkbRLvkC6SJ
 /VZeAVtV92AKJ3KYL9YaccNSLKISt+4fdaWoX9sG77jzsqR4CdTneFXbND8TJ2yg6k6mtkcUh
 YI42SZg7VELuvhuB7Ytt5qmDMl4BGcqrUAEoNZLhksKKq0h8X7LwX6Phr+ABVrtmsuvtxMMWw
 bS6MI/WsTPQYrYdxqeEjlTO7avB8vSx0Jn9R8aoZt2XBEB5cxD5JuYGrOtVvII39/d52Sg+AL
 Xl1reHko6/d4xnyKzhnw4RmjvxOdKCcbMsb7BsWFwX+v1ZwKRl6GablducfryfrBFpDf3C17N
 Wjnqi5RjZHmN5xucckM4XMhoJ3xzp8ssrrFlqVZ9StBk4E0acOFQshZfWAJUdpCDagNcPlreG
 h8fRtIwDUzKyHjywYtzNZGAf0fL2imBHjfm0AmQFzyJ2gcnu0b6Q2w4BBm88SpIGpdwahfR/9
 +7LbQxxNyEXtEaf1dCQHmpafcEGO8rLEUatltuHVCvIsL6LbdKHBwUenf3iTBj42J4+3avhIi
 QAi9cqTEO1eqWmjCBsgHMJ28/jAaOptelD/RhoPoKMx2U2xtBhbXGe1p6i3rpDPEnvx2wmpDy
 8nxu7gSvn1cEKXo5ioX/v5u/mPumO1ogMmiRQJZldz1c0/6akztq5bs/L+b3+KlTcvvj8nHTH
 64KkZShEEGjnKZXud9CJetwxNWa9Ms7fP6Ppu4wzIw==
Content-Transfer-Encoding: quoted-printable

For loading of a firmware file over the filesystem, and
if the system is non-device-tree, try finding firmware-name from the softw=
are
node (or: fwnode) of the mdio device. This software node may have been
provided by the MAC or MDIO driver.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/phy/aquantia/aquantia_firmware.c | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/ph=
y/aquantia/aquantia_firmware.c
index 090fcc9a3413..f6154f815d72 100644
=2D-- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -324,14 +324,37 @@ static int aqr_firmware_load_nvmem(struct phy_device=
 *phydev)
 static int aqr_firmware_load_fs(struct phy_device *phydev)
 {
 	struct device *dev =3D &phydev->mdio.dev;
+	struct fwnode_handle *fw_node;
 	const struct firmware *fw;
 	const char *fw_name;
+	u32 phy_id;
 	int ret;

 	ret =3D of_property_read_string(dev->of_node, "firmware-name",
 				      &fw_name);
-	if (ret)
+	/* check if there is an fwnode connected to mdio */
+	if (ret && dev->parent->fwnode) {
+		fw_node =3D fwnode_get_phy_node(dev->parent->fwnode);
+		if (fw_node) {
+			ret =3D fwnode_get_phy_id(fw_node, &phy_id);
+			if (ret)
+				goto cleanup_fwnode;
+			phy_id &=3D phydev->drv->phy_id_mask;
+			if (phy_id !=3D (phydev->drv->phy_id &
+				       phydev->drv->phy_id_mask))
+				goto cleanup_fwnode;
+
+			ret =3D fwnode_property_read_string(fw_node,
+							  "firmware-name",
+							  &fw_name);
+		}
+cleanup_fwnode:
+		fwnode_handle_put(fw_node);
+	}
+	if (ret) {
+		phydev_err(phydev, "failed to read firmware name: %d\n", ret);
 		return ret;
+	}

 	ret =3D request_firmware(&fw, fw_name, dev);
 	if (ret) {
=2D-
2.45.2


