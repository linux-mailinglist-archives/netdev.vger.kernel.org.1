Return-Path: <netdev+bounces-295564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xts0ICQtImr7TQEAu9opvQ
	(envelope-from <netdev+bounces-295564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2686448E7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:57:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=wqTLDkZA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295564-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38BE3116AF5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A31199E89;
	Fri,  5 Jun 2026 01:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748A3B7B98;
	Fri,  5 Jun 2026 01:45:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623913; cv=fail; b=GU6hrvlMWu3hpt1/T+H8dWrV7Utwak6cXrr8yd5kKfN3v5BNoI/MJXbI3kYr3uLIDkkB5BHQs7ovblUFS9eJam6Svw7oPhUTDuvcTWEQdTCIGudm4Mii6VPXXaTBnPZJDZCMZFKdDQa7KTMIIa2dCb9V6+iWnuGJxKB9DuL8eqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623913; c=relaxed/simple;
	bh=IDL+cWDV63YBwU5KaOk6DOsS1jFEpxRjF5ZPF/i6PIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GyINuP3YgBKvqxRhQ9JEG8JNxfRfAOtdbsoe0SI6JGMmXLM5cBG7+WnBLWqh+cCJTBDfZaqOGcW1f5OE+/g1Shw1xoMXJeNE9Cl4AZx4n2JRpesA3xOs/+3UWeYDYVEHKJvu1+0gUeqVKQ+PcGjbot46ubdDvWwlxWOoMe+7IYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wqTLDkZA; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY5IjOr0BEarNaevhRG+KlslNoZTAStlu9B+qFihKMZ8QR1BAR0q3hGjCZd+Mz3/yVbSPgaDwtIyopePzx7cyAWBlWCltKpEzfDsy9+t0mOqQpFII/UbxsrnBIl5uss/zHumZf+XiUrhZoj6XqsUl7VHG6Dp8s6NO2bLSdFP+tUhXXV+u8UgTQJnumITk2+PzDdCowN7BKme3gOnkDC3ciu5IDD/Dg+Ra9yxA0J3yJrXaxNS0DSINJTrebWqDkBij9BJl3oli0/4aZibbUCsKixL93QYyYIuvKBTJnV/aGVOrxue/3IppqM4settnodApG91Akm3nnO+mKzP08dRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjh3FJIXv11HrKppu2k5mOLZc7mdKjqkSEgR7F98W5E=;
 b=Ee5QwUCq0rDr3QYHzwLB9SCbrwKNk0za2xQ1dvlVC2naYetgG+KegzcIPizNQkzGlmEXIdtQGJizdJLtgrGxu+isBjj/fdYCwaAumMqM688cngokywgAwSiLvVsaIoGzcZjQgQ0TWps9MsRuOnIrsVUj3MbU/A3IFe0Gj+k+JcxNljNeFIpHAQxALksB6X+9DXPX4O6upkVgIf5m/nu+7hWa2k3wcl5NtLoU0eRJ+rI+t2sRhSZw9TBWBiyA24R0jI6W1YPUyotgAE1COQTKvN3uFcKDdRX+aLkkERdbiPcRw3d/6QM3PpqLlCK83jNSe7B7sUKfQWMVKljkhSrGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjh3FJIXv11HrKppu2k5mOLZc7mdKjqkSEgR7F98W5E=;
 b=wqTLDkZA6dThXN/9mLHbnD0zXm5WgB7E2LO1EkznW/EJUcWShq0zAArjXm26uA5HIaaEeNnk5bNeQDRaUqt7q4kj2z65OkgXrE5GgFq0IdKsbnMW+t0Hq/0Pj/1KVx/Y/dFlPOp4hzj6Lggj+AQ1THZOYdLoLTu86xalaPSo1k56a5/pN48cQMTLAv8ODeijNL/vQ1E6GnVSiqAuE27/uZ7qGe7arEldJnK6ZyB3rXcBCs1kzwXaPgevxNYmmF/Z4HcJVKIne+7zXziXNreLOYjqFUXxXOGdiIu/UdzvGcDK6grmLphlhmDel/i68J8NlUHlOI1xGbsRmAd3YzzEyA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:02 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:02 +0000
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
Subject: [PATCH v3 net-next 0/9] net: dsa: netc: add bridge mode support
Date: Fri,  5 Jun 2026 09:47:59 +0800
Message-Id: <20260605014808.686024-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e948293-491b-45ef-b4f5-08dec2a40f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	whZWchuY7Q2NzGbOJdTxPnZt/nQR7KlAP4OggVw7mXuuOHfQd5hVBWn9gqcPbViR0dselO4ZsghhxVU6qaNPVlvj2zF016sC8OcWSSS34VVHGVOWP7mW5NvB72mXEqfON3I1TpegmR8vliiOfToGJjGcHkpEoMTUUu2GRKPNf1Wi3kpUhRqb0aupAvcReqoKhsqCs5wWVjWH05tBzHqigRBVQYl/I/qGZW3xHJEzpAfwFS9dohJZN5yLb/9j5oxWzsDWoEADCUZB25Y4AJmezP9/Jfd2o3WjHJ3OyTxYm40H02iFC8wLqd52rbOpdejaOI3UlxrLieAIvRTC1p1pnQBfRSlBECIPqRZRqm2gzhpDAm22TJf6dqwxcOoKIUsUYRN0sDh+twHJraIX/kQ4cuOeekdF3XEpI7fZ9KCS6c/92TXfqLTuM2aQTib8AYYn0JY/PK/P6mX1n+tn2bUUzizaU8uDRD+Wp4UJ8RwO69LxH6L8BwtBlW5gLeuCgsAsK/bPfnDBmAJG/q7RFU/Do+i2+AiH9J25FIzWBJFxAwLoppuceBSIAszz2y8vkL84FlVFa+HE99zM2tVIwXAE4oQzR/hq0SwGNXd3X5KviO6bd6VAeUmr4BYPUe5TLiGSwaCKJapW2Yu5n57BYeBOS/787e8RWQp1IMLAKaXR9oSvwW80kSgKIzuwHOEmHKJLLQMU8Ia0S3jOmywJJSugw8TI1KyYEjYXB/05lDtPew+GyWV2c2Df+fDLCMFM4Y5U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mg9pzVUeWsMMmZNtzCrDEPAClpePai60XrmWnqVjJgqmA3W5yi53Pg3IZX1Z?=
 =?us-ascii?Q?urVszIQDuDS3U7oKaRlBVFYGe/kSz/JI4oTXsWa3rxkZV2/Tw9C39I4oyAHO?=
 =?us-ascii?Q?EfEFeCXRAF3Oj1eSgpmKX5YCAeXLvUO0KQm/V0BLMufy1eDQDHPCai58KSVv?=
 =?us-ascii?Q?63zyqTzx5SDfyFiUdtIiM+ygPV9wvwWkc4znxs4FDf0apYtkFzAdRRdrDO0/?=
 =?us-ascii?Q?vXBGjqYX8uYYSF5PZLyGZzerGClDYLgJ4UJx5Jux/cEVfCBrEmOvXUZI9kGi?=
 =?us-ascii?Q?XVgWzZFr3V+MwVdSv/zp2vHnRxM3CQukaexuwZ9damBNyEPU8Ev7iSh9+Ri3?=
 =?us-ascii?Q?f4mxkZmy8Ip5lQt5xuhpGOBylWT//KzFvADThMWLmM4DbiUI7NrWJc9YZZCW?=
 =?us-ascii?Q?nZzs4OQp/h0f22Y3FdFd7d8KsG4NxySh/GHSo8Bhvkw3KEfLfeJVIIVEDxdU?=
 =?us-ascii?Q?deQ2MNMX/PDLqxRR94mqHZZf14fBbS2FqewUPgwLPHRLfqs5RNYcuzCZ0ag7?=
 =?us-ascii?Q?PU6HZy1buYPGOcDsL7SY8ewGKDIrDxvHcYQzj5UmZKv1bQU/f9rbWs97NkDa?=
 =?us-ascii?Q?zgFW7q/j6tCIiyrBUw0kNuyI0zuyd4bFDGVr8K6DPLiROFgaPLBr60be/3pc?=
 =?us-ascii?Q?ntaNoNLTxFD1P58Grp3++oQqHdkJBnOT/LdXoO0B3x/kFFjFkCMVxEJEmmgX?=
 =?us-ascii?Q?kFkxUaSDjgdWEhg6oqdmIE7G39MeHc6Ey4l/cY72t6krkSk0NY6YOhD7VOkf?=
 =?us-ascii?Q?Ww2UZAC/ZFqpjnHt4okRm9P7VJuU6p2tjJe6ZcSl1YOZq9PcQjrXMFuj1igh?=
 =?us-ascii?Q?7nLvKyqOu4P6K9emiN/rZ6hy34qIghln+p/6Cz+7SovW9cv4P5BV0x50l1qh?=
 =?us-ascii?Q?zWuTB/UGKrzSbCDEFpyfTDaaTcJ60ME6jMeIyIpYWxq/3pv7ClodiuNMgJP6?=
 =?us-ascii?Q?z3t0iLsVh2sSrqyhMSxjflgQ2akOqsWCfv03B7ktL4L/AUyN0YJbw3Tlawjs?=
 =?us-ascii?Q?HO+O9CQAI1EERtVJDFUeuicv5A9fWHiOSx9nEvuTTFY5FFOT6TMlzkPuDQnK?=
 =?us-ascii?Q?ztaLupDTWgFD++0JwJm+O0FEBLdep+vD3s56dQQD6KNtORXjDKu2R9RUYdqW?=
 =?us-ascii?Q?0MRZrRS6o3lRIuw5KitsRg0EZeS/4evIHUI5d7pFPg11MhZtHUCtMDc119Aq?=
 =?us-ascii?Q?ANrkPrk5IxwcJzVGz7lhSPIlIzrzODCidpg/lkS9JHt3CGa3YDABNmshdfUN?=
 =?us-ascii?Q?cwzpULCO8WhorVanYRrzGU+yzMpEAZ2Cma00y6NxS4Nx3dfDOIJqlPsjOLt+?=
 =?us-ascii?Q?kuDlR2wthFKpAUbJodPvvxenkUsQ69haNHnkqX5yHxkslKH6LZbyz9xl8iV3?=
 =?us-ascii?Q?37Wc7RIqT3HRgOUBTsZ/GoN8CPcellUz+3667xsxFGzBwufdMnt8hPBOhvuc?=
 =?us-ascii?Q?UeIw/YKxX2sZXXj7zhuoZ2ZFLhgl8R0qc38AOlxgCeTZRRrb2RIdZmS7JttN?=
 =?us-ascii?Q?+H33Mc87LtOSqgmbToWJs/eF8TvOWLeRPanBedugUGkiw+KdMEBqSUg3jLcG?=
 =?us-ascii?Q?hVsG8rPe6gTA3XxE4poiXWzk8B8GNNo+UEfV9b05f3tMruvy0MdATrsvIpzC?=
 =?us-ascii?Q?DzSKEyXl4r0fhy+dqnAdz++e7a1DyNetQS24VbR/BNvbmy5feckhyBAjB8dg?=
 =?us-ascii?Q?d2voAKbCroJ5N3OrxvYE6peFZCz+RP3zqcVYGaKeRiKZuvVv688qN2u0h8qA?=
 =?us-ascii?Q?VmPkL8T8pvofyOV219MIoRBMjh2/ix+uykC7Q89mr2zGpGeAR1KC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e948293-491b-45ef-b4f5-08dec2a40f45
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:02.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UMQcxJSqn6GQ1mboo2msRptnyW8VQhryLoLSjLBp1dEtF4dW1fGWNOwBHhmiV4F+cBhI2ptr/QTSUS1Eev1z+WjYQd6N7wGvRi8m1sNL7Tl6zI4wYNnaWA/0nnvDg9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295564-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:from_mime,oss.nxp.com:mid,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA2686448E7

From: Wei Fang <wei.fang@nxp.com>

This series adds bridge mode support to the NETC DSA switch driver,
covering both VLAN-aware and VLAN-unaware operation.

The NETC switch manages forwarding through a set of hardware tables
accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
treatment table (ETT), and egress count table (ECT).  The series extends
the NTMP layer with the operations required for bridging, then builds the
DSA bridge callbacks on top.

Since all switch ports share the VFT, so only one VLAN-aware bridge is
supported.

FDB aging is managed in software.  A periodic delayed work sweeps the
table using the hardware activity element mechanism, with a default aging
time of 300 seconds matching the IEEE 802.1Q standard.  Per-port entries
are also flushed immediately on bridge leave and link-down events.

---
v3:
1. Update the kernel doc of ntmp_fdbt_update_activity_element()
2. Remove struct ect_stse_data from ntmp.h
3. Refactor netc_vlan_unaware_pvid()
4. Refine netc_port_remove_host_flood()
5. Add bridge.num check in netc_port_bridge_join() and add an error path
6. Remove the parameter ett_eid from netc_init_ett_cfge()
7. Move the implementation of .port_fast_age() from patch 9 to patch 8
8. Refine netc_port_update_vlan_egress_rule(), reset ECT entries after
   updating ETT entries
9. Update commit messages of patch 8 and 9, and improve some comments
v2 link: https://lore.kernel.org/imx/20260602072313.3162120-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260527100217.794987-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  net: enetc: add interfaces to manage dynamic FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry ageing

 drivers/net/dsa/netc/netc_main.c              | 940 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  33 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 440 +++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  18 +-
 include/linux/fsl/ntmp.h                      |  55 +
 6 files changed, 1470 insertions(+), 22 deletions(-)

-- 
2.34.1


