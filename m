Return-Path: <netdev+bounces-127528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2C975ACF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954C5B226BA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983231B2EFF;
	Wed, 11 Sep 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="HX7lo8dS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506B192D74
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082680; cv=none; b=GBzxKxrmocCU+fEROpZS+2gmjQUcKr2JBl/LRsa4RlCA4zD4oh9YuME+Bh5SQoenvM0JocL5BvZe4vPrJAFk2F/zpZf0O2le4fcMqGRAh3RMYoXkis9ybPw4T8jFDln/gXmNH07/McYtOG7/TSXpUbhMku5kE7VvPOddJJr7mKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082680; c=relaxed/simple;
	bh=tNiAZCle51jqrkXYn5fjS8qWYzP1wL1CUYmfLIKRg4c=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=QCOAGR7zwWCMDEROh+jQ4ZE3pkaxm/x89th2KbBDVTz20uq/G5CVDc2eep7oCqHRLWQDEJYTveQrQl/iSF9H3LWJ6RyNJAD0VXktiRpqlLtw5o8/cFYStQMY9VFdQIJa8fLP/AGdAl34Nw9VgsbK5N7iR8iiWsc7qIyWBk9mH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=HX7lo8dS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726082664; x=1726687464; i=hfdevel@gmx.net;
	bh=8nFendPoiLS8InoQAVnryr6+OGW+V7/nQ7F9M3f93SY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HX7lo8dSycTUbKzjJ/tVi8vUOXZizuy8AdQ8xk1r/Tuac5pmaewNL8mxeHLLcxyl
	 ufMkYzuf+PxkELh8YVAUDGGTl8UY/cq8x0wnD0ZmdSRuhjOSuc5ywtdNo5rY1+k2K
	 2+JXeToMnfDtvLjxAMSxbESr3YchsL2Y8ev5JZ7sTMFMFjzPTpZxUFZ0oDYaRqZxM
	 chFMPGZBahePmn3Hgb83i2pTeUfncNstQmAfweXN3xeJ9tHgB0bttEnYSi6e8lP6t
	 A82s3VGA2S0TW2JyDGWlv4I5bkfKfJdOsN8cc9pW+zx55GN3SoIZ7D/NkU+aNH35p
	 DS3AkamWKngUfDlqyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:24:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ddc3de71-4149-43ad-8e8c-99edf092a769-1726082664469@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/5] net: phy: aquantia: allow firmware loading
 after aqr_wait_reset_complete
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:24:24 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:mMBphi7bkX4AUm+mxy8HUUGHKdM52rq/eM39vWPWYFItetmMffGPWcIZToy7oEHtci3cU
 72lSdvUo5T+BkiszPVIqwYqWzf40DQTKZtd2hOlii99Q1uXiKSp+KKyGdgMsfllTsA1D22Ueskla
 ZRHuu3p8Yb8454AsVgX+YOexTkVTw5ceXe+XWDS4wKcXeLL+QaJmIZsCcXH4EAMQzIODVadBiisj
 BcAJYMY0EAQgVwadQyg1JQLwF4q/T6U8kVdeBoEE0YtpERiE81IQkZvOugao8X8UcAi4aeIRK+8Y
 rk=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d4fzLlV0n6E=;40eqnngj4NuG/+TkKTqK+fdefjA
 W/usz+QbC3rm7VzppnsiHgRisQDBTnJj9WMQFQWb3meqeICWcrXlOM6JsHrn80mCnetX4ecN6
 xMmhdwWzf66iEgOgscr1IfF275o4g0wJkFBSC0HCOFDJHaPWtTHwMbmzTCVg10mgOvpQg7uvC
 +be4X//ZrJDK/HJq1HpOzJrXtDU+MyRnIDYOtv5/i7aDfTCLDLjfuAzjg4kSQxsSAnwbl4Ba6
 cCL6oHNIgNTbbxcl/NiqcoJiZc1GpeO5I5O1slqEZgn7GxI4KGMDzfTSTQXQYKfGQ9jLmvlo4
 SHbKVsvOJGKdg7LQGtroVvw9DLkqSwj45DfLC+Jl4Jga4YWCC2g2+Qjte5azH8+jroflNqjd7
 PgKJFSp78nt02N2PpTcK/2+SqFROqof6fp1N6EuzLlZzop+jeRmllL3R9w1bYbFQtvDpKXbfq
 WXbbxP80p8tCwRQhLRyTz1lAtrs2Y+RFK3VuM3c5Mh4C2ElGXpFmmb48MB3xNf17piMweNC5A
 2mB9M0FWH/dWPoEESa6HT3EgAjDPp9K1XeqKqQv3EGjanF0+lRt7nFQynhi6dzLRWiw4eWdR8
 95iX+/fbpZ3cSjsv37qjUcUbJ5VByhz/jAqi688/lvkICTnGLiz41qmjNQ9dHMrU2e9mzGUcy
 TjHqS+sb4SgZMqrvaSALcMMu63c62RxbBiVwKXIJ0g==
Content-Transfer-Encoding: quoted-printable

Allow firmware loading from nvmem or fs. As discussed in
https://lore.kernel.org/netdev/20240806112747.soclko5vex2f2c64@skbuf/ the
return value -ETIMEDOUT (returned by aqr_wait_reset_complete when the
firmware version is still 0 after 2s) needs to be let through. Otherwise,
this will prevent loading of an external firmware.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/phy/aquantia/aquantia_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/ph=
y/aquantia/aquantia_firmware.c
index 524627a36c6f..090fcc9a3413 100644
=2D-- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -354,7 +354,7 @@ int aqr_firmware_load(struct phy_device *phydev)
 	int ret;

 	ret =3D aqr_wait_reset_complete(phydev);
-	if (ret)
+	if (ret !=3D -ETIMEDOUT)
 		return ret;

 	/* Check if the firmware is not already loaded by pooling
=2D-
2.45.2


