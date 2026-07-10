Return-Path: <netdev+bounces-306457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id klpNAjmnUGq02wIAu9opvQ
	(envelope-from <netdev+bounces-306457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21D7383DF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:03:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=kj1IA4xY;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306457-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306457-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5365C300E26C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022313DE45C;
	Fri, 10 Jul 2026 08:00:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93703E2754;
	Fri, 10 Jul 2026 08:00:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670433; cv=fail; b=ok96qt4tJvTXTG0wJwKN5bqAnaGFEi0OoCHIxXAUyqSaP7t7FVMM+PKnTs6hdvpp7PUB5dtVY0yHJ58u61scPTpHbQJeNBLUDhD84hERcfzSdWKOKDGSdRxM7iyZTwTZpyGC7uRRpOasxAeKY6I7C+QSuAlsV46CjGGwzZF9Zo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670433; c=relaxed/simple;
	bh=ndOZEET1LaHeORw+pbHP5A3UFW2rcd6xGverpcPy0FI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G7TzOMjHYsUVPHrXfdPAjRo6O6Q2whjK5JiuvHo6Z5k6gLnwu3jds3pLTyfL8vbrPxWMFO9Pn1DPX6wk8E65m2oFjZEmO4OiFWcBgOx4NXDkk+BkdpZQ/BjopIkYk67q+EahHDGpPUsnVIcGz/32bGEU2jdtkuLVLOyiKOpj9rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kj1IA4xY; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4m/JynpxZKQgS7yXMvyTOWs5/lRqgK9tV4RS1JKtxYvgDPwl8erSMy+9MfqW0N3VgiewVqk0agwRmxh7Z1j2EIPVollW9R7nGtPdFs1ZPo0KYg45bN6D+y9plmtes2EBBvlzt/WuFgoQxjUbHFXd/9gEEQyegpNtMfxdP8SYCSOof7k3mYwsnCAlQKzLahMSKL8Gb1Qx65cCaRP9tzL+FA9/ii9SPKZc7Nk79cyT3Ul1Zs4dbcaqzW1pf4FGrHP7KALdnFaxAUwOwcKYJTrr4R5zQBQNj9f+js8fpP6uBTJerbd4kHW5rXidOjRDSbU2UB3pgP/w2V34ayupXyV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxKAelFk1rQy8pFWX+CAn9yrQ2PCdMgJOC5Rfg98DRc=;
 b=Q9XmFR7pk4AJpnPIV9vIv3ueeaDZoBWjUhXKjS08A5BXEocJylJMdiIFxxGp6n54yTybx3rC/0E4TuG8Vihm5Nbi5MgxqZ/FnMHrxpNOATF294CcCwbCenmWvZuHT+0RnOFsZSMBu7uAn9bJ168svQmAOz50ZUy7hQE5EgiTa8Wt+e6eDs7iFl3NZEi+8SiBCKwRcHDa+1kETUvu1PSlpPTqXmYa8kLTT+8XesWLQxCd7VuTC8+MMOhDMJJJcoaksvtj6U2VkEArO6qiUpM7dInimkOPDkT3j8HerXRJVWjw85uXzTUcvIzYj/fZ+UE7U9scHEmojkgPP5Po/GyStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxKAelFk1rQy8pFWX+CAn9yrQ2PCdMgJOC5Rfg98DRc=;
 b=kj1IA4xYg7tLH9X/xMEf2BCw9jQtfgLUvrdB9SSO+xBF3nXXvnlUaInURvVKU8ntk4Jk7UgAkf+0tlRyaerE36B0ZPjNStKUXFE+HUSqvZC1BpNJ6cibc9atKL5sL/HZx50faXmCvORU9FzhB5cSCWSBlWgEL6eFd2bFIP9OgOMZzy5D+iB3xKAxdki8B1IfPs3MSSGsD8tIJa5rjZidgstpgsGpoe8/pFN5QRHPyGG8YTf5NNym4WULp9gHwO+QxZdyJL+TW0lHtWZ9pNLbERubodxBFrwiKVUi6Wkb/eTQg9cGOXio/UBaf5l7MgtjGIlzMqGFgIErdsRJW0I17Q==
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com (2603:10a6:5:35::11) by
 AM8PR04MB7412.eurprd04.prod.outlook.com (2603:10a6:20b:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:00:25 +0000
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185]) by DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185%3]) with mapi id 15.21.0181.010; Fri, 10 Jul 2026
 08:00:25 +0000
From: xiaoning.wang@oss.nxp.com
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	leitao@debian.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	xiaoning.wang@nxp.com
Subject: [PATCH net V2] net: phy: motorcomm: read EEE abilities in yt8521_get_features()
Date: Fri, 10 Jul 2026 16:00:18 +0800
Message-Id: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 DB7PR04MB4428.eurprd04.prod.outlook.com (2603:10a6:5:35::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4428:EE_|AM8PR04MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e0cc5f-d292-4d53-8d48-08dede594cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	mkCo1BZHbuBKDkD+QJEUWvSVfRV+DLxIvC8EKyoRo9EJ+agvHW358q6iH5LGyxgKh+YuMmMfRrTnuu2E9DXmy8aHG+/1n+LfylPWOyhSQC1vLyKUin2puvuGspz54BmU/nzWrBGYbaTVZTISPBl6fq5zV84bxQ0dtHLPEqUDQwx0mXOAMLuwX8ONRtVseIRfTsJi7ZvBF0dNHkyPgrBg0nHOonmFpAv8SIXEKhC3vKcHZ7wwNyrLrA+4lXkAkaKtw5Ml4dgAiQOygy3hCbSIGgmi6kjzJssAQKJh42gfdCveqYXCbW4TXVhjQ40Ic7plBV7PbRZhB7KdweRzQtfbftpX4eADkTXqVwGwhzKdCu7DxtLxmyP4zIoX16b9k38e/r87TVcp6Jac6Peze3FzxD+DO0Ltxn4HcY+SCPvS/epEJ7kD4BR2VKJw7gpN9GU3myMJfFG11304MSBoSgymBr6Jm8ffwS2CfLNYJSKgDA3pI37AINUcJd4cWl7AmbzN7VdPPL1vQhLLN1PMJPsmRvJLDESAHXCgfnBUPnb7QKd2e8otfIQtU1G9ltteBBWSZeM2GV9XTf47dpIZRyCspvf1wqznYQrXJGf5uZDsW1DAz6DV42FMOFe1//D5r6SZ5WS2nzLCjiJtbGMu0w9vR/IuXG+CL1mrjitlTKRyFOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VpbAi1G8YiKJ5EXYgLOmIg5w8qtnfwdEuf3t78KoGwSuV/OE6mGQ5ONJz6th?=
 =?us-ascii?Q?J6+ysPGwjIPYH4Ym7gtN3h6bpKLK/a4DvmRNhw01Pb1jXm4nY8QhdR4dWLbP?=
 =?us-ascii?Q?8fwQTJ1L//IBcDGI0xNZIINHaZ0lrN0Iab/589uvMTqRetWAPs4lvSoxy9kM?=
 =?us-ascii?Q?9hG+crmxQGvrpGw/KkMvBeG6eVZ9Cg5P1BGtmLOB1TN/Rmc7IqfWknljKJLD?=
 =?us-ascii?Q?PwuGVeAonZvouB0+8qSq1rNeoNKqdPwyGz9sloslVp/o43wyK6LVjK9i73Za?=
 =?us-ascii?Q?gFkRPoVMXUYW0Q1BDhlOFreDcn3sI01pkAGK0L3dqvJyuYBbIWbCaasVsYPV?=
 =?us-ascii?Q?Xy0PFqwfahtiVGW7Wr2HIH6S5e37dSzgzJQ8eZA9w6n2yEQDXVZ/wZKyt/sp?=
 =?us-ascii?Q?vLcY353g2/iZsio5jVruQNPX9Uyg4J4AvmyRuhegoQgsr5IAkzz1m4PSso8p?=
 =?us-ascii?Q?/Nyl92rLzqkRqnwm/c+AcPEEocVPIIVi0uWlh/uZ26pCis6RJPZ/JOLR9kul?=
 =?us-ascii?Q?u8X/ALmhjS18E9bgbAAqtzyph9FOHsEoYCxv1cew1Go3KPGj97Qg/jFMMsWB?=
 =?us-ascii?Q?E+7Wx+S4AQkfjHQgWH7HnJwk1kmmhsFLmfdFWh/IdTZZnDOpHkAC24xMgW/1?=
 =?us-ascii?Q?MQ3Nwo0/ifWB9QTUbj08JB6IehjNcuTE0oVYUjDpurOjc+P4Rt1X0ZgCy25R?=
 =?us-ascii?Q?0tOhC5bRHyVma2fnHCl5Ad1lG5UOKAZQ8KHOWcaA2DzAIwcO38eaHBo/5xiv?=
 =?us-ascii?Q?oTTuWgp7FiPxv4k832v5E4DGJdn9355o0H3/dHBaIlBFlmHZyxUw+zll5enK?=
 =?us-ascii?Q?LZafJM6xK8MBVavyBO3FvNQ+IHqA8curM603+jygCz2cWsahKNGppyLVn5P4?=
 =?us-ascii?Q?dwsd6fl/KkXaRKTg5Ngeo6cUfWcEhIvM7Kf2kEkKCyY7KcpZ8pol5AsumDoM?=
 =?us-ascii?Q?O3CyJDkGjuMpIVMEu6RqgkRwNhNie94yyvOy2qg2hl/Vyy+AOfkG2wmxczDO?=
 =?us-ascii?Q?aPv8aOupTK1PZuCIT2Yadwoy32qVvFmJPzKnl/8staR3xZ1GiqvNTfDNMbsb?=
 =?us-ascii?Q?ZZP2WRmjlXfGbbwko4N2UAJi8wEI2nbVPkxdVVKHLOkV6A5F3qRuDt5NLLM9?=
 =?us-ascii?Q?Cmpyr/u00ByIp8TQXfb+5PEsNKcd4GRLDDe93qNgzUy4115Nq1cADXOUQZKg?=
 =?us-ascii?Q?dBZXIUeNVTpxm+v8PLQNiByTxLeas+TK/D8wYKBRsWNWrEUPaz1dR0k3tCim?=
 =?us-ascii?Q?/ieFWPI3f5JLlHDkpSfOcu3gEaFustybfYLpRXYKkArPVTWokAh6Ssncs1D7?=
 =?us-ascii?Q?eN9IjcFewntF0z/pgr5IgX/OynJnSvMfG8NHfHtBiyMZ2EQNi+dtteuhANTF?=
 =?us-ascii?Q?iV0ax0wjNvKIN5/hRePk2XRu4OLYc6DgJHWgdc4EPvE4zBcBStK+yJ0Uxqpj?=
 =?us-ascii?Q?SIjM5S9IYtjUG0unwIH3iy16B7ogHPkm1TeP+Un/Y9mMX9T6iQeWGqOb44kU?=
 =?us-ascii?Q?vONjAv7IeKIkqSiiy8MsoW0fJ4uCt4h3oVoPJe3uDyeaaCQ54lZLAJqIiTmi?=
 =?us-ascii?Q?toP7MI1m1F6ssCEDWIPUGgz/S+UBJEeuqtbrS05FihjH5fXmWoy8Sx/lt0Cr?=
 =?us-ascii?Q?5GBhuGg/kXAMtGObKPhWCsjF+Z3DuBDjCMptvFUUAWatBZ7by3oLbtDAJpGL?=
 =?us-ascii?Q?a5EZb0E2wx2F+A0232YjCxZhV4qcl5v/TyaiXZSi7DOiUhb1HBSmbgycfBaY?=
 =?us-ascii?Q?jBWzVj8PWaQ/Qcz92N11FzQ0UCCCrc/4wNOtyfpau/eH9g+6ZSEzD7/tvum9?=
X-MS-Exchange-AntiSpam-MessageData-1: oZOFVM3Sds+//g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0cc5f-d292-4d53-8d48-08dede594cba
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:00:25.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQRUijwj5loKyjqC8iXOOdPr06VadLqO2KWGQ2kxtOVGBnaC2J1/rMsb7jytuoXmgB9WGLVmlAEnQNQLqNmU5fFHmRnI9Wcn/riW1ZKTSNpqpruqfSXUWis0H06xzLVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7412
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306457-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiaoning.wang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:leitao@debian.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:xiaoning.wang@nxp.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,debian.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoning.wang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD21D7383DF

From: Clark Wang <xiaoning.wang@nxp.com>

In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
driver uses phydrv->features. Drivers that implement .get_features are
responsible for reading the EEE abilities themselves.

yt8521_get_features() does not do this, so phydev->supported_eee stays
empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
not supported", even though the PHY has the standard EEE capability
registers.

Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
to populate supported_eee.

Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2 change:
 - Since both the YT8521 and YT8531s, which call the yt8521_get_features(),
   support EEE, if genphy_c45_read_eee_abilities() returns an error, it
   indicates a problem with MDIO bus, and the error should be returned
   accordingly.
---
 drivers/net/phy/motorcomm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..73b5da937d7f 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -2490,7 +2490,8 @@ static int yt8521_get_features(struct phy_device *phydev)
 		/* add fiber's features to phydev->supported */
 		yt8521_prepare_fiber_features(phydev, phydev->supported);
 	}
-	return ret;
+
+	return ret ? ret : genphy_c45_read_eee_abilities(phydev);
 }
 
 /**
-- 
2.34.1


