Return-Path: <netdev+bounces-276295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA+yH5D11Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:28:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383A3B78E7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FDB1302D961
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE13630AE;
	Wed,  8 Apr 2026 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NpNR/Ez1"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903253612F6;
	Wed,  8 Apr 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629483; cv=fail; b=AwSPNwXQiyMUF2hQOPrn5Sq7Q+4f3RHZcZMbeUwL+uPm6hZccbdFPsuextrzoQ04uSgI2VVrw95YDopizWDZpEsTlQcaZRzZe3HfnaF3VWZHP/MXAD5C57525sClnJpCBFG1ESK8VH0QEn3OW1ra0rj+AntNNk+U97pjh2qc09o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629483; c=relaxed/simple;
	bh=7+HZCAKu4Z29LKR4unBwNVSNxU5ppXD5rB6dY0Q8gXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OutCTCgyzQt/4a0U5IOPLlF7mv7h7EBMkTqmBnxmUeCM1867xrCL+C0ShZCt2Cy++cJNAqY8ZKQJAdMBhBfK/k+fMpKpVpl4tNl61xrQ+EWcW+dAu5nTTkcA4J+uTOcLQOX0GuDzGdTh6E6GFYx0d/7cM+PnP2uf4xKvlStgsqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NpNR/Ez1; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D28HSNIgbvFWfkTv2vroOOp9KYKQv9jNz1S8VYpX6QNc6BhF6QhHXWDNmMxeVyj+91ao2mcDQYmQT/huyUmKWAuBIzNLBU3xZjI4GuWS5eX26TZ+vzzTWl+ZhgcsavbDQnqxZHhRByRkDLUhFHYrL+A8TqTLLjVlxAgeCZPFqPBq4lrKVMtif5aBd/kpcLubF0tmm6UxrsiekZGDsWAjX5qfco4yq4Aa2FDGOXGXg3YdJNvwYGCcaY99oMQx6ybxWu8eaXYwcy0Qqlgc+2dz+rbmRCRrB1n2HVd1ttGf90OBHgIDxQcPwKZhv71NPFlDGTizyQKvApN9JT5JgK7pgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF53HOhqJ9rGZT0qGiwtfg+KyNgg8BJ4zQze04PdNgY=;
 b=seBBciGfuGGXv/nhgmFtT/w5+yp8FYJqqehDJ4aGA6ScMtXS0OAwh+uDcKB0fh2MO8vc3d3qJUPzQbVTw2Kz0QASSRmd1g0506Q4I8PgSps78kzcyR7cZvANMUL4ggxAF25n4RN6jR4NKFlKElAD89TAngx6uZAJuQzNoIYjHNqaARo/rU3bZA5FT1cGG/hfW5ooCGwAATOu0ljaS5JRWuHvHA0UBQ31+y4lFMKDn4CwTKYnI7ptDJNmFIb7hE9xvKAmZ0nCO4IpvjjuEKR5iGILfKEtiFb8F+kzV0X49R1lYYRbUWIhWhZ3a9POzMvvHBk17tUw7oPJ81Xyd0jR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF53HOhqJ9rGZT0qGiwtfg+KyNgg8BJ4zQze04PdNgY=;
 b=NpNR/Ez1oIMTPVNWcubtueSZPFcihZjfSemx9azf0pDuzvoWIlVIH7ap5tBbuidjxuZrGGCMf/CNHWd3gyRycNBBCRCqWKIdVU4jBO695Ere9xST2NVv6vsmHPq/iAcxrzqplkxCPehaLXdt05+EjzsNftIyUU63rg4MPN4fKma7k2LpL8sT59lQyDshzhGfjyBLZl+giJLgf5aywTyk74W9RMcsbJGAQulTk/ipbXvQ8QlY9s1f7QgXOolPIgglTAn4i1PjcqQdf99fNxW26gSZoe9JwSSBxQ2FJwU4L1VDpcmmJkjADNdxH2PYqHSDG/IUVuzj1YkLNrB6ATO/mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 06:24:36 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 5/5] net: enetc: add unstructured counters for ENETC v4
Date: Wed,  8 Apr 2026 13:58:49 +0800
Message-Id: <20260408055849.1314033-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
References: <20260408055849.1314033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: b52142d7-34c5-4719-8562-08de953780c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XjysReoqTXhe+a95sdVH5X1NEPP08bwG34LbdjdkVUTNcDom1wfX1cPFVhP6y0x0mG6T4Xg4Fv13Pfx2ypkqU5n/McAy+gpkulitcZQEZMS8U8yvqPa7A00OScITP0AqRG0wXzsdll7wfwho05EEeWqCncRzFeMlq2Q5urOYbAanftb0ljqTFDLw2Jlj3TyWv/3yAu6VxdGM/X+Oq2k932QZY/+ID8PMlxvf+44gOqPaAHAShgYBqLJB9nHvRG7CGh/+63L5eDvjC6O0xDRJQFFzSgKLDcX1CoUVygRqxKvtADWYIWWv73KP3u22xWgbJrCjtgK17+p9gUX01qWZb/SYWLXTOHZEKTssq/6dnoWt/xBXgUaGYe37iFAVPyBOMnXNzy5kDT8xgJMo9UbVi7DGEr5zB5iswHvEUkWgs6eto2qJcivW9cYIybMV6XmUykxINZDIAY5yFTdkqgyhsMTGgosqtTYFgsYvg7zW5033e0zkbdPLvoqZYcLaagNaWps9elagQx6A1bBhdU/Zvh/EwAmzZGc5l8VK0A1lNDzvlD0EGAt6+M93yo359R7QQt9ht6pMARIx80K9m23OEVa1yqHvo6l3oAsn2/BSkrAaoJAja1dPIS06uGqvr/8KbqGf9Ozch4RNLunbXLPiN3O5/wl93yO0RFwYJ4nD2EjeXnOmaka+L06+OjzraBb1VCCIJiXxKXufGsp/re40SDH7TjHPe3hSXGbSso64jYB5X5Uq50iNLRpWL1/lm+5Eaq59qad3hL47NH6jqM0FlL5i4MBnFoADE5eChKnUUYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mu8Mmrqfd+7Im8djrdKtE98AjHJSlJROAocNPwQceKrVomfxEVac+gOYnf3J?=
 =?us-ascii?Q?yvPQ8SFEyjcKshX2iMAwwQhxtDdiI2GFlPhj8RYqwpVpO8Z3zIY7mHWkRoKU?=
 =?us-ascii?Q?t0w5YIOw5K32Inl1SZKBb8Q/61nwxzMlNu8I0v2GoCMIvyOGq18PWjrcF037?=
 =?us-ascii?Q?06NSGj8lC/bYbsWjzHv7nOlg9l8GTYs8iK+y2BHHri0ZOtr6wg/lFh0IEDLU?=
 =?us-ascii?Q?FfqdCVfiRGSc+0oAmRYSUMc3gmjbvbiCnVf97tb2sOAlQXbA7wyBCWstnLQX?=
 =?us-ascii?Q?6caIJnaIpjHHvjnNXjlbXcPwISWUw7vPLqQpp0mmV/H0ZZrrJS5SGQW4eLSJ?=
 =?us-ascii?Q?jz5hKcguajZpR8Mv4bE+Lt/7pkakgPeLKD9TBuJBRLfvgSfly7mDErlXo+Zt?=
 =?us-ascii?Q?ah5vrtpzJWwVcs468oOZ9wA4abi6b0al07s559PTGHLHeogANAHPpCNZPU57?=
 =?us-ascii?Q?H7IW+JBmqjz0lkMJtg7NINxVvQIlelt7BGDPVmYuMFAreN/HFhvtjIW1bnRo?=
 =?us-ascii?Q?e22NaNnkaUWA4733Fk2W+inYHRsfgy8Xpqs4uSQNRQFEi3p8OmbpM2xiqvOB?=
 =?us-ascii?Q?j1ElLL84hEC2Nruc3xJK+dHTnps74NYLHi0cA1Rvxm7xOasxwcM1BGira4jT?=
 =?us-ascii?Q?ln9BVUmfqQomoRBGylxWhSp1l68iN/v88Wfr6z5II8HuVhsGcS1P7i61ML50?=
 =?us-ascii?Q?TMFcSwuISoVHN0q6dn28pJZUOnuUFFybNGxttY2s6nVb9YRLsyttqqnKQY6/?=
 =?us-ascii?Q?Vg8NQjf4LyzgBIUS3wmoFzqKja5NihKE/EWFSDFjkvrNMJh4e1gA1f2Itnwj?=
 =?us-ascii?Q?9AYTVXgnjfbkHi8aJpteJCV3RWbPn15FXk3bjT12L+uMd4oFNWDpPb9zgGKM?=
 =?us-ascii?Q?ZPjFJryEW/UJKCmQptmmB5kXqESq0sz8tFEmb/UED1qGy2dO/W1M9eS9njkA?=
 =?us-ascii?Q?0hpfBG2BwaCp12II2gt6GxCHiIWAxbFtjqr1m7DaueLvLrNXhwbQIoofEWLY?=
 =?us-ascii?Q?MNpwDXtHyMhkbvQwzFN16K3GtvzhsV5aw9/XhRIKyWMCdrgZHt14NMT2ugLu?=
 =?us-ascii?Q?5qG2bYo5vPfbKmHc5glm9UUAZMD1cqhM+ekxW3FGQptu8hielb3ghjMyX7rq?=
 =?us-ascii?Q?nrIVvYAiVEPdQ72gN4BwQsxichIuHJXZIaAsxHmh0mSeEELP1MnskbAsOGc7?=
 =?us-ascii?Q?+PCv6fUfeZgQzejI51KWBnbFnVu5RDS16U/IshBC8OeHGmznsRJWFvEFKJvQ?=
 =?us-ascii?Q?NjZbstOM9SxbfTpemN42ZI+HHHrE2PRNa5i0LqaHCWXtCOCvOqs/vVuuAvXZ?=
 =?us-ascii?Q?aGjKVvgtvdmE+1DAnkMc9e+DAYE52PCVzSeshuXfUsjVWcl54Sn2kY9/JZY5?=
 =?us-ascii?Q?C/kbMkjal6S3qAtzFH19IObbggREbT7XahypsW30RqN2sxr/eH8seEDmySna?=
 =?us-ascii?Q?Ox2rG34pV/sefXUowXjgZpXg7f8q2nTFB+NXPRQ3K9JXuCWRCaUIaGspd4Ew?=
 =?us-ascii?Q?Kgz7araL19YtZMEgLIxykukPK0cyTp1YbBB78NALvKfiHl1Zsaahe1zrqJxP?=
 =?us-ascii?Q?RaMgekCI8P98nY8aQ7OfbVIfgqzRJhFMwDdwKFKxti65Ued4Rs2+5KZVx8PO?=
 =?us-ascii?Q?j29Z3OIB1XQs6XxHkdkzo9qguMt4XwEUv8O4KMlsgrUBqdlV66bz2epYvfeo?=
 =?us-ascii?Q?S3BtyRxolHkto6A8iK6rRS5lzIdBk3Ma2F6hCJ58dHYDT3/3kIk9Kh4dTtZB?=
 =?us-ascii?Q?oa5ISwKenQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52142d7-34c5-4719-8562-08de953780c7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:35.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3Hh0p7sTb6e5jSh15b6WyqEQ2ykhKQ923+YFkD1BPlfPYKlzHsNooIyTigziBITlwA4UIEXRV1dHeM/XylGXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-276295-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 0383A3B78E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Like ENETC v1, ENETC v4 also has many non-standard counters, so these
counters are added to improve statistical coverage.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  72 +++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 187 +++++++++++++++---
 2 files changed, 234 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 392992a646fb..f18437556a0e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -64,6 +64,9 @@
 #define ENETC4_PPAUONTR			0x108
 #define ENETC4_PPAUOFFTR		0x10c
 
+/* Port ingress congestion DRa (a=0,1,2,3) discard count register */
+#define ENETC4_PICDRDCR(a)		((a) * 0x10 + 0x140)
+
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
 #define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
@@ -72,6 +75,12 @@
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
 
+/* Port broadcast frames dropped due to MAC filtering register */
+#define ENETC4_PBFDSIR			0x208
+
+/* Port frame drop MAC source address pruning register */
+#define ENETC4_PFDMSAPR			0x20c
+
 /* Port RSS key register n. n = 0,1,2,...,9 */
 #define ENETC4_PRSSKR(n)		((n) * 0x4 + 0x250)
 
@@ -79,6 +88,12 @@
 #define ENETC4_PSIMAFCAPR		0x280
 #define  PSIMAFCAPR_NUM_MAC_AFTE	GENMASK(11, 0)
 
+/* Port unicast frames dropped due to MAC filtering register */
+#define ENETC4_PUFDMFR			0x284
+
+/* Port multicast frames dropped due to MAC filtering register */
+#define ENETC4_PMFDMFR			0x288
+
 /* Port station interface VLAN filtering capability register */
 #define ENETC4_PSIVLANFCAPR		0x2c0
 #define  PSIVLANFCAPR_NUM_VLAN_FTE	GENMASK(11, 0)
@@ -87,6 +102,15 @@
 #define ENETC4_PSIVLANFMR		0x2c4
 #define  PSIVLANFMR_VS			BIT(0)
 
+/* Port unicast frames dropped VLAN filtering register */
+#define ENETC4_PUFDVFR			0x2d0
+
+/* Port multicast frames dropped VLAN filtering register */
+#define ENETC4_PMFDVFR			0x2d4
+
+/* Port broadcast frames dropped VLAN filtering register */
+#define ENETC4_PBFDVFR			0x2d8
+
 /* Port Station interface a primary MAC address registers */
 #define ENETC4_PSIPMAR0(a)		((a) * 0x80 + 0x2000)
 #define ENETC4_PSIPMAR1(a)		((a) * 0x80 + 0x2004)
@@ -141,6 +165,18 @@
 #define ENETC4_PSR			0x4104
 #define  PSR_RX_BUSY			BIT(1)
 
+/* Port Rx discard count register */
+#define ENETC4_PRXDCR			0x41c0
+
+/* Port Rx discard count read-reset register */
+#define ENETC4_PRXDCRRR			0x41c4
+
+/* Port Rx discard count reason register 0 */
+#define ENETC4_PRXDCRR0			0x41c8
+
+/* Port Rx discard count reason register 1 */
+#define ENETC4_PRXDCRR1			0x41cc
+
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
@@ -199,6 +235,9 @@
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define ENETC4_PM_REOCT(mac)		(0x5100 + (mac) * 0x400)
 
+/* Port MAC 0/1 Receive Octets Counter */
+#define ENETC4_PM_ROCT(mac)		(0x5108 + (mac) * 0x400)
+
 /* Port MAC 0/1 Receive Alignment Error Counter Register */
 #define ENETC4_PM_RALN(mac)		(0x5110 + (mac) * 0x400)
 
@@ -211,12 +250,27 @@
 /* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
 #define ENETC4_PM_RFCS(mac)		(0x5128 + (mac) * 0x400)
 
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define ENETC4_PM_RVLAN(mac)		(0x5130 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define ENETC4_PM_RERR(mac)		(0x5138 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define ENETC4_PM_RUCA(mac)		(0x5140 + (mac) * 0x400)
+
 /* Port MAC 0/1 Receive Multicast Frame Counter */
 #define ENETC4_PM_RMCA(mac)		(0x5148 + (mac) * 0x400)
 
 /* Port MAC 0/1 Receive Broadcast Frame Counter */
 #define ENETC4_PM_RBCA(mac)		(0x5150 + (mac) * 0x400)
 
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define ENETC4_PM_RDRP(mac)		(0x5158 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define ENETC4_PM_RPKT(mac)		(0x5160 + (mac) * 0x400)
+
 /* Port MAC 0/1 Receive Undersized Packet Counter */
 #define ENETC4_PM_RUND(mac)		(0x5168 + (mac) * 0x400)
 
@@ -259,21 +313,36 @@
 /* Port MAC 0/1 Transmit Ethernet Octets Counter */
 #define ENETC4_PM_TEOCT(mac)		(0x5200 + (mac) * 0x400)
 
+/* Port MAC 0/1 Transmit Octets Counter */
+#define ENETC4_PM_TOCT(mac)		(0x5208 + (mac) * 0x400)
+
 /* Port MAC 0/1 Transmit Valid Pause Frame Counter */
 #define ENETC4_PM_TXPF(mac)		(0x5218 + (mac) * 0x400)
 
 /* Port MAC 0/1 Transmit Frame Counter */
 #define ENETC4_PM_TFRM(mac)		(0x5220 + (mac) * 0x400)
 
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define ENETC4_PM_TFCS(mac)		(0x5228 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define ENETC4_PM_TVLAN(mac)		(0x5230 + (mac) * 0x400)
+
 /* Port MAC 0/1 Transmit Frame Error Counter */
 #define ENETC4_PM_TERR(mac)		(0x5238 + (mac) * 0x400)
 
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define ENETC4_PM_TUCA(mac)		(0x5240 + (mac) * 0x400)
+
 /* Port MAC 0/1 Transmit Multicast Frame Counter */
 #define ENETC4_PM_TMCA(mac)		(0x5248 + (mac) * 0x400)
 
 /* Port MAC 0/1 Transmit Broadcast Frame Counter */
 #define ENETC4_PM_TBCA(mac)		(0x5250 + (mac) * 0x400)
 
+/* Port MAC 0/1 Transmit Packets Counter */
+#define ENETC4_PM_TPKT(mac)		(0x5260 + (mac) * 0x400)
+
 /* Port MAC 0/1 Transmit Undersized Packet Counter */
 #define ENETC4_PM_TUND(mac)		(0x5268 + (mac) * 0x400)
 
@@ -316,6 +385,9 @@
 /* Port MAC 0/1 Transmit Excessive Collisions Counter */
 #define ENETC4_PM_TECOL(mac)		(0x52f0 + (mac) * 0x400)
 
+/* Port MAC 0/1 Transmit Invalid Octets Counter */
+#define ENETC4_PM_TIOCT(mac)		(0x52f8 + (mac) * 0x400)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index bdc5916e4400..71f376ef1be1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -177,6 +177,65 @@ static const struct {
 	{ ENETC_PICDR(3),	"ICM DR3 discarded frames" },
 };
 
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc4_emac_counters[] = {
+	{ ENETC4_PM_ROCT(0),	"eMAC rx octets" },
+	{ ENETC4_PM_RVLAN(0),	"eMAC rx VLAN frames" },
+	{ ENETC4_PM_RERR(0),	"eMAC rx frame errors" },
+	{ ENETC4_PM_RUCA(0),	"eMAC rx unicast frames" },
+	{ ENETC4_PM_RDRP(0),	"eMAC rx dropped packets" },
+	{ ENETC4_PM_RPKT(0),	"eMAC rx packets" },
+	{ ENETC4_PM_TOCT(0),	"eMAC tx octets" },
+	{ ENETC4_PM_TVLAN(0),	"eMAC tx VLAN frames" },
+	{ ENETC4_PM_TFCS(0),	"eMAC tx fcs errors" },
+	{ ENETC4_PM_TUCA(0),	"eMAC tx unicast frames" },
+	{ ENETC4_PM_TPKT(0),	"eMAC tx packets" },
+	{ ENETC4_PM_TUND(0),	"eMAC tx undersized packets" },
+	{ ENETC4_PM_TIOCT(0),	"eMAC tx invalid octets" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc4_pmac_counters[] = {
+	{ ENETC4_PM_ROCT(1),	"pMAC rx octets" },
+	{ ENETC4_PM_RVLAN(1),	"pMAC rx VLAN frames" },
+	{ ENETC4_PM_RERR(1),	"pMAC rx frame errors" },
+	{ ENETC4_PM_RUCA(1),	"pMAC rx unicast frames" },
+	{ ENETC4_PM_RDRP(1),	"pMAC rx dropped packets" },
+	{ ENETC4_PM_RPKT(1),	"pMAC rx packets" },
+	{ ENETC4_PM_TOCT(1),	"pMAC tx octets" },
+	{ ENETC4_PM_TVLAN(1),	"pMAC tx VLAN frames" },
+	{ ENETC4_PM_TFCS(1),	"pMAC tx fcs errors" },
+	{ ENETC4_PM_TUCA(1),	"pMAC tx unicast frames" },
+	{ ENETC4_PM_TPKT(1),	"pMAC tx packets" },
+	{ ENETC4_PM_TUND(1),	"pMAC tx undersized packets" },
+	{ ENETC4_PM_TIOCT(1),	"pMAC tx invalid octets" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc4_port_counters[] = {
+	{ ENETC4_PICDRDCR(0),	"ICM DR0 discarded frames" },
+	{ ENETC4_PICDRDCR(1),	"ICM DR1 discarded frames" },
+	{ ENETC4_PICDRDCR(2),	"ICM DR2 discarded frames" },
+	{ ENETC4_PICDRDCR(3),	"ICM DR3 discarded frames" },
+	{ ENETC4_PUFDMFR,	"MAC filter discarded unicast" },
+	{ ENETC4_PMFDMFR,	"MAC filter discarded multicast" },
+	{ ENETC4_PBFDSIR,	"MAC filter discarded broadcast" },
+	{ ENETC4_PFDMSAPR,	"MAC SA pruning discarded frames" },
+	{ ENETC4_PUFDVFR,	"VLAN filter discarded unicast" },
+	{ ENETC4_PMFDVFR,	"VLAN filter discarded multicast" },
+	{ ENETC4_PBFDVFR,	"VLAN filter discarded broadcast" },
+	{ ENETC4_PRXDCR,	"MAC rx discarded frames" },
+	{ ENETC4_PRXDCRRR,	"MAC rx discard read-reset" },
+	{ ENETC4_PRXDCRR0,	"MAC rx discard reason 0" },
+	{ ENETC4_PRXDCRR1,	"MAC rx discard reason 1" },
+};
+
 static const char rx_ring_stats[][ETH_GSTRING_LEN] = {
 	"Rx ring %2d frames",
 	"Rx ring %2d alloc errors",
@@ -211,15 +270,62 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 	if (!enetc_si_is_pf(si))
 		return len;
 
-	len += ARRAY_SIZE(enetc_port_counters);
-	len += ARRAY_SIZE(enetc_emac_counters);
+	if (is_enetc_rev1(si)) {
+		len += ARRAY_SIZE(enetc_port_counters);
+		len += ARRAY_SIZE(enetc_emac_counters);
+		if (si->hw_features & ENETC_SI_F_QBU)
+			len += ARRAY_SIZE(enetc_pmac_counters);
+	} else {
+		len += ARRAY_SIZE(enetc4_port_counters);
 
-	if (si->hw_features & ENETC_SI_F_QBU)
-		len += ARRAY_SIZE(enetc_pmac_counters);
+		if (enetc_is_pseudo_mac(si))
+			return len;
+
+		len += ARRAY_SIZE(enetc4_emac_counters);
+		if (si->hw_features & ENETC_SI_F_QBU)
+			len += ARRAY_SIZE(enetc4_pmac_counters);
+	}
 
 	return len;
 }
 
+static void enetc_get_pf_strings(struct enetc_si *si, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
+		ethtool_cpy(&data, enetc_port_counters[i].name);
+
+	for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
+		ethtool_cpy(&data, enetc_emac_counters[i].name);
+
+	if (!(si->hw_features & ENETC_SI_F_QBU))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
+		ethtool_cpy(&data, enetc_pmac_counters[i].name);
+}
+
+static void enetc4_get_pf_strings(struct enetc_si *si, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_port_counters); i++)
+		ethtool_cpy(&data, enetc4_port_counters[i].name);
+
+	if (enetc_is_pseudo_mac(si))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_emac_counters); i++)
+		ethtool_cpy(&data, enetc4_emac_counters[i].name);
+
+	if (!(si->hw_features & ENETC_SI_F_QBU))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_pmac_counters); i++)
+		ethtool_cpy(&data, enetc4_pmac_counters[i].name);
+}
+
 static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -240,20 +346,52 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		if (!enetc_si_is_pf(si))
 			break;
 
-		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
-			ethtool_cpy(&data, enetc_port_counters[i].name);
+		if (is_enetc_rev1(si))
+			enetc_get_pf_strings(si, data);
+		else
+			enetc4_get_pf_strings(si, data);
 
-		for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
-			ethtool_cpy(&data, enetc_emac_counters[i].name);
+		break;
+	}
+}
 
-		if (!(si->hw_features & ENETC_SI_F_QBU))
-			break;
+static void enetc_pf_get_ethtool_stats(struct enetc_si *si, int *o, u64 *data)
+{
+	struct enetc_hw *hw = &si->hw;
+	int i;
 
-		for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
-			ethtool_cpy(&data, enetc_pmac_counters[i].name);
+	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
+		data[(*o)++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
 
-		break;
-	}
+	for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
+		data[(*o)++] = enetc_port_rd64(hw, enetc_emac_counters[i].reg);
+
+	if (!(si->hw_features & ENETC_SI_F_QBU))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
+		data[(*o)++] = enetc_port_rd64(hw, enetc_pmac_counters[i].reg);
+}
+
+static void enetc4_pf_get_ethtool_stats(struct enetc_si *si, int *o, u64 *data)
+{
+	struct enetc_hw *hw = &si->hw;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_port_counters); i++)
+		data[(*o)++] = enetc_port_rd(hw, enetc4_port_counters[i].reg);
+
+	if (enetc_is_pseudo_mac(si))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_emac_counters); i++)
+		data[(*o)++] = enetc_port_rd64(hw, enetc4_emac_counters[i].reg);
+
+	if (!(si->hw_features & ENETC_SI_F_QBU))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc4_pmac_counters); i++)
+		data[(*o)++] = enetc_port_rd64(hw, enetc4_pmac_counters[i].reg);
 }
 
 static void enetc_get_ethtool_stats(struct net_device *ndev,
@@ -288,17 +426,10 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 	if (!enetc_si_is_pf(si))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
-		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
-
-	for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
-		data[o++] = enetc_port_rd64(hw, enetc_emac_counters[i].reg);
-
-	if (!(si->hw_features & ENETC_SI_F_QBU))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
-		data[o++] = enetc_port_rd64(hw, enetc_pmac_counters[i].reg);
+	if (is_enetc_rev1(si))
+		enetc_pf_get_ethtool_stats(si, &o, data);
+	else
+		enetc4_pf_get_ethtool_stats(si, &o, data);
 }
 
 static void enetc_pause_stats(struct enetc_si *si, int mac,
@@ -1438,6 +1569,9 @@ const struct ethtool_ops enetc4_ppm_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_sset_count = enetc_get_sset_count,
+	.get_strings = enetc_get_strings,
+	.get_ethtool_stats = enetc_get_ethtool_stats,
 	.get_eth_mac_stats = enetc_ppm_get_eth_mac_stats,
 	.get_rx_ring_count = enetc_get_rx_ring_count,
 	.get_rxfh_key_size = enetc_get_rxfh_key_size,
@@ -1480,6 +1614,9 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_sset_count = enetc_get_sset_count,
+	.get_strings = enetc_get_strings,
+	.get_ethtool_stats = enetc_get_ethtool_stats,
 	.get_pause_stats = enetc_get_pause_stats,
 	.get_rmon_stats = enetc_get_rmon_stats,
 	.get_eth_ctrl_stats = enetc_get_eth_ctrl_stats,
-- 
2.34.1


