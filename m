Return-Path: <netdev+bounces-100858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9E8FC49F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7321C20EF1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764313AA51;
	Wed,  5 Jun 2024 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="M+Vgtgfg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA13AA4D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572842; cv=fail; b=WPNN8w72sxx3H9RiOGYlCCsC8eZYK2l9/uTLTcoPOTi3ttUctc5wGl8jhzwD95plm9fJ4mwhmBw9v/VxMf/2Lf7mbl9BHsgK36JmTpy7YFDsJgRoqBqqxs1rWHidWvWUgiEyU5r+CYcIavvaO7PVoYqfAs8MgV0Zu1kF9DzSMKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572842; c=relaxed/simple;
	bh=48oT/PWc/ClSiWnE6vWcQzVFlaBx6ZNe1vwSLFoGOm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ah9JxVCy0MvgLAjIHB2LtT/9qe3f4maS8i56CZjoML/uDSLNIzBta1mtLoGQKIZhlLuHzUgYaQhIrdC5axI2+C4oIzE78bh0etveUoDpzPzUTMrMr3QeqJ4rsU3pPkavqMp8DzCAN81y6pWItCh2QirYq41QL2mPcqOyP/h1CUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=M+Vgtgfg; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454KRqVJ004139;
	Wed, 5 Jun 2024 00:33:34 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167cb39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 00:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be/p50CAz2rxJ3wJDMJrZ2znYYIYzYiDHfWZH/21nRN97laPVAsIVL5MsVerqxUV4ussPZHvK2uf9xXsuyus05MDfkasvC6o2CcVl6UWWhF7T9yM9ZvQOHaxgEcr7WdKfGwOxR2qizcv8MqG6ID2z/76si+Glc+W9bSIlF0WZgPjSC7TwCM3J3/VYS20pwAxvuKxmCkM3H0BoijvMnQsWgozz3ormTfHBKi4mxZCwRtwky+f9A87VwADoyTvs3wbB9IiQNtPa/QDe1XgV9kKm1RWVApprGEhfNTIiHb+iMiiIa5ZpNuilbXs3ZleUnuah7n5eoLGe7n6N6udjNNgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMvrvMyl3WsBSPKUi6aiaIiooxFsVHIhGZ4RFGMC2jI=;
 b=jyorXDjdcmnp9m+x0R7cmmVwbmLIEKZG0KbTrwFtzcojjwIOw5v1D5GX0L1Z1RHxbVOymCRQXfql7djdqa8zCLUqUe7zp8DbOGlWicC+6sRWsG85MJ0DBJxcpSdJhBn8iAQyGZWdbDRZIelDZsqGIDG1xoqyudElWGHiKEXeHILNlGr3tA4w7upZdvzLs/RNnsocnFuUV09jAYbQdNmIqNumZIeJC3htjoK1buzarXtSoSPrF/G1TFDX+IKgKz6+JesrZSJWVSFmFWu7ytt3Lh4tX6ouLsSB5A8tLlaux4bgD04gG2+tiz33WX4VaQHqXGgCj8mQoWfevngCaKU2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMvrvMyl3WsBSPKUi6aiaIiooxFsVHIhGZ4RFGMC2jI=;
 b=M+VgtgfgNTjA4Dc6hpb3mA/Pub460ptbSvPGG+g6Ww6bdiSF3r0xAuE/JlDqSCSWy2xzVNu8JxY976BHPOVYV6KGiE/adAeUelS072axZAryEuxcAYmI6iT+riDDBDwF5bIOaXs3HBhIdveWGVqrxNhr0t0SavOS7udrUpWiQg4=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SN4PR18MB4987.namprd18.prod.outlook.com (2603:10b6:806:21b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 07:33:32 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:33:32 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 3/3] net: txgbe: add FDIR info to ethtool ops
Thread-Topic: [PATCH net-next v2 3/3] net: txgbe: add FDIR info to ethtool ops
Thread-Index: AQHatxqq6TM2n8jp3k+PefG2Oc9tIA==
Date: Wed, 5 Jun 2024 07:33:32 +0000
Message-ID: 
 <PH0PR18MB447474CD899ACBFECF63E9D7DEF92@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com>
 <20240605020852.24144-4-jiawenwu@trustnetic.com>
In-Reply-To: <20240605020852.24144-4-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SN4PR18MB4987:EE_
x-ms-office365-filtering-correlation-id: 923c0f46-006d-4e1a-962a-08dc8531cd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?htUY/gjneA+ZoR62ceocHm3QYE8sivncd4E0pJM0hsAFJAwGETLKHWpNqykm?=
 =?us-ascii?Q?tSqagEEepMP4C/B3SuAmb9/9M4MWQJMKul0QAgdI6qVna2UHK+ybfYa5Le+A?=
 =?us-ascii?Q?VZeHaiiO+80+tAVIiIbqvxaVeyv6pHF1AOmobAXpn5CVQ4ax3awLVT1OoIHa?=
 =?us-ascii?Q?74HY2BeywcgDkf+v0+M5GilKgGIhGcNPRoBvtiLmO+B8leqQxrXJbOTeICgy?=
 =?us-ascii?Q?XH3vrCo6R+yPvqIZkIRmztltNuF7vtJthzH10rmmG/+4eAxkLmmYa1OMGdHE?=
 =?us-ascii?Q?Ir0Pt+7jebnOQZI4N9aWPy3e24uRk7WK1ENixy+7ZIv65wKEweHnAgIX1aFx?=
 =?us-ascii?Q?AhNcMxIdO8F60ibagFfYVxb4OEMeA1mPiC7X10zace0d6xEM8wX5NwM9lMj+?=
 =?us-ascii?Q?ccNiYvRcn/d6DR6wbEz/M8QZ0CSwtubB6fx8voeWD/a5gtcH0Q4DON392260?=
 =?us-ascii?Q?UgYRXmuXs3zg3o04kgHC+c6Z/KBf3xSd4VceXM7JBSHLLOcZHAsfgBxdaR4f?=
 =?us-ascii?Q?hGocvsMqtLK2Y7OLE39KUdbmsetk3ucnqvEl2VvXQVHMHBw6ncbcMEGFhCEa?=
 =?us-ascii?Q?uPwbY+jKfRrxo2PATcpF9rnzecZjS75SPKfAdity7PbXZ4gPBJqXxY4Iy4AU?=
 =?us-ascii?Q?N2KP8eLSepLa+z+nUR6Ch+hPi8wGmYe/j8oIkgihZYymweijM4r7OgIwiyXw?=
 =?us-ascii?Q?mZRym1ofinYxZoZBLpNMs0OueQgVS8meicCHL7wIVU+NDSx6l4VeJB9Nqoj0?=
 =?us-ascii?Q?/6Mz0BQK/75uNwIweLG099EXIhd5CCfsffaukDOUUEpC9cg5qkjUXJ1fRH3H?=
 =?us-ascii?Q?VvSQ9/3B8XwXUCGqhrmU+zmZklqmy1Rgs8dQ+c7Eor2oSALBIby8PlsoWIxB?=
 =?us-ascii?Q?awPjqFD4OKEFOWqLStUc2VMg2zqWX/CM2QpOJ0Y2OnwpsQxPuks6utA5322/?=
 =?us-ascii?Q?VvGXNmHU7SdCA2Em42Y/83dyN+Wi4c3iF4j40+xFvYI6B4CqfMc3Tt9kl3yZ?=
 =?us-ascii?Q?exMche1BQLE+NteKZA8PL6FtjkLp9X1n/jvXZ3L+8sQQDfF5PDA7DDrUUqA4?=
 =?us-ascii?Q?1O9839SDzFA747v6dPrIHv+hK3XKSNZhr/X0zrooIcdVDjI3B52UH4z2p877?=
 =?us-ascii?Q?0jFMRGaNdRAkLjqE8OMkSpzV+kWbVwcC5ZNAy9YSm2xEt+Ql3vcyuTk/rLyv?=
 =?us-ascii?Q?IKiGGce/BrO9vlDy5gYTKeVG5KFGu36flKKaQC8UEOS1VALh4J6lEXfS5ZbO?=
 =?us-ascii?Q?4zn008HRBj4W1ct3JCtbsldxIN7SHh9bU/WCJ0DD/8oa8lwNVHpb+v0QZlJB?=
 =?us-ascii?Q?4Q76GB6r8wVjLu0blM44HMS1zN2yqFSonTkqLMeEN9lKHA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zCw98rE8PJatyBWgozjRZoHgB5Pu0U9VJNhRa6HpNH8QeXQdIlhO3eNiy71W?=
 =?us-ascii?Q?ZjAhevDHfuu/i/3fBK5oMu/oUICPECEiasi8t+rG9RuwE9jUMV9OBnGAuuVe?=
 =?us-ascii?Q?ro+adAp5naz8p5F0Jd2CVB5b8ene+l96MdtG4PzbyRHkBF+BOuMO8NPsaXLG?=
 =?us-ascii?Q?ojzay/35osSlfa8UTMfteZOYnLYhAOa7J7hGJJC2MXs4O6a255FTQGyMmdeN?=
 =?us-ascii?Q?rI59lId/xu2Edi0ILfenSqDa6Zq5SCCVcZ/SYPXPePsQAAUM3nheNkKfgRns?=
 =?us-ascii?Q?Jl/1bhp83zoC9N/RgRsMH2BQhZDC9Sk1FtfoPowRpHT139/mhG2/2rUMstWO?=
 =?us-ascii?Q?Io7+1yBddBP7jJPio45NcfpsOkxXkA7bPa7bxOrgWZld7v5owTXJ3FPonB7F?=
 =?us-ascii?Q?SZTBLL1y8zb9t8SM6i9jt4tK1nVyWn+VPuy3aPpjR1EaxK/rT/mkyx8bhl3H?=
 =?us-ascii?Q?pMRWPdy5WEnT50f1Pl8wNMxouuRZ8SNZamm6KEMJOZKpOWQD3/fAKSdgyvli?=
 =?us-ascii?Q?LnF4UtTQP1zK0hTTnI9FeaQbxGKcvcb3msUTWBMewiwFRyePZEAektPthTgS?=
 =?us-ascii?Q?OAhHqGW4q9x6TvllvvLbrBOL8Dcezv8Qp9XVSQnBc/yxnx+kZMoDBPUOjgKM?=
 =?us-ascii?Q?UyLpZPYQCdZgbxwQBhPwPvKRCkRQTxxKELrxpmUOaluTRQJPGo41fZhtrh9/?=
 =?us-ascii?Q?kzhTshYBcq02L5Q0WHiQuNMNr2e2pEDM5vfs2eoUY5ILcv4quLUlpavti4a6?=
 =?us-ascii?Q?AEb5SptYqmXSQt+B4t3rliaLnEgEWhvuRnrzTok+tUAxXtrRlacdTEcoZU2h?=
 =?us-ascii?Q?ce6k6pKE0g7Em0eVj7Wks/x4/P/XdiEcnMibl2i31VsjRpk3Gme4YT45/TwX?=
 =?us-ascii?Q?4mPdhEn8p0Xd2SVntUcQCNlsVQBBtA9EfpT97Aa0ZiftRJcXIKZPRDMQI4t8?=
 =?us-ascii?Q?BMRz7MybC327QUkiIaNbJz9lw47Z0sqvQBtU+qFtHedRfl9LB7mYX1zw+4id?=
 =?us-ascii?Q?boyHtS47cxtLvgKPXXtipVc5AkUfdcuRfzVYillTOrFhlf1JpAqJKga+zh8y?=
 =?us-ascii?Q?mH2TnhInl2yPxi+YR8uUoqgUVQACE0pL1f6DIySIE0ZFTFS70KOBF2FlPmjF?=
 =?us-ascii?Q?exEYilip8/DZHF9Blydc9aoSFNld71C5AMBYyVG7JZ2B7FEflB0c9N+827Pe?=
 =?us-ascii?Q?UH/2vukTD44CTBslfqAZgbkT/uAJ244RQQTulsWbGx1FvavJK5M7w8F0XWgN?=
 =?us-ascii?Q?GOjdiObZjlqxgYHd2pAYcEBtMBf/SFM05Gzv+y8FBO2l60C077Kecmx1UcYz?=
 =?us-ascii?Q?wG1GS5CJVFqFs57KLDC5KhytQ74b4AwXZFo6X3aBQxvF+I0sh5YrJ5f81EUT?=
 =?us-ascii?Q?lXcME8kOEjbjcA7ORvK236/OFyP+JZV1d7mnto8atW5JVcgyZT1gkWd9vvlG?=
 =?us-ascii?Q?GZ1wox/vrAW7bdKno320uG7xvDhQb+SDUh52lXPZoTDGqyKGoxmc+EwmmKSd?=
 =?us-ascii?Q?j+upUZjVyiJby3vGy8pGwFj7mPt59RYDdBSBxLm+o4XQKJoX//VpZ4ItFTaK?=
 =?us-ascii?Q?xnCVumu8fxQIk/IFT8U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 923c0f46-006d-4e1a-962a-08dc8531cd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:33:32.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2bg4SMOIC/l/udp39HEUmY4zJFy5+OdcX+Js6GA/1OQQ8XZXWdPmuy5sAnKG4WVvzALb2ypVwV8ffDURfY+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4987
X-Proofpoint-ORIG-GUID: 5rOPx9kocKlOdmvX402PIPjc5_46gCQD
X-Proofpoint-GUID: 5rOPx9kocKlOdmvX402PIPjc5_46gCQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01


> Add flow director filter match and miss statistics to ethtool -S.
> And change the number of queues when using flow director for ehtool -l.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 39 +++++++++++++++++--
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  5 +++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  4 ++
>  3 files changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index cc3bec42ed8e..a6241091e95c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -43,6 +43,11 @@ static const struct wx_stats wx_gstrings_stats[] =3D {
>  	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),  };
>=20
> +static const struct wx_stats wx_gstrings_fdir_stats[] =3D {
> +	WX_STAT("fdir_match", stats.fdirmatch),
> +	WX_STAT("fdir_miss", stats.fdirmiss),
> +};
> +
>  /* drivers allocates num_tx_queues and num_rx_queues symmetrically so
>   * we set the num_rx_queues to evaluate to num_tx_queues. This is
>   * used because we do not have a good way to get the max number of @@ -
> 55,12 +60,17 @@ static const struct wx_stats wx_gstrings_stats[] =3D {
>  		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
>  		(sizeof(struct wx_queue_stats) / sizeof(u64)))  #define
> WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
> +#define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
>  #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
>=20
>  int wx_get_sset_count(struct net_device *netdev, int sset)  {
> +	struct wx *wx =3D netdev_priv(netdev);
> +
>  	switch (sset) {
>  	case ETH_SS_STATS:
> +		if (wx->mac.type =3D=3D wx_mac_sp)
> +			return WX_STATS_LEN + WX_FDIR_STATS_LEN;
>  		return WX_STATS_LEN;

             Better way is to use ternary operator.
                 Return (wx->mac.type =3D=3D wx_mac_sp) ? WX_STATS_LEN + WX=
_FDIR_STATS_LEN : WX_STATS_LEN;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -70,6 +80,7 @@ EXPORT_SYMBOL(wx_get_sset_count);
>=20
>  void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data) =
 {
> +	struct wx *wx =3D netdev_priv(netdev);
>  	u8 *p =3D data;
>  	int i;
>=20
> @@ -77,6 +88,10 @@ void wx_get_strings(struct net_device *netdev, u32
> stringset, u8 *data)
>  	case ETH_SS_STATS:
>  		for (i =3D 0; i < WX_GLOBAL_STATS_LEN; i++)
>  			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
> +		if (wx->mac.type =3D=3D wx_mac_sp) {
> +			for (i =3D 0; i < WX_FDIR_STATS_LEN; i++)
> +				ethtool_puts(&p,
> wx_gstrings_fdir_stats[i].stat_string);
> +		}
>  		for (i =3D 0; i < netdev->num_tx_queues; i++) {
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "tx_queue_%u_bytes", i); @@ -
> 96,7 +111,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
>  	struct wx *wx =3D netdev_priv(netdev);
>  	struct wx_ring *ring;
>  	unsigned int start;
> -	int i, j;
> +	int i, j, k;
>  	char *p;
>=20
>  	wx_update_stats(wx);
> @@ -107,6 +122,14 @@ void wx_get_ethtool_stats(struct net_device
> *netdev,
>  			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
>  	}
>=20
> +	if (wx->mac.type =3D=3D wx_mac_sp) {
> +		for (k =3D 0; k < WX_FDIR_STATS_LEN; k++) {
> +			p =3D (char *)wx + wx_gstrings_fdir_stats[k].stat_offset;
> +			data[i++] =3D (wx_gstrings_fdir_stats[k].sizeof_stat =3D=3D
> +				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
          Since fdir_match/fdir_len are u64, do we need to check the size h=
ere?                          =20
Thanks,
Hariprasad k

> +		}
> +	}
> +
>  	for (j =3D 0; j < netdev->num_tx_queues; j++) {
>  		ring =3D wx->tx_ring[j];
>  		if (!ring) {
> @@ -172,17 +195,21 @@ EXPORT_SYMBOL(wx_get_pause_stats);
>=20
>  void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *i=
nfo)
> {
> +	unsigned int stats_len =3D WX_STATS_LEN;
>  	struct wx *wx =3D netdev_priv(netdev);
>=20
> +	if (wx->mac.type =3D=3D wx_mac_sp)
> +		stats_len +=3D WX_FDIR_STATS_LEN;
> +
>  	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
>  	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
>  	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
>  	if (wx->num_tx_queues <=3D WX_NUM_TX_QUEUES) {
> -		info->n_stats =3D WX_STATS_LEN -
> +		info->n_stats =3D stats_len -
>  				   (WX_NUM_TX_QUEUES - wx-
> >num_tx_queues) *
>  				   (sizeof(struct wx_queue_stats) / sizeof(u64))
> * 2;
>  	} else {
> -		info->n_stats =3D WX_STATS_LEN;
> +		info->n_stats =3D stats_len;
>  	}
>  }
>  EXPORT_SYMBOL(wx_get_drvinfo);
> @@ -383,6 +410,9 @@ void wx_get_channels(struct net_device *dev,
>=20
>  	/* record RSS queues */
>  	ch->combined_count =3D wx->ring_feature[RING_F_RSS].indices;
> +
> +	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
> +		ch->combined_count =3D wx-
> >ring_feature[RING_F_FDIR].indices;
>  }
>  EXPORT_SYMBOL(wx_get_channels);
>=20
> @@ -400,6 +430,9 @@ int wx_set_channels(struct net_device *dev,
>  	if (count > wx_max_channels(wx))
>  		return -EINVAL;
>=20
> +	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
> +		wx->ring_feature[RING_F_FDIR].limit =3D count;
> +
>  	wx->ring_feature[RING_F_RSS].limit =3D count;
>=20
>  	return 0;
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 8fb38f83a615..44cd7a5866c1 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2352,6 +2352,11 @@ void wx_update_stats(struct wx *wx)
>  	hwstats->b2ogprc +=3D rd32(wx, WX_RDM_BMC2OS_CNT);
>  	hwstats->rdmdrop +=3D rd32(wx, WX_RDM_DRP_PKT);
>=20
> +	if (wx->mac.type =3D=3D wx_mac_sp) {
> +		hwstats->fdirmatch +=3D rd32(wx, WX_RDB_FDIR_MATCH);
> +		hwstats->fdirmiss +=3D rd32(wx, WX_RDB_FDIR_MISS);
> +	}
> +
>  	for (i =3D 0; i < wx->mac.max_rx_queues; i++)
>  		hwstats->qmprc +=3D rd32(wx, WX_PX_MPRC(i));  } diff --git
> a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index b1f9bab06e90..e0b7866f96ec 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -157,6 +157,8 @@
>  #define WX_RDB_RA_CTL_RSS_IPV6_TCP   BIT(21)
>  #define WX_RDB_RA_CTL_RSS_IPV4_UDP   BIT(22)
>  #define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
> +#define WX_RDB_FDIR_MATCH            0x19558
> +#define WX_RDB_FDIR_MISS             0x1955C
>=20
>  /******************************* PSR Registers
> *******************************/
>  /* psr control */
> @@ -1018,6 +1020,8 @@ struct wx_hw_stats {
>  	u64 crcerrs;
>  	u64 rlec;
>  	u64 qmprc;
> +	u64 fdirmatch;
> +	u64 fdirmiss;
>  };
>=20
>  enum wx_state {
> --
> 2.27.0
>=20


