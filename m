Return-Path: <netdev+bounces-252276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNRWHrYFcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521F65BFA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8619F6A4E1F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964393E8C40;
	Thu, 22 Jan 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZVk8Wmp"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7835C1B6;
	Thu, 22 Jan 2026 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079442; cv=fail; b=m9vENh+NRttlmAwIyQhdoZUo2PxZvdSV76QbZPZj9ey+AVVf1B+PGXVFQIdD9rGOHAoHBdXhy6245yd4wrjk9+0G+oTc+X4nOdIOV8nWY4U7pP90ynmLNE6bYacOLBLU4S2iKdh/fbjquo6qjPnpxJiLneMpNiHAq+Dj4z1QRqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079442; c=relaxed/simple;
	bh=4HbULPdAoXaDCx+oziFEt4uGPHKLUSJ3E3RTB1jOcRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EBeWDRAxZ/JIDAwXT1i8vs5FV6cTGXzx5M1LFnLxfTxFpBtKLwPoKdwNe0pkejyRuq+v6JkAyUoVe0F6wVkWl6dO/6WHJ/ltVWBd1AQ1nQWS3xvWLHvkqs8f6RM4aJe4CqUgrhqc/Rb3ve9JJ/SaLdo9fQ3U/5+L4lK2fI/pMzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WZVk8Wmp; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCZ1EkNyOhAooRACPKVRYdcuvWxWir9sntxIcwR2SUu5aKe25nfwnDdBA8yg4sgrT/BkjGGJ05eESKuOFDR9IIe03+1RIXWpQbgQoPDCFHuQ8rCXWqwY+8CkXkT2iL2TZPVEc2raXz/bZRSFFPclLP6ZfS8JUQlMqQDvHRnl2gBrH+Yi/KUIkE3yScRWA7EiWiuAhcaoL6z3AQEUP3NSzgcsugBET0Rq5iQODu4KXaPzC70tzY0qx54AnWfG5P9r77T+bCDGOk6981WL4nk7RQ82GPon9gmLevbyYNmjAQ+WUuu4G4f0sFwvmrpIQ53K/Rh2AsOGjcaMB3/FGvz2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO0Kr9IfDJqbWNr6D15nBIm+Wq20IbCt+mzYdyEOJWo=;
 b=MmnA7bEUBIaxH+thr7q1hCljZIMFFyQGfeSK231Dsd7vNoYqqbvFSVKodMf/rBzadp/eSOhRGR9To1qBcYhA7Hyg9PQ+VpjXdqoYyiDDXBIzTc8+Wzm3JVmxaXEnUYsHl0W+JG0ctHHANb5F9O3hlfh63EtDIuF8Egh+/pGg0Pls8VWG4QFjaGy+m8lQFx7yMirXwjMQX/gI3/tHH7GB14z2kEYN8G1agx2BG8LoYnW+BMj0l//V/FMTHmic76ybymrUC5nn0LP/DA9+vo/bXeLZm/pKv8OvdCkrjC0W2S/0uM1iRbSJFI/krvCc36ECSNqcP9wZ/7QIo3UsNAn/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO0Kr9IfDJqbWNr6D15nBIm+Wq20IbCt+mzYdyEOJWo=;
 b=WZVk8WmpgbehasyxvOVbs80315033A/3YkCOyvKxemTCYRxbiZqd+QtzXCfsnXagWe+NS+o43I+hCLfzi2t4ZksYD8qpztOmQvDVMb9DGJ6VdqUDJBjlDkGAHBCf/Hzf+umYgACNsN0Lu1hc6Y3UZkefzYv7Fd8rQe22mnUygUxf7jOTpKJoDHvjRfLHAhIj8AWnYWvMjgloHinBCcixf533QIZN0EeuVQ+9hIWhZwtgmQ8gauJMRUzcqPKenqNUWcxUBW6WqXHpdKki0YkRxIVSeRFASmVzeU+nO8kDHos1zZKcwa7u3h9gdL/pgaU+iAd6e/WiYh+/m+5Qkh0qkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:15 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:15 +0000
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
Subject: [PATCH v2 net-next 04/15] net: dsa: sja1105: prepare regmap for passing to child devices
Date: Thu, 22 Jan 2026 12:56:43 +0200
Message-Id: <20260122105654.105600-5-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f65148b-7a19-42bf-c46f-08de59a5008f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FL06giL9OAnnO4ldEKzRqyDzXEX/6HiyUkwrBLNqiBJEDvJ19yI+O6LnxIqn?=
 =?us-ascii?Q?1jmzEOawGGhP3w8f2kWx5LW+azUfwC50VwLH0dkNE/quVo/VV9roLZp2Iqfb?=
 =?us-ascii?Q?rXGBiK/uDXoYC0ypAUOfalMgEGNPB3tJQh6TCHpRisPCp5QbTmj81k8ILPVU?=
 =?us-ascii?Q?yKHcmB7hB1PPgekScBFgjj/61Wj5PIlwbNM18kDwOMJXgbe03fEMjPVt4yoA?=
 =?us-ascii?Q?VUPSz8aAHEhOOjh23yZR7OFTGoYyMyzpc4wxuaQ92nyzUz2Mcl45Q7fOeR4m?=
 =?us-ascii?Q?kT4kGYcBmxqYw5rArKvLdfR28L+8rq9+XizR2ck85vHqMva1eceynBFodfxv?=
 =?us-ascii?Q?XVLSv8Nqqssu/a2VeAiVewzaJ8+139GT5lVAuotcSOIpl9XgnnJsYjQ0oLAo?=
 =?us-ascii?Q?iM7HllGnEcr0Sg/qilcqzeGd/cjEngtPki8AhiTtp+EU/EfZ7HVFkevC2qhk?=
 =?us-ascii?Q?hcm/cyIZbhJrkT/H0Uz+AHC47VZTPAa8BOojPlM6Thf4U8sUbA6yt/Vprggd?=
 =?us-ascii?Q?X8G+o8RF8HBs5lQtdxDaGO1WKC6jfncS/VLq5MovSvCmWtoVu0JgdoJXcH2N?=
 =?us-ascii?Q?ZZnkC/F76IESkxRj0UFDtPosgWqNCUQIHoIAVNN3DX20b6hZ1erP8NstHnD0?=
 =?us-ascii?Q?fZuJ1jtyvKHoqUC3fVpuCtjINACF354S+0aYRmT+RkHKZTwIoDevDtNKUXRH?=
 =?us-ascii?Q?Ypj6psC83Qj2Iwd9Mm3DnS5XZiTDz/8euoBkqieC6SrqXuq/Rzwu1rrAcKSZ?=
 =?us-ascii?Q?En/3bXez00G/JagCyzmz6Uaj6wiW07eBmLr38SsSlwM8s0/sF2x7RhKCo5eV?=
 =?us-ascii?Q?EuWMP014YGSb1IOwg6/opf8QeN2+xt+TXfEgVygq6hqUFcLTXk/upYZaTAYB?=
 =?us-ascii?Q?+vkB0ELkHv1yAqKrWWsG6Tt2SSw8RpCi0y/0Mzi+uPAwM7kA34mUgMWd5WYW?=
 =?us-ascii?Q?usfaVR11Vls9b2otkmcCNobmW9InbhARmQNAcZiWZrB3zIIj30SJK7HZrB+K?=
 =?us-ascii?Q?vDwxd3MjlmsElSfuvpTGrarJr3FYlnhI0nPiIsj/2EAMNOmTsGKFqsEIFLCK?=
 =?us-ascii?Q?DbDrlHDuRhPsXPYFPxrgyTnh5kl3OdrfNhKd5Sx0nCGIvAEbUbg6+l1SHDMu?=
 =?us-ascii?Q?QkGDCIJUgFfGA4D+JTFW9fjVa1O7BdetVIm7aoNLZGCPyzrkmpFOsjvtx1RA?=
 =?us-ascii?Q?qRZV+HBWqRlsbj2QQrTe6Z4JI4287o4WFdwy0WS1S6VD5gq9BBXTKZLUA7Oh?=
 =?us-ascii?Q?5MMUxavWdP9HN3W0GMvHIGNNX5ApNq5ZiHvo9txpb1NVvVKb7ElpOe2GwyU0?=
 =?us-ascii?Q?rqUaGYLCM7sGmKnfG8ZQmSta/fFHcZkQxwMjSMKkRNlwkYhwq8NIp4TeZD9V?=
 =?us-ascii?Q?i6Kyc12N/kuBFLueD4DMNa7/Mm/e+ambS/zVVENvyhb2DWFVdHS0VLkK45Ih?=
 =?us-ascii?Q?JvZp6H1+C/4IRFg0NnGwIY4LM+aeX9FafCPgCh6XoVpfv/byIjz0HyGMbj6k?=
 =?us-ascii?Q?RNNoYjhiKgTGLL+pa7QsgR1FzTvxnPoYV7Yv5J7sBXOEagjaos/3pl3bCFTJ?=
 =?us-ascii?Q?EjzbWWgkrmea2Lb2OY/bilKvvGRAEWJySun/fPMeYsVSwOF94eWzHm2dWPao?=
 =?us-ascii?Q?p/b1pB9Wm1V4OPgGLS/S/b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXO2b3fesvO1D03GJzVXrgPY3LGkD5MsdAaS7ifLbncnuGfTGN94WcKUAxx+?=
 =?us-ascii?Q?pxjgR9mddYIDUVQjwBhB3dLMJ3OesDFT7vVVh9alfgaZPBCZHB++Kz12ovRu?=
 =?us-ascii?Q?meoXDDKCxMI3DzfQ3pME+23Q/rpD3GmXYILqW5vhDiiUNJ2U4uxX4f+aBYRQ?=
 =?us-ascii?Q?pksZLIby5eBB7Ec/GNT36NYAVCGtWFBhh5hVpzaMvb72qOqpys1B0Hc00J3d?=
 =?us-ascii?Q?848/Bwn0scrSis2Vvn/Gg97Fn6gBaET4qgcOJ9Dzr1tgBusaAWNvkEuLfGNc?=
 =?us-ascii?Q?b/QJKyX0cty6AUIhsLMA+ps3ZaD4e7ysiyppOQXBCnoYwoqQrf2jP4zDpb9Y?=
 =?us-ascii?Q?zlqh/IJeXhR/SXxOKjdtXDqWq+iFK87wJ66TKDFkUmPBf6LV9Nzb45R27Njh?=
 =?us-ascii?Q?z15mjOpJZw37M0rwJV1yWer0MOhVjf/jhx7dJfPUd1N+Hso+ZUz8EBdxppfe?=
 =?us-ascii?Q?pxBkib0/EGryAwDfTcyRPt0Inodma48gA6XjDpmVxm14QNsKMzOXpQ90SMq7?=
 =?us-ascii?Q?ZJoRTx+X2PEAkGqab+r46FoeoyrwxbnCEpmCdGpOhi1iZHukCst6kgAZq0w9?=
 =?us-ascii?Q?f6S+64dM9HubO067feo7Ih7QvtvJH0Mrdtv1wH2MipkTrT6rHS5tpLOLxRSn?=
 =?us-ascii?Q?pge73WFmoFdmJqBC8R0EU0H/vVpC45Bex7VoiDoOqR+elACLMRytB7oNQnCn?=
 =?us-ascii?Q?BWIKZAT/1ZgOUHPKnebqChNqGzvHeHGbTQBu6v6taHUu0wjv21QzO2qBlzaa?=
 =?us-ascii?Q?ScBE2/0oSCrpJ30XKXgmLYjyjq7a+WioSSh7/vp4WWxDFi5pCJjoqLrZFwnB?=
 =?us-ascii?Q?uM01kgeyhRbXrcEOrY2OtYh81fV0KnatOkBxcXxgdyXdS8fVCH/J4gZ4lvFC?=
 =?us-ascii?Q?pJe+5GGb5cZ6v0FZ8BShgForFB1pQcm97VYkd6xZkCJoF9jeWfv9oo+KB4Qo?=
 =?us-ascii?Q?ZvpJos4OHqlH8zaWEdTOdsvU45dxvswZNWfugZfq6SSvkqBWFaX5SLQuwuFe?=
 =?us-ascii?Q?wTe06e4F1u+QuVhMuPHBB6PyvjEpSR/KfSsBh2ol7BNWkI5woa0RX9SEn526?=
 =?us-ascii?Q?vTk2ONnZuYJbNyBdJj4iGW+ZaRixAfuPOU0zMDI5AN81VFq8iBThb2e2I/w/?=
 =?us-ascii?Q?kh69EFFRxeXpRaA9NZS/NxgH9PeSm3XY4JJZ91xiLi96uh4L0e4sxuSXOQY8?=
 =?us-ascii?Q?LvZAS1sIWTXwdGp991tGlsIPzooU91HjL7RKFFnX705NtuX3sFURQ+Swwe+Y?=
 =?us-ascii?Q?Ymj0/rvpQb4I8rXAIdqoj39MSAPlFXifH9WX+WxB7/3/ePLTKQomOBNe7rGv?=
 =?us-ascii?Q?01wpLVK7rL60MrzxnkcCcwF+NovZZ3URjtXD/vwMzeViJ+jgiAXpFE75gRfa?=
 =?us-ascii?Q?3Ac7NXhrn7voDSUytkb3Xv/ET/x/sz4Uv9xz6jZkAfzQo5S0ZvSJNqUwuH+y?=
 =?us-ascii?Q?4G2iuGV0qRZ6g6WDPi27vB1fAQlhoGHd3X3oZ/EJpH0jNVij19eOR2YJXZVk?=
 =?us-ascii?Q?vfgt1t19alN12m+NOyW0nNyihqDP21tArqiM9oj4LVkb6Pul+aFDXisZXSW8?=
 =?us-ascii?Q?sfTEY2cz1W9PWmnxXVzJquZrhonal1rZ2HstqiQ8gISBG35J5fvLrw8O7rLR?=
 =?us-ascii?Q?GIdb/WjWksDwpxJK1pVM5XYdBORIRQwSEwRRupn3S7pMSYKIOA4gu9u03w55?=
 =?us-ascii?Q?Y5x6GmweGM/UXlg0xD6pCknP0BmWeQLuWosD+VpkPcIkUgkq/4cFmdtMw88c?=
 =?us-ascii?Q?zpJM/GjxOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f65148b-7a19-42bf-c46f-08de59a5008f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:15.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MERWpXihjZex0znEvc5OWclF/n6O3K+IB0QXgN4nF2d4ztKuSNV84L2GECAJCSMNMpGy6UN8i2ruXu6fKRyqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
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
	TAGGED_FROM(0.00)[bounces-252276-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4521F65BFA
X-Rspamd-Action: no action

Prepare a single regmap covering the entire SPI address space of the
SJA1105 and SJA1110 switches which can be given to MDIO buses, XPCS,
irqchip drivers etc.

This regmap is address-zero-based (can access the entire switch address
space) and child devices are supposed to access their respective memory
region with the help of struct resource (IORESOURCE_REG, to be precise).

Nothing is currently done with the regmap, it is just allocated and
added to the device's devres list, so it doesn't need to be freed.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- s/sja1105_create_regmap()/devm_sja1105_create_regmap()/ for clarity in
  sja1105_probe() that teardown is not needed.
- drop unnecessary priv->regmap

 drivers/net/dsa/sja1105/sja1105.h      |  3 ++
 drivers/net/dsa/sja1105/sja1105_main.c |  6 +++
 drivers/net/dsa/sja1105/sja1105_spi.c  | 55 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index dceb96ae9c83..8d4c0c8df326 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -11,6 +11,8 @@
 #include <linux/dsa/8021q.h>
 #include <net/dsa.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
+
 #include "sja1105_static_config.h"
 
 #define SJA1105ET_FDB_BIN_SIZE		4
@@ -338,6 +340,7 @@ int static_config_buf_prepare_for_upload(struct sja1105_private *priv,
 int sja1105_static_config_upload(struct sja1105_private *priv);
 int sja1105_inhibit_tx(const struct sja1105_private *priv,
 		       unsigned long port_bitmap, bool tx_inhibited);
+int devm_sja1105_create_regmap(struct sja1105_private *priv);
 
 extern const struct sja1105_info sja1105e_info;
 extern const struct sja1105_info sja1105t_info;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 2a4a0fe20dae..e9e091cf8998 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3291,6 +3291,12 @@ static int sja1105_probe(struct spi_device *spi)
 
 	priv->info = of_device_get_match_data(dev);
 
+	rc = devm_sja1105_create_regmap(priv);
+	if (rc < 0) {
+		dev_err(dev, "Failed to create regmap: %pe\n", ERR_PTR(rc));
+		return rc;
+	}
+
 	/* Detect hardware device */
 	rc = sja1105_check_device_id(priv);
 	if (rc < 0) {
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 834b5c1b4db0..856a751de53a 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -408,6 +408,61 @@ int sja1105_static_config_upload(struct sja1105_private *priv)
 	return rc;
 }
 
+static int sja1105_regmap_bus_reg_read(void *ctx, unsigned int reg,
+				       unsigned int *val)
+{
+	struct sja1105_private *priv = ctx;
+	u32 tmp;
+	int rc;
+
+	rc = sja1105_xfer_u32(priv, SPI_READ, SJA1110_SPI_ADDR(reg), &tmp,
+			      NULL);
+	if (rc)
+		return rc;
+
+	*val = tmp;
+
+	return 0;
+}
+
+static int sja1105_regmap_bus_reg_write(void *ctx, unsigned int reg,
+					unsigned int val)
+{
+	struct sja1105_private *priv = ctx;
+	u32 tmp = val;
+
+	return sja1105_xfer_u32(priv, SPI_WRITE, SJA1110_SPI_ADDR(reg), &tmp,
+				NULL);
+}
+
+/* The primary purpose of this is to pass it to child devices,
+ * not to abstract SPI access for the main driver.
+ */
+int devm_sja1105_create_regmap(struct sja1105_private *priv)
+{
+	static const struct regmap_bus sja1105_regmap_bus = {
+		.reg_read = sja1105_regmap_bus_reg_read,
+		.reg_write = sja1105_regmap_bus_reg_write,
+		.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+		.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	};
+	static const struct regmap_config regmap_config = {
+		.name = "regs",
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+	};
+	struct device *dev = &priv->spidev->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(dev, &sja1105_regmap_bus, priv,
+				  &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return 0;
+}
+
 static const struct sja1105_regs sja1105et_regs = {
 	.device_id = 0x0,
 	.prod_id = 0x100BC3,
-- 
2.34.1


