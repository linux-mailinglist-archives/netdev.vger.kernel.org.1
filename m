Return-Path: <netdev+bounces-96278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BE8C4C75
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780CF1F21A0E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC58F513;
	Tue, 14 May 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lIX75LVz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D31E541;
	Tue, 14 May 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669583; cv=fail; b=bXf3WKmG1KKIN5XxvKUGo5lEbPNnEHR5fAPGbbicbibBP64TaDz8gkbzBWCpo57ieUVi1YrZoNogUzvX5OqtHox1O6lIB7sHXbGUIBA4PQQtG0Wr61LHH+3VLBe97mBe6kXmchSlpAlJ0CX/EqOu8am48u/uCFgc8wMNzyM+aDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669583; c=relaxed/simple;
	bh=USnhrvuMrzYp52oi+0DFo3rwOc4ZEHfCf31LA7wNZGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mghj+HBMTXM6U0WnNNGAzONY2C/cm6+kXTNV/TMmLNOFBgq+8NJEW0gyivcgLyC4hZQFmjdGYjEYAh70SXpzYBq/cEAqMU7AwnWzhODXTnyQnnIj2XizeI9+iiab5lbjxX/NFgpmC36ZvJ/HjfmJ9/fT38UWzMHWPe61pVETgfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lIX75LVz; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DM9rEk013251;
	Mon, 13 May 2024 23:52:42 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y3udn956f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiPvkiWZJD5Vn8xzqJkkDLe6/k3wGWU2k0SoNyXm/LwJ2G7Dm0d4AVgOwMed1MYJGpRXJIlhzBuJTnGcBdyDSudbEAKf2cY5z3QcKljFfjH+aA2FonASuQj+pqQdX6obSD0VyzwPQk5hMKiaeXOiAsPjb6SFPnaYfpTqm7rXJWGDV8N3SvOPz2x2P+39wrIzP1x/MW6QQwUv2KNOMkhDDWSipi8eTPojPVn03nOXSHVbkcDQ55h/jncnkMnav+H6gDmQddiOVUU5UFZU2HpGlfM72icW3Q1d8p/RtEeqKG922siwEh29rMur20RQah745Lax+qso3cgDBNAXJVu1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIo9MeR4C/bOBFx5NfNZV8w9T+5HQyL2K+z0OHehvdI=;
 b=ESKDdHE2GZNwHISKeu2wn/S92mUv5cug5f30Xx62toHbgBM0LRm/5O/jeLmAopa1nNAs2LVMj7u0LPCrhoOFzr7fYQgczKllzZVk8O3oooNAJ2YnG33W2XWx4QhEOKPEG8ms86avUsmoGSR0YiNyKsx7hnVHGlg9kwNMIu0i7E47H8vHkHdhHf3X40huQUN6/rXgHubbS3Xnwkzo5tthI8e9LYjnmeMZv8A/IHNRqjWM7cfR9V+Ynahb+z5DVbIQYvpxMHsNO05Kk43mZqkq/5XkKVYTGtccu2RGjeCFtGoGPCTTESudMg3JwttWwvtEPNml5VPkEHWQU5FyN6Wtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIo9MeR4C/bOBFx5NfNZV8w9T+5HQyL2K+z0OHehvdI=;
 b=lIX75LVzMdgfPIEU/WZ+KwvzqI7IozaBginPS+4gPuu5c3Wek8IeF78y/7OYgpFqF0tRY/tbV/HObjZZzvER6Za+szA+DJjUg0PetqCM2w2FX5cv4U2efUk2EzeUPsjlxeqewESiGjTCNUJbU97c/l9hEigx3w1Ot5Vlx5ujS2I=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by BN9PR18MB4250.namprd18.prod.outlook.com (2603:10b6:408:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:52:38 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7544.041; Tue, 14 May 2024
 06:52:38 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete
 support for outb inline ipsec
Thread-Topic: [EXTERNAL] Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete
 support for outb inline ipsec
Thread-Index: AQHapSQR0x+Esvjms0OtuMaRtaoBH7GVYVaAgADoFFA=
Date: Tue, 14 May 2024 06:52:38 +0000
Message-ID: 
 <SN7PR18MB531442D0D88031D320F3372BE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-6-bbhushan2@marvell.com>
 <20240513165133.GS2787@kernel.org>
In-Reply-To: <20240513165133.GS2787@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|BN9PR18MB4250:EE_
x-ms-office365-filtering-correlation-id: e282c4f9-4260-4781-6e0f-08dc73e2719d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?+FG6j7FC9Cd9jERzM+4Qe/wzMXdNCF71gN+AmHAO8y4JRxHSb3L01Igi3eA0?=
 =?us-ascii?Q?j6gFShXbgDeyiaCBYD8j33Oe++UHcDldZHCmoQAwbTYVV5fYcpeeVt3OxcE9?=
 =?us-ascii?Q?Ptr6CE8kYfy1mlHxOO/JrRVR6MInfuV/6XX+pJokvDRmIsiXhqCdgktZTlzQ?=
 =?us-ascii?Q?vJj6y1Y27Bo6pcZIGkQW6I2G0CqZJDF+EeHEghzOASAtB8+RoQoUCyW+Tlt3?=
 =?us-ascii?Q?C3U2s5+f43dQtMNgPuRTcdqSbA9Ge5SoKZ2BbJwFgyuKyyzdm3VfrgqPQrQv?=
 =?us-ascii?Q?l2PH6SNW4RdujuAPP22DtdXPjNhXr/3B7NrbmFwp3jKAlm9Vh14yT+Tj2BY9?=
 =?us-ascii?Q?CSR7b23FWYYWTFU5nwDW+mZpe+zUO/soOYnKtey1uRm1Vo7PrV3OCCKavJri?=
 =?us-ascii?Q?//ES1EqDL4QVlAk6xSJlTaIy4HTkcRPwjhd4fNhnprYMF3VKdKLYZTKIjGSV?=
 =?us-ascii?Q?Y+zpSG5/BPu6T3z29ebnOpSUw7pn5t5TT9V2ZURqJT9AEtC1QxlAhVXuu03X?=
 =?us-ascii?Q?pdQ03tadGYDIcni4UhvbI5gzHgBFjeEZkp6ELuyBcOO9o4vhGUrpTg3uSklr?=
 =?us-ascii?Q?SYmFDqrwXQ0aA07as2RS1IihBXpFYh9bpplIL6YODOQiFlE3vd/dmqWlOoI2?=
 =?us-ascii?Q?Aj72vsFi0NvS2ve99FMfSxT9J7uNx9WBaIlFB4GHLBZZATD8vIr6VyHZf3LU?=
 =?us-ascii?Q?A+TPguyhDIszfU+uhaGVP9Xb2jker37OtZ9ZQTIyYkoEzuTPXU3Co5HWzhVL?=
 =?us-ascii?Q?WGLmc2L7/gtwDDL8qZGzS9PPipwHcRhYtIQtz0Fwnsl2cC352FvyMuPwYUHr?=
 =?us-ascii?Q?NnFkSW/1LH8PpZRdbUTlA83WcT2anVqwo5jHQkm4JQI6Tn/jSohLqweyy3ik?=
 =?us-ascii?Q?6kAbznLPUevR7clnAkqWIpcNyztbt7uqqhezNcgTBnBBdqcpwJNkAy8XD6WH?=
 =?us-ascii?Q?rEGYKvWjTFfyB6EBWeEHXNVtLHS8mMxJogPvOolH6tuGKDYJ+VycFAUUMvH/?=
 =?us-ascii?Q?7qjrjEfdGM8Lhhkb6PDIRS2L8OUP2fGGgoe1Kj+VUY5y46vBsWRCjVFL5Aux?=
 =?us-ascii?Q?/nWMhByekOsyL/YMVIuAEBzcphKTFYRIC9nA5F07/1IiBDwEAMPTXNZZ0YMu?=
 =?us-ascii?Q?R73GetAij0FMunCe+R4vNiczMbPjHgWxtkZpjlY1smvg0/P9S6edC3xCYEWA?=
 =?us-ascii?Q?9FfNzAw2VcSULauk8IXmj0vc3I/OrdGflOBgM4+LsZeylEO1KWUq3Mbybuac?=
 =?us-ascii?Q?IN9DEn3uPNOTM5WmwDgI7sGrZ2H0FyDWgCpmRXLWw+gRfPReivl1tf6PX0WM?=
 =?us-ascii?Q?UJXUC1Pi+rDEBzdITjxMpAK8zoGmlxsNwkp4C+6v884SbA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aGLu6HINuQFsLcWC8p0IE/p4QYIGJxfnwJrjiRLUxti2RXBkjRUzlWdoRh9c?=
 =?us-ascii?Q?BKkaQHW1T3h61a96dWLAhmMvd2/yg3cQKNQh7bSJlEjiy6jaboD9E4Ua6DkL?=
 =?us-ascii?Q?igIQvEn5ClqbO79BxFxSr/v4eHj9ZAOPBKZXalIwe84/tVCC/fINu4lI25V8?=
 =?us-ascii?Q?4ms3+fDc4B8MuTwoers7XJXxs4wdgAosvGLQ4URKVMnSIEl7iyAn3SkXw8tG?=
 =?us-ascii?Q?xTKqpJ4IzZwQGhkxmd0FwE6sHZ7gMSw7LQj4fVz2JQ/lpPboj6+4eU46tANY?=
 =?us-ascii?Q?0s3OJTbNBwbEjLYsvrMW4vFI/wqJhryGoT7Zplrf3d5YYPgWLolCUWak/YsE?=
 =?us-ascii?Q?T7aYQaiSp1xbCiyV6buS2KTH7Q8niK/mQt9vmuJHLpt2qPLjpuf3H3Lrtucs?=
 =?us-ascii?Q?gS0qUjn7ZADu1eXCxJ0cTkL3nWw/DK9Ms+2+GFeIEeELtHUZoPIIBZPK2aAr?=
 =?us-ascii?Q?kICYNL/raL8yJgW8r3IZqtL1BCesSFO9mm1pH9iC6+ToSk+MhopvF2GsMB70?=
 =?us-ascii?Q?XXkaWh9oSQ84a7nlEprTgJGRrQnnMPKlABj0FKLqhVDLJvKnV9gxJbNg6tcU?=
 =?us-ascii?Q?B1r4bACGYLDAl7oHvCM6PAbuekMq9DPXm9h3AMV/2bcMZJi165rrsU7CMofz?=
 =?us-ascii?Q?LxQQ5kyz8C0NdoerU71SZhdPbJeMbAhTwMwGd8LDSSC2DIPnZ36Fhx9BqkCb?=
 =?us-ascii?Q?gBgBdXGYIFqUzhLW4gOKjANerbXTJP98V00OWaf17Hf5w+8OyQ+ajBqESOZS?=
 =?us-ascii?Q?DDccdylX5NfVxxslKwn/2Z7czWn0O5od6rq32mnYACdoC3XbOp2g/tqfKRHK?=
 =?us-ascii?Q?TUmGJQMdSMbY31DraLWYi0Z8iRSQ6Uon8/gj2wZcnEJWzse1MiKAEy1+QpQ2?=
 =?us-ascii?Q?nqBOoojV/+KffrYiO0TjzSbCG5pb2/ob4FtlBVj3kUKZbeEUdYppg0Qv+VY6?=
 =?us-ascii?Q?mJYlax5WvPuyzlG5j5Cd8bz4Op9LCjukX46dK/WNYTHy9Z15/19ChBCd5v2X?=
 =?us-ascii?Q?r40w6Lk5x+RG+mCfxRQckdOsT+k61qOQAT7PXnCSLZ4vzdX+ijF/dQR8sVgV?=
 =?us-ascii?Q?8LcBn5ekIAEXYYSZ3x0qhZ+HxjgMLrc6k1uqttm19+Wzr+9onZXS+VU8LIh4?=
 =?us-ascii?Q?amRn6WWlyALmlwGG9hxOd4CP/pfgiIckRIY4SJ6+3B/lu/j/hjtFRCabSquG?=
 =?us-ascii?Q?JR1IqUvdt39dOWrDP3nGe/lMHpwZN5d0hEtTULEIN5AGRXpgvYtbInfhRal8?=
 =?us-ascii?Q?PLd+FC4YvpHNSb/xUCeuH5RRjdZ3nrcBtMvDq8n9EvV0+6WKijj2yeSY5HcY?=
 =?us-ascii?Q?901ecXpbrt3EDhfex8tFk4bEa+v54vmxr2VDA3qa5P7NmLf6DG1awLwBg0mJ?=
 =?us-ascii?Q?h+GXD9evxgfpTRlIXHCIKGshCPKtzaPzOhDLDfHi+iUOpY46Dcov5/K7cXub?=
 =?us-ascii?Q?WufBe6m++kewujV/8SHXON/jtsgzlt1UXvVY0bmvJ9ctkEhtjcKFC1QILkeb?=
 =?us-ascii?Q?EvC1w0neA/tNjrje7PqUNLHq+7bFiWHtrA1UmJE1o5j+gcu1WCG9fpO9TSpk?=
 =?us-ascii?Q?4QJcgBWbSR3RDwQYK0fDiyqHJDc2OhHhiJXa58et?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e282c4f9-4260-4781-6e0f-08dc73e2719d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 06:52:38.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwiEH/ugNNxrXOofJs2kOZGVyGKqTdQXxJuvnTzvYThg1kgT+G4L+oQa2K414V1x3mKaaFDpi8iyXhCn03oNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4250
X-Proofpoint-ORIG-GUID: XnoP85846KAQphOh0rH_Q5j_6AEcOagj
X-Proofpoint-GUID: XnoP85846KAQphOh0rH_Q5j_6AEcOagj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_02,2024-05-10_02,2023-05-22_02

Please see inline

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, May 13, 2024 10:22 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> richardcochran@gmail.com
> Subject: [EXTERNAL] Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete
> support for outb inline ipsec
>=20
>=20
> ----------------------------------------------------------------------
> On Mon, May 13, 2024 at 04:24:43PM +0530, Bharat Bhushan wrote:
> > This patch adds support to add and delete Security Association
> > (SA) xfrm ops. Hardware maintains SA context in memory allocated by
> > software. Each SA context is 128 byte aligned and size of each context
> > is multiple of 128-byte. Add support for transport and tunnel ipsec
> > mode, ESP protocol, aead aes-gcm-icv16, key size 128/192/256-bits with
> > 32bit salt.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v1->v2:
> >  - Use dma_wmb() instead of architecture specific barrier
> >
> >  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 433 +++++++++++++++++-
> >  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
> >  2 files changed, 546 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
>=20
> ...
>=20
> > @@ -356,6 +362,414 @@ static int cn10k_outb_cpt_clean(struct otx2_nic
> *pf)
> >  	return err;
> >  }
> >
> > +static int cn10k_outb_get_sa_index(struct otx2_nic *pf,
> > +				   struct cn10k_tx_sa_s *sa_entry) {
> > +	u32 sa_size =3D pf->ipsec.sa_size;
> > +	u32 sa_index;
> > +
> > +	if (!sa_entry || ((void *)sa_entry < pf->ipsec.outb_sa->base))
> > +		return -EINVAL;
> > +
> > +	sa_index =3D ((void *)sa_entry - pf->ipsec.outb_sa->base) / sa_size;
> > +	if (sa_index >=3D CN10K_IPSEC_OUTB_MAX_SA)
> > +		return -EINVAL;
> > +
> > +	return sa_index;
> > +}
> > +
> > +static dma_addr_t cn10k_outb_get_sa_iova(struct otx2_nic *pf,
> > +					 struct cn10k_tx_sa_s *sa_entry) {
> > +	u32 sa_index =3D cn10k_outb_get_sa_index(pf, sa_entry);
> > +
> > +	if (sa_index < 0)
> > +		return 0;
>=20
> Should the type of sa_index be int?
> That would match the return type of cn10k_outb_get_sa_index.
>=20
> Otherwise, testing for < 0 will always be false.
>=20
> Likewise in cn10k_outb_free_sa and cn10k_ipsec_del_state.
>=20
> Flagged by Smatch.

Fill fix all error reported by smatch in next version.

>=20
> > +	return pf->ipsec.outb_sa->iova + sa_index * pf->ipsec.sa_size; }
>=20
> ...
>=20
> > +static int cn10k_outb_write_sa(struct otx2_nic *pf, struct
> > +cn10k_tx_sa_s *sa_cptr) {
> > +	dma_addr_t res_iova, dptr_iova, sa_iova;
> > +	struct cn10k_tx_sa_s *sa_dptr;
> > +	struct cpt_inst_s inst;
> > +	struct cpt_res_s *res;
> > +	u32 sa_size, off;
> > +	u64 reg_val;
> > +	int ret;
> > +
> > +	sa_iova =3D cn10k_outb_get_sa_iova(pf, sa_cptr);
> > +	if (!sa_iova)
> > +		return -EINVAL;
> > +
> > +	res =3D dma_alloc_coherent(pf->dev, sizeof(struct cpt_res_s),
> > +				 &res_iova, GFP_ATOMIC);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	sa_size =3D sizeof(struct cn10k_tx_sa_s);
> > +	sa_dptr =3D dma_alloc_coherent(pf->dev, sa_size, &dptr_iova,
> GFP_ATOMIC);
> > +	if (!sa_dptr) {
> > +		dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res,
> > +				  res_iova);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (off =3D 0; off < (sa_size / 8); off++)
> > +		*((u64 *)sa_dptr + off) =3D cpu_to_be64(*((u64 *)sa_cptr +
> off));
>=20
> Given the layout of struct cn10k_tx_sa_s, it's not clear to me how it mak=
es
> sense for it to be used to store big endian quadwords.
> Which is a something that probably ought to be addressed.
>=20
> But if not, Sparse complains about the endienness of the types used above=
. I
> think it wants:
>=20
> 	*((__be64 *)sa_dptr + off)

Will fix this and other errors reported by Sparse.

>=20
> > +
> > +	memset(&inst, 0, sizeof(struct cpt_inst_s));
> > +
> > +	res->compcode =3D CN10K_CPT_COMP_E_NOTDONE;
> > +	inst.res_addr =3D res_iova;
> > +	inst.dptr =3D (u64)dptr_iova;
> > +	inst.param2 =3D sa_size >> 3;
> > +	inst.dlen =3D sa_size;
> > +	inst.opcode_major =3D CN10K_IPSEC_MAJOR_OP_WRITE_SA;
> > +	inst.opcode_minor =3D CN10K_IPSEC_MINOR_OP_WRITE_SA;
> > +	inst.cptr =3D sa_iova;
> > +	inst.ctx_val =3D 1;
> > +	inst.egrp =3D CN10K_DEF_CPT_IPSEC_EGRP;
> > +
> > +	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
> > +	dma_wmb();
> > +	ret =3D cn10k_wait_for_cpt_respose(pf, res);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Trigger CTX flush to write dirty data back to DRAM */
> > +	reg_val =3D FIELD_PREP(CPT_LF_CTX_FLUSH, sa_iova >> 7);
> > +	otx2_write64(pf, CN10K_CPT_LF_CTX_FLUSH, reg_val);
> > +
> > +out:
> > +	dma_free_coherent(pf->dev, sa_size, sa_dptr, dptr_iova);
> > +	dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res, res_iova);
> > +	return ret;
> > +}
>=20
> ...
>=20
> > +static void cn10k_outb_prepare_sa(struct xfrm_state *x,
> > +				  struct cn10k_tx_sa_s *sa_entry) {
> > +	int key_len =3D (x->aead->alg_key_len + 7) / 8;
> > +	struct net_device *netdev =3D x->xso.dev;
> > +	u8 *key =3D x->aead->alg_key;
> > +	struct otx2_nic *pf;
> > +	u32 *tmp_salt;
> > +	u64 *tmp_key;
> > +	int idx;
> > +
> > +	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
> > +
> > +	/* context size, 128 Byte aligned up */
> > +	pf =3D netdev_priv(netdev);
> > +	sa_entry->ctx_size =3D (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
> > +	sa_entry->hw_ctx_off =3D cn10k_ipsec_get_hw_ctx_offset();
> > +	sa_entry->ctx_push_size =3D cn10k_ipsec_get_ctx_push_size();
> > +
> > +	/* Ucode to skip two words of CPT_CTX_HW_S */
> > +	sa_entry->ctx_hdr_size =3D 1;
> > +
> > +	/* Allow Atomic operation (AOP) */
> > +	sa_entry->aop_valid =3D 1;
> > +
> > +	/* Outbound, ESP TRANSPORT/TUNNEL Mode, AES-GCM with AES
> key length
> > +	 * 128bit.
> > +	 */
> > +	sa_entry->sa_dir =3D CN10K_IPSEC_SA_DIR_OUTB;
> > +	sa_entry->ipsec_protocol =3D CN10K_IPSEC_SA_IPSEC_PROTO_ESP;
> > +	sa_entry->enc_type =3D CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM;
> > +	if (x->props.mode =3D=3D XFRM_MODE_TUNNEL)
> > +		sa_entry->ipsec_mode =3D
> CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL;
> > +	else
> > +		sa_entry->ipsec_mode =3D
> CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT;
> > +
> > +	sa_entry->spi =3D cpu_to_be32(x->id.spi);
>=20
> The type of spi is a 32-bit bitfield of a 64-bit unsigned host endien int=
eger.
>=20
> 1. I suspect it would make more sense to declare that field as a 32bit in=
teger.
> 2. It is being assigned a big endian value.  That doesn't seem right.
>=20
> The second issue was flagged by Sparse.
>=20
> > +
> > +	/* Last 4 bytes are salt */
> > +	key_len -=3D 4;
> > +	sa_entry->aes_key_len =3D cn10k_ipsec_get_aes_key_len(key_len);
> > +	memcpy(sa_entry->cipher_key, key, key_len);
> > +	tmp_key =3D (u64 *)sa_entry->cipher_key;
> > +
> > +	for (idx =3D 0; idx < key_len / 8; idx++)
> > +		tmp_key[idx] =3D be64_to_cpu(tmp_key[idx]);
>=20
> More endian problems flagged by Sparse on this line.
> An integer variable should typically be used to store a big endian value,=
 a little
> endian value, or a host endian value.
> Not more than one of these.
>=20
> This is because tooling such as Sparse can then be used to verify the
> correctness of the endian used.

Will fix in next version

>=20
> > +
> > +	memcpy(&sa_entry->iv_gcm_salt, key + key_len, 4);
> > +	tmp_salt =3D (u32 *)&sa_entry->iv_gcm_salt;
> > +	*tmp_salt =3D be32_to_cpu(*tmp_salt);
>=20
> Likewise here.
>=20
> > +
> > +	/* Write SA context data to memory before enabling */
> > +	wmb();
> > +
> > +	/* Enable SA */
> > +	sa_entry->sa_valid =3D 1;
> > +}
>=20
> ...
>=20
> > +static int cn10k_ipsec_add_state(struct xfrm_state *x,
> > +				 struct netlink_ext_ack *extack)
> > +{
> > +	struct net_device *netdev =3D x->xso.dev;
> > +	struct cn10k_tx_sa_s *sa_entry;
> > +	struct cpt_ctx_info_s *sa_info;
> > +	struct otx2_nic *pf;
> > +	int err;
> > +
> > +	err =3D cn10k_ipsec_validate_state(x);
> > +	if (err)
> > +		return err;
> > +
> > +	if (x->xso.dir =3D=3D XFRM_DEV_OFFLOAD_IN) {
> > +		netdev_err(netdev, "xfrm inbound offload not supported\n");
> > +		err =3D -ENODEV;
>=20
> This path results in pf being dereferenced while uninitialised towards th=
e
> bottom of this function.
>=20
> Flagged by Smatch, and Clang-18 W=3D1 build
>=20
> > +	} else {
> > +		pf =3D netdev_priv(netdev);
> > +		if (!mutex_trylock(&pf->ipsec.lock)) {
> > +			netdev_err(netdev, "IPSEC device is busy\n");
> > +			return -EBUSY;
> > +		}
> > +
> > +		if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
> > +			netdev_err(netdev, "IPSEC not enabled/supported on
> device\n");
> > +			err =3D -ENODEV;
> > +			goto unlock;
> > +		}
> > +
> > +		sa_entry =3D cn10k_outb_alloc_sa(pf);
> > +		if (!sa_entry) {
> > +			netdev_err(netdev, "SA maximum limit %x
> reached\n",
> > +				   CN10K_IPSEC_OUTB_MAX_SA);
> > +			err =3D -EBUSY;
> > +			goto unlock;
> > +		}
> > +
> > +		cn10k_outb_prepare_sa(x, sa_entry);
> > +
> > +		err =3D cn10k_outb_write_sa(pf, sa_entry);
> > +		if (err) {
> > +			netdev_err(netdev, "Error writing outbound SA\n");
> > +			cn10k_outb_free_sa(pf, sa_entry);
> > +			goto unlock;
> > +		}
> > +
> > +		sa_info =3D kmalloc(sizeof(*sa_info), GFP_KERNEL);
> > +		sa_info->sa_entry =3D sa_entry;
> > +		sa_info->sa_iova =3D cn10k_outb_get_sa_iova(pf, sa_entry);
> > +		x->xso.offload_handle =3D (unsigned long)sa_info;
> > +	}
> > +
> > +unlock:
> > +	mutex_unlock(&pf->ipsec.lock);
> > +	return err;
> > +}
>=20
> ...
>=20
> > +static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops =3D {
> > +	.xdo_dev_state_add	=3D cn10k_ipsec_add_state,
> > +	.xdo_dev_state_delete	=3D cn10k_ipsec_del_state,
> > +};
> > +
>=20
> cn10k_ipsec_xfrmdev_ops is unused.
> Perhaps it, along with it's callbacks,
> should be added by the function that uses it?

I wanted to enable ipsec offload in last patch of the series=20
("[net-next,v2 8/8] cn10k-ipsec: Enable outbound inline ipsec offload")

Is it okay to set xfrmdev_ops in this patch without setting NETIF_F_HW_ESP =
(below two lines of last patch)
+	/* Set xfrm device ops */
+	netdev->xfrmdev_ops =3D &cn10k_ipsec_xfrmdev_ops;

Last patch will set below flags.
+	netdev->hw_features |=3D NETIF_F_HW_ESP;
+	netdev->hw_enc_features |=3D NETIF_F_HW_ESP;
+

Thanks
-Bharat

>=20
> Flagged by W=3D1 builds.
>=20
> >  int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
> > {
> >  	struct otx2_nic *pf =3D netdev_priv(netdev);
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> > b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
>=20
> ...
>=20
> > +struct cn10k_tx_sa_s {
> > +	u64 esn_en		: 1; /* W0 */
> > +	u64 rsvd_w0_1_8		: 8;
> > +	u64 hw_ctx_off		: 7;
> > +	u64 ctx_id		: 16;
> > +	u64 rsvd_w0_32_47	: 16;
> > +	u64 ctx_push_size	: 7;
> > +	u64 rsvd_w0_55		: 1;
> > +	u64 ctx_hdr_size	: 2;
> > +	u64 aop_valid		: 1;
> > +	u64 rsvd_w0_59		: 1;
> > +	u64 ctx_size		: 4;
> > +	u64 w1;			/* W1 */
> > +	u64 sa_valid		: 1; /* W2 */
> > +	u64 sa_dir		: 1;
> > +	u64 rsvd_w2_2_3		: 2;
> > +	u64 ipsec_mode		: 1;
> > +	u64 ipsec_protocol	: 1;
> > +	u64 aes_key_len		: 2;
> > +	u64 enc_type		: 3;
> > +	u64 rsvd_w2_11_31	: 21;
> > +	u64 spi			: 32;
> > +	u64 w3;			/* W3 */
> > +	u8 cipher_key[32];	/* W4 - W7 */
> > +	u32 rsvd_w8_0_31;	/* W8 : IV */
> > +	u32 iv_gcm_salt;
> > +	u64 rsvd_w9_w30[22];	/* W9 - W30 */
> > +	u64 hw_ctx[6];		/* W31 - W36 */
> > +};
>=20
> ...

