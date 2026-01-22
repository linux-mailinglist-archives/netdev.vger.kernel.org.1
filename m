Return-Path: <netdev+bounces-252288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAZ2E0YGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DA65CAB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C08D26A7928
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27544D688;
	Thu, 22 Jan 2026 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dTx7KgbJ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152843E4B0;
	Thu, 22 Jan 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079466; cv=fail; b=EbpGXHE8V3A8PKPKbN2tQKtB6xq6C6FIpf7mP+Ze2Q0qAc61BkqJJxTHMbSJdFIl5JSyT2I8z6ddmV9OFcdr1pXi5kUHsBwSm8oXgbokpdrbZxFI2m+u2VPqsldfoaM3l67fApovQVvc2wnCp9T9rYlZUsRV/1l3xfELLnncDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079466; c=relaxed/simple;
	bh=l4OLiYtOQWILMhoZMCNEtdxL7M4mObnII3hadBcF3JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJub/PwGiPqN6+TKAiFJu5mPThTKJFx6J51mNb6G7HyW7mf40QgqXTQbeehTlVYMDBsSkEq4qnVs/aTNnFQAkyFaHJiLe9D+FkC2xVcFk3oYD3XfGSqzepsDkCPoP19d9VNgFKkZbgtvuLQv9K6yveRUgRY9tqB75Qo7nd6amy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dTx7KgbJ; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BADKYK60BhaNOie5AKnDMrst6Yvb//SUtoG7jzojQfwhZbQ/KbBteNSuHPxngcfSoIEypWctiz07zysHvB4lmP3qT8Ck9du2sh+FYj9XD34IXxRIqFCugnBMcL3JhElcFLiy0AVGN7obemuckNDvEBYjaTn4wNHpamP1PFlgsmDwVp5fF6ZUN4iDo//YLSFFjtQmeVwbuKrGKBzpun1h1kv1NTQ9wNOqR2jZaNYs6H/yzzUhH9Mhl0fHZjYFTD5DlkdPcgVVAOqDL2ZVvNUG3mML3ehHTXe1J6i8cqQPrEaXltrxMseVvZTGxhkDPNShlVRZqtSz5Kqq2pBR6J/9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2YC0s8vxbtcRXMWcp7UJbjvPgpx3yuqojyQZFYuBug=;
 b=NTMbE4LjfhdRIBAh6kb1IM3NhM/wc61aGH5QroZA+56fnayfYlGqVPLY3Js9MRgapDjxFIMIH8Y5pfJglB6zAVZyo6/z34Q2RuMIlxtilTkfTPv2aS/QUVcNfQNDeeQ7o5B7F3Y/3emI9dDUUXlfrhttwVESRWcEm61jp75cgjdGQ4mWrVDqg+iInNZcuruagFbK/BfCX1Oh0oo14Cs7zKt8DhtWHQsyXQ7rGaau6xX4+82cP5+p+zAVjNbMN+v7dVLaDYwBMuN9ilBOkzySrfIFlD97+e2a6c4pkbTfZhIdSIhBfQx5cZo7NfJqC0JdKooXxkpBs2o49Af3mwetcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2YC0s8vxbtcRXMWcp7UJbjvPgpx3yuqojyQZFYuBug=;
 b=dTx7KgbJ2WzlMktBgtzxroby6FGx7hDdZSXhSyV+eanbRWy/KvO37lSlFvBahLracU58v10JeIYTyAKs8hU8k/LcPuyCo3Id5yXhzt7jLixHtQWj28hyUTscLoiDPhvjTdqG8z17mp1PHvaQnW8nl07T0uaBiwRBTjjs6/Fxic/qtbQIPO+PgHP3dSXZFf4BDmY7jn78p2s3VDLyuMNhWMa9lGI/G3M5eJO5+/LVQwTDg7leZEBpMo9UosWwHpT1dXds0XK/mwQlBbFSzFqWyrAsfgjSqBVnXDu9xRv7XEOsrjPabmjU9JHWUA1RgnZT1VoCMgNiixZoQbEZI6uZiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:34 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 net-next 15/15] net: pcs: xpcs: allow generic polarity inversion
Date: Thu, 22 Jan 2026 12:56:54 +0200
Message-Id: <20260122105654.105600-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8b9ab5-1bf9-42e1-0815-08de59a50be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGEhLPdXiLnkogs7dY2PF9gkgt/snXIY2p+3gQ6IW9M0+tk6ufuO9ZfKffFh?=
 =?us-ascii?Q?GZc+fyUeAaHyTezFVHpGBBp2RPpqYPIf7ZK4S0Z4CbWRS4t3nZgb/k6WMkDo?=
 =?us-ascii?Q?fJyd18YA7ZzglDZkE7xOig3ghnnWaf9p75s0QncbdeVkYa5Uc56cfyGSiWrm?=
 =?us-ascii?Q?oTYb/9Qs2EluU6bp/X3g4baXo9Me6TPhCyKRAghtgd6tNWvgDdFLwtTAzXHX?=
 =?us-ascii?Q?E3YnrLbVtu/583O1ePgE0B7FSdY+0As+1UiN+mNEtGtrQIsgncdLmre5uTqk?=
 =?us-ascii?Q?0hRX2ZnYTqvTv5lBNjCvPvc49583inYFsTMHXhhn18A4tPxEWWpKjUnFP7OF?=
 =?us-ascii?Q?5B04vzP6+N0V0ic4hu67ecmBf/CbFzPrqeWZ9Eutr/a6bOK1NKCjDG2aOksU?=
 =?us-ascii?Q?9siOjxkWaC9vFgZAs4Nupo5TtfKKmD3qeFPhwPqm1RpA/IoISZhPtcua1r6L?=
 =?us-ascii?Q?ea2A1y74Bdnt99lFABkkbbi4vKYhx1E0G0bDGRXja4/HCzgCdoaIEoDnw9yc?=
 =?us-ascii?Q?s/WTOG9CpPTpOlmjbpkql6UvmgPk4eVMsPXYv+9c0t4cY7+PntGWKWnj0jRg?=
 =?us-ascii?Q?DyYCqfgJ+GBq8GmhCorbZQjT38gmXQ/8lrkCqJ4D77qN/4MTTyk3CGfSA6/D?=
 =?us-ascii?Q?O/jgXrsEVeOrPAbz38WIuD+sMYCdfGdti22epLxzSjOXfw73M5/FjfdldPA+?=
 =?us-ascii?Q?SryIgxtKV/9wd2O89Cr5tiWNssstfw52dcR2azXMoQmRReJpvGgQdn6TNgPn?=
 =?us-ascii?Q?GVnxtp/pTKP6AAMzl8zVAjSMcZEzEy6SMyTAQrT0fO0zgChgU4YnCSRMIXKF?=
 =?us-ascii?Q?pUA8vUq9XLAr5Wpb6PlMk/nV19oXcF42EIeUTpAoE+ByMO/3pmi+KWTwpkea?=
 =?us-ascii?Q?dfaEjcYA2f7x70ufJEeKjThZkLBw1QUtkDHowv8EMo9hBJtUgYv8C7CkEpCP?=
 =?us-ascii?Q?nSMN1xMFg4i8DqpkYvaWNqqUuUQVTDxH0LAOM69hMIjk7vTQjE3V3KGNWXqI?=
 =?us-ascii?Q?T3+VNQnDRpLMmAgA9b10qq0Zey28tQkRLoRrlbK/hxzvTsgulAV/TTY+ZJVb?=
 =?us-ascii?Q?juir5PkkHCFRmUeft+D2oeangLbRZrkZI+Y6JJhWOtw50kk2uy7Vl8H/MayG?=
 =?us-ascii?Q?qA2UySRbSlw9gGw1URJtqT6QyWdqh6MIWN1HboPA8r4jDCw90Nk/4964WS3E?=
 =?us-ascii?Q?SyhqozE065ujuePWrX6rrL16K3A09pCJWnN6DQU7Mb9X8Ixh+wwi8AyJBtn+?=
 =?us-ascii?Q?f4bM5sQVyIpNAZ7j3adGWvBzNtVn7kMmeZpnlgHxk6BwehhFWYThei4khqdo?=
 =?us-ascii?Q?z61CRX8jYTez47Wh2o4iuQ+H0gjweHZSM1f2d8RuMrCMVDP/uUwGqRooGOG4?=
 =?us-ascii?Q?XiksZ4vI7iGASnF+J2Iesa0fjnwvOmqSnqZHbW5EQ35J7doex7clMYnwSVMV?=
 =?us-ascii?Q?eXTG9kPKmGMC1M2eXkb/xlfnVSf9lNg5YOEEVdXkM+/LfgRVOklplrprq/VF?=
 =?us-ascii?Q?WGacDOTuvIwrQp18An9ZBG8eguMVJBIf31ObHgoGFbH0DSetWxc9svxa/c8o?=
 =?us-ascii?Q?A/X/i8Ar2o3zmPlW9dpkExWk6kdcNZf7UvP1EcuCin0Ji9/4qXTc1N8zttK9?=
 =?us-ascii?Q?WgGPMYvO+DCeeKdFd20IhoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQxvEH/bkw1BCAs6iEXEIfeg7fAo1jLuG2X8s6M9RdK4hXwhRK3dQp8XxEnU?=
 =?us-ascii?Q?YmjlbmfVQBx0YI3ZsIglqEBUzcp5o/xVEDz/a0spEl19YmNGqMiBDQPHh9ru?=
 =?us-ascii?Q?ugWHYvQGAPx4NwA7YFmIOYm+ZLq4yKST3pOQR8fYJB8TeddcO1hxQO46dnNy?=
 =?us-ascii?Q?wHh+kswnMQsZy7Ph77NvBCut4Ik9SC0SlQQRyrYkFcBcVIp3yRUwSsibh+5K?=
 =?us-ascii?Q?gIT93EeHLZD9tKBV5ntu9pWpV6x1jxPigdtWhS7+b4MFpE1tyjs9KgWURYX/?=
 =?us-ascii?Q?pkQMagG3xuAPBY5ao4BkB76W9PtF/Agmk/Y/oS2Q4Evkp/E9m6ivFgvwYSqZ?=
 =?us-ascii?Q?kGqPSMTpGFfLsa82ICCPl06iTt08792wPiHopI0ORD/VlPVM2K4R88VqrpqH?=
 =?us-ascii?Q?2k+1k+d1Il/c6NS/28ZALWinr7yDyC8JGb1JQNIht2ksintu7Ey51vmbqGS5?=
 =?us-ascii?Q?YwuZNTFQM7s7Q0XitA8B9YDvLS4mK2xhDn1IR+OmlSswOR68RiZloiQPCbpG?=
 =?us-ascii?Q?TBjOVe0RX1VFj9G0F0enhyVu3vKeT58PuzYYwA9OWvgzDzt7pxq30oaJcj3u?=
 =?us-ascii?Q?dShmOXHScNNopG459bfm9Qvi4FLpVzTCBb+/iHXfWSs6bYepMA0cZULxP4dX?=
 =?us-ascii?Q?pT4TrvlPJkngF2H2BIuWP/1XfeOJfZAymKCzTS4JwskjPGRjJ8Mztf7g4FfV?=
 =?us-ascii?Q?h+mNdaIju7NVDC9N/YP6bXUfalTP16Btf7PAFbtBDo/rV1rM54LEwEdRSnEv?=
 =?us-ascii?Q?g2F4Yk2ER0FtqYhir78U/LNOIkCwlKi0U3bwUDVHXL67Q1dtl81/0jKAmm5y?=
 =?us-ascii?Q?bHxoIgMvJfLaBaVghO4fth8gwZ73YUXXU9O80Odkkq4gHwHF7kvOq5w4YVB2?=
 =?us-ascii?Q?wbLUZebMRPf+zoi9sL5Ifg3plrwTtUdpPJeHp3oSpr6uJKAyDMNoELuqm+ZO?=
 =?us-ascii?Q?RZVnnMjhPIj5fkWLD1Vyg3TgHe50yGci+jmzK21ogCweTNh4rZdsYogOvwd3?=
 =?us-ascii?Q?7sPCCVqEA46C1d2YzU2PWH5EbHP0GHL22XwPybchcVuFMLctJSyzzKDLP37s?=
 =?us-ascii?Q?MlwBnVJ6VPJE+1F3R/UOGEFAIQNXO+Sj98zLHHAEwJKKmjvYSsEIWo/9k44+?=
 =?us-ascii?Q?1ZM1HtvnOs5CKUVHwCfgWzzAD86rbZEnwKNGi/xGd1GEUDl5c56IlNy2yqUb?=
 =?us-ascii?Q?hF9ldsCGg6qpSfiSEKFqqlB2Za4XOb8pP9S8O1V9AF7ByJGdKg1HDtFlkNgP?=
 =?us-ascii?Q?r2G1hor4hb6QBI0kU3rGUR82WJXvWJ0zimCICBQx/8SjqvIAqvZ4j5knDf0M?=
 =?us-ascii?Q?WnWBHMW0qyZkpWV9ZKRQMmVt6IH4EqH6NHhLVvS1xTr/S+ETBLJ3jYruTVKx?=
 =?us-ascii?Q?NbxK/2jaghfw4dfZM+6mtwhZY9MwF1WSRRblQdrlZl+qekOrwmvU1CzsLCoL?=
 =?us-ascii?Q?3UNcslKB8s2+10FdK0TWjkDouh6fSfHcfNIhYQW0V88nDcsx+HH1TE4rOtGj?=
 =?us-ascii?Q?c+Hb3m2wQ5DtAho0DJkOseiXTxQvbo/cX6xV3zl+PY1CKA4rH3/J/fBcfGQl?=
 =?us-ascii?Q?jT07atrs3fddgK0ZMYQDbradB6vXrGmgKQxWfBQx5Ux+Ge0b6UGjScKpz9mA?=
 =?us-ascii?Q?nfBBfZJTPs2njydBpGVQTOy0BR/psaqlb+l7+vVBqHbVosEaAcehKYZ3z48L?=
 =?us-ascii?Q?Iqsl1dEBERIK1LjjYrGUvgwXAfO+cQCeSJgNVyEB0wlRaCcwj9ewviL/I70l?=
 =?us-ascii?Q?ZXdUgkXH3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b9ab5-1bf9-42e1-0815-08de59a50be1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:34.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iIHO8rNa2zvggrWoaBlOyTNqgT8BtBRuzBhdrcxFNpSCD+7ouwJ4IJzvFt/uiiOxlcgyluTDQtD0KIcTrq01A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252288-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 189DA65CAB
X-Rspamd-Action: no action

Using the linux/phy/phy-common-props.h helpers, get the 'rx-polarity'
and 'tx-polarity' device tree properties, and apply them to hardware in
the newly introduced xpcs_pma_config(), called from phylink_pcs_ops ::
pcs_config().

This is the right place to do it, as the generic PHY helpers require
knowing the phy_interface_t for which we want the polarity known, and
that comes from phylink.

By using the "manual" helpers, we default to PHY_POL_NORMAL, and support
normal and inverted polarities in the RX and TX directions.

Note that for NXP SJA1105, to get a functional data path with
non-inverted signals at the device pins, we have to apply TX polarity
inversion in the PCS, due to its integration with a custom PMA.

Since the SJA1105 was only recently made to describe the XPCS in the
device tree, we can require that this hardware quirk is described there,
and this avoids having custom handling for it in the driver.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- use phy_get_manual_rx_polarity() and phy_get_manual_tx_polarity(),
  which are simpler helpers that assume the default polarity is
  PHY_POL_NORMAL. There is a slight regression risk if some XPCS
  integrations rely on custom polarity set in the bootloader.
- drop custom handling for SJA1105.

 drivers/net/pcs/Kconfig        |  1 +
 drivers/net/pcs/pcs-xpcs-nxp.c | 11 --------
 drivers/net/pcs/pcs-xpcs.c     | 46 ++++++++++++++++++++++++++++------
 drivers/net/pcs/pcs-xpcs.h     |  1 -
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index e417fd66f660..c95e24c895df 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -8,6 +8,7 @@ menu "PCS device drivers"
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
+	select PHY_COMMON_PROPS
 	help
 	  This module provides a driver and helper functions for Synopsys
 	  DesignWare XPCS controllers.
diff --git a/drivers/net/pcs/pcs-xpcs-nxp.c b/drivers/net/pcs/pcs-xpcs-nxp.c
index e8efe94cf4ec..37708b28a7aa 100644
--- a/drivers/net/pcs/pcs-xpcs-nxp.c
+++ b/drivers/net/pcs/pcs-xpcs-nxp.c
@@ -64,17 +64,6 @@
 /* RX_CDR_CTLE register */
 #define SJA1110_RX_CDR_CTLE		0x8042
 
-/* In NXP SJA1105, the PCS is integrated with a PMA that has the TX lane
- * polarity inverted by default (PLUS is MINUS, MINUS is PLUS). To obtain
- * normal non-inverted behavior, the TX lane polarity must be inverted in the
- * PCS, via the DIGITAL_CONTROL_2 register.
- */
-int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs)
-{
-	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2,
-			  DW_VR_MII_DIG_CTRL2_TX_POL_INV);
-}
-
 static int nxp_sja1110_pma_config(struct dw_xpcs *xpcs,
 				  u16 txpll_fbdiv, u16 txpll_refdiv,
 				  u16 rxpll_fbdiv, u16 rxpll_refdiv,
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 910fd8b23d41..eeddd0b1f3da 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -11,6 +11,7 @@
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/phylink.h>
 #include <linux/property.h>
 
@@ -908,6 +909,42 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 			   BMCR_SPEED1000);
 }
 
+static int xpcs_pma_config(struct dw_xpcs *xpcs, const struct dw_xpcs_compat *compat)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&xpcs->mdiodev->dev);
+	u32 val = 0, mask;
+	unsigned int pol;
+	int ret;
+
+	mask = DW_VR_MII_DIG_CTRL2_TX_POL_INV | DW_VR_MII_DIG_CTRL2_RX_POL_INV;
+
+	ret = phy_get_manual_rx_polarity(fwnode, phy_modes(compat->interface),
+					 &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		val |= DW_VR_MII_DIG_CTRL2_RX_POL_INV;
+
+	ret = phy_get_manual_tx_polarity(fwnode, phy_modes(compat->interface),
+					 &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		val |= DW_VR_MII_DIG_CTRL2_TX_POL_INV;
+
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2, mask, val);
+	if (ret < 0)
+		return ret;
+
+	if (compat->pma_config) {
+		ret = compat->pma_config(xpcs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			  const unsigned long *advertising,
 			  unsigned int neg_mode)
@@ -959,13 +996,7 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		return -EINVAL;
 	}
 
-	if (compat->pma_config) {
-		ret = compat->pma_config(xpcs);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return xpcs_pma_config(xpcs, compat);
 }
 
 static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -1456,7 +1487,6 @@ static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_SGMII,
 		.supported = xpcs_sgmii_features,
 		.an_mode = DW_AN_C37_SGMII,
-		.pma_config = nxp_sja1105_sgmii_pma_config,
 	}, {
 	}
 };
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..56fd170a8736 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -121,7 +121,6 @@ int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set);
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
 int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val);
-int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_2500basex_pma_config(struct dw_xpcs *xpcs);
 int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.34.1


