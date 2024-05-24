Return-Path: <netdev+bounces-97933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E48CE350
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388161F223C4
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7A84E19;
	Fri, 24 May 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="E9wyE8fE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6396E615;
	Fri, 24 May 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542960; cv=fail; b=i22Q64T83p0nJ4mGj8gVJIQRhrfLy4Q3QXkqit0PfmP2o/eyuFy9NLGQjaqTHvPrpjDXfUUiMt8XU+H+yRAuL+tpm+Dts0fEuyQQ0VFA3yD+wTkcLTTa6CMNn+s5vQY1ujfiqKBJIQrv7uvoYA/AhR8Gf/9nLrEdEtf481TmENs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542960; c=relaxed/simple;
	bh=IyUkPioFfJXuyp6FgY+U/sCDAgMHmG/yMga3WNqzbXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=frmIChn1oZhe1vTYhmBKhwxOvL840kS6Rtvm+hyV7YmTtlDE00GbYF1J+K6TvjoDutvBGOpSJltPxZUTU3zecbDOvS+PWsKacAxwnPVGow2QAmGrjGzVcTScipb7wlokL4Nd8YWQ0nj1l96fHL7SGcKJS7R2TpJ7TyNuesQmRno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=E9wyE8fE; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O60RTX016339;
	Fri, 24 May 2024 02:28:50 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yaa85tmuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 02:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqq5KsR0SKN5zQqP9Ydc61Gtm2m8aeo04ejAK/rvEwpGAVPNzXolmaSCMi68PBB/koL4KvHARtwSHsAFQeKAVKqpsa96WdTUQB5II4/xq7nfbYK9jOdHde3IWqKchoR5+ybkYIzC/5SWSXCt1xKklgCMZsJouzJ7IZe7fY/2bFN+hJqSg3XMGkDjcxoVG6c2erF7zdkG/Q8xKTTip8Vnid0nhTJNx9g8R7MdxcLxctCCq4CbDfatl1VkWrG84GWaqkPzridAmFe/7oA9JP9JS91XYq9bZkVvnL0gbTRMfXEbZsgyMvmhiNFaPFbchBdcWx9uqvZkgFU2GiS7buLrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdFegzvpShIEESA7aalmeFQ8sVBjj/s9H/bqeYgwcfw=;
 b=cQzA6Ae9MAO2M/XwmTVFRXVjc8ZFYpeLVXOWZhJ1Td4nVFKgWgL99EGV2xX62CU873YV5FCePsPKHu34KjlI9DOsHcQnExyoUFK3/CbiA9szRmxCzI6Xgk9EmmK1qSm7/XKFB7BQO8o1SyLhtThiMVc+pK6VGSNnodc/flvJMlAC3SFOqkDQzO/Zh9gyNSztO9HSeWi4mTai1W8LZAqYOrQk1RzAabHgCTiwrkMJDDrs18kf+tYOuGggdAqydop+ALnBazqFjhB1A9A9cbpKSJyWQnWUj2miy4GUo8lSqHpDCoMljZ7XUGReDgutOh13eS6Ym4Vxv4w66RRqgroY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdFegzvpShIEESA7aalmeFQ8sVBjj/s9H/bqeYgwcfw=;
 b=E9wyE8fEVlnqtVn6EiRCtwe6dcQOQHqwOEeLKVg4c64dxeC+nsHqCZj8Z5plO31CMdNqt5tFwidN7sC9xvcxdhqUB345lez/Ndt0Hnvcrt8C4Qc64UjDGoDNY8FxxWzEVEWa6vXJ6IR5ywLnw0w+VhsQVdJ+n741xgQ2YoK0WtE=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by CH4PR18MB6360.namprd18.prod.outlook.com (2603:10b6:610:230::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Fri, 24 May
 2024 09:28:45 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:28:45 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net v2] net: micrel: Fix lan8841_config_intr
 after getting out of sleep mode
Thread-Topic: [EXTERNAL] [PATCH net v2] net: micrel: Fix lan8841_config_intr
 after getting out of sleep mode
Thread-Index: AQHarbhQeUVWEJNGskeeatAPV6IdgrGmHecw
Date: Fri, 24 May 2024 09:28:44 +0000
Message-ID: 
 <SJ0PR18MB5216EFA6E40EF5FAC4C096A0DBF52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240524085350.359812-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240524085350.359812-1-horatiu.vultur@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|CH4PR18MB6360:EE_
x-ms-office365-filtering-correlation-id: e4c53dd0-8d05-4c11-b88b-08dc7bd3e893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1NDKS7Ai3D0X0V6NOtxptVdLeOgm4hkH1kNmdyO4yw0Ch6Es57Mglifq56CE?=
 =?us-ascii?Q?v6oL7FQwe+woaBa3DHngF8PWfA8Om/6TXzKJfPKLb3IWmJzpvNm46laYwwxO?=
 =?us-ascii?Q?Ds/I2ousJtRfLswNiMr5LdVGj4OBkkHGZ+o71FZJwUw4QV4C7pqQXGBOIKDM?=
 =?us-ascii?Q?EUOFgP/RAUeGBUA20PHKcAdjZt1pLpQ7LKQPx/xBv8JViApqSCd7sJKUcg8t?=
 =?us-ascii?Q?vNdg55yru0awguyfKa5V6/1y0Q2YBnOBeVJJ7saPuEqRyZOaOGPac6f4Nn4V?=
 =?us-ascii?Q?5B6HXZk5sGkM5hsD0kkTC9QlIwVN60CezohTNdKnsELNNOjSnrPlDXfEimck?=
 =?us-ascii?Q?Fi0HBY81ZxCntakY7o3wfJ5MW4sWH3ARvD3hwehyhEVGY3/yPvE8Sdy7wMa1?=
 =?us-ascii?Q?iFkGpsgyspQ1pLZZYmNrujRAENn7CHrqScqIEXkw8/786bDzvYlSCP5xLKKm?=
 =?us-ascii?Q?DSEkRfqcoXJHGEx/h8YBBPZe1CzyuBEnu75ApGpc/TvBcY/LKWFQjTBdP9RU?=
 =?us-ascii?Q?wbsRFMe8Ri0NC21mGANq6e3DSSlU/1SlEEAIJQbxXnPF13n2qsBUv7/ASj1r?=
 =?us-ascii?Q?R7TKykm7rj6GdjTKbhJJquhFKu4T0RQFR9P0+fe1PHMtX6NqcNE/YVysdXgz?=
 =?us-ascii?Q?QM5gAMCDoDDiWVdPHB+eE9wz/Y9fq+Mn75GO6jQFaUM7LLYhpEmzq4tGbaYU?=
 =?us-ascii?Q?DqqSfQPaucP8qbZMqxzTza6GydJpA8Un+X1o2XlSECqMV9cY526PHeMly9xA?=
 =?us-ascii?Q?VcYPzWC0jaLhYAAyxlQonQ9RegJOnsrJ1PTP+6lrobwAE+SjY1qJoAwBuNZR?=
 =?us-ascii?Q?gZ60iDz/LnkyjO2+PkpiR3mMtfpfdS437Qt6AkpUoRZaiQ8wX0I17MPRH/pk?=
 =?us-ascii?Q?AqiI4m0Qg8Dg1vn1MdvLC6vVuEPFqb/yFB2kkYvCD9gFYhVZtM2/lA9aZeF5?=
 =?us-ascii?Q?JVCEqQICQex9nu45Pw2EvaO7XpRcu/mkm5NzK6v4f1jqtPyw/Et2wwDzcxIQ?=
 =?us-ascii?Q?mK9jpCQlNHheoZdjEUeTwYE0AMTI7M7TKPKITDSqJr8H6HtXEu/tKnvLizcF?=
 =?us-ascii?Q?F5se3JxmJ2wqlDcIQ/FUGi82IK0if+Qo8+bj/ikPFYiwbTcgvrxOOTjqW1Kw?=
 =?us-ascii?Q?tlEKAV3uLHn4Ul5+bCVtsRJVot/+++YheKnqeEhFZY66NxQPz1kdRtmXymOn?=
 =?us-ascii?Q?xZwbZnP/gWVu3FKG/8rqR/S25nWfvFM8B2jpVi9TvOKX5Mr4r6wQYy+KeDZM?=
 =?us-ascii?Q?tWtI7dn4n2di9yIxlep9C9Zq6N55Zpvza1F2EwfulxgV2oRmym7wVkKFyTRB?=
 =?us-ascii?Q?q8TkCRlR7nYFdvuaDlRk4ZoieY2FBaAHB0gQFNPs1iGywQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YrttkIiDSTMVDH/4zWdRugVYzcHMImZk3OKSWtjzC4XAHPHqoINQS5DMLQU7?=
 =?us-ascii?Q?bVaR5/0IrdR+HpvdCRJ/aA53uZYYUp4CqvZ4RYff6ZM7sT3g+Jr24OsPk597?=
 =?us-ascii?Q?uSH2OyEYNbcyMtEFdRvbXJLHmRsU0nQXTDUBj+SQ+rvO7EZys62RJtI1XARK?=
 =?us-ascii?Q?1PQWnkRYZ/IwObb5JE6B7Gvacj8le3fZ5NarKtIrJv09PbCZWvYGKenVYqHi?=
 =?us-ascii?Q?PZ3OqnBoM7sZlsOGsoP5WV9xaxitKJnEpLvdI3ViZQ1oUZ/lOpiG9UFEwmx/?=
 =?us-ascii?Q?vcmUTTHR/oTX4+t++e3i/FhnRn38GjMImjZe6NX9wy+2P5ijNRJYjslK8Dvd?=
 =?us-ascii?Q?6SL+ZMMvsFDire7fAa0yajotXb83NA1JX9BCV4N0UuSdDokKrS3SorLrOPeX?=
 =?us-ascii?Q?qwNdDljPyI4dFK9sSiu5N8MTXOAgnjRvLyGJkLbC1O0o8C0c8ZZvbPqTsB++?=
 =?us-ascii?Q?KdKNVx3bHBT9X30lELW3t0AVoAKysLxlOTG5W0JfI/mpui/RUwSwDVqjy1AL?=
 =?us-ascii?Q?tvL5KuwepgqzYE03tFjarzohxXWyZAHDDLVeEKyqLfrfmxLWXzKG0TnPLmGv?=
 =?us-ascii?Q?f+syfEHd9Khvebzt9ZyT3cx0wS9RTd645wSFjjpFtlgrc+nQqS0hFMNC+Aza?=
 =?us-ascii?Q?aMVqJ4ygDKcCDAJ1aqX65Oui8N+uGXaRmaIC8hZDuuqoIgfbbu175JJBWpKm?=
 =?us-ascii?Q?20N1rXwIqVGezNc+BOg5vndzqFopCEspLy9raIea4w8J1US8MC2yt55c731J?=
 =?us-ascii?Q?5KA2meBP+/nzcPGaAtzepxkp5uwuSi2L8F1bbHV/b2A9iYnr/3IHeEUm6c0g?=
 =?us-ascii?Q?yQPWsAbNoZp8Cf06fedeHDCjb22doahnN+3ceTEBMACDJCkXfOjuCY3m7uw4?=
 =?us-ascii?Q?afASDZMpa8N4s2IC6HRYMnBnnxd5USy0yoaDKd0KfkuDJLeg1ny6jKd/xthv?=
 =?us-ascii?Q?NGC1I2xI+Sqm0ES3vULVpOf3euRTsIA8zcMfLEdRIQBQPs9WL1sZh0yrR/T4?=
 =?us-ascii?Q?eJKVHpxs2TSKuD2GBd0+vgptnmxBOcdIYkagGxNuHm2OmKzlxjYkKSJ5w06h?=
 =?us-ascii?Q?hNfwHV/o07aaXL60ak2affe6wSXYDUYYSseSol+q6yD2unMYw1dbCjytTWcX?=
 =?us-ascii?Q?2YcJhNTCapQPSLB2BWqIRsiM42VEHuHL0fnjBy+bz8iOydyFlQCN5K7+4h3m?=
 =?us-ascii?Q?6avDaxcUp3Ha6VPMMAo5E3ppANOiYHWD7ISm00N2XljaswcGBWq3ExtUBah8?=
 =?us-ascii?Q?cf30UATo8USmSy/WRXAiFMMlSmQk584l0LoNucOdeJAfDDusMV8cGXphP4BC?=
 =?us-ascii?Q?qZR685Qrg+G80VpIa2IawBzfsxEi6g7xFp91eEJ9ntdZTbiIrJX5PTfagEfU?=
 =?us-ascii?Q?WHwc270TLz438EQHHANqxg7d5rO9JU+1qPcfjr30yY+J7a3qCggbA4xLYuKj?=
 =?us-ascii?Q?b9XcVl7djUACJ7N80m4zxgyoo922An0b53Az6BqdOBCnsyN2rJDVFOI4il12?=
 =?us-ascii?Q?aRP8PqYC3TTWH3szmJ9gKRDzQrt9kYi2oYqZ4CHZ+qOLZTDY4+evZZ+qZJhR?=
 =?us-ascii?Q?qXQUxnQDumATv85nAJ0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c53dd0-8d05-4c11-b88b-08dc7bd3e893
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 09:28:44.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlmpOqtEw4TZ5SLpqmpUGZ5PPlsFsP6cHHJbVFEzzw7haTbYdOP83CJ4iSjyUMlRIUly0+ZPD+P/WYnJWNwt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6360
X-Proofpoint-ORIG-GUID: bpr7T7MyoRC69_4E-8Xl20XKVrABZU3U
X-Proofpoint-GUID: bpr7T7MyoRC69_4E-8Xl20XKVrABZU3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_02,2024-05-23_01,2024-05-17_01

>diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
>13e30ea7eec5d..c0773d74d5104 100644
>--- a/drivers/net/phy/micrel.c
>+++ b/drivers/net/phy/micrel.c
>@@ -4029,7 +4029,7 @@ static int lan8841_config_intr(struct phy_device
>*phydev)
>
> 	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> 		err =3D phy_read(phydev, LAN8814_INTS);
>-		if (err)
>+		if (err < 0)
> 			return err;
>
> 		/* Enable / disable interrupts. It is OK to enable PTP
>interrupt @@ -4045,6 +4045,14 @@ static int lan8841_config_intr(struct
>phy_device *phydev)
> 			return err;
>
> 		err =3D phy_read(phydev, LAN8814_INTS);
>+		if (err < 0)
>+			return err;
>+
>+		/* Getting a positive value doesn't mean that is an error, it
>+		 * just indicates what was the status. Therefore make sure to
>+		 * clear the value and say that there is no error.
>+		 */
>+		err =3D 0;
[Suman] Looks good to me.
Reviewed-by: Suman Ghosh <sumang@marvell.com>

> 	}
>
> 	return err;
>--
>2.34.1


