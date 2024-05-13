Return-Path: <netdev+bounces-95982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D78C3F24
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BAB1C21869
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192914C593;
	Mon, 13 May 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="EuosQUu5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30414A614;
	Mon, 13 May 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596741; cv=fail; b=EM3+WHEWExH/szgbiDX+t/1ajPidKxkxyBVUqfu3HyGe12fcLeM8ou3LHF7wilXUbTKxgF4JBKdK0SvuF5iW1f1tF7wlNBR62djp2yJ3TU6nPdxm2UNh+IaUXlFmtHh29X/RdLN03zMGBNQj47/8smwSoeG+8TqTMTmGlDUgXpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596741; c=relaxed/simple;
	bh=WGcaoZgPoVHP6K47Ag5U1Eff6cwikOn8uaF7KULQ3bA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsFhSAxxdHcawxOVCoI6AINByLjej0IrKLl4g/MToSt+DauVowUa0FGoe6eEPcYqFf6ZfDqG4EOPsAfdt1EsyF++vf8LeGJdbeoTbW3ozINg+wIMI+RQnkgSfPaIw3oA3uzZe6ilp/UnEGBCSVWyaRvIMV2fq3Jq6DsMckstu1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=EuosQUu5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9ffDH014150;
	Mon, 13 May 2024 03:38:49 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g4bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3kW3DxLNasQBYeFU3OVtQrLYZ/C9iF7leV95etrXpnNzInzzkGV2gbKY66hlcr2EgDb239cmRxo/qpwxfTeUyclhjTB1GrdrMBHO2cFZSDSap7cijPDOLi50SgiCxmx9kyBPK/v2abquaC0bcO/FAaX+teI9cyY6rKtCFiJMclkbnCmtVZ2re/RIhneQKaIgkdfaKtUezGPibg/+mplx7af8gRVFg0bB1X+uwTJN7GcJ9Jje8nWiShSspxQB3EQfQTVGhPeCBFBS3vlYavj7AhLRbsJcYH0U+n1jhJb9yOd/hUZMIZg9HuJjb4qTelnPu0Uw+mYLWpKh38SvIem2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22aIVxNHNShy1jRK9pFWbgiPd8Qm47IL0T104jPuFyw=;
 b=eKuM+eBqmlE2djs+d7vblS3AHXQP+tkucnQ4UoBbeldC99dqjAsM1mrsRoFhQwC++pEyQIBl3WpDZ1UC32xV/5NC58HSMz2DeQPFDUPGfUa3ETxuDR7Cs20zNTvDfVkUehq/o1a+pQdpDJOBOqI6q5ebHvYyyT0/PLWqQaktzQ9Bj7pVG17K8WWw8FQb5c6EoXJiHG4v8IUe3dj67AlRIDy9y2WBECs66qR2qMd20q3C7ov6LfvoHFYPO1Lhjcp5nqW3Ql61bcpdPgkfSCUzs2biMC04knGFLbM4eU4SHz6H/wDJkBc7HQpRzifnn67VQQqiBIcliJcX3z+xVlIslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22aIVxNHNShy1jRK9pFWbgiPd8Qm47IL0T104jPuFyw=;
 b=EuosQUu5f/9ih7s8WBl3GWZ3YqFNwSZWFtaemQY6jjAP62Gro6twzcfND9qJIOUVIchbCHEoftSAE0l+XRnyp8zjMPMEP4VIBGeo5pidfVaQkoTSwF2KerlQLoCqbk6WSw6FVNoBi+ONZu8ZXl3vnxAiP/dAGBcddkbwYxkQ6IM=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM4PR18MB4381.namprd18.prod.outlook.com (2603:10b6:5:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:38:46 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:38:46 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHaoJ0n31dqKn1PqEi4BSrztzCWvrGSGMIAgALpFRA=
Date: Mon, 13 May 2024 10:38:46 +0000
Message-ID: 
 <CH0PR18MB433916E129849A20259D4568CDE22@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240507163921.29683-1-gakula@marvell.com>
 <20240507163921.29683-4-gakula@marvell.com>
 <20240511141036.GG2347895@kernel.org>
In-Reply-To: <20240511141036.GG2347895@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM4PR18MB4381:EE_
x-ms-office365-filtering-correlation-id: 05e9431b-4bc6-46fa-a74d-08dc7338de47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DRmDIMf4S5YHyu1twYZ+LfNHvAWako2AvizgZ0OCzKwpW1sigec7KfbGDt1t?=
 =?us-ascii?Q?/MzfibgIRWx6ZcL9GjiyjfHK/TCA6pe4l4xjtueuMvWxRMJs2zBbLa7Z3PZY?=
 =?us-ascii?Q?zwbf9aM8DYIp4GiAeDsxhvoKN+IoZzz8iLNTt+ZpaMncdnO1z9hOQhIpvom6?=
 =?us-ascii?Q?byjUZgDwrzaiFTJ+ZiYY6PqId7DX0axsrIuPK4pxQBRgJDgJxtsJ+tiloW+F?=
 =?us-ascii?Q?iPh9Ni1lqWv2GkBPiaU18ztcq9im57fOpz0O5obFaSKAUe7HSmw/qhhrOnZS?=
 =?us-ascii?Q?dr0Qg5gE3RwKnM9XVUEp8pWJgcJDWWKgNeG5HSfKtRK9EzOthXjT4yqe64lv?=
 =?us-ascii?Q?XO2yRHsJEUyK+AIBVjqXfpR9cmoistjCg+pn8bkdDKIUPeJ4pr2/sgui29aK?=
 =?us-ascii?Q?7AZ+gmEI8tcqaWzTxW9IKaoyj8lYjwl/1AItZ97KVGV7a44hwErByEgYL0pq?=
 =?us-ascii?Q?S47Lve8+fwS0gjf84UlzHU+/Wd07KIzp7MTuPHogi+JJ968XV0yXRCmCU+uA?=
 =?us-ascii?Q?Sl/23xR/EhDEYMLjFGs6OAGo83vdzLzFQcWrVQPx79TqrtaBBU6cuJ9YX85V?=
 =?us-ascii?Q?rIk8JNgWltx+mNMkTUgoasS8zIwh8ZP7vPC1dbXbq0sgPkuDM0eWFU4Vpn2N?=
 =?us-ascii?Q?Gj3eDhtDeN/dGRvbrg+0xZeHttXULm0d8QaGeeuEJ996+5q7hTBeny5rKxUq?=
 =?us-ascii?Q?JoasdbM7wPHgEOsU+stwBAPZjl+ywoQrGiO6edjOyLAsy97AhXP3ozrh4AGL?=
 =?us-ascii?Q?QE426QHx3mZYyTiCUBVh8TGjDjs5hhvMNFFExA8W4KC2dGmQrICbzC4fWC/d?=
 =?us-ascii?Q?74CMnJxwLZGf14deZijlyAcvFc/rH0+exUt5PT47ZnPLCeQOwEgFNZppkC7l?=
 =?us-ascii?Q?84qfEai9xsiytjYf3Kx5RhjtpUx/ZWSQ4ZlT29YvjkJSQGAV4vLRGsJH47Uo?=
 =?us-ascii?Q?s3YlKoIUPZdFBsp9v5XKe+SrQkfyTREfzletOBYSTLOsUwJlrQE1+DfVVSbe?=
 =?us-ascii?Q?aYUSu652LXlwoM3Aiu2Y8ptS05YifJJrfLYsIKjg54F1dZCmLNv05uSphvae?=
 =?us-ascii?Q?23W08PeWZfQd1bs6Eq3drpYIuu6meSdanvyKPw/OQp1WfNnvUh7RFR9cakhW?=
 =?us-ascii?Q?6WzJL7e/S0sv3F7NxqOqd01hBcOOnqiht44azqcPdivOL6M1VQLRRZGznFXz?=
 =?us-ascii?Q?nuhKIIRybhrMGR1Dv9SUJvaVOLE1VadEV3ybGlsFm+cKYfZmlXjBr0B1HnB5?=
 =?us-ascii?Q?N97GH9AYojRHDFH/ICN1ieUo05A/ZVZcrGw8VGqUsg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ifodmtVBwL7UlG3vYlOIpFbucMIqHuIL+ys2kQ5oj7o9sKxbRY32PO4b3Nx9?=
 =?us-ascii?Q?+68y3kPYfSNQ2XvlnJQYoPHyFIt2VnPOyhIm2w/AeIra8YxjEtEiD6Z1AsIP?=
 =?us-ascii?Q?w/imlZpjuW7T37H6v096LgLqw8w7COl7cp+55zCO2EfyvjArybFtl45l2VJu?=
 =?us-ascii?Q?s21IeP4rqr4bGUky+Yeaxt4djIEyrq97Xj1NnB98MSl7+6HbvnFANKmMXcDz?=
 =?us-ascii?Q?8fMpClABo7kR0LTvAUQVC055OpZGNP/+WJCRjhii3D7k7H6iVkVf9w5oPUIA?=
 =?us-ascii?Q?HlTeOybcDtRCfxuLyIplUDUJ9Z6r+SnkAlIJwmMjtqbrZzmy3AqN23wTAkEc?=
 =?us-ascii?Q?3k2ulXyWQsiJA3Ki2up+++3ZWNPXsJFg3U5TEkz7R5nxbRUutNyfe8DwnsZJ?=
 =?us-ascii?Q?RHk/OcuB9gxM8aVxQbgnKCE5KIwKlcdHfo/oQC1+nHMijhSVH7mBN/hkr1pZ?=
 =?us-ascii?Q?a6XveJNiOvyFJ1Labgri28RNgbv8iSubZxWj4uuhTkXo/PrmhIzI5sulLHj1?=
 =?us-ascii?Q?ofh2i/DlTJ6VKlIdymVvxiiVMGdkw2SO84GZ8NK+luRbKgUEzK8dTDA5LcHO?=
 =?us-ascii?Q?jWOJorv7X7ntZA3nVvsZnLRQgaedu26jM8N4q0dmGvX/9DCvX3sTw9c647GL?=
 =?us-ascii?Q?fczKvE8erlQNXt32kZY/n+WtVsJQJ8LQ1/ViXm8EUdTniXPgAOHzYgnPLuov?=
 =?us-ascii?Q?gBnXpeI/51ZWKdCl/SdPF8FovYNvQVlgFgxIt97PLlxf1RF5ygrQwl+WA4D+?=
 =?us-ascii?Q?4vFVUU+1ymj4uysBO2QRUI240U3eXSb/Rmt4qweo4gpsYkeWy8gEcVrr2MFc?=
 =?us-ascii?Q?CnLvwbqJDjW7ocb/dSROYYFoYrqkPVM4VjLJ1FPqH9gFI3DlCCantIfJ0gih?=
 =?us-ascii?Q?oLsb2tmBUPfMcIF7yqcrbRkieSbbKokLY1EiZd9+xNlEAOUVJD/fHoFeU1nK?=
 =?us-ascii?Q?pD1DKNY1f8aqoERq3jSex7XQy/eim4fCVmdpfpaV9MF/WKcPcS8lC5Qeqscp?=
 =?us-ascii?Q?iY2+oYek7qEhcTmYsGtyKRpgYLPSPW89BVrBEY6QbseNk0MJhMeaxWCT73Ph?=
 =?us-ascii?Q?y3zgef54dlWMcNWjszEU88QUI6175PlVuW0CysM27bTx9gmXZKED9dNbtUnw?=
 =?us-ascii?Q?aI7nFDL2aiMwPJCIEc5K7IFXIgPoa3PLn7c3BcCRIKyf+QMASEB2anhCVq+7?=
 =?us-ascii?Q?cX+uBUDEKS5KgRV71pBQHQ2ZL/qksY+ucFi720GI4W/Hf6Mohtl6zxmv2P7M?=
 =?us-ascii?Q?xkbvqCyKUJvgX0lXGoRxFFfWPYNylEL3MvIVeMoSpWTlsvYIVDNAgSU1bye1?=
 =?us-ascii?Q?N6My03WEYPDR0hzGeHI0aAcdWZbLSsPNHucYn4HeqnKObl09AwrDeZJIYBH8?=
 =?us-ascii?Q?P/Qe6slNvquTDddI882HNAR6Y7oVaWEAClB1hp5ARcEfKw2mAWuNCGbs6LK/?=
 =?us-ascii?Q?Qb6Y50eKICqfWzyH6tb3mqpUvS/MomIMOXfHB3sFukoiy7eH7wWaUkDNkWxM?=
 =?us-ascii?Q?Q08IHjtJIqa1kOf3t557WH6khS7S++MC7a4kct8gPPnevidYOHZQ4fdgsU8h?=
 =?us-ascii?Q?9qMnustVblX2dfvrrjM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e9431b-4bc6-46fa-a74d-08dc7338de47
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:38:46.4236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByULsSLKrKYbVYmMluXhU8rghES0op7XygV9oAChvbKseohAn8x7mPynp8zlVU7Fzk+LiKQ48UtaGtFAt8/CqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4381
X-Proofpoint-ORIG-GUID: Z_N5ufNoJKy7V2w3F91nN3kPD5mu9mqG
X-Proofpoint-GUID: Z_N5ufNoJKy7V2w3F91nN3kPD5mu9mqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, May 11, 2024 7:41 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
> representor netdev
>=20
> ----------------------------------------------------------------------
> On Tue, May 07, 2024 at 10:09:14PM +0530, Geetha sowjanya wrote:
> > Adds initial devlink support to set/get the switchdev mode.
> > Representor netdevs are created for each rvu devices when the switch
> > mode is set to 'switchdev'. These netdevs are be used to control and
> > configure VFs.
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > index 33ebbcb223e1..ff4318f414f8 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > @@ -28,6 +28,157 @@ MODULE_DESCRIPTION(DRV_STRING);
> > MODULE_LICENSE("GPL");  MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> >
> > +static int rvu_rep_napi_init(struct otx2_nic *priv, struct
> > +netlink_ext_ack *extack) {
> > +	struct otx2_cq_poll *cq_poll =3D NULL;
> > +	struct otx2_qset *qset =3D &priv->qset;
> > +	struct otx2_hw *hw =3D &priv->hw;
> > +	int err =3D 0, qidx, vec;
> > +	char *irq_name;
>=20
> Please consider using reverse xmas tree - longest line to shortest - for =
local
> variable declarations in new Networking code.
Will fix it in next version.
>=20
> This tool can be helpful: https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-
> 3A__github.com_ecree-
> 2Dsolarflare_xmastree&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DUiEt_nU
> eYFctu7JVLXVlXDhTmq_EAfooaZEYInfGuEQ&m=3DMq4aRWpUpar1zTktQDlrt8Jl6
> 8BXQjkee8RpXExMCFcKMalirC_mVOYEGA0fcuSf&s=3DKg1fSyZvUeZAO0TSWVB5
> A1GPqngBfG82Tx1Dz46ZH8c&e=3D
>=20
> ...
>=20
> > +int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack
> > +*extack) {
> > +	int rep_cnt =3D priv->rep_cnt;
> > +	struct net_device *ndev;
> > +	struct rep_dev *rep;
> > +	int rep_id, err;
> > +	u16 pcifunc;
> > +
> > +	priv->reps =3D devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev=
 *),
> > +				  GFP_KERNEL);
> > +	if (!priv->reps)
> > +		return -ENOMEM;
> > +
> > +	for (rep_id =3D 0; rep_id < rep_cnt; rep_id++) {
> > +		ndev =3D alloc_etherdev(sizeof(*rep));
> > +		if (!ndev) {
> > +			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF
> representor:%d
> > +					       creation failed", rep_id);
>=20
> gcc-13 seems unhappy with a string spanning multiple lines.
> I suggest living with a line longer than 80 columns in this case.
> Maybe:
>=20
> 			NL_SET_ERR_MSG_FMT_MOD(extack,
> 					       "PFVF representor:%d creation
> failed",
> 					       rep_id);
>=20
> > +			err =3D -ENOMEM;
> > +			goto exit;
> > +		}
>=20
Thanks for the feedback. Will submit next version with the suggested change=
s.
> ...

