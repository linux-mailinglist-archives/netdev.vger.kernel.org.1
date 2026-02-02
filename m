Return-Path: <netdev+bounces-255707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFr6DVE2gGk64gIAu9opvQ
	(envelope-from <netdev+bounces-255707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:29:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED2C851D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB35F30031F1
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4502641CA;
	Mon,  2 Feb 2026 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="N/Jas00t"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023076.outbound.protection.outlook.com [52.101.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA0260569
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010189; cv=fail; b=uV3mLQ2RN7DC9smondUMs7koUAZjbyTmGBnFoZ+qipWBCC63hj7+/kUWi7BSjRjOTSltcmP4azqOTpt7mkAiODTxFdFjs3EIUCRd9SDXVhTr0HBZYOSHCjfElMGVl7f9df2cy9gigDaw98UM0ppebdaBgMq0WOis4cdbHTzK7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010189; c=relaxed/simple;
	bh=yZbaCG11OczIPzPas5aS/EgmUpyJJ4rzGs9QbFBVDek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MlltyeyaZNTsnlM+ivLlXZ8SpOUmoY4GcU3uccN8MA64YO86UOrC8oNsd7EH3l1+bwuiSLLKy5p2Hl8UNGtXSDvywXczoI/nOv9M0Q9CoeXGUu1NIzCt++0IkvhSM2bkGLCEl0pRbFqF15BezPvEIfsGKebTSR73u/YB/doAJc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=N/Jas00t; arc=fail smtp.client-ip=52.101.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIek8fkw8KDSZ6p5pFgGMCwVJpz0JS/zm6BPvM+p2a3fGBddPSqHBzMGw9497D1awLOp4/Qt0fPUTxiWXWBbNPaakGIkfKrLUVq5bwmrh+mIzwqFxDLOuyCvkB8ZnpFcFsNIG9IVPJPNbqQXU23oUgP/wRjddLXbPXTUsUWjHSM1BcfKvUDwE5mntBk42/bntBP8TdtzGLb10kNbPw3NmbRslcQkWCQHe0eI5xWjIgtx3Bj4FnyCfRKlYLHMlBsSxo+58/w4POLaKrRmOXnXEVSO9j0Ft+/WdTAoavV5xLPfTDSRKaYmoOY0riaSZ15nNzQtnQ8RuJGhhVV5TETtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa8N9DPIhoSpCEL8qdIhW3WaC7Lgp2KFSyRmSUBMtmE=;
 b=NTc/1IN2llSWda5Xfc6HEXc56Ro0FbHkDloOy8j+aOsGvvvb5Bg+x70FwuTS14oKL/Qa9LCBROL8Ve2mdx/ZdYyNYOSKZHFyfLCt9+JEkbCCi2mSboNjOmi0G1V0Lj3jJWC/ro6PTvaNqbIq+sSEhs4IJ3u9Ch4SVqIZPhcVbHNX5FJ2PK4OtmQTfsDevEvrhPPReZRLuvU1BbxgcjNQcohsrnMPRajc8piyh6lI/o8chKTMo5KM37k1v5HxGYMNnrjl2F0GoEz+RJ5UJcI5Su2XTjUXXqQ2rArVA9i6xCpwrxjTS7MAiCKK0SxZzXgZbgT0+uFsDS32ezd2mNtHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa8N9DPIhoSpCEL8qdIhW3WaC7Lgp2KFSyRmSUBMtmE=;
 b=N/Jas00tVbHQij4SGQ01RMzzN4JJJfxIFATSeLe6YtMN48d3zr+Oi++cLAXrW51MNxB+DNUfIpLPaC5YB1k6ihlSTAo5LF6YXh++vesFOX3cX12vo9O8ACzVpeBwGl4iCyhihtWXfWfxj5FhCmd1Enj+8mj7HRFmbkqvrixp6A/bZk6mzaYaQrjWxFbVYUdKBa7ogIAnuV7j3mpBk62zblT+knsOSwe1vevZs9EXhF+vXvp0vpgxLz8XbWA0BoCJrd7HXEfx51PBaCe+BiHNuriqFUH3ph7YV/mNnTsD2EhhNOXYY9UvW5xZTToVRR6Hip9rZGfWs/dbm0RqJF05uw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYSPR06MB7224.apcprd06.prod.outlook.com (2603:1096:405:83::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Mon, 2 Feb
 2026 05:29:42 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:29:42 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus when
 it exists
Thread-Topic: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Thread-Index:
 AQHcigZP8DCE3uwsu0OrjMZguO4jabVbGG4AgAK0otCAA+8JgIAG94OAgAB4nACABclrgA==
Date: Mon, 2 Feb 2026 05:29:42 +0000
Message-ID:
 <SEYPR06MB51341FAD7C7769CD920879C69D9AA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e6f9ee03-91d8-4d3d-bf9b-c08ffa991c01@lunn.ch>
 <SEYPR06MB5134A65B925BAC871927C9C69D9EA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <da4f0506-50c9-45a1-8c28-001b0672ef52@lunn.ch>
In-Reply-To: <da4f0506-50c9-45a1-8c28-001b0672ef52@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYSPR06MB7224:EE_
x-ms-office365-filtering-correlation-id: c0a68b68-c871-45be-3d59-08de621c118f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XbPFw2CQBbMxV4f414zIrql7q/TJalakQ8zSF7cUuRHTkfgXidjmqmcTXcY5?=
 =?us-ascii?Q?drukTgpPTULghipgAWYGiuYT8dLvf74Dp94R1DkDSWiPOT5w0EpnQGzMr5Ik?=
 =?us-ascii?Q?gecVR2YaWTCg5aHsIcdicDZoEFo48bv44ZErBCewYg+PLzqIVALsL6VhXI6r?=
 =?us-ascii?Q?USSb4AoN0lDUFMlW55GftHhINEaPZxiRKsaR9sGQt/h0lcset42X/5qzplTI?=
 =?us-ascii?Q?3Al2L24FXtKAnFs5eVVFsZrLW6FyKuBAmBmPM6WwspbyQwnVy/PgGqqdBw/m?=
 =?us-ascii?Q?uuV10eFPzbkGwbda/Lz/6coaKflEBuR4DwUFGYe8MBmFITS/YLxWpotrPg2H?=
 =?us-ascii?Q?6yYTWZKTJMq7CyFzidhHr8SEacVv9NS09GndMa/kQh+Cvqnl7pv1s7s1qKGO?=
 =?us-ascii?Q?gdZLwBZmMUfT4zbRCrv23bAYFdnOogKDVDEdJ9OvzfHZ1Brd+tv8qqsk3rZD?=
 =?us-ascii?Q?hg1Wfps3kobxnpxrSKqn0Zamlzl4Z1WGr63YXoySM4m9SypNB2Q7OJmFoQ/b?=
 =?us-ascii?Q?HeiVtqEGZ0KJgtqLsnqexlJpgssWWrerMyzoCdDPhN0BnlkO/XmDUvxMHv89?=
 =?us-ascii?Q?lm0HG+g61xYFB7ufSazVqFPwJyUbYW9Mu8ryugmXPcQiqFRgrIw0ApVb5Ptp?=
 =?us-ascii?Q?Q9xCtzOjYCcU8KyloQBkAWvQKQ12k7pI44zy5LNNX/D3I+8mds5lSnKI2TIi?=
 =?us-ascii?Q?hQ4gp6oslWO6DNItJDwoJamR0yx24a6GFOT7UmjT0mIQXCW47/3D/cZCKpH8?=
 =?us-ascii?Q?EcopK5Sq/aJHdec8ls79O7/b2Rjx4w38R/2U+lu2OuHryuj5fOPOIm9RUkYL?=
 =?us-ascii?Q?0l0lcutmc/92m9hc7wr0jg/xB+yIJxxrmCnX/Y/5uagDe+ZNWKrRDTRUcizm?=
 =?us-ascii?Q?LzLBo0rO/rGMLB3eJ8JqDOsFu1M+gI+LJ60KpCTSYnBXvDkzXzYytXblQJDO?=
 =?us-ascii?Q?T2hOFLlJFb5AQQgh/OumoX4rJvSch2uo3d7tt+gmgN86XTJmZtQDYEJ/dwr+?=
 =?us-ascii?Q?5rv3bGrHGM/CKaloicz4lZLBea2RwIm0rXoh0Bop02B2+LDipRsefx+Z4mtQ?=
 =?us-ascii?Q?015eJr9RbYDMp7DPGhksN65U9Th3OALMyouWquqF4vEzOLWORoib/U+WHHsx?=
 =?us-ascii?Q?phVKfTOGGVpYaDOSV/qxpNrQOBLZbPr6RB1ZmzFNbe+kGJwOfLghkpHEzzEw?=
 =?us-ascii?Q?F4KzJG7M07SmKObD2WlvEAbhxZIorHNGkSQsm1xdiLlvH6DLoIocUicdF54p?=
 =?us-ascii?Q?IJeNoxUNCve1LND6N2DycXy3f9t6D8mFE7UYEw54lIJJ0N55rCiE0c7OcOKI?=
 =?us-ascii?Q?dhVpPCMaeXWSvR93oYK+Nq9J2YTmq3hsFy9etFhucanWpkMH1Hhc+C+jGWmK?=
 =?us-ascii?Q?dcx1fgMXR2qHWrpIUua6g1ajmMJlCIZ33P9iKqPhcxYfV77E9ARhTs9IsQgD?=
 =?us-ascii?Q?teB72tTUblJRardsFH92vVS72RwpUZBfJ0d4CucchoCYJHJK2IIkPkTfG6CV?=
 =?us-ascii?Q?Desgm8HVbQSFJnciClTqdeQiKoaCBoOAjfcfROQWfNon8SqWvdxAe/84iH+I?=
 =?us-ascii?Q?jdYP6FQdxGbuLrbm1u4S4N+uM9v73q9HqVsHeV6TU5CK2e2Rl71evG8tsfOE?=
 =?us-ascii?Q?P62nCAZ1B0ONOBxp3PJuLik=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n8RkniMNlla7TWsZlMX/YuhVAd7LqKEeaJJJevhrcDzY/ag2rdPUdgYas0Hk?=
 =?us-ascii?Q?Bftf2GmV8rZQaRSMdrHVYB/p9qs5WfZ04DM5HrxrilETY9RVkmTKtNrp70fL?=
 =?us-ascii?Q?49OsnXmIhu4EyCXcZ5IQFlnz/9h0MP2sAaVEdGm1tfBEtYpt8tndV0jXLGnk?=
 =?us-ascii?Q?+rEB8HtOFkj90nn4p/LyIGJhLig0Qp8rjhpA+htKtfsriHKt7sYGe3cGtPYi?=
 =?us-ascii?Q?u09JeZLlMJpo4rq6VqQF5C9cLowkKHnBEDKnCXU/k9r31Mq15yNuh7+BW2oJ?=
 =?us-ascii?Q?IHDF+YSqJTjiZlP/XmNJj/BoPu0pHCsNOY4d+OkVIzXWpXcefmbRY4U0D3sm?=
 =?us-ascii?Q?xJ5xhuWtTLU0DdcUvrFaJMvIVIYdoMtZc7sFbbxRCwqtaf8ysiWmmDK4EQow?=
 =?us-ascii?Q?QdM85rrLVTaID7AjpBpEHNvnAogfsWBfgk0EjN4iIwyp5swKfA/vkI3fB4Po?=
 =?us-ascii?Q?NTGl+xJJ07CATR2yz2+ErFQewmsD6WPeGWj3wqFcFT5r1GWUPckLmdeXSZ1W?=
 =?us-ascii?Q?/rxpA66DZHMJFvPfclAAGoj9XJuGxy2RGy+9mL9c9dmvkegYfFGxeYYyEo3t?=
 =?us-ascii?Q?8Ikmwkv8DXdLmIZ+Znspq/yoIbn5/kUhRM15FuW+l1QGz+iepr23lURfk89M?=
 =?us-ascii?Q?DnxouD1kT4NC2CGt3SxAKcnIztvr6/0I3zjErI3VbkHWglxehzBp0KMDqtWw?=
 =?us-ascii?Q?o++ujgVzxtvvdqjHS2otnZIRCk+fgUX1JWeK35a3lVipL/fNntQ4LmBLdVZB?=
 =?us-ascii?Q?vD9U2SVACADO7vOKjrs8gNbSFwzkB/6bZlBGZVBLaNIbYbwkF/67sWK9d6O/?=
 =?us-ascii?Q?UyOXWyvH6XmqcfKWu830n+AsHpDutsFU0a1C4tfQPjWt0+h+Xxvg0/0XVUGW?=
 =?us-ascii?Q?mRNKp7APdvKrkZhSWMZ0EUvMAWefqyGK4fe2hW1xjek/DzcxPrHKyk/kivez?=
 =?us-ascii?Q?EorUTK076P7ohfr949aCWWIycZ2Jy76w+sXpkwRrtIJQSD13mBDGvHjLqSMn?=
 =?us-ascii?Q?UVV2UaoselgE4j+sjy1LINbbaSubnDJFv5oHG7W/g9aomZoCOUFKAvAjhclD?=
 =?us-ascii?Q?wgeqJpJbk4ngIYkboxL6Eg0iHyQsRdFO0JCHigIUOJJLHFWyr2yFp6cMi+bk?=
 =?us-ascii?Q?Njj4Wq5/GaQtdQZD/h8BmsNc4ye9Pxib70LH4FYu4OH2oeUonb/aYpXRqd+l?=
 =?us-ascii?Q?p5kkM2GAHupwwmR8eLL1KUZH0PPHRaTvtfNQug195wuahTDbD9eVPIulZQb7?=
 =?us-ascii?Q?okLpKlxTYWVrbeh4bNKsoMzwaAQkl8NjC0J0ORmOx0uJCHcC3L2XXs0lJJ8n?=
 =?us-ascii?Q?yTg5cYqUUVczrrGNMif/+yYM8s9Ww7YpKHxiOMyWXp67JWgFWuGnOGOyVfN3?=
 =?us-ascii?Q?xmYRW/wnR+xD8kFATURBmOn+X1etPoXK4ObP37JpO3fVBr6rGLWosv9alulm?=
 =?us-ascii?Q?I2wEuB+ctEkrWqAMd32HCmwSUGjXtDfsin/i21p0pxOlTosp4mQ2Dra9ttVY?=
 =?us-ascii?Q?CvNctIXDJQSXKDKYY7lcCGYBlJ4Y5RXFwBbbfnYYeX//AF8XPm2x8BtFs57H?=
 =?us-ascii?Q?1xQOwyIrQa4fzkABPOKpMjmFq4ilRySYQX3h7wKMb+4W1swmzdOaBDQo9M4k?=
 =?us-ascii?Q?6PRG7pQb77YjuBm9yIkLenFoC/UMOxoDW8zCDuqs3CPf5k0yDAAFJAYk3foA?=
 =?us-ascii?Q?XZDdE71WpjO2NwTQBoJqB1MXIPQHxeXjrSKJmTFeHKbeMMblLg/Yu10tumgD?=
 =?us-ascii?Q?R1MgjmGeXQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a68b68-c871-45be-3d59-08de621c118f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 05:29:42.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxwGeFYcB+whEAqsry/bmSFrjA5KSogddsvRt4iOxlqDpvmfZ7qQQIzWQCVJip12b+HohLxhfEUeRXWciiGEAuTKAwLWT3kVq3cKICLwxf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SEYPR06MB5134.apcprd06.prod.outlook.com:mid]
X-Rspamd-Queue-Id: C7ED2C851D
X-Rspamd-Action: no action

> > > > > > > +	    priv->mac_id =3D=3D FTGMAC100_AST2400 ||
> > > > > > > +	    priv->mac_id =3D=3D FTGMAC100_AST2500) {
> > > > > > > +		err =3D ftgmac100_setup_mdio(netdev);
> > > > > > > +		if (err)
> > > > > > > +			goto err_phy_connect;
> > > > > > > +	}
> > > > > >
> > > > > > If ftgmac100_setup_mdio() fails after of_mdiobus_register()
> > > > > > returns an error, it calls mdiobus_free(priv->mii_bus) but
> > > > > > does not set
> > > > > > priv->mii_bus to NULL. The goto err_phy_connect then leads to
> > > > > > ftgmac100_destroy_mdio() which checks if (!priv->mii_bus) but
> > > > > > finds a dangling pointer, resulting in mdiobus_unregister() on
> > > > > > freed memory
> > > > > followed by a double free.
> > >
> > > I took another look at this. The goto err_phy_connect is wrong.  At
> > > this point, if there is an error nothing else needs cleaning up, so
> > > the goto should be replaced with a return err;
> > >
> >
> > Agreed.
> > When ftgmac100_setup_mdio() fails, the MDIO bus is not registered and
> > the probe function returns an error immediately.
> >
> > > It is not however the full solution. If ftgmac100_probe_ncsi()
> > > fails, it jumps to err_setup_mdio, which currently just does a
> > > return, leaking the mdiobus. The
> > > ftgmac100_destroy_mdio() call needs moving after the err_setup_mdio:
> label.
> > >
> >
> > In NC-SI mode, MDIO is not required.
> > Therefore, always registering the MDIO bus is redundant when the
> > interface operates in NC-SI mode.
>=20
> But it physically exists, and in theory, you could make use of it, hang a=
n
> Ethernet switch off it, etc. Linux does not care what MDIO bus a switch, =
or a
> PHY uses. It does not need to be the one directly associated to the MAC. =
The
> 2700 has MDIO in its own address space, its own driver, with its own life=
 cycle,
> etc.
>=20
> This series is all about making probe simpler, ready to make it more comp=
lex
> again to sort out the problems with RGMII delays. Always registering the =
bus
> just helps reduces the complexity.
>=20

I agree. Even in the NCSI case, registering the MDIO bus can still be usefu=
l for other devices, such as hanging an external switch or PHY off it.
Thank you for the suggestion - always registering the bus does help reduce =
the overall probe complexity and makes future extensions easier.

Thanks,
Jacky

