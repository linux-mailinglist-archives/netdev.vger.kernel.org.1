Return-Path: <netdev+bounces-264070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE1wNNCyqGlSwgAAu9opvQ
	(envelope-from <netdev+bounces-264070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:31:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C122C208A30
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBDD830015B6
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9737267B;
	Wed,  4 Mar 2026 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sZ26Yz1g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A37239E6F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663498; cv=fail; b=L5mCb6+EPpOVAk/rfAs77DyMysEkTWkYSHzAzOPHWFxn/h1KVuePh2w/FZDtM8jLcN3nvKVz/QMuoxoq5NTwzzXwPIAPHFEa348PWwhkxPa32ZLsR/Ro8fN4a8s/AwR0UvBXrQxHM+VtRD8Iamtwfl+xa4X2LAqKDxO0r4Frxzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663498; c=relaxed/simple;
	bh=rdnhN8qhPwnfnKdYmU+c3Q1E09g6hd5XfgvcagdKVlQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=XGrUcLQOUEvOmmZOg//7Q9Yvu9sB2FxoTPj38Ws/S+MwyaylZDqKfKiHO/bsp5AdO1WmuaPzNQI67eMoN/eVoyxMfAL1mqU2zKKHT0dBgyLB5MT9WAUPsmLfd4WPRIUspB8N2T6m7wLu7ooO1KYaYVVp8WofKz+LUzjUDgMRgMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sZ26Yz1g; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 624KrDJv2372975
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 14:31:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rdnhN8qhPwnfnKdYmU+c3Q1E09g6hd5XfgvcagdKVlQ=; b=sZ26Yz1g73tu
	bsxyzgh6UAQbYUQE+UQvQzAPZuKABI1NSLCoLEPX2hs7xhye5r42RpQagrvXa66o
	i0XKhtUANBRiSXeDbKfHsvMZXKnq0spJ1lFW+6oQT2+8eAjcY6L93MMaCUC1aakM
	eltFspF+O+igTUYnuA97ih4lLL8KMcm6Yt+3RlS869h00xLEAgzCAdsSSCGoEAGF
	XGzr8/2LLdIx34U2ObUveaV669Goy9fBa36lX2HupOqS16NIrhYYEE1kNfBeW7+v
	VOlrPmNuPJa/moDU7RD0rys7XLXDrRgklrbgtrVWEWVjmPhsRu+isNBfYkYD9i6x
	vlUqV5p8eQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cpr6uvg1f-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 14:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl4NnIEyykhl8XuWJ/fzVr1VPp9wb75PnxlZy9Gtg0kX/OYqa74jVwvWjusFPCtynlqsg+PGhAIk6wpvhDsVXEOcARRfPMNv4/dRJYYanX5BB9OePRbVinUbV8Emh9XQRR6whz+s1FayFFGdG2bRmPUHMDuWhnYyM5k4r8W5vobFoGX9eBPwKDRPVUTBbLFCYkXrBgstAZKf3rLQpnpOoPAVFVMJkwg7B4r60McfwpwS0hK73MZALFy9EXBTi1xFUnR8km4qFU8RthYWKYliENmlxyTcvz6gftC4JZAwNqdWdp3Qa6HIgxdS5o4/jLkmQsB20AdujBS74zWRdmBqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJhVPapnHq/oIzE2jTyUAXuD2/WsEBnVJIptcY3xNCg=;
 b=OllLPuuFio38gCtEjDX8CS4xn9OFFwyOgbz21zDyuJ4ONMdwGoH3SwT6DgHeo8RIKe1ehUqv4vIsNZBmR4kwbELjGlfmHkJ9RkHmS+YZgJJJK7m+WUrKSqVXwZm4O0+gMahDaqVfuZL7C/0ncz497dfW+y7DdVgo8fhsw49FE21LT6Zafr6jUkK2nEZZg9Do13akl+pO7UnP8RnAxAJA5gj0ltcLq2yZaOrF3qT6I7Vn/oGWbkt45aA1SRs9TuPsRowbYiNln4wslJNRnppZApAelCXERPoIYTyvuCOoVsXQyPdFOIvufTgnnFHkXlt8HJYmPm5az/sMxQNBeidBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5817.namprd15.prod.outlook.com (2603:10b6:806:33a::11)
 by DS4PPF7A44476B0.namprd15.prod.outlook.com (2603:10b6:f:fc00::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:31:32 +0000
Received: from SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2]) by SA1PR15MB5817.namprd15.prod.outlook.com
 ([fe80::5aee:c356:70f0:66c2%6]) with mapi id 15.20.9632.015; Wed, 4 Mar 2026
 22:31:31 +0000
From: Wei Wang <weibunny@meta.com>
To: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>, David Wei
	<dw@davidwei.uk>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Thread-Topic: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Thread-Index: AQHcq2vctPcgZuHnIkGgU6JfsZG6gLWekEYAgAASKuqAAAiHAIAAALmAgABHTKk=
Date: Wed, 4 Mar 2026 22:31:31 +0000
Message-ID:
 <SA1PR15MB5817DD5000DA78CC8187C743BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
 <willemdebruijn.kernel.2c99d96277de8@gmail.com>
 <SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
 <94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
 <1d2b02b2-0541-4a17-af2a-95345395d2b6@gmail.com>
In-Reply-To: <1d2b02b2-0541-4a17-af2a-95345395d2b6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5817:EE_|DS4PPF7A44476B0:EE_
x-ms-office365-filtering-correlation-id: ef6c0f43-0bcd-44f8-3a57-08de7a3dc922
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 qZzHmfI6ISogfAgi6/EvCU1Xlo8CZO9kDs3Lcsg/Q249UzaZxZ6K4jgwywtZC1Dzlhjr8KsQuhiXi/nz9cmrjd5a3Q1YHjHMZ/J7UVzlk8HMuMKK7+iLsc0BtafIw9teGEbeA/mi4zqod9ObCbYsLKU/ASHOCIrdeNyTyNtHDlXWlQB0b3H3uZfw7DA/7vCk0Q1BfRNMzYV3ThHP7MyOC7AiNonNODLSlwMxP7tzyWZKpq6qTGr7JJskisJ528QhyKhds6YGecDcqnPdRzQbzCbgTuMr80k9qjtZIWORxJJutQ5OLvG0GSPc95/urhyIz/CWFV88y91YWcUZsUqS9mLfOUR0gi6zx0xfTYomfWeuuK8xUExw43SmaG0oymRCF8VJb+7QC0szRRS1qF58Gd8THw4wjCGozleGgawhsI3MjgoItA53TsFyrV8boSb2TthESdGLvGcDZF5P5vsGbB/cp74rxejQxmeQ3TtdC+ryrcYw214oshZd0jibwYEgR00zV3IEOcn0N12/gMwWw5nBByGTd51NqEpCg5VpkjzVhP63jPQCgBNFvQnwQ3QsJO4x5daHISl3XhMVte1JQ/Fpft5tv77piQwcQKqv1gOATFNPKTKAvkzmQBOLtPW6UthDTdINetRiCs5KYNUUrUPyyTnrrYFoDCwA6OmuVIXSoPSf9HCKZfjVAGDRnp5OfA77iQ1ZxfoyiKLjJ2eQfzDvpeCHDLnrggfuNbRwUE/oTzEBqlBqz2M5znBLKrr8KG8uSdIrWqCN2sqhT7gM4yeVyYHcdWSMn/Q5j8JdjWE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5817.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aXMjk/qMojHOAp6SD4IJVYzZ59Xms/YEj3F0TJ4ranyxuovgNYy3dw6QCm?=
 =?iso-8859-1?Q?guR3+TMXhjlhTbL92uv25RGkHpoI/Yf3t+PfggeRKaME7edO72G1P0mdcf?=
 =?iso-8859-1?Q?htbZRXWl/9Z5cxD8G0wwYDWDSY9f57ZBv6i9HARMaixXTZPhVRBWtzQywb?=
 =?iso-8859-1?Q?kIz0KrT1ZI+owtVWYxtzXUvqlqHqNzEncGVFBTsBdN2aE8sld1BGv52VSL?=
 =?iso-8859-1?Q?OPnZHPAnZZ/FIezISyIinZw2hpBJnoFBcbh+6R/MJOz4TvFzTI3+K5peg8?=
 =?iso-8859-1?Q?9kR+y5KHRMD3f/1tJphiedbkKVcWDlBCC+h/6ZQKhsKmCjo6nxx1KmceRo?=
 =?iso-8859-1?Q?9fqR0Y0gJHKPgrVOe+ELb/Mp3bhKUyi2H5B4JmvQUfjs4eXDXvST+0rr60?=
 =?iso-8859-1?Q?Y4kjFzBIMsnQYyTqDo87GjQ/21HxYp/6wGeBHiOMWgnxbfqS6IvACTFn52?=
 =?iso-8859-1?Q?7XEmR9+Xik8dkdD/ZlRC/BY3rBLceQGsxdUpiZS9PUFnS6mtM+zlGhwf3A?=
 =?iso-8859-1?Q?tsmS1GOsTkXlMrChlBIXxbXovkNNMcJ523jWwtYo+SmedRw7hKFGoDi7PE?=
 =?iso-8859-1?Q?HMgy15TanIWGc9yMitZAj7bTOxaGMnos9caG6Wu64EqpopdJJo/YcKq1Ti?=
 =?iso-8859-1?Q?/55OaIisu7LS6hYpPjJGUUzyjLWxW8fyfFwYq6FIN4E9B/hx7Rz2Ehjz9D?=
 =?iso-8859-1?Q?oGeRzODnR5c+YxwWA3gvs8VvOOeZec2U+LcL92V/FPh32Khfh0Uf+Vpns7?=
 =?iso-8859-1?Q?bf4kJBC2IcFdF8MZ2LaWBbYpUgLGFVGyRsX1RRxASC0f/nZQejFLBhjuPB?=
 =?iso-8859-1?Q?GQM0QcomcSaeHnVZouydYjXpDlCILTlXn79ZMZ21uXm2sLPxAHdBLPMrRq?=
 =?iso-8859-1?Q?xD96OIQn9RtmgZ1UAv5uv+98ODOqd3EjrflGShdtwNSfSdEKOlNJ3QKp77?=
 =?iso-8859-1?Q?hhSW3qqs8QGoJKbI9/XNiXppc4fCxkTk0tw76bE/sOlJ4buyl/WUKpoSDu?=
 =?iso-8859-1?Q?u3wY9DlFQ5TVsdqkERXKHOpiWtyJpO8goK0/K0Qr/ELMPQZq5YTksaJuOA?=
 =?iso-8859-1?Q?0avwhiA7fWO1gQdX70/QOvjFnmQ40II5M/wPLPtdtpFzTLG7FCIK8ccWTw?=
 =?iso-8859-1?Q?Ta/CL97npw38ant3HPWZM5SSFYsb4GbV4tur3jM1jO+NaXroFucT/QIUwE?=
 =?iso-8859-1?Q?A/krhHK5uRaEfToOm7NXGQMfs7Y8lQ2mjCEYddcq1t38wTziCOD4LhfeZF?=
 =?iso-8859-1?Q?wQgnkrKld37TAbeI7IhS+EzIbpOgO2jto7ddj5u842H2bYoup5bOXrBePT?=
 =?iso-8859-1?Q?261yr+Ap9EYt4gwxns5B+pq1dvwvW5C7clY3S441U4UswPCglGrqgYi+Mm?=
 =?iso-8859-1?Q?IP/PdsHuQTzi9Lhp5GHQbOC89SRnBqcb0fZKWZN1fEu1JEXzY/CuxcfxfH?=
 =?iso-8859-1?Q?GsnbLLC+pl5ObstjwrCCw8zMV9a6pA+mbTaVYa58/vAAMto+5f8L3ZKsXI?=
 =?iso-8859-1?Q?g/pK8itjHrMWpyTWXOH70APnIcsw8VnPrLod6sw4Fj19THYoptDIU2jgCy?=
 =?iso-8859-1?Q?4uHMUG76Qozve01eHfMuR6WYnDeWJl3XlnNk9iPgjNSPUeQuU571p/zRNm?=
 =?iso-8859-1?Q?NjIBsZoj8sWfx2KJGohiFpZE3DH1LOgFdC/ZUYGSMIW2u4pC7IJe/yGPaw?=
 =?iso-8859-1?Q?gCOi6Hx7skOOvMR0SkeJlMjPx52e0XhYj+RJckk1htcvk0qdadhYgKoIZR?=
 =?iso-8859-1?Q?KzGTJp+ieQa/laJ38WmfTVR+gRdOKij+4C9mLLEFrqFxzEG3dpLDNmFLnc?=
 =?iso-8859-1?Q?r+7+DzGpUi/nZYzyXfLr8/fEDFv6hNw=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5817.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6c0f43-0bcd-44f8-3a57-08de7a3dc922
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 22:31:31.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/bXDMP7BxkojheuHImWLSngxnbwUriwi/H9vwO4AA5DYr4QDPlAD3UHkhoxEfJeA+1NQn5PtYn+gCqlV67HwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7A44476B0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: cBSwHD1ra4lntj0xSn6GDYd5tmQ8-eec
X-Authority-Analysis: v=2.4 cv=JcexbEKV c=1 sm=1 tr=0 ts=69a8b2c7 cx=c_pps
 a=guboMCJq5DUNhCsQxgR9jQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=z8RPQzy-FIXI6DA93UYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: cBSwHD1ra4lntj0xSn6GDYd5tmQ8-eec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE4NSBTYWx0ZWRfXyu2sr7+TXsoT
 tBcE6fwfoV745F6ky65XWWlpM3sZeaVWkAjndLG1Dt7Gn//QVUwLQh08OBlNI9OmCmoDS+w9dGW
 d2sXaC/SiDyOqO/fgBjFvCoarqjyMn9gGkYQIVCpSMLyYcq2PteQtzC8bYhDe9NV8frJS5VFmns
 hAZSwJwiTOaB/Ypuoafpg8RNQe+22ZfCVQQyVteWstHH0OV40EHjDrF0ZLYcZPzbMl/cVnGIqv6
 7jnOqQjcWvxnOS2iBClDCAj3kt7FbcKpW/8nagpfJJo5bHgv0JbM7utUH3qWVIHe48te9RQd5sv
 Inwa1ygDCWm6Dm0aYlLG1NyYlSO9WgWnAf0bKKoVIGvsMctPohaEDP4n0TFlQtFgAP7XBjwt2JP
 IP7RN7knKjJK9VnLfkbRMRol/1HZA+mW86zFdhztAXWr6LnyOkFPSLTGr4bVRJzZ04K1nGc+H3P
 mN5Ulfk790uRyyzRclA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Rspamd-Queue-Id: C122C208A30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,SA1PR15MB5817.namprd15.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action




________________________________________
From: Daniel Zahka <daniel.zahka@gmail.com>
Sent: Wednesday, March 4, 2026 10:03 AM
To: Wei Wang; Willem de Bruijn; netdev@vger.kernel.org; kuba@kernel.org; Da=
vid Wei; Andrew Lunn; David S. Miller; Eric Dumazet
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of psp_d=
evice_get_locked



> On 3/4/26 1:01 PM, Daniel Zahka wrote:
> >
> >
> > On 3/4/26 12:42 PM, Wei Wang wrote:
> >> _______________________________________
> >> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >> Sent: Wednesday, March 4, 2026 8:25 AM
> >> To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org;
> >> daniel.zahka@gmail.com; Willem de Bruijn; David Wei; Andrew Lunn;
> >> David S. Miller; Eric Dumazet
> >> Cc: Wei Wang
> >> Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
> >> psp_device_get_locked
> >>
> >>> Can you give a concise reason for which operations to allow from
> >>> another netns and which to deny. Also as forward looking heuristic for
> >>> when new operations may be added.
> >>>
> >>> Btw minor typo in first sentence of next commit: associcate.
> >> Thanks for the comment!
> >> Yes. "unprivileged" means access from the main netns as well as any
> >> netns with an associated device and is used for commands like
> >> dev-dump, dev-get, rx-assoc, tx-assoc, which are user-controlled
> >> functionalities of the psd.
> >> While "privileged" means access only from the main netns and is used
> >> for dev-add/delete/change-ntf, key-rotate. This is more like the
> >> admin-types of operations of the psd.
> >> I will update the commit msg in the next version to make it more clear.
> >
> > I think Willem's question is more: what criteria did you use to decide
> > if each operation is privileged or not? I think one reasonable answer
> > would be: operations that have side effects on the psp dev's state,
> > e.g. key rotations or changing the enabled psp versions.

Agree. And the current set of privileged operations should only include: de=
v-set, key-rotation.
All others should be unprivileged I think...
(The get-stats command which I should make sure they are called with unpriv=
 =3D true. I will change that in the next version.)

>
> well, now that I sent that I realize that criteria is so broad to
> include things like rx-assoc and tx-assoc, which obviously need to be
> unprivileged :(

Yes. tx-assoc and rx-assoc are currently implemented as unprivileged. They =
call psp_assoc_device_get_locked() which currently calls psp_dev_check_acce=
ss() with unpriv =3D true.

