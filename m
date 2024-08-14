Return-Path: <netdev+bounces-118536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435DC951E65
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB73281191
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BA1B1436;
	Wed, 14 Aug 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CacciOpy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="THp4xp8b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD21B0137;
	Wed, 14 Aug 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648773; cv=fail; b=ImnFb4E/CFQPGHfDomdEPylApDmMwZsWiCznlFSfKOLApHWOkvacHfRNx0R0xZ6NKgWQhenVEliEolHEIDxcUfo7VFTmvPkIHdao9zFSHYGaEDPQp8rYqZ4xxcT/X3QJoTlR76f+1r6phvAUgqJBi3wh5MTe4w+uigfTdQ78HwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648773; c=relaxed/simple;
	bh=jkqxBl4wQMb5cC5oe4EjJ4P+h87zGuM+37x5AR9IiOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=oBOxym1TQy9JQMhu2zDvvelCXW+fyxkvTU+p81ZJaUwj8Ajmjnq34r00X9bU0k3bdGAMEExZi2JbvtLkApBo8hxNXJQYbbp4pOiILFIY6fg4FKJxuwHYHwZx3SCJNuUHUauqRKIvJ4G55hw6f940FA0tMaYak/un04AjEqSe8A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CacciOpy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=THp4xp8b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWmV015143;
	Wed, 14 Aug 2024 15:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=Gt5BATB4Nz08zy
	IwtSdC6S8yykdCaxEMU9BHQZS3dag=; b=CacciOpyihCFtH6uXRxDxXfu5oScTw
	zK3YBDK3WqJlULuulplLnE0AaVE73XjnP3cE1mpLCA8LdBxw80HqdIHTbaW9Ryad
	yyOyInBGdIQ997C8M8IIai9SPinCD6rAnnYMU8kxu9wr2k4/n0d6/85o5fQ0SOI/
	3TBWDMv2mmvp2SX2k4tsQx6+ORtpQKUlBHZtehpgJuSrnF0ib9o/hq86FfTiS5Yg
	vd6tszvDwieR8QnpCRV8bX675h2M1PxX70jF+A9XMaffMEbu+6AENhQh1K0WqKLn
	DuTBbo4neFQ4/x3+nER10zY7tt6DP9l7ZbSSe3C0LSDOusP9CBCUPo5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy030q1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 15:19:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EEPN50001390;
	Wed, 14 Aug 2024 15:19:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxna097a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 15:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miuoRriBSJPRzvIwz1CGwUea+CkTxfuYlq5opQKjcUteyHJKO+jxeqvsElMuLN5IFwUXJEqvlpeik0RpLzrJdy4bGYV/qvre/4VrCESfljgRAnCVMFiSFYTqdB6qLhz23leAQC7Qc/f0oAKKfPkIdF8Ws5tF2PSSyYPsjmfXXZtIHrndX7sjVQdzhuDNopJE65G5AV1f2VEAK9kKeU4S4AHZZgRCBkOQeO3fG80APAhs3iXO5w5UY21txBwEpwAgHznwbI8bmCeiiN3g+h/VVybYa+wUvIBz3hkOq94LxX520Mxoz5Zc+pYb48+i1bVG78TKkhBdrJpGJyWtr5TIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt5BATB4Nz08zyIwtSdC6S8yykdCaxEMU9BHQZS3dag=;
 b=kPnHrnvNA4x4yyCziewOe7fv9suKczS54adfRHzOYXlyzon+LZpCDFY+TZ7Nng2bdfAUtWvZSPp3VOkIF6xjId2v4BkGk+tbAKVVfzYuaK+jnUgSub+HxPkCm7fF8GUE5cIBWN5i49ECkyKoWVnmQbGCMaqEZ3yJjt0LwR3hHQF0AZ0udoAqdWsdWZQtR4aq6sFEYqKOylDQz7o8gzVHqBGMOn8lhPeyh09E1YvGhyDlUKtO9LvDrBnisgwkaNDReTE9AFLQJDR1Wt382UAvgOWB7vbrTmDmiTIXvsDs9gER79+daLfQVVZLMVrJw31j9oRSkRjZR9bZD1H9SO+ZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt5BATB4Nz08zyIwtSdC6S8yykdCaxEMU9BHQZS3dag=;
 b=THp4xp8bUBRPDuUrD628HzX9Qtc9WKNg5ZgPxf8CXp+UAGgRbVimGQkR3dylGFTUFvjrTNGaatnAXU5oCO0dkw1YTu7EDTe5mYRyPyuNaDeZ0Ht0tX7j/w50cyNDJ30ll9rbEuOuBr8dH7WrEnH0diXU+iLUFLtGxRH0WHCq2mI=
Received: from PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 15:19:11 +0000
Received: from PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990]) by PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990%6]) with mapi id 15.20.7875.015; Wed, 14 Aug 2024
 15:19:10 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang
 <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH RFC 1/3] Revert "virtio_net: rx remove premapped
 failover code"
In-Reply-To: <7774ac707743ad8ce3afeacbd4bee63ac96dd927.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
 <7774ac707743ad8ce3afeacbd4bee63ac96dd927.1723617902.git.mst@redhat.com>
Date: Wed, 14 Aug 2024 16:19:06 +0100
Message-ID: <m2y14zrv2t.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To PH8PR10MB6622.namprd10.prod.outlook.com
 (2603:10b6:510:222::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6622:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8d1cd6-b63b-462b-2fb9-08dcbc74726c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	SO4tPlBcto/48RNvb+t01HvI1knG6CvPyC6e7i+iybvAf1WsEXtntWuMI02KlwGk4+y+1BEDNGE5yqoenuYrZd1/lcD/Wv+oO2fpkWUax/A3IuAokSt3wW3X620RtKKP07VhKrsbp/EwbKljdAZyTc7hJ1p/+TX8cVliAsmpNPbRXJIMAyrfQYsbRjlWDLG6Lofbn0CUnqy5+tt2p1CoY+yP/FH+S7iY9Ft5JxjSMVItdl+dmIP7yHccy2zm1/HLFDVlR0fLTcVSXN0gK04P3DsRlrU/4cQbbIdbSc9HWDOXughVxp62ON0NA+ogX4ihhxmitGasjNace7o+cwFKnXNWszHOoVJ6ln3pi662h5SCj4Nkq5iuGqVNOjWfFL1iT3rPP4HCmhL13LBDKljhqbFAAqXFiZoPP2Qx2P+USii2jW5+WmrVSVAf4UIf/5GKpR8TYfuv+mRMQMkrNffaPPGZNu+hOSZASR/UdvVF6hIboNDYaydN1gDoHsVXYflPLH4l4fnKGWSx5AKAkJNbz4Y810B4ITE6xkXK+weOojjT9AJbrQ26citqLGz4h3IttN43aRrGUWIhb/cwJj3Z+0XYKx2luiuX5mKFKORdYwdIwJCcNw3QuZ3pfv2u1k280ZRaMWHObP9rMpASLAvDAYKx2xqX3CcxGpEnJ2N72xI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnVXGRz3szPNWDhvxa6cIpipqEVqnDw5JGAG0+b0ws14vwNdhtGVYqkO4VLa?=
 =?us-ascii?Q?ZTUreer1MkMlOHy2ZD+lZMLDIgPjWoV+l9yfy+COOGwvHsdhP581cYCZwF8s?=
 =?us-ascii?Q?curd9y2zXySyyhWqj4zbO1eL5q+SfSOiCqrjQnwe70tXQB06ixo+KR2IBcbP?=
 =?us-ascii?Q?LaCRiCjBD1FeRJeE7cklNh0nkFeHx3VreJdiXYhLP/lGQWlwCSNpFPUXJRGJ?=
 =?us-ascii?Q?J75cTpEOcjNTHFvLVZp1x2yNe0sSK0kMhJt8RWPbw1LZZUDQJAiP+Op0zM++?=
 =?us-ascii?Q?DZLtIJdyuyetvRgRGzNMCzFwtbevU+3yfsz2wUQ2wlygWe0HG2fJ5B5KR6GV?=
 =?us-ascii?Q?9gU03xeKTz5JCWMEch7h4pNs23md16GjxZYeKGnryBkVHfUIElrU8swoL+i9?=
 =?us-ascii?Q?yRHL7jZWJ5Y6F3obo3192n4AnRD75hjhTU6SD4B102YvAx8eV6fLZTRQSddh?=
 =?us-ascii?Q?aAd5qTXXTDX5UPTlDI4RqLZgjbozRNroNO0RibCJs96LXLnaTTeFfniMdS5H?=
 =?us-ascii?Q?rg7zn6zCKgGRdsvxdNQhqOzYPzDxqRiRBFTlFW/PzrYYMYXDR9ywJ+9XX7P3?=
 =?us-ascii?Q?SMtfMeQgw8wTVoAA2NSTZn3EjQXsxOoSqb2Y7nwrhC/nrrwh+XOSnwN3byHW?=
 =?us-ascii?Q?ylAZ3fMrytde1I1kmiaA09M3d1b3qEm6ubHMQ69U1qD32u2TSiR3OUQrkuMb?=
 =?us-ascii?Q?OBk0A49w0eEnMK6m90TRx5Rj2LiPkNtbw0lwOYuJmUtIan3kJ7tCaImjuZtK?=
 =?us-ascii?Q?il8HSjXUl7YtHa/7k/vFE9Eb4H5iFjjnTOH28r4Hgls1XmpfLtyxDTlvIQDm?=
 =?us-ascii?Q?sdKbx/+GMumamvPlTWKfYmbAMia4dD1Nd+AqaUEGsSYfVbwBtb//zjYt0ZoF?=
 =?us-ascii?Q?lSxlBMJzch3URLfcjEjNFc2xL4ZzNkXh/VGnnwBhXeyINU7XeJyilVO8osSi?=
 =?us-ascii?Q?6Rafi6FDUdOjZ/5ng6+ZFb9hLLwSQFtCSi/ETTk9ogjGmLzT9+18SyH+yGb1?=
 =?us-ascii?Q?8Ay2He7WBZSfahMmJTTuqdQR6vuxBl3E3qqIFKlx92Uobr1fDBaNBw89R78+?=
 =?us-ascii?Q?PP6OovK+VMPrVCQ5AcsUovTOLyos7C6AjhG6qwahjPZaJ+be4mBP09seq218?=
 =?us-ascii?Q?yJffwTFK2ExEd0klKP0SvJRVxM/FA5FCjg332/+biVJK3Q69xF9xgGDkGtni?=
 =?us-ascii?Q?i6xQEn17WjjCwaobSSLAcptMEB2GRD2ARlCbmOXpQKn1i9XDPP5gYAmQA0wj?=
 =?us-ascii?Q?n0oXPEY4j/1ZYM81ODuWy3z6weetLNXBi0ETrQevdSdh5qkZViskISBowcyk?=
 =?us-ascii?Q?X4C5Q5G23yy4oaDQawH1uJUOxHgCvuaYYbc37UeuL76dEj5WVN86czzqmSQ1?=
 =?us-ascii?Q?ZXHP5S9FrtZpiQd7YmvTvHxRk+oat99oINUjutTx5jdkYFuu8G6fy0RQhHtH?=
 =?us-ascii?Q?qNGg210WQJh5k7Cts8xSRitl+x5EvT4e0XXoCJQEvYdT3kjNTorAkZe9Po81?=
 =?us-ascii?Q?Uxhk8FtON2TpgePjQKlBFChuLTSjFSK83VDSLwRkA9aFY4gz0J3YjWzsT1cq?=
 =?us-ascii?Q?Rx6gYfxxk11pFmdZzl9Zy2YGPAq1kqXudOIFfcJW4HilNnpNcL3o02zA3rzD?=
 =?us-ascii?Q?+f50w0hY+2KEa1XBBfodsPM7q6IGYTfMT4AkMZtK7IXUcYZ8hAtDre2r263J?=
 =?us-ascii?Q?0/BjuQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e4HWf54yIS2wUhY2HhmY0ESs6HRQQLKrRGGV42rZaVnGUDwjA7KBWaxgpxyCtXcxDSHLL0Dxoc7sZVyJvKqUKPukMHrn0ccYQrq6ck1puzvyq9cJ8xXs4N5oLqNvUoSH2hrB0Zrv/fiZvpqU6CH4LjgghNbmHalz9csAmyarkwJiS2261P+ja8Hx6z9drK7bddZqQsrFoSeqPB1eiwH3EuLrmUodZ+hMQg0QDso8+MsIFPGrZ4d28Ea4XLGxOSY8fXQS+qnhKQbGCTRj0s0M2whE5mO9pYhV4wWK5WjDmXGhhALhBXSnE1i1UpT8JqRXCOYgvdEgAsDW5s9WxKlAD572n/DBtiALfMvboAT1RN40FIGdyQ7ismiplq8xV0dNop11IHi1vcrs2M04tvdwweCl5CP3KC67kzIa6EsxJPVDdWe5aDHtlwX2al5gnVTZtduNP0yLABSQEaOV4jeAYforbLLB/V0ahDocd8Wtj0DaGPCJwmWW3ugHLfvRKnjG7JiXf5ZlhwPdgnBMpbGQqNtHL2EBSrWVnVdnhSkTPPkdNI6oTh14ZkSU5/d4QbMnUnjybDKuRYqNBvrTezITnU5nry71LODdAlKDyDY/T/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8d1cd6-b63b-462b-2fb9-08dcbc74726c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 15:19:10.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s1+WQ5EEZJn1eZJBlniMZptME2Rj0o+Xzlev1FPLrYsALQ/K0bD3H3anxExpGevLs1J9MdL1yZgpCBZGPSiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_11,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408140106
X-Proofpoint-GUID: y1pymA2Ffycf3WvDZthLda_5f7LyQBEu
X-Proofpoint-ORIG-GUID: y1pymA2Ffycf3WvDZthLda_5f7LyQBEu

Hi Michael,

I've tested this on the system that was reproducing the panic, and it
everything is working now as expected.

For the series then:

Tested-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Wednesday, 2024-08-14 at 02:59:20 -04, Michael S. Tsirkin wrote:
> This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.
>
> leads to crashes with no ACCESS_PLATFORM when
> sysctl net.core.high_order_alloc_disable=1
>
> Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fd3d7e926022..4f7e686b8bf9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -348,6 +348,9 @@ struct receive_queue {
>  
>  	/* Record the last dma info to free after new pages is allocated. */
>  	struct virtnet_rq_dma *last_dma;
> +
> +	/* Do dma by self */
> +	bool do_dma;
>  };
>  
>  /* This structure can contain rss message with maximum settings for indirection table and keysize
> @@ -848,7 +851,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	void *buf;
>  
>  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf)
> +	if (buf && rq->do_dma)
>  		virtnet_rq_unmap(rq, buf, *len);
>  
>  	return buf;
> @@ -861,6 +864,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  	u32 offset;
>  	void *head;
>  
> +	if (!rq->do_dma) {
> +		sg_init_one(rq->sg, buf, len);
> +		return;
> +	}
> +
>  	head = page_address(rq->alloc_frag.page);
>  
>  	offset = buf - head;
> @@ -886,42 +894,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  
>  	head = page_address(alloc_frag->page);
>  
> -	dma = head;
> +	if (rq->do_dma) {
> +		dma = head;
>  
> -	/* new pages */
> -	if (!alloc_frag->offset) {
> -		if (rq->last_dma) {
> -			/* Now, the new page is allocated, the last dma
> -			 * will not be used. So the dma can be unmapped
> -			 * if the ref is 0.
> +		/* new pages */
> +		if (!alloc_frag->offset) {
> +			if (rq->last_dma) {
> +				/* Now, the new page is allocated, the last dma
> +				 * will not be used. So the dma can be unmapped
> +				 * if the ref is 0.
> +				 */
> +				virtnet_rq_unmap(rq, rq->last_dma, 0);
> +				rq->last_dma = NULL;
> +			}
> +
> +			dma->len = alloc_frag->size - sizeof(*dma);
> +
> +			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> +							      dma->len, DMA_FROM_DEVICE, 0);
> +			if (virtqueue_dma_mapping_error(rq->vq, addr))
> +				return NULL;
> +
> +			dma->addr = addr;
> +			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> +
> +			/* Add a reference to dma to prevent the entire dma from
> +			 * being released during error handling. This reference
> +			 * will be freed after the pages are no longer used.
>  			 */
> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> -			rq->last_dma = NULL;
> +			get_page(alloc_frag->page);
> +			dma->ref = 1;
> +			alloc_frag->offset = sizeof(*dma);
> +
> +			rq->last_dma = dma;
>  		}
>  
> -		dma->len = alloc_frag->size - sizeof(*dma);
> -
> -		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> -						      dma->len, DMA_FROM_DEVICE, 0);
> -		if (virtqueue_dma_mapping_error(rq->vq, addr))
> -			return NULL;
> -
> -		dma->addr = addr;
> -		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> -
> -		/* Add a reference to dma to prevent the entire dma from
> -		 * being released during error handling. This reference
> -		 * will be freed after the pages are no longer used.
> -		 */
> -		get_page(alloc_frag->page);
> -		dma->ref = 1;
> -		alloc_frag->offset = sizeof(*dma);
> -
> -		rq->last_dma = dma;
> +		++dma->ref;
>  	}
>  
> -	++dma->ref;
> -
>  	buf = head + alloc_frag->offset;
>  
>  	get_page(alloc_frag->page);
> @@ -938,9 +948,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  	if (!vi->mergeable_rx_bufs && vi->big_packets)
>  		return;
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		/* error should never happen */
> -		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> +			continue;
> +
> +		vi->rq[i].do_dma = true;
> +	}
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -2036,7 +2049,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> +		if (rq->do_dma)
> +			virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>  
> @@ -2150,7 +2164,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> +		if (rq->do_dma)
> +			virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>  
> @@ -5231,7 +5246,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  	int i;
>  	for (i = 0; i < vi->max_queue_pairs; i++)
>  		if (vi->rq[i].alloc_frag.page) {
> -			if (vi->rq[i].last_dma)
> +			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
>  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>  			put_page(vi->rq[i].alloc_frag.page);
>  		}
> -- 
> MST

