Return-Path: <netdev+bounces-303955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AoBbLCvbRWp+GAsAu9opvQ
	(envelope-from <netdev+bounces-303955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0346F3408
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=DzOyFvYO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303955-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202893092381
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A23148B5;
	Thu,  2 Jul 2026 03:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E443101B6;
	Thu,  2 Jul 2026 03:26:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962815; cv=fail; b=o3xBLjZx+9DPaMeQ3vi+e0cNOKPqI1ACfjarRDVKxU8lVxuRKo+y7rHR8VvGbtlAx9A3ilTa/E9lTYFsqd4u4XsGUdC0lRdg4zfaFgieKX+lgfUbL/yYIAU6ejjCMQUkeVa4a6N39KaIisaRfzAjx1mctG7xPEBEmK7nYd8Kz4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962815; c=relaxed/simple;
	bh=xs5XQR4GCTJgSYpvY0nM42qJl1+P3JkQUA1R73tXpik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlYlxVEfrDDsyvNK5jBVenHmaOZQPto33p2OGvw+YDKHunFABKbiMyvR7xo0+zQO3Bdnzh0zsNz3vAvhyxSgQgriCyeTwU/QqyCromhnqDI0DmfOp8uwubScB8+fASCAAevcjQi0xSojRPUj5/ZraF9v9TTIHUX/bM7tTqdXXHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DzOyFvYO; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNZHZv64ZUf/J+BopVpkhGheckuvjBDTfB/YVYR7sKm67KHfxOFXsXtKBEDoLHMX+8mXwyLfkiLDX+bO0dK81i5jrn8Y0Jdpg7WPdvyS2bvTbo8iSoxckdVibs0XqlDzeFwSPJOmWVaMGzE7JGgmtHdf7r97MFl6vPTUh6d06eO5j2aj2JTiKg891kyQagVcRzU+rijv7SKC2OplxODBipAoTutloghkFqIDBhIiuczdpeB6QDNI345RIi5jEHuPiCcrTQBg+Hw1DcpmPd6rT22sNrEKAqfi/1kFbk6wIueNb4wbfAwpkXPwx7HVKA5W3uOySfLgiVYTKY2AYxyfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=TPCEJe7eRJnoDV2O3UH+Q1nTu34K18DKpLs7IE+PNldI9SZ4hlZXepbXZEVHxgyCzZefQVeZacR+Jutw3ZCgzaU3APVe+OA+/V7ilwedB/rHljVGq3IIHk5iq4/4IQURhOqtdJQHu4SOAr/S2RF8cLozEktcAFAViUT8kPR6lTqkBYAZ155q3D9Nv91e9biSrEuhL1Rvbv9/5UbeN8BKjlfshgeRggy3iOV+RdKIYU0gpSpW8iAl8m0CLSjfUGBqEsbh9UydO6QJ94oRlW2jc1lwOf1cXOGuO3d4OcHpCerCKNqhi98ZWbFq9dFcRUX4M4q7mxldfkWUa8iqqJKweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=DzOyFvYOq5zqaCAj+k2DgLyyNt0pmAYYQViEljjIdg00K1+7L8e3UA9SijYmia2Bb71pZjPmVyqKuPwuBIeGXa8l7AYPybiWzgCl0saY4BTuxj/HdhnU+jfF39Xawo/pB1Anjziqa1VEUiihaGFpI2DQhHv9+b9cPtkMTZFTxwRsFYCR2zXwGT8keZs1QWzXSpec5Ht914rq25MF5ewV59+IIiQ1I1Z5O3oFdjZGjNM8Qdw0dKc0l8YFM9f2VW8CdEeb5M06cXaxXtrEKf8PO33KMjxsSUb87DdYkawiyoXjPvae61RYeen1blPVnc76Gy8BQ1WoUpOGq5G0gOzw6A==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:51 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:51 +0000
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
Subject: [PATCH v2 net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Thu,  2 Jul 2026 10:57:14 +0800
Message-Id: <20260702025714.456233-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0147.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: 28021c45-7f8d-4c13-454d-08ded7e9c1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OqHxpoLi6gfA7WNAlsGoPmKNoiZ3wGQkumF2zv+1sJez5Ti2NmeyMWE3bmUZy/yxQieeBR/lJUWLOreSLonZDqNl8vtYR6MZ0cE7u8e6P4T4fBlipBwEIsm+e0uGI9lqHgoudVyc+2CxG+s2ThayJKCzgKsfoIQimpXObEGGwO9/h70b6LLPCbPszMsyvwPyuZcfsVSJX5brclmPUy6L0uXTW6llVNpuz5PwmVDmCn4meDzvtdr1pSLZD64pZ/9tRHcToXCsEXlqDRCQTG+/CMC1sjXe14D3eATTHGz0y3R6yFSTaAZbWdZVdUGzjXu9ZP0fJsdiTsL2Vm7NDh8xssYjKO/d6q3bSxiyvST313yIAHq/mHvKlS2dnVbDilyvNEA5X85usQfALYhS7J+RKNFBHpYoFENOmOx3XI7Y40ivhJ45t/zstK1d1iogKnCaZn6mshu2Z4oRprXADpSwW5O7j8cXTskjMMeZ/Xur5Kc2q1fS16Bk0FSwth7v1kjhMLU52brDnhKcpXoj2vC9CBK0akX/8UD6o50oeZ2H+WH5B2HWMliTtW5EU+ExcQA7rFG2joN5uf1QezEWubGzArHuVSmkUNnxWRoxAKOdMYFi2isO8zXcSHQUYkBn3ZRjy6JzSJrTkJnISXdEZqygTkjcsxgmM4Yp6Kuxrbv7JgcWmV0e14liPvjcezN2gxc61wt1NphLyRvXsXJZ1pxcfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2cV7dKQiIs2By8ErgBCqefxXOBQymXIQMt/tTCaN8BP99eg6UmqMTVuO8qKk?=
 =?us-ascii?Q?A04/2vWy2UxGODr61GbZdqDSzY8lq1By7WDXFHS18W02a5tZvWXaSEPnf1Aj?=
 =?us-ascii?Q?TTZ5vKy2EAJZPk2qSZa7Un5BsGyqad0arjh19rGf8dtzPDZGj1CUpGVyQk2J?=
 =?us-ascii?Q?IugCt76qo7AMT9vrCKt24scuK1ghSa78GQf37xWAESeOj7X2BQlnqrINJbXm?=
 =?us-ascii?Q?SPOSjY3M8Wv2hRZKbBFSbSr5geU6nEEmOcvbuEFDcv0DlEcTpCn8dhYrGq33?=
 =?us-ascii?Q?nF4Ko+hF6UQfbJ2AaPQxWYkuqpW5UC0DE16uLYF1PTCxqnsHAkFhSAQpauQS?=
 =?us-ascii?Q?3pKyH0D/+wQoOramE1Dqnm1WitmEWcNBcnjHP2VehbP1oezrvQYcwzSwV2w5?=
 =?us-ascii?Q?+Y5vB/sGBcfD7asjqqkIZJscCaI6UJzZRL6eab96JP/oL6LszL6BZ4s0zAqq?=
 =?us-ascii?Q?oarzrdpw8wNkuXJPd1o/WvpESPMq/iFsx/xVr9xi4USfMjUByKgGKi+QeMka?=
 =?us-ascii?Q?ISpHd4lReNk45+aLzcLQhw6c8xXK1F09a0qIrzDjzTscqHZesRI/CocVuK9Z?=
 =?us-ascii?Q?rMkbkjDst5GKpcRyEN2NmioHleJlj6LsQkOU8UmIFyiSeDRxrswuAvBMtdkX?=
 =?us-ascii?Q?uJnU1X56dd3TXdEkatd37rdr+GWhtGueH8q0iKTupiQDhA5pF+DYM7s0ndbl?=
 =?us-ascii?Q?K+jsiMg6Ki+RvFZieclfj4+sZLKPcReXQecYO3MMpgBjhHuX/aPsLndjsALT?=
 =?us-ascii?Q?89qgNvPU2aswemSIt1WV3RRUXEEH5ZW76cVdEdBOoeQFtLVm7DLoRR7x2+Vx?=
 =?us-ascii?Q?3LkX2dkFXPmlwWK/dbwHKnQDDzFvKt+MsDnay8MgPoVJEMEnxgHNPKQkr4nA?=
 =?us-ascii?Q?rrgFlKdtP55mefnaQPosddOsq3BrZb6FUT67G0MkkYDFQJs5rLmpfCRdKhwZ?=
 =?us-ascii?Q?A93EbtPPiC7gXtih9JTIpWoHdUYQP573DtGXgC3mYvlCMerBwDNF4U2N0JEb?=
 =?us-ascii?Q?jK22tRE3iQnjxLdDEZ93smOTw/x0Rz57yY3pVtUGkHyZv/Du36E1E8X5/60G?=
 =?us-ascii?Q?MPdVWZLeAMGeOZP1b3YSP4a+ys9P7siWzHlRKa8F3p82FuKerLABLcH12+1j?=
 =?us-ascii?Q?tOs2a13BCr9Irw4rz/mVLi6nE5yzkD5+D01FhHraKFjdw1+2Ls0RkudiGdD7?=
 =?us-ascii?Q?eKqaLbiFqsvXZRTnyHIVOb0nSWwSVE6etmiqQNtb1f0TaxgFvD47Qg9l3nsK?=
 =?us-ascii?Q?5OCuyG4NFcxTLBD77yX21t5bukv466HApxO5GxGlJ7Q60Iamu4HVVb15VBbU?=
 =?us-ascii?Q?lC4PuhHnA5pYThfKZiQ4Ye771jp1dEqhrZryjW32J1FTRsW7KdpcS3K4WBfG?=
 =?us-ascii?Q?PF/dkIQXU2TFRFBzFaYwzPa5mvvLPneprri8G1jlK0KghyWoKjQUsT7b84YI?=
 =?us-ascii?Q?q10L+B6+4xLzKSnDpoIWcD5BfYmMlFi6SI49Cl+SLprp07Hx/TtYNCeFrOjW?=
 =?us-ascii?Q?oAyCmRDddEL9ZJXgdNrOGNsySru1aamptXqNDLdilMADlLtWa7oJLIlps0dJ?=
 =?us-ascii?Q?q+3+Xj0Lo/qnTyJfNO2nmGDItNCgMAcFmSPzSU/2aXr6+FwH85zU/NnUhHyD?=
 =?us-ascii?Q?Hw6O8SJHkK00mC2ABKoKASRhUMg79yuYd2SjcuMeFq2XqugYbC3zI1Bx4GZa?=
 =?us-ascii?Q?pFwiKt1B0BiGNrdnbav++1EbQdvny9YCAdSobe9oinQEqqKR3sYYivND3Wz9?=
 =?us-ascii?Q?elSYWpFUoJhN4o+ttSmSrD3gNAG2NlcfChxeYVYNRrs0mK2nwb6l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28021c45-7f8d-4c13-454d-08ded7e9c1c8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:51.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xecJzwa5IgumI+1w9dU/1vvXTob4TuqR/EKkWu3pb8MOP4ME7NJWZBfARVsgyZyoP5QXJWfBM9TjscRDO25sDOKXMhzFjSEm5t8rzsIll/2xhzEOKU3MsBFFIxL50+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303955-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0346F3408

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


