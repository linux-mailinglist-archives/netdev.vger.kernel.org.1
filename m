Return-Path: <netdev+bounces-295690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zabvEe16Imq4YAEAu9opvQ
	(envelope-from <netdev+bounces-295690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13B645FBB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:29:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=XpUQ6ti1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295690-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295690-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E265930979E0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416147884B;
	Fri,  5 Jun 2026 07:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC674478E4A;
	Fri,  5 Jun 2026 07:23:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644229; cv=fail; b=HQ3nRcM/lPArvv5zPTibBZGWOr2LOSv+EpdkN61RchIyE1lP3ZMzAYdPWs1XCvrOfYHbczRIAnPEHeJxDv1EFk7kq+/aCjyqGuGikg+GX0UbHrNro+CbK1d0POqw6Ny92lnjYNH7jL052bLm5cWDiHay+hSUp0bUwbeknstwrlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644229; c=relaxed/simple;
	bh=+YY55GXaL2bkQ9ERXU8knjFVrVEuzOE5/UgN607XNRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nuo+5up6UB5gE3Sh4uKQtsnI4J9/XtwBSmpBjrHI6p6sYvx0qxzdZBmJLgVOKj6fEoY8l8J8m6qixy9U9NJOeYcRkNt4x8CfJ6+UKhCC5nrTttoqpi5FTKdXlsAkc0czmqaIUWqkPhl11I1rK1aL00bbHOhmKQgN/b/JV0bu28w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XpUQ6ti1; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsvjcM9owbE4DBAUEH5drfO83pugCP5vzyWdGnPSCvDM4PNSmMyD/IPhTwQTSiSUBOwkETBhCuWUh0drwGaoNrdwpXr12fZ14f2ZcnmFSjDIpswHiyhTveEyRKwfgNBOB3/Ipa/jxAd5FUxd6Lsf9DZaFseUuFcfP+gCRE826UXYNCT361C1escFY7mWYNX5cKwXaNvAdXzC26YsXgCnABDLgKXTEAwBJEGYm1pasKYNcVM06JWpf8/UzmzQwQFNxq23pLMgOfdmbpuZyHZK3S6AtRxxRps4omVNjGbah4lFlML8QaAM81ZscE3pIKPhF1sJMGfwxr5ps27nnB+HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVrg6RwsdB1+3xKsoIXAMRKlqt7M4OeR2IQ5CUb2+p0=;
 b=PbWckRmMBzp4D3wnGwb+4EP7INFDXoBkp/azNsAFIkFeTg9uJriQ3QPbgLRg+CJ/YII9obFsVTk9H0Y7Tcajr9giqfXOi7EtbaMWdqsLyDO6UTuoP9ghGo/YMz+c38ppjXMF5fIx5vuMyOFNEczVi5LVa3dzLxEU63/BZfODbvgNiFeizkjaCHaYXkJNBD6lTIUxz0Eqas5lEh7B43OzWOcBiup7w+YyaqUHeuYzhgZG0jSpymu0kuGZD3BtPyJLg7Vd4+9BPC0K1L8eCLAwz6nsZET7Fv9Hg+Bt6EJJzKwVsRvph8ombdtO2w6k+sHClKZTvBqoXFM3StLYa1Yu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVrg6RwsdB1+3xKsoIXAMRKlqt7M4OeR2IQ5CUb2+p0=;
 b=XpUQ6ti1gMtkeQcFwXEtazC9F1ArkEs6NLYmD5JydRKKubjA/SIVyIa7E/NJABCfQddFp9F41JnMeBBWrvZZGjB4FVv/1eyO6xhTK/CIoStLhJZ47Z4aLg7vZ2bs0fR8ak4TOKkLtxrZsP0HgaUou2IkaIJw2Iy0GUJfuWZr0GpJqQsYmOJeyspPYf0AhEEomRn41eX4uWrN+SgJVr8ycuJ/gRDAszs6br8AGHEw8k2DL5l25/H5nJWmqJNZVrnM6qiJiVcimL5YZQuweXd9eLFyvGwi6GW40PCA5FHIk/dfDz0Cwh8vO1b7TfzkHZDF403dqiWw/rjHSBmm9y+5Ew==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:45 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:45 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/15] net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
Date: Fri,  5 Jun 2026 14:55:43 +0800
Message-Id: <20260605065550.3038579-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8a1621-b595-4637-3feb-08dec2d3609a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8Lv4KxIv4l9ilItpUW2CqWH/j9l65AclsAdbmvITXSsqyWFAd3bt39gwvimt4bpj9iLAi43SVSmrYIE2Bnmx63LmRrIx4KuA49QcQtxUmu30CmpTPSkpp4eLjyYxUxsKWg7WldHlBQiHPxtwziO/UEgKeQzAYHLovaB29N484cC5bzVo7PDQ0kbDHss9AU39XzMqju1yLaqKOdzjDPkT1WqLUmxSpwGiSErmLKi0urtcTUnvLWkJSOH6K4lJ5xUeYJ0nag+KI0BfNqfw3G1W9+PL2fN1bK485qaxjd9WyuKccBol4K6idDdnueDuqUNjXEoA9ATj8IC7/8xIbIBn4FwvRx78JYKhojQOJaRs2UVFgV7v1vMtgpwNwDAWfusVXi+R9pAoxiNFGb7HNjqMt8BZEO6cVwEzu7CutkYVugoxRJZzqljRFYbRNRzufDwvIYia6hRwCnrSBTgYN3YN/MM//NWVkjOjJVxXKzNQoVL2jbHJjOnKxT66IDW3qW+KV9UHbDNAtroD/KOFwsyxe5dv6qpYxiluXbwsR+oW0IJnJtmTFVBiye69EzZmwckksMo78LCAor5BgGJlWJD6KGjgTrkqFDouLWgkVjtOpT+PoYexRRmSzblA9Gtw2yLwXeznU7yWdyHEhktcXA7gJDd8aw3W4apxZc8e5ws6BhRGZmdtQ39B3nIBbm2OD0zxMQlpfmeWBOys8Rx6uES+ND/NoEiL1Dk457Ex23oJDnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rs/EqtvVHPqhmkdU9lHgCwxut/0zRkzLO2o4/eX5oHMfCP4ynio4HRjExWGK?=
 =?us-ascii?Q?EW72pHSOmdFc1mDlvNMIz2JdFoS2dNyMyKj6YZNZyaa3LavsxE2zGHIyGmK5?=
 =?us-ascii?Q?gBk/ZRvTJg6QGgr74nBC6Fv/8xFXEN9Cc5Ta82+nqI8AoQvN0Axx5U5p6nSq?=
 =?us-ascii?Q?GCouExdt5IxGTNgXr/CGybEOniOev42ugGRNfmiIvNa7HCnMNnM9zuIhQozX?=
 =?us-ascii?Q?VyjPKE6cM9Y+VbC0FPpgRee+HRttNqaWL+8mFGueEgAHsT9/0rOmXDTfVjd+?=
 =?us-ascii?Q?ZydLvNSz2lmyEgdED2vdEXql1Y1sTbGBYfeh6ImO7IjpgPQo/Qltt+xs4QQy?=
 =?us-ascii?Q?ZxWHfFOCSqNIdrxP5ijH0DOQBKMWCjDnoWFFCzSakMn9VzUiYJxE5JQYwNnN?=
 =?us-ascii?Q?KAfrhvPjpeeAF9qRcRRPmBW3GHd6dx0i78w/LwANSvrU9SxJ1PeMSSQWEkD4?=
 =?us-ascii?Q?u61MxLm6/yqy1O4FN3X1stsXOAQKljuWgpAjCI/3JTaPMzZm7HN+dP6WNH59?=
 =?us-ascii?Q?mEmHXNzKXsDhPdPab0610KVcJ3tprCC7FTZ9s8/QUfFWl5bxeOiMZLkVgm9Z?=
 =?us-ascii?Q?ezbaXk0e5wPxjCb4vteihni0Nxhz3rOvO+bF5ePnpMLmZHIbshMikrpqKRV7?=
 =?us-ascii?Q?u8tiLWIvrMK+RwLatXGE56sUXXIhDK3XDxLKvK7ML71GPEhr801Gt8nYjN/e?=
 =?us-ascii?Q?8M4jbr4FqgrvY2Ej8nYEG7Z89eVQpYlfoB14sxH5udiYkzpm5P5qaVUS/xMH?=
 =?us-ascii?Q?OwICNc6gi/nFpT7VdcqQEWK87lRFw87ySSLBF7XZNJ+6PWJcmfzMqKk8J/2q?=
 =?us-ascii?Q?VfX1GqS/4j0L3g9a4tGg9/4P0MMXHLUXEm0tQqXn7kjTqguDgvt90gxd+gts?=
 =?us-ascii?Q?c7omVIQo9qRKtpeln+IxVJLQgwHFzLq7/gs1ozLepEb3RqCE1VY8ypArOKPT?=
 =?us-ascii?Q?zRhKwNAyes/rbdjcfDAGVdF5EESrDooMRdzCC5cwr3aE4dQe+Oofgn7hhdTf?=
 =?us-ascii?Q?7PG+sjU4iqGFHlCD1o7d2yXeeX1Rxq5gbh3M0mX3mmalActUZVdSuZVU9758?=
 =?us-ascii?Q?i3dmTOLMldzE4xwMIpG6zbtzkLS6SUW1LbiiSMFLIljcsn4e8Qbj1/oNjrNU?=
 =?us-ascii?Q?d4MgQL6Lb1P5Zxzl+66Jlenr41qc0nLwyumBiNFhJYFM0/TQOTI4/tU2B/6v?=
 =?us-ascii?Q?xiNEyB7sRd2vqCItQ9I4MjVsPr0vplaCY+j/D60REqcLznjQZiZy//Q32r5h?=
 =?us-ascii?Q?xp7CqJPNWeAi7190A2LbPKP3SmcEXLBZE+FtpnQ35xd8CfNAoKcBolrow3FQ?=
 =?us-ascii?Q?uwNmfRPyp98KtCSDg+i90gwnVvV6IFTX37mV+tDmD4ANIKln8BdZbgTtrdt3?=
 =?us-ascii?Q?oSRAexhrdDOmS8UfgYXfS00YVRX4XMw8QmA2F3WyA3RyI7uAZgKUs7Df5Ppm?=
 =?us-ascii?Q?doOH47NdPX5eEI5y0WXMeQ+/inm0eonA9IJ+aT/5BCb+bdRjcVM6ULCa6RdD?=
 =?us-ascii?Q?37YAShMBhRQ3ex6/E8j37my4LXfYPB/16rowRCqJlDn6G4NDZxmM9lXa1Pes?=
 =?us-ascii?Q?gQ9DN2IEKe7f8F0LdpK2/+HEXWZSydExBvTUa+s4B29OGraBWf6PR+6Sltqo?=
 =?us-ascii?Q?20XxoJ1cBnvtdtEpF1HWDFNvuULyPYP1ZOMaX9SAN4PfIFsuUh2ufQZyRBWY?=
 =?us-ascii?Q?MiueV3h4sC87pUuXsdVlx5xRBG7qROQo1UiTRGc7COE1Xr5s8oZ0c6fJfdlk?=
 =?us-ascii?Q?7lw9fBftWW0dodXt9l1+ZK7jEs00LUB4bsLFfUbVdh+LvkFQA4Ot?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8a1621-b595-4637-3feb-08dec2d3609a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:44.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTfJmbjgEe7bnn/nDsxd1bejl+18iIWxaBwvlyPAEZEIMKLDdMSBQkUlmKCInV503si9EoqtUu3ZJj6tor7ewSHQCo14rOUfKq8lZUv4/N+zncYokEWEEvcNUQ58tsz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295690-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF13B645FBB

From: Wei Fang <wei.fang@nxp.com>

The mac_filter array currently resides in struct enetc_pf and is used to
track unicast and multicast MAC address filters for the PF. Since struct
enetc_si is the common structure shared between the PF and VF drivers,
move mac_filter into struct enetc_si to prepare for MAC filter support
in the VF driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h     |  1 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c |  5 +++--
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  | 15 +++++++--------
 drivers/net/ethernet/freescale/enetc/enetc_pf.h  |  2 --
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 2cd035773aca..24d9f89aee73 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -332,6 +332,7 @@ struct enetc_si {
 
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4cff2f1237f1..f6920ded9f7e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -225,11 +225,12 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
 	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
+		mac_filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(mac_filter);
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
@@ -239,7 +240,7 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
+		mac_filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(mac_filter);
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 38fcc7b5fc6d..209a3503609f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -111,10 +111,9 @@ static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
 	}
 }
 
-static void enetc_sync_mac_filters(struct enetc_pf *pf)
+static void enetc_sync_mac_filters(struct enetc_si *si)
 {
-	struct enetc_mac_filter *f = pf->mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *f = si->mac_filter;
 	int i, pos;
 
 	pos = EMETC_MAC_ADDR_FILT_RES;
@@ -158,10 +157,10 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	struct netdev_hw_addr *ha;
 	u32 psipmr = 0;
 	bool em;
@@ -180,7 +179,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	/* first 2 filter entries belong to PF */
 	if (!uprom) {
 		/* Update unicast filters */
-		filter = &pf->mac_filter[UC];
+		filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(filter);
 
 		em = (netdev_uc_count(ndev) == 1);
@@ -196,7 +195,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!mprom) {
 		/* Update multicast filters */
-		filter = &pf->mac_filter[MC];
+		filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(filter);
 
 		netdev_for_each_mc_addr(ha, ndev) {
@@ -209,7 +208,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!uprom || !mprom)
 		/* update PF entries */
-		enetc_sync_mac_filters(pf);
+		enetc_sync_mac_filters(si);
 
 	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
 		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 549ea3f4b5cb..b90a3d24d854 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -41,8 +41,6 @@ struct enetc_pf {
 	int num_vfs; /* number of active VFs, after sriov_init */
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
-
-	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct enetc_msg_swbd *rxmsg;
 
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
-- 
2.34.1


