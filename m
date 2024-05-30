Return-Path: <netdev+bounces-99363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EBB8D49CA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0820B2248A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FC17B418;
	Thu, 30 May 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mAy6e8fH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9E1761B1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065565; cv=fail; b=ZcFlWuXgPo3ogWxYQClKJlR5xG1i4rAgLKIiK0WdSQ0MjlMBNHgFtAhzntKSxKMplI4pkFZrYsivN02bcl+Q4Qr2ciOtFdQam7cgmeu8RUYt22IUBlVgXX/aoXHYaiixybozsgXh3OLeF/5m+FKRBVT1/SI2866guJy4He9GQ40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065565; c=relaxed/simple;
	bh=Lx52VdN5LxbTwLevpq+XurPU5k3qbIxI6ufDcZsWcZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAB2bqLxT3j4y+XBpdy2/vSsji4yZZE5klzN5I6c8hBSxCXlIJsvg7uVERin3Jm0ebH8mFEWDct8Sq5glo6wvo5Tgpb+VhlTatVFL7ZL7ZSOe/B4/xTiAdmcfpd69Sqi+6NiFxt7sVpj5PkMi/h2vRIdGzd8+OHpwToZmuJ5R1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mAy6e8fH; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UAQ4wJ022230;
	Thu, 30 May 2024 03:37:05 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yeqpx02fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 03:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEjOo3lBzi1wf6N4CJDcFwPnGC2s2OmXNnRkgqfEoRRhbLis/wCRNsc7egP6j1hBF85ZPN6IxDGPb1nuq3m4BbUuGOsOhsr4U7iXD1uIjZkN8i0xf/byeZQVoeChYNs12rTzaFbMlj6beSjkcpbUW0qoWqRGzL0XJFwq/8pg5WurARJWjhU7abdVHtcDEl5dCGHuQQZgOo59+FS+4LYr35ywTRU5bD2zKC/ukZCLEprkj+99rxglRUvWOqb2WSvTZ+GIDl/swQN1JCQ5HMVSH0B0jD9XWzwbRQjiBUPpt+hGzudq8n2g5o+KqsnOCPIeL27cIVPwlQHFQDpo9CgBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiTLKjIBXQDWa7UQezOyIxnFTlVnpT+UulZFopCcMuY=;
 b=MEltVpKgEs4QPl4aVXECrYGYrRUbAa/R6sfB1oPKEx+ZEJ1O26H9SHFl3ZtNOt8LRPAQu+RDegM8PveENq5gL2a1SH+0UnnHzwF12p5q8NwttgYDCH6a+hPaPL7YswAV7F1XGUypX2n4ZNKlLtnmbFFKglM6NmJFFSlrCLZKtQEcQn3Se15hN4RJwLho5dBIGZVvn4bAAU3L+zFexVmgoMAIIJkkNXYoCFsMPk+MgrkAe8/cvQ08nApkhkpVbEdbTgJvstnQWvEIDiQvJIqjPCnlo0tlpwdvPVKDAzZwa82fp1TyqGMWzogFMwxoDfqp5xow+0HXK3kuGcF5yMkn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiTLKjIBXQDWa7UQezOyIxnFTlVnpT+UulZFopCcMuY=;
 b=mAy6e8fH86QoCPRvoyFb3pa1XRbFVN5vu5RGI6cZG+R4QN4NRUmxwWOwhHhN56P0mTeqVKkv/cYdzRpLtLtRcoBH8s6d8nE/LeLEcNtRQxfK9nCBK1//4nWKJf4t+xT2z84QFtwt3g4k9XqSlT0jymlKJUZ44B2gzrwLMN+I0aU=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by BY3PR18MB4786.namprd18.prod.outlook.com (2603:10b6:a03:3cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 10:37:01 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Thu, 30 May 2024
 10:37:01 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "woojung.huh@microchip.com" <woojung.huh@microchip.com>,
        "embedded-discuss@lists.savoirfairelinux.net"
	<embedded-discuss@lists.savoirfairelinux.net>
Subject: [PATCH v3 5/5] net: dsa: microchip: monitor potential faults in
 half-duplex mode
Thread-Topic: [PATCH v3 5/5] net: dsa: microchip: monitor potential faults in
 half-duplex mode
Thread-Index: AQHasn1O4ewVLoQLAkm+fA49IPc4GA==
Date: Thu, 30 May 2024 10:37:01 +0000
Message-ID: 
 <PH0PR18MB4474DD8CA750ECCCEB7FEADBDEF32@PH0PR18MB4474.namprd18.prod.outlook.com>
References: 
 <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240530102436.226189-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: 
 <20240530102436.226189-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|BY3PR18MB4786:EE_
x-ms-office365-filtering-correlation-id: 463905e8-720e-4a31-8ace-08dc8094708d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?H0az5sF13cA2E3MZ+ywD4vsa7IP/R+fTqfwbR2dJ/CJ5XHlJ/KfNItxg88H2?=
 =?us-ascii?Q?1t1zycliGNHUR3U6KlinP2dgbbGL/SdDceu4k8Bo7G6PG6FuT/gdCx032Pjs?=
 =?us-ascii?Q?ReAAphddvgLntx5QnDLIzDkRUhyUIThSgBVHnfrT4ifs0ugj9Zb2FvAIFPRW?=
 =?us-ascii?Q?2VVwGOO/fvuR/40W9vTmU3xXl4tMLwaeLKqEiYNbVuD2vFZa5OYGDGIveIHD?=
 =?us-ascii?Q?ZxkAj5nD+bgJ5lPZUHG8AkQVAjUnfwo4ZxMBuivlQ6rKAzAnawr0+Qy/+TMi?=
 =?us-ascii?Q?6bJ/QHOyYRERQ3wm/fndNJ3TPWwHNTYt4UCDY9pLUGovA6LlSdjaAhZvIQ8H?=
 =?us-ascii?Q?zX6ueNNVhqQAWn27opvrsL3ojjb7fBPdVd9SGlW++6mJ5po09CUMhaE9xXkJ?=
 =?us-ascii?Q?VnA3UmLT97+my5ATEigr3Qs8xzBetA0QTOt9QCih+9G5O181s6azYUc46r3f?=
 =?us-ascii?Q?4gSVN1ddaNwaulgi6FjqiJhtBy8M+jDXX18dd+VF4Pnxgns3HMCpxJjfZXNa?=
 =?us-ascii?Q?aIiYldOWCwIpteotekpxJUw+0qHvCKP9uwYXXxpqMCgRU2sc0XLb3gfadJv6?=
 =?us-ascii?Q?qa0N4fueRou2VgPkPQnBzX5Vr0gletWdLvxIM7T37JI42V6PzAqB5ZkHGy2I?=
 =?us-ascii?Q?0Yn8rginnOYSuH4mNqd8RYhQToAQQJBbPknD3AJPq9mmS58M4KeLhbd9E4O5?=
 =?us-ascii?Q?JEWqmbcKFNyiv+9qcXmmiJZRjMvYS5BTeSxGj3/MT73xpD5TxbMnu/80Y1AU?=
 =?us-ascii?Q?Uk9+DtzmMVAqdDUnRWvDoplhkDaoRSlg+JU1qKi/I/ir+VjvrkONM/b0Uz8l?=
 =?us-ascii?Q?XCIsBlxtjix8NpeNowVfB3JNxXXX3j5i/lCtCCO2tFLgpaTHXOgq37rTL2le?=
 =?us-ascii?Q?/k0OoGncSf0K6fZwmoeNCKaUnpD/fzkg7J9CWRR6E/uAN7BUtRzD+oTLdEBK?=
 =?us-ascii?Q?oS0wJcaDsukztvx/26mOFMBB+0deBa425Nft5PshEbplLItREA38TBqs8bku?=
 =?us-ascii?Q?WLys9S4+EHgLDsYPCiH3ZpbNjGTGr/t+Cu3thXPcCvzssBmRdFW6TIZ9nc7W?=
 =?us-ascii?Q?F/o1SYd5mjqjLApJJFVjYPn0PCvzSyj03d13j8rf9CVZ2hgRzcDma9/zIklg?=
 =?us-ascii?Q?S+bTR+ZPI6czVWFzFePOsDtCHOu8WJ2mnMzat569WT71JZyxZQ0UTKesIhU2?=
 =?us-ascii?Q?885ggvdI/9YPwCbvHjASqdDhw2UV2kZzFFPjWby/SVh6V/1lMVtwLS1EcfM4?=
 =?us-ascii?Q?WGTJARIb1kj2ZNpxo4iKeJvxySBpDcQoix//dWV4c9VaMqTbNhCjEcofkUWR?=
 =?us-ascii?Q?dW3FGqwZMHrcnD2Rq3V/znfyqtPhWJCeoz4Dji/HTl7QEA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yQ/sSOuh+6WUYEevRFnzBDZg4inuPzB2GT1o+kmuLIv3RQzYnx2fcL/2IAN3?=
 =?us-ascii?Q?a/aWB7jS1bQ5VTfCKMS5xTeIpdLbQvEU21tmdSfsym6tE8cQW3efmug/6GD/?=
 =?us-ascii?Q?xfckin8lRk2rFcX8JUUr/rFn8UdAOb7UvknLyjhbUOCM3gIZCTB40ajL8JgE?=
 =?us-ascii?Q?DSmb+WtZf25ibNQ7vd44OVcRFPsGepDzNnqkV2o2D/spoBOPpiOyZ1r2Jm5+?=
 =?us-ascii?Q?0BL6WrZOO6OdxXp+9nNc3rls5OYvSsXUCd5NqG3SZnR2/JsUkCJqIHyyiZAf?=
 =?us-ascii?Q?bT13dtYNTlUywZTxuk1QN/ZTQonDRNdDifq02rYtDH4uXPI2YVT4F4Wvvq4r?=
 =?us-ascii?Q?96lytDEgQyj5LVeAeGjoFQj5pLQCTZc6VDuuXy6bGk6oSvwmalJNCTHq/w6I?=
 =?us-ascii?Q?Alv9cK7q1PzvUeUJaZqHamYnGgwSZD8kbQZVLF7CYGubMRW2Q26lgGSrWekQ?=
 =?us-ascii?Q?nY+0CZCr08Ubky8YkMVH+PETRpsvZ7zOplz54ZUhwJasXGJIr/ghcXzFkHWK?=
 =?us-ascii?Q?fNfZTiaJu5VX33A2xQXnBzmjxr7+NEom4qsXGuJNdsjGJGOz9kVLvE3HUUot?=
 =?us-ascii?Q?wutBFObwrDm6joHwFb7jVXdKfK6nt0MypENP8AblVa+ZHo9eg9Oxgysn74Jb?=
 =?us-ascii?Q?+Vq9/9QbaS/CXSW+kdW1VZHTcQBAsXs+FVnRHcqDq3yQYzctU32HzBRk08c0?=
 =?us-ascii?Q?t1zHeHJ5EZRxGVA37fLrLJ5QL+rGM10uhfrSzu9v6OjGik9H/MEfjr7aLZpN?=
 =?us-ascii?Q?Mdx3Axfpl1ESstHNw7O3K9yt1PKLOYhwrNAlglVnRwJuFggdFF9CV/UnCwbE?=
 =?us-ascii?Q?zdLdsaIgdHH2hGpsoRlXfI9FHV//S7ETm5yuhN39tmH6sg+waBz3XyZZJGKe?=
 =?us-ascii?Q?t+3NtrD1PlV6gE+/Q0X5VvZl5Cjmd/ASwQqCrjREEcrCerC4pBZ/9cmCq0k1?=
 =?us-ascii?Q?LAmmz01mLu04zVMiEuO0yXu2Aq267DYyegYVGp1yLRGFVDoBWbY9xaqqBD99?=
 =?us-ascii?Q?aldrTfAN+v4UoX1e3j07M9shlADcbs7r+wEjQhIimPyN9O6qakTvwebGCtdS?=
 =?us-ascii?Q?g3BbqdwWr1tNTddWUOoRJ2jMSM69WeE/AVs2NbXCz7ZvgzkKUIr6lnDSBddi?=
 =?us-ascii?Q?e5ACovq1R0ak8z2DtPZVN3bIms967odh6/hOKph0gpSgixkWlJpiQ+vf5uIC?=
 =?us-ascii?Q?f5mk80mV6NRE8+vTz3Fc9VXZ7a9MEWWO/SC80JHeKT5UDCZeFCGl4Z/doHcc?=
 =?us-ascii?Q?HU2wHjHZPIpYAP8KELGh/FoWpte5dNn2CfaAEbnvtITNpOiXk7y1gSliZprl?=
 =?us-ascii?Q?SkSVOn62syVDse/9LgdDual7qnIDIPO/+Icmaf8hIki/n5SpXQnxFERvapf1?=
 =?us-ascii?Q?f1NsmvQqK0b1Mb6AF8mMdBSHcumZu8K5R++g1bGCw9Ldv+IZ1oowxp1xBYbM?=
 =?us-ascii?Q?sax9kT/+K7emxGBuEbEqcwxFhcVnsjXbqbcOX3tZSqiAR+zpOrVJTjXBAt2C?=
 =?us-ascii?Q?TSbC6TxqCsEHHevr6XE8/l3Yd70spoY03gVOL/J+fV55gnHxnHK3fyMlAcjg?=
 =?us-ascii?Q?kxCH6DX5TwtyLV5dt2w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 463905e8-720e-4a31-8ace-08dc8094708d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 10:37:01.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uu+yGJy+6OkI8TuqMpa7llzs+9TQFQPxKerSt1Q8Ish42Al6y9ZS0CB50QR+AEbr7i/2ra2IKw1O8bbNbRGhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4786
X-Proofpoint-GUID: PgH7Nd_1XGOJwmPRpLXutsnOvcN0hTyK
X-Proofpoint-ORIG-GUID: PgH7Nd_1XGOJwmPRpLXutsnOvcN0hTyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01


> ----------------------------------------------------------------------
> The errata DS80000754 recommends monitoring potential faults in half-
> duplex mode for the KSZ9477 familly.
>=20
> half-duplex is not very common so I just added a critical message when th=
e
> fault conditions are detected. The switch can be expected to be unable to
> communicate anymore in these states and a software reset of the switch
> would be required which I did not implement.
>=20
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c     | 34 +++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477.h     |  2 ++
>  drivers/net/dsa/microchip/ksz9477_reg.h |  8 ++++--
> drivers/net/dsa/microchip/ksz_common.c  |  7 +++++
> drivers/net/dsa/microchip/ksz_common.h  |  1 +
>  5 files changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477.c
> b/drivers/net/dsa/microchip/ksz9477.c
> index 343b9d7538e9..ea1c12304f7f 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -429,6 +429,40 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int
> port, bool freeze)
>  	mutex_unlock(&p->mib.cnt_mutex);
>  }
>=20
> +void ksz9477_errata_monitor(struct ksz_device *dev, int port,
> +			    u64 tx_late_col)
> +{
> +	u8 status;
> +	u16 pqm;
> +	u32 pmavbc;
> +
          Follow reverse x-mas tree notation.

> +	ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
> +	if (!((status & PORT_INTF_SPEED_MASK) =3D=3D
> PORT_INTF_SPEED_MASK) &&
> +	    !(status & PORT_INTF_FULL_DUPLEX)) {
> +		dev_warn_once(dev->dev,
> +			      "Half-duplex detected on port %d, transmission
> halt may occur\n",
> +			      port);
> +		/* Errata DS80000754 recommends monitoring potential
> faults in
> +		 * half-duplex mode. The switch might not be able to
> communicate anymore
> +		 * in these states.
> +		 */
> +		if (tx_late_col !=3D 0) {
> +			/* Transmission halt with late collisions */
> +			dev_crit_ratelimited(dev->dev,
> +					     "TX late collisions detected,
> transmission may be halted on port %d\n",
> +					     port);
> +		}
> +		ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4,
> &pqm);
> +		ksz_read32(dev, REG_PMAVBC, &pmavbc);
> +		if (((pmavbc & PMAVBC_MASK) >> PMAVBC_SHIFT <=3D 0x580)
> ||
> +		    ((pqm & PORT_QM_TX_CNT_M) >=3D 0x200)) {
> +			/* Transmission halt with Half-Duplex and VLAN */
> +			dev_crit_ratelimited(dev->dev,
> +					     "resources out of limits,
> transmission may be halted\n");
> +		}
> +	}
> +}
> +
>  void ksz9477_port_init_cnt(struct ksz_device *dev, int port)  {
>  	struct ksz_port_mib *mib =3D &dev->ports[port].mib; diff --git
> a/drivers/net/dsa/microchip/ksz9477.h
> b/drivers/net/dsa/microchip/ksz9477.h
> index ce1e656b800b..3312ef28e99c 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -36,6 +36,8 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int
> port,
>  			    bool ingress, struct netlink_ext_ack *extack);  void
> ksz9477_port_mirror_del(struct ksz_device *dev, int port,
>  			     struct dsa_mall_mirror_tc_entry *mirror);
> +void ksz9477_errata_monitor(struct ksz_device *dev, int port,
> +			    u64 tx_late_col);
>  void ksz9477_get_caps(struct ksz_device *dev, int port,
>  		      struct phylink_config *config);  int
> ksz9477_fdb_dump(struct ksz_device *dev, int port, diff --git
> a/drivers/net/dsa/microchip/ksz9477_reg.h
> b/drivers/net/dsa/microchip/ksz9477_reg.h
> index f3a205ee483f..3238b9748d0f 100644
> --- a/drivers/net/dsa/microchip/ksz9477_reg.h
> +++ b/drivers/net/dsa/microchip/ksz9477_reg.h
> @@ -842,8 +842,7 @@
>=20
>  #define REG_PORT_STATUS_0		0x0030
>=20
> -#define PORT_INTF_SPEED_M		0x3
> -#define PORT_INTF_SPEED_S		3
> +#define PORT_INTF_SPEED_MASK		0x0018
>  #define PORT_INTF_FULL_DUPLEX		BIT(2)
>  #define PORT_TX_FLOW_CTRL		BIT(1)
>  #define PORT_RX_FLOW_CTRL		BIT(0)
> @@ -1167,6 +1166,11 @@
>  #define PORT_RMII_CLK_SEL		BIT(7)
>  #define PORT_MII_SEL_EDGE		BIT(5)
>=20
> +#define REG_PMAVBC				0x03AC
> +
> +#define PMAVBC_MASK				0x7ff0000
> +#define PMAVBC_SHIFT			16
> +
>  /* 4 - MAC */
>  #define REG_PORT_MAC_CTRL_0		0x0400
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 1e0085cd9a9a..26e2fcd74ba8 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1382,6 +1382,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
> +		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
>  		.reg_mib_cnt =3D MIB_COUNTER_NUM,
> @@ -1416,6 +1417,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.num_ipms =3D 8,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
> +		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
>  		.reg_mib_cnt =3D MIB_COUNTER_NUM,
> @@ -1450,6 +1452,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.num_ipms =3D 8,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
> +		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
>  		.reg_mib_cnt =3D MIB_COUNTER_NUM,
> @@ -1540,6 +1543,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
>  		.tc_cbs_supported =3D true,
>  		.ops =3D &ksz9477_dev_ops,
>  		.phylink_mac_ops =3D &ksz9477_phylink_mac_ops,
> +		.phy_errata_9477 =3D true,
>  		.mib_names =3D ksz9477_mib_names,
>  		.mib_cnt =3D ARRAY_SIZE(ksz9477_mib_names),
>  		.reg_mib_cnt =3D MIB_COUNTER_NUM,
> @@ -1861,6 +1865,9 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int
> port)
>  	pstats->rx_pause_frames =3D raw->rx_pause;
>=20
>  	spin_unlock(&mib->stats64_lock);
> +
> +	if (dev->info->phy_errata_9477)
> +		ksz9477_errata_monitor(dev, port, raw->tx_late_col);
>  }
>=20
>  void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port) diff --git
> a/drivers/net/dsa/microchip/ksz_common.h
> b/drivers/net/dsa/microchip/ksz_common.h
> index c784fd23a993..ee7db46e469d 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -66,6 +66,7 @@ struct ksz_chip_data {
>  	bool tc_cbs_supported;
>  	const struct ksz_dev_ops *ops;
>  	const struct phylink_mac_ops *phylink_mac_ops;
> +	bool phy_errata_9477;
>  	bool ksz87xx_eee_link_erratum;
>  	const struct ksz_mib_names *mib_names;
>  	int mib_cnt;
> --
> 2.34.1
>=20


