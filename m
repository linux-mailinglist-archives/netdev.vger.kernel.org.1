Return-Path: <netdev+bounces-292226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOV2BefAFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:01:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C95E24E7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B5D03015C96
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDD3E63AE;
	Wed, 27 May 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bFzNjFgK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C23ED5D9;
	Wed, 27 May 2026 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875966; cv=fail; b=aMw9a0pR+0j6g8L01iRJUC6VuUxqtz0s0bQdDbSRTBprlMswlXErlgiWGK07ttB50NRL7jd4EenXxE914HqwslLJk2Zs2t2QVSgv74a8vd9//NDVWDnJ+BwrLC/8ZDghkbq1aOAF2pd6cJMg41SMBRF9wvq2GUCYGDYwaTmcju8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875966; c=relaxed/simple;
	bh=RzdncWhDIT5vuEnShmvGicol+fKqKwLiwppgiUk4+2o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X4NrwHk3iPnqp23qieeucGnT/Bu3LsivF67mfVRV3AZGfkYo2to2pnLHpuBWCB4a57YDWvypSI4XuGdTWUbp5wjicMfjbPctrvqkiAB6eH4atVOX49bb/N8K/ffT87aqc4L6J3WRE1NqQ9VqIo4TinDlXUckGMN+0ih22SIxAdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bFzNjFgK; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDNthRWA2I6xxWDmC7zBgk0SHwIZmNehKID+7fBb0BIBZDKVsrZ+rDXKcG5Sce77k+FgOyk8jg5vz3xpsS3Abwe2HnX+5RahtUG4qgHp1UcJV+xCNmfsnNEHkdYeT+5EVV7l2cHYs3Pin8edV6XJNYeHNL7YJJIAJrBkPhHqZxpOMvYi5N5CVItLZ2jLXn+BA12gLKjfIHoqEg7lj7NBG5cAXq4F2O250sHuKajbHmtCjgqix+BOTTVh03P9z/YNlFifuN3iJrtQCAR+DGp8n6hJwKw0E9kbBUmyPORnsSDYCHG01bqeuSsBHsOgBdxF2y7rcFFGwLoclRbFaY15SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mePD1+AFaG79ukMOjTrZIF2pgBU7tXADn8HlkIPSQ/w=;
 b=upJYYu26HjBfi7RjNjIBO6VGb65p5cfogpK0A12tl1t0KK3vAZk1RhZ4zYjU3dL+lLaeKYvmYEbOUolaT0ZenMCG9AZ0JyeXgcjkj2CFriftPmME8VcG6y0234XhcMqUFRlYOIWGV+CK/SNLnOXZs7XIEuLVvBjHAqfnNpaulnXhU0V0oCyIeJOg+i8IOcMcGV11o1Ovg9we3Yn+IL7wt0KalWPwQspwoUdmM9Ktst1qtYC/Ctjf+JM9iYevD+u/HXlT3BvzjQL1RKgX9q/qIZy3wUb5NH4G0X5WnWxmQhn57+Z56L460kqpFRPF+SOHbp9CgAu6269+ZFSPkdDunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mePD1+AFaG79ukMOjTrZIF2pgBU7tXADn8HlkIPSQ/w=;
 b=bFzNjFgKBx/Tw7rfn505IWYNtngHBVjPiXEkprQfCia0Y6IwRm/ZlT806N6D2nkn2gD+BdvT+i/k0zdoedKk7Q9U1vw+pH9vQex9hBDBz1wThvH9cRtKOjMav67r6ibUi2xFdlodceuj/TaM+TEyD1k0sO11e60HKBsNS+eqMj28/aW6lcd5/v2L1xerWm3MhjLLaduH9d8cYlBd/Lm9jXiOhk3zs8Hsqyf+ZZZS4N0t/bJodEf9HCJn6BFfQSrLI8ALc1fhLtReLYGcZTJEL1emwVYO1589+gnFq2BjGmBDFabOTiP4zL6Dse82YlLFtV5jHFkAXb33XAhfeg4vdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:18 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:17 +0000
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
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 0/9] net: dsa: netc: add bridge mode support
Date: Wed, 27 May 2026 18:02:08 +0800
Message-Id: <20260527100217.794987-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aec70bc-12e0-4a34-9f0d-08debbd69da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	IIPzlQ+rOFggmP7+K9uOLnvWRg+jjy3E6IX43KpWctlZbBEZGXp17sprr1hyKf7kEbYoc9jsIrRPwPrkMhOOed+2JRxlsaQaUwJxmKPCRLxR6Ym8tNK6yUe+Rt8cvZtFMDpnmdVJXOEGGBEsUGyRnPtNC38zMI4RBli+t8SxN6YquwnTHzLRN8r2IP9Jg2waf9b06n5zDazpTUusY5x24w7HIAdTt/ArRW/Ey6rYhcnCMYmJzepGeNQOdBI4gO2uo/RXfvxzh5TtidnjhMO9w1EtshBeevbynrwSIiQmF8zv3BYEtbIaRt68CRSfVBdSVTNbDcsJVleMoZpbb/bLIZwtdXTFyFRMtp+mCyYXPq77ino0VTwH/2GpBybDr5VB3D6SQGT+LiOReey4ElyFs55COTgjmh0PxYkgF3oiOSA/xbb/B2EqAGy2Z7VtZtDEE/5+j6ATUFtICru1WArzrZbzXrWAWWTyqPWGEMjSEF1OwwiPRYWJoqQpcVy++6FEhe25qGNmnHZb9o3j1rv/RF9zwQdJ+157cc2fpiPulYS0oj8LTqlUX53/qvYTbXt6XB7MXM7ElcqrbgElpkS9yHxdJayiK+3dAogS8R7PaSP8zwDWsR6C2M5aeBQD0ELzl5nBfQx/KeVS575PR/MLlnyQw9kM3WnBcuqr0FKoP3al00XOOGMIlN/mG/rM0lbjcTiYxD0kcmckwWaKJTXJGv0YsgAWSqj235qyiIRMCDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EyUTlLosFosInwQN1p3sU9WpMXzwnoYnEV5JzJZX3Std9T10z9BSJH3dAMH?=
 =?us-ascii?Q?AixM3qv3vdi4eBmen15OKobHOJMfDIexPv1mZLQXSA60+srixYDyXDCEcx/h?=
 =?us-ascii?Q?W2LHELu/zhUe679E7ba1W3sfbmMOYJueWzHDhOgWWVfmdxW2IeWl1/GoIcGY?=
 =?us-ascii?Q?+fE7bQ2c/YkhwV7byRVsPjZQWnMAznApAh043dkW9YWnxOKTTYKjpSqV03ds?=
 =?us-ascii?Q?cV3GglWKP/VziRruNFvna3Y+kMj8SWm+bFLBlFKbyRQk0sVo7j7dCwv4YkQY?=
 =?us-ascii?Q?KAt+0nX8RLJ7g/aRO8t6tU7D8vuDJd0iGIFT0V/+b5nf7CatTmwIBobZmcyb?=
 =?us-ascii?Q?aHi1GsuPHwFaq+MAeeaZASRmMoFNmrV9Gr1pRixX4JMzukTJYBYA/tJDD9AB?=
 =?us-ascii?Q?M654rIYAHlGkMk9fZuPjxOFTWPuwZY79h6BZkxmqLrspZr76xSpPo2Yd2pBu?=
 =?us-ascii?Q?gU56SvtnL3KQo/aUH3iQLLLrjLST04Y5SKnj2mMeBtJmFG3umJlsbDjbskFv?=
 =?us-ascii?Q?XeLCTtsHFfxbzoOqB64CeFSAgp7FFPtZm3z6BD0HGg8+ClruGajVLemLlJUj?=
 =?us-ascii?Q?MyQN2bMYE5Gwc/Tv+j+A3eMIQ4+SkWQorMKicNpXX/MAPptoBrFzUO/IntIJ?=
 =?us-ascii?Q?zpqzWsz2AbVJZ2Yw6n7eReSQj80jWkSITe0n3tzvQDo7mkQcFeA/cGxZ+SMm?=
 =?us-ascii?Q?o4O0FO5EnHoFFWDpXBnPf1on+H1K8UnH4Zkj4AGxF8xS3CSaxXYOyqicXgn+?=
 =?us-ascii?Q?Bq656b8iCsRFmsLX4QvQ2o6868p+P1zXJMc0ztI0bHR85zmtIGVNz9p3Qtya?=
 =?us-ascii?Q?idauBZjiXdwtoAmppjgQkx4sOEMLv7LzcO64LAASSKGQvUCUInTlYuoXz+FA?=
 =?us-ascii?Q?4JQPukCZgI51S7VcusO7QiISPAeUTFl4rBO5bYZkXQGN67y+Pa9pAsekxhuI?=
 =?us-ascii?Q?+9HoR94dbY0HxGuWovo0/GwatouXFHuIcm0gbtwFzrK56IPgYca9neXbdTBT?=
 =?us-ascii?Q?B3pezlwT41POFDmE8VBVAHo71Ts8EQ7h1Kp1p6RjAln8AOgJsxo+eiKVkyRa?=
 =?us-ascii?Q?dtFUjX0/J2kskpX2X7UzgAy8FkY0thYWBczesLlV2rh1Jc1aZqTRb1AOLmrb?=
 =?us-ascii?Q?zB9mIABBAtUHNVNAOP7YxX1fA3uXy3vDIScLjHl7Gw2ND/GFFLVmVmqyLOGh?=
 =?us-ascii?Q?G5CaH7R0HPOk8t7o8AFW9jHiBZhZ3nq71DhN99fyMr244gho5lA8kGDu5m/T?=
 =?us-ascii?Q?qPWiP94ql3E4S7lpxS17XeyfQY0re+T+IA0JoMEr2jsyamjE3tijhJENrhfq?=
 =?us-ascii?Q?8q0jxKRJ0C7OpSGRx3sKV9/qL/riJxYKxfanQPwneO67+21FGYH422mrd0dk?=
 =?us-ascii?Q?JCSBMwmq1703jCtBcCJAEXw1Nu8izzi5OpR6eYL88dA+fjs67X2pxGzV/P/j?=
 =?us-ascii?Q?VdHIJ83ooTcIoki+SjjNpTTy7Qnrj9JQWVxL2TzvbmyWKpZmD2y+oyOMN2bk?=
 =?us-ascii?Q?MOafEJWhn38wKWER8+xBXnHcSEOGAoZ2NizyO/lbkyaaO97PiHgYG8XKvLBz?=
 =?us-ascii?Q?CmEvhSHtbbYpQglTbKbtD9sRh+YayBZ87fUbaIyKFvYlhVguCMMc5DXHf4OJ?=
 =?us-ascii?Q?a9YSYnqjPa+yCUTsTAqQhx8iTB5FskxDqTggXc0dwmaf3V3w5w2Cwo9cb7rx?=
 =?us-ascii?Q?VX0sRTi4wKyfUPCRHSnj2Kj3W6jIEX0S1O6oT4EcrsLYSpMUqMNkCVLCBHyn?=
 =?us-ascii?Q?y71DWo+TjyiMWnxNL2egVQ0l/4eHRIfnsjt7NPvkJuJ2ksb2Lt74?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aec70bc-12e0-4a34-9f0d-08debbd69da1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:17.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjT+n5a7UolbxnWGP5qjvWwQ0Wik93uf6CugAEf5i458xyBJbsQwnIDMmemoFjxcCZE/kat8bSvwWlCbzsceGOJNQqRh6eNboENRpRjE7HjWXYrSpvBblqfKJ5DF94qI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 5B5C95E24E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Wei Fang (9):
  net: enetc: add interfaces to manage FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry aging

 drivers/net/dsa/netc/netc_main.c              | 882 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  34 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 431 +++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  14 +
 include/linux/fsl/ntmp.h                      |  60 ++
 6 files changed, 1413 insertions(+), 14 deletions(-)

-- 
2.34.1


