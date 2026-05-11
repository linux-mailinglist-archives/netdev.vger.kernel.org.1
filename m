Return-Path: <netdev+bounces-286463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBI4GC9+AWoMbQEAu9opvQ
	(envelope-from <netdev+bounces-286463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB0508BEE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62987300E61F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CA2FFDE1;
	Mon, 11 May 2026 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="g21nUQCz"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022130.outbound.protection.outlook.com [40.107.149.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC301471;
	Mon, 11 May 2026 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482731; cv=fail; b=OdDLco3rnRpOo3vowNbD43VBic2Wf5FPVerIGMCJ4inJoCRvk49mFkZ1NvEzyyTT6aSky6+2lZLXbFra8m0VTkfd7o5SRof7VhuJVktXs/j5aSoWrofnzgxtGeS/+h7TJRsvg1mKxNWq7Iti+n0J1C8boM8vf1na17FxebWDrhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482731; c=relaxed/simple;
	bh=sc5JuvAmgPJ5iJ2hZcsBxFAJk0tTlRR2039tNqSXT/8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gEpQEWuNgdscAdiqw+kTWBNfudrb0u3LLfjzyWTc+RN5mwr8elfhdg9kAJexZcORIexVxA7SjBuSGWvictWN8U5WuhhcI6S1hLMrTw1N1nDyJDcx92yIz9IaoHnEeGjNwVfMc5RJvFeOFMavm7x8J0J3/RTB1i+7EVFoZ21zDk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=g21nUQCz; arc=fail smtp.client-ip=40.107.149.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsD8HEiosb0LC3xOo+RIE8/fMFv1HqweeMAF9KpB2b2I33/K33R223SS7L+KddbYq6eNC+dUILjP4VkBJ7vZiOARGaWsobk9c5PfXFSf+xEi4ZM3RO9x1oq9wEahl0mq7tppltgG5FNhf8s47zI2xFPVFxFi/vT2RbxH5xnhPseFXNDa8ZnsiKDvqUclBPmlHE85Bkb0lR9YUkt2S0wbxnNy+ssukKa0YHXdj8M57qDTlbvhbevpYE4YYePYr9rLgzXlhvktSG2vWC9ABqAbwGe0tOTQ6fBDuk9cFRtMBwd6CtzgSqoebQr9itj5JxGYFd/3dwvYXejNJiL3XBCdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSV/iI20WWVPqhKv863NDlS2dltiLV6NB44ITiMo7P8=;
 b=QFt+WZIIeR+krCa7AOJBwoaToUdovFELWFvbQBEYpfLwp0TiJ1CplogoiSpO2UEIJUOPLe384yZGbEjzcCa3cYG4FLGlz6kK4oNiYmKKCLa8x5badVZMukU7thI9km6w1r+tA6DjtndJjuLGlRwLYUW8biED9kuZuW8ZFC5OSMDRJOO3Xef7if7qJEPuflgAyGKQ5rmGtHrKQexlsG3tb8flsZMQ96bn6eJxxptlt05BaReJbpLncVHR/ISfLwaFcDB6nhoiuLmpjnxYHp40DGataJMcDzfm5A5o5t273ATnErGJzWobEKmc+etZBbI4uMHg7G6IwYNGROeXBAbxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSV/iI20WWVPqhKv863NDlS2dltiLV6NB44ITiMo7P8=;
 b=g21nUQCz/7lXjNmq1JKSCK0WbI+/dOzeLnsxV3gArigw3Fa4RqAoY2fRo62hUdg/vrZFv4OMB7+eULdt+xtY17xHNqtAzAr/9GfhSTPzfEPAlYjl/Gr7+dmOK/HCk7NmyqYoPj3R994ItZiqP5+T5NO5Q6yUVWBilJqoK26gTlM=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BE1P281MB2307.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:32::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:58:43 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 06:58:43 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
Subject: [PATCH net v2] net: phy: DP83TC811: add reading of abilities
Thread-Topic: [PATCH net v2] net: phy: DP83TC811: add reading of abilities
Thread-Index: AQHc4RNiAwsqEUoxLU+UgExzF3T7lQ==
Date: Mon, 11 May 2026 06:58:43 +0000
Message-ID:
 <BEZP281MB2245C0B534D1297363EE1343D9382@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BE1P281MB2307:EE_
x-ms-office365-filtering-correlation-id: 92f0b3b4-6197-41b8-f508-08deaf2abd6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 pamyxqBGWhc2nNyC6HtO39VI/Ldk9TbysIsiCi/iV7TA98A/7cDzQp4tnN9DDS0QGKBkJd1BE9OGKw45YnOfC1nAXwzD2Z+0V2ZgJ8NHR9aqLtui13ChKOTZuFHFurjx0QZhEyrnhS6bHON3I4+m5axoEa2SvKiagMpI6IkwNW2gXv7VUpyq72wNgOOl8sXVQmv0sZUoIhA+wiwtoDh+vCxfPWgWQ3P+LMtZR4/4mGq1rfmi1IQVhbimKYYpQYHdqHK1eaAd6NEddq4h6/A7ECeU5f/zbH02swhp4dQgewqwl7UyP58Y6FuaoWSWh9Cjkpnda/MTPwe4tCBNBMyLxdJdU9yt8gtByv4eIPfJyjaOyA14j/IUahKVCF+fgVW2mqBcVOiMeupc7u4UQVP74FCQBnSnV4vJudliP1K4aXM1C+/7PhT5LYUzaEsNKahOPH3ExVQd39UCib6ygwIIlWa2FNlpRoYRI7ziwz4L2gv7+ydYFOEUGH4jjXHCx7UyxPlMt3i/XaPTp9aQLGOQRgTUzTG0zaaDWcpFArwM2LesiQNVrvAD/Rz7cYdv9t7eaCajhG3lg/lM13Lmof1lYyN2ohjpBPhutK/6sN8GqsERLZ3/MpbI3l1WA+ABKYkH8JvDQIiLq1Frotejwy68VnYbqTJ6G/sQZbrsvT7TOIfz0QiY5vC4p6f+zBb+g6onjpaoOXvLeCn2IcNzFOe+PjS42gfGCUhFHu+I9v/Yq11K0ol2XqdkVgZYtvSYZ7ua
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?liDWU6wyiXwP5ipEJXt8BdeMIqNdseXBywtrkIouf+q/Bl9KLSWWpY0nvT?=
 =?iso-8859-1?Q?j0r7myHPkC8a2UIDUiZWVIPtgeA6hWh2voO3qYq8L4xUrO3e/PwwrdSpK2?=
 =?iso-8859-1?Q?X/U6jdplYeJYRTxZPwkFl+wsA9X1RE2eUWP8XiA3e2ZEpHSyJHfHfsSE9v?=
 =?iso-8859-1?Q?gCjBlO7EB2RYeiOzB8ReO61BEI0YYUVr0DxCXj2PMKMLe5t824cKMg+/+j?=
 =?iso-8859-1?Q?b2y9qeOTQ42+d/Ai/nu2YdqjpM4YEgxAz19KBoo36+sKoCm35R9YRAlxTz?=
 =?iso-8859-1?Q?nGXTD7zJdPkJDNontoHm1pj456udC42oZr9gDZFJLHiDttBqzzYT4Unca7?=
 =?iso-8859-1?Q?nUnsfIJJAtSqCTFGY3BuCyhj1CAIqSjP5bGd9vWCT5U44SINKKwZYT1CMb?=
 =?iso-8859-1?Q?Y/P1bu6O93aZsL51suKdn/qO7h7mdrokBKYh8ydvgrhUcJW6FpHFyltnLs?=
 =?iso-8859-1?Q?fqtYoem2ci7f40fPNw4WJudoZ6fBcsHZw71ATChuylHsSg04f20gXzMGt8?=
 =?iso-8859-1?Q?HPF9egurl07ta45im9AUsCBSLFUG6HKdE67a9VAW5476FdHlgXAFD1WMC7?=
 =?iso-8859-1?Q?acyXPvPpXBj8Qt3PDMx3zcP3PZq1qiFkr4ZdxX7DVNUZ3vgQe3eUowoCxd?=
 =?iso-8859-1?Q?O8JeCzltySiSi7nFuo+heuCw+ItDY5P/Rb47rf6k+mZu0sNQIXsMt8FDZd?=
 =?iso-8859-1?Q?MvFM4qeL3xj95ODXgo1eKTCB2vl3rzTOSy68GJ2prtiNGI08Yd2vkpQWrO?=
 =?iso-8859-1?Q?oqaq1RHLH1wp4hMJ3cW+mbbwv0fSpneWfkJC2bT/fskD3CNEYmnEci8zEM?=
 =?iso-8859-1?Q?HoeypRaCxngOXhXzYuoLNASWOmm8A6TlWXsEOs2BgIThyJi/5Wbyd6nzKn?=
 =?iso-8859-1?Q?xRVwp9ZKEfqIOaHABh8JxErbDT3AtfKr5pkGPZ0VA7fv8QKsG/rb3sou/p?=
 =?iso-8859-1?Q?LxeYLAe1rb+XxIziMP8GTQSLZKKgFYPZzipDBTa6FOrsxzbXryhZ0utBAU?=
 =?iso-8859-1?Q?5UNvA7KFdBPIo+f/LouOX/8d2OzIg6G4pa163AuduNTuMFbvqO+7TydkwC?=
 =?iso-8859-1?Q?sbVzx5YnyyNPZbbgqgl4HBYxJ5MmGf3CGSQxUvfnMxkzHQgtbItTCrm7WL?=
 =?iso-8859-1?Q?Y1VvhBR9yPgbRi45oxk/CbZSIu8hGRZ4zZHEHopNbvd7QV93i0aCaAZZ5s?=
 =?iso-8859-1?Q?1lgMIalvujLcIJI50u3UcCtZc0FT0Hjg8/ka6YMKHa2tmGjQ9xj7c74jlF?=
 =?iso-8859-1?Q?XDwyb8QC7rvN+7oVo24WaghQGAqFbuQSCnhTq+y6EUnYzFsj2y9CFYzoKB?=
 =?iso-8859-1?Q?LwLLudDtWpUKphLKTLLQubA7GbVG+nI/MmNqeOy8wj233mmKiYMUzjeH1v?=
 =?iso-8859-1?Q?CUnHX6Grg3CO6LhHXPG+y0nokrLG2EQSq4bxxu/xBUP3kd2BwoAHiaItEb?=
 =?iso-8859-1?Q?SBeZplIGVmni9thB3aRapEwILjAfxBt0z1t2GOEfXN7Uo6r0s6uAaN3+Il?=
 =?iso-8859-1?Q?KE5MPQcrOd47+UF35pOK8CoCEvAh8Ts/G1SDXumMHx8w9bG/YwQOcTZz5Q?=
 =?iso-8859-1?Q?nm8SzdOlkMcsjwEyMu5KMwLK4ux1oqEhGs3aGwZo3OyIP04DRKD/eASpmS?=
 =?iso-8859-1?Q?3jotRs/4J/BWSuNwfQamQDUS3iLn2iXlZRplKj+lx/R1iLsNZazj3zVSLm?=
 =?iso-8859-1?Q?dTxa6PzzucyetZpLv6QOR9eyy4rSaNXWYg5ffbqczGb7JpzDaaBCnSdS4R?=
 =?iso-8859-1?Q?+lZLKmezKHeii7v9c3y1ezNo/4gfbVPsLELvW+HqUu/B/YOThd4DUkY0vT?=
 =?iso-8859-1?Q?5305ORLd8g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f0b3b4-6197-41b8-f508-08deaf2abd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 06:58:43.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWe302CTxmCob78PK3GxNgjrzfw0zu/0nPi+Wt05jRvvCQdnxO0eXU4Y9kkguAWGDHITqjdka4cn93JRwP8yrjAvdRvHQeAjdXgmmji846E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2307
X-Rspamd-Queue-Id: DAAB0508BEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Action: no action

At this time the driver is not listing any speeds=0A=
it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT=0A=
for DP83TC811. Add the missing call for phylib to read the abilities.=0A=
=0A=
v2:=0A=
 - Fixed subject and added fixes tag. no code changes.=0A=
=0A=
Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC=
811 phy")=0A=
Suggested-by: Andrew Lunn <andrew@lunn.ch>=0A=
Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
---=0A=
 drivers/net/phy/dp83tc811.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c=0A=
index e480c2a07450..6492b60d1f7d 100644=0A=
--- a/drivers/net/phy/dp83tc811.c=0A=
+++ b/drivers/net/phy/dp83tc811.c=0A=
@@ -392,6 +392,7 @@ static struct phy_driver dp83811_driver[] =3D {=0A=
                 /* PHY_BASIC_FEATURES */=0A=
                 .config_init =3D dp83811_config_init,=0A=
                 .config_aneg =3D dp83811_config_aneg,=0A=
+               .get_features =3D genphy_c45_pma_read_ext_abilities,=0A=
                 .soft_reset =3D dp83811_phy_reset,=0A=
                 .get_wol =3D dp83811_get_wol,=0A=
                 .set_wol =3D dp83811_set_wol,=0A=
--=0A=
2.43.0=

