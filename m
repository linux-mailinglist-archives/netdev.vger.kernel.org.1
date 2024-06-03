Return-Path: <netdev+bounces-100106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D78D7E0C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB89283657
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109B7E574;
	Mon,  3 Jun 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vflsrp/5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BC537E7;
	Mon,  3 Jun 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405518; cv=fail; b=W3TNGe23q7CJNDPXAtMDs54gQwlCCDVb8VfcqmJo3DCDix//xxgXd3mbBBp5v8HnYUmC02qgCZurNS/AXZUKMIkd21Iph2ZR1vlUP48wLbOh71uOJs5xPSwbIA0LZNqijSYnPJx3mk6NEex7eXgNiQcGHcX6Ifjv84OxGdHn5Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405518; c=relaxed/simple;
	bh=GFFGhCOZlX3w9ePh+opfOVPaOvuP1xpfOO//UqVFNrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLqvaP8aRNf5MiNzpDTNR0ZlYIMMMBYF8/XbARMSvBPhbqqATIvCGC9BJoN9+g1CHIimc8fDhtho5A4/Y6LIGwUM+aY6zGiHeUz0UMuxFgTURSeNNUjCwAP8Ko/mOCuQYz4kHZkv7zUIsRIBD38bjdd/tq/6NTV6Np+sly+kEQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vflsrp/5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452MVgc6020216;
	Mon, 3 Jun 2024 02:04:51 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ygufmsyfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS/SCyP0pkRh1EGQzqj4/Mmp2R+/LLeHnuon2ZvLGjjfJJWQrnbpuh2Vzre/n3Ghxi2mZTXGv/lm2/kTPP7Gyn29wXYh1t5agVb8PiuC5346XXhYJ1efwqgE3r6f4WeBAs9Qc5yWsYTX4NsuM6sTe5+7MAO7c8Ig87nNQclPS4CJ54c52itc42B6Silxd9UYdEfK2Q9wmY6qEhtMxGVQ3d0PZxe6qo8gLa+6jjxVBFGFHkgnuyCL7R5d1VmSBrxd0OomG+9PkrHzz36M96x2V9kApzNeMdY1c/5xjSZwN6nczbhlbsWHd90Vyn5XvJkBKLFD02XEL6iYjFWJBx/RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEVg6pcg/c24uvC57tgQ+SAddBLcQO1S4VabD81Dxys=;
 b=gRaMcIWHJrKGahVonu2z0FLZLAq10kpVCOMZOnJ+M0vEWQx6axT/5cBEumgie5IXGJjXv46fC5ppKgG38imHA4oIqXFkz9+1FXspp/Oa1j8Zx8ZhDqa2yoly63ZbqXR/yT8PCFmOHJ81/pG+kX35kZAVAkF3hLkjhaqOojnbUFdMHopjLpy4zal2TO++rTh9xwqZMcduQSn/bTH87RLYQoo7MmIpQ5/XcmaATArLh4/i8pUTCMkBT1Vve2RNQI52Vk3/uNK+uHaiXEkF/+xEWnhN9L3WUqw0Xk7ijbOkDbQz1YnLD/Tu8EqlaIrGpzO4fqNB8zsOfS95Hi0FEIJRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEVg6pcg/c24uvC57tgQ+SAddBLcQO1S4VabD81Dxys=;
 b=Vflsrp/5fYx0XtEnpdjlLgqO9P54zy+CYP91deMs2TB9sZmsZGAmUC2XrQfM53Q0SRrnTuHEnzuoAUkEfTjvIuE+xA7uxAPbaUfzUrJPyjN0x5SKk1Xirv5xHDViR8xaw4J8QmEEr83/R9VaIeRm5GpOJgZeOl0Iep2xoyZhN7o=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by DM4PR18MB4285.namprd18.prod.outlook.com (2603:10b6:5:394::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 09:04:48 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:04:48 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nbd@nbd.name"
	<nbd@nbd.name>,
        "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "upstream@airoha.com" <upstream@airoha.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "benjamin.larsson@genexis.eu"
	<benjamin.larsson@genexis.eu>
Subject: RE: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Thread-Topic: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Thread-Index: AQHatZUWk+XzQtNsz0qmN1O4FDwReg==
Date: Mon, 3 Jun 2024 09:04:48 +0000
Message-ID: 
 <BY3PR18MB473784C748E054DFED063C19C6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
 <BY3PR18MB4737F74D6674C04CAFDCD9C9C6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
 <Zl12e1LjSqf-M7cb@lore-desk>
In-Reply-To: <Zl12e1LjSqf-M7cb@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|DM4PR18MB4285:EE_
x-ms-office365-filtering-correlation-id: 757098ce-0d5e-4999-c9fe-08dc83ac38a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?vvs2luV5vNhoYK4DDgEWY6uW5mVccTUAMjisWbzpE/WqZ1+vR1L8OLZjpeEB?=
 =?us-ascii?Q?1xVkAaryF35LVNcblDINNEg5IOzLrQyoRKNe5Rore6bWRArEThjO2CH3QAPq?=
 =?us-ascii?Q?LCUAxhngcqExOV3frZLi1NRrIALCdKRQ8BsnbXtgzbAeIqvIMM3eE3MKUk6X?=
 =?us-ascii?Q?n2WRn5JtlZNsvOEDnLmbOpEgRSuns+F3FrdUB8N87KvctkIWwkGgAkDFLOhc?=
 =?us-ascii?Q?JaXFWv2xK82H9mh2OYaKvA/NqYEpjp/PG20s91pziwIEpYpb9htCsHXpKiwd?=
 =?us-ascii?Q?UZcRLOLE3tDNJ9V6sbwtngpGLJFlcrr/g3mAZt9JOUdu791izWNeBpAfZOGW?=
 =?us-ascii?Q?f0Aaq6CPYzOJItCCFmiT+CNCNwnwPH8fflzI8Hm1ZxNg+vbCf0tjYqqdYEv6?=
 =?us-ascii?Q?lVsOMoejqlocjaTBLB4g+He+PCeciFB9z0kY8seHG1tA+1PU9qZfEm2Iv8nS?=
 =?us-ascii?Q?2VQdDxsEl+wvSdg2ZV29oIbmdubre1P0ZeydfUB9+HuzLwpJXpSJTtgQHO6T?=
 =?us-ascii?Q?MY7BAT97jcFs86ZQgosD4EuLj0iSFezPcaRo1vRUl8dOuA1n/OqMDo19im9r?=
 =?us-ascii?Q?HtlgukmKrdnIHcST52EO/j/6w+qGcOKf4+RknbVozmIzXznAEx7wvQ3m0qH8?=
 =?us-ascii?Q?7zDxV73vrKRln1PXks4Ykl2RJwt77GUT1vj0nSdOFX349lPP3ZD+ubTgb8I6?=
 =?us-ascii?Q?fnMm/Bum2cacHef0yhzIOCfI6fI8DI9tqzzYcUazu8dO58KyniveGifuPAIi?=
 =?us-ascii?Q?Dz/mmMZ0Q89zpTeLQcBjHFet+ngv3Syk3t20x7wEwrrRrJPnl2J+Y2DUXgKV?=
 =?us-ascii?Q?rKQy6kHADvJV967mhpSAe/JLgdG4aR8aNwnsnUECb/CtX87kwRgUlziJ8uFS?=
 =?us-ascii?Q?H6y26C73luO6ZUMr5/CiTTm/sTZC7hT92VGSHAQOrIdrOVVysJwR/hRXvBRS?=
 =?us-ascii?Q?OWxnt+OYO8cWy0vk33mz9onJ94zGRLcWI0HXo/O4oXQqmeleJJybtB27dtTP?=
 =?us-ascii?Q?cw0pRm7i59JHE08fxsXT/GZH/PQ5Mvxh5+hbURK5BavMn4p/7NCmNk9xsQ2a?=
 =?us-ascii?Q?fEXUbLndnTqQ+/+i+tAeASAH2sYuO3pYgC7EgNi8KpJm9OZ8peNGYBqQ8apU?=
 =?us-ascii?Q?kEKvghJ7p44c1528RIy/QT3kDP7Uqi5O+gSoaGlGzrW+DYpfjdt3q2cZKi88?=
 =?us-ascii?Q?lLVwknfgrPaGP9Oa7hGzBoaNjq2X/6aWWMwdwJ915SyCqe9Ke1jcvC+4M7IL?=
 =?us-ascii?Q?2OCspNnE8RCOaTofxl3e1MMtcJDHy4jpgpwc/B/VCCxktHR0GCtEvlenFhxY?=
 =?us-ascii?Q?32w+0FaD+IwwhGPylfkyzpzJLbCwfWR/DlkUXPoB8++X5Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9yrlIwm2E25K0qaDf38XeDEv41jbodJkamAdK2qgtwF9t6MpuWvCyuEkUmeP?=
 =?us-ascii?Q?GQB5Q+mUOUp4MPw3M4rGr29FW1TwcOtyiucgK4V9ayqXZBPpMD0/OaXo4rEs?=
 =?us-ascii?Q?9+8UXNY2dTCISYVu8y8k6BjZiGBjtCb7gFPbs84e9iXqCbKZzGHrrQs0gj5c?=
 =?us-ascii?Q?9gzMQZvNyAgdmOW8SfFIdWI37pVDRa1oPSQ5gQYRLldoCur8mpxi5YxhD4OE?=
 =?us-ascii?Q?EB6H7s8TI4gS8R6zEq8g5xT+9gpWQRxzWkmt2yjGxVgSmaUX6TAoXok3StpH?=
 =?us-ascii?Q?vGslDMFhXDng4KJ+6BEiLDbHVt4PeAkRtmtvcs9XHCOvWkRAR6s28NJchjNd?=
 =?us-ascii?Q?jVsVQOQcgDznAVrEI4ZVv0qej8sYQAtJvnIInKKDBJofpZGPfx8HENEPyFu7?=
 =?us-ascii?Q?sbWpID1C6n1PO+7XH4Knra3481cFsu8l7xMo1LLgZErhcYfWTt4M1zRLtPoy?=
 =?us-ascii?Q?NujM41r6FqPPMCIYtXZKqZVC0h6m+Lt6iv4BeQi6yx+rN5RvegpsUwbAO1b3?=
 =?us-ascii?Q?42A5aWqS5G5d4ldCef4TW8JUWGRfe1Czfa1sgkw4iCe7zC1mnDsegOieGiRh?=
 =?us-ascii?Q?UFDUFduMb3noIouAul97pW0pA1gpN2yLut+43elz5I6WehbRGIEyZ2kIpItW?=
 =?us-ascii?Q?A/CbFai69p2I1mRguw5NbhR8l2MXMTSx9TnEiYUX+Ibq23FHwUBvAk7O7nan?=
 =?us-ascii?Q?ndQc3a3/WVPlWnFVsfn46eg7sOf+lhAMtc2h4TLZBu7el8iWWvGQhIWkbe/8?=
 =?us-ascii?Q?UNSKpKlw611ZjQC2Ikmd3f+nRaUQjhv6Dv5davp4xjtG3fZ+6Uy7lEP/B3ow?=
 =?us-ascii?Q?oQdO5Dd7EYEQ78YhJkpn91UeO06I76gFOUrISiWIU7Pmehl3tNpruYnVcGsH?=
 =?us-ascii?Q?lO8SlQdx7YNmVLA08PVGNGxPmzyCvfC/lYWA3SQn4b1WPLR3DAmgbeNzDTbe?=
 =?us-ascii?Q?xWZlB6ke83qbr5qA28g/+HhfaySMxrBFXhFFZSaFwDtXzbJzqy9GM2Az/Pan?=
 =?us-ascii?Q?SSR7FZXimTt5HQm3RimPSG+jFKNhBibW9EKOD6P0FLxBOKjeQa9AstkRxudn?=
 =?us-ascii?Q?n6PKlY7dX4JdGiP8x7ZCFTgYbva+ngU5EydFt4kwwYgYQZCQ81bw8+lGzG60?=
 =?us-ascii?Q?4+v75+1u5Q9hQ1zcY8LuBk7Kdrh4aqXxUPEZMCUlzS6q782gqhDHgRfIt5fv?=
 =?us-ascii?Q?ADAXCk+2gfXwIF5aXziDvts31qIDK1BVSUutf4cmupWZhMPLedL8j/mXhAHy?=
 =?us-ascii?Q?mGMIAGT8uJaAk4NCPlGzEhkhmpqXTgnWNstWVvbS+/nF9U+Mj3YOzH6HWSHP?=
 =?us-ascii?Q?QsXdlFWbfNZ5P7JckTRMtSACCBGmjS2KPTstMdkG7RSQV+NOIPYf1QIML61p?=
 =?us-ascii?Q?o5qN271pIxxtI7PutFkzLi9+sCrT5j1PSdd0wWgA3awy+aT/pF8jh5HGmuAE?=
 =?us-ascii?Q?P30feN8aBU1fMnIGfaHyDDIvuWDFNuWkVCgVI8ziOepmOFUDb4XeirhZ/7iC?=
 =?us-ascii?Q?AXXImE6CAy1ypxQKWKdt3gQFngaHUmFtGJkx3hDLviy58ASh5DeQI84Ogwjb?=
 =?us-ascii?Q?/EVl6DOLwXw8GtlHwarssx+vbX7Qdp4l+rvmPJ5s?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757098ce-0d5e-4999-c9fe-08dc83ac38a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:04:48.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/nVyJSybE061WMBBlNi9FDy/yjrqr9qG+Qld9TR+sex4Vnlm1nnzT74ca/YXWJFuiII5GNgPWKMMmaY1QQkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4285
X-Proofpoint-ORIG-GUID: hj9GhLiWjVkGkuDVzhZQgTSKAmIbK_7n
X-Proofpoint-GUID: hj9GhLiWjVkGkuDVzhZQgTSKAmIbK_7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_05,2024-05-30_01,2024-05-17_01



>-----Original Message-----
>From: Lorenzo Bianconi <lorenzo@kernel.org>
>Sent: Monday, June 3, 2024 1:24 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>Cc: netdev@vger.kernel.org; nbd@nbd.name; lorenzo.bianconi83@gmail.com;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; conor@kernel.org; linux-arm-kernel@lists.infradead.org;
>robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org=
;
>devicetree@vger.kernel.org; catalin.marinas@arm.com; will@kernel.org;
>upstream@airoha.com; angelogioacchino.delregno@collabora.com;
>benjamin.larsson@genexis.eu
>Subject: Re: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethern=
et
>support for EN7581 SoC
>
>> >+
>> >+	q =3D &eth->q_tx[qid];
>> >+	spin_lock_bh(&q->lock);
>>
>> Same here, is this lock needed ?
>> If yes, can you please elaborate why.
>
>ndo_start_xmit callback can run in parallel with airoha_qdma_tx_napi_poll(=
)
>

Okay.

>>
>> >+
>> >+	if (q->queued + nr_frags > q->ndesc) {
>> >+		/* not enough space in the queue */
>> >+		spin_unlock_bh(&q->lock);
>> >+		return NETDEV_TX_BUSY;
>> >+	}
>> >+
>>
>> I do not see netif_set_tso_max_segs() being set, so HW doesn't have
>> any limit wrt number of TSO segs and number of fragments in skb, is it ?=
?
>
>I do not think there is any specific limitation for it
>

Okay.

>>
>> ...........
>> >+static int airoha_probe(struct platform_device *pdev) {
>> >+	struct device_node *np =3D pdev->dev.of_node;
>> >+	struct net_device *dev;
>> >+	struct airoha_eth *eth;
>> >+	int err;
>> >+
>> >+	dev =3D devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*eth),
>> >+				      AIROHA_NUM_TX_RING,
>> >AIROHA_NUM_RX_RING);
>>
>> Always 32 queues, even if kernel is booted with less number cores ?
>
>ethtool is not supported yet, I will add it with followup patches
>

I meant by default.
Wouldn't it better to check online cpu count ?
If system is booted with just 10 cores, then why initialize 32 cores is my =
point.

Thanks,
Sunil.

