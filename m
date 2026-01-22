Return-Path: <netdev+bounces-252286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INWfAdsFcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C540A65C1F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 925C942ADFE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2C449EC6;
	Thu, 22 Jan 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JVH6/prM"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE043CEC0;
	Thu, 22 Jan 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079463; cv=fail; b=t89e42fGfBNx795gutaE+ZPVeJWbekwglJ3HU293iXcdEVvv1cxdnKUZn2zQuvJT3bTyPoONbBsLp9OB/gwR8gHCx44mie2sgjNHOAnyuZVbYCswq2vQZ5d4kVoG46OBFPKrY6F5DGpKs2KznJB8w4j+t2Su0M52386EtV1wGzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079463; c=relaxed/simple;
	bh=k8Bvc0XHseiHfCvTmz5Kx2fludyqf8SOPobRnjs18lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bow5ApYdJB3QZ3z4sZxNJb4stt03UgWhFiJKaHo45yacbWZjvSYQ1i3nmlHuHMWowT1Z3T4n9T+ZHX3+8xFMAZAToAmUSDW9itch1sy9vfA8Mbo7cM/1/r6eEhvT6RGKbyu6KYR35mCbNOA0SySDufoApyttr3nU+0gwkBnnDY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JVH6/prM; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXr0Wf0m1Jo3j6iAw2POvhrpBpn2eScxppspLm3CExaiLEegN6qnISf6UopX9at80Tp7Ht3NrLvmuZEdzXmW4Ci88+F8rJvxjKZgueDASNzBppuemastAx3Gs6Liy46dx6NqJqNRdDZ9a7qPL1c7721SmDSZJbI1gciiV7raBSg4ekZUwHzh6bDo0p+cLGVkOToeKyiq6yJwiW7mo+KdkRNz0vyhZMROEUyessn7ctmt5fEgMHWwsij3yXfWmrhyhWQs895swJCKPiB5S8pDUiexbSp6SgRT2updQGVAd4ABCoHK993Y0EsFmCcM846CMPTvqH2A0QNR3fjNw+Muqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhHZRuC86kQeaiXXZFSA+wjuPsSZARcyFhJXcenYyFE=;
 b=v84YVVZXN8c8YSixxbUMi1GqIqL5xQHYGZHYnxcnHq3CtSi4bcfsXwZ7thHf3HYDzgZDqeFid806SEdY5Es0QfkqkvKqDQHi6dKHcr4GdxmSBwuVm2fsxa7+OgqmYMVgj9isholCCeEOuMv8W3PhNJvYQp4RXMcjN910qUvmy+vZZwqhZQ1t7XdB3hhTa7YcYBCgiCFnLRDgL3YtuCmGcCa/e57h8AhUZz4/Duby+Nho5JsSUJlkxv4woblWCdl++U15S2ABNFiHJxwUOeVMU/X9pwNM9BnQeIjwKhR9383b9LedojOf/cC0ltXolrxVufOlWp5lfXJ/Xmz6HdopVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhHZRuC86kQeaiXXZFSA+wjuPsSZARcyFhJXcenYyFE=;
 b=JVH6/prMzHcVmLT4JUUqWrP/h0VRO9dcQs/8V3ww5XqORrgFBKcdF/YlxtLZ2PrFzyy6LlbqqPZYS2/xYg1zee0T0F1Fv06y0Jl803EwD01CQF1WZw/i1Dwvnnct/hYyu2AhMnNCczkKj/ce+XKFaT21q+clzIFq8XwrKyNA+cV7F4LW4O04bhBdk/uwcicOAoJh4p1AwHUeqFtOrX2OYqHqIJW35SWwFq1m8gLaGWS6XY4IGU2J+6+mPvz8TKHnDmSNq51yLsCaGRO3oy4+cj5RuPMbwoDI+L2xCWR7yZBhWoPcSMQu+X6bd4aVACc1WtKWfc5IYh7yBNjLD3Sltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:30 +0000
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
Subject: [PATCH v2 net-next 13/15] net: dsa: sja1105: permit finding the XPCS via pcs-handle
Date: Thu, 22 Jan 2026 12:56:52 +0200
Message-Id: <20260122105654.105600-14-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b13235f-bf7c-499d-159d-08de59a509b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYWp1AyfYsJN4uh9mZfrgfhoBx6+bBOSivZ54jhT+YsXZ745BAclNwAQrr7M?=
 =?us-ascii?Q?PHN+KBztZgkz43LJSB63IjGv3+UrPFFLJu3ZvCa78FDdRcydUf+6NbJPLgv4?=
 =?us-ascii?Q?jfdilotnTpdm2rAl9yYIuHBA7XvNToRJG6stbav9M3iJ6lWfJJ/HnQyYamZu?=
 =?us-ascii?Q?YsQ3Pd4IELIgv37iq4d/vgU74vi/dqHWQ06zxL1fJOj1CR6KF7tSwAiCgy9C?=
 =?us-ascii?Q?bhMEnLlRLJb3eR0T++53lNtRaFt+69P/jopYOWFZ0iG21LYrJ17palFEyoR+?=
 =?us-ascii?Q?nqkJlcUo6ioPzadgVC4W0TP27LJQ29fb6F9agaJtj5TKL6veBRXwZxHwb8tn?=
 =?us-ascii?Q?V19+Mgfq7Jh79TLfnhML2aHqp5yOvhXAZ4Vmqa1UW5XIUqTRTA//6NmbgR7K?=
 =?us-ascii?Q?hW+6F4FPt5lzkQudHFgm/JlhAwKKWjeK4p7YId7pJTeObivz+78txTCvqCJm?=
 =?us-ascii?Q?ZzonvLQToKZsenSpbbPoWRb2jxERoyJ8/r5WRnSGdJoPknbIbnTcViq3VCx2?=
 =?us-ascii?Q?DRBkBCps1adHQ1DTmCs8KpMj4nsgPaXgdbargIPUEPgkXTgYOFynUDDT9loT?=
 =?us-ascii?Q?kMdq3hcPcr31Q221N5nh1tx9pUI537tU4Zbz/QmlcG4ic4Xx85Bet2CfUkhQ?=
 =?us-ascii?Q?3n3m69lpGNvJwPolbASy9WhFe1XaqgRJuEfVnf3Z8f8l6HFwajOLyp9R2yTA?=
 =?us-ascii?Q?AMLc3SsXgLspTNYr4JI6RWIGJHA7k4l2ag4UIQiZi2C/0l2SiLWo648HRtae?=
 =?us-ascii?Q?4zezvFS+ftq903t6lNVzX5QHgSWt0IQlU3zKPD3ccP6tIvCHRCO5yn/5Vy9E?=
 =?us-ascii?Q?7k9M3YNNOVpQzMNLiUf84II47dWOGSebD9C4hiZhfpzmgVcHIjyIFSvcFgDJ?=
 =?us-ascii?Q?54rPHLFWgkOL7i1LXRm2Az5HLftv5JNfld0Kl/jwAF9HGX9Wwme1ZSja8x/x?=
 =?us-ascii?Q?6+YkbiRcqYSD725blTWqDEMhkzE12Dv4UQHeaGduQCWcpOMz3tyMPeg84AwA?=
 =?us-ascii?Q?Mx82/2K90trHgQ1HESl5g4RXw2KJmyY1Rs2TVOLuVQ0vbhfqrYKKq4/neaMQ?=
 =?us-ascii?Q?qx6RolSWiwTnfJFryHTuvcoWFo5hCvcYhdhC/UMkx57k6BLVtWb92aWGeUSF?=
 =?us-ascii?Q?mMgdTbrM8wD4ed8YG9EBADT9fcdAh/dMLbrfBY0kKQUUY8KeHPWOg4PxcSvq?=
 =?us-ascii?Q?9sXHIQVdJDMtq+fw88YkJdRZ61hb77PuSNcyn6Jbss9+jp5/fQAAalQ+oEaJ?=
 =?us-ascii?Q?joULO4SHjRn8oeSzm2ior3ly3JUzjVhpdGQk0S9buj2LrFCJTPDr+emrnu04?=
 =?us-ascii?Q?rtF0siylN2hzDjHZrxpNxN9XirF8YjpH9VOHSd9vsfdoZMI6d7QOK/Uk47s7?=
 =?us-ascii?Q?sbUR7N3ttKpjznmCN347rlJ7jugQpkVCG2p60c36lWItcwNnIpYs2GE2iX0H?=
 =?us-ascii?Q?2lHfSZQ6hgBTnj/FmZX7SmmKbF02+YLBJVe/jECLSJxx79/LMTh9/dIRBOOC?=
 =?us-ascii?Q?61L6/IZINtaaKQAXr+CDM8URGqqpLyQkj1sCUns7cCUB3wu2sPvJmjpNDVkI?=
 =?us-ascii?Q?pob5auLJxmETAL5tAAbbcmxXBDwa+7qp9wWTm/H5uOizcwLPszcQfzTWp+Dc?=
 =?us-ascii?Q?Z6rM6eoGNS+LAs+dt1Vc4js=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ji94tTOtnDyNPHpMPwS7lVx/6nNbedcuXR02lY6YPlIvx6PETqYf1M/Dwh8F?=
 =?us-ascii?Q?h+Jws0S02w6iWxN8cYuasbUE7mi2jRCH+3zGfIU1V4lZoNJUoTqF2wu35/6E?=
 =?us-ascii?Q?TznPHE1GGq6Qja+bNSccF7Ax7ag+JhGVj8Jl658GvMpG3WU3r0Yw9hhv42ZY?=
 =?us-ascii?Q?uSH8Mzxr1eULfMu7/RuEKmHQG1BQ4Fs5skGU6kjDCapUbK4u8ZGfh9JLRP9g?=
 =?us-ascii?Q?JiXr76OX9WcmpB0/YauNTYQKG3eXYModVmylq4bvxBjug3DVtGmrqyxwMRCz?=
 =?us-ascii?Q?Pv5Czm5guyObGp/cFowvxN2x4V1dZz8Ay6G2pEMUFa4AWcgySPQh8jQSGSVv?=
 =?us-ascii?Q?tuuGe8d3w/ogtzwUswMPQpu9W3d1OuCiYhCK2xTrgTb1P05I5TtXRc1rX+qm?=
 =?us-ascii?Q?yvuuSJlogb+fvaMvyClGx6cpf8owEbJ02agFvrgsUIraoz3ZY/EfJYrwOWwu?=
 =?us-ascii?Q?jjYeYA+of0dG37vHVhd1/HEHp+Ib3hoqSHHEhiRtrkXbPpHVf0TW16GO5hDj?=
 =?us-ascii?Q?v69YzFZj20RtNkgz02m8LdEBO8s567L+HEUtTHoZn++saTwCU0mequ+A84/3?=
 =?us-ascii?Q?Y/em+wRHKhZICGK/4mPjCT1AVOSkV0HPrAhlyn+kTXr91zP/gURi7HdNTehm?=
 =?us-ascii?Q?NdRT5dn0UKu2LJvbLEckFE0CWA0zMaLBoAWxdUjhFg/2YaZMUOQsKxOZMmEs?=
 =?us-ascii?Q?SYjtWPQd/vcjAghOfUzPeemFgfWQ6eL3UfKNRvh4UMxPZjMXUTpdGwkCEn+i?=
 =?us-ascii?Q?Afk2pPu0lUqq6heJmZmYmwpNcXPYAnSDkfnepZDb044N3dpKwFZGMs7bpJHW?=
 =?us-ascii?Q?wdohHA5/+ONDuMdYpj9tE4TEOYlFA9YIaKhe/NImqJ6d/9cKSTaKcp2rMAxo?=
 =?us-ascii?Q?adoIDbSPqZjL85jDdUS5P2i4NTTW9U+ATDxNlYXp7K0qTvt2ll4ECtndKVFW?=
 =?us-ascii?Q?BMWMeM1mDIBJCRfVGX+cjN2uqxgLmnbcqY2GLG30zGfAocDYOlFbBdAtfFDF?=
 =?us-ascii?Q?tWn51T7GuN5Oh6kxDgTk2JYLM72gY6PIGPNxER05lHoVAHzTGuebIu3MMddX?=
 =?us-ascii?Q?HfF4V4GXdfM+guRdPHzviLlKRPCCn7ukNtTLqAVHsiZsqfgyrdjh+2xysjp4?=
 =?us-ascii?Q?XcwTfbhil9h/yNvwu8DHbenU1dYpK+9a9SPz1X4KzlySybWMKj8YIeBvw/KI?=
 =?us-ascii?Q?SchgXWpvVIH8ztqVG1Q9G1RaDq1pfim8SIyCZRdRq8/XinA2+8qOqEUOIxKv?=
 =?us-ascii?Q?jjOe9BZpwv9m8vvaqI2PRZ+8UkY67QKq5FkZ7hs2zkhNNEPnyEp+sDm9Lp+X?=
 =?us-ascii?Q?ZXEyVtKppI592tOTj99LkqRZA121Tsler90tt0Tpx5v8cKB+0/LAUIefd2vn?=
 =?us-ascii?Q?HBrvtXrqlk8U0wpPyHBfEA/fXNhi0RMYMHEQGbJ01ZQ8XqOFclqohooKvevV?=
 =?us-ascii?Q?ri65WNNdpkmvy8vDRx/KrRexGJzMkyCO8ggv0xpFck8xqk4o2dNFAp1DO82u?=
 =?us-ascii?Q?YYTLNKgCElN9Tn4Jnse9b9LJCemLSemCZaeSmDzCsViyDKXJwSbZZvrhBowT?=
 =?us-ascii?Q?nspigvu+YpOOiJFeu6hZgMkrqzyF/eix9CGlfq//AX92+DrC9ejZN+cQ8KL0?=
 =?us-ascii?Q?8I7ATBv/zSaqhYAK0Q9rp9g9VDIrhR3umQCz9DN/XEZS/hVe73S2ItAwYgvI?=
 =?us-ascii?Q?/MYV3Fmy9ThWG8YTX4A14bA+ZFAjzJD2HtvZ0MMJZWvg1IxgaJCI0N95vHHe?=
 =?us-ascii?Q?J/lUb/WRlw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b13235f-bf7c-499d-159d-08de59a509b4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:30.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJHuLa3yfil6FuMghkQO+7ApL+EWXoLOwB4wxEbubv8eAyK3NgHXYl18cAfTYR0LoNuNiM8DhpSxa3+cuqydQA==
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
	TAGGED_FROM(0.00)[bounces-252286-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C540A65C1F
X-Rspamd-Action: no action

This completes support for describing the XPCS in the device tree,
rather than just the case where sja1105_fill_device_tree() populates it.
Having it in the device tree is necessary when configuring lane polarity.

Note: I would have added a pcs-handle during sja1105_fill_device_tree()
too (for more unified handling), but this doesn't seem to be supported
with the of_changeset API.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: rewrite commit message

 drivers/net/dsa/sja1105/sja1105_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index b60a890ba416..3c2030e8fce5 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3008,14 +3008,26 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
 
 static int sja1105_create_pcs(struct dsa_switch *ds, int port)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct sja1105_private *priv = ds->priv;
+	struct fwnode_handle *pcs_fwnode;
 	struct phylink_pcs *pcs;
 
 	if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
 	    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
 		return 0;
 
-	pcs = xpcs_create_pcs_fwnode(priv->pcs_fwnode[port]);
+	pcs_fwnode = fwnode_handle_get(priv->pcs_fwnode[port]);
+	/* priv->pcs_fwnode[port] is only set if the PCS is absent
+	 * from the device tree source. If present, there needs to
+	 * be a pcs-handle to it.
+	 */
+	if (!pcs_fwnode)
+		pcs_fwnode = fwnode_find_reference(of_fwnode_handle(dp->dn),
+						   "pcs-handle", 0);
+
+	pcs = xpcs_create_pcs_fwnode(pcs_fwnode);
+	fwnode_handle_put(pcs_fwnode);
 	if (IS_ERR(pcs))
 		return PTR_ERR(pcs);
 
-- 
2.34.1


