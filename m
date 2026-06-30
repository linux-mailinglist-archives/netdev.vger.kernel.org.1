Return-Path: <netdev+bounces-303023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H0geD7N1Q2o4YwoAu9opvQ
	(envelope-from <netdev+bounces-303023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:52:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD36E1678
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:52:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=KfcWF2ud;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303023-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303023-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04933303422D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FD3E7BB3;
	Tue, 30 Jun 2026 07:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4323E2AC9;
	Tue, 30 Jun 2026 07:49:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805774; cv=fail; b=igrqtALU/VR+9sjuUpeDTc73T2X/IgBVJJuH+XDGzoQoXgbluNEoPeuKuM7lIxKR9Wg2Xnne3OlKcd3aV64KunyRJ1M/Sesf4+gJjRKHcLCyD15bi7WFvh+Tftn01JTJPtiUxXKcmpDgyRIlSlwbQ1x3ERwjWzNjAUYguZDCYlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805774; c=relaxed/simple;
	bh=n68g8bd2LJDBYVosg70ea0vg7+7heNKGeftQKFHtbhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDlxjVQIxMjtu75J290HtFMV85R/BZlWeP6eA4SaChcuw9UqNDQjAKJ7l7gJjr4fX/xx24CoiTtJWi07EnWGS3XH5gNFcseWdrza4DnO8A8yHQsdH7hKbY977SRl6JarzbKQRPLXtEtk1gq/+tVI8hz9OmI8SHKlpE//AWJB6ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KfcWF2ud; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXFlkY1CTwXZTARz+jeZsoAZY3y/Zpui25sL00HJ/O1SsjuzQLOOUdzgbtl5FTL+xcuwm5AHy48UAsQYQ7t56n//9tF51cdNoF+bYump4pVyPkour+uxdqA2EySFAv0YIAK1uiy60MDVGi9VO0A1herheSCOUyHHPA/Qa26fGIDoEKAFiCdePliloNL+wRs/KMrg6IcxZXjVogpIqq4cPYgymitFQdsUjHnjZTOMPKXpr/QlXKRKMwCki3jV/ZMvHCVshK6BninZzOLb+dlzjjnZHy2JOCVwVr3vNTz/h0hUAfYGzD8RNYMOKs9OpZvpQzi07jnC0aXQbwHgalMQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT3Vsq0v9+pq36q57f/18e05NKhG86wbn43vQlV1L9w=;
 b=i7Xm0b5vaFmIvtlWyFf31aZZuhg7nlTi6mi0lXhHb3cVlqtwGFIgJKD8cUsPBDEoD6uev7dozsH081eLKT21zMRPv0uxWLAEw+p/5JNN5gWi7FVJoDTLM5cZpmyaJRfIf+ZvEbbViQWwsHhgnZjDVqIxy/rvEpuP6dxclEChgJqNs5lWi0d6CrCoX/BGvKFYxvig6WWl3nDdouizuiOAu9ji9zVbtENZ/0GN0UDFxdny19StgmfYjtdRnJXoW5FgAg+9rtCXMtOkmK62DURbPrwwEN9L81PQN4nhMh3pjxPs5/ZIPkOcqAPqteQ8/kjCjh8liAN8QzpJnnFc9yxmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT3Vsq0v9+pq36q57f/18e05NKhG86wbn43vQlV1L9w=;
 b=KfcWF2udgr0INqBgd9lu8OHgHT4KS4VVSeWSqbp373sp+9zSN4Y3mMW/98gMOOEuubqlJ/QjcEr+O957vkt+ySrC2HFlwq9MI9OAbju8t+U+vI3qyCDeftULr9REpjLyO/jQ2SEt66PdixCn5O/WYQnfnqCCHkWpkU1QPJudUPhBxWdZM8Ai1UC/Vy2YatsVKWQuFDGY9mb/732V+UAwkkXYXhvjTY4f2RJkXXFynAwieBmdBskfvFDC2RzC2cOnLLeTsrbVmo18S2KVTHRmt9ewuXjdH0A1CgoSyWeETL0jqYbS4BZ30xP7nrgufp8KXCR7R3sUqgz0+hrA4B3OcQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:29 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:29 +0000
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
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 09/14] net: enetc: remove enetc4_set_default_si_vlan_promisc()
Date: Tue, 30 Jun 2026 15:20:31 +0800
Message-Id: <20260630072036.382761-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a5a042-1930-400c-6fc3-08ded67c1d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	BNeI/ppi5gBFg4p4Otz2HDuRW7r+9taw5pDj8np3Ert4RCPzQMa9Ctjuj3nVLfKluwz20DDPi+EvupMTU/awVI0cWYu5H+Ga8CEN6gVfTYuy+oIvca/drMNEyEVbxIl7SgNvDo9d7YjnCyduUWdSwFuZIYuUI1GeG675HfsfpoHZwDU6BXk+Psoni4smRtRqiS4vq/kqTgBo2Yl4nImV3fXXbhPSuHKMpS18FwVuSB8SOk7njeXKmc1S3rZaUfSNFcC8Km0D5SkDq2m7M+IWLwTqywacp3pe67ZCSF6NLfMD6dsndMolD7eWu722LqLOPbpYtPFCydWfWoBr4/Tdd5V33BJzrx4l5VD5vG8zMOzesFu5AAOUaSBBvbmF40TTmIm4hoB7geCLMQncdSQDHsJPJsaWOVfx3hrAgmWje3mVVd3KRfJ/wMYgJpHQp7AAlNQJa+uukW3Stdte0oSgenoCS2TPgGbScrdxfXIRjlYA7q4I8cfXMWvhzUP8tFytrgjYAOE868cgh+iH1OqP7lZKSORT8z8oBJPh4+dV0JZv3zAzfZsrOX4ul8qUj+nWUJ0ZCtRPR7w7FHqLjD7iI6bTewunMJ6HLe1N9dIhdL7JgH+tbT/u8cX7RmwNqmNqd3Ug0SQ3VbftRJ6nk+MgM0KuS/qk0CCe5LgBgPP+6UxGKKpAOJ+yp+Hx5KbymEi3IC5J3Sc7X0bScnBPnCHIRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ib4+r9jNnkQIdSI/HA5odqRzkVKIybolTgf8V7C6Omt8mmv204voi2qfaSsP?=
 =?us-ascii?Q?OjUVFSTF6Bqjvb6rNWGQE+5OluhFF1+xcR06w9kOZpNxi8UEnCg0PMJOZ6+s?=
 =?us-ascii?Q?fEEcMVF38cImU7CSnvkOcCboGU1F60vOw3i0CzansZ63ij41QHmsmROX+z8N?=
 =?us-ascii?Q?qB6D+2x+KnyLnmv+VKD+XgjMIFgDMr/gOjq8TK5XrWWXiMakH91y+nj7z7RZ?=
 =?us-ascii?Q?CHi7hdhOtUBjaJAiYO43SyLQvSrpWzf3UP5D546E3TafRNJJIjjXowbk5Ilv?=
 =?us-ascii?Q?HF6FyrQMbaD3nBYx1JFp947KIsjKDho8SWjENNtVtdZziTRCGL/Il8dFcfPh?=
 =?us-ascii?Q?UUF4+HzUUnvAtB9Ik3Ot9Lf3gVtqUgIbHQKbI81I2bsetxMqRbkL3iY0rhiE?=
 =?us-ascii?Q?ZaPc1o2W4+8KxtUu2gWaZdRmM+U3buxD2umirietQepfgDlwTyGVBZ9Z3dzs?=
 =?us-ascii?Q?CpwU/mkCnw3RaD4TYxCZVeeIR1fo1+se4ZsFPa6v0tLKXFe/uHJYsZidFWtA?=
 =?us-ascii?Q?v5ACZe4PG+8UrzKi8ceCtzcKC7LvGe5OIu3Ztj+AlYBHXi5OCcF6Qss6EVzq?=
 =?us-ascii?Q?FCK76FlBBgKx3uOzk3dr/4E8tlgmGEW/Lph2tmKXU8wnTy5SebcoyLiQqvgQ?=
 =?us-ascii?Q?PoyYifneTS9Iu2j7EvLZeY6FUhBasfpgos60eym4sR+vtGkqXEeM1NCP1+xF?=
 =?us-ascii?Q?luaNtYhlKpThiboBHPq4/6buU6eiBpBn2w27WAk/JiPcU/bRqj86NhiB1qzT?=
 =?us-ascii?Q?7NM9ev3lmUNwfoE6cLCtw4gO++knpkBZSoz0+brei6dlzSJtnL/XZRqKOlrR?=
 =?us-ascii?Q?GvRCVdENCPa7qe2nuwV3SJMsS1SUvAJ7z3d0q5kui8xeKyFf7w2kYZzDayH+?=
 =?us-ascii?Q?/d7D12ScO++1FHBUCWQtafRl9qjYfdsWrYxTBB+2aXP7raIlheDz0TjEXr5A?=
 =?us-ascii?Q?K4SZnZaf0yfHgWg5zGU+1tngXhj6xq/NbM/NP1zNfdkoZ1hALWBwQrCpOdPE?=
 =?us-ascii?Q?e+q9ezMVhAW/zZBkCeh8hLjgogxoSTz9siQNJ/V7MekKe845apcB8pEgGjQI?=
 =?us-ascii?Q?pXmBvpNNv+YsL+xGTzMoldjYsbYl617D1VhOgLFwwhi3FgyM7a7jj5DPs/zU?=
 =?us-ascii?Q?lAua8zIgffn6SbGgnrczfDgTlc9AWz69vQI+XeFP49rFc/Md2nkGFdcqqozy?=
 =?us-ascii?Q?sx4Dr3XvGK1h/6V2nPb/4i9iNwpEuuNtHHzvtE/qsjm+Kzbo3BYXimlulJDu?=
 =?us-ascii?Q?3kHJe/YcrnhWjBwo4Bx0uIzInoOCkxlHSVCe4he1UILPSJMAwAtktCmseAw/?=
 =?us-ascii?Q?E8INZdaWltfiePsPXEXqcqmCEDUknDiEGc/gxehuluqHdl+u7PsznSTBdrmn?=
 =?us-ascii?Q?wlA4neXNn7SMZBeRX4eoerGeUceIBNVdYNNREfDnseWFCCDXLxiKJ1myPH8L?=
 =?us-ascii?Q?oYq9v1es68scZzqpJ386yrtoflVA0VTTWdK45Ckjdgk2+MonKPeDBcKzkV7N?=
 =?us-ascii?Q?RhB+BGFq4CPMcjTyKcTxB6AIwkMa+YRcbfFAZ5SaDmKUidyOruIAZ7YQGAw4?=
 =?us-ascii?Q?pWjKf2ox8nFmwz9QiQJgIIYqtjUqU22/C7h17w3+5x9ZHL20Df+whtqyPIOC?=
 =?us-ascii?Q?Eq7hRb/4d1Izm/iuDStMuE1UkbILRhG1eV1iMGOK+G/65HvsLsJXm0zhrpxg?=
 =?us-ascii?Q?pTRkk+SfFAvu98MablWW+lYtlLbSPcLxftPdsEjL34QDjMNgMAlh5IkNvI2n?=
 =?us-ascii?Q?mJ27YquSrnFo/PDeAkeAmbKamFnTqRBljTmt8c9rraHuyKXZNIRg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a5a042-1930-400c-6fc3-08ded67c1d72
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:29.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta4iysC+ELz9KeKZen04oH34ezpUkkUVIFziI+jXZA+wP2A5zjHG4zgbaofhxV8prl9vjzUqPJuqKd53Ym+tr/e/ODsvyc4e5T23a6xYY39GSkSLn5YmVn1/9elf8PLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
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
	TAGGED_FROM(0.00)[bounces-303023-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06DD36E1678

From: Wei Fang <wei.fang@nxp.com>

PF performs PCI FLR during driver probe, which resets the PSIPVMR
register to its default state where VLAN promiscuous mode is enabled
for all SIs.

The explicit call to enetc4_set_default_si_vlan_promisc() in probe
is therefore redundant. Remove it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 67aaf188d325..43883b55974a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -310,17 +310,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -364,8 +353,6 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
-
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
 
-- 
2.34.1


