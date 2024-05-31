Return-Path: <netdev+bounces-99733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F738D6255
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF01F258F1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CE1581FB;
	Fri, 31 May 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tAtqJ9Eg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42D158A26
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160673; cv=fail; b=mW4z1KPeEfDmXgR6T9nRPIOJVTgnnL/1KEmwZSfZWukwR6Dx3QvG0NF+KibBvJZ2pt5kj+2uX/SOmRsg1QeieZFijo1v3XtiOf1ypQMAP6tiFZubhw4jRsOXtW3GvtU11vs6pjms4uyYI63B6pEUe3/Bsd83r8JbhP2O5xa4/tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160673; c=relaxed/simple;
	bh=f+z2Fd0PbNpvXovltD2I3895Rxr+CjsCEeupA1pAdD4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oitJRMc+Ph5+mpQ1zx68J0fmVcWvyC2WXQSSKB4T+s7rUHN3HkoHJeI1kTiL9lXLnMpk3AbpXpjfQSgJDpfJxzfcqaEIEYgBRBHvExiFuMro/sO6R32TeCV0m0GUrXl98W1Emmdwyccx5p+OCU4H2krWmWYBB0nPytPzHNwrlB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tAtqJ9Eg; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V1RYPB002651;
	Fri, 31 May 2024 06:03:55 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn6abd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 06:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYiauIe8ViX7+0Rg+qLTIsKWokB6FNojXx7158RAEzNOS0TL9n92EeuKJbKDhddsVSgkxPKO7Grlfu/WgiW6YlTv4Yetxmiig93ZdP5p7LS+eiRFRFRSkMEqGqiQFnzT/+ki1jFSrA25oFXACNpfl7Cw49k0obZzhblN4dz2gIkwY0/Dqpn/3At2OICgV+SQT2g1yKAUs8WL4zV0c5upTq5N0CC+ymFJ1DfsI8sT2EYHYxOcCMeOWxFBL9biaKCqH1qi2kqs3pQjNBJPnCzs1s8jNebQ8A9SGIlR5fh6xjcICoRDObO8GArT4jQRKUxwywNROC8jHvdWWxAa0UFWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oyc9RTabIwzq3/d2OLpzT8eNj3RdupaJIjxlAsnryY=;
 b=FD0fOIigAA6qS7CeKHVuS0yfFHTJf2YT4xpcmI16EoU836wqlNQdYx7iSN8+TQJVFcftuF+kr0uB1g0omSwx8sildyd46kGLBCKUvhd02fqMENKpxUubfgBF56/TJw2V+/W82o+6tfj7rND9D/MHqp/Tv7hDMtUf18CuVx5i9uZG56CHG1Tuazu+IADHZp6GpxQ832Mzj9qyWks+78pIgHLz4sZflzFPfq7OieASxhZIeY3Ua2MtZAcZ3UvB7bUUyvVxwaVOinWh8ywA3vw0JOTfncEq0UFZUsK4nb+C+Xp0l2vc4Ex5pkCn491uQn7GuBa2NC4vKujZjSnr6tcH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oyc9RTabIwzq3/d2OLpzT8eNj3RdupaJIjxlAsnryY=;
 b=tAtqJ9EgPFIozuXlXb6k/zQcfAGmoOuPtsndaVhriZwFnhbgYXXGN/VuTFjFeOMpRRq1Q0mUP1cwtfkAnYjgOQtgnQBvcTgC2MlER7PDWeYw6eXJdg4t6bxMP3F9o8m3L3t4GtWf5gCBn0Sim7Gvvot3CdG3emugjfWpJqqhAlQ=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by MW5PR18MB5176.namprd18.prod.outlook.com (2603:10b6:303:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 13:03:45 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 13:03:45 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Matthias Stocker <mstocker@barracuda.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "doshir@vmware.com" <doshir@vmware.com>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2] vmxnet3: disable rx data ring on dma
 allocation failure
Thread-Topic: [EXTERNAL] [PATCH v2] vmxnet3: disable rx data ring on dma
 allocation failure
Thread-Index: AQHas0aQaUv8laD98kybn8NNJ+euP7GxTwpQ
Date: Fri, 31 May 2024 13:03:45 +0000
Message-ID: 
 <CO1PR18MB4666CE7C4345174FD71A16A0A1FC2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240531103711.101961-1-mstocker@barracuda.com>
In-Reply-To: <20240531103711.101961-1-mstocker@barracuda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|MW5PR18MB5176:EE_
x-ms-office365-filtering-correlation-id: 3132b0f1-92af-4a82-426c-08dc81721a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IDvYdoAokrqes4SYOqMUWm7bmZxEKag71AoKAwCCYmN6wV/OA7H0SMNwqPPD?=
 =?us-ascii?Q?K5rdI3FjSUkl8hj3riR0yJSz5tdrlVfK6BAReY0FDVazXGttWaLz6NqKX71W?=
 =?us-ascii?Q?RFb5IPYKbNt8ghHkBDpbBznf6/nx4Nh56kCz3FmbsCLKp+IT9uEWghiJVxOZ?=
 =?us-ascii?Q?RxKWTxAn00ZX+EehW9GaQGiX+hjUJCIhDCFmmIXxPIvfTZ6dugOMkP/JWkks?=
 =?us-ascii?Q?V5vN2nlC923WSHxEF6nGetWYi81Z7lUxv7yVQ4umab4EMthHMo7z8xcfFxiL?=
 =?us-ascii?Q?hOK7Y5qg2utvopFPdT0x+7DsINaV/5THVUX0QrS4a45WdLC3O9idqsw6zNpb?=
 =?us-ascii?Q?j6RWlxKbNAUkgnPBp8ZYzfW5L10kSk6N1TJpASOZ51iVIfiPjwocm9ZVEepy?=
 =?us-ascii?Q?SBmTKv3IZfR0fcBYzWlc/08WcsZQuwb9lQPR0E2PB10F8tnnbN9EzU90MaQC?=
 =?us-ascii?Q?QZ4avlGQRTTPisPeTlnH6qA81WIdBdOqN7JIrzELeoi5Nq4pA6VPisSK+Nkr?=
 =?us-ascii?Q?Kchj7W3t7o4f3OA/l1JyrbVsjCe1KFS/z+Tunvd6onMrPz4vAKrR+iqbltRo?=
 =?us-ascii?Q?DdnFA8f7J6TmVjA1hyVYkW3e03Qe25dwMMASciEse+0sOY4bJndhqdPhaGPy?=
 =?us-ascii?Q?RsLUXuYoha8dXaMwttcR0DOMfhcgSnXv1PMYe9M+TFl8YA2kOD3sNLmFZVXz?=
 =?us-ascii?Q?cMqbRurWOESQJLP4skQ28fjg1TkDAo9Zw1FPf1Sfwqkw+97Gn8NXZFaAmN5Z?=
 =?us-ascii?Q?B5D5aBjJTpE0+YViCcVOLCByQHv9jPTYYm6F08AQkv6okq/A2G4g3WhKjEw/?=
 =?us-ascii?Q?Pb6TuRWRiqXUYO4lfY7tme71zfK5YKYFHRIVcFO8JHjbCAN7mdqtmQYHRFqR?=
 =?us-ascii?Q?JMsRQA0t5n/ajF87UriPsLrWk5WuUY8JRV2p0K3W0ejbTRLLQCp2vdwMtJiI?=
 =?us-ascii?Q?cGOlr9WYHv0xzx7Wyyc1Y9pattlnx3Fxc0lShZrnWqRcTsTYo5PThQcVbCLg?=
 =?us-ascii?Q?djFJbc8euTNRxGGuxaXKusgfKcRIWkwc7tcLdWYPGc7vylo8LOSMpc3AudlS?=
 =?us-ascii?Q?p8WQXLJ7JArwg2qP0bZ5Xdt2tCCFhsP/lRgV3RmHUnLtMGW4jw+Yl6Re9Vod?=
 =?us-ascii?Q?IcFkF4pnNyYUAcfdib9fJqr94WfJZjwZ6g5IdK1A//w3zkzRT9beix7Jz6m7?=
 =?us-ascii?Q?qK7oHIdfQ2s8DsRhRaj1/bdZBJenmAImxd9My13rSo9PqjmzR47xVdDQ1WCi?=
 =?us-ascii?Q?CYNRoPbX47VYKWcPF8AGUyD0EyG7kk8rUA0XbI5JndVDWukpaHFY9xeG6e/i?=
 =?us-ascii?Q?cuMZiSwCOqOlayCFt0Xmef9T/PI1zePDJK2TSHk7oaeJmA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A4zDO4BbIYg1E2G2QSN/cEx1abIVyXZqpHvRP4piW10uPNpNL9XZnVv2Oenp?=
 =?us-ascii?Q?gn08h0BZb2fEGBf760xPvOBppCLF3ZfmccPUjIbEZRTin9Uus66u0y9Ywg4y?=
 =?us-ascii?Q?5p2Xp++JNcjeYIcC5Bc/lbflnVC2dlnbb5P9QbLDO7mo0oFvMsh0w2WKewyH?=
 =?us-ascii?Q?/Sw5Wp+CP8R5Q5fma3oNR5Pe2gh9avdiRu47QDimyGV54MZlYXkBB5ed+49E?=
 =?us-ascii?Q?EBgXjyrbzHSaeM344LlvLDJJJXrPQfZv6qY5+JR/CoJbrRmMtW5nUpmspLjt?=
 =?us-ascii?Q?ovr5c9W5eMZtAwPT8a9gVSyH/TUI2lOeXqmhCSOWcjlipynmmMSE4Ea+Alsi?=
 =?us-ascii?Q?UOY2d8ORAPSFq/jja344MTo2T312dW/qWsLlJiY5PYsq6dm+eugsEryfM7qk?=
 =?us-ascii?Q?mTeQ3CV7fmKBTiVVFRbF73lXcrX0+jKrcvh9BLWzHC0LDFNZC2KQdjXN5BPu?=
 =?us-ascii?Q?T/KRnYh/6TsAbnto0soVAc1+mqGiGvehy0abXvxhBDQuF8M61FIlJMADxAuv?=
 =?us-ascii?Q?rns5Dfs+7HXShn0S94O04XiJgxddrtWav23CLiHuq/EzFvNKMafGFpf8oDG1?=
 =?us-ascii?Q?FSg2hbteRDD17KRWPujq0AvhrWCcK45oZW5Mawfvf7R3/JMu78NzcE/y0t84?=
 =?us-ascii?Q?+R0YvUobRJ0ETyh7bptuC4VncSq4V3s3IzxVbeSeL/3A6jPRnlNORDn5tqf/?=
 =?us-ascii?Q?b8SFRTbxjUCvH6VgO0lr5woQDvlDz+Ko6vju4eg3vKTZIcdKQwn/mcaOCBCM?=
 =?us-ascii?Q?u1hD3X0Kq61Z6Z9yzlOpCK+9nkHSe8XzrsipICGX78N54uHyzMpqw8Rspr/9?=
 =?us-ascii?Q?9HTrJ3KtvkPkVO3PR2XMne1nwvNnWXc+Y0xa8kYeRPrkgbIOrUMtaqVZCKHt?=
 =?us-ascii?Q?Ty3ibQDql3vzhS0JvY7CeDKbv2WJhsa7dwyMUvI7DckHPJWxPurBn07sl/cK?=
 =?us-ascii?Q?lLkeYuNeN68gyEOMrFqT6+yDNV8eC0IAJyDy0EBISC7heOLsxVHucSdZsXiZ?=
 =?us-ascii?Q?cMrFHBFJ28UWb2KRgGHq01RZL1TdgwEbKM+co4FCkYGqRXhHQB02A/A0SxGQ?=
 =?us-ascii?Q?ro6hlozll63BLvJ5JX7alz5rS3+nBsGaWHcu/xc1EdNoXVf6BVkfq09Xbdm5?=
 =?us-ascii?Q?tA9gvwYGFZHZ99/Iy46xtzghQdSXn4dJjAhWjal5yiK4CrqcrGu0JzzWpct5?=
 =?us-ascii?Q?P39v3Jphju/1S6abuoPl7SHouMko9r82aq3XRzniNRHxrFnhFLfPvHdtOQ8G?=
 =?us-ascii?Q?D8gCDUlYbcJZSxoH9ftl6+oSDTkDPqng0ERxRTGu4bX5Zj4aMgvCMon/RUFZ?=
 =?us-ascii?Q?ZkEopGNNbXI6s4h9JBrsFWWSbZeado3mw4xgM/z8ZxJaIszyjpEy9Zw6cZCa?=
 =?us-ascii?Q?aDbAjX9tQoVEQJQACHWm5i/F+T+0lU+r2edrJISR/MrvYEcCyW0RJXfTFXsm?=
 =?us-ascii?Q?ez6tzmDyQkSgVdY5DyTJLMTsSNLCQFmJh41eyrC/MlA7icIH7s8GcPIT++YT?=
 =?us-ascii?Q?ps8ooqOlsVBJRLZzOsIXmvd4ob4P+i7ZER3R+5EeRDrPHb0m4Fg7RzRkpySo?=
 =?us-ascii?Q?oKsPDZvcA7hbFvp9o94=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3132b0f1-92af-4a82-426c-08dc81721a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 13:03:45.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjnsB1WenOUu2mABVpsCY0lmECeEW3kWs9F24TBJbStAwbHexjPlDTOJrAIdK8mfMhAwcJqnOTgZbDUyLCw1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5176
X-Proofpoint-ORIG-GUID: lYyLQZBAbDIT9Dsw0L0Jhzi2OOHWS539
X-Proofpoint-GUID: lYyLQZBAbDIT9Dsw0L0Jhzi2OOHWS539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01

Hi,

>-----Original Message-----
>From: Matthias Stocker <mstocker@barracuda.com>
>Sent: Friday, May 31, 2024 4:07 PM
>To: kuba@kernel.org; doshir@vmware.com; pv-drivers@vmware.com;
>netdev@vger.kernel.org
>Cc: Matthias Stocker <mstocker@barracuda.com>
>Subject: [EXTERNAL] [PATCH v2] vmxnet3: disable rx data ring on dma alloca=
tion
>failure
>
>When vmxnet3_rq_create() fails to allocate memory for rq->data_ring.base,
>the subsequent call to vmxnet3_rq_destroy_all_rxdataring does not reset
>rq->data_ring.desc_size for the data ring that failed, which presumably
>causes the hypervisor to reference it on packet reception.
>
>To fix this bug, rq->data_ring.desc_size needs to be set to 0 to tell
>the hypervisor to disable this feature.
>
>[   95.436876] kernel BUG at net/core/skbuff.c:207!
>[   95.439074] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>[   95.440411] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.9.3-dirty #1
>[   95.441558] Hardware name: VMware, Inc. VMware Virtual
>Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
>[   95.443481] RIP: 0010:skb_panic+0x4d/0x4f
>[   95.444404] Code: 4f 70 50 8b 87 c0 00 00 00 50 8b 87 bc 00 00 00 50
>ff b7 d0 00 00 00 4c 8b 8f c8 00 00 00 48 c7 c7 68 e8 be 9f e8 63 58 f9
>ff <0f> 0b 48 8b 14 24 48 c7 c1 d0 73 65 9f e8 a1 ff ff ff 48 8b 14 24
>[   95.447684] RSP: 0018:ffffa13340274dd0 EFLAGS: 00010246
>[   95.448762] RAX: 0000000000000089 RBX: ffff8fbbc72b02d0 RCX:
>000000000000083f
>[   95.450148] RDX: 0000000000000000 RSI: 00000000000000f6 RDI:
>000000000000083f
>[   95.451520] RBP: 000000000000002d R08: 0000000000000000 R09:
>ffffa13340274c60
>[   95.452886] R10: ffffffffa04ed468 R11: 0000000000000002 R12:
>0000000000000000
>[   95.454293] R13: ffff8fbbdab3c2d0 R14: ffff8fbbdbd829e0 R15:
>ffff8fbbdbd809e0
>[   95.455682] FS:  0000000000000000(0000) GS:ffff8fbeefd80000(0000)
>knlGS:0000000000000000
>[   95.457178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   95.458340] CR2: 00007fd0d1f650c8 CR3: 0000000115f28000 CR4:
>00000000000406f0
>[   95.459791] Call Trace:
>[   95.460515]  <IRQ>
>[   95.461180]  ? __die_body.cold+0x19/0x27
>[   95.462150]  ? die+0x2e/0x50
>[   95.462976]  ? do_trap+0xca/0x110
>[   95.463973]  ? do_error_trap+0x6a/0x90
>[   95.464966]  ? skb_panic+0x4d/0x4f
>[   95.465901]  ? exc_invalid_op+0x50/0x70
>[   95.466849]  ? skb_panic+0x4d/0x4f
>[   95.467718]  ? asm_exc_invalid_op+0x1a/0x20
>[   95.468758]  ? skb_panic+0x4d/0x4f
>[   95.469655]  skb_put.cold+0x10/0x10
>[   95.470573]  vmxnet3_rq_rx_complete+0x862/0x11e0 [vmxnet3]
>[   95.471853]  vmxnet3_poll_rx_only+0x36/0xb0 [vmxnet3]
>[   95.473185]  __napi_poll+0x2b/0x160
>[   95.474145]  net_rx_action+0x2c6/0x3b0
>[   95.475115]  handle_softirqs+0xe7/0x2a0
>[   95.476122]  __irq_exit_rcu+0x97/0xb0
>[   95.477109]  common_interrupt+0x85/0xa0
>[   95.478102]  </IRQ>
>[   95.478846]  <TASK>
>[   95.479603]  asm_common_interrupt+0x26/0x40
>[   95.480657] RIP: 0010:pv_native_safe_halt+0xf/0x20
>[   95.481801] Code: 22 d7 e9 54 87 01 00 0f 1f 40 00 90 90 90 90 90 90 90=
 90 90
>90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 93 ba 3b 00 fb f4 <e9> 2c =
87 01 00
>66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
>[   95.485563] RSP: 0018:ffffa133400ffe58 EFLAGS: 00000246
>[   95.486882] RAX: 0000000000004000 RBX: ffff8fbbc1d14064 RCX:
>0000000000000000
>[   95.488477] RDX: ffff8fbeefd80000 RSI: ffff8fbbc1d14000 RDI:
>0000000000000001
>[   95.490067] RBP: ffff8fbbc1d14064 R08: ffffffffa0652260 R09:
>00000000000010d3
>[   95.491683] R10: 0000000000000018 R11: ffff8fbeefdb4764 R12:
>ffffffffa0652260
>[   95.493389] R13: ffffffffa06522e0 R14: 0000000000000001 R15:
>0000000000000000
>[   95.495035]  acpi_safe_halt+0x14/0x20
>[   95.496127]  acpi_idle_do_entry+0x2f/0x50
>[   95.497221]  acpi_idle_enter+0x7f/0xd0
>[   95.498272]  cpuidle_enter_state+0x81/0x420
>[   95.499375]  cpuidle_enter+0x2d/0x40
>[   95.500400]  do_idle+0x1e5/0x240
>[   95.501385]  cpu_startup_entry+0x29/0x30
>[   95.502422]  start_secondary+0x11c/0x140
>[   95.503454]  common_startup_64+0x13e/0x141
>[   95.504466]  </TASK>
>[   95.505197] Modules linked in: nft_fib_inet nft_fib_ipv4
>nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
>nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
>nf_defrag_ipv4 rfkill ip_set nf_tables vsock_loopback
>vmw_vsock_virtio_transport_common qrtr vmw_vsock_vmci_transport vsock
>sunrpc binfmt_misc pktcdvd vmw_balloon pcspkr vmw_vmci i2c_piix4 joydev
>loop dm_multipath nfnetlink zram crct10dif_pclmul crc32_pclmul vmwgfx
>crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel
>sha512_ssse3 sha256_ssse3 vmxnet3 sha1_ssse3 drm_ttm_helper vmw_pvscsi
>ttm ata_generic pata_acpi serio_raw scsi_dh_rdac scsi_dh_emc
>scsi_dh_alua ip6_tables ip_tables fuse
>[   95.516536] ---[ end trace 0000000000000000 ]---
>
>Fixes: 6f4833383e85 ("net: vmxnet3: Fix NULL pointer dereference in
>vmxnet3_rq_rx_complete()")
>Signed-off-by: Matthias Stocker <mstocker@barracuda.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
>---
> drivers/net/vmxnet3/vmxnet3_drv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c
>b/drivers/net/vmxnet3/vmxnet3_drv.c
>index 0578864792b6..beebe09eb88f 100644
>--- a/drivers/net/vmxnet3/vmxnet3_drv.c
>+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
>@@ -2034,8 +2034,8 @@ vmxnet3_rq_destroy_all_rxdataring(struct
>vmxnet3_adapter *adapter)
> 					  rq->data_ring.base,
> 					  rq->data_ring.basePA);
> 			rq->data_ring.base =3D NULL;
>-			rq->data_ring.desc_size =3D 0;
> 		}
>+		rq->data_ring.desc_size =3D 0;
> 	}
> }
>
>--
>2.45.1
>


