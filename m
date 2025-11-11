Return-Path: <netdev+bounces-237435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E7C4B48D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 04:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F338188C90F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59248313E21;
	Tue, 11 Nov 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="J7Gd3KRp"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022084.outbound.protection.outlook.com [52.101.126.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FA2E719C;
	Tue, 11 Nov 2025 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830601; cv=fail; b=C4rDuHpyn/BIwiaB7YNlcMghuw3F4EZ/5sF9UtkkI4w8bz1bLdxmyvw64mtHZ+s+1yB2S2m8vYFGYQdM+pHPOMrNnfeu+AXivK37vSIcw/BG1J2vzxAz+O33ZtMM55GYrWzQ38N0Q1SpWDYGZoIA9vkpCLYFS8MrWJaWt0eAESw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830601; c=relaxed/simple;
	bh=NDnSn6RKX6gM8MpiiaJZCDWzga63WWTqUpe2z26PdAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAQyep+/SfwXuYAbwkf1ERFRBwWAsU7f/JLppfcIz1w592vT+V+ZjHKm7KUF3ws0fb28vLlaJQqjU8TqBfZUcLNSmpS3BEy3KKFRmWSLAmqDkTa4jFk4ITndr4CiAz4Tc+JNdTfv9FhXmjE4P0mfMTcV9VJjm/eoGa3dMCf6YAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=J7Gd3KRp; arc=fail smtp.client-ip=52.101.126.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLCtPshXEozoc9mCXuCqKsQVy8UgRYrtyAbvuoDu5yIiUHHeinF0BycJ45hsafi4u67u0ladgbfFIWSSsbiuie5z1c7SuWZkFKD0wFSfsWRf4IIULd7/dc2m3Lg+biQKF5kqDSFMjX8me91HGCdPW9gEFVHQvgco+woK4uQIDOB5u6eOfAtAF6CKz0GLgZpnCuYDRkdxYtwKfnCA/9lbMpyi1wc39vr1ANpPd9ZPrvgTeWanP7soicun7VfY2S0S2sRHZ5VqoG9+ApDyuTfbUrP/ZTFPfP4Sucxbwv0otx3yABgJ8OFd97GEYPj2juiZ0O/MFPgY5hMqcWuzaHpA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDnSn6RKX6gM8MpiiaJZCDWzga63WWTqUpe2z26PdAM=;
 b=vhDx367gGQafIdQ76E7Z/ROq6+gAqgEIOZZEaOIv+QAp05OrqzDiTOVZobcxbWlraM04FF/JyS9volemskXCgZ/TgfhKaWyd4aa0chYevgErhGZU9pJ+eLC6fffGknqRBZYrVx5/d/Q/rh8q2qJp7MjsxhNxGok3jDeApMDeIfCRPwIQ2OXIefuX8PXVJaarZ/vASO7qFefzCGxn4JsehqMxMPtAPLUunfhbGlqhWa3d43NlnxJqjQ+pQelm4M/KMg8Yup9vYFOX4tmkPhgc5es5cgwQs1ImlXoAEetpr1XVGJnPhu/kGXnrRa1bYKz2cniJtkuEFOGuqyh2u9QYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDnSn6RKX6gM8MpiiaJZCDWzga63WWTqUpe2z26PdAM=;
 b=J7Gd3KRpwWT1f1bCxLcK0LOzfmrJmLcUj9j5P4/wdF1wp7DugR8mv880UIkk4zC9vh/kazVEDuZzkY/MztDeVxeG3R9qaokXXeBhTSOjZDIdPDN5ZfRdB500O+VdKSadtvU+FRRz8K1u+GXi6SEj67u4F1mBG2e4B4Onv09M48CIcmTxPUaUAYMJ3qG4XRydzlyL3uTh9sSqMBXfo4rxOh7tff7+UpIXFIGkgtdGRwxTUBREtagbft48b4Yi3+oPTamlX7yt361+uiDJ+0PCW4qCIwUPWQ+cdaRmMQXt2hnxu8AejrrJfyV0ZBaY1xR+/u6jcNiapPY0Wa5/60T1Mg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6332.apcprd06.prod.outlook.com (2603:1096:101:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Tue, 11 Nov
 2025 03:09:56 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:09:55 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Topic: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Index: AQHcUjKPFpI7MoYOzkqsJfCmSLBAwbTsBwaAgADCIuA=
Date: Tue, 11 Nov 2025 03:09:55 +0000
Message-ID:
 <SEYPR06MB5134CA04A18DC9783CEB40999DCFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
 <aeb5d294-d8c7-4dbb-a159-863963d38059@lunn.ch>
In-Reply-To: <aeb5d294-d8c7-4dbb-a159-863963d38059@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6332:EE_
x-ms-office365-filtering-correlation-id: 22684813-ab55-4e0e-6193-08de20cfca59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o8DSMxIEffKF9gPBmv1fFQ88AgohNAuN+XfMe6rrl7V0qrboHd68E0B4boB5?=
 =?us-ascii?Q?jA/t1afO+hlnCcMrjR6uL+iEdQSOg/c7mTpkc4hwLFRzLIYq/gt5mmr9sVB1?=
 =?us-ascii?Q?f13MoTC4GMW09+vxPjKp9N4JGHz+0cgoUiVwP0abSbV3w/asgxex3vTZzEZ8?=
 =?us-ascii?Q?43TWSOJLQEVwujvGlafPwObvkwAkQCOJ5bITX5AmF5bQjYJdO70DHlFN0/Tn?=
 =?us-ascii?Q?NL22AgQ8Dj8ImtQZ5toNYP/eCkXVvHyTcvaur5NsHQgMzSNb07HxvoPmRrCN?=
 =?us-ascii?Q?dgEE7EZw4/3iNRywDvt1bDNw/S6lTLhd6nNP7x2UsxowcBdMHxDJNs90NtWr?=
 =?us-ascii?Q?pAX1LmWArwIj0fP60RPc2LygYq97E7fZwTNJVbRPOLk/kDqJV5VIWZVv156p?=
 =?us-ascii?Q?A2TiQwKQ/KywKnptY6eLod56Rl10ofKkjW4VHyLjoCOwALBH+xhjHB3m/edm?=
 =?us-ascii?Q?tw4SOJSjbWiB6ODqA0V2mGNFYahJwIXglaH8ddDZNB7RH9dzfVUpM/WQZPwM?=
 =?us-ascii?Q?0UW7WUUkq0Gfs1y0SkAXfrC8LAQ20f20oozVUc+wX5Swq1Xahc2jE1TiqUDw?=
 =?us-ascii?Q?psorkTC+x17Ktl9rurFh5IbX3ozyMAAqGIW8giDfb/dPF/GadrsLITWPfEQ+?=
 =?us-ascii?Q?oc6KX1xilEeo3iveVoVrpYBBNhMk8lnNadCL+ZR0J794CbfgEJaRrc/MiZm1?=
 =?us-ascii?Q?PuseuFKhwQYDxmBGM7dpuQkH3XUcnk7cxWRtKTi0+0cEEmOpP9Odzc/bYgfO?=
 =?us-ascii?Q?kydFSM0rjdyr4PmCaOOHExdoJOcl9tsSPO4y033MaYXc/yoHyCRl16ouhcab?=
 =?us-ascii?Q?YPfsYwvESczYaEZObXEjHmypPeOB2T/IzW/z/zT1sZWRp9+B0NTB37haYPDB?=
 =?us-ascii?Q?0x7houpGfdrK6aMJ/4jyn+xHghvE+N5asdtQt8blfVL/RmXWYMjFG0DsAGFx?=
 =?us-ascii?Q?1t1p7qJBKOcAs11f4Y/hYvn5h/vtzkg1rbasyp9/y0zffg1p6vnXAu2zGvn8?=
 =?us-ascii?Q?iwnm1cSDSHfCiSJ/omGsUlxwfBPe5qFO6u1NwoHEwKW/lH605OrHr1hEGkpb?=
 =?us-ascii?Q?F9p3MumuYcc9oveTp8g8dWoDrTeFNkYrIctqOYbjW1LPVztl5At/ej5R56u8?=
 =?us-ascii?Q?8A3i4GGLxQ0c4LZz6S4/pKtrUG3OupSlAZkGAQ1+AWNPmyHymv0PrWRoAdIq?=
 =?us-ascii?Q?A6PlG6jdOd/Qqees8R/Eq3CMaL4+BQVpC/+vu+zkcGo+t/aEBWmteT75o3/1?=
 =?us-ascii?Q?sYPVa8Gy5BtDZgVE9vZTsDJfYTUSH8IxGhjEflDb8MZvkP3nDcJEmAMln0fk?=
 =?us-ascii?Q?M84o7RX1iIF1Ik+k+5+oxEi3Q2yDDELIMUzzFu3+tPd+ZkgveFkR6nlJBENu?=
 =?us-ascii?Q?S5sa/WS+uvAMyOcA0gSTC3Xf/lbirSLWVlp1EJTqtFGxWKwvA33voc9AvXKZ?=
 =?us-ascii?Q?k9Bx20pICcEyCerGUOi6x5oA5usL7WvRayVuAAIBdQtzHL/wKNlP9uFvUmQl?=
 =?us-ascii?Q?Moh99qXqsppobXOwmpUQMeIcGj0Ayl80YmER?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FVo0eDphrJNcb6duB3m8iGvuX+b9lYpzzzJ8Gpu2DuS4VZASrnJGCwUMjLXV?=
 =?us-ascii?Q?9W9X9TPPVPG/ZSDWKGA+qtqquiAHBFW/+robJVl1cuMZm0WGYjy6irhfQsLh?=
 =?us-ascii?Q?7zFvRXvgU7V+1E6j/bBXvaqMPCX6X9ZUovZGdm9jhwd9HmEyBrnfT4NVVfKa?=
 =?us-ascii?Q?/qVDHS3xNBHNfpPAFYsoQSLQT7iCQnGPRnXbDKExnHI0e4dG46tnR9vhuYXa?=
 =?us-ascii?Q?NZDvv2Vgi+ffP3/5ybdooKTSh6kHpAl0EB1TEKcWWQLAHrU61Mg+8KH5d/ZT?=
 =?us-ascii?Q?Q8MRggBqiZoljpw4We7LjE4y2LSVlhc0q1twNDjHo6FLGNX8GADPGEcIGfv1?=
 =?us-ascii?Q?2pAcpiIIHJWStSld+hZExWjjn67VsByYgdOlAlMBxy/6V0AT3CYSUIK8kRZv?=
 =?us-ascii?Q?jO2h+lPjt6P+wl3utscjH2yVP+J5otw0V/FeY6izEtNv6Y9t6S6qv8CsUb0r?=
 =?us-ascii?Q?7wfaWOnPF2+4mRNWVTkPjrUBS4uTNWLXzsy6RsBfad1zT/qvnrdrf271J8+8?=
 =?us-ascii?Q?l5RAuRxQ7N0NsXh2uYB53YddCr/5T4+H0BDzHRS6wvwmNYY8PzHgQWsDKhQB?=
 =?us-ascii?Q?/JF3i/MbecPOrpAEv1bN4Qebcv1AglLdTDn5RcsKycDpJuz/M3oo72ih5dsi?=
 =?us-ascii?Q?jr0xRrfKFFL3qELA3GEaW7+pt6cP4oB4tkQEJI4sY5SeGEr7Wle6sajo9c9a?=
 =?us-ascii?Q?B1+lM79Ddd4c7UpFgSAMIzzIDkkdGf2+Hd9OpsrNOueWquhhF/kV6XsVOtYm?=
 =?us-ascii?Q?cnVKNsxj8yHo55//mjzcI/OjvyDqkDxnd2YVeek6GZu9825aVtIa1evSNx4L?=
 =?us-ascii?Q?b3RMSqj/iNCXEvX511d/I1E0a3krWnQ09KlaadfybF0qm9frVIkoJTKmJjCh?=
 =?us-ascii?Q?rBTzhfSfebvnejWHwzvXLdu+GUfF761Ot2FBm1p0pkgLDL8djksd77AnjVv/?=
 =?us-ascii?Q?pQzU0DOx5cBTgPe3ZJgyHSUXImrS0sXNTMA/hBbZ681a7NZnxNjUXKlLBSuL?=
 =?us-ascii?Q?CZFCexl1Mxv8GnIfm5mlOqOhF8p/CGFpEzhYsjL84Ok0+G129RGADHcJlozq?=
 =?us-ascii?Q?0Reb+a57+he5E+AHn8qSzkMxB9z810ANjZ1bb5tgpIrcc8H0/fzzjxLKw4dk?=
 =?us-ascii?Q?DVtXIXG5kcwsezTFL9nR4ZRDk87FQuc6pTuYkVuBj4CGSh6rRzNCMfyDjBTi?=
 =?us-ascii?Q?EiwJQpxitAobSLGLtYTGfIa00/kGNear3Zo3MZncdfb8+8MSULQ/ilTFuLm0?=
 =?us-ascii?Q?TktqdJVgsMz3MnDKi4faAk5bNLAjwqP2byS2fpngnFx7HvCIua1UO3MsLlSp?=
 =?us-ascii?Q?f4k+TaQT36OM0xgzkf2mhG3UvReHJzTlzwx9uoyY6SFEQH/iiDI49uBWYdpx?=
 =?us-ascii?Q?NHOgi2Hy0BRcs9oA9vlCrW3Ah2rLDmeeee+VBW21zkLvAF6YlY3TEAwgPEio?=
 =?us-ascii?Q?+1LoJ5c8UryYdgsYmqmJSZdNOsft9ec6rjzUGvaYY5zLrq7asxmvOUT/vPsM?=
 =?us-ascii?Q?DDg3sp0cuPluL8cfEy+3OcXwk2ptNNKYSdsZPB/ef5ooFzrapeIhvhORc7CW?=
 =?us-ascii?Q?bxENv5ncELfvT+/iR7rvNaKejodIXzymNZu6VHkz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22684813-ab55-4e0e-6193-08de20cfca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 03:09:55.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTOKYXZX5oTvm+X7Y+xKa8fg/EjFH0cAKB2HZ9m5rA601OuVi9PCqjU2K7MQ2S98lIccQ8FAJ6UFL1Jhat6WR4hsONKYBSAqfLQNshbkj7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6332

Hi Andrew,

Thank you for your reply.

> > Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
> > RGMII delay in different MACs. And for Aspeed platform, the total
> > steps of RGMII delay configuraion is 32 steps, so the total delay is
> > "apseed,rgmii-delay-ps' * 32.
>=20
> You already have hard coded base addresses to identify the MAC instances.=
 So i
> don't see the need for this in DT. Just extend the switch statement with =
the
> delay step.
>=20

Agreed.
Indeed, no additional property is needed to specify this.
I will remove this property in next version.

Thanks,
Jacky


