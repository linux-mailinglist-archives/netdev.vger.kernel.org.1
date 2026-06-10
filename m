Return-Path: <netdev+bounces-297577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URt4Mc82KWrUSQMAu9opvQ
	(envelope-from <netdev+bounces-297577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB370668187
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=B3y3CmUD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297577-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297577-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 782C230257B2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED033EA94A;
	Wed, 10 Jun 2026 09:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497663E4503;
	Wed, 10 Jun 2026 09:47:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084823; cv=fail; b=J2XxQb5BhEc9AFmNGFupcjQH0ys2wgtAGD+GKvNXK0VJfDY7M2ZEo5p3bqqZZ2yloV/5YMSH4lJd0QM9XEDYVLKJ8gYs1OpJYBPBRRgM7Mm8DhqnmCaypYS+EU1+AY+XWA+/0cxVdCL/pxkHiwGUtX+K693yBe6Dt/SscHmTOpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084823; c=relaxed/simple;
	bh=nodh5+3gkOSRZqg5Bs7uWGZwFcxdz27N9uLmFjByg3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFomn/utCH3fTgvUmz8h90Whm0XumbNjr0ItwQCzLWtECnE1X+bed/GVg80Hq6c0y0YbmZMqztrBvo8XN038+QtXK5dLXdSlNIuP7hLVIoGtzwoIRHukHIihqq+9oBxs962ZhH0H7U+F/vNosas7Kp1nPW443xy/dslekl4R+O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B3y3CmUD; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PftbeNVXYSaf/V/IrfXUbIrSAc9oiT77dZ4Xj3rkkcH6418pFqSqLZQyY8J6uRntlDWUBUvbXLY/9sf/+P/32WFr8RbSFSLv3gFvl8L6DwnpOTeMhrQGZx5LRUZ4Hjme/UtGsoaeAHCOQRMDEz4AzjkDcykUX/T9wx14Sa8toVrG8eCKgFgADtj7r15sEY9zulGYDo9/JtxmxOyO70TjLIFEr0KcdbEl5YrOG/nnHQToz1cq5YgF4IxIJ8nXdP9RoBcA4HjawtrBiUAoB3jVNuDGDYmCzYhrbby6Dv5uUqXZg9jNkuti8D321IBUc/yQRTr5Bb+YN+xb/GvtQpDFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwtqHmw5l/uM5Q+Brnu0fhdQdi1us7iRfPQNXdxiDbw=;
 b=GI/kM2G6XnBp36DkhieMWkq8v7A5e3Lsz7CbGpPmugB+mQw0GeowXKMKhYWSvRSChd7Ahcen/TkSZRhmQwmXp4NUMhOt/nc/OA1HfWuTr8+/LYEH8qIiqETnPJotxI7AKVWV7zusN5ee0y5J7uex8O+Aeh3r+OkAoatyQomFyh3RpjG4FlY6horTcpjX5ibLQYSPbLapvxrs2uGd1jw45x6hLBfe2rj1za3g+Hs45fgNO4hs+BVHON/afN3h8B1iH/vejLbHar7FZCFjuuhKghKpgAtXeiQnTrBPZipQXlxGiA3zeJPlbechQ+FNp1pwu6/3rnhtgrqEqEnU1/bgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwtqHmw5l/uM5Q+Brnu0fhdQdi1us7iRfPQNXdxiDbw=;
 b=B3y3CmUDSxQyzTv0aB9cMmVZ3NAUHZsqxuUX3ks43YRBxvnp93KOyzmo/q1Ei2BLreH8S+5G0JA7nZD4+OA8Bhi397CO99/i7hP+IvmgRDrXujtZ60lu3XM58krOUSXN+OrwDQPkBlKQ5L0c5uNc+SPiYD+zkq91FewtTLIvkVzUzgey+xhmKfsbudg8OSYEWqRHTfVFhztG436Atyt0MwRA0iCe1aX1CPCeVrTx+RmefJcBzdx7E/vQlFdIXYbQo7YeZ5Oo8XDnIiNVvJwm6zGsOiCwfOYGa50L7XWXYUNoxfa2ZNJ1Ixo+ax86Q3MYvy/oudmI3o8MG+Zg+uE9pw==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by DU4PR04MB12129.eurprd04.prod.outlook.com (2603:10a6:10:643::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:59 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:59 +0000
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
Subject: [PATCH v2 net-next 10/15] net: enetc: simplify and rename PSIIER enable/disable helpers
Date: Wed, 10 Jun 2026 17:18:39 +0800
Message-Id: <20260610091844.3423693-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|DU4PR04MB12129:EE_
X-MS-Office365-Filtering-Correlation-Id: f73d31b2-a3a6-40b1-f5a6-08dec6d53761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jbFBGc4G5ADN8hq+wRQFaHaAwB9RCe/t0tLRE6QMf13cj/k3vTTZwDp+rAdanX5z+QAq7i7xW+OTqg0rS8I7+fSr4fCec6/MD0StjMMdfwvx5OqUWA+WudNXMYJZoA6pkJRvWQ2Y3U2NuaxT3yW24zG9lKdjWRgye2HrFn2YWnR46xS+TVP+wks8cuetIP0GXwmmjqPBE7ChakTRygz5B58/OjpT6HnpVa87fHmNs11TMYgbcdTcZNTb5LHB1ChEMOx/8mcMdF1SvtcXyXeUul8PFuFrAfvjdIMKOjh2/RVXJl9tRbAyKHzXBIDEIm4np0Q6E4DNuiRhMvOlY/HHoern5UeJuwLNbFjJhL8YV8huZzXPvNGnRhCTcbOLfrFlpBORGid54Si4WhFhquA+NFw1vhx5KRaxK0cTxoOrsY7nIgMWiHX99fzSyUbr/eGOiIyt1WDDPLcB6FYKaQMlWJiDD92ZEgP1Fq3O5DdREVKL+GlkG7T+VQvzavqd2+KROiHR1O/wvKHmC60sB/NmRghP7gkzfxbh+R4vMt47YdBzMrrxdxmuxsZt8VH2QNomuV1TtwlAJK3QpDr5dOl4oHfAY72wY+gHFuFHM29hE5zta6fLzYewqWVTiLSCzQwXkFuRJ1zIkqTGIpEHzRgwyf6ENUyV3yXhbh7LszspXdhm/nxE0R4rkxUaUjRo2UiBa9N6jmjfOmItjoVD7La5smYyqIKhqRtDYewT6Hw0BLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xhw043TKzsKqHz3r2orLi6aV/UFm1hr1Pi1jXlAlhunUrDzpHHGiqXyxTEJj?=
 =?us-ascii?Q?ymVlhJzpnrQfSibnRaRzSnwXArXfdxydZHn+av12CaeMjwiY7Nw5m9j79mUC?=
 =?us-ascii?Q?EbXUOWRyCILekxkmwjxROQgVKe1RLJ6pNa2UI+OLxwkwIz1g+QlhtyzVoucH?=
 =?us-ascii?Q?raHIuLq29TzyK2PNFM5sl6nLBx5Fe/2sfhWK+/8FYILEk0266hAlBlwYpjYh?=
 =?us-ascii?Q?tPGsKeVJc3Fk4i93yJ5ZecmXIQ5oi7JbqsWMDAcMDT9kal2eEYGewUIuz5Qp?=
 =?us-ascii?Q?XIzdMF+t7pBdLiPK5vz/2PlBSe9FkkXWzXuNt89cCBJyg6LOMTrEnYqCAh3C?=
 =?us-ascii?Q?T2g5JBGxF15I6S1f6HmQHtcPAjM02pqWR67GwLAYN5tHnrd/7bFgjXHr4HMf?=
 =?us-ascii?Q?DBEDgGa514GAfk6DvJcht4jA1zcdGPhjiZQ/yru0Cwzkeo6tUAAb+rgsHG9Y?=
 =?us-ascii?Q?2wvEWbIJpS7jHxFDicNkvhLiyEYat2NmmzBiB7Nnvab4aruqdcrTJzKF9S7I?=
 =?us-ascii?Q?qjIaSnjdRv3ZtcWakflSiFRJ3dxzn8j5QL6rI/Rnz6NFpXLNdL9VKjFhOdHF?=
 =?us-ascii?Q?KZLwqgQRc7WA6vY79+KiWTqclXDMCzo26mREsXNUUuHTTfdRcVN3pbjxv3BO?=
 =?us-ascii?Q?+/ou6FU1FY1Wd17UOE8SatOY0zIchUQ0upgfSuDkGOAyWmmWSV3954TjHUoC?=
 =?us-ascii?Q?kidsvS7gFReh3FKuwWZIbAjmQEYnlQAsD0z/F61JVeJcW1G83jyowmYvconl?=
 =?us-ascii?Q?r6GrNjbKLIIs3mX5vTM+K5Uwuuy9qMLndS852qvpNuEXGnRinrC9NKOiyiZy?=
 =?us-ascii?Q?6Ejjm/rA5suBfduHqFEwOZ7/Ik14kneajgiHMbI6XNAtnM7HyC7dDpLbq7bs?=
 =?us-ascii?Q?42We7C5Dy8kq12Ffkqlw+eyNTxMJnjX+xYCHPb3+arxxKxyfTyZRnkpbKPsj?=
 =?us-ascii?Q?mtHXVTz+f+sOmJJSy3rXzpIliExe40D0dUdIS6AD/wui70JU8npdnbcUVbIC?=
 =?us-ascii?Q?ZOIy63V2TvRT2dZiIyNug7fZtWhsXpfD4ESoPrHbnXUhbRf3IQZyRdBGFeVA?=
 =?us-ascii?Q?7dtPEyAjIkNiqHS6KAumuTxpiUB+c2dziU9G8BEm48LhWpfE3reFsNOWurCE?=
 =?us-ascii?Q?A9QEmUhAmUJcjPyPI4YKvTVij2uLoXFM735+sKnK5vt3APaL4CtDpw+kF6Q3?=
 =?us-ascii?Q?op09TzRkp0jv+8r6kFidqf6d6M5LvY7TIq7E1C1drjddDL5Rzjq7cCh5G+op?=
 =?us-ascii?Q?GL1ee7kTlIg16Lo4UmJcdbqfZyDh09IFoB3qGJkGbdJW2jBzkwG+CNzEcLbf?=
 =?us-ascii?Q?HzemMKWP8ogAqnt9S0PVJbghpcuhRN5bE+PjEzi/ssEMmPgss26BtkNcVAUH?=
 =?us-ascii?Q?cgGP/q32/BZgbturcP9o1ie/sxS0OreS7Fs+v2kBDqcJU4UhGF8L1Ko0GMD0?=
 =?us-ascii?Q?kxwUukv+/SIkw4/07XKyaCjlpQU/A2khVOKI1KKGnfm2MAwQTUx61crY0LZa?=
 =?us-ascii?Q?jIHIVYNPr4s0ZTDikDJOkCPaBjqGw+m7aUsooBrYBYItA8j+pvR/+O7XgtD1?=
 =?us-ascii?Q?OTiwrspdN7FOP3yxxot8kFi2MxIIvhnyQ2HHGWj18FI03Hg0V9rosybMjD2h?=
 =?us-ascii?Q?5rlJYUrgAqc38Zbj9k/UgoAXzfU+OKujIegZgjeDEk/P7vHqAXaanscnUIM4?=
 =?us-ascii?Q?4u9N2rTTTtNP+h2wWML/okNqDa9oqb6lkg1n82vOQNeIdhA1FbpRL1TQihZ8?=
 =?us-ascii?Q?PMaDIjlRKcqGKRvIGCDpZdnJqsSieqmV+Ty9TeV04gYatsN2CVoJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73d31b2-a3a6-40b1-f5a6-08dec6d53761
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:59.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t2sF/2vUpFjIXE38nS3ZXYPeMPvVsRvrWGfPuFxOreyOT9253lOPgGLwc8/cyKIzUmkew9rQgRZH+waUNkymVNxVx2c80tDSdTohGNpkQaQiYuzwtubvDzlpKMtDN90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297577-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB370668187

From: Wei Fang <wei.fang@nxp.com>

The PSIIER register controls two categories of interrupt sources:
message-receive (MR) interrupts, which fire when a VF sends a mailbox
message to the PSI, and VF FLR interrupts, which fire when a VF
performs a Function Level Reset.

The current helpers enetc_msg_enable_mr_int() and
enetc_msg_disable_mr_int() use a read-modify-write sequence to update
only the MR bits in PSIIER, intending to preserve any other bits that
may be set. However, VF FLR interrupt support is not yet implemented,
so PSIIER only ever holds MR interrupt bits at this point. The
read-modify-write is therefore unnecessary overhead.

Simplify enetc_disable_psiier_interrupts() to write 0 directly to
PSIIER, disabling all interrupt sources at once, and simplify
enetc_enable_psiier_interrupts() to write the MR mask directly without
reading the current register value first.

Rename both helpers from the MR-specific names to names that reflect
their true scope, i.e. managing all PSIIER interrupt sources rather
than just the MR bits. This prepares the code for a future patch that
adds VF FLR interrupt support, at which point
enetc_enable_psiier_interrupts() will be extended to also set the
corresponding FLR bits.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index abf0f4d9aeac..fddc69cb4b90 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -18,23 +18,17 @@
 					    ENETC_MSG_CLASS_ID_MAC_FILTER) | \
 				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (code)))
 
-static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
+static void enetc_disable_psiier_interrupts(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
 
-	psiier = enetc_rd(hw, ENETC_PSIIER) & ~ENETC_PSIMR_MASK(pf->num_vfs);
-
-	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier);
+	enetc_wr(hw, ENETC_PSIIER, 0);
 }
 
-static void enetc_msg_enable_mr_int(struct enetc_pf *pf)
+static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 {
+	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
-
-	psiier = enetc_rd(hw, ENETC_PSIIER) | ENETC_PSIMR_MASK(pf->num_vfs);
 
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
@@ -44,7 +38,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(pf);
+	enetc_disable_psiier_interrupts(pf);
 	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
@@ -628,7 +622,7 @@ static void enetc_msg_task(struct work_struct *work)
 	}
 
 out:
-	enetc_msg_enable_mr_int(pf);
+	enetc_enable_psiier_interrupts(pf);
 }
 
 /* Init */
@@ -703,8 +697,8 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(pf);
+	/* enable PSIIER interrupts */
+	enetc_enable_psiier_interrupts(pf);
 
 	return 0;
 
@@ -720,16 +714,16 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
-	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(pf);
+	/* disable PSIIER interrupts */
+	enetc_disable_psiier_interrupts(pf);
 
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
 	cancel_work_sync(&si->msg_task);
 
-	/* MR interrupts may be re-enabled by workqueue */
-	enetc_msg_disable_mr_int(pf);
+	/* PSIIER interrupts may be re-enabled by workqueue */
+	enetc_disable_psiier_interrupts(pf);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1


