Return-Path: <netdev+bounces-128439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6B97989A
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CA21C2110D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073251C6897;
	Sun, 15 Sep 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="PYWU5SEW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A21805A
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430121; cv=none; b=JmddcamLSu6lCqsrcd/2iJ7ycilC3C9U+bLxvxeN54i737cl4g1neg3p1GvVBpcJRVBLJWT828xVXoZxZtNKHdrydjCO+mepQ2Rtn0jtIzotUmbzFalQYxue2fCUl4/O1DF/33RmVkjUaipprASLA3nNg6ZF0lIHijyfwCfP6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430121; c=relaxed/simple;
	bh=ovKeA4iC4KuIlxDyWHk+CmDKrbr+mt6Z6DdmxyG7fF0=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=UYhgXjDuBVOPPfLytXLK+wfDFiesFUFSllrSGMexi4l3E//z0MSs/pMa+i0xigU9HZgVucMv++ckEFZLb1xfR90OrzmTO+MwUtHWRgg6Ah4AQO+5Mcp1M7kgWpyQMCSYyuGxk4ZwjsXQVXe3m2P+80BI5yPXMgvRLHWB6cRwcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=PYWU5SEW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726430104; x=1727034904; i=hfdevel@gmx.net;
	bh=Bup10WnCsUPGHan/4YMoaWd6Gle1dPigR/QxnG6jWIk=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PYWU5SEWfr3jyvv8UHiGRYDh1Kkx8pYzhZiJ36tR7k61Nd8wR6ndbyUOhPXAYbDc
	 JScgKPbV+wsEcxyWM8UVYxGBpCZuVHSOMwnVcp4Yl6mHeL7nNBLTgutHYj8JKMMHA
	 +lYn3yaCK/MZi6I85OlcsksjQWc3UFdCPLBP7BfJy4StqZR6vKQxS/LppvOeTt52d
	 okyydvQVxPjWKXR5tw/rNZAQk8fd1mUlQFc63fOFvvbFtqHQuBviWQlLAIOEsEAq5
	 Td3Wu6pKOQ4xKAqRlG5U7EwzzvRcEpITciGHaRxHlIggv9z16o1+1Jm0DsuMADMjA
	 1ZNH7fjHYpGCf7mq2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 21:55:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ad10e630-a77b-4887-b006-2f8885745738-1726430104089@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/7] net: phy: aquantia: search for
 firmware-name in fwnode
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 21:55:04 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:+XZEEkd/XzlviwXMAEpKDYFSMerO1t+flmXVC1qjLuBrB+yYAUducBiEmYfq2LNpradCE
 k5qQ1gERZSVbGwrdq2Em3eobcXX//whMyWrVo8Sv+QrpiHDoQlT7ulULKa4CA/CuJL75dXHozCf9
 eAeaSAC/Pal0A0dX9uAT0CDcQxPsmt7Uv57Ihnm8l3uj9NsQebSRRTQK32JwTlnOC91VlLAXayn8
 NO1Mb5Fq9iApr0DveAYzwalK6WRWTsmPJ2fGVTYhtV8mCsbmuJ1uGr4Xm+/dCef/Pp48B2TIGRP3
 9s=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/qZck0IJrhQ=;9bMLNHVWGb18fTtw9XiGAlElDWr
 6h20nOfXAjb4cPDI1k0w5UFwX221phyt7xLTHGecMEypbMcZ6Of++EF8A4zWWk+6HkeFGMqcC
 ORE7VeAIGhpGH3zpGdMC7KA/Depw3MgUKa48Td/h3qJK6hsXuPyT6JkTmFksnrhWh569UKFsD
 zrQQqLwnoULdjVGOOinzojNATLCGe5gXyqId9U5hMj2eWV0omcXOfHHLrXt2Od1o9pMvskg7/
 cH46HJfrxgVVLBN8mNUbUfgde3dHVtV3BMI5PRfWgynSbYOwW4SG3rqXLKwSOXKe7F9SeESBH
 huHblUTEJcNL4yuwSKvRbIk3UhmDpYEZhsNSp4URfLdUrU+3uxLVg60OOzP81ojcTOQYS4nig
 dlqE4ZyFzXr/+LHmIhfHMfz+LRwaLR0oKaJjRwZJq+9vteS/z/WjoeEKx8WpA7OacHhSfxq5M
 bP5TiHtmA5Ixra1RjLeMpB4nq6e8LcEdJnUGezRJsyq/DzwhOZycwe5L8M2iiM3tqjip7O/dP
 zDHb06LAVtZRVzLRy0dqxfIXOOnFdspNyIlv5pmtYkUWQPp16cKFYWA+wP678VWAP+Znwp1yB
 iZXNsEw8DPa1NLkASXhw6pGSL7+awtdheW+U3/cL1SkD+/nrHg8ozPdptTvOUmqD5KlwYEhg4
 gfqiRXLHpNpl9D9bmttvDBzASllOSmjamD/uKD+exA==
Content-Transfer-Encoding: quoted-printable

Allow the firmware name of an Aquantia PHY alternatively be provided by th=
e property
"firmware-name" of a swnode. This software node may be provided by the MAC=
 or MDIO driver.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/phy/aquantia/aquantia_firmware.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/ph=
y/aquantia/aquantia_firmware.c
index 524627a36c6f..f0e0f04aa2f0 100644
=2D-- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -330,8 +330,14 @@ static int aqr_firmware_load_fs(struct phy_device *ph=
ydev)

 	ret =3D of_property_read_string(dev->of_node, "firmware-name",
 				      &fw_name);
+	/* try next, whether firmware-name has been provided in a swnode */
 	if (ret)
+		ret =3D device_property_read_string(dev, "firmware-name",
+						  &fw_name);
+	if (ret) {
+		phydev_err(phydev, "failed to read firmware name: %d\n", ret);
 		return ret;
+	}

 	ret =3D request_firmware(&fw, fw_name, dev);
 	if (ret) {
=2D-
2.45.2


