Return-Path: <netdev+bounces-121663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE595DF3C
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5541F21C5C
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5816481D5;
	Sat, 24 Aug 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="AEm7Wytf"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDF39AEB
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521086; cv=none; b=nNHtpimaZIYttRdk8xcOHGTZfewPBAq1TghgScau3/eZHCVVbSng+KnNswDJi+GG1hc5mNB/zqV7KreWp+ARJ6l0Hewv6bQXLOtwzaoOKx6bUpf5i768ZoZao9PYKZpx+GUfk9M2PxF4ipFIZLIFJfWyQTegpCZ7FFwgyAPcuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521086; c=relaxed/simple;
	bh=f7FHHRTZ4zwv1LgTjd1+jt/RT5dZtwt+Kxf6wHZd9cQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=t1Pd5KBG8ee0oRP8dfwipaMzj7Jh/VimsBhM8VJjUtzWAV91qRVPVEhcitWvgfucFaQGRECUXwcVUVnYhaXIOqPNZWUiwKZjpn1LLbT94sazB7R+2yUYD6SWxSU7Ppwfl2eZFvRTCUOxRrtjNpWeUF8h4uudsqlGj6eGJeBtTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=AEm7Wytf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724521078; x=1725125878; i=hfdevel@gmx.net;
	bh=Y6D4+sv9o7e44cH2BmPufRy2U7/cY2RW4Sd1P03MQ/c=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AEm7WytfSPG6vbz0I3RxV/mf8/RFjEtadMYXr/qgP3jIDHqWzUyVH5+jKLJUVTf5
	 AgJzFowYkyk4G7oHi29GSWtGrbvaAgGLwRqMRDUgOzMkVoHTjjfXpe/tSowaTDDXb
	 9ALyd3CZHz1SEN+HqeCaKfFIw32XorZA/ucUqPZVMgQuh6NClJdJPL4ks3vMvuD8g
	 YD0ftW8a5DfZltH6g8TbCbBW/pjQx6dsdvGIDUBbEpaH/yEQuMnpTrGr28d8xYmOx
	 8omNOGpvpHJvWl0pcuWJ483CKB/BBhCwRrgeB1lRhhXoClEGE5UnDjexIsuqVHVqC
	 +8AQ9/XfI72AOplksA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Sat, 24 Aug 2024
 19:37:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-c751adf4-fbd2-4741-95a7-c920061d3233-1724521078637@3c-app-gmx-bs42>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>
Subject: [PATCH net-next 2/2] net: phy: aquantia: add firmware loading for
 aqr105
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Aug 2024 19:37:58 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:J+7TKQCLNlVVpIiPpG4acNhYpo0dEkabg+05rdV98zEmjWt3aJodvt8o935UkkC0ngtK1
 vhowJuvpXsvMHSOk65M435CC5l8IpyKjHhTUHqSMqEoeBnGbLvAYcfueyYBk/he1q9VgGqL0RzUC
 T0rljD8zLxx+EiCJRtU6a/h9wT+QNDqFFSC7Sec2nwgvD5TpW77cH5Ui+bxP/1TAY1ElUVS/z25q
 3mBxJD06JVrvgNJolFXpbUFWs7tsqiV+wZUU+wFMNGBu7C3avSmVWtzauvcMIqwGH1SCVQpTpAOk
 LA=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cfa8Oxdbu0c=;Gas5HLLZ3dB8mLUWpzuZwAMjLX8
 ftbwECgKsxQNn0X32Mp6fbbP25//PW/4l0PfNUZa2Y+zdO0qEfozdJ5PiZ3UeyF2CIUidPgoc
 YyibMbYB9BaLo2EtSGwyo+el2Wu5JA9VdcakPRat2UHQsq3ugjxFM4IN8aUOS2XakBbav7Z3B
 kmG2Sz1/K4jeimDk0zDBoEVv/CnnOfsCirUl/A5bIGf99fGPewRKtV0l0wQZKOM3vIIzgGnWe
 /bQLEQJkv1q4QqTWBKm462zuvd5ZR56ZaUu1sYn8DZ+oSZb07msZQH27pQ6P22tS6dB032Oz4
 NwXQ28h+hXTDRp1eSm2BCqeUWfwCjzAdQD0FgFlKM9z03i/kwr8CwjwYJaUypUuFKO17YwFRU
 Fs6UV4Ig19zx+aXoLl2obFsoRLFMcg/GQSyjizNfuY2JGvqY4eyngy0t4pEPN2ydWKvI6hSXa
 xcvom03Qcb1A8MSs7BL6lQ2ddgadwlkI7NsSjAiUo50ODgh6iyyeMwc9LnHR1D3e2NnLaJ331
 COrJrgdczS3e+B0QCwqYTvLDw/M+DQ/La2Sf8FO/t6nzGQiOo6BDmivJ396261iqUcskef4Ed
 iLwX3h71L89w56j4QtbJTxcNMXueJufRPGsNGJcLixpKwOuhXri1FM7s0doU16JotWpWN4BCA
 HNLkxm5XVoehykbY4LJQ3qwzXuW+es/t4eTNv9BwVw==
Content-Transfer-Encoding: quoted-printable

Re-use the AQR107 probe function to load the firmware on the AQR105 (and t=
o probe
the HWMON).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
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
2.43.0


