Return-Path: <netdev+bounces-303028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zG8DAH93Q2rNYwoAu9opvQ
	(envelope-from <netdev+bounces-303028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 542096E17B3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:59:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=EBySJ7DE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303028-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2E63111127
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B23EE1F6;
	Tue, 30 Jun 2026 07:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872553EB813;
	Tue, 30 Jun 2026 07:50:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805804; cv=fail; b=gahXjiEA++eeSOzk3gn+skzPh4UxrH6y88H1yWPztIU7GrjXvYOmHaIwbnWFyf6GoTgi5YvGVAb3Mx1ur+5md3pgaJo1/pot7kZPJUTe5qVgBYwudEpjJODBhAAcvfrMgnzgYyilkNZgatkOyfD1KfdbivhG2EL3aEhxEP7Ftv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805804; c=relaxed/simple;
	bh=xs5XQR4GCTJgSYpvY0nM42qJl1+P3JkQUA1R73tXpik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV0cYeX15QIY2dkkBXcsZZbN/JlQZc3EfAgT64K58cPgVdWQBRYhotcmYKMb683p90nSynqtcJAtaqqzxXbgaKme9mbwCLtCubUv6zouZ0eJEzCtijNp7tZ/YlndevmpWvxjQFA4InWu8R87d9+S+tJFREZBEhp7zEBZWG4hnoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EBySJ7DE; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8egj2QRV4tNoiKVLCV8+CvqGRt1QEofIiy0kiFdSaxS8+ocXRBHPhikCZxJho0n1uOl4IJ9th+6o/yULw7MowzKFi+umpthNSXKaxI5khDOxIvH7kSYJW4ZKKP9lJHQA2L3jCqA6KeaT/eSKHnvHZ99jXd/Wllm/ny3O507Kx7eVMPVGv/b0FKipL086fulbEmFs5J7Ir7wQ4ka8Rme1ShpIyvDP9w7Z8k9L3oVIApQ7qekmfQkm2VGAgtDMBuoELZx+Aus60uRu1GOUTCwrl9/2TBEFyT3UcZ5ZSLWwEGeIpDUZbRB9eUrSovu8/jCSDA4VPKBRFYo9S0RMzy5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=FtE5jStyu3BgBj1LkqVOrhe6HYRavq3g/jJE6d5ay3zlJ/YMUobO8yYFEF9yxg/UxgqIKOi0yNU47FcGqCQeZGNnWcO/VX9KtJ2KJsI32rr0KjPbs0Rh3HVnoryeKy7r6YfYtSV35D6/J/ySEii9tVTEK9TMIan6SdTq6/O2A6Jw9LUmq3FeDtI1ZakeDLd/p2lR2AVYXWsWYE4X2bWd1XiSTaNvAfEj5HJrEtmsl/nHiU6EdVDt9rY5QdoryaROMqXw0j7oh+9vZPmPcDpmimdQe3LQnby8takhtN1U5vo9w4+IH3kkbUdStVSS4sWHqqJUnU3ZE84HylE6n5dWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=EBySJ7DEc5jntHOj2twJGZf5gYFvQal2zlO1z6xyU2Sw1Ma4wBKEpji5rq13y4dhikcIMXd+lvEA2EMRDMSvVpo9Olxir9N3dPmzpYQVux89wSIXfOYYgU2RfLvvWcL1XM67y5hjjvQU/PyDhyYAWXDNEH750OtwlSo2Z2bF2fXeTsG6+7ykZjHGw7lKDd1DtXMjDO/pX2ZlccJkHrPt6JASGYEU9fOFLLZw9ASI/O4KewiKPl4gYMW72CB09ij0qWz8wpu6xL09t+ctBF65zRhh0K/yf4dLEXJBS+sAF4ZMQYRTXYBq2OfV9SDQOSf8JwVX01G+cyhsOdLALlb+sg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 07:50:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:50:00 +0000
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
Subject: [PATCH net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Tue, 30 Jun 2026 15:20:36 +0800
Message-Id: <20260630072036.382761-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: 003567c8-053d-4759-4cf2-08ded67c2fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nGN/ZmFzd8noCPaRjRP0ngr5fHdGttfEcRLktAzddnS3QTBkcrx78+pag509qfJTi1CQRaxmhEpkaXA5xfZBVvMf6ZrVdgcEuzw8jL4Glq4aNz7kBdXjgGxoOSDOiZ9IPt55gMf3DCzXH4EN5+JYEygNDjoh4eDkZApNgQSxwgarJP7zzaU4DAODQWwGBIlOU0WezL9zc3EUjYohTNzYNASORxi0JgIJyWwy0+aEY66pIXHr9wqdBuvub/CsE/YlBtkwXxj1X5gSO7XXEjlpKn8ib9LDk7u1blSJl7aWTq5x/xu+vEb7U63+jFA6X7i54kp3cmWHmYjaO/If9kHZqnSoAIvTbdRkBAP+7+r/lr4wDaFNXun+2pcLhG8gSPKHjnpbAdsSFpMqqvW4N4dMBAIu4pqz40NDjVNvLyHjVSX0esSD+rKAnYT1Jp3q32sJJpcFbGTulhbr9MVMvUZJRmKJPeMRgzBUs320/EIvAXr/1/vVZ60ESHyJz2RTVq6BSmgueEMCq1kw8+p2u7lcsPVPxZeRxpCct1OhtgpgLvwhG+rinrGA3wW5oG+pJERT/9llbHfEO07peZlbqPqDhxJ7yd71GcZrN6NuzAxtQ+Jn8sr+Z+u1iSImPOAfYVN45fnSWopwAuKAZiyBU2wYNE2ZbTYJ+93hYy0KL874S2DFf8Gg+3ijxHSt+7/ZTO/4Vo8L+JhTuOZvVehn6LXqGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yahuWumKpUJSe2TY/Fp914e1k49u6AGktApLBR8yo82HKDFECJq5HXnNxpxi?=
 =?us-ascii?Q?GX5Z4ciZPCoZ6+HBNfnJCRRRkUfs1nuqX2D1IafNknHa4OxgJZ5YI7/DwIbh?=
 =?us-ascii?Q?eSJ9bYdyBHkKtnbg6P0gXPNMKvl1kvJ3Vr7uWZ77PwOddxZFR9sXb2oTO9AB?=
 =?us-ascii?Q?8fP6K2CoQ9996nW28Hu/xE84g+KVwP4WjKoX+U+ZfiKXu/eRJQiL9G771Rac?=
 =?us-ascii?Q?Qi28SE7YrqzUemP6uCK929m8dxF2CjFi0Vh6BjcAmDvXNXPCKqIngZmMNsR6?=
 =?us-ascii?Q?tS4/WVnlRRrOZxePkCMolwxiBA6nHYrOBWbn3WG7naKRx+bVWziLsKDicezN?=
 =?us-ascii?Q?iLi6kKzaXUY/1gOHiw4WLD5Clv2dHIPF+XDdQCLgXpdJVo8YmMKHigaczCd0?=
 =?us-ascii?Q?l9K5l61tTaUv1KQmu8T6rsUMXpTPYwmtWeMjxC2rAws+j2VOAzUGaV3U2t1h?=
 =?us-ascii?Q?be4FN8zVEj+9IPASvDdOihz9sRgSRJ1dkVxxgu5Pvem1OVX426oZJEcv9Knu?=
 =?us-ascii?Q?wZYPFl1eo9VQ9Bw4xfUqJTSCYRocjYUaPhPPGJO0TzSvDJWlNGhIhX7Su+i2?=
 =?us-ascii?Q?H+4wLoxvb764PzPbCuyml3xlC8UHylEqcjJ4yGb9rTHH2dK2GYgfpPvQrF6h?=
 =?us-ascii?Q?6s6ZRs/lgyBjr8Hgag/dr77YgcG7pkQTwei13ohO66fcy67llTuLzuMnN9RJ?=
 =?us-ascii?Q?lGqEW7Zqshk33B3NfxlL/Ah4NaL9y7Qh9ePST2A/B++TaVXUfgQvEIwetygj?=
 =?us-ascii?Q?wOnDhGPo45m4HP35L6BcOzRthdnbiDCKw9k+Th6T947QLyNQ+hNjnMupkdoX?=
 =?us-ascii?Q?+4YljG5bzkNf0qqoxqaGpxzHIfrvGFdhNrBJGE+SRin4icrV0+p1jcCsashB?=
 =?us-ascii?Q?iGKBmtl43up8s/hUB5TqsVT/lfFiQmxz+nzzN27CfdyXyuOde9N32cJr+06d?=
 =?us-ascii?Q?4kGQh9Q511PJMK5yRJyVaP5mgqCtJaRrh7OawRwjFelVUom63vDVaZNdYdIS?=
 =?us-ascii?Q?SFeKt1qd/g8bv6DtP1WBFC3Ugr+muj8JiaDtinjqh+MHl6RnnYGEq0QFbOCX?=
 =?us-ascii?Q?+rkKI+5iByRShD41DyGw1VwLotB9mnMdiauXep3xAxmKLQi0WJGtIvjyMeTQ?=
 =?us-ascii?Q?ML4M641HVYIIlQYLDBjV3KBc5jLhz81MlSCurL4X2mJG0CNs8EE7jTnySP17?=
 =?us-ascii?Q?sFTlGornZU7kPbkFU8xE7NG/GY2mDrKrFqBhAaS+SpweQcqCCtfj1uhvRTQV?=
 =?us-ascii?Q?aaTyC9gloasBjrZe53KjQnl5DtRYb8AxXPRUK7O2uWexMrL+OccQ8XiEZAxd?=
 =?us-ascii?Q?KH7TKuWLuQycZ9JfL3YYfzUJ661oWsc5hzbmwZZeuHgYHJBL9Sfi0hO9Mr9o?=
 =?us-ascii?Q?oUecXvUSRRRsKNg3NFPjqNAprsKcDqM+m1XrCyc0M+zPuRmaiWA4VhCKljM6?=
 =?us-ascii?Q?CmxMixsGS+1DZMfu4p4Reci4onCsXz0yIneaujm/xN9BzCfNy49hS8Lv6oeK?=
 =?us-ascii?Q?DMg7mRciZdjCizS/ioaatwXS4yJk1nUy4A9MPD8mjSclcozwJRyWSnzWLRPI?=
 =?us-ascii?Q?z8m6jGI5M/9WghMjFzjD1m+mZMKKjTHz1Bd5XKbEZ+XAvdhm4TRvWpqy+1R9?=
 =?us-ascii?Q?/fGucIW1WEItpjJiMATrHIZvPHeCfVP8uHCWnPBKc54hgG+MDoO1dosjJ6SI?=
 =?us-ascii?Q?D1tPmpL+2Ndf3lFUeWx3wDuplL673nBgHViJn7mTYo1sUeMIIYiwUug/HF5p?=
 =?us-ascii?Q?5LKSBMCPtOVAHjfnJs6HZLRdL/z6TIN8+yFp4bodlHQaTFIvx1Jg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003567c8-053d-4759-4cf2-08ded67c2fe1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:50:00.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4L4cq04jC4uZy9hFCPPlkP3QYIntqAylZ6CVUW/k8KNHVFql3GZrdI5MWIWSMgjtgsGjdsks7Wiu4tCBxwCl5ElKIQNykJ2nJuhUcfbeELlzuZZLjXnH8ZCCubglVLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-303028-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 542096E17B3

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded struct_size() + kzalloc() pattern with the
kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
removes the intermediate entries_size local variable and makes the
allocation site more concise.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 7b17bca24f26..2aa0fcaafcd2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 	struct flow_action_entry *entry;
 	struct action_gate_entry *e;
 	u8 sfi_overwrite = 0;
-	int entries_size;
 	int i, err;
 
 	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
@@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		goto free_filter;
 	}
 
-	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
-	sgi = kzalloc(entries_size, GFP_KERNEL);
+	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
 	if (!sgi) {
 		err = -ENOMEM;
 		goto free_filter;
-- 
2.34.1


