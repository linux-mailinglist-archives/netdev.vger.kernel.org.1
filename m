Return-Path: <netdev+bounces-267359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN85Hbbcs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:45:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5363280B21
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80BE3302FEB1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE6386550;
	Fri, 13 Mar 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fgyTcZmB"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438A37D13E;
	Fri, 13 Mar 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395107; cv=fail; b=NiwPTnEl3LGHShqT/r+bgdDnpTGQb38kQ9L7ZuHKNsUJw21Bl90Rrgr/1pTb4lwjRvtfrH8y+iRUsHHldC5apVInpZgLeUu0vHM5yu85RS6Pznfeod+uCqHpb1K1xTNVx9K2hds+Zyy1atAejN/MoO8L50/3Bd3SUECOrdjrw0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395107; c=relaxed/simple;
	bh=0/ekdzRzk1T+/HnfbkxTCWRunLsCKyaKvGhCBlCnq1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=by5B7kqpPkbP5rUjeqnQwf0xR7ZC/SX+VTVtHgc4BQ1XvxxBrzcDcJASqMzTls+xQi9cLYu9xvGbDNVz400a0Hdf2PgqOmkLnidjEtaOUreTTNSVKw+SOZ2fhz+v5knHBLFa5+CiEEqRatp70Z3p+FqhwUf5se0RKr1a0vRC+O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fgyTcZmB; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkD76rLe8tEaYMFda7Fl2+YqfDQMGcYoWFbgQoucoYUTdzMZ0TckOIdyDaUmiTpwRufIhs5cE4hCbqFIusUqVlbG2InQTq8UtOd2Xug+Z9TsYBAnmO7G7ii9jLyWisCHLHWxnQp5Lo3lXaVWUVB6E9eEpvCrylnAzlo9US6fqeerg+A1ncUssTvuEk/6KJQ68yx2Bm4b8B6ngmz7K3M5BfcFp51h9Z8M0P/2GITTSpChUbjjrkmNotRkcDObTz+99vznL9mTPq8cAQe1FgyPo+pA6FJAshKrjhLljcS9TIVwMucJ1D6GVNNAm8m0J3KBGXvbDPeCledWououa/HQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhEuOM20/pR0ei9IIlTgglND7MbNzWFbTQu4N38DIgs=;
 b=xCt0S7zFPtuiLBqal1yEWRG5vrUormidzhh2bOk3IeUN7VDZCMwHmL91Pkz+Yz9sGWsm3TzYCKT1SAuke1KrTQvojdNSsFXtRfXO3Ny0iywFMjr+UH8E2Fkz9weU9bHe9Ox4/Raporm2wOduzrTsbTm8Jv0KcUo+UukMUjtzamNRRe1p8MPI71E2fpzhgyHQ0Vlujruofs06o6soIhGMSzGOA9aKvOidvnwdqxjM4vY0lqpgHJT27g4KpWW2sXm0nRg/NZnWchkouKnL46R00eLzcBd7eyb8BfsTo+FH95UaNwNesAb/3AVEWEDwT2wXHVhPxqRfBgDEpkBRXofE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhEuOM20/pR0ei9IIlTgglND7MbNzWFbTQu4N38DIgs=;
 b=fgyTcZmBTbL9BQO9E0GcJuU8UCG+RMyLxgjiRRI7xcCgEGVK3g+dmWtYUqfK07qwk7VHqIjk9dQxgFThndKKQpgwwwJL1pK/0MRQ9KMOdUc92/B0jfuBvibqovBXv9PzBexwVXgoXnxlSRuBRaOYXMGbIneMXRgA1XUzXvo/rcUzOTJkim0KC+eE2rqTfS2hmZ1IIp5DGUal5ScSS1U7NeiWScGw/u4ZlhjJQc5ZFvLJyfqQj9e+BOPeUnW+hrAEXWYv22oDCgxB+q7+VrMc6hbXKnXkem4gtRo5X9jVglXQ3zECCwhhFqeWQWZAvGKaLC1oMDGy2ByPs/AOC2EKEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Fri, 13 Mar
 2026 09:45:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 09:45:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net 2/3] net: enetc: add graceful stop to safely reinitialize the TX Ring
Date: Fri, 13 Mar 2026 17:46:43 +0800
Message-Id: <20260313094644.1132411-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094644.1132411-1-wei.fang@nxp.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9e480c-e64b-4399-42cf-08de80e53226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6K3PmfCKio5jUv0YxGxKrMXxFX9hBCx+pThxmuvxiLA0juki+GH5czWN0ha05lVYUt+W5HWDB2kVV8Qx963hB+ST2LSUB47OIoqbU6xoEl+DFhBdbQbdXD8FTv6jrz8jPf25eH7SyfPu+YopXiUu+or68R9/RvpbB0Ipze6+qCL0ukrtg63DPqLXhfT7Pejf7/T/MhBovgCqVBSxPL7a7aG3UQKfRTgm8QpEcRpYzapiDPZ1shhUwDgqHAU4S1Pmv8O6upur2Ibs2DBuSP7q1BLdt2wnwpusFXGCsfTAm6oWEUYJjB8HMSDDQginmBnLNYl509FfTA5sVIr6aymLnKshx81WiUVUyATiHBpPnOvOEeUe4uzP0Bv7gnvz8QEKEzap91vJvQq64BIKOTIgMLIP8AGizQGcMX1P0nveuVy9nilzTgRdIly9qurgPXlBU1W6NvB587U1psH4kesYimm8AxRezk4I77w4RYx2stn36W1DKAt/i5UlGBdWRf9cJQ6JMnGUTdQznpulSoyVbhRT/vwV4v0z87d29btPwwhn78iyxd7w3xSr1Xz6L5oKs+W7ETNQtm9nCSBqvhhRnYsYrdJZhec8fumfCsUxwRmTZkWgRiQTTLjuGnodSmD4rP9vbLjCGbgNawpXZ1jhMQJByBRRGF6TpRsPoEAuEw8Df01bCGPpHTAUL3Nxaye9i/FYeL4zRa4fX5r7/sLFFm+vpJx/+Wd2xup884PvCVqTecmLEspG59BgRcrwoQJbzPWkmZtZkNbPkkpiceZwz1N2rrI6lUP/LvPUj39dGdhYbZw4hg4PHho3CoPHDD1T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ohPniGHJpnB/lbbq3BdfLUEwJaAkDPp644KyOaiWVd1FIow1R9jz2Jirc3p?=
 =?us-ascii?Q?vTBTbkZF0hzzOtFiF6fX1scNE0unaI6YDqLO21Xs1DuS27LD4yzlUwdwZbVB?=
 =?us-ascii?Q?JDAdv30YqcrQdf+tcn8QhgWJXUAzjyMXRSGwaUkslLS7DEHER9RlEQFMmGSp?=
 =?us-ascii?Q?nlDXK8Mh+a3OkWlL8eZmFGejVGcTzhT8t2ik7VaBV6t/IQc1y719F+drlQ2o?=
 =?us-ascii?Q?wEHG+hbuzSJMup874oa9whDAmAo0lCkxLewLkwm/dPf3+HdheXt3wtLmVhUP?=
 =?us-ascii?Q?ixg0QSBsUsAfq3+PeXU++qHKo6aBHJMZUbpTIExRlKMfvXPp9TomAKcCBUsq?=
 =?us-ascii?Q?1yptvwEuojuh1ZCNpet0MDEZ6yD2V/r3VI5Ln4mRpPYzy+5tKy8ZEnYJpw6S?=
 =?us-ascii?Q?gXfzzcBrrSf9kejUCl2lz7g9aYJuR4s1r+FFjYHwe/62smLc6vopqRGiGjFl?=
 =?us-ascii?Q?UN9In4SiWT21RVplk/r67EHVf6gSZ7nNAS+eGiL6dyj9KVs2CNtsemXEuQH7?=
 =?us-ascii?Q?xtrMAQubQpRnOEWyQ4gbX+0zY22t7j+kPfx5W3liESoI2gkWNgkXShu0ygvj?=
 =?us-ascii?Q?VpxdkF9Z5ybxaTxaCedetWKU2rR0gJEojSnn5eTc2qpc4HDjOR3bpgrPV5KN?=
 =?us-ascii?Q?K2kCZsUUeUOX7imR3qHYLdvumCIUWwS6wd3poKyIXOFqpnTq0ENiMgmq9s3A?=
 =?us-ascii?Q?PQUhlZLe8Cwr9KnHNi1yNnPLHzx4rOy3a/6AzKDfvII0XzqrakEUEIZ7SJdN?=
 =?us-ascii?Q?aKvUDys7K325pPf6uOX+2abZDssJ1Z5t93ZJwTpUu+M57SmppqNbM+4wc7ao?=
 =?us-ascii?Q?rXKU+E+jJ0nSZaJYPIJdBAUm1lL/E8jURnrd4vpv+qKwupT3GxRLRl01arQp?=
 =?us-ascii?Q?Y2bxPLZZdnC1k8jcEMRw/dcf+eNhY9dcDyKmeMssszkl2tl4YHi9lgGdHpEu?=
 =?us-ascii?Q?YKAcNOag9qGsPPnwbCORgEStZ2wkj42uj9O8HdPDJhs94v/Hz71YYmpXCMLx?=
 =?us-ascii?Q?cJ63opTa0IlmIVlzVSA30s66iKkaKGfWUyH6g3pDfqvPlJOc2EzxbmUt9HQE?=
 =?us-ascii?Q?F0ysYgC0hfBGT7cBY0nxRKSrlbksYuJlXYVMFHEsiAIGeWq8LW3cIxf9QSjO?=
 =?us-ascii?Q?ObjQ+BfCLXYWz5JerUTv7ZMKPzD1mdXx0cOOFHVVWqWCScOZ4U0RQZghpevA?=
 =?us-ascii?Q?0XzPEyzikhFFs+wwk/jMuKp1AW+wAyNQhfjvPzCzksMcWe6J15t8a+hLZi0r?=
 =?us-ascii?Q?vKZUOgP+H3bLnktNd6CoLQMD7c4SonnYoX24VIIhLS2y7idlVSFuywnjxANQ?=
 =?us-ascii?Q?J7NATFzYWopsH7U5IxQHtYm+qaYz7rBa4U3DBu8eWfvITuGFiE/MJEDvxufX?=
 =?us-ascii?Q?HbvHtU65id8E18XoOY+moLxFf7zsE11FUAJBz+iCeeTltK3XKDEO1bWlfdvV?=
 =?us-ascii?Q?0lUW+CiMWMEkWnaQwMoWHsy/4baf71Vcg84dnF9mETok99SCU/X76ab32t5f?=
 =?us-ascii?Q?KAyPF3sBHZgD/p/q/vxAMgsF2YfzY0URVBwo/i2E/4vCyDzzrC+ZrN3sbKM7?=
 =?us-ascii?Q?5uNd01T6WwS3dgrqBavrkFYvLVK6b+GoO8sLVo4c0fKc5DTEN8j1MmeyktiG?=
 =?us-ascii?Q?/RcMPbhlWM9/MBq6KdSQdFnABFlu/nAZonper6SdC1L1HmE41ftt/XXSCmAk?=
 =?us-ascii?Q?LMjT9fP4x5sQWLN4HY3OHUL1ktObHLP0Vm0avKg71x/GFM/7b0QBu9IWVzmE?=
 =?us-ascii?Q?3KfdN+srqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e480c-e64b-4399-42cf-08de80e53226
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:45:01.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSi3VjdsUkUqYTO2CE5620u3Tv20P6CyZ8AupFA7gGrVBB7LINxdAdSRYU/P6OGBjrqPfOmMs02oOcHffoSNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267359-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5363280B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v4, the PIR and CIR will be reset if they are not equal when
reinitializing the TX BD ring. However, resetting the PIR and CIR alone
is insufficient. When a link-down event occurs while the TX BD ring is
transmitting frames, subsequent reinitialization of the TX BD ring may
cause it to malfunction. For example, the below steps can reproduce the
problem.

1. Unplug the cable when the TX BD ring is busy transmitting frames.
2. Disable the network interface (ifconfig eth0 down).
3. Re-enable the network interface (ifconfig eth0 up).
4. Plug in the cable, the TX BD ring may fail to transmit packets.

When the link-down event occurs, enetc4_pl_mac_link_down() only clears
PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
ring after a link-down event, we checked with the NETC IP team, a proper
Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
graceful stop to the link-down event handler enetc4_pl_mac_link_down().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 3ed0f7a02767..719c88ceb801 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -134,6 +134,12 @@
 
 /* Port operational register */
 #define ENETC4_POR			0x4100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+/* Port status register */
+#define ENETC4_PSR			0x4104
+#define  PSR_RX_BUSY			BIT(1)
 
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
@@ -173,6 +179,11 @@
 /* Port internal MDIO base address, use to access PCS */
 #define ENETC4_PM_IMDIO_BASE		0x5030
 
+/* Port MAC 0/1 Interrupt Event Register */
+#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 689b9f13c5eb..53cecbb23a97 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
 	enetc4_pf_reset_tc_msdu(&si->hw);
 }
 
-static void enetc4_enable_trx(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-
-	/* Enable port transmit/receive */
-	enetc_port_wr(hw, ENETC4_POR, 0);
-}
-
 static void enetc4_configure_port(struct enetc_pf *pf)
 {
 	enetc4_configure_port_si(pf);
 	enetc4_set_trx_frame_size(pf);
 	enetc_set_default_rss_key(pf);
-	enetc4_enable_trx(pf);
 }
 
 static int enetc4_init_ntmp_user(struct enetc_si *si)
@@ -801,15 +792,105 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
 }
 
-static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d TX is not empty\n", mac);
+}
+
+static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	enetc4_mac_wait_tx_empty(si, 0);
+	if (si->hw_features & ENETC_SI_F_QBU)
+		enetc4_mac_wait_tx_empty(si, 1);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_mac_tx_enable(struct enetc_pf *pf)
 {
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	u32 val;
 
 	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
-	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+	val |= PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d RX is not empty\n", mac);
+}
+
+static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	if (si->hw_features & ENETC_SI_F_QBU) {
+		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
+		val &= ~PM_CMD_CFG_RX_EN;
+		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
+		enetc4_mac_wait_rx_empty(si, 1);
+	}
+
+	val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_RX_EN;
+	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
+	enetc4_mac_wait_rx_empty(si, 0);
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      !(val & PSR_RX_BUSY),
+			      100, 10000, false, hw,
+			      ENETC4_PSR))
+		dev_warn(&si->pdev->dev, "Port RX busy\n");
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_rx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
 
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_RX_EN;
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
@@ -853,7 +934,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
-	enetc4_enable_mac(pf, true);
+	enetc4_mac_tx_enable(pf);
+	enetc4_mac_rx_enable(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -862,7 +944,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
-	enetc4_enable_mac(pf, false);
+	enetc4_mac_rx_graceful_stop(pf);
+	enetc4_mac_tx_graceful_stop(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
-- 
2.34.1


