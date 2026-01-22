Return-Path: <netdev+bounces-252283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GbcLWwMcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:39:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D7661CC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51AC9700081
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DF43CEF6;
	Thu, 22 Jan 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dX3X9Kzb"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630936D4EC;
	Thu, 22 Jan 2026 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079458; cv=fail; b=g/UDGcHP74dkecaYHIFQzocBoXxHLoGAcLfSewKmUsMS9+qYa95n0yLrkNIPxN91oqRBq0I2ZZuv3IUg/GQuRjAAXLowILq/W/UvkEEnmcSMCuvH5gqZ9tSYi2C+0wiVuErYznFLPpVJRNQhAhXmQDHWFBfXYegg+ebEjQ/GD2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079458; c=relaxed/simple;
	bh=CLFWSpsjLS+XmJjKkkbhMyNoXXE31W6VJkHMlf+b8TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2ociRkeq7KcYfKGLV3GCLzQ89A46vvosNE9ZE0qsXNisRCWyzK056MO7HPsv0e8l+eA0xRNk4pfwitz2e2lCvh9RBiYRT1shLjyCqkrEFEeYul0rFaH1Y0eiEwY6SV5vmXPave3ZrzNBaIcGdHNXsHyaCnf4V6y5F5s7lnyfLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dX3X9Kzb; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydw5YHpgdH0YLnSLCIDw8sLLhVFeZd1iUa4HNCtDlnoomfTGNHDEnfyj+s22vJXpzCfaGidZOzaKLB4KH/+QPcTHvP/RRjXoV1f0UlcRWy3+5Yc6ePQ2+gZ5OwH+LSAg2VMHQmcTUfW/WjNGE8s64+Xbz+fLPieci59ozexR4dYMzNAUpiLIm/iIDid3xpVjlrOS3/9N2JIywBRMt49Nw1lXOtkqcAjJ25vq9kKOQUbNU9EUfJIszDurHnFYPmk766tRgtqetc5uHDk9UFOZCMwrq+K9CrEGkufzcF5b2Y/FyVshCADqzrVWx+wKPieHHbyRNDSTOIJ0O9IUZI5vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIau/zN+CfIWfLW2nMGnIhDzUpakd0a7bxvxIMIo7sI=;
 b=EUC1o7bN+Ya05csJzzTgQgdB/EVG3ZZ6WFKbCnWnUZbcmi0sKOhTD/LiBjPIe/s4Y/VcsR44wH6oB8yOxP/84kWTjtLcNueQD0VsYQnT6EwadoFxC1P6+PiPA2+Tfe3NdyFxMNa+hGEO4ixklR1xcvEyWPy3Fc9IeP3YZhQMXAlHnx9RMqehkQqgOdjGtQtWwxqtfwSrFCZtK4Q4TTOzNsaH5/VBO7bW3la5vIdekAdzasxuPr4pk9OTY/dWH9sW+dkmsl1I09ipRno9K6NrrXiC+H8Cte1UEk8Wiku7WrybgbF0//Uhl2CU1MB3SFGNr4rBceLiKC7ah0Wy6COYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIau/zN+CfIWfLW2nMGnIhDzUpakd0a7bxvxIMIo7sI=;
 b=dX3X9KzbfI1qqF1mu3uCvQVCfQIxpbQmU5A/8gGGZmjM0330zre4YdRMCvc5tLIzfuxrAb22jf5YgRfXu26YekAFnmFbgq5XeC1+SxLmnCqkM7y4EYFd0p8FPnv4U2aFe5zhHqK1f3EgWFdoOeHk/XvGyX4I7clj6Uy0ud6dRA8XFK3UCsSpuTvYUdYgQPQi6U3B1AFyJWk2E2FQkrdzoWwOAIlZVLywROwpBv7DTEukO9AMImfpszfCjAB59/oYhK18iabiaNtQQDHyxLaacQ4swCaGjImJ1UEwxsZiyd0ejTNMoXjIBcsrKq2Jl5egrKg/sC7gskaSQJ2aBl2m5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:24 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:24 +0000
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
Subject: [PATCH v2 net-next 10/15] net: pcs: xpcs-plat: add NXP SJA1105/SJA1110 support
Date: Thu, 22 Jan 2026 12:56:49 +0200
Message-Id: <20260122105654.105600-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9bf97228-5dca-463d-5557-08de59a50655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kAwdF4pjr5+wp2pebfAnb1RsTIK6GUj7vRDkJQ1p3EFXKrdziDSua8guXc97?=
 =?us-ascii?Q?a9DmgUGO8BHQQ67LbsTodZS9WD7YfF3xZkEKB7MN4chiqsW8ukC2zAmQqfPF?=
 =?us-ascii?Q?9SjhYnMfiZCb3Zgfj+Tsew8RIaHBIiGw4J7wef/EI+ubpeuRqxTjo6yyXODo?=
 =?us-ascii?Q?jlsXOwvT9LupJ3PIA3iGK96riQou6ifed4kg9BristrfCh9q/sp0CTobtPzZ?=
 =?us-ascii?Q?baMrkRxojEKAQfT9lA96JjFkvnXy+At8jbE5LZESJzGHSgRM1pQ1hWawW1+I?=
 =?us-ascii?Q?2i3xrMiGL2bVP8FTz0x27ELh5cG2fDqN2jEh6EOZn1iAVEvApFHTW4Ct82Kd?=
 =?us-ascii?Q?3NdBr9s+dZCgpHdKP7QbM7eSLztsVzfkXVCuPoY8IeAc7zwJ+YtKmjmumQ/O?=
 =?us-ascii?Q?uN8apdyim6Z8wzuJRk0YZR4MZXu9FIjw+eoViZPTi1Moy8Uks2sU2I3A+j6U?=
 =?us-ascii?Q?i1A/YJlENTjt1lrcJ8xJp7o2c7Kx4wbRZKDlwIibefwjMPy40XvFcsPdz3Si?=
 =?us-ascii?Q?y2+8O+Uy+Lu7olYWsaT3zmM2z00MucKQ7t2kBKwz9jT5aNafAEAZqRDfMNcp?=
 =?us-ascii?Q?SswMbKkbr26csMfd6PvyLlagUmap5bIuxCjLv4o9R4THcNDqlP+/qG/AGE1E?=
 =?us-ascii?Q?ZEmPre39FbpvYPCs1c2qgoDJT28AlLkFLnae//YakBZgS4izNRIgErvqkn4u?=
 =?us-ascii?Q?wQvJ60qfut2OuxXLhYfx1i2mp0cooHfwlxkn/TdYs4hotDgtNFbhZmv0ymoj?=
 =?us-ascii?Q?VPp21Rme/7bwE4cvHt7Sqw+rRgPO+LNiArYOfUJSdUA+mMvdklEHYH4YbTyq?=
 =?us-ascii?Q?KR/vEKbVNDWiUX/k1YXCS5RIYopQTak4S0FCqBk4cz/tfoVswxA1DlxQd1nK?=
 =?us-ascii?Q?rzN6sxx4Hvgdd7DSOmxbMXLUJINY56Aa3W93AXqklfY9IKYSpivGD9Nd3MS0?=
 =?us-ascii?Q?CDNIHyPAmgJhoesqxdO61+8QGjR/lHpFaexhvF+dNGmFgA+e2ZeP/pOgNC56?=
 =?us-ascii?Q?sd/5w20v3o3qX67SmTGJ0bCkJWzxrepUrWURzaBwMt2uK7DQ0sOrtV12mAIE?=
 =?us-ascii?Q?vd2tKBx/X6iheIh4Fx7u8VqWBLrPkkRLmd/2KlB88RnZf1VefD6ECPeTA/K7?=
 =?us-ascii?Q?JsxX53GD0h/jezKZfaVfgJJRwK5bB3Tqn7qzJ/syTzjPMjOZyAfDf7WiqXaa?=
 =?us-ascii?Q?h8HuiufZgsAoQUL1zcqtZTHoBdgNIecC9xaiU4bYYMDtxCNQXY7JoQef1zD8?=
 =?us-ascii?Q?u2/gVg5rgp/zu1A143U90wogFSbJc8jgoKjxTV/o3qb+73e6Ol2SGDUSrBin?=
 =?us-ascii?Q?bc47XBhCcMukiFcicUv8nUQf8F+wlBU0BZ32T4AzPzqnamRlBHWubGp3FTkV?=
 =?us-ascii?Q?MOmnztr86/l4JWrkSPGtvHChYqxSpvIo9p2oNxQExhdhN6Jx7v0LLEQTHkd/?=
 =?us-ascii?Q?lyDoIgeVGvUAkL5yRXfA9F6tYmnKoBvWcI1IhAHkMKnPo7sMM0y6t6j1xM2H?=
 =?us-ascii?Q?IAQ2srCeEZwmYXuNBnCPHHD7bdXHQlqYnILsxMRXPlkfTSj6HKjuzw9N0o1K?=
 =?us-ascii?Q?n0DHu28w5JR5Psk6JGso0KSQqbAAbowvVyG/O0fhkh7vNZvY5snVT8Njm+WT?=
 =?us-ascii?Q?BXe+SImr9pQ3NiJTBxwpO3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYCYG+T7ttBAcf6CovOuvVMCRmkhAQqcfpg03FXsvqgUTcq3fACCD10Vk5fI?=
 =?us-ascii?Q?Mph4aKPCM3yva+NtNqsyfkEJO9GOuguF20xgZsV8puCy/a+SFmuUkcT/ClKh?=
 =?us-ascii?Q?NCn+PinQw3YkuaOTTBAxZnQCCq/SJkxTsiotnFqj8sD6wHHMv9UKSadRDBON?=
 =?us-ascii?Q?z7wPeYzpIt7N5qt95i00JxPMHIn0yJpofDrx8M9Qdj+DErKjf/eajQxlelxj?=
 =?us-ascii?Q?NPXWaBn9xmOj9gut6dQBJbjo2ceMWKt6LHxVbE1JXPHgYK7hfhRvZsQq43Gj?=
 =?us-ascii?Q?Xhyn0EM2X0QpJNK6YiKrQaTOrtguJexspLCAPp8ztOuHH16/cOGTfKoH0ghS?=
 =?us-ascii?Q?7RvYDBaueZx/1rtd5AW1lMCpz+iCfUx3dY4pHfnRXKddtjWgpspq+/su4BB9?=
 =?us-ascii?Q?w2ihRpb3VvFMBCTckIAG6eDZGztduKQ/QM6EEynf5BB0VErMUCLkMzhNW714?=
 =?us-ascii?Q?ajsQWUmx/S1reTLEkTQiJsTzX82CysC6c2AzKvKxRY29BC0oKaYDzZsqPZvk?=
 =?us-ascii?Q?wRSGzvUx1j6Vo/kWHd2pxdZM7upATNIb4koo+28EdQTu3equ4sO/l7piPYxy?=
 =?us-ascii?Q?tGq+fMohbWoPKBvV8kEo/FkUp+GS73DQ80txR9v6zedHhvAje1IKUmtxl1FT?=
 =?us-ascii?Q?DVkEYUykX9Fep+54rgTDuqa6UcfBMoRA1srBxDbaWWv3sfftHWr+WdoOeNJo?=
 =?us-ascii?Q?eT5S2vt635jtpXNMoqSig2cbMgwZVkzzMYqKL4xsCp5bGeWLLSrhwVmjbEac?=
 =?us-ascii?Q?v/9fkjAYULa26KPqMLhFmMWiiBI3HkVaVvLIPdd6xTZB2IpXWjwvEy0ZojdF?=
 =?us-ascii?Q?UGO/sNNqfxulH+KlavXhRjGRKb0x0/M1qxzReGfCVcmwSKYywRnoJO4xnXU3?=
 =?us-ascii?Q?TPX7gFykPkCqcWdTCVUPoGeP8rRsMebdkhrKImn0F3XIMrPKnLYZvmJFJcN0?=
 =?us-ascii?Q?V0zNi0jsFdcfl+OSWhV+8B+cE7hGC3QP7HJjqfbygiJsY+8dkyODf/R0Kd2J?=
 =?us-ascii?Q?+ssZMNNirVYzhAVZ02FYyiIBFArLKbJ7tG6rW2YHIotwPcQh87973isTDL6y?=
 =?us-ascii?Q?aaYGhZysMMXcGDmQT0D2HbSLhy05aJcsyiYMuzBcgwMn7UDY05c7i0qdrDfS?=
 =?us-ascii?Q?scxxT/nz2a/8aB3iInQqhFASof1iv78SeQD/qyZCjcNwKQNOwFI+LH1nblm6?=
 =?us-ascii?Q?1SlT5pOSRLnerrRaujdI2o0fnppucriJYL9OKY6CmEFcn00+iPvZZnhA/CFF?=
 =?us-ascii?Q?xpdMWYzarUJCFsoydRXEuuP3GNOGaaKmh3xC2JXmVgeavGxYt6zcK3ZgxLzH?=
 =?us-ascii?Q?0k1adtYqUPEAEQnChMuKqwBGeMsJt08ONdteHoWEBfqR3LQBwpRLzmx9M9FN?=
 =?us-ascii?Q?oDSzYWrE4zKMsLI286/2w3+pXg5/bJe7Vxf+d51ueVjNj5skhe5maNlxPQYf?=
 =?us-ascii?Q?dJcvJECyUKZlJPc4p//0kkZkCxOQXrevZ35JVoVqdIsOUDTYYvtlDpmAnGnc?=
 =?us-ascii?Q?/PzEPjsiz+zlhH9tI+CcBF0R6MWNN3XwLa7hhhN0dT+8Rw+BEWdyVNG23F5+?=
 =?us-ascii?Q?0nGSzVqB6M7e2JuOYVU0Fc7hyOub3wsnuuNdXad/G5fdZly8q18VwlCsO0Y2?=
 =?us-ascii?Q?UXX+KORdM1lW+9+ahwdyS2sPBafWgc6L/im/yOQmzy5KFokIkUXW996smqzW?=
 =?us-ascii?Q?K9vUjSDN8c6piwwvM7v02N4vts6j5VSxcyCZ/GsDPq1LdblGQgrL3iEwLp1b?=
 =?us-ascii?Q?A9Fj6HiZhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf97228-5dca-463d-5557-08de59a50655
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:24.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUximUSG2lm9BUIAgwY5qdlPW4hcgF7umkldN9bHrW1R7LEL2+n8fjGKp6fg1g5KpKJQKCCY7w+RCX/f2Qciug==
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
	TAGGED_FROM(0.00)[bounces-252283-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 780D7661CC
X-Rspamd-Action: no action

The XPCS in these NXP switches returns 0 when reading the ID registers,
and is integrated with a custom PMA.

The current way to support it is with hijacked PHYID register reads
in sja1105_pcs_mdio_read_c45(), to fake that it returns
NXP_SJA1105_XPCS_ID.

The new way to support it is with a specific compatible string. This
makes the platform XPCS driver use a specific struct dw_xpcs_info which
it assigns to mdiodev->dev.platform_data, and from there, xpcs_init_id()
picks it up and uses it. Later, xpcs_identify() doesn't overwrite the
xpcs->info.pcs and xpcs->info.pma unless they are set to
DW_XPCS_ID_NATIVE and DW_XPCS_PMA_ID_NATIVE, aka zeroes.

Since what is custom is the PMA and not the PCS, a later patch will
probably have to move the NXP constants around. But that should be done
only after this becomes strictly XPCS internal business.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/net/pcs/pcs-xpcs-plat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index 2bc0afe2bbb4..a256ae40c757 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -476,6 +476,8 @@ DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_3g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_3G_ID
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_6g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_6G_ID);
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_10g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_10G_ID);
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_12g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_12G_ID);
+DW_XPCS_INFO_DECLARE(xpcs_sja1105, NXP_SJA1105_XPCS_ID, DW_XPCS_PMA_ID_NATIVE);
+DW_XPCS_INFO_DECLARE(xpcs_sja1110, NXP_SJA1110_XPCS_ID, DW_XPCS_PMA_ID_NATIVE);
 
 static const struct of_device_id xpcs_of_ids[] = {
 	{ .compatible = "snps,dw-xpcs", .data = &xpcs_generic },
@@ -486,6 +488,8 @@ static const struct of_device_id xpcs_of_ids[] = {
 	{ .compatible = "snps,dw-xpcs-gen4-6g", .data = &xpcs_pma_gen4_6g },
 	{ .compatible = "snps,dw-xpcs-gen5-10g", .data = &xpcs_pma_gen5_10g },
 	{ .compatible = "snps,dw-xpcs-gen5-12g", .data = &xpcs_pma_gen5_12g },
+	{ .compatible = "nxp,sja1105-pcs", .data = &xpcs_sja1105 },
+	{ .compatible = "nxp,sja1110-pcs", .data = &xpcs_sja1110 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, xpcs_of_ids);
-- 
2.34.1


