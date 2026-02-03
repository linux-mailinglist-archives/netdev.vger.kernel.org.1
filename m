Return-Path: <netdev+bounces-256138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAezNO6GgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B0D4A96
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CD3F3028B89
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E6366DA5;
	Tue,  3 Feb 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iU1o+yKk"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C2366558;
	Tue,  3 Feb 2026 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096264; cv=fail; b=RqzwM+/gXAYGO2A12vu8xqh5Xuk9PirjAJYAM2U2EOyF1QAcRl2j92Brg5J6kAvXD8GEjlqteBYchHJ5FrXJ3ch3XpsVrJ5plJKcdz27RefDy1so+3bNJAO8m4N2RePUBGFj0aR1Cxv51dAO8iLsKr7YSOl3h1E7SMCOdY4kURU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096264; c=relaxed/simple;
	bh=WCAobjF6H4HIhC7zfqW2J2pPJ4K9gOBjdf6Ogobuc4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHz/nGyq3IZA0G5gi3/0VpCTKdiMl4FYbGAmhJPj5fI+7bQaCmwy0EOFXNbxr3H4a0JkkIi8k2z1CYrt+8R3AYebuT2I4tvISc4DyKrdVUGPkM61lnRvNdnjh2XBuv5kOa1wrQ7LBdHWNmIaBwJ9qOZYbaGyFyijXsdPWy+gWzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iU1o+yKk; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdKZJT/dqN7vel1HE/RlW4b7uVanbYsWLAFRAAHHl87zmPRD+0Xk786Lm6jElz4FzMeqHbFzdxBcrQgmHthvP+PI1fs8IAfZJv8wfbgWtVtXl472Y/xPUWwlWl52p0cDUTSTQghxMdNEXY+kFjfRNXM5DARbHqSdfr2TVxFd7JPewbAgzJ+y2XGXM3aFDOTzvc7Dl20cpm3CvPzoa3cIgVq/RBUMOnb9uWcpr/hB9+acsWisgxnCZdJvwib9eGFONCkBx3sadqcfmEEs6rCGz15k4n0IeAFrC5o9I05V/vGtqZX176XS8bdowIkOXWufCdwbTmQdy9c3LbO9Glv45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM/tBhA2CweKWiyd6akUD/25f+0YliFjfhuR/VIdxcs=;
 b=it7pRNnH4BXUi9unkU2lycAIJ3juZZhrmO7pNnYI4o3WB61IjEKq6Xrn5b774bhTjmN7S8CCFM2eQbjNvX6lZVJ+D/yiFSl5jV1lhP92p38tLhbitD14V9lsSKv8FzVVFqWRS+P+V6pV5hDKc5C/lSR9tD/Aa5riDw8Rmlpb7OlE1VEH8KV5dPaX0D9gLHn+LVnnKxAKyKaTm+5ZQ+YjZXxRkv/kOhRFRvt/m+O57UPAtBkR75O5Noli6ywVD1+CDzdPVX0t3WWXIrViv06EK2kz2mVt05/WVWvN2A+/vF2fBMeFCtxsgE9k/KFLfXeDkCw7y4g/cXALZBybpQJ6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM/tBhA2CweKWiyd6akUD/25f+0YliFjfhuR/VIdxcs=;
 b=iU1o+yKkkm4QGovo2vduWu2HYXsfFtybb4FFGDe2PLX197xZEyDjGEaV/bUSo/kRW7i8/efsR0woC8SR4gtkFbvvQTy4m+W2QZYHMkNrcZ1Mg8mtq3y3h0a6ahFRQli8D9XgyHNOlXBRXbTyxBC5DZy9NJN8f4mUF3YnFWHAINupBLB0NSPs+Q3zIuiPvGJNQadZxtjap1t4hP3dJkwa0lRm4EGeeimSPrWGeyCkN1qvrs2ffMdncNZkEKmAUjQSnql3Njzvs/UMr8nGN9DHDuYT+YT+alFpPFSi5CDfIVyMrY6wCpW1nDI9ig04VIbUJTBmLmnjL3FZPlLpAeY3zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Tue,  3 Feb 2026 13:23:26 +0800
Message-Id: <20260203052329.1085444-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 8960e6b7-d9f1-4c6a-25c6-08de62e454c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UDNa+J1zmI14ksPNWrTZbec7JtX2gNsvOil6jz2luUQqp50Vj4ntQ7w6uU/P?=
 =?us-ascii?Q?HbzqmjQDVYTHlHsHc/KnPU8QmjhnQrGMdwn/ND4BkCrjk6z3dkJfybSuHMsT?=
 =?us-ascii?Q?HT7mzXofeLlyn2YdNaO53C3qP9w7KTb2vevCej2y7P1NR65Nf2hVW0Mb4Kpb?=
 =?us-ascii?Q?ShagduqatvDIlWuTE9ZF8CejqDQfyxC0Fxilv98hcFwaAQBW15P3fc5PMlzF?=
 =?us-ascii?Q?iVy+/YNqwUFwXO9JphHaY7bl8Jjkpxoq1IvcpYyRAXw7E/bukQk+hzXw8waS?=
 =?us-ascii?Q?rIKB90GkfJFpPODWj5SKdvdaB5KBtfL1+iYmRBdln1SKUOcu8YA1vaHA+wqy?=
 =?us-ascii?Q?pTBlkSKFTPL/UqDAWPK814WFjtHYwj7n8f+JSCCYGJ1kpc86mgTrV0e9D8YM?=
 =?us-ascii?Q?RrKXR/ienSiqagH8fLKA7yOEwgjekiUhP0orvMOfOfzgnE5wXF9OwPby4ISX?=
 =?us-ascii?Q?olK6noiRow1jL+TTI9I97lZi1VFs9VDxS8rVL5CSHvAzqe1FQMTEro8FjOvv?=
 =?us-ascii?Q?eFBbWiwC5jeqEtFL42LqUfn7HpTppcpRFk8pOr28ySQFIFBfHFcLAvfgpn6n?=
 =?us-ascii?Q?n9mDXrNNVUKYjN6a482HzjJSB+Z8hPPOFbDOvtkLBWhgdxcmuBrDl8JWExJc?=
 =?us-ascii?Q?AacY3NHo5nIT911pV+xHr4ASitWHRp6478+y13IUhcDBC+jE6fyl0AQuutBS?=
 =?us-ascii?Q?zjXCm3S7JnmyidJhdKSX0DUBkeXw/A1ZWskWxD5cQVUytRghJKYo59riABe0?=
 =?us-ascii?Q?wLzPJiGu4dSOuSaPiuYwV4vYcs819oiHxaIbupVHsUW3KTD54omUI/uIwEo6?=
 =?us-ascii?Q?4L1J86r00B/7VjVXVPtn2SlHZC4ROVKvIyaRMwNmgIMf1AG6jVwkLraPh22q?=
 =?us-ascii?Q?6T5fKKkNFjVkY+Mbke7ZTQThZiUmK/NZ5CA2n+DeSiaXSaeI57Ez7EhLXO2u?=
 =?us-ascii?Q?H2texIAFrAhf99Azek8dwPtX/HO2RxyvHEqFxRVabdZtARHDdVu9hWJC6qvR?=
 =?us-ascii?Q?N6wy3zqR/GwfifxJLbxlSxRTfXbV7GDX2hcDM2tT5ad6SzKmRc9dyhVUHvrc?=
 =?us-ascii?Q?d11KvHjOE7tsrzXffFVN2Dt7RXOzvNfa0HPuwFfwSvwLP56H0LZQHrAK1CzE?=
 =?us-ascii?Q?J7YBFgME9tmW+kuzKal2dq8jtZs0IuP9+x1sSxMxdjQeF1zA5vxmgP3nqfR9?=
 =?us-ascii?Q?u9A+mFKdkQGkdYsMJkq0iAN1ll2XyYgNqW+VHiC49oLFaNQpOiwdwshnkbJH?=
 =?us-ascii?Q?qO+/tzLIOCf6M1iOjFHwIQzmtS5Ij4AhT9BD/w7Uv0tbNiHrODY+oa9tPNN2?=
 =?us-ascii?Q?DY53+lmOWEz915u98LoJtPX8aoj18G8UXuDThiSuWU/5HojEwTei1XCDvagn?=
 =?us-ascii?Q?fqrDAVPp9ZKhRkGPTK+OU1g/u62HNvN93x2X2Qq/9JUdQxJVM4rntnbTKNN1?=
 =?us-ascii?Q?COh4gqDwur5juPgNckGQJ1IPM3dJm/y2AGjo6EvSgqc0Lq05I7oG39kkZ2Ay?=
 =?us-ascii?Q?NpyWFck3tvk+zIfos3RSWcUaNPMSFU25BBMU4h/qBufzv9Me7STMbc7sJE99?=
 =?us-ascii?Q?IkOi6IaZ2jKTo7w9WgJacZc9+DqGSOxH2NaHmqtdGBcOalwXG0M1peVZpl5W?=
 =?us-ascii?Q?/GHbdFkp+dVLOIseberXoFoeDcXoUs7R2mqq2e4WFUlz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Chc3BvXZSj7iSY5YiD3rRXcVXOrc+GN8nAoaUBuUX2wMCVmjfSWIl5AGhtio?=
 =?us-ascii?Q?D4M5Ya0r0El2OsY7hVZokkRvfVWO+VIIGxdONmPkk55GNsLYKopIxxAdOtTI?=
 =?us-ascii?Q?VcUwn+iy3j2tukl6hyMmF7N+0kxA+dknNFen6cHmRrpI/DWX77rmseu8ut+A?=
 =?us-ascii?Q?pm8Omn0pbYZlBKdb2d2HfTB2/vTqCjx59fLaNvSoDL1OiAgS0v8d947oK37i?=
 =?us-ascii?Q?tH9ZWwGx3dPkakNhTJFrubnMhf8S7fPRMWz3+2+Gsy2gqgEdMtJVGA22bFef?=
 =?us-ascii?Q?U4xgcMLKPzDfwFLmmDJCQcbOKR3TsLN/XUIB/b4as+aLOO84peak9+bOYXzG?=
 =?us-ascii?Q?BuftOxJ3JkFngUt2hRyjLkFm1uykUgD6TbJ7SdCSEOmhZCnsfC9nWezSsAaX?=
 =?us-ascii?Q?MudR5qL3OMCwsVngiVNn3VD9t5N029dmoV54QkJ+4FqJTh7tMve1f+wulm8R?=
 =?us-ascii?Q?8aPFIfwLhrBKlDsb+cgZeVXvYCeZvN7pZ59vPU4WIjnrTGGGqkvK7m8MIr/N?=
 =?us-ascii?Q?b/PYHu+agMfQHBJNJCNrax1xkieC0dDWPO25M63sY4EZkSWd9JgpD/fbRdVO?=
 =?us-ascii?Q?TQKW3ZnbrdU1Iw+twewK1z2p8r8NuUAPNaX4uoCx9vNDH+LdnhM2Mr/XJdAs?=
 =?us-ascii?Q?GJIY9e2b2SlTNI87qqvU0tSNt4QQplebBPs1dQPfITpSUQiq5HZR60C3k9hJ?=
 =?us-ascii?Q?gNjKcw+SPZWdayx6CSpQQo7N4RTVRVVSucUl5U1INbHgGO9/yffq4WNOhdR6?=
 =?us-ascii?Q?mq3hXquF+c0ehrX8Pf+91oXHxriG8Tb/u7QJGYZuY1SSQpvMPzAIu+yxksrt?=
 =?us-ascii?Q?qphtEmPNTm0Ff6GM5XCwcC2VyZ+hYVxnAnq+6UeYG0i+1I2QIXOgmBhXXYOw?=
 =?us-ascii?Q?whwiYYzqiPO9ELZzXrMQa1YPZQDgqOwz+YBpqOx8JtvwKgAduI0P8FDpjHhT?=
 =?us-ascii?Q?qJNx6z2EkuBH4b0u/W5TjiNLY2uOrVP7A84iBNQDOoCM6g2jubxvU0duhZgG?=
 =?us-ascii?Q?58HWvNAz01TLPa37gD0naiLH48P7+L/ej+FIRoayzVPwazCgLxK+N0MZih2G?=
 =?us-ascii?Q?ZMizlEHM7QwId+yVFRLSyO8tTsWyTZH58qoAZNV7G9NDgXpG0tcrdJ0KPdAz?=
 =?us-ascii?Q?J3v3EK0gFmCY+h8hGA7TGhxjdb1jVEmSGXtDu58ZilSBgoRMQ0DqSxPL8h2m?=
 =?us-ascii?Q?hkl6UKTJK2PThAJG4b7gXRWgGaiGtsLzg3cQg4NLJZ1KY0oGW683txv4SqbL?=
 =?us-ascii?Q?GwRjSngaGiMBOjXCEE2R3o+pG3tMW3HVtHgt9K27rjPtFICLsRsb0kTroME7?=
 =?us-ascii?Q?J3ExZqHugcUQJYnlMIaozjxsE+CLLAQ9Yba/F3T5QVRN8NBSOFOyhsz5fUdo?=
 =?us-ascii?Q?6kgJ67zaSeuOqUEvIimvJ+yRk8u4eVSfHvSD4WtVRMV7OPeKTPq1XOMI1Htr?=
 =?us-ascii?Q?/Jj+0h4lM1VFZkW9nwwL49zpiuT7A/YOPqPGOvDLbnaYaeHNNHE2JAcNLRiW?=
 =?us-ascii?Q?Tj7pHdh9TzbZNQ9Das9HKNB4gNjRhXhg2w3hGDeTVi9bZzZ9+c+u0rZc7dME?=
 =?us-ascii?Q?kNeEaBHRHklHw1tufTRRyizjYUF9CsGucr1vYnIFXmSsEJd81AuXyzQXoT6G?=
 =?us-ascii?Q?8kkp6yOrTbyh8j/13jxzkudpAbZEKResrthBnMoYfRNbp6LKMQkcsiSBzmYz?=
 =?us-ascii?Q?xWlgzwioSOSbTDeVFm4l33KOgHAUOLJKV244AxWEN8rWYSJPr4U37BXZ1GQg?=
 =?us-ascii?Q?zNVYHZulnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8960e6b7-d9f1-4c6a-25c6-08de62e454c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:14.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy2arztJ+KfKNiI1yAB3qYFCF3KcwdGzUyMSkd9KS5TMScl0jScx9lP91QhO6Cj9hRD93I88OEKsqKTmrA3qyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256138-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 9E0B0D4A96
X-Rspamd-Action: no action

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e7113ea971ca..31a27f1cbf39 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
-	if (err < 0)
-		goto err_free_pp;
-
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
-	if (err)
-		goto err_unregister_rxq;
-
 	return 0;
-
-err_unregister_rxq:
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
-err_free_pp:
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
-	return err;
 }
 
 static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
@@ -3419,6 +3403,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
+static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
+				struct fec_enet_priv_rx_q *rxq)
+{
+	struct net_device *ndev = fep->netdev;
+	int err;
+
+	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
+	if (err) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 rxq->page_pool);
+	if (err) {
+		netdev_err(ndev, "Failed to register XDP mem model\n");
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
+{
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+	}
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3430,6 +3446,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3437,8 +3456,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3593,6 +3610,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err)
+		goto err_alloc;
+
 	return 0;
 
  err_alloc:
-- 
2.34.1


