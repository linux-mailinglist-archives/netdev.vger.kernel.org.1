Return-Path: <netdev+bounces-257055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OElaM2VbhGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC3F024D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72941301252D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79837106E;
	Thu,  5 Feb 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U2Ak78u8"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC536F408;
	Thu,  5 Feb 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281789; cv=fail; b=ORGX1msEbvpUXpjq4P/ZrN6Ud6BtPcRXCvEdoeZ2maZZYZ2dCxsqfscOTvmgoqmh4W0e8VmIAVLnLrRAKr+4udp6LAKE8ibjxK7rybiOcDpAmxd8WljogN4a9f5r25RohDTWxh4vkJ0rFzxKt3No9/mvQpg3nSzdrkyylK8IuB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281789; c=relaxed/simple;
	bh=+FI2c+V0tYja//tX8lopvOZsJRTg7EwIyVpmjXVeeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SiuDyENpeulf+2A0FyXbcmI4RsePtr+IApzRobz6ki9Qd2uqWaA76BpYJavupRsat9BbAobQS5BL058IT2ediTkfn+sZXW2G0LLgGVvVoBF9/gx33SOYxCJU+cu+zf0/U2GPRvJJRVb8GpyZ2QLZU77UdHoJvBxfEAdxvEJMEao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U2Ak78u8; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfIH0s1iEeI5a0m2J2AaS9VrIh6D8sepk/We0O4PH2HLrO7IQ4ur8TpbelFI530YuKV5k3Nt95C/lOdogDRknXJGTJCVDxG660v8OWBRvKVtZZWUzxBHNWywLWCte827DAQ/qLD9iWB+mwjr56m+SAJTbKjYGVm5RWMFLpbrNbHEaLw42cq/kGbBrVf/BE9tYZ+pywrUTHt2XPL6xr5U1rZMY4n8d7L/FGAnBsNg/epHRFbvmm0rLiV/LaT/7EjJOuSGfztJ9cd5sevdZn+FNpuGUkRvr38QPMqwg1JfkES46ut7l5YGtwzEZfAj9xnl5hfaUSIoDihgS2jAexblSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=cchEkr2VpOgBQpbeZR1xiQ+xx0Khe0fxGZz9d7USPD26g9IWfCJAGkZOEHrYn3Ka2plK82t6tDZX5LT309aOEhktECWA+Rq8o6J2EkyxvGbeOGWOdr1nKQ5LZLYwmEJDPi7DvnLzcCUJdi/XMOSY2NOxktjWLR/H9VPMj3p5c8yJVUBoPvYASVp1uehjqd2BTW6uf9Aos6xxb+dDmhsyDynnyr0e21SgdHSNl5/MCU4PSS6n/C+W1lcL5Ojmi93IWg576l8Co+YttWQDEoXGDjHgfhnz5CfxcDpSvpcNwmXG379djgdVD7cstwxWhJopr/5hERie8ZMbfma9YiF3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=U2Ak78u8dG1A3DQ3BBtlIS9YRTVFp56BdxZuSYr3tJ/JRZV0O5FQ05oUBIxRFDeuHjJTAoF2PMeEnaowbrT3zCDv8dj0GVXu5w6kumUwRZjbb8ADd8Nc93ZB+umdqI3kDTTVJ2jVUSjejfUSKNc19vMzUlFtqh1TzkJpT4c9MBsDUxZZDwVS1wflbnvaCJaW5gkiCdaP6yjtwXPX7KMl3rTGLZeR35PO5uz2LLDIR1po2ku9dme/ApYYPPBWBeS2EtbtXJlw11545ejwyIj9L4Vp025ID9IY2PLePcDH1zI2LtCFj7+YnkP+3ysKml4U7HJj9x+c5WRBBngnWl6Rpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:26 +0000
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
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 02/15] net: fec: add fec_rx_error_check() to check RX errors
Date: Thu,  5 Feb 2026 16:57:29 +0800
Message-Id: <20260205085742.2685134-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 13512e7e-deb7-4202-baa2-08de649471f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PxBL8eGUPEnet3PK+aRVLHKK1B/7/IOY+ElhmbjTBiDlS2bo0s1456W8HILn?=
 =?us-ascii?Q?g7PQVqVjQnZuxjrjUMtlWdvhIYa+ld5/uO4LH/0CUqJ5uQ0NF4wpzSA3lJAV?=
 =?us-ascii?Q?nNhSD5beWdpbvKMZZQlqwmVuCQlpq2p6GJ/aQ1ZuOA8AcGEHLbeN9Ra2lcT+?=
 =?us-ascii?Q?1KSnyB6woGCVnSVyQS5I9hqP06q01Rs6HN+pgS6PCI549+S/HiGTlEQ8AQ1X?=
 =?us-ascii?Q?UkqJHxNhOcvuQJ952H0Up4M58jvcMk0q//6tdRkK2YAdtRA75OSAq6dlLhtw?=
 =?us-ascii?Q?ZtydwOlk0O35BZfPUibpJ/Y2kAup7GinQqnOLeaphFRuSoGPmI15U/IFFF5y?=
 =?us-ascii?Q?bMtobJUxLSzp7C5+pJpcV+fgHDGT5nwlv7huKwJi1blmhMV1wH5qEBkjixUm?=
 =?us-ascii?Q?pKNhrV5wGOD7DqZ3ZUkzevFIEmOicnuzf1HTCZVMlX52NEshVRHY2sN47P5B?=
 =?us-ascii?Q?WCo/Cu3LuTsoJOfqeDDJmQZQ1QNRggW5v+zjs7ydYYm9yJPDpqzOsoPXZTsd?=
 =?us-ascii?Q?1AEwigOKvntE3Nr9CFDUNOJcKZfrb87H5/iGD5iOyfJI1YRfGXLHzfZv4uEi?=
 =?us-ascii?Q?ljWAcnqNe4tWG7gbAIQAN185TASZMsC7sSsKwVs/gpQfe7MOKktTmiT61Jrc?=
 =?us-ascii?Q?Zkxk/nAX/TbSGY1YUMokEeNr+MM+mh4Tfdf5c4t9Y4ZJxS/N2ZDMquUzc4Dt?=
 =?us-ascii?Q?LPJThOcxWiZesQ48R/xJWigXez5FKQ3j5bESWb0vQaRtWiy7mlpQ2Cv+1wqz?=
 =?us-ascii?Q?sz0RqsSyfIo6bZSjXOD49QtnJci671LcR8rG7V8awRutKEgpus/iREmeGPuT?=
 =?us-ascii?Q?vz0RLebdA0+2pOBlBgckO773g/2sASJ6srzirF3FeWhRmZmaF2CoN8aIeV4A?=
 =?us-ascii?Q?JoW8heXI0R5n2XnXFz0C2B8F+AzMIE4DV2S5Wp0qkDYwnLSBP9YDM1rnUdMo?=
 =?us-ascii?Q?sx/QJHTMxM0QwOnkBzF/RmjxX+lQFiBJouuPwR/chFjkcXa59G/waLrsUWrN?=
 =?us-ascii?Q?BXXJvgWKtwUI+56t9YwaDwAcAYLUSR1r/ebkeVfbY3J2Y4HC1IbS9BxRriEi?=
 =?us-ascii?Q?LHrrCGGyY+MUVP9YSzad49EfTnu4hCNV7ZcnATyYLwWQqZxa8w5y5Spd23LS?=
 =?us-ascii?Q?6heTAyZBR6MbpCn5cb8yUxLDd9bTnojXdu/nmQ08jlrRpO58jfuoSpm75zcy?=
 =?us-ascii?Q?tLJ5LD2Asg+mpjA17YYNeSonp17Ib4uATvmZf1WicUbZzJ+hYRiE1qEvgHVx?=
 =?us-ascii?Q?84KG318HomFTV8Jkd+HohfgTg1/CLOrDr0N8uKGuGlDrzC8I0LKys7k7zFOt?=
 =?us-ascii?Q?GJFsmX5j8lWSLGPBq5+0WERfMEkyQod0fKSJBY5lfBCQHeUurudfWhBV1mJT?=
 =?us-ascii?Q?zCnTmvEYphe0LpQxwuFb1PJDYZfcDXOkAXExn5WEqMHoJcZcslkgQVCPG00K?=
 =?us-ascii?Q?ImuaimNwsImcgthcpfjjN/kc/F/cSdAZgCdT10J/lF4Mq/1B0zpBGwxHysxm?=
 =?us-ascii?Q?OQ8ztnbwfPXaLJ3DJ/yZwRO+phrgMcqarU9L7UN+PW+FOl57Ttt0dNotKxS0?=
 =?us-ascii?Q?8dmNa07rZz1ah8I3W0rNcJ4HHD9sCSGZao7XtwKIoJZRC7bRubiem/NlSX4c?=
 =?us-ascii?Q?5I22ip48FmKD7y58k3PRmzKCY9cojvIQIXIj27xwvDND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wXEVCwE5G65V5ea9XVobcnqvXvKtM4WHihUiLQocP3gVVYDzLgXL8ma9+Dg?=
 =?us-ascii?Q?7gotGrYSnkV8fqDEKlcH2UQlnZqOSSnylNBSr1rh+odJADopedEakQZjrz0L?=
 =?us-ascii?Q?3Wl/b1wmxrS0ASB3Jes89jEfVemTozu29RkcMkUSxwz0mIOulO7Ffd8/poNu?=
 =?us-ascii?Q?02ZLfMZjqpUOkm0IANLrYe2iROmBmLf91Meo7w8TrqmM0X5+5mjMAgY4d83D?=
 =?us-ascii?Q?WY/GmbHJaHblcK7iirvtu9IifSNNmQQePy+0Vv/DZDj+yY3V6ujIxuCHl9kq?=
 =?us-ascii?Q?GVpT5hrE/jSx/eFxZoU0CVtAg8RMDD44urzn4NOmE0ftUvrFgzLIaDyrChDH?=
 =?us-ascii?Q?SqmPuW4+iUU36C2iHJOcIkIdpAYmUx2A32dakmGYkWandHxG6+iIPLSOXPsc?=
 =?us-ascii?Q?fXDm7t1tOsxGQ5k2znfMNnbS6Il1oVorNO/W7uYwrujJ0v1GvMrNEyyg6+u0?=
 =?us-ascii?Q?8Qx8Y/bJl6vSfFZsdCYNoqP6c738EWgyeVq0c3G0dkkZPxK4uGJ56MbVXG0s?=
 =?us-ascii?Q?ZBiIWGZW9ctQxyVwCP/GAcQGNngUuOs9SsEGUgCMfJpDch34G+viAMCfEMTa?=
 =?us-ascii?Q?NttuKGdBSFirCYaGCn5ZWCV91OoOoIIkHNRyDgK5WJd4fh0a5GSxIW/khoDH?=
 =?us-ascii?Q?Gmdkspn7dbG6LsMdRS4ovZtIsFofo14W8hZHDUGffIwd4n0plQTe7MS8iQtx?=
 =?us-ascii?Q?vJf8iWYpfzHHVdQxKINIZ2+ef3LSeDLPLXKMdwPgPiv5Pv6bQoYxjEQa8OPU?=
 =?us-ascii?Q?ooNbzPtnz8hSOfHWhIkAfAbZRtGGo1DRM4hi4PTJO6efShE6FKmXUlbxHtHV?=
 =?us-ascii?Q?7+FRjtGbv2M4GpjWpA7D6KSuBNWAgL97IybK2X2f+BwMHLqRmS0Rfr29ANbQ?=
 =?us-ascii?Q?cWZzUhxUBxvsLvOrept+dlnpccU1224xci3yffLOD+qCg7i3OncIO3YbziDh?=
 =?us-ascii?Q?j9LYzRMIgWa5EA+cB+p6tXOCsAbt6c8YJCe3U2X2HAS0Fp++CGVJQciVm+pb?=
 =?us-ascii?Q?z5IXjPKVJ5PHLC71Lz7NywUsEFiP8w0i/VYaa3MTVxqrz3eEl5iUeQXAsdAL?=
 =?us-ascii?Q?3dUDAwZ3T+9ZoUnhh0rKfsH+LRrEWqU2AoV/YlNgAMZAmJK2q52vfXGQJaJu?=
 =?us-ascii?Q?14t5RlFnKtt/WIGHpM50QiCyuaZ5d3ZmI4svLnhXnFDgnMIxPIjo6QePnUWL?=
 =?us-ascii?Q?jOog1rKDUxTZ1LDrZuImYJkS/Zh141QvZqL0Q5bckG6B3RTIB2heMsTs9APt?=
 =?us-ascii?Q?IOy1/xtK+y9CUC6bpsZogW1xm3LrY8IiTKYqttfAzm3qj2muqXo8Zj574OFM?=
 =?us-ascii?Q?48RctrCpKLytT3htNof8Xb656L7uOCZQbPIhIQ91BpdS3LClF0S4GrwuJio9?=
 =?us-ascii?Q?XlkQem63eG2rgSrdGtilBnonzBc3uP8jK5o19NEdR0qS9kT7S+qYWthVMUuc?=
 =?us-ascii?Q?4ia3yXqi5uaN738SS5AqREddBPO4eJfFodxRke2e0H84M+TgIuT9ikDOhq12?=
 =?us-ascii?Q?DCGOQJp7ADTRWGmp9ZBmFY0XFxxAlHBh/g1r9VrSpRYRGtxqlKRRKy4tRvRp?=
 =?us-ascii?Q?iFt/7eRk1DExJC2noqYqHo0wgLWoWGFWCgla9g4OVAnJ3S0UFBgrrj5PEej4?=
 =?us-ascii?Q?3FGuzQsU8FEcO330NwUm0sy+I1eYKN983rNBpCg1IgQt54IdjH2jy8Fb74xW?=
 =?us-ascii?Q?JrsW0TSAiINGQ26wi5qmAtlVFRoCNkVbb+0sQt0wqBShXYu5Gafqrki3mNWO?=
 =?us-ascii?Q?LzuBt+Myvw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13512e7e-deb7-4202-baa2-08de649471f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:26.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWjOUYkW7PQkWKoghz0yLSojrXEpvcE+W/j6xDiop07cltUKepwt3Bn1pum10+T8f3+90oNRWn+zdndV9AWkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257055-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8EDC3F024D
X-Rspamd-Action: no action

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ce433af02ad2..ee4a20d8c438 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1747,6 +1747,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
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
@@ -1807,29 +1842,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
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


