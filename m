Return-Path: <netdev+bounces-101747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D98FFEA5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D34E28BFDC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30A15B143;
	Fri,  7 Jun 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fDRZokCu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373D156C5B;
	Fri,  7 Jun 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751070; cv=fail; b=LF6ESjpHZRsT0o9TIH/TWMgmuNkhmD9R+I/U8EDilbPlirLMJGq2vm1z0ojiqL6b4uos47qh5oHecwlbksNKPaC8knoo1Di/MofkfxLGkHiXNAKlp9dXK7g2FECP+oZVHbW/qshIFq0jPJ/skZ2dNHXonZVRavjIVhnyo28HaV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751070; c=relaxed/simple;
	bh=xFgYLebGH0euSHhlp6K1NGKDVh/ZQdOxh2Zv59CnC3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wdh0EIIh5f+TwtDKKkLJdDk+1zNJLOLLTLSj2ezU0ahcuCcH7FzLBth1H1MSw2nuRXaGIYHTFNvPA/4PCmYBzTL0Rr4/3aCG+ypqoh2mPZLlvgkdW3MkTD4Hx+wRZq0M8h660oZFqASXPtd3ySl0igeuulKVRvF6GlIyLTqfSTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fDRZokCu; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4575WWoZ001353;
	Fri, 7 Jun 2024 02:04:02 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ykv59rgts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 02:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWcN3FuVuq87GWkXEAoQi3ObHoukkMW/5jHyMD5/Y1Mmr27vVP2i8x26oIphcmG64OIH/yzLs5D4jWsJpmZKV3rVRKVJUo9FFL2HOssgogwXUbOc8BrNPHw/yk0863XYQby7vJ+Dvn3rEX969BJ8gszcF7CY2OynQUkCrrEW191HJ7KUkAo/DlLWCx+YIA0NpgRmpHfkL6V40DNQf9ddil+O9bTnGg+cRbvXIhrcmpQVfqUzKto1YDM9yEQ6/HzzEjTILV1rlRVmGF/tbHNHE2Iaee8AwEP1PNaqYepahIATYy7g72KWs1xja01Kg/vNkUVKml8pWvai7E49fZXSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8suX0j8E4W5sJ3NlLHqmfwlDLPrkwLGU/Rjt21OSbXk=;
 b=Xmb1FwxfT6Z8uAGHE82e0AHNcwj+KTb0M1hlZ7Wqo7+/X5ehBHC5eOGYbJkxDW9bgfSMLaT2DVCm5GJLrXQDQI/t03QRCLe1DFAErBOeBIb3sHYyB66uE0jieHops0E96arixjPPiH5BqVT0j9BlE+T2sH2cO694k0RF8yZL9Pi0R4oI31xbcxQGj9rfIJa4pY+5OxhQdWZqjSSTVRaGD3qDcQoFi2S2hSsyNX1kKjec2HVN3M+VnUyUGvQ1cYiLixIUXffp376Oa0Mx4sbOIwCDNyuHyPTTHzyT+rm5Um3r/d1JjE7zrDJuHJQg+EiKJCZbBKk2u9OC21Iqga8GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8suX0j8E4W5sJ3NlLHqmfwlDLPrkwLGU/Rjt21OSbXk=;
 b=fDRZokCuKU4Z2Sdznpm1hcMoMHc3a3GYJwJ6748xv69escVEf04kHFQzLwf4NocAOynEtyTE6qAK7/5/VQevqjqcoIDJH/r+wXoLXkCN+zsUCl2sENlrLMuuQhUXW8cJBxzpyMUK2Wc0yexqNy6Z8QMfboy6xRcdqNpsQ4pqmPg=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by PH8PR18MB5360.namprd18.prod.outlook.com (2603:10b6:510:254::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 09:03:56 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 09:03:56 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "pkshih@realtek.com" <pkshih@realtek.com>,
        "larry.chiu@realtek.com"
	<larry.chiu@realtek.com>
Subject: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHauLmglNHUNJhH+k6V4cXh5B3lqg==
Date: Fri, 7 Jun 2024 09:03:56 +0000
Message-ID: 
 <PH0PR18MB44745E2CFEA3CC1D9ADC5AC0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
In-Reply-To: <20240607084321.7254-7-justinlai0215@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|PH8PR18MB5360:EE_
x-ms-office365-filtering-correlation-id: 9ec8d388-3b15-4d19-f25d-08dc86d0c30b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ZtzcrbCc/k4kmvFuUdo6rSY7MGI+GyO48ytrliTZjeFHiaq+tKOBl+9qky7r?=
 =?us-ascii?Q?JPQNLWtX9qyCOC1nE3C/7YbEm85wHEjZdngzNhGAsy/8rasfLfuDsH+t15Cd?=
 =?us-ascii?Q?XlD2UvJdGeZu7Osrp7qaKTezV5LPmQvBNHAp1RD94wxK33+tzmFoTP4YGoIm?=
 =?us-ascii?Q?a8TKM+M6ip89NdG9JSOpSI717y7IVlEl91Fu9NlMj3ujXZgjyolbOhOHwXn1?=
 =?us-ascii?Q?R7LlT08Oi2Hde7HjGmBEFExC0VGoLXdaMw2TQ9vUeibpUt0pQ2CMDBI32xdU?=
 =?us-ascii?Q?LTYL6TWP36POzGL/eWzOCvVyRSDrgu5tDrbIZLO7zhjSedGmQvkl7R+OE0Jy?=
 =?us-ascii?Q?IvN2TQHKUADLJK0Psb0KfPYHzCulyDKFxtT7WXOmwXVWpE0p3QszQ+fVEpE6?=
 =?us-ascii?Q?VI6tYvAIIbPqpecU0/fVi3szxBMns9gTP8vjYU087NJ2dCFLPMBFIUYbZqF6?=
 =?us-ascii?Q?Z3B5Pvt6Ak7GPoYCxFvDyz6v4u1v6bpePnb08tb1w/Ar+5gY4nZD7xYgk2hD?=
 =?us-ascii?Q?xsjxNKbH+7SpQmny/oRGpjt8Ty8oQaxEHaUBeBp5OE8sBNim/aoHv2x5a997?=
 =?us-ascii?Q?LNp+SlxhzW2leUZ1u/pSS+DTVD3FCMQbh6gEZpLZJJTHXIfVqJdO6Vatbzr9?=
 =?us-ascii?Q?97odePaZLy9oqykv9StmCniFsfSS65QIUZSWQTwntNDJnj92Jj213W8AE/vV?=
 =?us-ascii?Q?KMePU+UT+NqWbWXnuZL8T4fqXBntgGVAYKM5ogdqVexBwOSZ+gkwfKQPBXpk?=
 =?us-ascii?Q?YUS4CcuS5IAGJfSew7mjN13L+MB6OTgmdJadIL4iO8wVJmMrUReWJ8HixL46?=
 =?us-ascii?Q?JL6x3yitSAkP8HcDxouj0FPO5PADt+BDyr4+QhkBmAWKr9mCz0hy8I5T+rPB?=
 =?us-ascii?Q?Yk/Fx0pZvDlDRyaAFtOo+rgIvd4GOgdgiX0zSgLFomY3+PvHKev89FRd64ee?=
 =?us-ascii?Q?CrnGoFCZy5rUql44m+Y3It1aigj4QDtq+zsLL24he4eqiZACONQcccDS7iF+?=
 =?us-ascii?Q?5g6vxbGMACPPVBcmB3qRnchQIoh5/laD2pAEwguA8Ivp4nmTUJJSHXu/psiX?=
 =?us-ascii?Q?HSkriAo61rCfGFzLVE497PZcUgxKPFTYVeqzBEJMRz9mnSiHBLd470aI1F4F?=
 =?us-ascii?Q?4FHJ06acyvn7wrz12GCTB17lGYaiRUamA3ziG+5+6kmqkIW7pHgdeHGFAIGp?=
 =?us-ascii?Q?EEWvgtUltF8EFFr+HwpHFlBWPlR04Fooejy6za0w/xZlCWvVr/P0VYj3L1HA?=
 =?us-ascii?Q?5yVS7woAQ7f16MQnz48Yq6s4s2YqtDIw2xqkrs9aEVU1hCii1zw83Lr9VEVC?=
 =?us-ascii?Q?gm+95F8mzdgzCaphzdwZlFsYfpxMCLfM/+0uQe9FuW9c6/LJ2CZO4B9pgU/I?=
 =?us-ascii?Q?6frugqE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iYw9iJp5eu8jRWMUOXtWisQ8QXhkv7cX5Zy2QT7K1HtQEK8iSY6l0l5a3JiP?=
 =?us-ascii?Q?7lzsypMQ1kwi8G+bJrjUQxrv6SsktxR5gyz20t7n4flgJUDrFm76Tyjied6J?=
 =?us-ascii?Q?XDQzhrsq37XM24R1pyJpsMd5+cCXReB70J2fbjwYA4KAAtFTnPe0UVeVk5y/?=
 =?us-ascii?Q?yPqnC9NNEvf2wimQ+njJBGJPMwOLiUC7zHL1rL47qGKgPRyt0o13U7gqLkCu?=
 =?us-ascii?Q?RCWu+3YG7hmJeGZl6eVh46x00uHnYrIB5U7rK2EfpyJftzp6NFoixxs1zU/y?=
 =?us-ascii?Q?JYLHbCDoMwuwJhrObBqs5JB27Wgn0NqtMP6VNH9/IJzdN2hW+wgXtsTtyXoC?=
 =?us-ascii?Q?1ugCVAyiFGSLAL/ixLTpGJMOfAZr9E8Cuy0Hv+QHsa8XYeixS7BzWfcIN0NW?=
 =?us-ascii?Q?a+WUlQaju3VGfhzt6+rSEZmFYi2Nt43lKci//fGQGRxX76OMMWTlix+AlPOB?=
 =?us-ascii?Q?ytZPJ4BByQwN4UWLdSHVyrAcR8sOLWR8zvcfDhTbe0K7e2RDCFaFypgXwAHn?=
 =?us-ascii?Q?piGBDVH7Qta9ZtC+GlT/VM5CxRmYNyxn5nBWIQXL11SpT99bupOt1yXlEyIR?=
 =?us-ascii?Q?QOgt7n3lVITKJOTp/lEvvvQoOton1dm7zOHQF6x7ucZa0SI/LIn5paVnQA2U?=
 =?us-ascii?Q?k0IA73tGw+8BCTR62D3h2PKM7yGMNAugGnL7UwdWo0yGvOpWd6PQ+iryY7U4?=
 =?us-ascii?Q?h9BrMWtmpM4cN9bJw4qt9vihyWMd66k20OIl1slmTY/nSYWoG/4h5rR9obdB?=
 =?us-ascii?Q?x9w5OgjAA5xzVaV9AqslgDTInSGLtjGC+dbiEuY8v04a5oGXEMLfx11I5SVa?=
 =?us-ascii?Q?vve2wBhOeAJRlUglTwlPgA7BssIMwoeKp+OPbTSR2qYZucBSa7rv2T3MR0Qg?=
 =?us-ascii?Q?SWDZfa+lwzo/ui71elK+i2t3Gm5UaLltCIqSlJtF5Bu5mKyggS2c2NTOd4fR?=
 =?us-ascii?Q?xkERb6wnUgV8cpqgc033QrFXEcwdsoVNcbxJeiuo/CR9gxzj//qGheUcm9aH?=
 =?us-ascii?Q?kQZisghzKsHKap738btFJXmkBNH/6N80veL/VplgV7xT5wWntESsno2vtEJG?=
 =?us-ascii?Q?V4UlrPLciQUzRIeYfizJhBDyS209k1fU1alMYtViZkDX/VEuW5vlsbSJDBnf?=
 =?us-ascii?Q?QbG4vehrwJmJupStxJpq9iAtn6/fPIbVvdC+WWqbgtke6BrvGw3O3X54Fjjh?=
 =?us-ascii?Q?JLX0OZfSv+YRxE8VwJ96gHdaJxSMWMlBzGdXG02TMbuVDObHQgoeVdJ/Et+3?=
 =?us-ascii?Q?bKUJEDQYJqWCoIoVx51AtOgUB/+MzzEE+atxzNMZhhIPnFJvA/hJZS9tGBEK?=
 =?us-ascii?Q?lMPKCOcqDE+lMVnhOqnSGiXPoZaygCuVWU43Ti4uuTo5dtklAl3t3mFc/nP4?=
 =?us-ascii?Q?v347yB2SoRLmIhXbUI4oo+yeuvZqQPvP8WEXlQaWpP8MdxQ2SmTt0Go+dMfT?=
 =?us-ascii?Q?uW9tfSWTgVF1yy8m/W1Uy3SagNLmr82Q1MWqtBj6q57eoTnaSPVBMMiyUQfN?=
 =?us-ascii?Q?kJr/daWqnZE+HBFDsLWRgYogeOHt/16etFNFJwsJ0jNPG7WfmGtRu+8EyeS4?=
 =?us-ascii?Q?kmZHEJndBTRtpI7ESbs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8d388-3b15-4d19-f25d-08dc86d0c30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:03:56.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjFX9nN0JZ26d/gumKn4KMnI0CY6mSkry3lT6bmXVi7W5s2S2A04/NXidxt2wN3NW9rKlvpfbxUj01cabgQ2kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5360
X-Proofpoint-ORIG-GUID: qKWpweyM3N1SW_HqoP5CWcYxAFMb1Dnv
X-Proofpoint-GUID: qKWpweyM3N1SW_HqoP5CWcYxAFMb1Dnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01



> Implement .ndo_start_xmit function to fill the information of the packet =
to be
> transmitted into the tx descriptor, and then the hardware will transmit t=
he
> packet using the information in the tx descriptor.
> In addition, we also implemented the tx_handler function to enable the tx
> descriptor to be reused.
>=20
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 285 ++++++++++++++++++
>  1 file changed, 285 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 23406c195cff..6bdb4edbfbc1 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union rtase_rx_desc
> *desc, u32 rx_buf_sz)
>  		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));  }
>=20
> +static u32 rtase_tx_avail(struct rtase_ring *ring) {
> +	return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> +	       READ_ONCE(ring->cur_idx);
> +}
> +
> +static int tx_handler(struct rtase_ring *ring, int budget) {
> +	const struct rtase_private *tp =3D ring->ivec->tp;
> +	struct net_device *dev =3D tp->dev;
> +	u32 dirty_tx, tx_left;
> +	u32 bytes_compl =3D 0;
> +	u32 pkts_compl =3D 0;
> +	int workdone =3D 0;
> +
> +	dirty_tx =3D ring->dirty_idx;
> +	tx_left =3D READ_ONCE(ring->cur_idx) - dirty_tx;
> +
> +	while (tx_left > 0) {
> +		u32 entry =3D dirty_tx % RTASE_NUM_DESC;
> +		struct rtase_tx_desc *desc =3D ring->desc +
> +				       sizeof(struct rtase_tx_desc) * entry;
> +		u32 status;
> +
> +		status =3D le32_to_cpu(desc->opts1);
> +
> +		if (status & RTASE_DESC_OWN)
> +			break;
> +
> +		rtase_unmap_tx_skb(tp->pdev, ring->mis.len[entry], desc);
> +		ring->mis.len[entry] =3D 0;
> +		if (ring->skbuff[entry]) {
> +			pkts_compl++;
> +			bytes_compl +=3D ring->skbuff[entry]->len;
> +			napi_consume_skb(ring->skbuff[entry], budget);
> +			ring->skbuff[entry] =3D NULL;
> +		}
> +
> +		dirty_tx++;
> +		tx_left--;
> +		workdone++;
> +
> +		if (workdone =3D=3D RTASE_TX_BUDGET_DEFAULT)
> +			break;
> +	}
> +
> +	if (ring->dirty_idx !=3D dirty_tx) {
> +		dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
> +		WRITE_ONCE(ring->dirty_idx, dirty_tx);
> +
> +		netif_subqueue_completed_wake(dev, ring->index,
> pkts_compl,
> +					      bytes_compl,
> +					      rtase_tx_avail(ring),
> +					      RTASE_TX_START_THRS);
> +
> +		if (ring->cur_idx !=3D dirty_tx)
> +			rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> +	}
> +
> +	return 0;
> +}
> +
>  static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)  {
>  	struct rtase_ring *ring =3D &tp->tx_ring[idx]; @@ -1014,6 +1076,228
> @@ static int rtase_close(struct net_device *dev)
>  	return 0;
>  }
>=20
> +static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
> +			     const struct sk_buff *skb)
> +{
> +	return (skb_vlan_tag_present(skb)) ?
> +		(RTASE_TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) :
> 0x00; }
> +
               Vlan protocol can be either 0x8100 or 0x88A8, how does hardw=
are know which header to insert?
Thanks,
Hariprasad k

> +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device
> +*dev) {
> +	u32 csum_cmd =3D 0;
> +	u8 ip_protocol;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		csum_cmd =3D RTASE_TX_IPCS_C;
> +		ip_protocol =3D ip_hdr(skb)->protocol;
> +		break;
> +
> +	case htons(ETH_P_IPV6):
> +		csum_cmd =3D RTASE_TX_IPV6F_C;
> +		ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> +		break;
> +
> +	default:
> +		ip_protocol =3D IPPROTO_RAW;
> +		break;
> +	}
> +
> +	if (ip_protocol =3D=3D IPPROTO_TCP)
> +		csum_cmd |=3D RTASE_TX_TCPCS_C;
> +	else if (ip_protocol =3D=3D IPPROTO_UDP)
> +		csum_cmd |=3D RTASE_TX_UDPCS_C;
> +
> +	csum_cmd |=3D u32_encode_bits(skb_transport_offset(skb),
> +				    RTASE_TCPHO_MASK);
> +
> +	return csum_cmd;
> +}
> +
> +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb=
,
> +			    u32 opts1, u32 opts2)
> +{
> +	const struct skb_shared_info *info =3D skb_shinfo(skb);
> +	const struct rtase_private *tp =3D ring->ivec->tp;
> +	const u8 nr_frags =3D info->nr_frags;
> +	struct rtase_tx_desc *txd =3D NULL;
> +	u32 cur_frag, entry;
> +
> +	entry =3D ring->cur_idx;
> +	for (cur_frag =3D 0; cur_frag < nr_frags; cur_frag++) {
> +		const skb_frag_t *frag =3D &info->frags[cur_frag];
> +		dma_addr_t mapping;
> +		u32 status, len;
> +		void *addr;
> +
> +		entry =3D (entry + 1) % RTASE_NUM_DESC;
> +
> +		txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry;
> +		len =3D skb_frag_size(frag);
> +		addr =3D skb_frag_address(frag);
> +		mapping =3D dma_map_single(&tp->pdev->dev, addr, len,
> +					 DMA_TO_DEVICE);
> +
> +		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping)))
> {
> +			if (unlikely(net_ratelimit()))
> +				netdev_err(tp->dev,
> +					   "Failed to map TX fragments
> DMA!\n");
> +
> +			goto err_out;
> +		}
> +
> +		if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> +			status =3D (opts1 | len | RTASE_RING_END);
> +		else
> +			status =3D opts1 | len;
> +
> +		if (cur_frag =3D=3D (nr_frags - 1)) {
> +			ring->skbuff[entry] =3D skb;
> +			status |=3D RTASE_TX_LAST_FRAG;
> +		}
> +
> +		ring->mis.len[entry] =3D len;
> +		txd->addr =3D cpu_to_le64(mapping);
> +		txd->opts2 =3D cpu_to_le32(opts2);
> +
> +		/* make sure the operating fields have been updated */
> +		dma_wmb();
> +		txd->opts1 =3D cpu_to_le32(status);
> +	}
> +
> +	return cur_frag;
> +
> +err_out:
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> +	return -EIO;
> +}
> +
> +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	u32 q_idx, entry, len, opts1, opts2;
> +	struct netdev_queue *tx_queue;
> +	bool stop_queue, door_bell;
> +	u32 mss =3D shinfo->gso_size;
> +	struct rtase_tx_desc *txd;
> +	struct rtase_ring *ring;
> +	dma_addr_t mapping;
> +	int frags;
> +
> +	/* multiqueues */
> +	q_idx =3D skb_get_queue_mapping(skb);
> +	ring =3D &tp->tx_ring[q_idx];
> +	tx_queue =3D netdev_get_tx_queue(dev, q_idx);
> +
> +	if (unlikely(!rtase_tx_avail(ring))) {
> +		if (net_ratelimit())
> +			netdev_err(dev, "BUG! Tx Ring full when queue
> awake!\n");
> +		goto err_stop;
> +	}
> +
> +	entry =3D ring->cur_idx % RTASE_NUM_DESC;
> +	txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry;
> +
> +	opts1 =3D RTASE_DESC_OWN;
> +	opts2 =3D rtase_tx_vlan_tag(tp, skb);
> +
> +	/* tcp segmentation offload (or tcp large send) */
> +	if (mss) {
> +		if (shinfo->gso_type & SKB_GSO_TCPV4) {
> +			opts1 |=3D RTASE_GIANT_SEND_V4;
> +		} else if (shinfo->gso_type & SKB_GSO_TCPV6) {
> +			if (skb_cow_head(skb, 0))
> +				goto err_dma_0;
> +
> +			tcp_v6_gso_csum_prep(skb);
> +			opts1 |=3D RTASE_GIANT_SEND_V6;
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
> +
> +		opts1 |=3D u32_encode_bits(skb_transport_offset(skb),
> +					 RTASE_TCPHO_MASK);
> +		opts2 |=3D u32_encode_bits(mss, RTASE_MSS_MASK);
> +	} else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		opts2 |=3D rtase_tx_csum(skb, dev);
> +	}
> +
> +	frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
> +	if (unlikely(frags < 0))
> +		goto err_dma_0;
> +
> +	if (frags) {
> +		len =3D skb_headlen(skb);
> +		opts1 |=3D RTASE_TX_FIRST_FRAG;
> +	} else {
> +		len =3D skb->len;
> +		ring->skbuff[entry] =3D skb;
> +		opts1 |=3D RTASE_TX_FIRST_FRAG | RTASE_TX_LAST_FRAG;
> +	}
> +
> +	if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> +		opts1 |=3D (len | RTASE_RING_END);
> +	else
> +		opts1 |=3D len;
> +
> +	mapping =3D dma_map_single(&tp->pdev->dev, skb->data, len,
> +				 DMA_TO_DEVICE);
> +
> +	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> +		if (unlikely(net_ratelimit()))
> +			netdev_err(dev, "Failed to map TX DMA!\n");
> +
> +		goto err_dma_1;
> +	}
> +
> +	ring->mis.len[entry] =3D len;
> +	txd->addr =3D cpu_to_le64(mapping);
> +	txd->opts2 =3D cpu_to_le32(opts2);
> +	txd->opts1 =3D cpu_to_le32(opts1 & ~RTASE_DESC_OWN);
> +
> +	/* make sure the operating fields have been updated */
> +	dma_wmb();
> +
> +	door_bell =3D __netdev_tx_sent_queue(tx_queue, skb->len,
> +					   netdev_xmit_more());
> +
> +	txd->opts1 =3D cpu_to_le32(opts1);
> +
> +	skb_tx_timestamp(skb);
> +
> +	/* tx needs to see descriptor changes before updated cur_idx */
> +	smp_wmb();
> +
> +	WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
> +
> +	stop_queue =3D !netif_subqueue_maybe_stop(dev, ring->index,
> +						rtase_tx_avail(ring),
> +						RTASE_TX_STOP_THRS,
> +						RTASE_TX_START_THRS);
> +
> +	if (door_bell || stop_queue)
> +		rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> +
> +	return NETDEV_TX_OK;
> +
> +err_dma_1:
> +	ring->skbuff[entry] =3D NULL;
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> +
> +err_dma_0:
> +	dev->stats.tx_dropped++;
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +
> +err_stop:
> +	netif_stop_queue(dev);
> +	dev->stats.tx_dropped++;
> +	return NETDEV_TX_BUSY;
> +}
> +
>  static void rtase_enable_eem_write(const struct rtase_private *tp)  {
>  	u8 val;
> @@ -1065,6 +1349,7 @@ static void rtase_netpoll(struct net_device *dev)
> static const struct net_device_ops rtase_netdev_ops =3D {
>  	.ndo_open =3D rtase_open,
>  	.ndo_stop =3D rtase_close,
> +	.ndo_start_xmit =3D rtase_start_xmit,
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	.ndo_poll_controller =3D rtase_netpoll,
>  #endif
> --
> 2.34.1
>=20


