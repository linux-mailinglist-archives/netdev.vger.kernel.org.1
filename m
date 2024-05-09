Return-Path: <netdev+bounces-94832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F328C0D27
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E99228317B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153D114A4DD;
	Thu,  9 May 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SEftCokw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2914A0A6;
	Thu,  9 May 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245761; cv=fail; b=ueVlj4KEByvP5HnSVN2TUqIM6JYM7XxwJfOpfWfy1aGZ6ZaK8WBuhOqU7FlXWBDZeg96XIXIgDMDDdAUpFCWZG38YpGFiwJPYl1FQyrZGOrnK7hwsujaYQSsotqmQ+YfZUG7uslP8DoqcdPxGPzP6VAHiSAnPPtFwv+LqR82CS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245761; c=relaxed/simple;
	bh=J0tpSKrAQgS0yE1Z8SBiaAghjYvzZvyV1+OdT7VOiSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jtw9JjVVGLjDu0Co+DW8DWNPFTMlXGvSJrLl9UqzrXP37cYxxqh4myP724Xs2aAAXyKSXyBocrlpRG5ptQ0GirAxzTtVPeqmG8X9HNuM0FhKbtrC28a1azqsWQlBB06lOFZzIrn15PkbWxQDaKgFzexSujNJ58y0jU494duDbt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SEftCokw; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4494fMBf022099;
	Thu, 9 May 2024 02:09:03 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0qpbs954-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 02:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWst0kNF/Aw036daBiwLGWABJudcnqBLhTREOW+qF2QdoPXfLnKfmtzgimjUtNKk8mlCWYQgP733+aeA3UQc8FG3SuHOuQPwwnUJscwMNE9MYzFwzf90fAbzuWJgwsNBprBE2gPmQLOUb8GFrgEOLhCeZGJTZI0hq9CtvoCVobqo8tymkUrJH9rKWt8OfFvUmS/EQ3oHzzeMim5GLiSTZZTe77AcmI8Apez7Gswn7Ac6S/MHRHjKQEesH/dktw78UZco95IXDVAuSY6iSadngnN0dYhjpLXkTL6elcydFSeeLqgjgvO3rpben6jhBwMg5rWKgJzjjN2LWMW/cVKMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Oc3FHu5NDvomZN7M2An7nsFvTU/mAud7mGSK9YXl9M=;
 b=SWy1quxJx6tGi5gvXytIjlJ94fvRNEYbao35Hg221Z3s6HqOotAzFHd9+5OKohrgfAk8jBSNxfpQQgH79bloa6+zUlC4QZrvUCoPqCVrAOiDt67EkZl/jf4KkF+2vlN60AqxOguP8Bqhl86XN/AGYIBcLKXVxBQrmeiW1O5un/wBk9K6ecbwaQmIVl8EgL27VphI4zYIkr/CP/y/o3wUqrZeQDUzzytMww9izHVdn5ZEAaN3CelZUD7FIwojMZXfKwi6C1L1jmxKEu56otpXa7PxbLzrZNzwlGdlXI0Lb+0T4WkZqTcvxIflcfNbitQSYSVVcZ2olf09WZ/ivjf3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Oc3FHu5NDvomZN7M2An7nsFvTU/mAud7mGSK9YXl9M=;
 b=SEftCokwvCqCM9lrIFaZN81EFz2OjH4AIF/8aj/epTanatMemYvPBqlHcaZQbQ4m6QdmwJJ2oWysD/rA/KFiwehXUckzszWEob3XiDancVcgrVErFWt6p1Z5OJ/3s4ehmH7jODeJ16cUTQP9fwMPDqpv41Kv+fq+r+uxNtsraV4=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by SN7PR18MB4015.namprd18.prod.outlook.com
 (2603:10b6:806:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:09:01 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 09:09:00 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open
 function
Thread-Topic: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHaoUT5RWh4TO7cuUeh1vkT8i8o3LGN87+AgACfZICAAApUsA==
Date: Thu, 9 May 2024 09:09:00 +0000
Message-ID: 
 <MWHPR1801MB19187C10FEBB29BDACE499B1D3E62@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-3-justinlai0215@realtek.com>
 <20240509065747.GB1077013@maili.marvell.com>
 <9267c5002e444000bb21e8eef4d4dc07@realtek.com>
In-Reply-To: <9267c5002e444000bb21e8eef4d4dc07@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|SN7PR18MB4015:EE_
x-ms-office365-filtering-correlation-id: 7d0956c0-bed2-4982-9a5d-08dc7007aa74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?hlWD5mQ4mdImA1rFyjGd9dsC4dxhKC1yDbo/1X4PCsiGRTEDXtrfwWtRaKxE?=
 =?us-ascii?Q?A8vDqD6HL/SaSXU3i7HvkJfslpm+Nfo+AirXW1KgvJdcCvuHNhIa9cLCIgPk?=
 =?us-ascii?Q?OZxSSDIr3/hwfQUk+T03vjSTLLzZoC6kKFsKzOk0sO0jlSXPA1QlwxBWGboH?=
 =?us-ascii?Q?JN+dgYKlSB3kkF6sZkh0G2HZgABwjQ9KyPYEql15LAcJTztkmZzCfZPYJPDq?=
 =?us-ascii?Q?blwpV9sl3OHGCaVmYwllHE3qH4EC/GKVZKHIiDLx/0Pcuqp4NQKpZRJUGmmN?=
 =?us-ascii?Q?+j3/NdFMNNvjioMy4Wk3XCdHxpvqorGr/L8V71qNiDurkYa/PY5yAfJnOt13?=
 =?us-ascii?Q?RslBLneBwS/obtDeNy7inhyAPTOEIm7BlZDrQQ3//tp3he9i5omRaQSaFlX0?=
 =?us-ascii?Q?MWryqjPCtHVj9bcRbUouDHzpxegc5pKhyl6KZ+ZT/cGKtGgqYCOh8NLlzhMg?=
 =?us-ascii?Q?T4nHkDMj+4u17CxtT2bi260BYAMFEDOWrYwQJ2AhZEtTnI9uFpGSeOYtbGt6?=
 =?us-ascii?Q?YGUktfIqfV3p1R2w4W0JJbScHRpiiAE9KTQtxKUCSbP54q4syDXqucMwFhj0?=
 =?us-ascii?Q?j8uXxSrN92AvSk5HMSwrfuxlMqnZZYlMvEPNwE9iVXHJUMGIJlmGzmrpQo3M?=
 =?us-ascii?Q?Bmkw4V1wjxt8gXxxa6EqZPLesnn+yINBRc470b3wienzL+qx74ZDeCldkB8x?=
 =?us-ascii?Q?J4j86WSDNhK7EQ7MVNQhtBqjzwdIyK3quSUxSfouZUmMfOLndIrYOH7uJSls?=
 =?us-ascii?Q?n2z5Q0pej8GksnNCjrUpAeT6fVpwkawdvJba2pvzoD88cxfXlFAwvBa5phsu?=
 =?us-ascii?Q?2GZ7rgko/uP6BNChDTaArmzy+VUOe4k6WBRJdGooIZ50fCRgM1RcPDW2ntsK?=
 =?us-ascii?Q?E/Z16y3lPIPelDaEkvCHRf+FHdYLiD9FFvLv4p/rK3gizZH56xW1tOfssCd7?=
 =?us-ascii?Q?ioNicMy7wlv56A0RULqyscpE9zZZe4676MMsz02FX79k6EPfUJRsP2VcotvI?=
 =?us-ascii?Q?EY6CWR9YxjCbOezd6qDWcQ69EBm/Bq3aQz8lWI2iP+4hRQ8kkQja1sU0eRj9?=
 =?us-ascii?Q?FS7+rYH0kSh5uDvvbTZyR4yxAFFnniN3zVKp4x8bReFt7rpfTsuWrB5nrCmF?=
 =?us-ascii?Q?jMRdaTtjyioLSdXMi6TQAY9IZAvgS9+qd08WG1bH7rFl4NMk3MyntH/nRFe8?=
 =?us-ascii?Q?O80q05ZcfJW/zr1cLZXU/fq13ebVkzAJ4gn+cCg+OtQbbjJmMJt3gdBCpOCd?=
 =?us-ascii?Q?r8j1LLVZr0US+EMUycyfPuihtEkgOsaPf0UOFn7P00KO6MnnvvuvX/TCPne6?=
 =?us-ascii?Q?Pj4SIN5ijPlTpl695Pjun2N60AzGcByvfOvhdQu15jtJqQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PtRHLfTwvB6BbnD2JiVSNITVohwU5W3AzVrihHsufq88LyXn2tBEb3p03bIY?=
 =?us-ascii?Q?L+pmGKVrt84/jcUStYyV8lkRGrzNWpHzLEkI/w+fD32Q2dZQdWnrJ2PVN2Fe?=
 =?us-ascii?Q?0CY1QnkOXoOZfaly6JdwASKMvS9ShfwE2OdZ839WgFZWGRKJpfF5dn/CfyIM?=
 =?us-ascii?Q?RukLpFLro1Kc4IbkghdilizrxLF4rE/mLRGRWoWmqHpJXlfQERUpAGJJ8eqG?=
 =?us-ascii?Q?vjKoQ8Irqpjje1pMlku06BiIzQ8YLc5AwUwD2wblqB9NasCmmih+E4VVeCR+?=
 =?us-ascii?Q?pPtbaJfMmWBdpwVSlvycM6NrBxZ0COCgZcEMw4ahq1QdJKdXbce5PAmvFK5H?=
 =?us-ascii?Q?ApTp2PsMYTJhaMCNPCM+dTShLc35et8ZI7jsCq6pNGCsSl3uCkD+SmA1NwLX?=
 =?us-ascii?Q?XM1scUdFCP+BHXCvd3R552vOpK3jXyWuSEWk6GCFPava+oDF946MDgVOHMP7?=
 =?us-ascii?Q?amAN7Z7BBGRlYpT6eirpwO7+/p1G4Gfe1DV/fuTx0nEZ3FYUAUtHsh1S6JHV?=
 =?us-ascii?Q?+MgUX6BRmz/0QWxKvSBZtpQ8zD4CflhJp2bPRFmw5bgpYc6xbRTgRspeM9zq?=
 =?us-ascii?Q?7Y/Fk8FWiV1UHpoEX3WhipE0Mm77xkCfzyO+xUHF/cAtOmowRZ1/eQuzlmO+?=
 =?us-ascii?Q?EdtFlM8znn3ncBliLiiGAj+CBYNmgrf2vM09x6FhNu8W/2w6k4eTz2/lLjPt?=
 =?us-ascii?Q?qUhtZG+Vc9+7dMTECuZCpU95bmxznU4XP9FbD1v6a050wCzflfcMrIDl2f/M?=
 =?us-ascii?Q?RWitoGHSgK/xxb32xJL59beEWaaejrgxCCzoO1Wk0LtgnQgTviymXw8nbrqz?=
 =?us-ascii?Q?ld2bD66pH2poqugTZnQWDgOQwUfrwdrPO0OgnuOjBxX9HzcuUlFwertJSBeW?=
 =?us-ascii?Q?H3julcLlmM8HHG2CU8/Rxj8we5j7fBVf2nVRerR2MlDSjYmQ4WsjcL0FFgSQ?=
 =?us-ascii?Q?KzJFcSdr5XZW5PaoWDXOKJFGRfAto8VJYtnM4MHjTRk9DWk4Oz8qxnf/K4uS?=
 =?us-ascii?Q?0dFZRew2EsAXL0JzSQJVzVU75supeqN77oE9YqHZVbQajRh5aFvwREwutnJp?=
 =?us-ascii?Q?UWV2Yro+7Sn2RGLqoKwrKuBa3KSbOGub8BoSAQSyYhrhFhkXYL/gIG16WGlJ?=
 =?us-ascii?Q?O3KS9NiM5xl9atfTyJimJF87h04Tgoz/sTKF4nXyq7f9ncrdVILpRR+V10ZY?=
 =?us-ascii?Q?mJ9+vsulTPYa3L9FMRyf6OqRFRI+LjfZefUi/WL0WARIgMbbk92l84ojjKMh?=
 =?us-ascii?Q?zXj9o7w1X6DVMSW3SX3Js53CCR+nzO+c5BOV4C1FF1O7ObaeuL8CLQxQ6jGQ?=
 =?us-ascii?Q?aTVEf9pbzznX2eEMeWfU/khC2843Mg0LvIlOOkdCCkdLDGnR4FWhpArnhQi9?=
 =?us-ascii?Q?t+T8ZfDF9VtpeESjGwSMrRINRC/K/f8KsXL1HnezchBoO+nHesW1YIcSltL3?=
 =?us-ascii?Q?fS5R4eK+tfs8rAW90kM6lBmXT1FI742DQh96C4Ot38WG0v5tOljfkEHfakWh?=
 =?us-ascii?Q?GSge1wp0Yb09r1tjG9VqxNCJsSTg15vv2AbgIwLPlx1Hj6eyc/883CWC5iRi?=
 =?us-ascii?Q?dhkK/P2Lil1xCU8GW66B/1QH0/sO8glqL6MYKDJz?=
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
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0956c0-bed2-4982-9a5d-08dc7007aa74
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 09:09:00.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExFkBS3J1YhqyeltqVm2DIvxYUTEp5PQO8e9EDniDoFcpZTnQ5B+zRXTV40MYSetlT9bR2VFmt/0/nGWKsnVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4015
X-Proofpoint-GUID: Ek9bMvwSpwIT2tfO33uC2ar32DTNXjmi
X-Proofpoint-ORIG-GUID: Ek9bMvwSpwIT2tfO33uC2ar32DTNXjmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_04,2024-05-08_01,2023-05-22_02

> From: Justin Lai <justinlai0215@realtek.com>
> Sent: Thursday, May 9, 2024 2:29 PM
> > > +
> > > +     /* rx and tx descriptors needs 256 bytes alignment.
> > > +      * dma_alloc_coherent provides more.
> > > +      */
> > > +     for (i =3D 0; i < tp->func_tx_queue_num; i++) {
> > > +             tp->tx_ring[i].desc =3D
> > > +                             dma_alloc_coherent(&pdev->dev,
> > > +
> > RTASE_TX_RING_DESC_SIZE,
> > > +
> > &tp->tx_ring[i].phy_addr,
> > > +                                                GFP_KERNEL);
> > > +             if (!tp->tx_ring[i].desc)
> > You have handled errors gracefully very where else. why not here ?
>=20
> I would like to ask you, are you referring to other places where there ar=
e error
> description messages, but not here?
other functions, you are freeing allocated resources in case of failure, bu=
t here, you are returning error directly.


> > Did you mark the skb for recycle ? Hmm ... did i miss to find the code =
?
> >
> We have done this part when using the skb and before finally releasing th=
e skb
> resource. Do you think it would be better to do this part of the process =
when
> allocating the skb?
i think, you added skb_for_recycle() in the following patch. Sorry I missed=
 it . ignore my comment.=20

>=20
> > > +
> > > +err_free_all_allocated_irq:
> > You are allocating from i =3D 1, but freeing from j =3D 0;
>=20
> Hi Ratheesh,
> I have done request_irq() once before the for loop, so there should be no
> problem starting free from j=3D0 here.
Thanks for pointing out.=20


