Return-Path: <netdev+bounces-100104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664778D7E06
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898CA1C20DD7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4B537E7;
	Mon,  3 Jun 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ho4ERzrd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88933495CC;
	Mon,  3 Jun 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405474; cv=fail; b=ppGlUFPrcLTBq8qwsmhHAAyPoq0U427xeu4wDNqR07VtQQNM1jq6fS9yH9hMrc0ncbeqCOIWywudOa6/CHWHc3jDzHNQZa20MfUAddOC8a5xLpVk9PFtF5I1N9LtnzVSp3h40lxRmsuFIyjJiZROeZvzrU5/wVWT2BtmaALy3g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405474; c=relaxed/simple;
	bh=Vs0MEiQwC+I8iRSXOAx6y7aLLNF/7z1H0yQdAC6WDDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2Op4aToWgccHfOqh3aDOuMqv5vYFk/T7RQIPmSRnpeXpC97F25bSmKyWho3CfUT4gnU4+XravvPJyJH0v2+8xiJikAHkxaVLeaAD/R61GLB88PvoHfSGICJO04t7uoW/KKuFGhmU9BCAUZCPnMLoWlLPV5nQkvnd2LbICojKMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ho4ERzrd; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452MtBZn007374;
	Mon, 3 Jun 2024 02:04:25 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yg35hc9fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ieito8iRz1CKCEkyBTERo6p5HygcZiFI4n8lqUA8FkEUaylIQzigdcMC4sPEuKRZsgKZeeOrPXA24xwUEJcRFRTBbl8GJUGhETSFymj1MTwOj1fNntsQazOfVdBpwmWGvUU/6kLWdW3azOo/90IClccGpQE8XrFs+UaFpeOjzfu1Sxa8BilK2f0eYNJKMVrGcwtE5YTDE0O/eqWQRe9Zihyq7S1rxv0loUnzdOQGkm7YRg5v3oVijx5CddoiN01pNQj8bW1KiIw/mizgCPu9w1HEhL4BwNMFjOE51dHt+BxKuG/2z36OsZQ60bbwtzUbX8w6tOfakFPQ57IRBPppQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qCIWYE9NaGU8oAxdykR2vj9l2FWtlUPOKM6oL6pfa0=;
 b=hf2LlWVyexSOnG32AmofZtFHKTDGY/Vj1HmQMExsdeWmFJTkEKjmybFGv5Bwhh8cEdFP3nJfzr0kF20Cfy/SLOu01l+NvczWl9rbOgh0Xed+RKugp5koS6P0RXY+eAUWqbDeEfxuQsFnMuzLtnzUn/4hhWhX8/tPcR9mPa0Vk0X0KNYuDLZ75x+6/8HTq9myh0vNSfR13VijWEhRl2LyeySJmBqDJe+MLAsdVfj/Ea9g02RZubkfEwJYFxse8adGSH3BT/MbPDLGb8Pt/w1++EKlaYpr7BzwTsJokvZ8mUJSYTiGqSItFgAN9ctjTLws4CUncygu6vxawVaRVKZA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qCIWYE9NaGU8oAxdykR2vj9l2FWtlUPOKM6oL6pfa0=;
 b=ho4ERzrdlcF7EyUGySyHV0h9cDgCphmiJIlBkWaunRqjiDUgvLCCc5GdIFJMV8FvvNKfLVsN2Zmak+mb/auozjp284b+49he4sNJeiWHmTVrVaX+Mhs3IYBev1BhWEvfkfVUq8YhmYdcJkl9AhGpF9vhnBP44Lq0lIOHi4qpuIk=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by BN9PR18MB4172.namprd18.prod.outlook.com (2603:10b6:408:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 09:04:23 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:04:22 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
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
Subject: RE: [EXTERNAL] Re: [net-next,v3 5/8] cn10k-ipsec: Add SA add/delete
 support for outb inline ipsec
Thread-Topic: [EXTERNAL] Re: [net-next,v3 5/8] cn10k-ipsec: Add SA add/delete
 support for outb inline ipsec
Thread-Index: AQHasQaPDAjBHvZ8ekqyrRu0MLgk67Gv3zyAgAXjqBA=
Date: Mon, 3 Jun 2024 09:04:22 +0000
Message-ID: 
 <SN7PR18MB5314D6ADA32A16AFB778B4DDE3FF2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-6-bbhushan2@marvell.com>
 <20240530144959.GC3884@unreal>
In-Reply-To: <20240530144959.GC3884@unreal>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|BN9PR18MB4172:EE_
x-ms-office365-filtering-correlation-id: 95ad33f5-e826-4778-ed71-08dc83ac2935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?vegBj8OKi6vYqI+R4CpdubwSmkzhgCaZbMEe9hyDMC/slyHfMsxnQ9G0dG/J?=
 =?us-ascii?Q?EIslnyFHiT2e8HM61i3x2eIEa7uvZNsrJ0EsruDThVoAhPz1k4Xs4uzJQbFs?=
 =?us-ascii?Q?8mgh98o4fNKSpwrSwV4dbkCbCk6Tcb0wK2GORf9mgNqBH2KHi8zFSJ1U3xFj?=
 =?us-ascii?Q?dNVT6g+97jRsRWvGLAsxol/FdyE690VqHJC8A2RETDVkXNHNjYdqHkyM2tEl?=
 =?us-ascii?Q?GUHiaNMx8lCJ1Y0MOzQuHxv6BdTiQU5wfeq9cMpJkIGnGc98bpZ4xiw3zxvh?=
 =?us-ascii?Q?NeCqdJwkq357p/2Q9mVDvPDn4vpqNIbFRPk4WZxe1sUn72SpnQ2IGPQgC1XE?=
 =?us-ascii?Q?FnUf3BcDRguH2cLkA0Odu+R9ipie8sK0oL/zPLyNIptBeI+yX24PA+TBjjMi?=
 =?us-ascii?Q?yAW2NAcEtCEGoAhfPSVZrgfRl1EiHWT+WjDKspREIVCeL1TDmSvRZr4+j12x?=
 =?us-ascii?Q?eJhUpnFVT7R8yZV5Cc431CZ/kFNcn5KPXJYfqaUJjyVzsRbLPcHg/x0p9PMC?=
 =?us-ascii?Q?ges6i0LaPOOFwId0GOfIc/kdzRxu0GMxFJaqiYrQvuAQSY8vdh9tT9RhPZpR?=
 =?us-ascii?Q?m8ZqnnEJNpAs+1ZangEP/7Ugi3UTYMg4fZaux3LGebgcuP+XwsTqppvFUHIu?=
 =?us-ascii?Q?bgVDQXVIG9kAeL3pUZzxo/HYQnznlbHYiFAeMlQW1vx2CjQN1CICO1/ECDov?=
 =?us-ascii?Q?kuGFVFajiWOSXfA3l4e5efF8/7BsG2jKT6W82uzavqp5wqV7z03rN+I8f0ic?=
 =?us-ascii?Q?uUzSdqNwzVBxlH4FfQRTSMHN9ZvHpV2z42sTnFp908FgzOB27RrwPFHSuQSJ?=
 =?us-ascii?Q?SorRO/ToW1dI4Tsd0i7phTg/p/3jaf1LP8HJW9JAL7Mj0cVGM3pdl2tFv92Q?=
 =?us-ascii?Q?PycUqZdyFPZT8rLNazrP3WGa70qcn0Sm5blEJH3lNZntunK1exCdbQ+zbapH?=
 =?us-ascii?Q?Mk1R3MXSAUN1MpZgGSxbYYW8JQmgRUOX3w7RHhz9QyJSiy4o/rMBWqvvbPuO?=
 =?us-ascii?Q?V1W6hFBIMwcX+wo8ny6XvUy8wIjZWCAw1Lw7uNeYFw+Rakz5wEQGo3Pj78ra?=
 =?us-ascii?Q?qc88dHSDorhVuSMTn9z4YLkPQhzou5p5ZMD3nXt3pmRkOTCLGiGXolZm1jz+?=
 =?us-ascii?Q?5+Kh/OfTycMowaTX/PXokXuSXzd+6+TfHDsq2F1zErUjD9PSs4ESYVT/R7Ep?=
 =?us-ascii?Q?BjFMal5roGgWWwVcd8DRm2fFr6ST7AoGWijYh252HHytJx+UlkamysdEyswo?=
 =?us-ascii?Q?ts5hmKqOs/7Pru93o9nN9oHtHuUVLzCf4+QBF/ocq/qJadOca+OoSF8GajwG?=
 =?us-ascii?Q?vI99fJ/q9pH9ocGvsHUyCiUib6Ukun+EjHTd3/w5ZRL2Sw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?q+BC98qYXwonCjPOzrY5rvBnxaE2H+vEj1n2ET6uAcSCxS27abDxIcqvV3J3?=
 =?us-ascii?Q?csXvahb/edhWVsMjhYxZ/l9D30nB0vMrIJGcikKG6eBsxvyKJr7U4l7hLAQC?=
 =?us-ascii?Q?7hAgmDzejGA8ldAOaB9g/ZoJ1IgFXmW0XkbRiN6VOB9cJZmpJ7EYHlWv6T1h?=
 =?us-ascii?Q?7tZiduo6+zPFW7mw5ZRVy/SkJr/JCTiDYSxaVPaKYmS1SagzLCXPPwGGLBtN?=
 =?us-ascii?Q?CTpiYtV4KjIKS22RhAQh+0mRTE99ouetZfwF0OO91CKeM8I1CU4VgFhOIHBL?=
 =?us-ascii?Q?AoSuGdmDqAxZzUfOTc5ZP3qQebFPFsOBUs0IdtEzhm7YWNIHXumoEFfoSDxd?=
 =?us-ascii?Q?KNKTj90WfEvjaXguksCmOO2fyS1RcvlUFzjEdrT3jEJYkUnCnmSDHMx1TFGk?=
 =?us-ascii?Q?utiSsrL/sQSR31vezcEwPLMXoB3mQXLQBhXq4u2a0nzU+MYjI8zmhYfRwYVT?=
 =?us-ascii?Q?mXcBWeOPkx3O4224Q6VHFv7bh5V2lERR36jVEXSihtxiw7QzfVM+tEBfwxwz?=
 =?us-ascii?Q?F69OAFdyV4h8DtapoblJ++f70/Ewoa+AzJmWKUNI9vgwzxxWzJDj8Ujn65IA?=
 =?us-ascii?Q?tOjFjAWi1UKAYCb/6V2IbhPgeFqc6Qw4udccZrGC2Hb3FqnoDMQxMzbuHqq6?=
 =?us-ascii?Q?ANIi5JF9Vs845KgkFqNVjgcrlS8RAgt+cxTwSgNQCxOACvV6x9jGqI7/cJ3J?=
 =?us-ascii?Q?8GoM4K03ZyFImeib2MtvrzXrUgE51G1jhVNOUsS44gsOYl5m732LsY2mq43R?=
 =?us-ascii?Q?H5R74AokDaBSKkwikSn5hr6iKDyRMLGw/A4IjRZK6bRHMMyr1ieWZPcWQzs9?=
 =?us-ascii?Q?GPsH3TxHJaQGNnSjLRBRP95QDv47SH7W37W2wPt0cp064T7yYaY0Hta3Hpu/?=
 =?us-ascii?Q?gqCWnkrvaAUX9GID/gMGtVV2NVtBcPTzswe5UQiO95JUN5qc19/mL9maULQV?=
 =?us-ascii?Q?2PQ/p6/mw7rLNR4aMeyjGlsgNQsgAcxlNbJ8wE4Rzm4+XlObp40eUE4SSCap?=
 =?us-ascii?Q?2mMUVXuD8vFcSaaJ310kMbaeVRdCaEZA1xHrZbI18MRfJtUd0Hcao3zJ09T8?=
 =?us-ascii?Q?VwJM/BszjtTqCyRTRFeMp87tS/jgDFYYgqRt84sC2M7W0tKgC5fZe5xBTwum?=
 =?us-ascii?Q?V6Fg5ZX7zvpjJ6EL69IX9z0N7MHgnuGCVphFcxYPzbBjsfO34A1fEntViUGE?=
 =?us-ascii?Q?z69vOcc8dOVh/LjY8lIM+i1Weqj4GmbRI+zoou2faguyCufU0H7JSArxH4PX?=
 =?us-ascii?Q?wn76uK1OiXHzKeSxSpkJalFApcpgXKSfbR527/oZQDmN0wRyG/aolnSSstE/?=
 =?us-ascii?Q?u4yQOOH/gcmdu8R43QtzAqYaYhecrXFcuJP2iGdw/HZ15IA9JEP4sPlv2KUg?=
 =?us-ascii?Q?rew7ul9i3vyLdCv9JhveX1ETKN1mLZAQcTW9UiE5nnevVHtZrHcYbH/sHYAH?=
 =?us-ascii?Q?mgHTXMOUAronBJZEp5cguVEDQYU+lhUHAcZssMMo7Xz4QKv0Bujq0BbVbQe/?=
 =?us-ascii?Q?2EruxJW7rKL0NclNQ8HVtTREHaqHWnONSkc3mRYoy7SB7+0Eq5vuJlTwcJ/l?=
 =?us-ascii?Q?6WvJnQQvtvdczaisTHAyiSFrwMh9QgiW5Ok9C2Yt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ad33f5-e826-4778-ed71-08dc83ac2935
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:04:22.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF9Kf3InSrUYqyWNm13jQ2NfO0dU10VspfU1p03PQV4+3N5RfSJpskI+JgNKyH7M7rijnI/zjt0PYncFtQxj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4172
X-Proofpoint-GUID: _51ClP8jwzK5x2gRB5Q6-3w2QzEFaF86
X-Proofpoint-ORIG-GUID: _51ClP8jwzK5x2gRB5Q6-3w2QzEFaF86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_05,2024-05-30_01,2024-05-17_01



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, May 30, 2024 8:20 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> richardcochran@gmail.com
> Subject: [EXTERNAL] Re: [net-next,v3 5/8] cn10k-ipsec: Add SA add/delete
> support for outb inline ipsec
>=20
> ----------------------------------------------------------------------
> On Tue, May 28, 2024 at 07:23:46PM +0530, Bharat Bhushan wrote:
> > This patch adds support to add and delete Security Association
> > (SA) xfrm ops. Hardware maintains SA context in memory allocated by
> > software. Each SA context is 128 byte aligned and size of each context
> > is multiple of 128-byte. Add support for transport and tunnel ipsec
> > mode, ESP protocol, aead aes-gcm-icv16, key size 128/192/256-bits with
> > 32bit salt.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v2->v3:
> >  - Removed memset to zero wherever possible
> >   (comment from Kalesh Anakkur Purayil)
> >  - Corrected error hanlding when setting SA for inbound
> >    (comment from Kalesh Anakkur Purayil)
> >  - Move "netdev->xfrmdev_ops =3D &cn10k_ipsec_xfrmdev_ops;" to this pat=
ch
> >    This fix build error with W=3D1
> >
> >  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 452 ++++++++++++++++++
> >  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
> >  2 files changed, 566 insertions(+)
>=20
> <...>
>=20
> > +static int cn10k_ipsec_validate_state(struct xfrm_state *x) {
> > +	struct net_device *netdev =3D x->xso.dev;
> > +
> > +	if (x->props.aalgo !=3D SADB_AALG_NONE) {
> > +		netdev_err(netdev, "Cannot offload authenticated xfrm
> states\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->props.ealgo !=3D SADB_X_EALG_AES_GCM_ICV16) {
> > +		netdev_err(netdev, "Only AES-GCM-ICV16 xfrm state may be
> offloaded\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->props.calgo !=3D SADB_X_CALG_NONE) {
> > +		netdev_err(netdev, "Cannot offload compressed xfrm
> states\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->props.flags & XFRM_STATE_ESN) {
> > +		netdev_err(netdev, "Cannot offload ESN xfrm states\n");
> > +		return -EINVAL;
> > +	}
>=20
> I afraid that this check will cause for this offload to be unusable in re=
al life
> scenarios. It is hard to imagine that someone will use offload which requ=
ires
> rekeying every 2^32 packets.

I agree, Currently ESN offload is not enabled. Enabling END is in our list.=
=20

>=20
> > +	if (x->props.family !=3D AF_INET && x->props.family !=3D AF_INET6) {
> > +		netdev_err(netdev, "Only IPv4/v6 xfrm states may be
> offloaded\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->props.mode !=3D XFRM_MODE_TRANSPORT &&
> > +	    x->props.mode !=3D XFRM_MODE_TUNNEL) {
> > +		dev_info(&netdev->dev, "Only tunnel/transport xfrm states
> may be offloaded\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->id.proto !=3D IPPROTO_ESP) {
> > +		netdev_err(netdev, "Only ESP xfrm state may be
> offloaded\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->encap) {
> > +		netdev_err(netdev, "Encapsulated xfrm state may not be
> offloaded\n");
> > +		return -EINVAL;
> > +	}
> > +	if (!x->aead) {
> > +		netdev_err(netdev, "Cannot offload xfrm states without
> aead\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (x->aead->alg_icv_len !=3D 128) {
> > +		netdev_err(netdev, "Cannot offload xfrm states with AEAD
> ICV length other than 128bit\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->aead->alg_key_len !=3D 128 + 32 &&
> > +	    x->aead->alg_key_len !=3D 192 + 32 &&
> > +	    x->aead->alg_key_len !=3D 256 + 32) {
> > +		netdev_err(netdev, "Cannot offload xfrm states with AEAD
> key length other than 128/192/256bit\n");
> > +		return -EINVAL;
> > +	}
> > +	if (x->tfcpad) {
> > +		netdev_err(netdev, "Cannot offload xfrm states with tfc
> padding\n");
> > +		return -EINVAL;
> > +	}
> > +	if (!x->geniv) {
> > +		netdev_err(netdev, "Cannot offload xfrm states without
> geniv\n");
> > +		return -EINVAL;
> > +	}
> > +	if (strcmp(x->geniv, "seqiv")) {
> > +		netdev_err(netdev, "Cannot offload xfrm states with geniv
> other than seqiv\n");
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
>=20
> I don't see check for supported offload type among these checks.
> if (x->xso.type !=3D XFRM_DEV_OFFLOAD_CRYPTO) {  ....

Will add the check.

Thanks
-Bharat

