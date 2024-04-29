Return-Path: <netdev+bounces-92045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F88B522E
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6522811AD
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B514A90;
	Mon, 29 Apr 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nZG5/DkU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873D14F68
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375182; cv=fail; b=YbZDOANVaTSTFj/+6UpbkxqZw5c6tD+MWSpJxs18lCrYWldkgHDqPm+xFT/ee0lK+44BNfD/MYGiEO6/3Z19+XRavPVGgxGXT6KjTCVFm9/uyShEWYYVYwAV0v+4E8dTwZI1gULsEmNBx6/UppkER9WeIHdbTFKOxBiit6FrQyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375182; c=relaxed/simple;
	bh=t2eogOvlf7uP8CxsVmOcgy6LIFMHskH61oBX+yZrSDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PL4OqcDiSZXrGYHcLkreS6s5Zzdg9Jze9W+KBqk6387Ufa11nIKCXglKlbPPmMFbFi69JET10/ugbPVRpKQvhNPygcJxY8++60F8aEvJ/SWBMEN76/FM5e5bqcwundTsMIqmljHxYjmGfDZxun870N8z0qzl60M5RJcxdOL317A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nZG5/DkU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3vlh7005432;
	Mon, 29 Apr 2024 00:19:16 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43arexf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 00:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEW7vBxDXtmr41P0GxFBovD6ermgtfndvm9qEeSw9ijtWY3+7rnutkF6Vj4u5kJFor0/DmeNS98NUFaI2U3RQmBl3eNIkbhWh0INAMp/i4q3JcCqPUEHWhUtdiPOU+KxlECF3xUbTKuL367fBwcxvV5X8OulsvWnFYAQRsUlZv0xIb5SJFahlc8TRfyKQ9azOAUM6OifyQz+DKotfJYv7s/ldZugtgEz4Fa/xkomenGrej7IWCsAbrz0CcKKslaSF7ZPWYhHGBpYLtApRnGJCDNdA+W23YHJfkHR/HiXo/hYy1eoDbgfW07BTOnca/V8o+PIDzx7nz6x58dhvlhUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEl578ziGfdrPWgbQF1y0sAm+nbD+KnLEL7elof2MRE=;
 b=mgqWooW+Dd/nI5ZAwP3IINgNpxkZBW+AMkWee4OEsgjD/peFKbnNb9C7w35Tj6jCP7W7pE4SkOUnRg2uRNLJYtPnPE+yl+0j5RXw2lA4CEU306SQIwzdG35w7/W0dh9u18MKZROmjO7ie1hMiJD6FaJmhpYrGZMXbCD80qECBe2lc3125odwFQSTKzyIa+nmiUwyvpFjFBAhASzNiZ7QLDEo/9qP977jSZglzIa7ZEnZvFgW/0tLExucuLy9rrtfdlozHfg2IS0NtJJLlO01d4udCLMCA78ipeRUZ5iRpapNyF9dCNo/3F2eCrzRkR6fY8Elh/2PwCKu3a6uFumwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEl578ziGfdrPWgbQF1y0sAm+nbD+KnLEL7elof2MRE=;
 b=nZG5/DkUKC6rhoJVHpVnPzY+vD8CwPjrZ+xWm5cvozcr0Qjp+lr+74sfkNdHUpg9dZTRyM+80uVXn3eWBfcgRGgr0zwoSUqNFPyEcbaarP+Sy+yVQ3Kt7gTzV2+PF3hQQ390cPg4yA9gUIyTdoD+vfJHL2MiJoat/jR2D0k8B4E=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MN2PR18MB3464.namprd18.prod.outlook.com (2603:10b6:208:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:19:12 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 07:19:11 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Marek Vasut <marex@denx.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: RE: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out
 external clock rate validation
Thread-Topic: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out
 external clock rate validation
Thread-Index: AQHamgWIysBpOLTxokOUgIlHRj/rVw==
Date: Mon, 29 Apr 2024 07:19:11 +0000
Message-ID: 
 <BY3PR18MB4707314AE781472140361D62A01B2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240427215113.57548-1-marex@denx.de>
In-Reply-To: <20240427215113.57548-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MN2PR18MB3464:EE_
x-ms-office365-filtering-correlation-id: 1c525101-591c-4b13-a81f-08dc681caaf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?HhXqZ3h43E7qEAHysn4xiKL68ALtLdXQQBtiKIzC2gDel1R9F0Gixm1aiudo?=
 =?us-ascii?Q?DFtLWyOe0iHPp6CmNloGTF86Oey4KDK1Ex8X55cHX7af4Y8B4Cz2kNdYMqMy?=
 =?us-ascii?Q?4Xkj4PdZ4yaUfQQb2Ld2zNLOl9IzStHfmRV5cDwpkY1x0D2KICGP5YuO4UGd?=
 =?us-ascii?Q?KcpMzUpdgbhTKylcpsxr/QMnhNZRN1zAsSzCaYgcs4wHE34l82YdIGOfH+qS?=
 =?us-ascii?Q?zWnkYDFb3kpTGT7eXwHxq2SwXj6LQ/pM7YydQYqND9KHGPLgp0Ew7ZFbCySg?=
 =?us-ascii?Q?TKGCL/Y0XxTRlBVTxKTI7x0wibLF8ac6tsvvBYB7dzcWg1Q7z0MY7+SIg4ZR?=
 =?us-ascii?Q?3pW5kIhz+blpgWR2nFlhj/ePwSxInhp/jWwPh3kKFHquvaz0mWS7sfhNu5BK?=
 =?us-ascii?Q?lDwBh9aQRSjS8ZGWepbVPWbNlMDPPfiFn39MEgFJx2XFJq6GZ1a+FI/pb6yp?=
 =?us-ascii?Q?uNLgAR3dw/qfNmGxWT7f8W4xNfILhtpT1Syw2Wa87wggWRTW3+XfcN0ml8Rt?=
 =?us-ascii?Q?e5dkFNZxULt+oRUqezytNFthiRCmarBJQSmCpszvPV+O8TyoSmiZxp80zKdG?=
 =?us-ascii?Q?+kRkjBWt9pbaXWETMnMf//ajLjfzk+Eir6aMV7EhnFkzal5cq/mDy1GA3qWe?=
 =?us-ascii?Q?mzwFKTLpH5WLTGVZkd7pvYb+N7GG/FyZALljMdCA3A3AOvDU8nJw4RW7GdT1?=
 =?us-ascii?Q?H1BUJq0CWBTJKq0C22bTz083OJPVyNzzb343r5lRZzHQ5abR1i3DJE3xlGGR?=
 =?us-ascii?Q?UFIbTt6bbkEun7UCgv+zi5FCV9Qs2BIFJ1NHpiFb4i47jDjchv6Y2WyOxdaB?=
 =?us-ascii?Q?YqefnsTkYTok4MRtNCXKQvqwTVOyghoQ5KOIJn2uG5W0HNi5CHNXdLuUFmHD?=
 =?us-ascii?Q?RGm0n8Zrw0iPKiyrhGt5xZB3qyvlVti9hca1j1VNzFg/nHw+wczyQ/j2bvAK?=
 =?us-ascii?Q?pmGr4Qc/0rRrNZAh5dE2b1lIC4NWeeKeZKvhcEUyKUwwbzJ/B0xZhijnjtJR?=
 =?us-ascii?Q?7e/awyqBg5PXDkjiMvKy5kqOEWJ8Pg+/HFM812HCC+qfDKUTWwwIkThzAGwM?=
 =?us-ascii?Q?HNzEhOOH7Gyb0rerTi3tlJ7C8/IQRjluS1Dc1BvjkZx56MbI4qIbH3ltrukp?=
 =?us-ascii?Q?5OcdnwCcTB2KLOKujRtVOvZWLSmlWY8rupLnGrAu1SLtRq3yhBgwWBkqkChh?=
 =?us-ascii?Q?2Jslh0K+9+sFHI+OW3ijEeGkxXW6O7E5AjVOsnqQUyevdLyEBK3ko4ApooGF?=
 =?us-ascii?Q?eR4rwxDxPwDN6KyafR1Nlf8p6b9CK7beGj3D/E53E7ILGYsc6W7nAlfAkjYZ?=
 =?us-ascii?Q?0ErRWWrX8eJ7cDAkcoWIoahlIzXtWR9CarHsI6+z89Kw3w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mHNvHs/0oK8S0y6LJqmdHtr58iq0Gs+eBEqPkEji2IH/JgtB6/VdxEBy/u+w?=
 =?us-ascii?Q?NF+soToaklMLqbFjD3bFiTtlxmdATEmpIcvTsG/5sc1c6+5ybYOkfU9xV5eE?=
 =?us-ascii?Q?88/VlV/p/mWjwMwbNoh1eJ47zZJntR7kvFV3daY8rRTXMella/HFjipUjC3z?=
 =?us-ascii?Q?0YQOH5BZ1C0jFYoOHNU+MiFk4tMiCR4TViRD0ua29Fp3jd4zX2+YqDHrw7LI?=
 =?us-ascii?Q?n83QaOGomMFCQW9bXE8bajlC6JoHdCRtK2zWNdaRf1KJQKVNjaDiQb6eK/zT?=
 =?us-ascii?Q?vT7T6Zq0wscpe3dzd3M0FE1qX4o4aOxPTVs06Z8WPPiIsm98lEI6jkOuqm+O?=
 =?us-ascii?Q?EVdanS5eO6ituolt1gZESBiC0lWxQflCVAee4m4J6UZR7dJpkltm7zOca68g?=
 =?us-ascii?Q?ZeKQc6Q46yrqYvaw6gwVqiAByW5H0g3P8Lxkm3EV+dy0LXWo1oBWjiD/Uv4g?=
 =?us-ascii?Q?PU16ur8FvD7PaSdF/DeNty6gudEsDUDMa7ZtLwSE/8zR2ubKhnBi7VyiPtG4?=
 =?us-ascii?Q?02A0oakbppqI3OuX2n78mHdSkiCtxeKKAUbtM+CQ9e5KFEBuK1do2uQwmhuD?=
 =?us-ascii?Q?1OYpSTy2Dx9dhA3JCUxu93+u99J/0jeedQ/w7DjHKrggGeXwbl0Ol/HcKuzK?=
 =?us-ascii?Q?xvhsEdmME8rYjSWFomStpHOJJg85xGhgrxvltNxWE6M4uGmrRE/eTVpfhG87?=
 =?us-ascii?Q?DOPO0dqCtNoJTWdI+9wLA5sophxt8eNPyhrSYX4wc3bkPK35AIdnH9u+u4b6?=
 =?us-ascii?Q?8v6a/1G3b4ag/Pg74N+NJVtqP88dnlUDoJ8uDohmHBCdkx6yYoLHuqVv/U/i?=
 =?us-ascii?Q?XRY5JFFC/qRx69aplfh+6VqaPC7TjVl1Z48Y+QcFq38ku5kp96kbqOUmeZDN?=
 =?us-ascii?Q?k/z7wbeykMjKyIJu001R/aZLtzzD3QjXjpngqQJn16+GLUXaua21P6peeps4?=
 =?us-ascii?Q?yc1x7eSFvzgs0imp8/K2t6TO0CBqPPSMe2ojOHbQTs+5cvp+PiF63lGmqrr6?=
 =?us-ascii?Q?TWKtuf+HfMXXXhGYNF0d21suBm2Evib/kYXbECBf5jv00C71wlpsHwmkje/f?=
 =?us-ascii?Q?mqDRo1IMsTFeitQb0wSHOjKgZmxhd/ZCwmRQK74IlERYU3IbaqKsa2qXdP1p?=
 =?us-ascii?Q?aEBNXRA9LfbyoT30jF8ej7cJ+jbJ8OZdqUxCDvAIGl/iawoLp0WMC55oBDZk?=
 =?us-ascii?Q?/Bnq35IjJiQVSJBtRFfMV333EO0nNVAae9NPM63KiFlotFn33BLRtQN8XYaE?=
 =?us-ascii?Q?xpg6YKYiSc5bw+W0hjbi/pRqFlpRuriecEm0xaM6CIRJ1TPhvtSYHaTGzBe/?=
 =?us-ascii?Q?f68ayzDCsLrilGD4pE8sLQgVQuHnqxpZJCGcVpFYtZUE/4tDblRbyLiYMHNR?=
 =?us-ascii?Q?790LyFZUMjsGAyna9IzGE7bVdZqwxdClV0uZA/Mzix6LO4Q2xX7gQZXxm+0j?=
 =?us-ascii?Q?eDWfE6cbjHBIcrleNnbPfEyM6DWxuuRjDrvtd28doBw4kxfAwn30uoC6/XDk?=
 =?us-ascii?Q?T1inVfaRb4nDZxIkOF+j/snyyNn2p6ovaNN078zMbpXwLQitcd0ktseA5iCu?=
 =?us-ascii?Q?vM8MUO+tm9zE7AEQwbO2JIRat0QcloEvYTXRFSns?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c525101-591c-4b13-a81f-08dc681caaf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 07:19:11.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpxQOnhkpNSqy7Z2zbaLKEYXgqMNsKlPW7NOgic7rDgZZnUl1xy5dbtPKcnNFh4wHHkg27fE0vGQi4AOWSmNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3464
X-Proofpoint-ORIG-GUID: 9oxiVnFS-WqgcDAThVfNlG73CnKEnwJY
X-Proofpoint-GUID: 9oxiVnFS-WqgcDAThVfNlG73CnKEnwJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_04,2024-04-26_02,2023-05-22_02


> -----Original Message-----
> From: Marek Vasut <marex@denx.de>
> Sent: Sunday, April 28, 2024 3:21 AM
> To: netdev@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>; David S. Miller <davem@davemloft.net>;
> Alexandre Torgue <alexandre.torgue@foss.st.com>; Christophe Roullier
> <christophe.roullier@foss.st.com>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Jose Abreu <joabreu@synopsys.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Paolo Abeni
> <pabeni@redhat.com>; linux-arm-kernel@lists.infradead.org; linux-
> stm32@st-md-mailman.stormreply.com
> Subject: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32:
> Separate out external clock rate validation
>=20
> Pull the external clock frequency validation into a separate function, to=
 avoid
> conflating it with external clock DT property decoding and clock mux regi=
ster
> configuration. This should make the code easier to read and understand.
>=20
> This does change the code behavior slightly. The clock mux PMCR register
> setting now depends solely on the DT properties which configure the clock
> mux between external clock and internal RCC generated clock. The mux
> PMCR register settings no longer depend on the supplied clock frequency, =
that
> supplied clock frequency is now only validated, and if the clock frequenc=
y is
> invalid for a mode, it is rejected.
>=20
> Previously, the code would switch the PMCR register clock mux to internal=
 RCC
> generated clock if external clock couldn't provide suitable frequency, wi=
thout
> checking whether the RCC generated clock frequency is correct. Such behav=
ior
> is risky at best, user should have configured their clock correctly in th=
e first
> place, so this behavior is removed here.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Christophe Roullier <christophe.roullier@foss.st.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: netdev@vger.kernel.org
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 54 +++++++++++++++----
>  1 file changed, 44 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index c92dfc4ecf570..43340a5573c64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -157,25 +157,57 @@ static int stm32_dwmac_init(struct
> plat_stmmacenet_data *plat_dat, bool resume)
>  	return stm32_dwmac_clk_enable(dwmac, resume);  }
>=20
> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data
> +*plat_dat) {
> +	struct stm32_dwmac *dwmac =3D plat_dat->bsp_priv;
> +	const u32 clk_rate =3D clk_get_rate(dwmac->clk_eth_ck);

Please check reverse x-mass tree is followed for these variables, if possib=
le.

> +
> +	switch (plat_dat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		if (clk_rate =3D=3D ETH_CK_F_25M)
> +			return 0;
> +		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		if (clk_rate =3D=3D ETH_CK_F_25M)
> +			return 0;
> +		break;

Please check, whether we can combine the two cases..=20

> +	case PHY_INTERFACE_MODE_RMII:
> +		if (clk_rate =3D=3D ETH_CK_F_25M || clk_rate =3D=3D ETH_CK_F_50M)
> +			return 0;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		if (clk_rate =3D=3D ETH_CK_F_25M || clk_rate =3D=3D
> ETH_CK_F_125M)
> +			return 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(dwmac->dev, "Mode %s does not match eth-ck frequency %d
> Hz",
> +		phy_modes(plat_dat->mac_interface), clk_rate);
> +	return -EINVAL;
> +}
> +
>  static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)  {
>  	struct stm32_dwmac *dwmac =3D plat_dat->bsp_priv;
> -	u32 reg =3D dwmac->mode_reg, clk_rate;
> -	int val;
> +	u32 reg =3D dwmac->mode_reg;
> +	int val, ret;
>=20
> -	clk_rate =3D clk_get_rate(dwmac->clk_eth_ck);
>  	dwmac->enable_eth_ck =3D false;
>  	switch (plat_dat->mac_interface) {
>  	case PHY_INTERFACE_MODE_MII:
> -		if (clk_rate =3D=3D ETH_CK_F_25M && dwmac->ext_phyclk)
> +		if (dwmac->ext_phyclk)
>  			dwmac->enable_eth_ck =3D true;
>  		val =3D SYSCFG_PMCR_ETH_SEL_MII;
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_GMII:
>  		val =3D SYSCFG_PMCR_ETH_SEL_GMII;
> -		if (clk_rate =3D=3D ETH_CK_F_25M &&
> -		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
> +		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
>  			dwmac->enable_eth_ck =3D true;
>  			val |=3D SYSCFG_PMCR_ETH_CLK_SEL;
>  		}
> @@ -183,8 +215,7 @@ static int stm32mp1_set_mode(struct
> plat_stmmacenet_data *plat_dat)
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
>  		val =3D SYSCFG_PMCR_ETH_SEL_RMII;
> -		if ((clk_rate =3D=3D ETH_CK_F_25M || clk_rate =3D=3D ETH_CK_F_50M)
> &&
> -		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
> +		if (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk) {
>  			dwmac->enable_eth_ck =3D true;
>  			val |=3D SYSCFG_PMCR_ETH_REF_CLK_SEL;
>  		}
> @@ -195,8 +226,7 @@ static int stm32mp1_set_mode(struct
> plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		val =3D SYSCFG_PMCR_ETH_SEL_RGMII;
> -		if ((clk_rate =3D=3D ETH_CK_F_25M || clk_rate =3D=3D
> ETH_CK_F_125M) &&
> -		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
> +		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
>  			dwmac->enable_eth_ck =3D true;
>  			val |=3D SYSCFG_PMCR_ETH_CLK_SEL;
>  		}
> @@ -209,6 +239,10 @@ static int stm32mp1_set_mode(struct
> plat_stmmacenet_data *plat_dat)
>  		return -EINVAL;
>  	}
>=20
> +	ret =3D stm32mp1_validate_ethck_rate(plat_dat);
> +	if (ret)
> +		return ret;
> +
>  	/* Need to update PMCCLRR (clear register) */
>  	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
>  		     dwmac->ops->syscfg_eth_mask);
> --
> 2.43.0
>=20


