Return-Path: <netdev+bounces-252279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBeMLnYGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5A65CCA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03B9F6CA3F9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3389427A05;
	Thu, 22 Jan 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIVumasu"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD538BDA6;
	Thu, 22 Jan 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079448; cv=fail; b=cfc3UavuHUg/fIkgHBecDq/22KyuwiJKnJuEtmqFnkS8GFMmmNhDsKdY1VItKpp8F0d2LLNlSZbQM3FQvcTsW1gJwjtgHqCNf2Jy7P5hvagsYU0OAyMfLc3Dba4ltB0n4iCZVvoNW3faj7BtTTPV2A4UCdJwQMvaeBYYYJG6hmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079448; c=relaxed/simple;
	bh=jowJ1GTPfTmG1cFyy2kZBm3volHYkJsac79vCipW1AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uB6i8AeLs13iV3Y/7huLzSvFdhyiHPKkxwe/oueyL22xxCUqc04zPDgdSvlycFDUBdcP7CW8PJsF/sy9Sr4rME1f6awdFJfSH0eJ3fijKc8IhmI7JV8w3j+4+6DOPgXpCGkw8uGg0WPOaSzsK0Dzm0ozkOwReP2XthNl+16axrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIVumasu; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTajUOx6Q05eAPndiDbXXVILjBgIlfCuEX9H9IKwOZVeF1LMpkNzlT3XL0KruWwoPgcK5yMxbUMBqm3fSbYjCUqW6FK9JtM18Ae39J14e3vXd4mjmn4+eAoKKQMopeWywmMJomPPZgbR56qqsz4l+i0an+g0KQJ7Ay/5GBwBiKR8wXryR9omnv94SiuuGeywMRehibf5fCPJYLUL29YgXJeJEBitkxlSz8h6YFaMiriDKIdiDQ8FYFrFIatqLSNwVqIhcC1QN2fXiY4RS9QNgA1Yb74/TjalzeJBDRFtnGJeMhffbIeDKpyhavrNhbB98V4hh+QnWLchp/zr114zXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTF6LPVCcFrsbGQmB0LugX7yi0iqnxmlyffLUfBa+wA=;
 b=cuacwcZLpFIg1+vyjl8Sf9xtrHRc1YEv8Fo/q5viyTC4OZf5tkavDaIr5sdwhrqPtNmgYPl4CqEXZt0B8xXaXOVv0iPbNpuYrr4itxBDEu5Eb+VyS/stRgjIJxn0uWjCR/TdYGbWCgeyKZQK9GyJqSIo5BMmVLuxdXRWI9hMrhkshi6TlKV7+ofYPoZsCIkdOf+NaXnCTCHzQ+gnVFnY/vdVVRreRGTOy1CHM0OdyBbeWFKxajy/ceI7569KjSyPlESbn7YcvqObqeY6kWtht9zlshKu7/rS3RZJo1CqjL4o3Ye+BYLiDQhj+iQY5smnnmamtzTynieAu+k1xTsuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTF6LPVCcFrsbGQmB0LugX7yi0iqnxmlyffLUfBa+wA=;
 b=MIVumasuUlVYGcpHYiQNnRmDQn6XRGTkhBOx/TyzDpr5fCDXt9hlPjshFlxHwAWpxKAAwUgdX+qZpjGwJmc/xIlJ/sSwdXSAuNtDPKvoUSDz58gydF/i6vEbx2xDt6iB9YZf+ZROzYIbaa3kGxyCLVLz2Zq1AiLG22QluUNxtOfVCAdllKA2F5YBpRsY5GogOA22TJsN9YTg2/KBfJ5OrdMOE6NsWsPZbEm3Kq3N4Sod2v4PuFontX6AKVUJUMaOKFQ3ILuUmu0yZyJApj+2UjcSTz8gEZ/nyr4qn0373Xl821sqLbIvWCnMXPQ0/QkrRkffuz0RpDpM0dMBCVaAvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:20 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:20 +0000
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
Subject: [PATCH v2 net-next 07/15] net: pcs: xpcs: introduce xpcs_create_pcs_fwnode()
Date: Thu, 22 Jan 2026 12:56:46 +0200
Message-Id: <20260122105654.105600-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c051c482-2831-4a42-3c88-08de59a5039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSEw1RIbsslAlnVwmZGQNsPQNKZhn2oatSAlaH0Evo/kfAjBgL4ENu5Sk3zH?=
 =?us-ascii?Q?WzftSVIxIZjXuFLJIK88wyGYGcJ4+eL0P0yr3BMYJl1HWm3U4fJuYHmORYLU?=
 =?us-ascii?Q?tn84EKrPeYQVF3aRF/FU6TtMCE4kHQbiOTqwcmrUtF9BcFMCboNuPdCrn+7C?=
 =?us-ascii?Q?91sS6BqlF74cU7Oma82D8LpSQ2fLvC3aUjjZh6LU59GPoR0Jm7yjBVCg+rZR?=
 =?us-ascii?Q?TBLCxqEjX+1/2e7V51uYJ/JqV8SaSra9qTUPfwR7JK/HJIXQ1o1eExvF3rIK?=
 =?us-ascii?Q?GlqdnltUdYAenzb42q0kCd//O08dEJ4okryw43wIrTNDhK6VjsmlTXlItI9u?=
 =?us-ascii?Q?dUeH+HjmfRVdrbeWpoLHSEObmA2q7uO9ffe2Icb8YPiO0PHogjsNnzTtkCQJ?=
 =?us-ascii?Q?nYU4t/1gwFDSaEEjttjGWQ7b5egX9oYT70MD0Vpd3s2cF0T3T7oMrzTRWq1q?=
 =?us-ascii?Q?akCBsnDAXfc/NjXLz3+mETFbt7N6j2OisvUDQv21/LgCBNIWnE8hZnHj45TE?=
 =?us-ascii?Q?lJvBK1y/P5+eyERIj7YWc+py1ZRmYxz8nFx6tQ6Wh6fNmDx8lzXLUBG13v/C?=
 =?us-ascii?Q?uCvtdDmEo8QbY8aLthex7X1+dA/MVoHb2w2NkbjIsWk7OJaccZrEddkzcmC8?=
 =?us-ascii?Q?rfgX+AXnl/c3SSc6tBs7FexztnswgEfoKbUYMpQM/fhJ/rSL288uHEx/Sk9Z?=
 =?us-ascii?Q?IUnqNwFEQmMXNplHH701L3qDt5zfUW0YO6DQ4H0szu0c00f//0x2EMuXrKXV?=
 =?us-ascii?Q?hcwRA/NEOU3+ZFEpozsz+g0KMdXF7qMuGP6Vj83ADllZwf3/CioGgUmTAGJN?=
 =?us-ascii?Q?MDoAkoj87VOWujcYC0y2QVRwrkTn6bc0hJnziAQXozjljvS2wyCYiY6vmNUI?=
 =?us-ascii?Q?aYno+ujTUp0GUV8QY7jfQd7NC8s/cHla9WHfG+4IRl4h3NhiO9ym6A07Lq7+?=
 =?us-ascii?Q?bX+hYpOQPoNMzF2IWzuvLmhLinmmcQnQOiFWGTdtzkETdnHGGL1rgNpApQBX?=
 =?us-ascii?Q?CeQvRQLtxUeL/IfuNn1Sh6W220o9hEiUNeVmlxt7+sBA2hYqoDniEJ1kOt80?=
 =?us-ascii?Q?/X4hJ3lN9VJQIGzc4Nk1bwJTQ46G0CSobXqBcamcUHHjmp03WmEzWo1cOn6w?=
 =?us-ascii?Q?OlUzsVZyYSlLrmfjBHuyfT7XloICLiSrn8V7yuCZPrZVmcQd1r4NSq+IPfgq?=
 =?us-ascii?Q?6SvGAr6BOpgtXwF7n5kNocMAjK20sm7+6CJH9RlPelX/QHO91x0DvseeGczf?=
 =?us-ascii?Q?lUHf8Nck9DMRlUTzC5yhbc4RFLVDqLY+gKoy27bgMjyRADgRe21eJtwdlhMw?=
 =?us-ascii?Q?WuP/8u+cbHP3gics9W29cEZllO8SyXJGaX3rlyoUNBrQ3O6wTeQQZ+6TAm9/?=
 =?us-ascii?Q?3psDwbmCT1wCXm97uLcWA1dfQ5LsO7YUQtF458JZ5qqe2MnGtjBBMQAQtbiV?=
 =?us-ascii?Q?g0tKEvg65xukrQESV6hmrfOTraQTiIWi+Av9e4m0LM/HsMaEoRkUnzFQazwj?=
 =?us-ascii?Q?QOrO1oj+tkhfqtzST6uvNNrr3fM4cYeHrJGq0OFcbu61gvp9/yFl3yTJ3Nff?=
 =?us-ascii?Q?c6tH9d0WDj3IA11/X2ep4uzCOT8IK78c357vxZKjGvvfhBGhGWXLE+QZpY1x?=
 =?us-ascii?Q?EyrwxCyqkIOyhT6jheDhDTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/HVFls3/ZtLqSAMqcbLEIUvMQ2gl1Cf5QT+mvl2rGJEeLX8B9G64bSW8Oo/J?=
 =?us-ascii?Q?b9QfuOPzIhQ61QNY9V5U9KENl9VuX5BnuNGNmTkM4T9MxT53bGDHDfCcO8rd?=
 =?us-ascii?Q?VMjZOcvlh7WbZQvu8PD/RmOGsHCHG3ZNUJho+wa7tf1yuSeanVmyF4X5Klvs?=
 =?us-ascii?Q?Jnyo62rykyuOcI7v/nu/KOcHpgoi77hs7cWYZ7zcAZ9a2K3KekMq0DP4/s0E?=
 =?us-ascii?Q?O6ahXcomcW5EAGBhi/wP33fAN/TS1tpj7JlXJeZM/5nejrdPUlSfsawOn6o9?=
 =?us-ascii?Q?emVJYTlVwe2naHfyyx/OUHl9DqRcrmquQ2/Q+++bKxK8p8s3PgCrXPv5KzuU?=
 =?us-ascii?Q?rXV68+CDxLEz2QFVdCotjTgbYi1GdWFWwDjxA3b+UvPfXyJ4xq1esMzyOxkV?=
 =?us-ascii?Q?QmKivn8fsaWos2ndxN7mQI9MXvGEQevNcuada2V9vvYvJmEb9CvZg16XLA2I?=
 =?us-ascii?Q?idML3dlI3uQriTOJCQpWCwVtkbbCuWKIlYc4ulOBH+4wSXBLxJTY+AgZKyKC?=
 =?us-ascii?Q?yh5ah+mzDKYBVPXXTvTDVQ48WPcJ8yKkJ7Q8J4rd99CiGloff1aMh82n0zLp?=
 =?us-ascii?Q?CIT8q7YU58FMowZyByHfZwAbT+8QrkUDwuvDozc69qugROtF3wGoPPKQ+jD9?=
 =?us-ascii?Q?Z2JQmkacrGu63QPlP8r4gs5qOLr1x8Ct27e3J1v1NnYO3Zcp8KS9bACLRqFV?=
 =?us-ascii?Q?FDWI0t/MUkXEqzry1GG6ZqWRslClAe47oi8LMJKu3yJICKc4AGnLsOAtDA4I?=
 =?us-ascii?Q?2tUAnmR1HCbcXCtPhkmD96DBo/632q0INSMvAbWLWnjOfk++Rz6zLWLESTwZ?=
 =?us-ascii?Q?VegReOUvlZgbSefcDLOBU+pk2P75Xe4b8uVK3y5RxDHOq/xXAbvuoEFsBMhM?=
 =?us-ascii?Q?PHDyL31KI7jb5Rd9lJ2QGydd3frRRT7TSFllqaWdqE+ty0W00ZqYgiblIz3X?=
 =?us-ascii?Q?fEo7YaHevEgW18+xmomnKe+VbiD2z2T/ndkvxp+rLk0glx7gzDuaGFWiaKw4?=
 =?us-ascii?Q?t23KVXQ+9WLFtILxsC5r6gYzF05UA7KwEwM4q4aMQSFLk/Nza/5M5mtZm9IS?=
 =?us-ascii?Q?uGqGGfXKt0xTdjBonjwO1P4oMGq1hit2G7vQBJ+TxoCtwd9AZOm79hrCYQfT?=
 =?us-ascii?Q?e0x8uacDEBFbocSwwuoTTUNbQulnaXUTRxjbNoB3sLw7gydj7D0RBSirjWMP?=
 =?us-ascii?Q?mWzxDanEoropUsyKM8MGUfCGIFx2kZa0RV09HSZBW5DjFJOOtvw1EiT1tx+p?=
 =?us-ascii?Q?36wEweCgfKFBP9XrZYukwTvwlKLAqx8HJuQzzTQyKgObQptZeQYh50M0ZzGi?=
 =?us-ascii?Q?cVg2nxPmARAdoZ2xkCW/HHRewKXNKaruL8CRiT2E9JrqQmFKiXaCXHPzGc+6?=
 =?us-ascii?Q?SvAqSreW347fO71bistZhJ3fr3UNN6wJxHAmm9/4TjColiPqHKijtB9X3PGS?=
 =?us-ascii?Q?Emiu0OLjPtbsFP2ro/NPaS5Og1tYwOWlnUnWvLQdxlXXhaj1+nUqNXivHp0k?=
 =?us-ascii?Q?iXVQH5ddUUvm4fB2BuIa7hC7U/XiqbJRHM/mgJT9CdwtI0xkhXMI0bIEsiKk?=
 =?us-ascii?Q?3418gP6ybdSOcWmxVnMnL0OkZwOPYqZQ+TpMeyDhgqoKLdD/RRjP+Bst5zku?=
 =?us-ascii?Q?fmOj0DdQ65ktMKRUMRmtR+X6wbjt4pcFpEg/JQoXiQ4PZXlgHwvGMGpXzH5N?=
 =?us-ascii?Q?/zb/6dHQM0/Xbdk4rWa1E82WcqynDzu7BcF4b/E7fc2TJ1U38Cyv+JX2UnWx?=
 =?us-ascii?Q?ryxvBQ4ErA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c051c482-2831-4a42-3c88-08de59a5039d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:20.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1QRHX05E+KYbBXCmTw8/xnEPW9zjA57L87k6GR2lY0kykJzpep1P4Q7XFZrWB9JkBZqQTJUtZ2lGGTGW/oQeQ==
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
	TAGGED_FROM(0.00)[bounces-252279-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 90A5A65CCA
X-Rspamd-Action: no action

Introduce a wrapper over xpcs_create_fwnode() that doesn't return the
specific dw_xpcs pointer type, but the generic phylink_pcs pointer type.
For example, the NXP SJA1105 driver might use this if it has a
pcs-handle - it is already a user of xpcs_create_pcs_mdiodev().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/net/pcs/pcs-xpcs.c   | 12 ++++++++++++
 include/linux/pcs/pcs-xpcs.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 9679f2b35a44..910fd8b23d41 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1707,6 +1707,18 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(xpcs_create_fwnode);
 
+struct phylink_pcs *xpcs_create_pcs_fwnode(struct fwnode_handle *fwnode)
+{
+	struct dw_xpcs *xpcs;
+
+	xpcs = xpcs_create_fwnode(fwnode);
+	if (IS_ERR(xpcs))
+		return ERR_CAST(xpcs);
+
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_pcs_fwnode);
+
 void xpcs_destroy(struct dw_xpcs *xpcs)
 {
 	if (!xpcs)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 36073f7b6bb4..9e450a356737 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -58,6 +58,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
+struct phylink_pcs *xpcs_create_pcs_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy_pcs(struct phylink_pcs *pcs);
 
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.34.1


