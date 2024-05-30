Return-Path: <netdev+bounces-99521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA968D51E0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063F41C22D2A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB474D8DC;
	Thu, 30 May 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ksXi5eYP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F848788
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094224; cv=fail; b=PM3DcZZJmmNdiJrH+2QEkVgFC/lNHxOs+MEUFDUEM8H8SzQeuhvE4rEz2qbh7woE1AG7gDqkbyHDSnApS6HJLlecOTf1txm9II5X2u6H/vmaPyshpRrhMpv6s0EAoNz43ajsswvgsynSFwyjyCBUt+r7XnC/2IDdE8qs19N62ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094224; c=relaxed/simple;
	bh=K5PaPCNMQE0yUDvE97G9kSZya5lt3ZEOmkHPJxXUYLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOz5gfrWS1PHlIg0NLUWS4NePkX5CVZhLpt24li+DipdnHL9BLO6/S3X310q5NuBt/ASLO1nJG2sSl9GCJfSimq4hOga9TGLKIdlU6XE5jV1mgkKXMH58n0lCgu6coikHOaGmKFVdOxEGRza/iaELxa0+Zj26N2LmDHnzGCrX7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ksXi5eYP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UHMRdt026595;
	Thu, 30 May 2024 11:12:18 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yewt387f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 11:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOen4CPv3AaFstEaaZw7dWhm3OadNHSyjbmWrMLjNahTPF5N9X030tClLKXeV03XJEsOJPUnEYR+Rgl44h9V0N1N/0meD9tOZEQQL/+PYwwbHeAX9zBtfTw3reDdrVrnibuItX+1mXq6IGrsX54qs4FWjUCsqoIrJTpGmseD1SPDYF9xhUpvahHWBgxxQ1Pqbcgyq5tmv9zHx+mRYZ/3IYp3zRIqwq2XAQ3HjUv+8nWJUpHIRmma1zaSeesYFR+TzgIDKbriX0lSvsN6Sk1zi9AJjhqeVuZjfBYwWRPqirNT5sKBHVvejTpb5Lsr0JKzIJdeCIzk8Rr3hRK33SH2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFYD2DlZr3jSYTUe6Cs1smYYVzRjUM9YOonY7hi+VP8=;
 b=lxwNS1tIk6VYOadLj2hv7UOLiJEEPFeP+vKEk23Jc1vMyZ2XNSDgG13W7mFngQbE9eJidhG5IuhDXDN3sXBURanj8v+gClfJ7qskqik/s+A+5/MNfH331cVnmMq8hWThcpGjb4MRt+qYoy9TQvZkqvNbYUzn6dMDvUTICJ50l5NJ48UBpXvJxwl33CqNh1dzRw/SxB9qBBAn4zxTlTeSZvoK7W+3FUN7/fRcjUh9xB5ql48AtIp5v0QdxSBEW4FRZPyLfjPUECcwMhewXmgMfPPt/zUVTd0NhXJocuS2tQzcBlmwG/XGCKKBpKm9Dq7xrWRAa/QWLopEhC0oU73D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFYD2DlZr3jSYTUe6Cs1smYYVzRjUM9YOonY7hi+VP8=;
 b=ksXi5eYP5WqjW/aAnkKULzdfoQHCxol/umQ5OHp8Ong8KcG8jP5gMOdOwKap7a+KyDBSuL8XGYnOpIpRoita2OM0ktdHbURw5+wjXI2Uc4o6YVSuxEGZMPQpMKoW0HEesEctIccPCeXxqU+Dh4ceO2+bux3OB8H/sHRislVZArw=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by CH0PR18MB4196.namprd18.prod.outlook.com (2603:10b6:610:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 18:12:14 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 18:12:14 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre
 Belloni <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>,
        Colin Foster
	<colin.foster@in-advantage.com>,
        Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH net-next 8/8] net: dsa: ocelot: unexport
 felix_phylink_mac_ops and felix_switch_ops
Thread-Topic: [PATCH net-next 8/8] net: dsa: ocelot: unexport
 felix_phylink_mac_ops and felix_switch_ops
Thread-Index: AQHasrzmOpY+9W3IhEaqFW34TNdMmw==
Date: Thu, 30 May 2024 18:12:14 +0000
Message-ID: 
 <BY3PR18MB4707F64261CF77ACEB2AF4B2A0F32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-9-vladimir.oltean@nxp.com>
In-Reply-To: <20240530163333.2458884-9-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|CH0PR18MB4196:EE_
x-ms-office365-filtering-correlation-id: 56877b60-a274-401e-1fc7-08dc80d408a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?w97EHFK4qOTirMIcl6bGT3colPt47gjhWaZ+pDRZuMo5NIfhUsqawT2yHs1Z?=
 =?us-ascii?Q?jrTKDV4MoydDGrZisIIYCw05bb+3dpDIP7q3c4X2rC91LqoZwN5yxIBCmuyW?=
 =?us-ascii?Q?c6anViPOWy/NDyQkv9POrGu4COoz5Ej5C3hSZFSLNz59R72F3//p7HdUtjY/?=
 =?us-ascii?Q?zeMizeUlJqA4ipANGgjz1SWH5mHmeDu1HNBHPSR/ziSkEq+/+X6AHIj2hf8p?=
 =?us-ascii?Q?JrTe0B/c8ve5FUfLgUWzbFHYh+efySP62Eqp8SwG87VJJC73sFAnV1GeQH6w?=
 =?us-ascii?Q?ixZDWp70ARqGrsc7W46Upm9f8vewCSYe/MQWFc3kZkR66GMXiiXNgqcK2OKZ?=
 =?us-ascii?Q?YbqcPX8ImwxPV2Mkhsdy47PbIYtROOCbUWw9JqVawpFjua0acNuOEi6xDlRV?=
 =?us-ascii?Q?Zv2Upubap2rljbyYYhbYgZQpigNpTgstdUwu21SHAi5F+vs83PzaVEzwrdp/?=
 =?us-ascii?Q?/4vkFS8hnVK+4sMoxAm1Wws07ZHzL34u+If+PZdd5++lNikV9XoF9xjLcJY6?=
 =?us-ascii?Q?7H82RcYvUlEtAXrUUPjI3UgRYdhL09yVgwrj+S8480Hxsb2Xp4WkB6/ziu2T?=
 =?us-ascii?Q?dLxfparL8TT7Nr4Ieup37VNXNQ+QaFsh242+YGxX93/WysC/E4g2FU7RATiN?=
 =?us-ascii?Q?cVqGtJI0SonLteT0k4yeTsgBDMwk6W4gX1Pl125vmH5UiOEIw3d+i7v0iuGg?=
 =?us-ascii?Q?wzgBLf6no8XLSNyFpWYecyK7A3KHGlclC/h1ev27hAaIiU6to+mE/lVn5lc8?=
 =?us-ascii?Q?bSKPw/dqpH5vOKP+duhW6z5Od5pZ+Sh5g5zTWuiJKHe3tg9kLizeDRAPVsFM?=
 =?us-ascii?Q?zcNbwkf1ckp/evo9Q1HtXoB803n0Is1e8gR4mgjfEBLpjvrmW0XXsnDb1E39?=
 =?us-ascii?Q?PMLNaXg43Wm2sl6AjAA/9K1cr86BD5DjsQuVFh94HiAdOsXcgv8ZXZoDQXEt?=
 =?us-ascii?Q?l8IFL5hW+bYDdzuhGA0MGF7NFHIMcaDqToatsGF/4HPbQcQEELCewLiNh1we?=
 =?us-ascii?Q?mGGu5Gc16LTnXQci1yw+o5J8Mn7LGtorydORObXzJzZztpDy0t4EvqeWj1Ri?=
 =?us-ascii?Q?XzjgVTPIZbF961IVSDM0lD578/cIXZTkReyhXmpFK/P0piMyrpUARH+UIDQ6?=
 =?us-ascii?Q?yydGiaqU8mB25QE8h+PM8a1Vsrfn1m9q8tXRWtWHPCnZBvtFyMp/SvYcZjAx?=
 =?us-ascii?Q?XseRIe68R5sTwViZZ0lO0qbtYooig/AZw1towkPuV+hwVlMh+METx/yrQ3fl?=
 =?us-ascii?Q?Rp2lTx9t5g9HqeSTIM3SpIIjya/tlnwxjHKzNS7wQgB058IhxB6UlJYBwZyD?=
 =?us-ascii?Q?r/WJwEe4RLyy0VlU7xRAZubk?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?12gLuGCPmh1WJcjjRD38nkEv/rYietDc/7Hg905SR2K7I3nXtk12MaW3APNp?=
 =?us-ascii?Q?mqCFZZIqpgpzWUWqunUSaI+yHV6hnCYu4yE2O6txlk8T3WrHjUEiHhb8HMBO?=
 =?us-ascii?Q?G2nwB7RDW0HDxSpeXFT+aB2tfuxhHuOIxZapPXyn4ekdb8gP8KvDfXN4dA/x?=
 =?us-ascii?Q?1gH5/Q9qOhNwLh+9g9cL30M3aLorLixNdGWLv+9dZrhSjACEvfUqbMlMIuUF?=
 =?us-ascii?Q?YcFAH8TYbku8L1hsp8DBXZNGB7BRZnha0YuBxYDeI/xYkR3zZvlipZ2qtR03?=
 =?us-ascii?Q?z7+8MNT3CJ/aVOdZzGmsx+2b+JC4a0CLBa/q4LuvBJpS1YYxvMd+QDJmzTTA?=
 =?us-ascii?Q?Sgc1fVD8TKi2KMG9kMGfexiyN7SVWATXlD/Z8PaBc1OMWUE06a+NzFWwpLhS?=
 =?us-ascii?Q?me5TMoYbb3CXzOTa807nirakuXgd1dAUFjJhslJLhZLcdKCuddPoLIpAgUmV?=
 =?us-ascii?Q?B3PGqq0YzX3wSXYDfoKzdQ4EeMEWq/Yevu22v/HVO/YvTJ0s/5GGVQoXR2iK?=
 =?us-ascii?Q?XCbbyyFSvkhhQuxebOaDeND9u4gOZdc9HDxkIFvI03TtxPLGqN+Numn13nB4?=
 =?us-ascii?Q?ej9xoxDVnBmLwjbGWLeZhwjEHs+jukUPqb1ubV5MBOmiaL/TNNkOPR/KLIjU?=
 =?us-ascii?Q?HfKvOzYHyOXmLIlOdMBaNRKm3SmJDILZHO6zPL9IUvaigG2Nx0995WiTLP0X?=
 =?us-ascii?Q?Ci3UjSQgKb5W8JIrj8AaXHV9c+G2pM7n9gDb6XMER/lY5cjShub6+PTOHQZu?=
 =?us-ascii?Q?wEzTFD+DqBOMkhdWje2CfrNQKy4zOM1QSog9YxeksmusDEIJb1+V9hIfse6S?=
 =?us-ascii?Q?yl6gMw2aBabSvoymE/vrNwUyqI/n5UeEksopBt01DYGiKY+DpY9XoMoGJndr?=
 =?us-ascii?Q?+Q20+tJOpDXg/hZbBOc5f0J15XZ6TrhST4DO+2KnYVb0RDmuW31lVFbblng2?=
 =?us-ascii?Q?hcpn7yI3JZR6qozobjbPudZitQEKY3w1T8raFLW6X3PYjL3ZXAa1oDWEcnqj?=
 =?us-ascii?Q?Z6OjuSNb0c3VAvloUjyi00JzDswMOvMyHw+aca+5HFhK9bmiQEDOZX40er42?=
 =?us-ascii?Q?c+TegmxadaWSEzqNAEOK51hV3ewFrVKD/wFFKdr6o51p1JXJvtKucRyU1xEq?=
 =?us-ascii?Q?MbN8SN6qCMCmbc/WK1m1PdiRzZAl/aYPIAtbZ+A8sCbnEZV7+Exyx2buyzwa?=
 =?us-ascii?Q?OJqkRauTLGNZ4pDbkNGU0U5XG+0aLYuP295TqMXK+efjxOJ4bZiG6tWdev43?=
 =?us-ascii?Q?r3wLRrqMhsMm0oqT4nk/PWivawsmr/u7MUT48L5HrupiXUNKpLFSvKZOzvQ+?=
 =?us-ascii?Q?ZeXt3UD+vQL9Rr7En26M2bsvlVn7v1W5bqefvDSbOwW1JZCWnbG4tFT2RBSD?=
 =?us-ascii?Q?F/PdYB3Sj1EZfuI0er/RJMI0sVNT1Fq7W4GSiSk/aSW1zHV9Y+Azlu9/uQPg?=
 =?us-ascii?Q?ZFMrW51y/nUOLr64vLNCJJP5KBF1cNLCwI3MnCboqe3A8ba/8J3id9zI55zh?=
 =?us-ascii?Q?TMyBamCGpqgVg44c49ub1/CdN7HaZHGl0eS3L1sGit4CFt+KXiZaFJDi+1q/?=
 =?us-ascii?Q?uOP7eZTPywE6PIqDx0bcqXeRz8JRhX1xrBQ/10Kd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56877b60-a274-401e-1fc7-08dc80d408a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 18:12:14.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlMk2S6JJ0UiE2GsxEc8Oe1DC90eFDa5fx1CjRTNCk4VL05YSUSwBE6zTcHHpRzwQBdHsagCYSPdf2PS1J605A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4196
X-Proofpoint-ORIG-GUID: Xv-SFbMpQCtAOGe_kdboED3y_18PyT2W
X-Proofpoint-GUID: Xv-SFbMpQCtAOGe_kdboED3y_18PyT2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Thursday, May 30, 2024 10:04 PM
> To: netdev@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Claudiu Manoil <claudiu.manoil@nxp.com>;
> Alexandre Belloni <alexandre.belloni@bootlin.com>;
> UNGLinuxDriver@microchip.com; Andrew Lunn <andrew@lunn.ch>; Florian
> Fainelli <f.fainelli@gmail.com>; Colin Foster <colin.foster@in-
> advantage.com>; Russell King <linux@armlinux.org.uk>
> Subject: [PATCH net-next 8/8] net: dsa: ocelot: unexport
> felix_phylink_mac_ops and felix_switch_ops
>=20
> Now that the common felix_register_switch() from the umbrella driver is t=
he
> only entity that accesses these data structures, we can remove them from =
the
> list of the exported symbols.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 6 ++----  drivers/net/dsa/ocelot/felix.=
h | 3 ---
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/feli=
x.c index
> accf737f7b69..d12c4e85baa7 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -2106,15 +2106,14 @@ static void felix_get_mm_stats(struct dsa_switch
> *ds, int port,
>  	ocelot_port_get_mm_stats(ocelot, port, stats);  }
>=20
> -const struct phylink_mac_ops felix_phylink_mac_ops =3D {
> +static const struct phylink_mac_ops felix_phylink_mac_ops =3D {
>  	.mac_select_pcs		=3D felix_phylink_mac_select_pcs,
>  	.mac_config		=3D felix_phylink_mac_config,
>  	.mac_link_down		=3D felix_phylink_mac_link_down,
>  	.mac_link_up		=3D felix_phylink_mac_link_up,
>  };
> -EXPORT_SYMBOL_GPL(felix_phylink_mac_ops);
>=20
> -const struct dsa_switch_ops felix_switch_ops =3D {
> +static const struct dsa_switch_ops felix_switch_ops =3D {
>  	.get_tag_protocol		=3D felix_get_tag_protocol,
>  	.change_tag_protocol		=3D felix_change_tag_protocol,
>  	.connect_tag_protocol		=3D felix_connect_tag_protocol,
> @@ -2193,7 +2192,6 @@ const struct dsa_switch_ops felix_switch_ops =3D {
>  	.port_set_host_flood		=3D felix_port_set_host_flood,
>  	.port_change_conduit		=3D felix_port_change_conduit,
>  };
> -EXPORT_SYMBOL_GPL(felix_switch_ops);
>=20
>  int felix_register_switch(struct device *dev, resource_size_t switch_bas=
e,
>  			  int num_flooding_pgids, bool ptp,
> diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/feli=
x.h
> index 85b4f8616003..211991f494e3 100644
> --- a/drivers/net/dsa/ocelot/felix.h
> +++ b/drivers/net/dsa/ocelot/felix.h
> @@ -82,9 +82,6 @@ struct felix_tag_proto_ops {
>  			      struct netlink_ext_ack *extack);  };
>=20
> -extern const struct phylink_mac_ops felix_phylink_mac_ops; -extern const
> struct dsa_switch_ops felix_switch_ops;
> -
>  /* DSA glue / front-end for struct ocelot */  struct felix {
>  	struct dsa_switch		*ds;
> --
> 2.34.1
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

