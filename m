Return-Path: <netdev+bounces-96273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A918C4C67
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F4B20C0A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56069D2FA;
	Tue, 14 May 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jH1Qtmvh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB14C74;
	Tue, 14 May 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668822; cv=fail; b=uNUplFeNr4WSejd/mVTQeUZbFPbvqSvLXIbEdPnPcHd3RH1ltDNEvTY3unK8kLpbDwf3kVrnQMnIbT85qC4FsrV5s1PxNyWRUa/gOyHGjDzKOoZIGkL7SXxwwLwGy1g0L82P71E4V+MnbQY2CDPw/SgtaWwlPc1zhColACo/wiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668822; c=relaxed/simple;
	bh=nj1NVJILXDYpNWAcdVjmrnywAxdL+t9eQFbIWDK4Zro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4W1WtRdsTzsDWZx5LIzh4z1kfAZOdxfPWy31+fYSXtGO1OPOlqsNpA6Mf9/0X057cJyqxIN49V4NofEtWxFb9nm7WS9fS9lR6e2fXEtUXq+Jt9AYIzqVVVWrX3vaEqp2Vi8UDVhEQiKLD9y41H35mBuXOn2vsTBrYoMKTpcznU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jH1Qtmvh; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DLvG2Q015147;
	Mon, 13 May 2024 23:39:50 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4k9tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2wff1jn9tBBB9WXdiqPPf1WQyWICFjZl2WqT0wsRm4mLRb2LqIARdZSs2WkbWxh7L611lAVrDoTf8BmiPWtKjBbt3FPLj0KXvtkAOZR1QJvGfV84WKWaLpik4eewbjedfCPeZctWCDZqXLxdeFQINOIaO50OpDT2FQUmJFpBGm/GvaYCgCHR+7ODNY4mv8vMle/1x3FRtu7V7fiZ+l6xJrZcdciGzcPqmwvx0KD8stNrDVhAi5Du3kdpkxu2nOis+JE/QF5E0a0c/btvTMDC6h2WCkPW89hezLDCb4pbRatv49FBqLYhUrvxVC/jSaT1Hhw8BYqv8CpX1u1HUKU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtyCLsG6MVaVniqw6NbOJKyNLW9hB3hNlt22pnR+YRU=;
 b=NEIMAcFckWXzo45F2f9OkUKMxwU4ztVyP9WDaEhPBZIc+JiH0kVZBmNNua44bmwnwrfH6WMGU6GkoWiuxWmsAIFvI8a1K9loWvPRVXToEl8+/vPJ42ewkgJodeIoBkl7iAMQ/19ZGfus9SGO8PnmOD3CDcgF4Zw2N/0aQwX0ZneV4Xb1j5mBZdJdA3gDQTJTBdP0zp/DZpgh5/PQ49QhCAm67oPlyg4MT6sDjrMOnt1MmWpq0Ks3UlZstsQEwN4t42wUW9C44td8m9fCIjW+mxVh4KqmMNL716uEsjn80y8N7cv3LCTYkCV2BnOGxrwvE7DIyDVl8+pvN/17Tv0kMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtyCLsG6MVaVniqw6NbOJKyNLW9hB3hNlt22pnR+YRU=;
 b=jH1QtmvhvrxgHo+RnvlhKLMSFB19bkSK+sQcfKNwoX1ZsP6wJNToQVPWRooF/lSR95oFqEQ1HYJRfckbcXYiOS6rbdSVpGMu3mC3PvzXUr+AZvejn2aMjIgE2EuKS8N3NNC2RD0rbWGSCYoQvu7qorDQxJ9XZ6eqLFtW6tB1wDo=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by DM6PR18MB3505.namprd18.prod.outlook.com (2603:10b6:5:28e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:39:45 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 14 May 2024
 06:39:45 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Jerin Jacob
	<jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: RE: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Thread-Topic: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Thread-Index: AQHapSQKuOy9XZhP3kiH1e4gTcWZRbGVVxCAgADtLRA=
Date: Tue, 14 May 2024 06:39:45 +0000
Message-ID: 
 <SN7PR18MB53149716909DE5993145509AE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-4-bbhushan2@marvell.com>
 <20240513161447.GR2787@kernel.org>
In-Reply-To: <20240513161447.GR2787@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|DM6PR18MB3505:EE_
x-ms-office365-filtering-correlation-id: ec65e74b-b0d4-449a-f231-08dc73e0a4bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?vOnVvcspTc1I9XbFwCQJnPt+NfA2C+LR1VLJTLfH1BL5XGhHEDiTMui3wTeZ?=
 =?us-ascii?Q?FDEm55OI1052t/6+PW9AFTtOuRvgvFpXNc7Msg+VrTAoW3Ivt+o22mxi+Sa3?=
 =?us-ascii?Q?TBCyV6EUiwQ6XEnTwibXEl2Rpy6mTktqMnVIqjHIl9pb/eE71kUsuhD9ztof?=
 =?us-ascii?Q?GuL/BI9E6+Iyr8pit22QNNXfxXju/H09aDWH39PxcQomYMKKMAf4o7IecSt1?=
 =?us-ascii?Q?UuNsbucCTenxxi1MHIk9Jx2/h1vHhDDbIcHuM7QURBZfKLXUgWLiQtCNEU9j?=
 =?us-ascii?Q?siImOYShcDZnZlDjliQdxcrzTnfnXZ0lB4BWlij1Gu6SQMuNlIs2NZYSbGHA?=
 =?us-ascii?Q?0zxUGTI2DdCq+GS3C07fIAK6FJG1QomxGfUCRAwl05pC55i/+3f7fn82b0Pd?=
 =?us-ascii?Q?h3TDSIpemtaYV2tyQy175TIRjeSLMCFLXajzxWytUbMPWAUN3CZpopclRt2R?=
 =?us-ascii?Q?aqoxsqJ1auCxcBaWXFlS5Hg8I12l1YkCuOuhThwI8AgBDL8cb7Ezuq/BSMln?=
 =?us-ascii?Q?cKbY6DKCecjGNyHzJhWqu8B6wIjm6VA0EZRIJglDkrE56AnvU+lQo5xSNmTm?=
 =?us-ascii?Q?/+e3/EBOa2J+J5L1pM8V3f+nO8Z5/cJQKvsJrHTKijyGHAWsQIzR2/Ddp1YE?=
 =?us-ascii?Q?JOwoM1zdblW2V/i85Zy7BHRoFVGE17RRkSs4LYlyOvt4MeyB1JOjWxN+2hyy?=
 =?us-ascii?Q?BLInr8hZqgsyND/8lW6r9PtEjFwCEMq/OCSJIyJKR3qAZMEo/ULeuwrqrspV?=
 =?us-ascii?Q?s4sgat63rThFiSUECIbM+TSt9hi/3pWaquegDmQDITV4aO52f3JBHx4D3mQB?=
 =?us-ascii?Q?IbU9ebyPZCECx0tVbgJhjAfwOWbgxD2G8jXaoilEDD9TL5NBX+whArXpY0Qx?=
 =?us-ascii?Q?sjY4GdqNB5FtbpJ6yjzKmpLrFiLSp63cllg6zkaQRdi8gmxVr9AzqJt1sqtF?=
 =?us-ascii?Q?n4+1lZUBX5DPZ8MUHSrv7qyddRhL/Lz3L97kRnYdCAMz/wtBOhOdFUAaiAUU?=
 =?us-ascii?Q?zZBlOoewMBbjXEMVyME/O9JDC3rCtXxtd5KaH25bpOo6REsBcXrwToZXdBEi?=
 =?us-ascii?Q?fjSS5uEOHpDX4GXU2dM2uXqlJXJ2lazthafjHzAJbESjDu6tp5sYPYS158Bk?=
 =?us-ascii?Q?0o7UKx0Ld57X4weYnEtKEfPIM4qYhx5FacZZi1zKjfny79hrtPzINDuixN+W?=
 =?us-ascii?Q?Tnq7aJgn72M0mkhQjxBbknK+yErWt8UAlav8u8afcViwyxpmETeGq3sXlZBi?=
 =?us-ascii?Q?XsIw2r2Pe8JwQ1Kscl4sdJbPcEeHgMAZrYq2kgpjOhkTofK0Ln4HTg/cIh+u?=
 =?us-ascii?Q?TjjHOklvYh0bPuuOmTUOg/PTyRsRRjXNDZHeLIAuzdFQFA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UWmeEshkA4adBX1P0zjyR4JEZqsodjzSJ2qOoHujEXFziBV/8BZMS9hwCZ6I?=
 =?us-ascii?Q?bVrO6fOPvadQxjDeO/nzUGVzI8/J118PJIemLqonhdIiRSyQhgWXYjPWyWEW?=
 =?us-ascii?Q?Ds9mkCgS1+JLJhFL9GTdM2TItd6nCVQ8Ql68iw+jQIgllEuaS0T9o4gJILU4?=
 =?us-ascii?Q?C2gE/cL1YIBHwtWbiQJh7AeIKFphoIoXzgaOYOfsn2hd+4QOv8uOdc8pzOIA?=
 =?us-ascii?Q?FVAgDdBQ5KlLD5YEUpun+9V8ZkvecdAtYED15AoDoMaAhyEPcWbdPpjIukvG?=
 =?us-ascii?Q?VbBOj34OjQvh0aktHg+JHDvLCT/w2AwqBvR/R1yX+wKTJnQ2VQHRZHhvtQFd?=
 =?us-ascii?Q?BSd2y6DgS0xxIfWqR91dTCki6bRoy0eSi8WT/A4K1Fqmdv1c2O5tY6FoVama?=
 =?us-ascii?Q?xrNTuh55R7AgqwS6ek3wB/JwYpZN2ZBd74pXlHYhm6WJ6d2dq9p6iNkJpCkk?=
 =?us-ascii?Q?NVRfzluPCHupJWtS7M7omPi26kklVpuf6/Nc7hzkmIPuVaTSCczgWFGrT9Jh?=
 =?us-ascii?Q?cpcIJ4R0E46GHnXCXGqBbUMsa0CD5x4CsCeAREz19K/czv5ex2ocSWL/ronn?=
 =?us-ascii?Q?9me2KoswMA3HJJYljt0KL0YnIyLYLodRKQncYq9ZyWhEXQIo57XF8SPi1mTg?=
 =?us-ascii?Q?h0NxxjQEIs5BPzkzimupsF02Dxb/mUlGGYfHuSNEXzTbTG+7N2NtvKum0PSC?=
 =?us-ascii?Q?Pd7WDEiCoMisFEmoHdfjq8WJr5uwcj/IZ1NdHbTuCA9P+W/f9t3aKmDorSty?=
 =?us-ascii?Q?oBrtFPixbkGsEIvKN0VDHpp8UbVALCza7fJCMmrMyEQmlTzj9GrkcO8m8upR?=
 =?us-ascii?Q?ffV67iVmz7yrN3btJ1K887YmKR9I+33Xj9E9cPZnQcLPXm/Mfb37YUw7RQHf?=
 =?us-ascii?Q?E2sfecp0IXqeIYOXdXte36bpgiY2lcEgbifMiDC3EILKUZykzdFENHDNoF6c?=
 =?us-ascii?Q?RNkH978wFbXfFO3IT1Qckqgg7uvvOpIk996p/1e0sG/qZcuUQoEveSkCAD6O?=
 =?us-ascii?Q?4IBaXyY0WKAoWfSrlHXRTsG9zn8tX/WrB+avvimJOHTHIjtVdlFludGYu7mM?=
 =?us-ascii?Q?+lucNap6qe3zwwOAgB85rEArlnCq9XXGjKJE9q0ClssnljZKN5GC+ceEOWXp?=
 =?us-ascii?Q?HXLpL0XIyfIAblXsQ3vlcCmFGlRplgvGWSYIgHr917Th2ksesvcUfS9TaeG/?=
 =?us-ascii?Q?XWT1jLp9njM1sIvhuRwH65kBoUvkBdrm8Zm+Tnt/QzPJTZunOOtkXsAGT9yp?=
 =?us-ascii?Q?6BWAxDaPu1twnJ0aT24bKD8bVUXVdlXaf1qewrLUQop/oXD/UXA+wQ/BKEde?=
 =?us-ascii?Q?KBvohoyJXsxvnEwpcVMsl438u0edRGCz0rFeI2Iaw736KtM+VC+QCuwY3+9N?=
 =?us-ascii?Q?mcLegOzLcijQ8DkABHte0jaCqWMZ0ody3uPU5xK2Gh688tuEn6HiE/DsQpU0?=
 =?us-ascii?Q?xp4JasIbrLA6VILyLsoHt37rpAPMHdFj8M0KWkqqFDqa7G+EB7lZulAqmndo?=
 =?us-ascii?Q?KxP4f836vtrmf0LcMzTsos69cFGIrfjMOvBoZu3IVIr1mtivvYJFkAky/4Zl?=
 =?us-ascii?Q?uX4IbOk7s+Pvqhpvr0GWx85PnqrayoCjbwqw/aWp?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec65e74b-b0d4-449a-f231-08dc73e0a4bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 06:39:45.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M41pIh9PgiK6wvru357RUMJnFOFcQpMfIPqYp1eyw9q7tLgRnpLpa12mimCdrGMSIDOy/5B/QninvzuR+hCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3505
X-Proofpoint-ORIG-GUID: 3YngV1FnOqb6IYPwRSPBxtdJWWqDGP77
X-Proofpoint-GUID: 3YngV1FnOqb6IYPwRSPBxtdJWWqDGP77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_02,2024-05-10_02,2023-05-22_02

Please see inline

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, May 13, 2024 9:45 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> richardcochran@gmail.com
> Subject: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable backpress=
ure
> between CPT and NIX
>=20
>=20
> ----------------------------------------------------------------------
> On Mon, May 13, 2024 at 04:24:41PM +0530, Bharat Bhushan wrote:
> > NIX can assert backpressure to CPT on the NIX<=3D>CPT link.
> > Keep the backpressure disabled for now. NIX block anyways
> > handles backpressure asserted by MAC due to PFC or flow
> > control pkts.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>=20
> ...
>=20
> > @@ -592,8 +596,16 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu
> *rvu,
> >  	bp =3D &nix_hw->bp;
> >  	chan_base =3D pfvf->rx_chan_base + req->chan_base;
> >  	for (chan =3D chan_base; chan < (chan_base + req->chan_cnt); chan++) =
{
> > -		cfg =3D rvu_read64(rvu, blkaddr,
> NIX_AF_RX_CHANX_CFG(chan));
> > -		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
> > +		/* CPT channel for a given link channel is always
> > +		 * assumed to be BIT(11) set in link channel.
> > +		 */
> > +		if (cpt_link)
> > +			chan_v =3D chan | BIT(11);
> > +		else
> > +			chan_v =3D chan;
>=20
> Hi Bharat,
>=20
> The chan_v logic above seems to appear twice in this patch.
> I'd suggest adding a helper.

Will fix in next version.

>=20
> > +
> > +		cfg =3D rvu_read64(rvu, blkaddr,
> NIX_AF_RX_CHANX_CFG(chan_v));
> > +		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
> >  			    cfg & ~BIT_ULL(16));
> >
> >  		if (type =3D=3D NIX_INTF_TYPE_LBK) {
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 7ec99c8d610c..e9d2e039a322 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -1705,6 +1705,31 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf,
> bool enable)
> >  }
> >  EXPORT_SYMBOL(otx2_nix_config_bp);
> >
> > +int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
> > +{
> > +	struct nix_bp_cfg_req *req;
> > +
> > +	if (enable)
> > +		req =3D otx2_mbox_alloc_msg_nix_cpt_bp_enable(&pfvf-
> >mbox);
> > +	else
> > +		req =3D otx2_mbox_alloc_msg_nix_cpt_bp_disable(&pfvf-
> >mbox);
> > +
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	req->chan_base =3D 0;
> > +#ifdef CONFIG_DCB
> > +	req->chan_cnt =3D pfvf->pfc_en ? IEEE_8021QAZ_MAX_TCS : 1;
> > +	req->bpid_per_chan =3D pfvf->pfc_en ? 1 : 0;
> > +#else
> > +	req->chan_cnt =3D  1;
> > +	req->bpid_per_chan =3D 0;
> > +#endif
>=20
> IMHO, inline #ifdefs reduce readability and reduce maintainability.
>=20
> Would it be possible to either:
>=20
> 1. Include the pfc_en field in struct otx2_nic and make
>    sure it is set to 0 if CONFIG_DCB is unset; or
> 2. Provide a wrapper that returns 0 if CONFIG_DCB is unset,
>    otherwise pfvf->pfc_en.
>=20
> I suspect 1 will have little downside and be easiest to implement.

pfc_en is already a field of otx2_nic but under CONFIG_DCB. Will fix by add=
ing a wrapper function like:

static bool is_pfc_enabled(struct otx2_nic *pfvf)
{
#ifdef CONFIG_DCB
        return pfvf->pfc_en ? true : false;
#endif
        return false;
}

Using same like..
...
        if (is_pfc_enabled(pfvf)) {
                req->chan_cnt =3D IEEE_8021QAZ_MAX_TCS;
                req->bpid_per_chan =3D 1;
        } else {
                req->chan_cnt =3D 1;
                req->bpid_per_chan =3D 0;
        }
...

Thanks
-Bharat

>=20
> > +
> > +	return otx2_sync_mbox_msg(&pfvf->mbox);
> > +}
> > +EXPORT_SYMBOL(otx2_nix_cpt_config_bp);
> > +
> >  /* Mbox message handlers */
> >  void mbox_handler_cgx_stats(struct otx2_nic *pfvf,
> >  			    struct cgx_stats_rsp *rsp)
>=20
> ...

