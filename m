Return-Path: <netdev+bounces-255071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FcoKsZvfGk/MgIAu9opvQ
	(envelope-from <netdev+bounces-255071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E673EB8991
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D932B300CC12
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D36F2F7ACA;
	Fri, 30 Jan 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zp2rafQi"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1A298CC0;
	Fri, 30 Jan 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762730; cv=fail; b=PQEh8VTrCTfCGZ9YnwvkdDlLg20XivaV2uR4DgiIXQOwJ+5JzLtcLAWDh62i2MrvvolLaoZPnGy53SsgAcbfFkDMK41tTLpCwhvhAWiK3kkMu6OcHK8ctFj2tPAku4xUpPBkxmfR04wGYN0FHqm68kgSwt1iTBBoRjXmxyGASvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762730; c=relaxed/simple;
	bh=I8QkZ6lEcXNgHrind3vhPb3Dyz0VHfcHlLB4a3wOsGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jkqlYgrFUI3dN2EJ4wgqp2hrJ/o616ONDJuSwZCzfWW0FPfBbShyQnq4eUtMRymQTg0rhbnHkabsuebu27vwKicyL7oOV9hETSidd8SC0IHl+9N8Ocui4MH8y7uKRnk6vuaJu8OopWViYA5OgFOfmcjQYc5QatLLF0K6c31s5lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zp2rafQi; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcjvyVHTQWFLmKRjopmzeR+z1ILdkbEkqkYIXCdgpfHTVTqnfv/Ew1rkvrFoZMKrpuLNhcGTiZdKFS52+mEPqtRz8JTALK8qFT4q6KbjwgYUH3+1Kxrg3DD99WGRf/PWSiL7sW5nRPFMW/ACnFLji5V3/mHpMOctpPYbmV5l3OZ/BGRT0PgljN85rZklCZ537eH7I1DOFat/n9cv1oeQGMSfx7b8j8UG73A4kW6awFt2VrCmDw4FkVX494golQm24mjtvS/6FSOglVWIX89BRTD7aS4bhZPEC96+txx5jqkh9X6Nbmfu1HEqLCbzoyRtDlUAgiYpf3Z56muyIaN3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyjtdvaKXoLBocFYq67JrNxC5NO1ebhsCwmkKJeE5eQ=;
 b=mqAQSn+Ngb6zmsFUQo/xebdc64eQunv5Of3orghSCZbwup8/BSWHdu9WI+pZuaNe57hFLBtX9D/HeDQY5eZkOMtxfIXyWcPrStetyniUQwyYnXkCL1f84TIJ0nmQ3u3+FHWujv6Im6OqpxUKAWLedWNuPc/he4xPz1N6vyyA5H2JsGFdVI8kg7tDz/VxrckToMlgfRdknc1FN6gxUMQHc27WBi4frKsx7rml/5AdTX2D1bOk6oIv122/I/Y5Rbhb+swr7Vh+j95V8pU4AHSy6R60Rjv5LAEEk4qs7aFRTldaVuEyFpdNPitgSYxFAvAGxyXcG2xfPw29rTNx4jAokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyjtdvaKXoLBocFYq67JrNxC5NO1ebhsCwmkKJeE5eQ=;
 b=Zp2rafQiPVXoojmd/1XYqEna5lFR9seHuxVmvMlDDEw7+WHtF8LFx5z5+IwZsP1afYc0qpcDxbhMjGPUP1DJveECjhVSRY/VkEX55A9s1eDGRgNbJ5Nzewr6brz055dJhXr9sPD8GFRwVgelpbUsOcOB4rQim0zIOB1bgsAtFz+c21qmrpVRyknbewBzUrrKMzYWIgAaaJJxuKAMJ1N6vGxPUayo2apQKod/furxzZnPZtbtNt1N7ByZFx3E5vDzVQJ5qPtm7zGU1S+1722su7Uc+HMGRTrynG+happqgskgKNzWrpZh76UTVk6T2QJJZCltYJ2hnH9RyXqGq+3SGQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB12083.eurprd04.prod.outlook.com (2603:10a6:10:63d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:45:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 08:45:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Russell King
	<linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, xiaolei.wang <xiaolei.wang@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
	"quic_sarohasa@quicinc.com" <quic_sarohasa@quicinc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVojkqAgABiM4CAASQWMIAAUzAAgAABviA=
Date: Fri, 30 Jan 2026 08:45:25 +0000
Message-ID:
 <PAXPR04MB851017585749D3523D4A516B889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <20260128201501.04bb6e5c@kernel.org> <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
 <PAXPR04MB85106B63AF43DE0830B4C362889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <cb94b647-c2a4-468d-ac1c-c5f18f0734f2@bootlin.com>
In-Reply-To: <cb94b647-c2a4-468d-ac1c-c5f18f0734f2@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB12083:EE_
x-ms-office365-filtering-correlation-id: 1ac5c20c-a65b-4987-54aa-08de5fdbe9cf
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LPIQnB8fg52SXiSPiPNC+dH5LbSpHAk05gOiN++X05Cs2+jTkUoK5Ls/fskH?=
 =?us-ascii?Q?iZZe6R/mF6uzg660MMZf7AI3gZY5PZT6QJqPbKXVNGQ9CyN+t4CSpy8duMKq?=
 =?us-ascii?Q?yRrAgyDD+RRbUItiEs99DTBkhXlAXIN/x05kx5R8CZO7+Ra7+7nnT7hCE+BP?=
 =?us-ascii?Q?b/GhyouZpse9bX26+STYHvxMCUbVQe49ijhSmuti0v1aXPNTC1Lxfkpv4NS1?=
 =?us-ascii?Q?R/qfdYx6tQX7w0+0SnzGgP7WSerDbJA+lr627WXYvmHqXLGvRT9mR3jVXIit?=
 =?us-ascii?Q?oKTTpelqNLALEAmR1IhB+ySwhhu4JAQgI7HSyygHnFUCq41OKBLNPy2DsSKl?=
 =?us-ascii?Q?yYKmibreBubmMmQsQAuTGDtTa+f55vs3nG8C4Io54GV3QAbi7SIKMrzD98P1?=
 =?us-ascii?Q?AovNGhKVvYptl5KR1eCy3LzpzKimy5kjZtwkTdT1K+XI2aTKqf2iRlJJUdN+?=
 =?us-ascii?Q?jXZ0a9vt/TfJ7hQ6GwGjDivXyuh8FAh94vL6IbggrE2v2FaoJSx0dEqS2XBn?=
 =?us-ascii?Q?H/V/VoAGzg6DAh3ZYD9jcRSOJdmwlC6ppeK6L88EgmPDBef05uJsy9oQsps2?=
 =?us-ascii?Q?AtUcuAYWq/4T0OY+DJP0tNn+gK+HKu0PnL15itycvHmUr6r2QQEWFlP/jd7w?=
 =?us-ascii?Q?gmt4FBf2syXxqQdaRbzE5soyR3eL6LN/PVDCOHj/1J3VUhBJKg9z9L20QKQW?=
 =?us-ascii?Q?XUpBcObVZGq+K6rXA0Vc3reIzC9py4geZ42LV0kD/tW1JhnC6aeRNpXDf+yM?=
 =?us-ascii?Q?HSwEbGsAC2++DgDoNwpjMMK3WTbmD9st/pbEqkmmd6zuZMa2yzQPacWW7FPv?=
 =?us-ascii?Q?s1Bi/v6m3ARj3F2uWaUqo7rkg1o3odRAnlu2O7IFBA0PMuhtL0s2csv+aRuz?=
 =?us-ascii?Q?p6AtXck/ugdlo05zUw7YPJNtrfg6Qzv83dRb2X9Is0x9Op4ow9Zx24Bsup76?=
 =?us-ascii?Q?hPzn5DxH+d0UWPFfGkDZ45H34ZdA5TWOuEKJMZb30Afg8aiWpVHJLsYgVjy3?=
 =?us-ascii?Q?vvfgcaoQWypIFBBeHE7iQR/BJOivCoPRGySZF6YizvoLO43czzFAc+vAbarC?=
 =?us-ascii?Q?XeDKsS8zRPtnEm6CoV7holNebI03LhBDG+z4cZNnU7yAmj58OzWqA1yIwwQS?=
 =?us-ascii?Q?VxLOObquQjwbFIMxN+i3q5ywzsUtExo24W+fv6/X6VWPSAv1Ebdm94zy9613?=
 =?us-ascii?Q?Pgau5jQVfwo3pWTHjRWR9hGki5ErAYaHyQE+RTfNLMgpggiqoW5P32lXxECh?=
 =?us-ascii?Q?xOriUw+u+ORVbpK0QP0Ws8It31KNbTO8H86Z4cDXtfg/Ucm0xK/ugouyt5IP?=
 =?us-ascii?Q?pkQw6zMVPOePlu3Zez0rN9e09GxnXCqbTn39b5UH4G19aqusPtKzYpcmJpBU?=
 =?us-ascii?Q?bRSc8VigO8ATHxXMfTltkL6OdkqqTpweLhyh+59OUKx8sdYsSeat1af7VS3Z?=
 =?us-ascii?Q?8O4TgzD9Y8p7tFt21rPrSLFYvpASktrGkqZN8SLlbKU70rsVUwv80IM5oASl?=
 =?us-ascii?Q?afVgTFs0cR5C8o0oR64HIKyIlfe6OxV8XLdHtpSmt0bXlOEGcFsZJeyC4uJK?=
 =?us-ascii?Q?ZvWC6zJMcNwT6qaMY2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AT9zWrnXOuWUqPbbRKxPJUoJr3r8Lbl/UeM6m7V7G1gmua9RROrmttpX9oBQ?=
 =?us-ascii?Q?roe2DdK7mb0Byh4EITZnkOg2NQKHK9cPZhvjDlS9FI3jCf+ZkqhK3YQx4WAf?=
 =?us-ascii?Q?U4yX60S4bJ5fUTEuEPnMH6a94SdA3vvOjk1a23QvQVQ4qWwHUgu+mF1wscNo?=
 =?us-ascii?Q?hKMQqeypmwj4c3yVT/3w9n0zIVLn077ypm9e2F5T6QIxtK68CqmfUtPXq4fz?=
 =?us-ascii?Q?Izw0OVBRvJQdHnD18j1l2BZ2Efz47Y9wGcMIYmuwTXGCX7r9nszKr0TBkIFf?=
 =?us-ascii?Q?xoO+C76APd75r3QcgboCEZIfuhcRGJTu5VR+gGPVYSKipawkTMhc8rxqK5lG?=
 =?us-ascii?Q?whIAN5aUVycYi2U1m9L4+LFRNC6BhkkAv68Odhg9YSdQSVXDdmCZ8IHFK/Dl?=
 =?us-ascii?Q?JoJH/KTcQt5zEoLVfDobywYZnmKzDnsUzHU9St+e99u/Y3GUBnGe+ELp6Cc4?=
 =?us-ascii?Q?zgqy5a2+Nnf5VvjP8uZp8Ex18xyZ7Qza9ZseXKWmPsGYZbKqTLGfqow88mZC?=
 =?us-ascii?Q?4tI+e0vfpINnfiWVzDG34HT8Dg5STFoCirW4jSGiOR3dmgQdTUA/DXaQQUNo?=
 =?us-ascii?Q?lbiPOgmrjo+naxll8AHLKc15ylAS13YWFl5Rqc7aFPvcPKEv1D9altCVW8Os?=
 =?us-ascii?Q?AgM4lbypBWxKsUcN+XnnU3jYUqbAgPMSdJhPsFdj3IuoIoUEYbg+TE7mDbfF?=
 =?us-ascii?Q?ogX4olWQP3iO06kCD/1ZtHiGOEpdY1cTZ9LPCf4s9AQ2kqibN55+4/vBJCtn?=
 =?us-ascii?Q?NfxZpf14Cu7GecmsvZt8EFYeb3gX+aYlRoHNWArfumGPkLfkKyppeWpJpXiN?=
 =?us-ascii?Q?9cgI4vHtOm7tYjfetHc1dJqJ1eEV+dHriWbQ/wulPoN5NdM7RAjzyUEvpzFi?=
 =?us-ascii?Q?Y3PLkb4tN5a4DZq7Kt/Y9r0EI4FkVRs/M7vvGm71mma9kXwl3jqmi2p4dOS+?=
 =?us-ascii?Q?3259u0L4Vam6A0m6P3y4W4kPMB3nncxmBgyJQysHD8WkBhhqCwf6fBXz3q67?=
 =?us-ascii?Q?w71ntuvWlxzssbrSMEy/nbo6ah5X7ETKDg+cbdKg772ZkVAR95Gyc/3Kcrj8?=
 =?us-ascii?Q?1f3/7qiKtkkuaVsRSnCuVZgD/wnN5bjTnSB26cUsbL9sKXo8LdZTJT8PMLYe?=
 =?us-ascii?Q?d63MUPBkRqxPpOD4dwbOngfNnacf3kXlmCpAY7Ph+66/+/STeCkg3Kk9EFIO?=
 =?us-ascii?Q?7Gr27Vo15zs9QlUOu3P48qXpVHtbFOWlGchsSOZ4C58yzIrm7Qni4ahFYNiq?=
 =?us-ascii?Q?mlkh1qpCF0QZCIqviQz+22t7zOxaZoF1QIm1cNdu2bDzgId2X5RWQw89X20r?=
 =?us-ascii?Q?FooPT5E3efuGwJn16NvSkLh7FQW6zID7V7P5PFVY+xxE5eB68EyvG0o1k0rm?=
 =?us-ascii?Q?rLK246UxFqzPJcfb18/hGv4yu6QBzswYl99My3ftPqMj6xoJMoeZRxzhfFiB?=
 =?us-ascii?Q?HahMLOlyspcndMGPYQZUENuowtlwhpPBLu1+AxOlmYyJNkaNxQ5m8eXQ3XxU?=
 =?us-ascii?Q?s/CCtTpm7Pp+QU678Q2p7Jui3WV3542aGcLVOw5f5AuZ3wL8rBVLqrs3on6R?=
 =?us-ascii?Q?dIZ8tUIUlT9lcY7pZAoe9vwycppnmuYhr/ILC3T+r/rotxWiGtoE52syujuY?=
 =?us-ascii?Q?GVW+khECDP4eNkMbKgJVh413mjjI7PXH+08iT1kCCAvpYOe889czyXfUbEaY?=
 =?us-ascii?Q?kXSX4+nDV3xQt0ifNoJyoW70MjD7S/yG+MwcuSwMQsHS7mXN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac5c20c-a65b-4987-54aa-08de5fdbe9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:45:25.8206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqmXzVPCXq8vAdsWN8uOLnKI4QG2qoeXwJtQECVwz2RewCAIgiDj8ae2aatKvPf9eIIttsKWPEj5DXuKwMil9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,broadcom.com,windriver.com,davemloft.net,google.com,redhat.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255071-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E673EB8991
X-Rspamd-Action: no action

> >>> Anyone willing to venture a review tag?
> >>
> >> No, I don't agrew with the patch.
> >>
> >
> > Is it because of SFP? If so, would the following modification be more
> > reasonable, while SFP still follows the previous logic? I'm not sure
> > if
> > phydev->sfp_bus_attached can be used to distinguish between SFP
> > PHYs and non-SFP PHYs.
>
> If you want to know if the PHY is in an SFP module, you should use
> phy_on_sfp() instead :
>
> https://elixir.boo/
> tlin.com%2Flinux%2Fv6.18.6%2Fsource%2Finclude%2Flinux%2Fphy.h%23L1766
> &data=3D05%7C02%7Cwei.fang%40nxp.com%7C94dbe2fb454c4a8fd96708de5fd9
> b94a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6390535858824
> 03531%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C&sdata=3DFqnLEaC8Jt0zIgVQpIkbp0fg7WCrBuJjJFkCExRQKoc%3D&reserved
> =3D0
>
> It's set for this kind of setups :
>
>
>                SFP module
> +-----+      +-----------+
> | MAC | ---- | PHY       |
> +-----+      +--\--------+
>                  \
>                   \_ phy_on_sfp(phydev) =3D=3D true
>
>
> phydev->sfp_bus_attached is for the media converter user-case :
>
>                             SFP Module
> +-----+      +-----+      +------------+
> | MAC | ---- | PHY | ---- |   ???      |
> +-----+      +--\--+      +------------+
>                  \
>                   \_ phydev->sfp_bus_attached =3D=3D true

Thank you very much for your explanation and the diagram. I also noticed
phydev->is_on_sfp_module, which is also used in phy_attach_direct(), but
I didn't know the difference between them.

> >
> > Anyway, this problem has existed for a long time, and I think we
> > should find a way to solve it in upstream. If there's a better
> > approach, I can help verify it.
>
> Sorry I wasn't available for most part of yesterday for that discussion.
>
> I'll give a try to this patch today, with the above change and let you kn=
ow how
> this goes.
>

Thanks again. This problem has been bothering us for a long time, it would =
be
great if this problem could be solved.


