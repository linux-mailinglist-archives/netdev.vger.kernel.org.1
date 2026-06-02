Return-Path: <netdev+bounces-294167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ff7fCEXCHmoJUwAAu9opvQ
	(envelope-from <netdev+bounces-294167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C762DA90
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:45:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=tz9umdwO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294167-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8842E301E9A3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2A3DBD41;
	Tue,  2 Jun 2026 11:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC23DB647;
	Tue,  2 Jun 2026 11:35:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400133; cv=fail; b=RcSWTpMhKzGpXxQtnXqybgbh1onfqJ3VP4Xps0Cy2GJ7OJRnMQjg51K54jD/0RjY88J/UymE6cll2U+cBufoysVOLGb4puhNFr3JSPuPX6JN+V0bP7HhlP6uYjqKNRtz2M9bj6rcuNmt8eghPq8cmzUtmWED3FtcC0SgSIfofDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400133; c=relaxed/simple;
	bh=EEIQebZTy+DHXImx3GCEt1lGyrEqHBA9yQczpbe5MSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TM4nfzUG+Tyfrs0T9Xmf8mJ6DkvCINwaF3T2mbJlyVvegOJGUprKPntO7rGXlOyMnWpZapUuvGpSZtFCjXMH1P/7bDUR+fjrhlMUZuitbEuX2xnQzSEL33hopCOPrHTCWAZVZAYbkaSNtSyrNgrA0cnI6gBLwfdsZ/zRSRmkfPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tz9umdwO; arc=fail smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652ACW9U930009;
	Tue, 2 Jun 2026 04:35:11 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023075.outbound.protection.outlook.com [40.93.201.75])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxgbhpg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 04:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhCHo2ue5JLPjxtht1yaTWbinyKXTtKLu/n6wrLhKo02k+YKXlyPjvh6OOZa1BRj2fe4nlIpgsSzRIgj0BNyH34Z9/u2bTLk8RoBXucNyNwQKHj3rXD6W0uV/CHobURhf/1dasVCFGOH8svRHfumfBifjYnd3+yZiAW3OcUsMTle3d9a2IloqCkRUNDWunaTU19ys9HIXfvE9sh8ClB1Ni+EEPYOJX6WO8hdR+ASBObHk7m4T8o/n/S17vf041GUYQwsi+7WZeoobTdi/inUnqN36LTolBkUkNRwevKEXobOVGA1bZMTawCuJ1jpq3yIsarpZQFbwlxO/NrFbRo21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0mEXsuvP0OISzDdAVvMk40evrAsLLDAn1JHUL5yc3s=;
 b=dxnwsuMma7/pv0hP+2HhVGtyNw5EvQ4RCNhtKISaCCA1z2Y1xyUZEh4DZ9oYMtDPXu34CISNjHsk4L+VQaNef73E4LhjJYS5W5JmejqRFxp0szLtO86UdRJm5pE35KUoTsulbuV27vjsGLHqq9vMO3QdIHp0S+6MwRdTRD2/1Tu5+GWR8CsQpYi1HfJJKQml29SUTr9Qy5DdVayDO8THq3uZd7iwp+wkG3DcV/HA8UTp2oNkC8Y7xs2FmnTfKEz635svo7AAnF/ef/2MUIej9Dhu+so1YH4vUg4GWFoktXszo622t6DTWFteHpv7KvN3UZ/yRivNvBYEFgHCzGeZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0mEXsuvP0OISzDdAVvMk40evrAsLLDAn1JHUL5yc3s=;
 b=tz9umdwOR3tXp1uixWHuuefaEla3YjENsGk/7Q4Vlx9SmyZ3ahFylSnGG25oonaSE6bAabpv6XmkCmoJMhatMyFWK9b7mZFKfjapCrGMhYXOQ8xLH2zBNhfjYf9jOc3VIVWAs4tQaeJbCo0NuTI+1pVCQA/lLBF/3PF9ovTKUz4=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by LV0PR18MB927504.namprd18.prod.outlook.com (2603:10b6:408:346::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 2 Jun
 2026 11:35:07 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 11:35:06 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 6/12] net: atlantic: fix AQC113
 HW init: ART sections, L2 filter slot, MAC address
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 6/12] net: atlantic: fix
 AQC113 HW init: ART sections, L2 filter slot, MAC address
Thread-Index: AQHc6GKitFA7kdFyrEG/QIQ6THOtCbYa05aAgBBcWkA=
Date: Tue, 2 Jun 2026 11:35:06 +0000
Message-ID:
 <SA1PR18MB4600185442306C5682C8D4A1BA122@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260520141046.2151-7-sukhdeeps@marvell.com>
 <20260523011919.1819994-1-kuba@kernel.org>
In-Reply-To: <20260523011919.1819994-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|LV0PR18MB927504:EE_
x-ms-office365-filtering-correlation-id: 39dbad07-cece-41b3-f122-08dec09afecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|3023799007|18002099003|4143699003|11063799006|38070700021|22082099003|56012099006|5023799004|6133799003;
x-microsoft-antispam-message-info:
 lEtIgiMdVqjBlK5WhcLjLtyRa+ma0OjdtjyMQggY8XI2TYUiIJdhEFoncZQTiHfvl29tBxLE4wMtSuQpTCipvGsLYTTEUSy2IFomtJOADvt+I21oVeS0r+QJc8jSAovm8a2pFzzTkcptmeN0YAG+vzaJbFg3qWiUpPKsrZHyiBe3Rby6MgduAseTivdFBBs/9ZSeApOIuCELW0jie+clNUGZjyXeZ3ozqA0iNfPJXCZ5HBXvmyhu8GsN1uk3NZvOhnTWFqmC7Yu89VuDvnhwxBbl6NTIOltaRCEk5pzarlAu8tWxt7ASwAMiO3Bh/EFDzjjZTlC1bqA2frUys3Ny83dWDfWefifbXlbGe9mXDHtVLlvu50+jrSI+lGatuzc+kdAx2XTg0Rmrs9joYhJW+9642xUCnV978HnyxpL7dKL6B6t28CmPdGKg1op3FHH1BOo1DJRjdn/nwCsT4gdlD/QbUvrHn9AYJSjkMPV6J0LVeu2/VigjfLFgBGdKjL60DIev4KTzzfTsN4mKHxD7bC2O8siLx680k8GPYDC0z1ctcwp1z+vgXI4A64iWyzqoN287gJtD3OFGwfVma1+X0emUvMAK/6kMpx52iDVygzT1Y46xv3298gr31Ovr5M3A+UvaK1Yf7SLkBnvIxPAY7LB15vZjXE/FFn7o76KLnwq/7DqB0VUxziS0ozr7kCpTtTC0uE9k76XYe9i5ppzyChu6m364eYwfkrv1q36Myh5qE/aRalA4gtFYIMWskZkq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(18002099003)(4143699003)(11063799006)(38070700021)(22082099003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?35LZX86h8SyRq+qmCmfNYrk36Sl54wXIDTEImD3RTZy8exjNHcHgboEFcRlw?=
 =?us-ascii?Q?PBQ0ERQCAa5JGRRcM7nWhm21GYGzJoAod92Zf9Re2XxggBPD2yLzggz/TaHB?=
 =?us-ascii?Q?IC0LipclcXXfhQEMffPra5ajHjDohNZ47UZQ4kGL/yn5Ztijxz13iQJ0w8gr?=
 =?us-ascii?Q?VK6YjlSSUHod/plZwq90XPAFy5Fga+Ib2RJ9uQzn8rV+1Cb7O0V6QIInuu8Q?=
 =?us-ascii?Q?X68Wiccaic0Y/Lw3vX43wU6MsrAoO84Nwcror4NrxSLB+MnwahqNPRuLYaL5?=
 =?us-ascii?Q?LOreDkjsDIBNUm9ZoRPYNQ93iPWSWyToFt3EwZp/f0wFdTbNtukqT1SXBHSQ?=
 =?us-ascii?Q?E1xH7WQSUd/BwpP046uJnvROoBlIphTzjPo9XAYRIjxZDj8CidReCyZPX0LY?=
 =?us-ascii?Q?+nNBbBXDUq3cPStJnAzVkeiIvaGskYlEEt3+/t1v4Eik68a/BZoYF7bh54ga?=
 =?us-ascii?Q?iC9z2+G9jVfwevJ/b64AJUZzjhLPhHC+WpKxDEAxpwy6mMOwU2FKKKziyW2P?=
 =?us-ascii?Q?q6iFOK+8vuvkX7OvzvI8Q6G4iCdMXAAIL8yo7xn+rsKcJwgq5z0qFRQyodfO?=
 =?us-ascii?Q?zZUWiIkRSloda2GpMVO/xx3xIIhklUNvjdUp/kWpPfCQ/uhb+nFac1a/DvQx?=
 =?us-ascii?Q?OnVKkeguLHMJ9OHD8Ni6d+pe9Y5q/iFOS3PqU9hQmWPOUW6CJ6HgQWPlhWhc?=
 =?us-ascii?Q?ocvgCLzmoRaKO445gWGepdSUgTFc8lDn1y6rD9nnkxqkrQ0o5LQkzf2sZGY2?=
 =?us-ascii?Q?OiNb9hvbCTDnA+kOyeFSKr8FtwwopkNiVL8nk5PRWMWwzhMPoZ08vyyFCeH7?=
 =?us-ascii?Q?yKJUclUhp7GsZfrPUd4vf2BSWDTXlnym/+OIZDDJi1SSTu055L5DpkQT+ErD?=
 =?us-ascii?Q?OpffA+SCCLwVAtP+mtWPmOcQIYFEIU92lvSjsPE3NvCZppEs2ISJN6jP/ENY?=
 =?us-ascii?Q?O3H7Za0XkaGzshOyBxpIRzJM7Sv6uRJCsNTmoKyu0UWuC44i3898qWnj19OM?=
 =?us-ascii?Q?qkwK8GpOa/6hTdCJTkXjfI8PX5/lthsjDfdb5seFit75BNgUT6hktLqBlr6J?=
 =?us-ascii?Q?nge/Cx+xahdgrkKWqEcwH6wEPR8o5o+/cqCpCFH3Vl0GbCa/Hk6Pe9VoO4J6?=
 =?us-ascii?Q?DRR4nmM/b0RWal4XsD0w1i2jKKTsp9SDzYq4b7OLeVjF5jp0Hhy58nAfGX+b?=
 =?us-ascii?Q?SaSgqG70kfO6W9CMArnRj2VJvdUXwU1jmqd/MXSX4Bp8e/hhPmOozRo3rHkD?=
 =?us-ascii?Q?pnkJSQU1WUjYj9CsMq/O5dTCdygcunmmBfOaltMkbzFLQRCpE8wXOsQEBbSn?=
 =?us-ascii?Q?5uBsmALXh03FS5+IOm/gFTN65DxfRJHpzxvVle5Dbi2tJmsjxVjzPnnSHhGp?=
 =?us-ascii?Q?ju76ymrAxOd+eNrrjrJu/FZfN7DN0PEWSGCfM8aouAgwOTamK9t8fX6/RtVt?=
 =?us-ascii?Q?u1zQxLbGTXccRM4mGOeJPHyhQ0jo7p/xNP+2EqR+0MweX0EU64XsocGROtfu?=
 =?us-ascii?Q?ZjM4lUpiHokVH/8pTN8ydJnSuihkYMuFm4HwU9Rzm/nIpevHyXB6adTtc432?=
 =?us-ascii?Q?uqlciPiL+kxGQ//JK0NS4NPrs/+eYOqLvxEFLb+rmmO1QUqcV768bjSsHyv7?=
 =?us-ascii?Q?WMwAyMiM/WA7RYxqi0+qODyj3Dd6/WndgOSti3k4gNijDupj1js8JEQhpDgC?=
 =?us-ascii?Q?kNm0LU7Xn+mm+NxW0vjhP/KWr78qvgecdvbknu6+IkdMW2qk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U4VuR8jZT+1TSfPSObDUSfUhW9V8rr2bI9SFZEQo9rdjBWjNcHzO5SPblgEZpHE+e7x/Z7f7SlmgLGuWWHCm2tXortVnpbE4/Tc5RAsXvI5TV7LeuOEbL3fqv2A7yumZ61nguPsH68tBIfDSo8OdbZ0R/qJ3SRNn2BtMCf55EfvZ2LSuoM3yYZhZ7MpomR9giQiPq10ZwAHtP0Fpmzdxx4t4URXPflYBIYhv4/Y18kVubOZ5gZ2+wP9fXoUIfVInzAweTy8pyoemPo6ZcyY+73/xNn6S03MbPG5mxn7WQrZ9eTkba6qHbj9lXTGhwbs7x/dl/WgdrGodw4ThDMeWZA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dbad07-cece-41b3-f122-08dec09afecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:35:06.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJpxBs8xLq0GHT+p+IgXEjR0G9q9fZB4O3yUD1EQyN/ArMCDfH+U8Hc+4fmEQGIoKUwLorbwrSoLYEkOQIBfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR18MB927504
X-Authority-Analysis: v=2.4 cv=V75NF+ni c=1 sm=1 tr=0 ts=6a1ebfee cx=c_pps
 a=bqsrm7XTco20ezpTcXdHqQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=dpqvAJybPjzITboqyKkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4gxEQDn73SIEGej9QkH7ZLshQBtq86s2
X-Proofpoint-GUID: 4gxEQDn73SIEGej9QkH7ZLshQBtq86s2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMCBTYWx0ZWRfX3ERsr/Au8SUx
 eVquZ8Tt6CCcyHiWWhaKjjImLRVxX7DR+hBZCaqwijf4dx0u5aOWi5BWOTrC6siip+XxOxZX8gg
 LmBzcjaDqSoH4nCZHkZPdAnFfx9LjF6xf5QMbnLhujfRRiSTa4fBdWIIqB7bF4dPTNAqZD5c7IG
 Vbhhd5Rh+uGKZqJOyfJN3gVH+Q3mdg/qVUIx0AtahBaCOaISbICxd/eCT+e4NI89OS7TkvszpDs
 7q0Urtr8pgh6pLE1gfl+I44zdtHCZ5bOJ6CPc0Xj6f511cTPgHFypVOS741SUbq0BGKlE/WyORu
 ESdk4FAK9Zjgu5Fbp5bKX+PvJ3Hc/OBKV6sKsRI3AhH+9E0SvZNux1eYyzNGBQweyq9MzThgJnm
 Ar+Hd1Pr8VLmHjS8DufRrr04lrmXZrAhe2Qi3+Oaxe2oVzhaq+KIpOCCVvVW2LLX1nFRCeDtmEb
 C9Xhl8Ecq1SH9NYi2KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 903C762DA90

On 22nd May, 2026 Jakub Kicinski wrote:

>net: atlantic: fix AQC113 HW init: ART sections, L2 filter slot, MAC addre=
ss
>
> This patch reworks hw_atl2 init to use firmware-reported filter layout
> fields (art_base_index, art_count, l2_filters_base_index) instead of
> hardcoded constants, adds a hw_atl2-specific MAC address setter that
> programs the FW-assigned L2 filter slot, and wires .hw_get_regs into
> hw_atl2_ops.
>
> A few questions inline.
>=20
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/d=
rivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..db0035fb04c7 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -95,12 +96,21 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
>  {
>  	struct hw_atl2_priv *priv =3D self->priv;
>  	int err;
> +	int i;
> =20
>  	err =3D hw_atl2_utils_soft_reset(self);
>  	if (err)
>  		return err;
> =20
> -	memset(priv, 0, sizeof(*priv));
> +	memset(&priv->last_stats, 0, sizeof(priv->last_stats));
> +	memset(priv->l3_v4_filters, 0, sizeof(priv->l3_v4_filters));
> +	memset(priv->l3_v6_filters, 0, sizeof(priv->l3_v6_filters));
> +	memset(priv->l4_filters, 0, sizeof(priv->l4_filters));
> +	memset(priv->etype_policy, 0, sizeof(priv->etype_policy));
> +	for (i =3D 0; i < HW_ATL2_RPF_L3L4_FILTERS; i++) {
> +		priv->l3l4_filters[i].l3_index =3D -1;
> +		priv->l3l4_filters[i].l4_index =3D -1;
> +	}
>
> [Low]
> The commit message says the change replaces the unconditional priv memset
> with selective field clears "to preserve firmware-reported layout
> (art_base_index, l2_filters_base_index, etc.) across resets".
>
> Is that description accurate?
>
> hw_atl2_hw_reset() runs hw_atl2_utils_soft_reset() right above this hunk,
> which calls aq_fw_ops->init() =3D aq_a2_fw_init(), which ends up calling
> hw_atl2_utils_get_filter_caps() and unconditionally repopulates
> art_base_index, art_count, l2_filters_base_index, l2_filter_count, the
> etype_filter_*, vlan_filter_*, l3_v4_filter_*, l3_v6_filter_* and
> l4_filter_* fields from the FW shared buffer.
>
> The full memset was therefore harmless for those fields. The durable
> behavioral change here looks like the new -1 sentinel for
> l3l4_filters[i].l3_index/l4_index (since 0 is a valid filter index).
>
> Could the changelog be reworded to say what the fix actually is?

Thank you for the careful analysis. The commit message will be
corrected in v4 to accurately describe the actual behavioral change:
the selective memset replaces the unconditional memset(priv, 0)
specifically to allow the -1 sentinel initialization for
l3l4_filters[i].l3_index/l4_index, since 0 is a valid filter index and
cannot serve as a "not assigned" marker.

> @@ -380,6 +390,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_=
hw_s *self)
>  {
>  	u8 *prio_tc_map =3D self->aq_nic_cfg->prio_tc_map;
>  	struct hw_atl2_priv *priv =3D self->priv;
> +	u32 art_first_sec, art_last_sec;
> +	u32 art_sections;
> +	u32 art_mask;
>  	u16 action;
>  	u8 index;
>  	int i;
> @@ -394,9 +407,16 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq=
_hw_s *self)
>  	 * REC entry is used for further processing. If multiple entries match,
>  	 * the lowest REC entry, Action field will be selected.
>  	 */
> -	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
> +	art_last_sec =3D min_t(u32,
> +			     priv->art_base_index / 8 + priv->art_count / 8,
> +			     16U);
> +	art_first_sec =3D min_t(u32, priv->art_base_index / 8, 16U);
> +	art_mask =3D (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
> +	art_sections =3D hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
> +	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
>
> [Medium]
> Can art_mask collapse to zero here?
>
> If FW reports rslv_tbl_base_index >=3D 16 (so priv->art_base_index =3D
> 8 * rslv_tbl_base_index >=3D 128), then both clamped values become 16:
>
>    art_last_sec  =3D min_t(u32, 16+something, 16U) =3D 16
>    art_first_sec =3D min_t(u32, 16, 16U)           =3D 16
>    art_mask      =3D (BIT(16) - 1) - (BIT(16) - 1) =3D 0
>
> Since this code runs after a soft reset, the read-back of
> HW_ATL2_RPF_REC_TAB_EN via hw_atl2_rpf_act_rslvr_section_en_get() is
> typically 0, so art_sections =3D 0 | 0 =3D 0 and the entire Action Resolv=
er
> Table ends up disabled.
>
> hw_atl2_utils_get_filter_caps() does not validate rslv_tbl_base_index
> (only art_count =3D=3D 0 is clamped to 128), so nothing else catches this=
.
>
> Should there be a fallback path (warn and write 0xFFFF, or refuse to
> proceed) when the computed mask is 0? The previous unconditional 0xFFFF
> write was immune to this case.

You are correct that art_mask can collapse to zero when
rslv_tbl_base_index >=3D 16. This will be handled in v4 by
the guard immediately after:
=20
  art_mask =3D (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
  if (!art_mask) {
      /* ART base index is out of range, enabling all sections */
      art_mask =3D 0xFFFF;
  }
When the FW-reported base is out of range, we fall back to
enabling all 16 sections - matching the previous unconditional
0xFFFF write - so the ART is never left disabled. The guard was
added precisely to handle this degenerate case.

> +	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
>  	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
> -				     HW_ATL2_MAC_UC);
> +				     priv->l2_filters_base_index);
>  	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);
>
> [High]
> Is priv->l2_filters_base_index validated anywhere before being used as a
> filter slot index?
>
> filter_caps_s::l2_filters_base_index is a 6-bit field (encodable values
> 0..63), and hw_atl2_utils_get_filter_caps() copies it verbatim into
> priv->l2_filters_base_index without clamping. The same function does
> clamp the L3/L4 base/count fields against HW_ATL2_RPF_L3L4_FILTERS, so
> the omission here looks unintentional.
>=20
> Two failure modes follow from FW-supplied values:
>=20
>  - If FW reports a value in [HW_ATL2_MAC_MIN, HW_ATL2_MAC_MAX-1]
>    (i.e. [1, 37]), the UC slot collides with the multicast slot range
>    used by hw_atl2_hw_multicast_list_set() and the host MAC entry and a
>    multicast entry overwrite each other.
>
>  - If FW reports a value >=3D HW_ATL2_MAC_MAX (38), the loop in
>    hw_atl2_hw_init_rx_path() never matches, so no UC slot is enabled
>    and the device cannot accept its own MAC.
>
> The previous code used the literal HW_ATL2_MAC_UC (0), which was always
> in range. Should hw_atl2_utils_get_filter_caps() (or this site) bound
> priv->l2_filters_base_index against HW_ATL2_MAC_MAX before it is used?

Good catch on the analysis. This will be addressed in the v4 :
hw_atl2_utils_get_filter_caps() now clamps the value at the point of assign=
ment:
=20
  priv->l2_filters_base_index =3D filter_caps.l2_filters_base_index;
  if (priv->l2_filters_base_index >=3D HW_ATL2_MAC_MAX)
      priv->l2_filters_base_index =3D HW_ATL2_MAC_UC;
=20
This is the right place to fix it - once at the source - rather than
at each of the three consumer sites. The fallback to HW_ATL2_MAC_UC (0)
preserves the previous safe behavior when FW reports an out-of-range value.

> @@ -484,6 +504,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s=
 *self, u8 location,
>  static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  {
>  	struct aq_nic_cfg_s *cfg =3D self->aq_nic_cfg;
> +	struct hw_atl2_priv *priv =3D self->priv;
>  	int i;
> =20
> @@ -499,7 +520,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *se=
lf)
> =20
>  	/* Multicast filters */
>  	for (i =3D HW_ATL2_MAC_MAX; i--;) {
> -		hw_atl_rpfl2_uc_flr_en_set(self, (i =3D=3D 0U) ? 1U : 0U, i);
> +		hw_atl_rpfl2_uc_flr_en_set(self,
> +					   (i =3D=3D priv->l2_filters_base_index) ?
> +					   1U : 0U, i);
>  		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
>  	}
>
> [High]
> This is the second consumer of the unvalidated priv->l2_filters_base_inde=
x
> referenced above. If FW reports a value outside [0, HW_ATL2_MAC_MAX), the
> (i =3D=3D priv->l2_filters_base_index) condition never holds for any i in=
 the
> loop and no UC slot is enabled at all.

This is the same root cause as the previous comment - both consumer
sites are protected by the clamp added in hw_atl2_utils_get_filter_caps():

> @@ -530,6 +553,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *s=
elf)
>  	return aq_hw_err_from_flags(self);
>  }
> =20
> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_a=
ddr)
> +{
> +	struct hw_atl2_priv *priv =3D self->priv;
> +	u32 location =3D priv->l2_filters_base_index;
> +	unsigned int h;
> +	unsigned int l;
> +	int err;
> +
> +	if (!mac_addr) {
> +		err =3D -EINVAL;
> +		goto err_exit;
> +	}
> +	h =3D (mac_addr[0] << 8) | (mac_addr[1]);
> +	l =3D (mac_addr[2] << 24) | (mac_addr[3] << 16) |
> +		(mac_addr[4] << 8) | mac_addr[5];
> +
> +	hw_atl_rpfl2_uc_flr_en_set(self, 0U, location);
> +	hw_atl_rpfl2unicast_dest_addresslsw_set(self, l, location);
> +	hw_atl_rpfl2unicast_dest_addressmsw_set(self, h, location);
> +	hw_atl_rpfl2unicast_flr_act_set(self, 1U, location);
> +	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC, location);
> +	hw_atl_rpfl2_uc_flr_en_set(self, 1U, location);
>
> [High]
> Same concern here: location =3D priv->l2_filters_base_index is used direc=
tly
> in HW_ATL_RPFL2UC_DAFLSW_ADR(filter) / HW_ATL_RPFL2UC_DAFMSW_ADR(filter),
> which compute base + filter * stride. With a FW-supplied value beyond the
> L2 UC filter array, these writes will land at MMIO offsets outside the
> intended register range.
>
> Should location be bounds-checked against HW_ATL2_MAC_MAX (or whatever th=
e
> hardware's actual L2 UC filter count is) before being used as an MMIO
> index?

This is the third consumer of priv->l2_filters_base_index - all three are
protected by the single clamp in hw_atl2_utils_get_filter_caps():

> @@ -825,7 +877,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self,=
 bool enable)
>  const struct aq_hw_ops hw_atl2_ops =3D {
>  	.hw_soft_reset        =3D hw_atl2_utils_soft_reset,
>  	.hw_prepare           =3D hw_atl2_utils_initfw,
> -	.hw_set_mac_address   =3D hw_atl_b0_hw_mac_addr_set,
> +	.hw_set_mac_address   =3D hw_atl2_hw_mac_addr_set,
>  	.hw_init              =3D hw_atl2_hw_init,
>  	.hw_reset             =3D hw_atl2_hw_reset,
>
> [Low]
> Could this patch be split, and could each piece carry a Fixes: tag?
>
> There appear to be five logically independent fixes folded together:
>
>  - selective memset plus the l3l4_filters l3_index/l4_index =3D -1 sentin=
el
>  - ART section enable computation from FW-reported base/count
>  - rpf_l3_v6_v4_select enable
>  - replacing the A1 hw_atl_b0_hw_mac_addr_set with a hw_atl2-specific
>    setter that targets the FW-assigned slot
>  - wiring .hw_get_regs into hw_atl2_ops
>
> The .hw_set_mac_address swap in particular is a runtime behavioral change
> for any FW reporting l2_filters_base_index !=3D 0 (the host MAC moves slo=
ts,
> and hw_atl2_hw_init_rx_path() now enables only that slot instead of
> slot 0), so it would seem to deserve its own commit and Fixes: tag for
> backporting and bisection purposes.

The five items are tightly interdependent: the -1 sentinel makes the
l3l4 slot tracking reliable, the ART mask computation uses art_base_index
and art_count from the same FW caps read, the rpf_l3_v6_v4_select enable
is part of the same RX filter init path, and hw_atl2_hw_mac_addr_set target=
s
l2_filters_base_index from that same caps read - all flowing from the singl=
e
hw_atl2_utils_get_filter_caps() extension. Splitting them into five commits
would require each to carry forward partially-applied state and would make
bisection harder, not easier.
=20
Regarding Fixes: tags: this patch introduces new hw_atl2-specific behavior
that was never upstream (the driver is new in this series), so there is no =
prior commit to tag.


