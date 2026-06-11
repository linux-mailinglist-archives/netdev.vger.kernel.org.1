Return-Path: <netdev+bounces-297885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsIFNgYaKmoyiwMAu9opvQ
	(envelope-from <netdev+bounces-297885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343EB66DC73
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:14:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=MYAhfJMi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297885-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77AC530C8D01
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF22C0F7F;
	Thu, 11 Jun 2026 02:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4526CE2D;
	Thu, 11 Jun 2026 02:12:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143945; cv=fail; b=I60so7kJUVk0zeqA7i16ydlose4wUfo1o1+njRgbiMolRTwkMxD4sCFdFJoKmuo+tV5mU/XBeYC2pr8fwSAFBVHaVG4BBAnpLDQ58EaHwgVH5f6hU0cNqUNDuDNWWPWo2TIwUtorhxDnhbA8G37mucmVJgR1TPqF+92YkoRtaI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143945; c=relaxed/simple;
	bh=30zxUTGxgNU8nboSkm/t/uLXEbeCmhlaRyP+hHDJ5yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6cn3AFMqdytb+c7sz6jZVDtefC6GvWZuJcF5qO1F0VWjji4vGIJDPKrolbyCuVWy34JWvhT0WxudlX+jvb2LMtHvUxFsdFqUE5WVfTKS5z5P4hkZc3M0JVZp8m1ROtgj72DbNpA0DMEPUwnSkzLwda+oVcyhC8hf0YWPjX3Myk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MYAhfJMi; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1bTQbvTr6ORt4B8Fd2Ohl+v6ucX/MPDm+iBpg8EpvdiDdSo0MUmE7HX8U65cywaXjVE4tWma82hQnLrzYpKvoyqS46QXqZ7HUWovLMRXQSzz8pSZKmiPYnqUyFxg2hdW8qRca7qnXn6WIQ+kMmo+FZj9K4Hl5rUUERV83atlDEEWSuf9ac03vqxIznNiraEpPk2I2QM1pDMC6G31Z/mlYoZZuS2Pa45quavrlJpWWb30R/aqbajNNyVhEHTOpJUeF0+diWjtIHbVdVP9OKljDeHK7doPL+/u9iYapcRidFVVJRmK28XG2Od6cwrk7/UdQHmvNvEA7y0jUMz72O4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=mFk+Y0FKqbhjKCTjAEcqPtJ0UdOB252FNL8yDn5gnxWL714N//yfmaniFEUdhmDS1oEUAeV8CJ2arQOoocMgpABtdzwliZZNl2nOzlaVB8JdzTA5SkA4OAlPmoFaoyFDJytGBj7EYA6Qf8Vqc58bG+i8ZjugFXiPSAbdf+4YyL6AVhsiQU34XhFWjaskFFLOCMmWWnz5Mrgd0zQmqhB3eUBXKcdYqIw67W7HcihJIZciIcyzgzbqvxztEM11YKowWQ1Gq/LTx/9S7+0dNZwiptXZ1khdrCCjNfC2OYU9KLBQfudQGWJ/wH+j7jWHH4oDf/WyTl14DB96pabbfTHaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=MYAhfJMi8sRuHcj/bNyfqdVcLoOxBjtR9U/JOSM9QkmuaJQuB8HIqwdRVgrXhNhT3uR8DTvipsY0eQ42iZ98gOQ/vXHMN6JtgcQcQ30y1e1VlegnOU/ZJ4XmFApxahSFKRXp1JYMF5PApCUR8FLO7eNp0Ue2fuk8hdpTvjbFDzr9993Kp8ZRgoBqKhEaBOSW6W9hNaAcBspsFV/EhZsOy206yajaKHJyrbThCZBbSM+v/zeSVoacVh7sHPrZkYp/x5HK/SGX2mMeqCY1Epm5sY+LqGJx5M52cNC1wv5poC19T2C/Wa7BaKYSMsV4/vwlhEc4OcGM3d3AMVfAzLRg8Q==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:16 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Thu, 11 Jun 2026 10:14:53 +0800
Message-Id: <20260611021458.2629145-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0280.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 354ce70c-91d3-44eb-c5a9-08dec75edbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bY7YKI+y4gD1JJd3FbNb+vxyoE7xsYdcPMUnVwrgYqqfHkbJxQGKqyFZSpgkqeqZqweu5om7MQCcIH7ZzVtwxcpw8yTdb9FS6/VXXtuK35keuARIJ31hrMkpoOVjZ3TjttRPUBwUZHsIEm7Pc5riWYyQAA0lGx5W6pYs4blIVm+7dQMDW0CylD+/MtFMowSyNEU7O2xq0WJ3KVpbucdqZK07y8l5nJHieZpPSmM4Uh3Ney5zWSUEuMf716b85yawe7jKWbNDBZ16+tWXRHav4rBRPwE7/hxjCVSkENyYcUBby+0eTitSjXYW+3oaXIzSWh2k62sgi+zjf8KFPPKG78hpNmsQ9ggBOIVAeWu00XvAds7/KpxquZf+yjUI1Q6tzCfMeqMAP1hNpTjZ++JPTVJBnke5z23hLDNcUZc47eiAofwCZ99aejnOt1FpW1Znnt4zl87OeWrO+9jqB9F9ZnWbnVMT8bANtTfds9aUFLyT2EvStsa84XgsmddyY0Z7lOM+/xONL4rgTY6Mr7iHIvAlZGI91U2UPf/ARyIbRUZKVU7+8ItFLwQteH058BmlVOr9riezcejGzVSLJce0pRDlFdcZ1GyMpbU50hpffLUUmcSmyND52cL2PqfA9BG93yoPW5tfVyfhIzradVbVHN+DSzaLdBtbt7/zF1KlfCECBaQNY9vSa2/tq6R2QFTGViNEkpIeUGilFO/6cBASTXGPQuQEgTl5tdPVa1k8nnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUelyHufO8x/SwpqIYBw9GvMgLHP+WgAATJWPHthJycwYHn0XQ4hXkcmHCoU?=
 =?us-ascii?Q?izLOMm+VMXaCOZyrNqOfg2lXqHE4M4tbjnMsHCeW5H5rnkl44kiCxAxl995K?=
 =?us-ascii?Q?3SbTqnK4ShmvSf8hRESS6/TRgnkuXL0/YXQ0zAZZtPakWfrc7A+qU7ZKC49L?=
 =?us-ascii?Q?K31bZgUIv3Q3xOjuPyAGS2Al0loVaGj06e0muKX85V9iaVUoK+nOfuBBk4qZ?=
 =?us-ascii?Q?Whmy07yougWQihwj/LM1zWUbidDry/eSJ8u7dOtF9Ey9fNOYhPC/w5QkZRx8?=
 =?us-ascii?Q?BJyQ6MkVznu9soQ8iRJUWBVVG4ymeKGUYfuhWRuGxLBrPDkcN2heYMNfJ47+?=
 =?us-ascii?Q?baFaApYLPpTVUr4ZsixSwy1IBdPfbTO84e1l09utvyzZiKCLLKKMcrplYJ0t?=
 =?us-ascii?Q?RDZbK+/l554JFA9vLDH5Oi1VE4SVr5CCatGUjFWKe+au/UVBZHMvMGo57ve3?=
 =?us-ascii?Q?eeWhSrQsg58wpjA0oXU6RORxqtjWDFEsTE+/+749UaD111hYO5oS9fFB8T3E?=
 =?us-ascii?Q?RZw7ehBVNbvJA0gfrKJw+vzKWxl77G66/VKI1zLHZPuo2iEa0m5OQwBdZuTL?=
 =?us-ascii?Q?m/rQMpCpSDCuqcefvuGGyvGGt0bWcPbA9mO70M4cWm9gf64x8gTt0MpM/xBh?=
 =?us-ascii?Q?p1zM4JuDawbuicMplqaOziUchZU9owjYAL2r7qmIo27ExlZFgHsA6pclnvqb?=
 =?us-ascii?Q?K0SEkG2ouuVg0wiiF1jQq0FDBhp+RMxYRrj6yXVKuvJIItImcjgwfLSSaxa/?=
 =?us-ascii?Q?JQHrmgDnZKP9RZdwr8ARrMzb/2cEpT4vgvIaaDaFJ9A33w3MaUc1NM5pcICF?=
 =?us-ascii?Q?KTVBMXRUWRiTiiZPQ8ql1opDhP+b3TVUbNukPPYIMgwBMjprAjr5zwmT19FG?=
 =?us-ascii?Q?tQOi6XmFLERfifhQo4Xi/wSrSB4bN8OToBzMfYA4+ERD329kaNQnMMuT/wQi?=
 =?us-ascii?Q?uXoMfPY49CNIEHBVcSpsghgJmfxYTv9ep1rm0QBUIsghY16ZCi//rHoZ5iWD?=
 =?us-ascii?Q?oI0hMdctWLb+/SbYcfqRL0Okl5vnhJyddLnwFegOmK3JPg/8uhVrRYzX4vOs?=
 =?us-ascii?Q?fQGQun0SS4n9+JZ84LUUhdx/iCFB+ma9Q7Swq0XbkrCYgnrkb58xiwjzH6x3?=
 =?us-ascii?Q?cUtsWeVvf/1GutijdQlSVdGxKqivRYvDi6IRp4iNOQJbQOZEOxoGYJF+BaP0?=
 =?us-ascii?Q?ktBVEuLx8mDyy1A8dQE6zyJFub4CrqH8HiackkZPUMRVHLNLCZMAewbyJ6uW?=
 =?us-ascii?Q?nk554Yapts1qideIYSCTIAxAJpmR5467lyiyaQZ9hNUJOiujWRIf9mmc5MKJ?=
 =?us-ascii?Q?xcIHy4fgg/b1NLjYsdb10//aSXvgB8P+gpLrI+e7oSvhTPv4Q+DlwdKEdTMy?=
 =?us-ascii?Q?lrEGQrhvDuKCOKurOGAk0uhzAqgbI6sM1NdjgcrJ6SX9MuiHY/fK0/hRP0YN?=
 =?us-ascii?Q?SQN/cuJDhawYkfnoevgeyiCx4nzyIxEhANKcAsTon304EDPSMb+GNwGtvOrf?=
 =?us-ascii?Q?+t6f62TZlJWDYmqzQZp4D47IMnVii2SqKxFZDujuQePqOYyGrMUwO5XU+N2D?=
 =?us-ascii?Q?vP7s8tk9WYBEdC8XYOlyQKMW+5yo3ypMyFEmYVfztoAMA+u9p/S4z4k1AMP4?=
 =?us-ascii?Q?rlu23Y1UqyWJxLSPlFcewyqlRF3j8Fej/AnPe/q5PTHmDOPUcxVl/49rCQLg?=
 =?us-ascii?Q?sc3nFbD3rppFDL83lHcoTueMDCN3swPzbAuW5CYsGX8aoPJoumloOdksLHcz?=
 =?us-ascii?Q?z/DLjpLCeEiH1rR0n1zxMT4zzGxPRLA5M9Dl+p1T3nJnCe5Ysfo2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ce70c-91d3-44eb-c5a9-08dec75edbbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:16.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKUXR2VoYdLE8OgY/qnukLbTUwfXVMpbAPrfBOGGCslg7RI9BNIR4XbwqSAV+OEAWZgYSvfeRTtt0RnYaho48XQ2yvmnKKy0OEae7sEIiOIzE0ubbLBl4doz8yCx+byO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[nxp.com:server fail,sea.lore.kernel.org:server fail,NXP1.onmicrosoft.com:server fail,oss.nxp.com:server fail,vger.kernel.org:server fail];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 343EB66DC73

From: Wei Fang <wei.fang@nxp.com>

The egress count table is a static bounded index table, egress related
statistics are maintained in this table. The table is implemented as a
linear array of entries accessed using an index (0, 1, 2, ..., n) that
uniquely identifies an entry within the array. Egress Counter Entry ID
(EC_EID) is used as an index to an entry in this table. The EC_EID is
specified in the egress treatment table.

Egress count table entries are always present and enabled. The table
only supports access via entry ID, which is assigned by the software.
And it supports Update, Query and Query followed by Update operations.
Currently, only Update operation is supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 45 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 9249f78219ed..601435966ed1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -25,6 +25,7 @@
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_ETT_ID			33
+#define NTMP_ECT_ID			39
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -33,6 +34,7 @@
 
 /* Specific Update Actions for some tables */
 #define FDBT_UA_ACTEU			BIT(1)
+#define ECT_UA_STSEU			BIT(0)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -287,6 +289,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "VLAN Filter Table";
 	case NTMP_ETT_ID:
 		return "Egress Treatment Table";
+	case NTMP_ECT_ID:
+		return "Egress Count Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1197,6 +1201,47 @@ int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
 
+/**
+ * ntmp_ect_update_entry - reset the statistics element data of the
+ * specified egress counter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id)
+{
+	struct ntmp_req_by_eid *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(req, user->tbl.ect_ver, 0, ECT_UA_STSEU, entry_id);
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ECT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ECT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ect_update_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 0c951e1c763d..1222901f48a7 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -37,6 +37,7 @@ struct netc_tbl_vers {
 	u8 bpt_ver;
 	u8 ipft_ver;
 	u8 ett_ver;
+	u8 ect_ver;
 };
 
 struct netc_swcbd {
@@ -294,6 +295,7 @@ int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
 int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct ett_cfge_data *cfge);
 int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


