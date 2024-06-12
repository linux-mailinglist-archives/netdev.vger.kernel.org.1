Return-Path: <netdev+bounces-102845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CB905082
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D653280F4F
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3316DEB3;
	Wed, 12 Jun 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UyZudoZt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77C16EBE6;
	Wed, 12 Jun 2024 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188630; cv=fail; b=lKyDqr5l9eNDLrEVMI1yaOQmjdBpEdTzIqTlDiX+FMHsofti/TO5+gSfQ/TzfHP14Z1Gi7wCLDkiz9j7NMx3Gd5LY9004grfEiMolXh7MA76nAe4wMSwDa78HlnZPQl4qy3RuNi2Vv2wLXwbnrE+OpWBFdeJm7fe7riDVnqYJ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188630; c=relaxed/simple;
	bh=4LM+abrtuUIfijl2TPy6hLNufmjf7ytvvjw4xOzQyy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=brZCbpOi2W6z3beCrMmymUQ7Tmm+blNzwMDaycJK7TozMZrr4c50+Jrh7gCTWEBXEd8EOuode2nT3wm+PKAcpxAWn9lD3e5hNYWHskeBN5XF6HF5wxqpE059jVQ8IszO/mskdnoj1M2Ad8Ke+VkpME4Y+puLGVyHsd6Bppo+bww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UyZudoZt; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C99tCc019595;
	Wed, 12 Jun 2024 03:36:46 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8syr8k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 03:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGF9TVZxsxGv/M1tnxEP8GsI5yNKDjk2prc0bGQRdigZ6Qw1QJP+Pw2RGs2+jdAGAk80YbPBvFR19qoBy+xSGGXrH32Zv/3ke3f5CWNZ68//e6zErhtGwHxTJkymZTZPPPQrY59Mf74GqwlkOrGgbcvbVEVARhI3Sr3eTw/qk8ylr57wL1vLEz1uxBSa+bn9nLaI1LEDWy+SWPMsJMqyGLd2ttLtB2cV+lpcrKcEZlFbJL0rqAgHO0Vui8rwgPCuE49kldoLz5QJ66NlRnhJomFOo39LAa6frupx7BmKJMu8QbC9KIGD7N+COHnpT1TyX1ULTOt1R/llR7mIo4IKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElJX5n85omUQHUc0NSL6OXp6Q7q+6OlhMuDH6eZeZOc=;
 b=fTUP/FaXiohwNYZHzyF8UqhhrmNXyrggu4ZBO8B/jzMOfFeFq53cy2V4roaBBkkJbU1qZaop05cKSNYIjEXaP+fjpilXqKC7N0KXLs5lkwFhCnps9WSjWR9LsP+MGpS7biQbDQcXnQ7h3nC/md1JHjNEvliRtWQ0Fnvkfp4T2Ze37Vo7o5cSG6DERNYNU/gzcKW6ZHXzFDPHgBbMwgyTh5qY5Rq3PnpVLNmLomflleBjkUG8XalgDSSDeLQ+N90ieV/uZlBAJB6xQVmyDZprW6DTc1HEQHGLfyx5bxmxlHB5nWbe/sg7IteLdqFXCdz9AfFG9dSrMNKf/LYG4h39gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElJX5n85omUQHUc0NSL6OXp6Q7q+6OlhMuDH6eZeZOc=;
 b=UyZudoZt0zWB4w6YelLxArp6oW/F8oesSxZ86RcrRXH4EKw7bGHpXE0LhhUmZIJCAOvTC2FawgKhoOCqQS0cajw+Vl2xM4+kgq7d0r8Qgohn5SGUuGMORYyMNrpjnb77mNqnEffwvsF/Zl2oyq4+jLMyGNk2vB1Pn7ND9z9oceg=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SJ0PR18MB4495.namprd18.prod.outlook.com (2603:10b6:a03:3bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 10:36:38 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%5]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 10:36:38 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Topic: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHauLmglNHUNJhH+k6V4cXh5B3lqrHDkmGAgABipvA=
Date: Wed, 12 Jun 2024 10:36:38 +0000
Message-ID: 
 <PH0PR18MB4474CB7ED482769F166FC50FDEC02@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
 <PH0PR18MB44745E2CFEA3CC1D9ADC5AC0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
 <89c92725271a4fa28dbf1e37f3fd5e99@realtek.com>
In-Reply-To: <89c92725271a4fa28dbf1e37f3fd5e99@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SJ0PR18MB4495:EE_
x-ms-office365-filtering-correlation-id: 0e5f300a-1e4a-4798-5b93-08dc8acb8a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230032|1800799016|366008|376006|7416006|38070700010;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JnIr1mWdQpjzxM5BFq/x3H6AGmoH0TWbtU0lTqn3QDZPmTDiVgk3pYtiUwI3?=
 =?us-ascii?Q?aC5ZPERUw69p0y2cJ1VYCpS3c2WPRq+/E+c+3L52YMUHMRxoIFX6FRGMKU6z?=
 =?us-ascii?Q?mcUrf3Lj7AIhQq6Jz897e3RTi5+Y2mnInVlH2shHMuzrAV79gseUsnTPTWPb?=
 =?us-ascii?Q?0y7/haClgABkaZJKV+vcxpHjkyYJRRLHqI3CgYdzaN84U14rxRPAhZHmRf3D?=
 =?us-ascii?Q?k5PDZ2fgMWgnwn7nm0z3/IIKyKwSDu45r/UiFTb8I4ieUnBdiXXI4eQ2r9Mw?=
 =?us-ascii?Q?Q3JWvyTnGQWbfgtZy9A15VBxEzDKIEJ/yMeQ9dDxzZOEKG4SUXUVQThbh6YC?=
 =?us-ascii?Q?G6lsoomk45orRxZaYF7YwSL7+XaVwnvhQqdgOE4fDdK4/WukR7jy9CFou38P?=
 =?us-ascii?Q?dGXzrStTNnjqbuYl9w05gEHHV1c+LzbFGM1V+t9XYOKr9fKORg/k1DMed+dc?=
 =?us-ascii?Q?qEgtgGkmVR7PlGxKNdY4PuBg5M0hHsVTWw4XtLCGNKAplylmf9U7URHlWKpw?=
 =?us-ascii?Q?nRaBD90jx4dpS9Ml2zN1jf2l8mstUkTOMPBBvTniQ6j7zt1/wn4O12EzjN3/?=
 =?us-ascii?Q?iQGZLm1qWedWn5LnjXdyIRSDbZJ9WzzTiA49mxSnJOfKNJ2K/6xcfCPahN3j?=
 =?us-ascii?Q?+9pZUEOohdG7M6YoQfTyuwUGPZHQTy08u/XIvC3j4LbtmZUYbPnZBnJsNo2P?=
 =?us-ascii?Q?hDsg/iLVX9a9B9P9Twmt2ck4xDlvQviR6ABfnBz/Qa8xc1jETpQVuWBcRQad?=
 =?us-ascii?Q?KfZh0YsmbX/5qUtOrW4ibYqfDvAAzcKvgsLg35Ql2LsSi0ptJFR0OHsq1stb?=
 =?us-ascii?Q?mOR+za+/ANWKfPe9fVJ9Tnner0WBpwix4lexuG2a3gY51eh0Pxz547XUX3uf?=
 =?us-ascii?Q?73k41iLdaS3tqXJ2lTxsa6JDwoeSxVWomzzBXUQs1rlbfVySsF/gnsT/DsFb?=
 =?us-ascii?Q?oIiQRwZLy/2f1rX0SWhmNq/PLK3K/5MT7DN3SfIIfewU26qQtxhW4ENE660i?=
 =?us-ascii?Q?TBizpFaKa6hUUM3XD8gCvt5BVoMDSYM4lOB16xsbm0tp5i4wS5PPkXTiilm5?=
 =?us-ascii?Q?AodbFFlQlpj/QqBMPB4/s4svri78xe2VPdpFMHPWfJtqZxp1Z3LVHbYYSj8B?=
 =?us-ascii?Q?yT3RzA2WFrB0hPk3rEBFJJs9B5ovmU+L9uZM1UUFy1K4zbtJgK+GLlA9Ugxo?=
 =?us-ascii?Q?C8KVeP7afb/6/SyGcKaZJPjDZjmD3na3bUXFdGrUgLj1wfsR/IpPnsEMYNTN?=
 =?us-ascii?Q?A5UAwXspn6PTn+h5RuvQxYl0uxOHRXt5ivtP0ranExmml2yZxVhDloxq4m1I?=
 =?us-ascii?Q?MVCqJL+hyVAAeYPBoufgNOOyR1EjxvtL7NzZrGUKbxiBlu+Ctm7qDtE1haIG?=
 =?us-ascii?Q?diDSCwU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+1UEz2tvYLl75LcWD4i08p7f4oXEhKDKuldGYgdxK0l7te1QZnSW5Lx0NCd8?=
 =?us-ascii?Q?/7aGpcqefCZkVgUnrg0L2rf8hsAp3Zdy/JNmpxt3p5jc3Z/AOUDCK3jbdGaJ?=
 =?us-ascii?Q?5TgVNVmNa9mnnuKR/8o57Q3YFu4cJ7P/6bbBlf0voq4BvFFspM8k+Gskw8iM?=
 =?us-ascii?Q?niL/yugfj+t1vlAZms63nbi6MGi2oMww67iltML8dDm5HKcJBmtjanxQxPlW?=
 =?us-ascii?Q?Q2wJ4uLUovvP0yUYbI70KOkfTXJsKztbFkn2aoQr13lf+b01BlUpYEiSDsX+?=
 =?us-ascii?Q?QAxFVSGInCNNvmZhBnhOO9D3BSChobIuJhhm6dEGx8UtxSlW6e2fI+C4UK1K?=
 =?us-ascii?Q?SO7YKsk80fbGvM5aBBQs9EObXqW9lVrwpjUnXMclrSuug7PV3pvoOYX92G28?=
 =?us-ascii?Q?sHKNU2km5YUdPa/0HnKoWeHfKm1cchrDbV4YgEXWQf1azmgS9GqwMKlLFHDF?=
 =?us-ascii?Q?XpCHjO5pOaXuQMk791FY9dNQdjl99U8L4KKVfE1H/JrSOIKQ4+QtqEsoy9Vz?=
 =?us-ascii?Q?b5g17RbIPeiEUU4dqy27U6vmp7cQn0LEGr1u4LKLAK1il3HUfVk88SBB0aI6?=
 =?us-ascii?Q?XkCNczSbftuHoEy+D/Ef0OV0W7MPo21+cLyEkYiIuRFta9Yb3TVsrZDRaBM0?=
 =?us-ascii?Q?GIllc0VhyoCHxKT738AIudFyezZqDivVo+Iyc2DGRxvedw0oAMGQUeEYSOgp?=
 =?us-ascii?Q?8QbQkBNffUtOBmn/by+YqfKxHWHzrVEXSs1e0cL1X3BJlgtoAkif25+6Yaus?=
 =?us-ascii?Q?f5OQoaOmbTfeRmaJKKrpgEwDz3y8tinMp0/vndT17PjhPhjO4yofTfsETePK?=
 =?us-ascii?Q?/AMgt8fRQRsK/Mxh86oS7XtPkxMFVsfK5Ldo+Jm7TKVltSJSCoTYDs8MQrif?=
 =?us-ascii?Q?SX928xo+/VEeQEqOmpNPsaitN1SFs3H+gq09lK552bvaaaOHD5DANUybFldb?=
 =?us-ascii?Q?q4OXSl9xZGnuA9LHekP8xnhZZOh7knq7XjG3K6Eomex+T0ubfTQaGZM26I7f?=
 =?us-ascii?Q?J0RfwE4yyTwhf/bhBtw6W4s71HPfZjDupD5q9c7DzbhCBVThPJD12TuqS8qh?=
 =?us-ascii?Q?ZL0m6eZ2bGhMe7YLAkZDgYD7Yai0spd/vF+1U48gJyqdgtxZHpZy/mkHLdT0?=
 =?us-ascii?Q?0A3oknshmzdNvzUy/L9mezMMa292SrqONyvKhcdfbbM/4ndhW1B+6qzGOkel?=
 =?us-ascii?Q?E+MfXFVfTs1fmSIFyqZbCdTTSds0hyndGf1WZjG+gAkMnH8AqTFxL6euEuzA?=
 =?us-ascii?Q?qnkJVw1U+lgATF7/a4zI70vqHvmpk5GauNO6N6puy0FIlfWAsMjKy7gJJCYQ?=
 =?us-ascii?Q?PCj5/KowVwednB7FqAfG1gfPFU3xxQPzcnxoL0qTXW+W1imxGDmpNfr1wzfh?=
 =?us-ascii?Q?g293yWRBN4pLMw8E+lJD0Y98KnfLfZV4aTAQcsJpgvAyB4R0KSCStVGT0OAx?=
 =?us-ascii?Q?f3SXDYbUhKwPKoig6LvL/ruwnvBWkz7Y1wwJAzYAMjx1+oIQPTLZOZgKKf8O?=
 =?us-ascii?Q?gfr5xejEkzGibehKgk46jeGAZ0Syg/x13ShlHiE+YnLlzciMk3DwYmr84j03?=
 =?us-ascii?Q?J/3kUoF12uKL+7wdHf4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f300a-1e4a-4798-5b93-08dc8acb8a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 10:36:38.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1fOkoxFJSGsfiwX8Hoj3kq1f7vNk7CkyAArW9zJQ5l7rugO/G5zcm6A6z0P2+9KmfIMlEeG03w8Pp0m6Xnj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4495
X-Proofpoint-GUID: u0p4VsQBjE0kuq3NpeFimk25P3kjEsbW
X-Proofpoint-ORIG-GUID: u0p4VsQBjE0kuq3NpeFimk25P3kjEsbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01

> > > Implement .ndo_start_xmit function to fill the information of the
> > > packet to be transmitted into the tx descriptor, and then the
> > > hardware will transmit the packet using the information in the tx
> descriptor.
> > > In addition, we also implemented the tx_handler function to enable
> > > the tx descriptor to be reused.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > ---
> > >  .../net/ethernet/realtek/rtase/rtase_main.c   | 285 ++++++++++++++++=
++
> > >  1 file changed, 285 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index 23406c195cff..6bdb4edbfbc1 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union
> > > rtase_rx_desc *desc, u32 rx_buf_sz)
> > >                  cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));  }
> > >
> > > +static u32 rtase_tx_avail(struct rtase_ring *ring) {
> > > +     return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> > > +            READ_ONCE(ring->cur_idx); }
> > > +
> > > +static int tx_handler(struct rtase_ring *ring, int budget) {
> > > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > > +     struct net_device *dev =3D tp->dev;
> > > +     u32 dirty_tx, tx_left;
> > > +     u32 bytes_compl =3D 0;
> > > +     u32 pkts_compl =3D 0;
> > > +     int workdone =3D 0;
> > > +
> > > +     dirty_tx =3D ring->dirty_idx;
> > > +     tx_left =3D READ_ONCE(ring->cur_idx) - dirty_tx;
> > > +
> > > +     while (tx_left > 0) {
> > > +             u32 entry =3D dirty_tx % RTASE_NUM_DESC;
> > > +             struct rtase_tx_desc *desc =3D ring->desc +
> > > +                                    sizeof(struct rtase_tx_desc) *
> > entry;
> > > +             u32 status;
> > > +
> > > +             status =3D le32_to_cpu(desc->opts1);
> > > +
> > > +             if (status & RTASE_DESC_OWN)
> > > +                     break;
> > > +
> > > +             rtase_unmap_tx_skb(tp->pdev, ring->mis.len[entry], desc=
);
> > > +             ring->mis.len[entry] =3D 0;
> > > +             if (ring->skbuff[entry]) {
> > > +                     pkts_compl++;
> > > +                     bytes_compl +=3D ring->skbuff[entry]->len;
> > > +                     napi_consume_skb(ring->skbuff[entry], budget);
> > > +                     ring->skbuff[entry] =3D NULL;
> > > +             }
> > > +
> > > +             dirty_tx++;
> > > +             tx_left--;
> > > +             workdone++;
> > > +
> > > +             if (workdone =3D=3D RTASE_TX_BUDGET_DEFAULT)
> > > +                     break;
> > > +     }
> > > +
> > > +     if (ring->dirty_idx !=3D dirty_tx) {
> > > +             dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
> > > +             WRITE_ONCE(ring->dirty_idx, dirty_tx);
> > > +
> > > +             netif_subqueue_completed_wake(dev, ring->index,
> > > pkts_compl,
> > > +                                           bytes_compl,
> > > +                                           rtase_tx_avail(ring),
> > > +
> > RTASE_TX_START_THRS);
> > > +
> > > +             if (ring->cur_idx !=3D dirty_tx)
> > > +                     rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)  {
> > >       struct rtase_ring *ring =3D &tp->tx_ring[idx]; @@ -1014,6
> > > +1076,228 @@ static int rtase_close(struct net_device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
> > > +                          const struct sk_buff *skb) {
> > > +     return (skb_vlan_tag_present(skb)) ?
> > > +             (RTASE_TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) :
> > > 0x00; }
> > > +
> >                Vlan protocol can be either 0x8100 or 0x88A8, how does
> > hardware know which header to insert?
> > Thanks,
> > Hariprasad k
>=20
> We only allow the hardware to add 0x8100, the VLAN must at least have
> 0x8100 to potentially have 0x88a8, skb_vlan_tag_present indicates that VL=
AN
> exists, hence at least the 0x8100 VLAN would exist.
> >
Thanks for the explanation, but one question which bothers me is that "how =
hardware knows offset with in the packet"

For example=20
Case 1:       DMAC  + SMAC + 8100 VLAN_ID + IP
               Here offset is right after the SMAC.
Case 2:      DMAC + SMAC + 88A8 VLAN_ID + 8100 VLAN_ID + IP
               Here offset is right after first vlan tag.

Thanks,
Hariprasad k
   =20
> > > +static u32 rtase_tx_csum(struct sk_buff *skb, const struct
> > > +net_device
> > > +*dev) {
> > > +     u32 csum_cmd =3D 0;
> > > +     u8 ip_protocol;
> > > +
> > > +     switch (vlan_get_protocol(skb)) {
> > > +     case htons(ETH_P_IP):
> > > +             csum_cmd =3D RTASE_TX_IPCS_C;
> > > +             ip_protocol =3D ip_hdr(skb)->protocol;
> > > +             break;
> > > +
> > > +     case htons(ETH_P_IPV6):
> > > +             csum_cmd =3D RTASE_TX_IPV6F_C;
> > > +             ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> > > +             break;
> > > +
> > > +     default:
> > > +             ip_protocol =3D IPPROTO_RAW;
> > > +             break;
> > > +     }
> > > +
> > > +     if (ip_protocol =3D=3D IPPROTO_TCP)
> > > +             csum_cmd |=3D RTASE_TX_TCPCS_C;
> > > +     else if (ip_protocol =3D=3D IPPROTO_UDP)
> > > +             csum_cmd |=3D RTASE_TX_UDPCS_C;
> > > +
> > > +     csum_cmd |=3D u32_encode_bits(skb_transport_offset(skb),
> > > +                                 RTASE_TCPHO_MASK);
> > > +
> > > +     return csum_cmd;
> > > +}
> > > +
> > > +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff =
*skb,
> > > +                         u32 opts1, u32 opts2) {
> > > +     const struct skb_shared_info *info =3D skb_shinfo(skb);
> > > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > > +     const u8 nr_frags =3D info->nr_frags;
> > > +     struct rtase_tx_desc *txd =3D NULL;
> > > +     u32 cur_frag, entry;
> > > +
> > > +     entry =3D ring->cur_idx;
> > > +     for (cur_frag =3D 0; cur_frag < nr_frags; cur_frag++) {
> > > +             const skb_frag_t *frag =3D &info->frags[cur_frag];
> > > +             dma_addr_t mapping;
> > > +             u32 status, len;
> > > +             void *addr;
> > > +
> > > +             entry =3D (entry + 1) % RTASE_NUM_DESC;
> > > +
> > > +             txd =3D ring->desc + sizeof(struct rtase_tx_desc) * ent=
ry;
> > > +             len =3D skb_frag_size(frag);
> > > +             addr =3D skb_frag_address(frag);
> > > +             mapping =3D dma_map_single(&tp->pdev->dev, addr, len,
> > > +                                      DMA_TO_DEVICE);
> > > +
> > > +             if (unlikely(dma_mapping_error(&tp->pdev->dev,
> > > + mapping)))
> > > {
> > > +                     if (unlikely(net_ratelimit()))
> > > +                             netdev_err(tp->dev,
> > > +                                        "Failed to map TX
> > fragments
> > > DMA!\n");
> > > +
> > > +                     goto err_out;
> > > +             }
> > > +
> > > +             if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > > +                     status =3D (opts1 | len | RTASE_RING_END);
> > > +             else
> > > +                     status =3D opts1 | len;
> > > +
> > > +             if (cur_frag =3D=3D (nr_frags - 1)) {
> > > +                     ring->skbuff[entry] =3D skb;
> > > +                     status |=3D RTASE_TX_LAST_FRAG;
> > > +             }
> > > +
> > > +             ring->mis.len[entry] =3D len;
> > > +             txd->addr =3D cpu_to_le64(mapping);
> > > +             txd->opts2 =3D cpu_to_le32(opts2);
> > > +
> > > +             /* make sure the operating fields have been updated */
> > > +             dma_wmb();
> > > +             txd->opts1 =3D cpu_to_le32(status);
> > > +     }
> > > +
> > > +     return cur_frag;
> > > +
> > > +err_out:
> > > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> > > +     return -EIO;
> > > +}
> > > +
> > > +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
> > > +                                 struct net_device *dev) {
> > > +     struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > > +     struct rtase_private *tp =3D netdev_priv(dev);
> > > +     u32 q_idx, entry, len, opts1, opts2;
> > > +     struct netdev_queue *tx_queue;
> > > +     bool stop_queue, door_bell;
> > > +     u32 mss =3D shinfo->gso_size;
> > > +     struct rtase_tx_desc *txd;
> > > +     struct rtase_ring *ring;
> > > +     dma_addr_t mapping;
> > > +     int frags;
> > > +
> > > +     /* multiqueues */
> > > +     q_idx =3D skb_get_queue_mapping(skb);
> > > +     ring =3D &tp->tx_ring[q_idx];
> > > +     tx_queue =3D netdev_get_tx_queue(dev, q_idx);
> > > +
> > > +     if (unlikely(!rtase_tx_avail(ring))) {
> > > +             if (net_ratelimit())
> > > +                     netdev_err(dev, "BUG! Tx Ring full when queue
> > > awake!\n");
> > > +             goto err_stop;
> > > +     }
> > > +
> > > +     entry =3D ring->cur_idx % RTASE_NUM_DESC;
> > > +     txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry;
> > > +
> > > +     opts1 =3D RTASE_DESC_OWN;
> > > +     opts2 =3D rtase_tx_vlan_tag(tp, skb);
> > > +
> > > +     /* tcp segmentation offload (or tcp large send) */
> > > +     if (mss) {
> > > +             if (shinfo->gso_type & SKB_GSO_TCPV4) {
> > > +                     opts1 |=3D RTASE_GIANT_SEND_V4;
> > > +             } else if (shinfo->gso_type & SKB_GSO_TCPV6) {
> > > +                     if (skb_cow_head(skb, 0))
> > > +                             goto err_dma_0;
> > > +
> > > +                     tcp_v6_gso_csum_prep(skb);
> > > +                     opts1 |=3D RTASE_GIANT_SEND_V6;
> > > +             } else {
> > > +                     WARN_ON_ONCE(1);
> > > +             }
> > > +
> > > +             opts1 |=3D u32_encode_bits(skb_transport_offset(skb),
> > > +                                      RTASE_TCPHO_MASK);
> > > +             opts2 |=3D u32_encode_bits(mss, RTASE_MSS_MASK);
> > > +     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > > +             opts2 |=3D rtase_tx_csum(skb, dev);
> > > +     }
> > > +
> > > +     frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
> > > +     if (unlikely(frags < 0))
> > > +             goto err_dma_0;
> > > +
> > > +     if (frags) {
> > > +             len =3D skb_headlen(skb);
> > > +             opts1 |=3D RTASE_TX_FIRST_FRAG;
> > > +     } else {
> > > +             len =3D skb->len;
> > > +             ring->skbuff[entry] =3D skb;
> > > +             opts1 |=3D RTASE_TX_FIRST_FRAG | RTASE_TX_LAST_FRAG;
> > > +     }
> > > +
> > > +     if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > > +             opts1 |=3D (len | RTASE_RING_END);
> > > +     else
> > > +             opts1 |=3D len;
> > > +
> > > +     mapping =3D dma_map_single(&tp->pdev->dev, skb->data, len,
> > > +                              DMA_TO_DEVICE);
> > > +
> > > +     if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> > > +             if (unlikely(net_ratelimit()))
> > > +                     netdev_err(dev, "Failed to map TX DMA!\n");
> > > +
> > > +             goto err_dma_1;
> > > +     }
> > > +
> > > +     ring->mis.len[entry] =3D len;
> > > +     txd->addr =3D cpu_to_le64(mapping);
> > > +     txd->opts2 =3D cpu_to_le32(opts2);
> > > +     txd->opts1 =3D cpu_to_le32(opts1 & ~RTASE_DESC_OWN);
> > > +
> > > +     /* make sure the operating fields have been updated */
> > > +     dma_wmb();
> > > +
> > > +     door_bell =3D __netdev_tx_sent_queue(tx_queue, skb->len,
> > > +                                        netdev_xmit_more());
> > > +
> > > +     txd->opts1 =3D cpu_to_le32(opts1);
> > > +
> > > +     skb_tx_timestamp(skb);
> > > +
> > > +     /* tx needs to see descriptor changes before updated cur_idx */
> > > +     smp_wmb();
> > > +
> > > +     WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
> > > +
> > > +     stop_queue =3D !netif_subqueue_maybe_stop(dev, ring->index,
> > > +                                             rtase_tx_avail(ring),
> > > +
> > RTASE_TX_STOP_THRS,
> > > +
> > RTASE_TX_START_THRS);
> > > +
> > > +     if (door_bell || stop_queue)
> > > +             rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > > +
> > > +     return NETDEV_TX_OK;
> > > +
> > > +err_dma_1:
> > > +     ring->skbuff[entry] =3D NULL;
> > > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> > > +
> > > +err_dma_0:
> > > +     dev->stats.tx_dropped++;
> > > +     dev_kfree_skb_any(skb);
> > > +     return NETDEV_TX_OK;
> > > +
> > > +err_stop:
> > > +     netif_stop_queue(dev);
> > > +     dev->stats.tx_dropped++;
> > > +     return NETDEV_TX_BUSY;
> > > +}
> > > +
> > >  static void rtase_enable_eem_write(const struct rtase_private *tp)  =
{
> > >       u8 val;
> > > @@ -1065,6 +1349,7 @@ static void rtase_netpoll(struct net_device
> > > *dev) static const struct net_device_ops rtase_netdev_ops =3D {
> > >       .ndo_open =3D rtase_open,
> > >       .ndo_stop =3D rtase_close,
> > > +     .ndo_start_xmit =3D rtase_start_xmit,
> > >  #ifdef CONFIG_NET_POLL_CONTROLLER
> > >       .ndo_poll_controller =3D rtase_netpoll,  #endif
> > > --
> > > 2.34.1
> > >


