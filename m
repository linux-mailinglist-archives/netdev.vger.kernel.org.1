Return-Path: <netdev+bounces-252278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBMMEW0GcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B165CC3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C69F887DDC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF96423144;
	Thu, 22 Jan 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgnRUnNT"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9336D4EC;
	Thu, 22 Jan 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079447; cv=fail; b=dmnS0nN0mHtPxvPOQHrfYIFg98bBeZdXuEeER8HJzxS/JlwHpPYaHOZ0Z3SPTF1d9cX8YwsiuOVhvJU6YtAjlUqXluL8rWigCaYZk3idFueKb7xox+lqRg2mQlkY/JUZJSYzZ9AYAIsUMq7pAN/o3kJPX7yJmwiSSAsoxLOqCnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079447; c=relaxed/simple;
	bh=CTlCCU4FTC3KZ00bRaGFl+BL7W8X2taTQCgTpM+QjRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEFGA6hTuMt4ZSsEpYf6aQgtYJY36KEaqKgoz0cmSSddwP0NfTNbnTpGyJ+7zRdhFIAUxWQUgq38XDbvJ5XmYGWh3xfVMKZGn1Nn1UvlmmiLE0KhlQ7mViNjE8miABvMwvqISGjRPDqzRErvZw5vI8EGKkb/kaUYuo07Owf4A0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UgnRUnNT; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkJI9uVjnKqL59aBEHWH3rPo2Se16rJL1G9cAWGG4xM1Gz6I/1Ef6GsVN5QPpW52UnUjOlaijw9cIZKINywhTKIBWUeq4ZX39glSed35Y9yRJG9RpyHy3aXjLINg7QtZVCVkOud4lnoXz6iPrbsb5HPpAW4PHuI7crrNDuS83FrVROoUirWo25DXJiylyTlz4izf6DN7e5hhUn7N8KD9XDTcbwPETzlWFDFzefPiRuAIZs7WVXxCeQNBZeJBkJ6tIotI5lnDdTQyDILzLQG/inIR9pA+oP+RZzPzLLZGI86GIQqsj73tXaT5iraAgwdW9AR/ToROP8TzkFj36Fq10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyIB5mnFxnirBUEnA8i+RF2yy40qz/+SOGUI7GlnKBw=;
 b=x6aYbqE7/4qMFtlwNjO3GxZpkWIEWS47doxrAYwteVvMaH20z7jOtECf+qLY5fEUkb9J0nMuNbuIQm9UUCi2L8qTao+9Hifpaj76niKG/59emRmIqIpLipDHAbxon6LxomLWNI5Rbxbt7n00kqBz0/m/DWPAW/8dxCSL0Iz16lUkyqe5O0h0o14PE2nK3FkeZhydLQxmyhj4ihkPhNBKQqq6cI75mcp3B696+YDg4WVEO3aJyNQ20UTaBBDFwpI0cCxYzHmZ+nsEZJ/0bHVr5mPSQYOxcVxT7AxcoED6t3Yz5PBKH2JprbwkvnlXxnoYUU1oD3jy63qr8iv7apdHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyIB5mnFxnirBUEnA8i+RF2yy40qz/+SOGUI7GlnKBw=;
 b=UgnRUnNThc1VFa5BPbX4hB+++x51JG2zCTcOvVueAAePGVxzfC6AAfpWBZsz4GdqaPFuHQBX/lvyeyddPgU+SEGCWmYoQFMgrvi9Pikcd6YPL/fnOMLhPYixAz1abP3m+BUM7zktGuPQ411C+ka4MsC9JsAeUh3f3k3mIRig5BrjOkLFl8MScPrbaS3JclnYyblv+umKVd/wRvwSzsR0YvDbTlZDOr6Dvd9n7cdNut6/kJLmcYQci9maZouiZi9FZuZbZpUQllBnjvyns6l/xXh6D9e9GJwJcFGV/jnrOFdg1C3K67hKu2FE3LYHo5rO4U9sUGWSvoukljEy3rSFnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:17 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:17 +0000
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
Subject: [PATCH v2 net-next 05/15] net: dsa: sja1105: include spi.h from sja1105.h
Date: Thu, 22 Jan 2026 12:56:44 +0200
Message-Id: <20260122105654.105600-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e720d159-c2c2-4a6d-f210-08de59a501a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1sdiQZbsl7rDWcg+6JX1KFcmrunpyfubEf06MYrRvDUnbP35M/M1g+BFGH42?=
 =?us-ascii?Q?/Ntq69PuWAkmSu0iWx4VatDGTuHdd/M3eyp0/kECpNQzgWK/iEdfWgzXMJxf?=
 =?us-ascii?Q?y9tBoYa07yXeNYkpJSDlCORTHdhrpDr0FZ9rhdeCdh4GbZUxlNHX6jwfya4y?=
 =?us-ascii?Q?WQVGcByxfEerLHKlwIJMfAmGbIF7HG/ElQkgNdPB9+16zZs+sAmsdc0cKTLz?=
 =?us-ascii?Q?R5XrG4hKwsCWwzFY9BwDqUGSizfD3xZjyrUYkL2hboc+hTIK/nBFM69/CFcg?=
 =?us-ascii?Q?9cSf5vEVsaKX26VLpBLwtcOnGnz28NElf3Kju25HyBww2mWXds5VjJv58xb+?=
 =?us-ascii?Q?0TQ2/Q3SsiQRdUTcKrQ9+Q6cvG4S3UWg1znoZFRgNA4kHFQybOOWWwxyG9z/?=
 =?us-ascii?Q?4+v5nEyTNVtnez+Ao0QSyJF7Esd3+rjjEOaa8W3PBZ/XG275v4DLKKzjVz3q?=
 =?us-ascii?Q?xSdPDKcHAeUi1h0v5Y9aq7b/Q7DATv+/oKCxeJANc8Lg5tIfq+vEgZ0ml+6O?=
 =?us-ascii?Q?rrVqk2nej4KxmaL6QoiI4VhQVoS2o9tOjgm7PBYCBAphAuCAQ1VAzB5xaX69?=
 =?us-ascii?Q?wLHBTdHFApc4HV27SaWM1W2KqibbAnXx1YsNrv63LWNHl8AcnbGXaaIBMd0Q?=
 =?us-ascii?Q?6cwL9JwV/DLDJu960p+PZoZVHY7Z0vtu9cT2krs1e7rTYv4pHDPlOO3MZem5?=
 =?us-ascii?Q?AqIFoPD1BlbwOuAFWyw1uXM/TolDEqqcqJoJ/rfdq4vepehHf4OFe7+8T36q?=
 =?us-ascii?Q?s21MAfpNQGfK+zYLCuxGKTmmM/eHztRYjVW3IB0ClRwW8xuPbAA6mn8C8PSz?=
 =?us-ascii?Q?IaxcTMFdybeq+4T2eyVQw0o0OZNgYNfo/j3sz/kjoPtXsszh7xdSoZN0e+Ad?=
 =?us-ascii?Q?Rx8ELlNdz6C3Uctu4Ht3Dh2OgVhEGh3swjWV9m95zM1gud1LMhnbR/kGhrAf?=
 =?us-ascii?Q?pjizbkUBHJu6Lm+CNYrv+LhIqQIoF0/CjD+UOjnPJa1WIKATGrYSxT81mHTj?=
 =?us-ascii?Q?HpaCzM9bxPBKM2/1i3vk0e5VGy/W6veoKzjUPcQEgU9X9Y/wvW5exSLgXfxq?=
 =?us-ascii?Q?wv5nF+fArxrq38AJ5/UJQtCVXmjRIlmIgf/bceafBUvLKRweJcyP2DIfYUtd?=
 =?us-ascii?Q?C9REndFQQI1oR2vefT8+pU4ztl/nLnQ8GUsSWjOiNAdpVftOvEYPuqkoTFxa?=
 =?us-ascii?Q?KVM7SA0eTm+4oDUdnLLwGdEfT5uMIeGSGS2UU/RH8ppN+2/CjgytzNZ2mnrx?=
 =?us-ascii?Q?qf/jSHda6WH1snXkC56q1LJR6ffgyKhptPGqhyPlBxIxy9gHrGMP7UhubPKf?=
 =?us-ascii?Q?BaSDIr31ETZeQXi/iqHO5fdtLkU8hpc0RjlRqnnvnUqFetG4LY+rJUFrgaGO?=
 =?us-ascii?Q?h/eq97L7tV+E/xBUBKBBgzTVn3bGeGOIdHYAzmCouhJ8RP5x8jb6hoiEHev+?=
 =?us-ascii?Q?Bcdkn1cFZUibfx0EKayV1p5Z3r1MEjlRLyhFLdU7F/d8pfad7k8gf51Ualif?=
 =?us-ascii?Q?+nCTK+7JzQyf9/G87DRRydyd/poopz/hRlRqCykfZCQYGia8019veiBxYSYz?=
 =?us-ascii?Q?k2B4crkE9zxW852qtN2Hv9ZF+VUbxNELZUETcCArh7w/JmRQOZkmmQ7sp8+L?=
 =?us-ascii?Q?fXDgNvijzsfMaQOEXM1Nqfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQhNyprzgMdMggSbUvXfiQN0Qeqku8Dd8H5feYd2tMEHNgsLYvB/eOP89Ao1?=
 =?us-ascii?Q?RQl11Jr8yrI+VErCwKV3b2C4cBM7Jsox6qBtdjf9fhUtEFEFDvE1FvEQ//9U?=
 =?us-ascii?Q?+a/Ql3SfUZ2lg7IbBHo3gPeTU3+iwp7/cpWUTThh5LMpW6yYv+vm8XdANXfo?=
 =?us-ascii?Q?SdPno4btzmZAgzRgwxlR4KSlLbPueNRVDl469BOH2b99ZArDmkQrXfTQElgd?=
 =?us-ascii?Q?47K28543KM3IRGoreQy6WCkSESWPaIqT+Ds0UyXLUDE6aXiSV53nLBgYf5c3?=
 =?us-ascii?Q?mY1eO2Jz0vzSkKFydIeNjwS/dflcUpHYX5Cj0QWDn9SpW7g7IGJS/RwqO7HY?=
 =?us-ascii?Q?0LP1y2l/TXBaLKaLhdBkLRHlLK5ifYjAseqbUoVy6WPLN6xZYoE+4wLV5awU?=
 =?us-ascii?Q?qeuzzJCHdT9oKioo8l7cSXof3pxMMBpZtnPFVO4YLm+R4e8QAVkECWQ1K/QE?=
 =?us-ascii?Q?TosZ98kcDdsgTa4dB7zYkCxdn4LtXEKtNJglv76/MoHokym6CVdt0vA2HFYB?=
 =?us-ascii?Q?2wGrEVWliV7Kn2tAdPQUQ2/6t5SHAgn6olwRCGPZUbueL+3ZxNjIi+IdfEc3?=
 =?us-ascii?Q?tLmPyEEFg33uZnZ9DDInNcR2bDvSb5e4SNGLdDhCgVhU021gg8Surfjunoml?=
 =?us-ascii?Q?PQ2Lj6g9zZRP47UniWjS9dscigX864UeHLDIWZWy6SdjMYus1jqMqwZpfdV5?=
 =?us-ascii?Q?5JfLiWdymLDSCua0eqi1j4TuQmQtBt1ul0oafHqC0tmimXFXewfl4jKhQijs?=
 =?us-ascii?Q?GxjVPMezzP5Fnz/sXCS4DSH6pxQFJYpxFg98+pU9xeJRVoRCI6MD0eLOVk+h?=
 =?us-ascii?Q?aVG5EwgHmFN7ie1TOUuJMghNpORpmCpcO7VW1epjVtJ49GMXjo0Ig4vKd10T?=
 =?us-ascii?Q?zHhgYnsmwoEag43ADXYI+scVZtEYNgCh8j8XIJmPN/Q/GHwZnORmkLMIv0Vx?=
 =?us-ascii?Q?Fb+OKdReRig1sR20343/e7e5/KNWWMQIco2C2nAnQF2HuDDm2RdqLQGXPhV3?=
 =?us-ascii?Q?kyP4mESuQh3A+wjr0mTaqRGB702V6jftLLegGvtCOlRC1+Y3qKR6Q+WxUVRJ?=
 =?us-ascii?Q?QCpxBqaeNyrDr3F29r5m6AoIosRgKSIFfFrWvUrWRxTX6HeIphDAa1bMfRW0?=
 =?us-ascii?Q?Ok6MpSsMprxXdIM+Hofk4YlfmRR3OtWa0TeddwxmTwSjv2cmJL5Ww43tB6UI?=
 =?us-ascii?Q?vHFHxxtQFPDIdxw+V/KspkWTGhzcpEVsPIKG0v9gDq6JcLiJHqT9EMCg3Rfd?=
 =?us-ascii?Q?fJrfu4tVxvKvSZwGr+KcU8DJ7xBjJe03kHdz1H07i0buCyY8zACvQkoYbpd2?=
 =?us-ascii?Q?3DdwmdZ9gCUEKPUgUKxoCtYtQYeGnvnTNATGi+K1D+tiEcZdgYOuoTiqVXRj?=
 =?us-ascii?Q?uwkBzIlN6QWGslwy7I4pPAOz+mQ0Zx8KInkrBkmSQRlW99mEx2NhQ0OZwuMI?=
 =?us-ascii?Q?r7AABd/OBRuP18X/u2GRts84VEJ1YxWe2+nZkS/v2TQpiHD6FO+fWwi0UxFq?=
 =?us-ascii?Q?CvoJNyUevFs6FCTBx8yTFx5fATN1MuB0j5yr9dAaSr0h+sr7LyhcQCjYnfv2?=
 =?us-ascii?Q?pizKQt2MSqYrdpubMBJC4eQ3bsuy1Uif23QPNf+W6sw14f0DZaIH4pDQWjj0?=
 =?us-ascii?Q?6G4x2e4KCaY/jtedZvARWOCRS/1DA/K0XowOVmC1e+PWUcQqkRoMO/QXLe0e?=
 =?us-ascii?Q?85Lqcrq+IapUWIJA9umnB9UZI3TtHnVBH+9Rg8XspyiItbOxuH5XfgY66CBB?=
 =?us-ascii?Q?lXZ9FgkFJA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e720d159-c2c2-4a6d-f210-08de59a501a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:16.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5MMIzvMGb//iBJ2cWQxJHah9EHN6sRvv8FsU6z48xI3L8jRZJbnoK1hEB/OnDKhnKKMyEKJFj49WmtJG4lfYA==
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
	TAGGED_FROM(0.00)[bounces-252278-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: CB2B165CC3
X-Rspamd-Action: no action

We have a reference to struct spi_device, but users of sja1105.h cannot
dereference it if they need to. One such example will come in the next
change, where sja1105_mdio.c does not include <linux/spi.h>, so it
cannot dereference priv->spidev->dev.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/net/dsa/sja1105/sja1105.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 8d4c0c8df326..30903fb62302 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -9,6 +9,7 @@
 #include <linux/timecounter.h>
 #include <linux/dsa/sja1105.h>
 #include <linux/dsa/8021q.h>
+#include <linux/spi/spi.h>
 #include <net/dsa.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
-- 
2.34.1


