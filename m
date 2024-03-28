Return-Path: <netdev+bounces-82841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159F88FE8A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510DD296559
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B47F7D5;
	Thu, 28 Mar 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="X03DOHo/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A237FBB2
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627289; cv=fail; b=hRFTxWPY3flxrHAgXityLOh0gebfWmj91tw8SCvQ219eNNOI4roDO7gxRzietKMzM8SM7bas5dcO8QNiVVZ1dQecH6mUcw4g+pMCbifejByuts7x8mI3Z312Nnm9CElZgfT4Ick55kH28SU3kbFLM8fjDqhJuOLsaS5lavhjs10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627289; c=relaxed/simple;
	bh=xM2fFfIYOD7vRtPWVrH1YaEcT9FZejU8QGPfaA1THVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SN6zjs6cJ6tlG8Np4E+xI2l2nLE74J5bfCK8ixjMArHcFxe5gdf/fUfQEXHlyXoaD/+432H156cf51iGJQHBvDKfchurZw1hdk5JDNaRpsF0hWFngEXTqz1pZJuFYjtt0kzVXA+FTPsLpmaZsR1jXGhWfJ7BuZZTONFokd2xW08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=X03DOHo/; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SA18Sd031446;
	Thu, 28 Mar 2024 05:01:16 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x4jd1q26f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arPM4VWBkAggQM4SUNwtsualy7eirSXFriJNUFo4VM0vRt0AOluhgposOWVCAuooFxgguYrUT4MITliykvSrV+zRieWerf+ZgUBtPERshaGrP5X+HcxrGbftxNRHV22ZIj5UypX52h9jfVYGqtka3eT6zvj27cXoJJJofFvZmMimE08gp95eEJSBfQrlbs4eICPtrmpoFL0KvwReVpYcUR4suTKOiPaXKImEk9+m1I0MTEGzuCJRCLHuP1OJwW4fLYteTKfJPfTNkCRjcfUfX9zwFTdbBDCp+C4Z1+T+L3BLZYZOm8j12yubgqZRlDShR9a2n/EjIiFgY0R1t6UwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRFq7P5ccVpUnyRdC6iFeeSO9mYOec6Mt3PHZ0ttZi4=;
 b=h+sro7h9qMMvLBgk8XMMTwo8JvG7Bc0//u4A9BJGSFprl3MSn6u9RuHowVabfRxtwaSqYdGWOk7XstWAaVbBFYC7LkDgas39SleA+5zJz6vTtenNsdbY2aT1VoEjVQym+uFDS6R+0lHHOQXC/vpWVUU+xH+kYjE55BPHSE1Bl0XWwc7whNGX7jEtPl4CZnjRDthLgc8YNLXOfirVf03/izVSALhQM41lGYzY7MDmAMV3QL200PGlUYspgmq7wb4G08+/l0KzLnXhq+LkUs1oT7IzXw4PtzRPR+OSaVKccj92LrEAbi9wsfvDJdRGJ+TJlyQ7f8M/uNh+7Q8BHh+Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRFq7P5ccVpUnyRdC6iFeeSO9mYOec6Mt3PHZ0ttZi4=;
 b=X03DOHo/mu0+srnlPl52oZkU4srVWloRVon6tO5xQ6mMCtO/A/M7FOjxwAbomJxLftPMzNOQx8on/GMu8VgkV52OPWqVDlcOuZoDt+fRKqjYh1W1cPJJTvX/jRUGKosWJpdH0gQ8Vm7xXP7yM3CfJx5cXGF+BfxCjjFVWkDXIig=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by SJ0PR18MB5162.namprd18.prod.outlook.com (2603:10b6:a03:439::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 12:01:12 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:01:08 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: Denis Kirjanov <kirjanov@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        Denis Kirjanov
	<dkirjanov@suse.de>,
        "syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com"
	<syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Subject: RE: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
Thread-Topic: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
Thread-Index: AQHagQeeMh7qEfoqiU2iDE+a5FYwAw==
Date: Thu, 28 Mar 2024 12:01:07 +0000
Message-ID: 
 <SJ2PR18MB56357AA9BA3EC99CE88EBA05A23B2@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240328113233.21388-1-dkirjanov@suse.de>
In-Reply-To: <20240328113233.21388-1-dkirjanov@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|SJ0PR18MB5162:EE_
x-ms-office365-filtering-correlation-id: 54078e00-2590-411a-4f29-08dc4f1ec09f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aJRLLqY+Q16u/bXSEoGvSbTl5nmA6ipwKjWawbjlD8loGbta72K+KtYAgPKWMhv9zcvWafAzBKgC+2Vo5ItBLO9wb5pwF6RBJr8CDkTP/byQpHMs1LKGI+rPXSsie4Z204qIY25x7ysMpaJrSm1EWRE7FI1PFXCFVAnNr9gqdXIbz3oVcOwxYF/mKQ9gZcNErM8TEbp0EOCkoPDPDkjlfJdjSBCOxGimbbf8edSFGUFNtI/8y9zRiIbQJLhHJRxKfzXcMkSKDlT5SgnoW8PVJPoGAyZZ5AYP1fsuP4h2qc5/iBX2UWuAUlGyKoqY9lKJkx5fI/BtCZLcngpAfL3RS3226hIPBNt1iMG7phfjy3sMpcMVIIlJFCJMH9kDfUko4YkeuPv5hsW7a+ggC/b0f0pBr2kjBeef4M1yiVO7jbcrtnd3yrOIj1UyZ+7jE423wbDNHCYER497F6/Ij2NS5XpVZANeM85oLw1ZJeRlAM/MAL1cq1m4TmeW+Mw4lKjftbJA9R9764k/pc1Fy37I+t4V09MIoq+uAkkRXsv4vAweAj6dgxdrl74O7MJ9mgYhkMWtW7Z9sv2lFkzaRjelLG1KMTwuso6v0ddL80PYB+0LNZCCSByMoaBM44Bo4gURhlAFm/AJz+Dcf9ZYfaxpOcPf+IsbLfNcYlLIYdF/nOLUqBYZsnQCN66YYV/kqfdULDN6khft+bcSlT5Pb4jRIFoLHhYdNm4Cz2idk+MU4YU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UfuoHYIqyUok05sh9CC4Icafno+BlgnUm/M6h2nlbhafCyx7xg2OqZVBrvPg?=
 =?us-ascii?Q?YgmMyGnDpRbEezDbtU6nb88dYDGP0DMCa8cpmU1RE3jrRQdwaCFNk29rfRfM?=
 =?us-ascii?Q?jdCwiRl99oI6trPG28z5ZKYoxfTH4rQS7uFl78Ow8a8TCzyg/OF8NrwWiVA5?=
 =?us-ascii?Q?H9YNInOt0Y2ol59cXll56Ls0o9T2wneThsqm2p94DsrbMcBjkbYmsXBzxIM1?=
 =?us-ascii?Q?y8+SVqyBHLrcDCmr0a+/USimA6VkvxiLbkZ1x43gU+jWMl23AaiB/1gko74W?=
 =?us-ascii?Q?0VLZU4T2wFRwkIlWZM/ZP80K7QQ8zLCxWa0kusjEtUoAaXvvzyaWMC+F73zm?=
 =?us-ascii?Q?CMeSxfbylvnb3qD2K1P1V+UKPiRkqaAsXfIib9twLBiT3ecA8WKPVnhJ6Pk5?=
 =?us-ascii?Q?oRrnSacfqzhFZKWPE+ypMeR7nCHKlYTbkG2sZ0VRhCRNDxCL5YKWsAZIZRok?=
 =?us-ascii?Q?GxqttfCXNTPVBF256YKJ0KYlIqzERA/Dg20foxqka5V9+iZcoGGI8T8+ZN6L?=
 =?us-ascii?Q?MktSwti7UjnlxfuISTaXYxls/WK9VTSHUwhIwNopeKkhluBm/UG7c1bdLwi6?=
 =?us-ascii?Q?mDalfGbiFa2jdDCXHHhlKJxy2+jIzqNpSHdfxe5/w508TxpEQxJ+BV3svAfx?=
 =?us-ascii?Q?K2A3sDaBiSxbeRL0v3cy6P+fE1VHFaOo7dqNbsFYOMbaQXwBCVimucp4C111?=
 =?us-ascii?Q?/PxWosEPWxjzfVJaSdjaSeWdP4ExLNZTvHnOADPU+HSrZhtAY7UO3KKU2qyA?=
 =?us-ascii?Q?nswirXdefv8WU0YBRn12QsTrj20BzKnWUXIscWstNtkKd07jAqVcpNNxJII4?=
 =?us-ascii?Q?mCDvuOXAZR+aNOq+kuEyDXZpWY3cx8nVCXzgz6HrOdn6a528ILp0rfoHHwvk?=
 =?us-ascii?Q?SlDKxPM2sxFCM9DTwAYEJewdgiLKlo4I3dsBkSgySlUqQGX5AHAXqTXCBzKZ?=
 =?us-ascii?Q?3WRRKSDnlKf7nfX8JGWbP+1a8apWYf+LaZvn6SEpgfREoMhU15Q/L+83CaUR?=
 =?us-ascii?Q?yVmt7rK8YUPZSSa7Z8HTvzcP8fFLQ/y0Pv6MW5JaALE3GhtQIgaLCw1Iv88l?=
 =?us-ascii?Q?bz+p/+M8JX3f5ZEz+3X5yxVoNYbcwSGZsUX8eFAP5p0f1iHCqtejdjRPXo3v?=
 =?us-ascii?Q?Nuwq2Jm5oDbiMBNmkj5X1bGRUXW6n08v9GtYijUi57t2jaNJnh88vdoxbmUx?=
 =?us-ascii?Q?Arr4bjpJOGnb0Qyf4h5MnY0Ivtixnt8teLpy4nJeqcY5mLK4rhB1wtK+Mtgs?=
 =?us-ascii?Q?A1Ab9IEMBd+cJheqCCgNRyOd2aDgeKRie9+Ek87qtIi/7pjN/MfynZBtT+P6?=
 =?us-ascii?Q?UjBRiP2xRbmBgm1ffe3peQILjlsgOAxwuqtIHMDzWSaPuc2xDRVZN2aBOeU9?=
 =?us-ascii?Q?fwNZvLr+JtgccqCzWY//JfPDX60+a8EnUu5GOZYrSups9U6s2iW/yo8b8gJL?=
 =?us-ascii?Q?AD0D/aLkkOZcy9B6oRB4KqWH7eTi5j1qD7GVXLUmhJcF9VCEajKNOGS2kLEF?=
 =?us-ascii?Q?5svivoGyOg4hKXe0mqqAcpDdnE+WgCm1glcnSCYgbgW6cLqyC7fHogwo4Mxm?=
 =?us-ascii?Q?uIndMEywm34U0jHUk91DOSuisaBY4TxJiag8OO5a?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54078e00-2590-411a-4f29-08dc4f1ec09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:01:07.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iw4dORq6fDnRA4M9GYOwKyxte9qwgurvcRIgCS2o9KjgN+L8KOARCH40xfhLRND9ULCK9di+sooMvUaswmWzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5162
X-Proofpoint-GUID: nq9WVE-NDeutIN3VyYW60vdwSD0hJEEu
X-Proofpoint-ORIG-GUID: nq9WVE-NDeutIN3VyYW60vdwSD0hJEEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_11,2024-03-27_01,2023-05-22_02

> -----Original Message-----
> From: Denis Kirjanov <kirjanov@gmail.com>
> Sent: Thursday, March 28, 2024 5:03 PM
> To: netdev@vger.kernel.org
> Cc: edumazet@google.com; jgg@ziepe.ca; leon@kernel.org; Denis Kirjanov
> <dkirjanov@suse.de>; syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.co=
m
> Subject: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
>=20
> A call to ib_device_get_netdev from ib_get_eth_speed may lead to a race
> condition while accessing a netdevice instance since we don't hold the rt=
nl lock
> while checking the registration state:
> 	if (res && res->reg_state !=3D NETREG_REGISTERED) {
>=20
> v2: unlock rtnl on error patch
>=20
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed =
from
> netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/verbs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c index
> 94a7f3b0c71c..9c09d8c328b4 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32
> port_num, u16 *speed, u8 *width)
>  	if (rdma_port_get_link_layer(dev, port_num) !=3D
> IB_LINK_LAYER_ETHERNET)
>  		return -EINVAL;
>=20
> +	rtnl_lock();
>  	netdev =3D ib_device_get_netdev(dev, port_num);
> -	if (!netdev)
> +	if (!netdev) {
> +		rtnl_unlock()
>  		return -ENODEV;
> +	}
>=20
> -	rtnl_lock();
>  	rc =3D __ethtool_get_link_ksettings(netdev, &lksettings);
>  	rtnl_unlock();
>=20
> --
> 2.30.2
>=20
Reviewed-by: Naveen Mamindlapalli <naveenm@marvell.com>

