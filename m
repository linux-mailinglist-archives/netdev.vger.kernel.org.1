Return-Path: <netdev+bounces-251748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IG3EYhJcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80050751
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5C6C18DE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36413366DB6;
	Wed, 21 Jan 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQ6I4QkV"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2172366567;
	Wed, 21 Jan 2026 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966475; cv=fail; b=HubA6ETlF4XSL+M8QgiMVCJrCDxsYCCDO0S7mM10Z2zFX+9jYC9VrDjrmN5gKV3gkjkSdYReDspLyMpocUenn97wO6FDxzKIFF1yIDUO3bG/HzcFqNB8TSxiAIlalISQbX3u/Q5VTalSsJHfQCT25OxY2xT27xFNqGLZ39/K60w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966475; c=relaxed/simple;
	bh=++5BwbXI6gsLka6qAUzrvbfIDIWhlLfuMOnODDgcGVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoWG1gQ2tbKWgsJC/jOsmN0UTDcnJg/V6YcK00L4RFXD6Fx8V9iBfWcG9Yr97GUxICHQ90VNDZ+YoNhH5xZZeck2MiI8kLgrl7WW6mMIyGTlpAvcS+4R1E+9R6l3pZCrqVVH0ctWfKTyH8AHxeoIUG2AkppcCDvsDMRwWRxIXz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQ6I4QkV; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swt4IOdQxCDTof6GKO2oF4GFaQPB0Gf4EzVxTBrhAFJLCvhs5eNppR5IRrOnrdebDIsFCQ14ngNbXpYQMaQ769+KR13Sm5anjAO6ZyHTK91WOmwJJvV+vJStWjzgDN+kbFK5epoTIpl6AOS2ECgCI3SKw20lHnX+VPndAxSNtBLvqvnaQwFeY4W+89lmnqRWZlIAHF8ZatZJZBzmLrOhczeyRW2afB0AteL44mODT/OPRTjBYBdHwwiNOiWMsUczYPSviNuhdLv3NDnbO1fpbVdTgr2dYvKDwNZmUUSNkUCIvqNz7qXLAtSIC/fH2H4vSmyMBDvqvKnc204xjB9ZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=Vl3CGp6ma+QaMh7zk5IE0q8nJiEZZcmN3lhuwMvn6ySVEnwFsY3A9TOQEeItzpEXG4rmBIOstiduwYgcJjp9fvyhSvYTokinAIktVduMDdXNahUdLi4P0JAV6uBXnX5CrWmfG+u9IAUoLm78RRR4SKMsfTLVkdCvHHSp9pQSq0ndhUbF2KJdlVrGhFDLB66L4vhDj0e6cnDKREHKG4ndLzH5JADQi4UuC5wif7bI9HkMcYx+gSgNw3M124uGQh8cIipFLB0L4wBBTqBW+TflX7ebhXEVJ5KqxfT1xEbvVqUSTZjLypyOKYJsDYLsBg6LGgC+9cHyf71iRcr1I6p6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BkCGt8PQsr6pzPjEl54Zc8fTuQCm8RmbczY/wHYp68=;
 b=WQ6I4QkVDqM5QDuwpNoHmbPkUpQyMcLekeAT1K2Ly3ug/dnM2gymO/QAmdmMkux8svGxAWjT6U6uYzrHl/H1Edn/9eZtxwYY2hcuh7wPFUErm5HIBTWIcD803NvBYW1fcGVnOcQxStEH5tK9yCuCtzpH25Kl0u3iG6zRLbYTE94ny74bfqpBvDIHj/HGNCI6wu2J+EvP7vRFZDXiuU13VP0VgmpAZhFf1c/k22Ha4Op3vZS1Q7GatY/KoHxm1cJu28+cvVyogrbAN5xMEwOeaU9de8bSziHu0cSaR84oLWAWDzRx/IncOblcJUcor62c9cWcMeQQYO5ho1Xj+C3++g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 02/15] net: fec: add fec_rx_error_check() to check RX errors
Date: Wed, 21 Jan 2026 11:33:44 +0800
Message-Id: <20260121033357.3261464-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: c31b71ff-f874-4026-58ac-08de589dfabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRt4BigH7T1xa3u5I8Rgl6Y+dcCSNjs1rQYUcAph/4pi9nvUB9jEaLoviriL?=
 =?us-ascii?Q?sYEpniVB8xMaNZQowg0BCYK6qnM6x7QyS4aLWtHZ1i8V2uqnFvW0DCbD4zzN?=
 =?us-ascii?Q?nTqNC7fgcN0O+DeQpvw4njsZIM5viJqnTfNMLq30wUYdM4etMDXX8VzoL7jL?=
 =?us-ascii?Q?2eOIOc7x6BjykpHnflUls8PGfHgztHDitpJZ5SkhRlo1yo9+TjuLiQhLorUh?=
 =?us-ascii?Q?A0EuzdIQzapVLusvf8IOzHKZwvmD3RySY+oV+JeeyH0L6ScEU2jFrRMXd4YB?=
 =?us-ascii?Q?/dukReiIYhs2plShzi4rEKWPIWdMR5C0ykpor/SRDozuZ4ZN6Q3pdEQgXtn8?=
 =?us-ascii?Q?Qtpqlk0cvQqINMEroMcQT/VZ+vgJuQu2jI8a5G2bAvFN5w4W1lUh3LfKyMrC?=
 =?us-ascii?Q?SCGLnF5P5ieEs/6jtRMe8ASHGjU6iz1wA4MCLKTzfpIwTt1q4ieDBRflpS/S?=
 =?us-ascii?Q?h56y3WzDpyxbrDqF7brz0/mGA9Ch9ugRIBJZs7ppAbVQj3t7SJMMFPn+eXzM?=
 =?us-ascii?Q?d2R7+8+mgKTF8uW8Ep6CZcPohqr3UuLpEFMB3/B1TZ/v8qd/4LeqpDn1c8Q5?=
 =?us-ascii?Q?OA9TZhx3+sbc2mYrMRj/uMleDbHSBo8Pje1Ko85vda2xlHkz4MrhnC/qr6h5?=
 =?us-ascii?Q?BrfiDWTivQng9Z/1czBQPfitXO/m4C56IpXrdwuKMmu5Ggd1iE6+9jsh1ELa?=
 =?us-ascii?Q?xY2XYQAtqtRr14Mscnekztusq++eDlvbATSSFyxg0kzBWXSQxXIBY3Ggzl30?=
 =?us-ascii?Q?cqwAafhlgccMGupC9Fz1O6MRB93FoHrg36QyAQvoYqQ/e2BasM7hu1khPmW3?=
 =?us-ascii?Q?9Vk5IF8Yr+z0YQQCh3N8w3mql/fWu6YmzVIPqmSLrPOxH3Q5SthDmzdk2m8N?=
 =?us-ascii?Q?i5wXDHIle6Se+teiXrKpF0NyQYE6+xRq3eF37LH2T8MypgKQnYrX2FyN7Afd?=
 =?us-ascii?Q?aY+TnDf+No4QZzgw1bQ7LPlds1nO/cWDSUby+oNe+wCX/YDaSSNXAD9qLf97?=
 =?us-ascii?Q?WDYh/BZxUOPnHGy/CFPun8BqyyV/e0RBEy9mihgxbukxDjFdSYuJXIk2+5CR?=
 =?us-ascii?Q?1Ndns1T3xb8bgGs4K2jSuO4juZVhGHt3Yf2QYUyP/dyyy8lrLfQ8vbxSG8l2?=
 =?us-ascii?Q?kbvp/6FWDrBRnkZtb6glzsvGWW5v46gzOQ2A1gKWme9BDoyo5aujHyWrP4cM?=
 =?us-ascii?Q?gGJXiZRTSlImM77MVTLs2wCf9qn2YRrd7DC/0ufHY41vv+WmJw0WT8O4TI+f?=
 =?us-ascii?Q?uPtKRPwsAP2aXSbEF11mOg6olxMQvUxjIO5C4j01Mt7ucv2WSk7p4Tn90S1R?=
 =?us-ascii?Q?ZpxjXGkCZ8nqSbR5R8Qvqh+7hOSsqAJ0AskFTeR5yuLIpsUzLF51mAgtk2eD?=
 =?us-ascii?Q?kKzPMkX4fNygmc1r9EXeVockXJ/VF323EzOQ46gglnHre/JPZ301OEmKO1Ul?=
 =?us-ascii?Q?TsF+jafZCu3woQYiwA/6dbZYCOVR/wWHN51eLTqwhCV903Y/RPckhaWJj8YS?=
 =?us-ascii?Q?2Y+UyHb7kEWhpV3z4xPr++L1rlFH/TFoafRAb6v3YHpqWJBU41EQvXarOfTQ?=
 =?us-ascii?Q?fo+QASkn1AkDIdMa83EEvq7YKkc+FK1zFQqNTunBbrz+OhcjrC1kLItNkdiY?=
 =?us-ascii?Q?20KkrP7zdaxVKpQRhmwRQVQsvOo1A9Ni8wb3iZzMAyFp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVeB5thjEsyFJiRW3KRFCVvUDyOVrYcbnOOYBMt6l8R7o6HR9gf+oprfmoTe?=
 =?us-ascii?Q?CaEYyx1+PyIWE6YO0EclQUw5DfkVdfbjeM0m0SelaKIorObm4Bjw3ET3WNPT?=
 =?us-ascii?Q?EX0y/ykKEiiUFIzqun4TfzyYxiDLjlX1JkoyG/30TsFvsf/HJEi6yGBNPkpR?=
 =?us-ascii?Q?CLrLL1o5PnmzEF40p2Lx52+HxPGfJTGZXuYRNDFoKnDVHl+D7ucVPLv8LyIX?=
 =?us-ascii?Q?xQqnHzVR/QCdxDVjdHAsEehsprVTeJDE0aMh74q/SFQcBSOCniKET9RCJXg1?=
 =?us-ascii?Q?vQzql2FHnALqROuLscIkgiJFrAojLVD0UmjQPtJLv7hfJ1v3hM1IRC46ueuH?=
 =?us-ascii?Q?o9pG/N6GnioSIk+xJFE36htzXBx++H/P/zxsiJTKiLmoo2+X44UI3mVcHAmP?=
 =?us-ascii?Q?bdHhJ+QPGjU1AtN/tqsfzmEdBHwouOZVvFEqv+34gXo3or4IOWBn8AFL7Cy3?=
 =?us-ascii?Q?DyVxwVpPMLOzhkijE8mce/MDZPrbvOLQIL/F+D7UBCn1q0LNiCV7xl9u+jA6?=
 =?us-ascii?Q?HFF3wvI8eSfCoWo4frMzj1uENgDNbpSmLi0BN1iZYx3dW64WwHPcJ6H9az7h?=
 =?us-ascii?Q?Y9Ibr1mYnRgW9F3j5uYPLvEIViLZvFCr6754DJV5P5K6rET0jck3Jd2KrHpJ?=
 =?us-ascii?Q?rKE5YwPoUzBGXDByLrk3PDEuUKwq9TQaGOVWYE4KHLx5ez5XkSxL1gtlO+S3?=
 =?us-ascii?Q?aCRxgTCA1ddvH0qrdV2etFAuND2DWbuCfwEC3jzRpvRFpoSJ4wYNZaxkEvNN?=
 =?us-ascii?Q?5nm1FCgXswW59kdhbh1tePpNvPQIatKcQPbX5p/J//URQ0WhDVhGURFrm1hC?=
 =?us-ascii?Q?qOc83AmVkwoGKcjYeWP0LPrg5WvN1FmSqOv6glrNJQ3jy3hKUen57pZL4tSr?=
 =?us-ascii?Q?9W7d5LJS3v2IL2xV0M8ddWIGmxdb26Qa4eGGh1WtBYpcq4c/ppTNMx97N7oG?=
 =?us-ascii?Q?19c6ENa5iDnzk4Nrop4PwEOkfW+3QQhTJMP4F9e5Ied/UWMLz/Ml++Md7KXZ?=
 =?us-ascii?Q?UyzZXSbEWDMpVnNWBOU9f18SfVhUwI3h3ZnE1hEPVffI47rdqVLECz6r66MH?=
 =?us-ascii?Q?PsaJtlG01gDQi0xLKM5FxdDp11r036ctkB4Bdg+PNvqFRjMMloHPAwp0CSBA?=
 =?us-ascii?Q?MmwAI6tnD8mpUfERUO1WltsvG4OBpW9ZbOcEpwWE07Ev/KU3KpZtHVhDcihA?=
 =?us-ascii?Q?PrcUr4Zm9GA/cAXxzkAqyyU/AqFxa3Uy7rDdzpfvJJaDKcOU8dLhPzJ9FnPA?=
 =?us-ascii?Q?K5yUWdvF33rZKxKyzwt4kIcrIugPdwAkw7+G9exVpCGHnwJ6UidrSvUpnELV?=
 =?us-ascii?Q?pMAcbcrAngwsaDkcw+/0g4GBdwps3HvQPqAVd94VjWP4yaa0QDfKwv2VaoA0?=
 =?us-ascii?Q?et9n5ybIRZDChQIYmH9YvxexNWTXPQTlQ/WxmDS0PWqd2NoMLJ0uIf28Wb9W?=
 =?us-ascii?Q?bJsyPXUeDQfxkh2MbLY+Dxt/4uXafIXf2GjGCPsz6QEC0h2jIYkdSVbpUKq5?=
 =?us-ascii?Q?NH0gbJzbupCT7o8ukjClYHg54Mn0JvjxYmkPAGbv8xOJKlIE0Cq7KZfupsyp?=
 =?us-ascii?Q?+UgUGVN77XuGqjuwWKiXg2ghWUjfDT8mgtG2KcEhsVnwl/PsY6ngn0PugnC0?=
 =?us-ascii?Q?gVWekXS5uj2ReYD4QSMYkQBJkwgnjKfQvbsvddtxZRl2RyuQhZxVshPvL+lo?=
 =?us-ascii?Q?ifPI3WFZURocUc6H+TlE7ZS/qHKcUeLyXu48IrpJT9K8VXQ6lNmirxxmsca5?=
 =?us-ascii?Q?onTlXJVhXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b71ff-f874-4026-58ac-08de589dfabe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:27.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNetMQM+1u+cbv/rUYb/MmyLkyJRdAYLmML1pkbH62VmJYBvmQy+tg0T5ndtsXNJYwZ2vN+6gkdKfhkWYKVweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251748-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AA80050751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 85bcca932fd2..0fa78ca9bc04 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1746,6 +1746,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1806,29 +1841,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


