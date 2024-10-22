Return-Path: <netdev+bounces-137844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D179AA10B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E251C2252C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FC199EA2;
	Tue, 22 Oct 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="B0H+wtMh"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5A140E38
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596084; cv=fail; b=bFNL7nzG4NsOAg/eATrFVIP1kQIQuGQ2qEANmrbWRnlr7J/JZsO6DKyRDkYxO+orxC+LWc0rmPWoX6f9d/JFID5BlXHs6z8PmcHynSQ+tE5IO2mJIZn/UXgxqgtZriWuBQs9FzL7Yw+T4K1/DDd613zLxzCAfsGD1J7psA6KYzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596084; c=relaxed/simple;
	bh=i1Ef9seSQ/0ZXxIJrIOddAzQNM16I+vW4wNqTDOFQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twdirxVQBgrvcwRM0nStLinHCqM5pJ0uYJUX+SpA/l6f33xq7cnBKMD0scMm0xcPb0Q3dDs3vXbsxmb+ZZqowFq3iUxj/gev2QZKvpnjGyyv7VX65y+s9xhzzCvefNp2gPCqtVNVe5TPVVDKgFNM58PqJjB4owSXpq+TXV0aPAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=B0H+wtMh; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8E22CB0006C;
	Tue, 22 Oct 2024 11:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFX6RiIr8Y3Fm5bhpCkzlA3n/PMFMM9M/VMyyFqff3x0rG+mjAZSw+BHsIp74jSAPXqdUsRgUXXTaUYA9cq4VqpW0WkvwF4tqTjAxh2taqiaXtuHVQMYbofUu5BSt/on58gfn7S1KJDUFKbwK2vejecN6cHT95GBZJd1v+VWfDKHwlxprZzsQGmcd+0Zt6kLBWi6ARKbUt7Nh6SmYpSRH5lSNPet0Z4jYeOL7WRJs49+mlDjRJCe0OyMjiWRwevx3fF39pp3h/sHiDJtfeuQ4wEqt2AIHE0U2FeGswL342JAjTi0M98kSjVv9A//yC4OsnpF/J6dK7wjhbY8i+3gTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaq01R6PDba/4pvIrNHw3ikEnIQBcA3k02NBXGQUh0Q=;
 b=dr8Y00/ZEYOZIO8oz7H87i61X9kegyUeFpVmZ+7v7Ld/FaWMiLiuOUY642iIvBCz7+a4Q/0j+D6yhrj5FmfrUX78hEzWVxEM2yqmxaPRkbVZRnOTLhMDSWv2VFrPIfBB03w4QjWxDO68vJaA8ezWcN/Wdhk23kDxPVVbaCjLgL8iA5cU6TyVWsDAve/Yd4cbELTsB+jHUjhk4mNK4W0rvjmM7Ux3sSaxarchroNt67owhCnJgNJ8Mov19WDYSWgHrJXj6J5a8v44GN5/uz95Y214ntEyfeIMBl7kTHL3QI4wnJmwi3wsv2DFuj//b3zUwWigyZf9VzjjTLUdRtL8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaq01R6PDba/4pvIrNHw3ikEnIQBcA3k02NBXGQUh0Q=;
 b=B0H+wtMhsMIjxYbysRvmYR068bq2+uvSU+XMxSDJ4QyoelAwXRiA7j+xwWFA3J6veI1lIQocS17gC7jvr8/koeHehk1td4X3zw4yQMCtWGl1v3DXYQAOBt0eBbn0LDq/QGhy/nylPcDW9jSNjTK3upr7EO5ZRnTwpB9+VoKksCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PA4PR08MB5952.eurprd08.prod.outlook.com (2603:10a6:102:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 11:21:12 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 11:21:12 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: stfomichev@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/6] neighbour: Improve neigh_flush_dev performance
Date: Tue, 22 Oct 2024 11:21:04 +0000
Message-ID: <20241022112104.3238833-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZxaXyx4wV0EyN52R@mini-arch>
References: <ZxaXyx4wV0EyN52R@mini-arch>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0340.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::16) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PA4PR08MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9f3db1-9eaf-4e40-036c-08dcf28ba298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PjiZ+VjUyNOLF01Q34qypk8iIManKIpP6V8I85QeOWlVHhwQkjaX2N94N8L?=
 =?us-ascii?Q?6tx+c8D9iWIHsloBBcOl3BMizapl2KwYemnzKSvXxjMbN4p3lH4ToiDQg2nx?=
 =?us-ascii?Q?Fz6OrviyMaxeZL++BUM48LPsOEYVw50+qDsUyfCeP/rrPyQWyaCb+VpPQmwj?=
 =?us-ascii?Q?oPbQdkEY+Z8lsIX//KBByrp5APBfDGJeJJR0GOuOF5PNVG2MLzZ2yqGhPrh0?=
 =?us-ascii?Q?zcBWLccJ3eejLxTEa5jgbCnzCvvyBWAknFIZRzpdSEJyk0FUEy8me1yzoO8J?=
 =?us-ascii?Q?3jg8iGjGKtL/FBUhC7csrJuZAAFqJNxUKqHGbPSYw+hiLfNNW7eZzfT9son4?=
 =?us-ascii?Q?HQY1i9Sy5icIHu+LHbjqJ6BYqf0yknPalTRzkmJP8JRvB3+rLRBPSnKbVOHS?=
 =?us-ascii?Q?mYdxIo1QXoep/GmfOqoF/RN150vaBIX1QbzJA/KINVWxdd/gRHfA2LKIIFk/?=
 =?us-ascii?Q?rgeXklOEy2jnPssCfpSEWXQo3RpcYVpo47iEcW1Gg4brXD4oykIaJKlF/lPY?=
 =?us-ascii?Q?dv1ZjtHR5rlz+a/hoHn42ptvT9CXTEbGc+ndsNAtkzsNEqVaffcd2Sz0V7b3?=
 =?us-ascii?Q?Q+2NoY/ixRTISUSk4tx33dpOkUl06/bWqV5OaBjXyQlLUupZdC10wKtWXY8V?=
 =?us-ascii?Q?wztZtSowSzA++yNMreCOoRzdIXo1LUWOzhCPbSOomlAkddQsgIqXxioCU3uf?=
 =?us-ascii?Q?Z1ycR6YJHjtp4kYskRrvIPWPjkMFpuqhkNOPBApX/iUVmYWaWhCj1ZXRR4Uc?=
 =?us-ascii?Q?STxGEpUVwjr4/vSpU9xyL1/4EfnnQiKB3cie7WKj6/g6tqFQw4/twh731bz/?=
 =?us-ascii?Q?j7odTmf298eoQ8A1QTKra3y1g3E60oF2DdatkGicMMgN7Zw4czkAzfVTi7wy?=
 =?us-ascii?Q?YTwSnEBtBNnK3LBByJdYDu7SJ9uAiftIrmgMvrU/mxTTmTNfPI3MbWCmSJ5C?=
 =?us-ascii?Q?G6JblwJ5T0BSqxP6vivJ98CTMMJyvH/o9ntPftg3BH+oRHve+O1OxxNWKmOS?=
 =?us-ascii?Q?V39YgYfyUyUJ2qyI1nkoXths2RK470W4iqbaN6qWEMcNfg47xwYaAWo2LVMr?=
 =?us-ascii?Q?uyzkr9R3nl3iOX1sPfLz7z/yFdlRc06boIJhNSoR/DNGLUYcuAvqIijXhkEb?=
 =?us-ascii?Q?0xz5XXue7NslFSnL0q0kS4Kvr0FpdGY7aPsGVCUDlMQXY0PNcLMiJ5TEFr66?=
 =?us-ascii?Q?ub+EHFnJ3KQTqaEmWgEAke7yT7ScPj1E2veoL5CfclFQ86jGudzXkmfm04lP?=
 =?us-ascii?Q?Nj4oqd3hKMewK4LG4VTREL+z4WCbS128Qk4374l5E3eJf2DTColT9L/UAwYf?=
 =?us-ascii?Q?nTIqDxJp8skZlzMkCqGPyVBEqM4l0f2qZttgI57pmNsL4d/Do9Hs7D+MkPY3?=
 =?us-ascii?Q?qcIlw1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItBzyPmd7MJQCXY078fTuZKzjZAkcKKaa9YgoAE+BYpPrzsj6g/wtKFEJBkC?=
 =?us-ascii?Q?UrF83CBlmQ3hU525c5zDd40ba92H3gZm+e8p3xbfgj7alKRyWzk0wa5yuxYz?=
 =?us-ascii?Q?IzBQsRejFRIZcG20cIEJB0Td7E96ixLOM6fSYHrKZdH3PTcxFRTrxgcFzXs5?=
 =?us-ascii?Q?fq9wws48s3wjD5rcmd41fQbJ7B8Q2G0tz/SjsyLh8Xpfg83cEVkfUzNQxJqi?=
 =?us-ascii?Q?P7or0VahTZYKNvRd9hKL2he0W6x7LSdaZQtYzs4wzOWfma/zOr+ZwkGq23vw?=
 =?us-ascii?Q?hrBLT04JA0HCv/nbPB4SN4ifxUXdVI/p1vedDTYMnv/CFbH/GiztZ6QqU3Gg?=
 =?us-ascii?Q?75FESMmkOQy3H68VOZDAwFh3bcK9nVsY0xNvnA9ff9yerHbSnrVtS5Fi2Cy4?=
 =?us-ascii?Q?t3EDV2JCLYW9ByFHQri0DZ2ITaqH4WeOKaOetrtYSV/hi7g7o5L8uz3hMGtw?=
 =?us-ascii?Q?RIHgme9kzjrzPFdffYpPblNgB1kZqM95k/pg9DhL2rMXU/n7N5vdruqXE+5i?=
 =?us-ascii?Q?YcBU0oWdLQlKI8nnwB6dHbSCIF1yseeA4vY81fpvTAYR0UYavjBU/cG8OTMY?=
 =?us-ascii?Q?upT9S1GHUJjcFWIAtAWJpvfLJEs0DUcvbMyFuwbcEfVIEcvXcjaQNmW1QOPJ?=
 =?us-ascii?Q?ON0vZ0u9+jklaU7gqdfW+hmAUAS7+dbFQeQiH8g8wFilKnK4kK3AQ6Dai4g0?=
 =?us-ascii?Q?ksXcqjVvxf9hTD31br0bV6wsTOIwh15VgvaovA6mVcya4vOWt/9pHVpXWOBE?=
 =?us-ascii?Q?p+9fjYLbEEQ1qDc4vG3eqrZVtjvEvgYSsxj+r/H8pG8KioHibOsqctRFQ3rV?=
 =?us-ascii?Q?Lw3Og9YC0XPa8Fz969xmvCT/m/40HX/oiqonKUss0P1opGNMbIYqUzTRF2aJ?=
 =?us-ascii?Q?yb+UvLf5GvEwY+Eld6MrfhYVFvmfhTu0yBcT1x6JnOpq6XD/Kgh2zABvybfV?=
 =?us-ascii?Q?WZXo1UeSP3+nezYO06MO0rw/F2YH+XsZqkcQFOh+0bZUrl/WEGrlIzPcovt2?=
 =?us-ascii?Q?hx/CO1lOBHvn0CU9a8xpIMrdluOBOhvm5C3gdwWlyjSkvLGQlO2zQth8VIic?=
 =?us-ascii?Q?rcrv4sWd9H3Dw1g3huLLp3XWPWjfvJqORcG6Z44MKwa1b/IW8y79q1Wizs7b?=
 =?us-ascii?Q?ybtKYYRI5xQsVyhwhYnXyO+GqluGsKp6VCR5/mIAvCZ0KD/BLxJrPKiVYSrr?=
 =?us-ascii?Q?VFrw5g6Lq2oxdpeUJWVIJXKnEhQpqa2JRtc+zCIxArTGI/kkpf8KQk9rfG4A?=
 =?us-ascii?Q?Qm/GsOEp5bu9TmQFlLEIfccq74+F0qfMKGM4UpFDybu+6yVd+CnPge218Vno?=
 =?us-ascii?Q?d5FtxSWuE8BKipRFBNtLv/3xMxL7kT+lceUFu3mAj0EZYvxM/0K3AMAtz4jT?=
 =?us-ascii?Q?ApCgMvxkDdPxYntVu7OlHK7UezuxBQ+PB7yRxxO1JXv9tdsGPbz4sFeDAvTy?=
 =?us-ascii?Q?K5FjCP2z1qFO1t7ywT8r4zRcu8wuBh93mgud7haVP6B33FDPD2nnvlwp6iPs?=
 =?us-ascii?Q?JP2gDFH3W99m6X9UQasdkPs2DA+I1UFRH2AjrXzTXRCFVz2ov2aWgobYMAm0?=
 =?us-ascii?Q?Ef8qzCtKw8ltYgVXB3zlNlgOEZ/pDktUTBPkckGnZvz2lkJ2XiA7C1PU3b3m?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BLAYA0pkTmQ/avSCzj6w6FNOc6khoGXsi79KnywC6Oq5I77bTlNHbjzxZFP7zSQM8V17ZpmTQvp8uhK07NeVj4TMg6ae1Ixxk+ijtGtkeCYa8YcitJmuYCHub0RV5mRz1ghNR3uaNP9m+h7gJO0mPSYpIXSEwQx8j/P8i/DPzSjUTM2d9dTiT99rOlgBmn2d0QNKwAPGNn5O1ynvnqbIUATQ8jPhZwaoFe0Lvh8n66zVsdcjkkBBzOaQQ0elV0/xBlXwx1x9RTQoumZR6cZdUFrLF5N1zJALJx78gYxMr/cwxw7m0+3SZNGYW3WoXCJfbVwuwWgdcdj/nyWG7EP/CRJZKd4yg0wYiw8naex4MWGgqn1NpVKb1ubTYEcAuNaPnATqXlooacgEqkTyfewZD8RcwFeH24Zkj0li43D72PzfKXvj0uOUdOlXsgN7iDZ/icW+T5/sZ/0Zqwis7hqKwNc8Cv2PUdP2zkXDJj2ZNsGR7AqOQCbNcidUaQXsZtEoRLhevVF86wqTYhUCVZwFRqlZJ4AL4x0ezndm7NS0XsnBiDb31muJ8HUFjKwZnOcWIf8lqP/9zVJfbBOTYn9tlJW0OEgibcKEx80KMm/L4BH3I8ClZXA1A5TSyVsGO36t
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9f3db1-9eaf-4e40-036c-08dcf28ba298
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:21:12.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DygkDm7lOPRVtBi/IugKg0EkkOYFuDP+B8ncII20IxV5EIj3lBEsZa1pO3ZY4vqy5iol2IGtwqD7OS5N5/j2pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5952
X-MDID: 1729596075-AJDksMsR4Q83
X-MDID-O:
 eu1;fra;1729596075;AJDksMsR4Q83;<gnaaman@drivenets.com>;05ff692d30dd2b3781f81b6a1a8e69d9
X-PPE-TRUSTED: V=1;DIR=OUT;


> Seems like the series triggers a bunch of GPFs from
> tools/testing/selftests/net/fib_tests.sh:
> 
> <snip>
> 
> Can you please take a look?

Hey, 
thank you, it seems like I botched it when rebasing the patch.


