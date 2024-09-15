Return-Path: <netdev+bounces-128438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2637979896
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B571C21C34
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7151CB31C;
	Sun, 15 Sep 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="qsjO/jT/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD31CA690
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726429899; cv=none; b=RRifS8oXzmk4zGUTON+F1i2EY9R6wLgmUxqGXjrwjQk4qYZNbu2RZNmEsKn6M968iI9JL18uNRCmZStzyKS79V9/yrkhWsrksKv1D6jryaZUMe0MLaqmYO5pQjzG3wxexVuHwK13KRGY0OO+PVF0/fwmqCjA23kWPic+ANYxkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726429899; c=relaxed/simple;
	bh=17+oqs+YPZ09Gz/uELJ4TqyCi1fPXYhH5b+1eyfecck=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=bkisdaEIZubL8mow+NOpDtu9+pAXK1iJxD1lRrG+ZEJo9UZNHwX5waKxJegqT6qbhB4TH34CQKk6IXXPOFt+9TbTSPIpYgcJXkMOOFQngVrWZytrrLiP37Nw5L8lRhAl1ZdDA9/3wq+KAg83X0X7rl2ckFAK9BgFdj7ypggZGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=qsjO/jT/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726429881; x=1727034681; i=hfdevel@gmx.net;
	bh=QXH6pChaI3gjNezksD2qXQA8L9JmPM8LZed8pHslnH0=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qsjO/jT/pZhVv7fWuM7Y/x+YLDIeo5ix4o8KRQNuJ2wkLCXsS6nUJ+o1YDc1w61C
	 KcMaaIVvKF5yoI9UynRU94MyMLNWpZv/59rG/AkaFteHlacN+nGKspXM5aljqz670
	 LsryecGM5KRZ6BQIPco58Nk+4V95by7mvTXoI6vHM9vE6AkvbLuggfyPOR4+JrS5C
	 A5TeoNuvJYbQjs9mR4C3pBMZ6YmDYRybQpd6MWOGtrC005UG4DVfL+ruK1LIRdXMW
	 yaURL80bdVUgWR2luw+dJLfNReNT60PSVprWgdftzgdCuBp0rgEwqxZpeel6M04BH
	 ycHyeu71j4i/OVRQFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 21:51:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-9e0590c1-6222-4e5c-84b4-8e3e28cad8a7-1726429881511@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-dev v2 1/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 21:51:21 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:tN783VlZ3yoIX0TAe3E0wwwLnEC9iS7PJPz5ucGzCM5XZMjf4nFUVxMjdJokZNfwY4HoF
 QzeW8foDXbNJKLULc2GfLcQVIfRBkmcv8b2geHsZxApCP7qOzzRCIFFnNf6dcqfsa317i1m3mtCR
 IJgQCeBU6NuEm1UTUgMHQhGlQ/PJTF1FpIGdCeC09o6HzNlK0V7dDu0BxctWWnJKeMNG/6cVeqQd
 eKo4NWhUFMOs5Ae2MyvfTRbiHo7t76R5vFtejXZhgn79ou06IMaAlsQbdRwZW4+Dt9G5fgssKVjt
 +4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PFaOYsi8+ak=;yASKMtlN6uf8Mb0vx7E8zKf/48h
 bc6yOkIO8gDkwJrukEwaqF++Tud3yxwWsAALEL9hLq8+eqMR9rApuzPY2fcEALCqsGu/Ytu8n
 thmp1E4k9IMWGIyR7X19CA+Rsf8cTqutfEVWX1E+NSYvRxc9zmDvvW2iihaVET8tGL1/QvlyW
 tDNrXVPC/kX+dVjdeRgw7wZ1u/Yf0ea7v75N4bDRa9ogWe2RhgWXcyyjcvcgctNv3gxAHtnRH
 c9zfDswPlgAHanwds8f1bK1EJ059fmvcGMQUKc/wnrmbTjsDaaQ3X9r2C9haRVD2siS19xw2z
 UrhtfK05uynm1tjIfrRCgRNyDQ3HB2SnY3vZ1H4Iq08gAG/LZ4OOIc5dJYMgLSNOxnDoA5qGx
 pIHERytc2oGD7MPPFtqoXSM/Nys4Ec81xR5r/H0cQXFc8GeJ0HKxEuU5riIGvuif32Q5MgJAW
 IlWFXx8oEf5IUkGS3vm8XTA9rXYAOyet0tBDhu6Vk5tkkXcZ0YcLs0yOxRfnPrZdw7+QseSPH
 bLj+vk3OaeQ5tuEbNE/goMPIgaywIn7tJ58bhjhDvvQ+km43/2BPLBioZuUu55FsuM+9TU7yc
 J72wVkmyzrgUaiGfT2xdAOHvkez8XEvk5x+skskEN1QER+A4pZ2eI1mR18FcEmqL1em/6iP/a
 RwNm3nbh3I40GeJNyV6Sj9ZeGUaUTbrmm/eq6kv1uQ==
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


