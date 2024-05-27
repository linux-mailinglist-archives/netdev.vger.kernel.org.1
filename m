Return-Path: <netdev+bounces-98170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DAD8CFE3E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E45284108
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87113B2B3;
	Mon, 27 May 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UmPxFTMr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDD13AA3F;
	Mon, 27 May 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806486; cv=fail; b=Tkpz5sfLEmKB0U4BjcoSnR9Ioar52XVW/aZC9WM5anYijT3bvwkmqL6Y+o6tnf0AcsDw1q0H8+Qbkoz8sxbAu51u59mowHZKg6B1ywr1/ap0dYqybvoOQYAuwjjPfQFjiP4jnGOm5uOS1U3CJBiwWs4nWpCVcIZE/Yt49XPbUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806486; c=relaxed/simple;
	bh=c3P7/bFFO6Eox7PY9hdJAVF7DPt/8HvCXfzm55yWAmc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbH/McpIgi/P9SJWFtBl5mZIy9D8mD7xptVYMZZA1+UlWZ8u7BQwYBWK5pMZdXlWH7kTVy1wslwODPDulxKuRk8G46dnscZvs2m+5W38SkLB7VITct0GXfpwubKzJDYqFvqJuQCF1wiI9qQ8hnCnDk0ZcseWBEiqSS880jCubWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UmPxFTMr; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R9bf85010731;
	Mon, 27 May 2024 03:40:54 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpyg5he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 03:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT6xbDumXXTjgHzwaeyXbV4NyHG5V2F8DOS++vuqNsNgNxzIZWWEBZaU5HGBKmFuOUsdTSrMiG2uT1mnecK2ud5OJj7EMVw30O3tTlGFfGTl6q8+REv3s0vMBwOy8/rtV1/2RlIxnoQOg5s1DL5VJi0QQtDIF4B2HfpvBk0zNmvUmjUVPMcFrUDJaQxyTfHl3ByoAoWPxzrnYj2xQT2frJ+MznBpfrO1sEpLgANGgwo/wjVqoH0eeMr592XZw498yKKwnqKO9Or3WRfVwQK4+aSXOuvlBOJaNsPkzsenMKPJPIySOJIAnrxjyfvWzlX42GPy97mm/555kXiYmRPxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3P7/bFFO6Eox7PY9hdJAVF7DPt/8HvCXfzm55yWAmc=;
 b=aJo4eGmuwnAleqRI99rK2aOtLLD7W/CCoYFYygtmvwYgI58TYCBzjY5a2Cm2HFZeYOaBPgK02yuLplzo2Qoa7cJmgL8kst56SAdjCDgz3lg+SiLHBA3kv7hgCzu2c0xbF6N5Kho+JbmvXH9JJXQnrBS2SsuNW/1Z9jTWgDV4RHb/I1QWg3r+McYyS2mfcLUDLfETWfmTfNBqupERQZtXWadDXg6vStxMLCCncWCbcVXSr56Q7MFZrxutZxRy3DxZW0jFlSFluORZVvKGtrVjCVqxMTVvMKYo+y00DkgGSat6RUOg6uZ+/Wkm3g4aoxX3mRm51pxzXPHN6H2W4Yi29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3P7/bFFO6Eox7PY9hdJAVF7DPt/8HvCXfzm55yWAmc=;
 b=UmPxFTMrBvKEGI27GiihmhSOSi9IymNwg6N8fVLsndN1gx86GcuvT/6qu/KoPK7+uUcUXgdeChrlhI1UAJUfPugRwbI09Qh8fdlPWRfyXuudm782dXWnOp8Um14uXxioK1A4OdM+mXP4JnSTc0TGnZjna/0QMf1AlXrlBPPnGXM=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH0PR18MB3911.namprd18.prod.outlook.com (2603:10b6:510:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:40:50 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:40:50 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Boon Khai Ng <boon.khai.ng@intel.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        G
 Thomas Rohan <rohan.g.thomas@intel.com>,
        Looi Hong Aun
	<hong.aun.looi@intel.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkWheaSobs03U+dZKCIDRr6V7Gq42wg
Date: Mon, 27 May 2024 10:40:50 +0000
Message-ID: 
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
In-Reply-To: <20240527093339.30883-2-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH0PR18MB3911:EE_
x-ms-office365-filtering-correlation-id: 9d49e519-36a3-4c8a-2820-08dc7e3979e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?H/FbupgfX0/UB9xG2Q+t8s/VVruEIyG7zXWyyU1O4DP38F4VWcs6sRfhGTrN?=
 =?us-ascii?Q?gckog69GllhjL/uCnaHE/aaEp5PpMj7Ich6ZhFKJC+IDclPeMy2KlXryvSSy?=
 =?us-ascii?Q?PuTGfYRFuOKGh/VzT+cTNGfH0Ma5WPpg0egNvszkpoJxQ7VBpK/zTaCCb/1X?=
 =?us-ascii?Q?F6wL0FOqt2N/NXef9/8ppLrq257pu2Kki75MQe+HL43myri3uUsx473Yk5px?=
 =?us-ascii?Q?VbDpv9m90n1SERaVvThHv5yJ3jMeF3OynCyoL0gGKj9JcbcOjoQqRrFG3Tsy?=
 =?us-ascii?Q?0Ze0hp+0c0lgkvp8jzuE0tVg7fIPZ1UFZ4+3Vxv0wseQRe+6AI8ATWJzG0NT?=
 =?us-ascii?Q?HwwE/BAr+MJJGeuGUG8AFqqpImGMIJbd7goECkTdzMRPLDsrTLJ0/MWnuI+t?=
 =?us-ascii?Q?7ItekRdPBIQKS31J67O8QvxpSNl7dvLtgIndmxDBz6mXqKvlvaESVJSIYSXs?=
 =?us-ascii?Q?6Egj5iMsuQpLg4GWrwtxeCmhz3jBfkNZlcGngo5/SmNZvAZyEQubiwPkdlrO?=
 =?us-ascii?Q?J/I4nUwSD84uELDg8MV+n1kuZSvh9aqcbcizSMnRNmf5cRMbo0EHzUvKjope?=
 =?us-ascii?Q?A+3HYKd7k1Q0G0ahSqZnIxA3Dt8apXJkFLerJghjKHyhtsTGT++xYU6+Cr39?=
 =?us-ascii?Q?ZvP5ntUo2+pzchM5ZmW+q3eeIRpAlGbFCozrNUoWj8D5R4jy6tn2nC4aMd7W?=
 =?us-ascii?Q?AMObG43wlT4R7eiA1mklKCvCFjTuCMn+7dOD8o5q3OfstkuuhIC9O6mnaqRL?=
 =?us-ascii?Q?L/Ag+LbpFgHAtwY65Lbwlh2pOm+ZRkGRPdwgOGymN4ZiAIy0fe9XjAhD0mgQ?=
 =?us-ascii?Q?y554Glx6TtvYIS7lfDKl/a8z9r2vaP4V0w1ejcs49yusTBSY4cHjkC8w7wqI?=
 =?us-ascii?Q?AGMyrRufSh11ihpKWkwK8/mVFPChSJQP/rLuEzSq94hHvrOV9teQgC/oeysx?=
 =?us-ascii?Q?Wdk7aGfUvOhQ+J0AMIzLNFsOrI6y3OZzatz4pNPmkisur07GDnv75OYWDEKb?=
 =?us-ascii?Q?8f2VtUw9zCtEJr5ZTrXNYaijsMKNlBQ+F77+zi7Y7AAP5RoQVunacn9uJAKK?=
 =?us-ascii?Q?AXWbXdAyXWuWM3ZlVnMemEVFI2JNBpbksvHSdf0dsdmI/7wYT3cLpeAVzp8T?=
 =?us-ascii?Q?DXoj31p1bAnHMH1knHP+snX1oBelqmmikUBLKftIXgxptq9TkZ8018T3oKxB?=
 =?us-ascii?Q?tynnIZNXH0fAzQ0z3sQJo6p0esFNUDVUuAssuVTe7rjpp1KOrhZD4DzVIy1E?=
 =?us-ascii?Q?xjvDjS00hfmO7iY+UViIdKp69PvYZabuxcIXgnadrngHROrBqIymrevPcag4?=
 =?us-ascii?Q?bdZ5RYPFV9ExTyXiSsVdYCEOmG4VUPwOmBVZ9WT4TGO5Tw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0itmvJN0z8IFXaN67eH9S66UwLEMhPSw8Fon8jrYlDWbSvmI/lNEOqrkDMUI?=
 =?us-ascii?Q?gk0q0+bVIWrPoNXi/LKpDbK81t3NMl9j+ZnQKBemXI2kHVyjeZZ4UzM72yGV?=
 =?us-ascii?Q?p54crEUNMGpM4dENYdHlQPIYpn16RzyLT0ee0tYMRhYlzPgJKtjvk/g2haXO?=
 =?us-ascii?Q?bGj+m61GVZoTmyqY4lvkGdNJkU4lJOC1kuMKZzUHqHvJmUn1u6vCaEtY1GrE?=
 =?us-ascii?Q?KhqQKbizomK3eT6BFwSPLMreyejJBHf9bWTk493fGmV9uFzx6z1O6RoMffZ4?=
 =?us-ascii?Q?X+UOUId6Kxsj/7gTx4xxnLCp9scOvmddHbAgO/c3m8VqmIfa3aZswDoKVMBs?=
 =?us-ascii?Q?8dILBO5mu/u8FJ97RDIyRt590gxCbTra1nnERUtM9aKMeMbCrzb3Ko6pjKiB?=
 =?us-ascii?Q?YtB4Gmj5+yL38I8kyrw7U2Oq+1MoR3f9kJSyzKng7RSYavgXxRhq7+ZbkS9x?=
 =?us-ascii?Q?itCpr3peSM3leUthapo6CgRsQSuTtgJ+uqEi+2NecBQ7V4ziODgsO5cmGWet?=
 =?us-ascii?Q?Nc+CKt/EWG1ZAPoOiFg17l7SagfX5vLdzrkZcD1syH57GCNhGuq/wChPnVMY?=
 =?us-ascii?Q?fTAPkK6xfom7l/9gP+udfXPJtHsaMAyN1h/IkbnlHp6cr5j0yyONNiyGQ1uL?=
 =?us-ascii?Q?mD1RDMlPJxdapQThOq+KnNeSmceXbBsivLXsewPR6ZQYisISr2xZuZ3v3fiN?=
 =?us-ascii?Q?rrBYK1SAarzX3iebDbkUej2a3QrYEtSYJIEUqxRISZlcjODXurE+d0zvYQnu?=
 =?us-ascii?Q?V/OgLVQs7AwYqm5WRauBDFIPS7Z1+KojwnsTcvcbRnZ/tjktbHpo1ZTrEOBP?=
 =?us-ascii?Q?pCHItd1sNs7b/xEIzE+p2gQbRkv8yjfd3md4B4ymG54NbsZEOTywalRxRxWL?=
 =?us-ascii?Q?sB/8XXPvqkZi3RxBPSM/R3Kd0Sch3ixzqC8aNsFlpFZAdkkoW5c0yiN20o9p?=
 =?us-ascii?Q?iS65l7jFA3jGfHfinGjcpOWoOXUVQXI7g4NLx2HfDUaE0ELumDg0qiMOLnDY?=
 =?us-ascii?Q?SHGmctkmNon/wUKMy+/ziksPUG26EOMY4CIgchtb4cPL5q3T4ozlXk2WsPFp?=
 =?us-ascii?Q?X2gDUlldwDR0QF04yLl607jRqacYXFSveDC4Ykvk75Wl3pbesP/gGtPcyByA?=
 =?us-ascii?Q?ZsFeT9BYaTLdwj0mPccVj0tU6GajqCB1gz7uJv7n9wbTqWtQ1Mm5jO45bJAw?=
 =?us-ascii?Q?9uaMlHNmoLfrnTv0LS7RZ0jy1c4e9rzl1sAK+bIJ2UInASorh/riy+n7a+0S?=
 =?us-ascii?Q?OmqZOlVqlVl7CdaDg2d7a6pS0CwVLvD+4j7QfGKnjrRReFS9khjDBbqYE9Ms?=
 =?us-ascii?Q?5gqJlkbp4/J27kakvKw5GEab9j4/mqhaLcFVx4vsKxdtgk1mbPWNRe3s4ra+?=
 =?us-ascii?Q?RJ0oKSfsPdwXToc24dvyUqWotpKF4uRDNF3PKrheibKRqzHuGGw8Z7ft/t54?=
 =?us-ascii?Q?pi/u7bQh+CUELddVOvflva/jVKFDSAh42jqJcpH9fDALelQL1fLvp6kOJ9To?=
 =?us-ascii?Q?/YoNpe4SbKV1JyRI2L0BygIGNljJxlpDvGanWwRkr3trJaVlLAmYzU05EPNL?=
 =?us-ascii?Q?Pp/CgfBKpiRClJQJafQmyg5aHoQzbAdd2EFMvuge?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d49e519-36a3-4c8a-2820-08dc7e3979e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:40:50.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/ggqFTnDfPsLUs+SkVQX5pgSNdvipxlayu+7XX51SYRQ9WzZjUfCU7nKuE0v18lMFK5m0j/QjLTYYTpQ5SEJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3911
X-Proofpoint-GUID: lR-iVj4H3YTwT07s0-4HIAkR0DMYptxj
X-Proofpoint-ORIG-GUID: lR-iVj4H3YTwT07s0-4HIAkR0DMYptxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01



> -----Original Message-----
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> Sent: Monday, May 27, 2024 3:04 PM
> To: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-
> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Tien Sung Ang <tien.sung.ang@intel.com>; G Thomas
> Rohan <rohan.g.thomas@intel.com>; Looi Hong Aun
> <hong.aun.looi@intel.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Cc: Boon Khai Ng <boon.khai.ng@intel.com>
> Subject: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
> 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> Stripping
>=20

New features should be submitted against 'net-next' instead of 'net'.
Also 'net-next' is currently closed.

Thanks,
Sunil.

