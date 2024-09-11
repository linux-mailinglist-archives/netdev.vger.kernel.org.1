Return-Path: <netdev+bounces-127527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F717975ACC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FD21F23767
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18221BA291;
	Wed, 11 Sep 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="AcncK/Ey"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EB1BA26C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082443; cv=none; b=awshh0aOXLTOrbfsxTAe5dSX4gjTDEpm+UODDij0qi7B4Yas9ifQwZW+PdFf5oRWDmyyaMbIq0Cf2z1gi3Zz/E7+yj3+Ew0O97Gyvui3z04wDXZWT/lQQxw2rCT5ilUKVZZk35yW5q4Umjq5h7YPvO5NaoEXFtq71lv4xRi2VxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082443; c=relaxed/simple;
	bh=17+oqs+YPZ09Gz/uELJ4TqyCi1fPXYhH5b+1eyfecck=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=P6JzOBwxIpQbjKuQXpNq34lDuJFWFyPTicN65epdgSxSu0xPTrXhbY00eTe1vlaBIuLMNDdNXxI+nZBbMjetTqMRQPKyF8czY0+h6EKczah3OQhWXkNQXiMlCmbo986MODCEMbKnyU9tV3XksRjUq55pIEcbwkMTpuJ802v+oUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=AcncK/Ey; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726082420; x=1726687220; i=hfdevel@gmx.net;
	bh=QXH6pChaI3gjNezksD2qXQA8L9JmPM8LZed8pHslnH0=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AcncK/EyAz63tubdQxhlr93D/t8XFqSd8DwEtrxUDYHdIJKIOXmEotXhwtUP0NhJ
	 LYDV2TZ2wbsKv1/0VV5APN0+gn5KuetYGszPqj94NL7h18JOTdLxbC56JVHUAulFk
	 NDsxPuoLN5RhrpXJ0r5tZEo5zZRLhapW+XjkMUcr33Hzvu6st1vIWoKpTJADVR0lv
	 PcpPxdKT3U0GYT8CfIqcGU0RgGlRR4NS6z0NUEM4VE8ek8vmwWffn0YzwCySgNNCF
	 K+o/OhZQXz1aKCMiQnbqCdgduc4vIjTndG5cy7psOrqzi0LYT4tNRadB64mkT0TR2
	 k2rm2NQkLxLWumLoKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:20:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-34ac707f-7eaf-483c-b584-52b871aea775-1726082420186@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/5] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:20:20 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:9s1Yz162xvNpIJqlfYiAQqOnk2dsOaSDseM0fU8e2/sH02CWcZXxjG6xG0r9mkanQlk51
 CYpa8QZ+0dakd8oLRXHDv2DdlC02xk+hvVHo+/gdwNKN4lpVX96oN2AZrwciCna78Y8lzVDBZCFE
 vhRPq1ZjtbBZaqWCXaeOLLPaWynokr7OzkUkPxDBvpWd+JgBaQjhpySoQcX1aalSqySeaDrAvj2N
 h8Lj3qWQHBbu9XK+bwqgIWRIEVmeV2t1MmU1eZNt+cuSHMPIFG97Ck2K4pNlWNl/c3GhKcdiJDN+
 Xg=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UbxCvXVH+x4=;yCNtB2LfyZfyAK8NMwZpyDh0/CJ
 QE1LHxMIByWRj8zg7lEWSpNzW2bf+W2tsUG7elTSqcpwT7uFN3Ce7kNURF+2xJRpjfm2J4AtO
 bLTAeUe5FUDQNk375HGdnRm7nPnR71Y63L7zAp0LKfD2k/MQEWUBSKjYzY21b3oKjT/8/tLGh
 WZx8hx2c58KivDQl6wueJtdzhTJtqKXGhHBmj1caDYW9HatpPqN+ght1BtDvM4Rn3sljpUZzy
 D2N9FF9Xhli5lRxKB9iQasuWp0O4U7acswbAFBids9Rej5NYZ5zGTkbZQhgNJuptYwHUlAnSV
 /WAkNPTzLtYRipHQHzjepPnALLycECKo+Gcu1Nf9XSo+X3y1PRVssRopiGAY2+jZSo0n3U6nX
 f18h+j7fEtcVaOHnl5JXdU5WuUTv8HqZ8cQ2xHdWBR08msYd5FByw+e/YYWfEIWv7rII78KYV
 TTimdDNA37NShW7suMJNlqSR8Z0ddNYNJ1IaLB74E+twWwZW9QQ6oAqvCzXLw/ssCVAhOKoxq
 KLEVxetUKRsQ7d4BVhZNfCbWNehAh1pzsWhwr+ymfT+aKf5QPR2t3XbjQdQKUgGZuStgWqkFt
 jcygB87R/h+O8k6hEy9u0LbKeprSem5/pEsDkp/Fevjefp9eepTf60lLiiwGgtHMwPb+Rj69l
 FNnTc3REZ4I6XRsdLUPZsYc4nzO241C85xcx2yzZgw==
Content-Transfer-Encoding: quoted-printable

Re-use the AQR107 probe function to load the firmware on the AQR105 (and t=
o
probe the HWMON).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/phy/aquantia/aquantia_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aq=
uantia/aquantia_main.c
index e982e9ce44a5..54dab6db85f2 100644
=2D-- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -787,6 +787,7 @@ static struct phy_driver aqr_driver[] =3D {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
 	.name		=3D "Aquantia AQR105",
+	.probe		=3D aqr107_probe,
 	.config_aneg    =3D aqr_config_aneg,
 	.config_intr	=3D aqr_config_intr,
 	.handle_interrupt =3D aqr_handle_interrupt,
=2D-
2.45.2


