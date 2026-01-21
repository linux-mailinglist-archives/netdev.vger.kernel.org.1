Return-Path: <netdev+bounces-251757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC8vEeFKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:41:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEC5081E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3D175C4335
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288ED3933E6;
	Wed, 21 Jan 2026 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SwYi8HLc"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45738A9BD;
	Wed, 21 Jan 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966516; cv=fail; b=oBQovZjv38t5Xs8DEp6AmLXYlRMaiO8CMEbbb7RBSUvMLUy7L/DRMpZ4w21eXzq3Cdr7EjPJ3xlPcPnBySMAi2yNUedJ7xj17k+0/m/0W6O0y6al+KBOy7YNlu90h/8q/BjsXRq6hIWCqGgWDIx6ueR/MLK6oLX+7g88JEy0290=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966516; c=relaxed/simple;
	bh=Kzrp+uOuPOsEh6YhVC26qHFs8IsCtq6+uJkjvxusBnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlfdHL6fpiFHh+gfTmo599MSX15wSFFdBf4bZ0W/hCYNnty0vCWvdNHMBviOEboCBzCnV2e/lViql2rfP7JEboW4V2gpIDj/MNO2wTv2dxdciJcdumY9FDBOye2yeXeikk3la1MNS7Wce4WhMqmvW4DueDAvWCpwyDCTRkxO5Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SwYi8HLc; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxJL631Dz/Ujtx5CwkMGdFT604aKZ+8WzKTs8dMXJw+chnUjNQuZrSXhfN3psbpVDI8RMgeXmX1vzjlI6nV5Tvvr8qSWSOqvXHElkEg7ICi4gQuoYYls8GPRX+5s9PA1lN0KTDZf+AVF47HNXJBnaOL8VK4ACEqHtRsMECyzG06pqXK6j0yrCLhfLg1otRGSPriYmEjAELB8QhPziiJcDPMF4dvYAtNRRqtRdcVF6QuKjS3h+8UyAmkbcUH3mdILKG1HK/U88YfAEvZn42IVtYhS6tGtBngKuYnoo33s1JNm1+1gomgt2VF82ZkLIIXhsvAlLaVbYmF8utPt86s6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGIJdqcez2/aA+VVLyyCHzwuWEuNTrNJGO6QDi8vVC4=;
 b=fEdk8q1Qpaa7YPXrVIPrldQtvivPN5IIo/VryegCKWT3SxtZB5o5Rjad1TEWAWY0NHAcS3ewMiGh45Y6hG/DICp/73vTurXZhtLkl1A9m8wCojmCcGQEsIRGwhYOt4WK6g0g9Od8ntosOIrmlSFWmyYTjra+EbpHzjFxLqcTPuNM+gSeQNJZ8btIzwDLOlUFh0kAB2Df9PwsslqGxN9BmBRaCU0sMM6xtNGKVc8e9OXeUxL7Sj7//BQxV8DR6CTjhGBu5itcnugE6d8i2lQABT/YwkweN8rDI8iK3Ad84AdvEtxn0kfWgO9Z8L5mAFaO0h8BgZzcjycGo/Cn3l69oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGIJdqcez2/aA+VVLyyCHzwuWEuNTrNJGO6QDi8vVC4=;
 b=SwYi8HLcGD/ppXwbHEPWctAkP2pEEAYVc8sYc0eXRVaL4/qdWX3hUwNCf2UpRkGO6QXgG89p5n76e4bMwtcGmpluU9Ef3rPyIn/4Dp1LroHlHvisEcAVJm8qKQ7xUl2FpaSPaRXtzJckgwipVE6db75Tij0YzizmOHqqixVQX+9xYUTt70lG5pM/1JjcF7FJUqRKPC21qaaAKLrPTS1TDOvIq8tBWFLn9dpXxx0nj9oefF4+j0jSsT/z8jI3FoVyvofVUQONhDmmM60sJ2pjZoXC2Ii1rY6Ayb++KDKmLVj8w2C6OSt4qzofPsuERIjPumf+lWCc0UyJXPFvfacIdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:11 +0000
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
Subject: [PATCH v3 net-next 11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Wed, 21 Jan 2026 11:33:53 +0800
Message-Id: <20260121033357.3261464-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7308760c-40c8-4f46-e16e-08de589e14bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XULIp735u/PGRr/gcP787pKry0smanQ16f6BWd2zwi0rli2iHd3WObuo9Gc?=
 =?us-ascii?Q?S4/4GPDoFpL4MfiMabK5bmdryf9ASyjpnJikwrS+VTAMzUFTeEe0wI321HXW?=
 =?us-ascii?Q?/tgWAbz+zev6clVzkKmd2yz1u8mMtoVlChC8JLo/V+e1CnMl91XOvqBftZGQ?=
 =?us-ascii?Q?vNmbsOis+KrEb4K8cJ7vdXSAUZtmGH6tJgpzHXTuDhTzdOoERPQ1oCegNNhq?=
 =?us-ascii?Q?4aKe0FmmhjMWl+S+fTe4+rQgBwZrRk+snQCbYbCzAiFm6hyw/80wF2GFIIMR?=
 =?us-ascii?Q?oNG2KeHwgeOSBGcwrSb+VlG9XBpxsH7IU1AU0+U35738+goFwOaeT5+iF/2Q?=
 =?us-ascii?Q?u4cbSTC/m+6mec1VNdZkeMLpzF8AfjE9IuN+ZhntNEQ87zUe0qqnlhRR9Bdm?=
 =?us-ascii?Q?GMZMPBKpvCoAsxl539gg0E8Tm+FXJv2WAnWdpF4XNiZ36I3yKyPXh3s3lUDW?=
 =?us-ascii?Q?IqgNlRmJoPDtFIe+ehViW4sTxehMjam0Pr8cPuBSOe9lQStQh+AZm87ly4nH?=
 =?us-ascii?Q?SNMqxWLQq/iacXsTBgZowCzhq0HppjkQHbnWyJLVnZiN/jRakQU95sPfLxe7?=
 =?us-ascii?Q?/PoBElv5FbJR1iK8q8wBeSQ23WZDVXAVgXDxNDqKxo+XE1qyc2tmBQlYPnbd?=
 =?us-ascii?Q?7arlnjAzO5SIuUWqeCM2El2jO4Vf5tOaDTsXV/cJNTRnYw91Oux9c3RoQ5aZ?=
 =?us-ascii?Q?s9rJsj/4OTxVTWFWZ5gk9l1yaFfwmEty1m46RMF6/Wrb9zTPEm0D7LCAPIcL?=
 =?us-ascii?Q?jD+Jz6B9bA11XZGlWZgiNpFlG9cRpScGMpfaB+2JO7zu1EjNG8/1cNy921fM?=
 =?us-ascii?Q?ezIcaHjUU/RwT+7P69KwP65EivKVJz/UMXUOPW8Xr0JPRonUN77bbkEuDRym?=
 =?us-ascii?Q?bctRHKJckf/8EsTlwDWcug1E9iAJbdrTyvDy1ToJkZgaozSWksYK6cy/Y1/j?=
 =?us-ascii?Q?q0rtgSJUnPigFepNwKzMLbCJ1ts3X/chGobvpI5gJPewnrVkgcuxMucABSI1?=
 =?us-ascii?Q?TGlM/GuMhRjQ0YI/37rAoNolvXcy02bO7+7IYy/eTJwrXQdj5TsaJClKR+uV?=
 =?us-ascii?Q?uxFMHYjRyt2QWaFPPlTd1d/YII/d2/TzgEpzzl757fUYH8VxtQcSMfbXvS3b?=
 =?us-ascii?Q?vGRLOUT0QFprCKbY4OnMV8ywTj0H6Hl+G4+Bi00dnHDXKlJKPaEwzne3Ia7D?=
 =?us-ascii?Q?+0IdhTzXTRntQ+YU/LLV/7uGZLC/IMoXOrQAfaEwVFE5Y+NxWpDNyfrIV4kO?=
 =?us-ascii?Q?FFEpUrhGw+R/c1VSrKB9oSesyu0hB78G/lZkX1nND0cGU88Q/Bw0xIpFRnEg?=
 =?us-ascii?Q?mnkQoJ5C7qFdV7vLEITgFtaZi07+CVFQAqYHg5hYYEyqL3rviQJTBXR0hi+8?=
 =?us-ascii?Q?VbqwSWExOaLvPpa7hSR4OWpAcawVKI3m1qR1st0IQX4z+qFSV0InV82d5TYn?=
 =?us-ascii?Q?aJGiFFT24KL6fB1BNs+dOQ11tf+My6zS+dqxTJ2CAmBbwaQTZ8iKJXvQOZ6T?=
 =?us-ascii?Q?OPSCbB4/lwEHF8DeHO0viIcKBoZp8gIuAEbm/pv+j6CD9n9efauzeLx+xdgi?=
 =?us-ascii?Q?ktPF7ZAl+duUwkpfhf/u0TfN0OvH3NBongFcHyP71ZZp8Vj+JjRQI1BUBmhH?=
 =?us-ascii?Q?ms+pmBQbhUSTXXpTmrOIHgdJmFbeKzC0DgJsWYHkZWQJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f2eXKJqSxajUjEMEblwjfX+andif+aCqZjo6pYHaaCCe/+3UeTQcmM0IDOZ+?=
 =?us-ascii?Q?BqMgEWUJStfn9zDF34u8ztxLKLo079KBiI/AUro3bBB5qx5QXKo6KO/CU6PI?=
 =?us-ascii?Q?MDD60dm8Agmm4Nzr9PMO4mfRQeR94ulDFpTJ3xcGqrTM/Nsm5fmDXm1g5OLu?=
 =?us-ascii?Q?zz6SO0tcWKHUGnctdx+ZFton2Pt0BW9tg8T5UAeCDzQdtR1UWa//vMmrkf/4?=
 =?us-ascii?Q?tDfbj8AUpQFY5y7oAq+sDYYhWSRMuQ4urI6x+6gv0gkNRbmvnpn2YYhCjvl1?=
 =?us-ascii?Q?aK3b9jzv4ai95FxDtbdFZeFXcbdWTDxNdq6YZk4yRHr+UG/QQ//UVnbE/OaZ?=
 =?us-ascii?Q?x/6EMUnR8edKYzrLFVdjo17qLyJxisNsZw1Tlomaa1G8Jtz6AlFM7pF+sg+y?=
 =?us-ascii?Q?cKNKPaMAdeqxdKKlJxauwzSjJHIKNGsv5Bvzi0UTSgYrAZNbpO9kBaDavOh9?=
 =?us-ascii?Q?SMUYe7vfHSKxutmxa6/D3ko/9hRCK4OH0g7PCpQSUFokbkWV3zVewbPSXeIE?=
 =?us-ascii?Q?alN9Jfarq46xsmOo0zI9jTC4aB/Z/8S8p7Td5bXlcn24WvCsErQK3BrO0A+C?=
 =?us-ascii?Q?gRiGnzv99kUJZgdlTFQL/W3NSWN+NF1SwResZ1bTTMhJkYBmQW+yL+B/qrpC?=
 =?us-ascii?Q?5+Vhhxrq/JOIBtBeF4i2WBqhPTaMTXSAgQKr/SpIMY/PLUpw4XYVhxWz+9Zz?=
 =?us-ascii?Q?Xk53wI8t79N5EsvCtDnNrlUQ7QI17A/c/USDLVHm+CHe/ebeSft7F9PG712y?=
 =?us-ascii?Q?QTg+G1hvROrlfhAJCCjRBBU4TZPIp0H+mvCTzcIwpGr4tRo1JMWYwaFgk9B1?=
 =?us-ascii?Q?cJI48UX15cAGC/85rTSgrpRuf/01iytdfDez0GAELpQAiQ0ZrOwrFsMFMcoq?=
 =?us-ascii?Q?DQitquxfZ7fprrxl3ZfFX9bBGJN2S28GYSgaDT2q7gderk3xnbtSRPW64jXf?=
 =?us-ascii?Q?rdeQSinN+Utz8icbgq9bHnzYfKUV7htTZxCFhLE2bpncNOLzCnwjSCGYlO4l?=
 =?us-ascii?Q?CLtWmm1i2/mWlFd7/ggsNJPQOjo99Z49Q45oKvO8Cx6P/pYRkNSTqFkVWXX4?=
 =?us-ascii?Q?QVISXVCTx4S8e1AvdZ/eI8MS0RcxEB/uwIk0F3jQh7FQWRxE4V+vQaWbg0pq?=
 =?us-ascii?Q?RnqFRZulAFLyCHL1f8J2+MrREJbyrTNOdCZ23/91T4m4p9mFb4TVdcbLOIAp?=
 =?us-ascii?Q?ZAMBaJS5bCqqZ+IsCkd3ejQes9cI6XENzGxiXWkrHNFIWhCkq80SKFpI63eX?=
 =?us-ascii?Q?8/djNgnUIfaT6PmBCMIxb1SYgSiM2UFAkYUByBPJ8wZxG88n6co3eQzWmsmy?=
 =?us-ascii?Q?1qKuAam407NJ6bcSe1K04eqxGNldkfPC4mnnFhj5I8MpukI43XucD9Mly2Hw?=
 =?us-ascii?Q?izzlpPuxknVO4qoedSk8PWINk1QcQg0yJbvwvvWYMjUXgtf9zp33DnRwMIUE?=
 =?us-ascii?Q?9xIT7OH6TrNeRndYE+Nu6AdtgqtwayRruHJeZcYkjUR7I6OHA1k71VT3dLQC?=
 =?us-ascii?Q?XNzCItj00C8lAwxcNsX0So9VmdhjGGoPv8kS5PRy9cVzEedzFtBFFDkoO3gE?=
 =?us-ascii?Q?MvK7aGYtLT7WynM8gQLUfgDPvKNBzH9fP+1eu6yhIJDCfplva/RiuW3d357Z?=
 =?us-ascii?Q?EjIwlUD0keYf/ouiZW5nMmChJut901UCa9rfu+/ZA/MVZHa1x1lZet1YekHC?=
 =?us-ascii?Q?CLgiwuljQjdn1KPJSRxQSc/f8+gnr8239DsIUVmsQW31KbaxqNHRXSVcDnZj?=
 =?us-ascii?Q?EHt9s1hhWA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7308760c-40c8-4f46-e16e-08de589e14bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:11.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFYIQw4O52CCWgX+Hmydx/gAsgyEYYKnErNqLzVQ7DxpWC69h3aVTJKwAixp+QNb9AZ6T7HpcQHK0DOlOoGhlg==
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
	TAGGED_FROM(0.00)[bounces-251757-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 25FEC5081E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the size parameter from fec_enet_create_page_pool(), since
rxq->bd.ring_size already contains this information.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1c3fbb6443bd..742786a4010f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -467,13 +467,13 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 
 static int
 fec_enet_create_page_pool(struct fec_enet_private *fep,
-			  struct fec_enet_priv_rx_q *rxq, int size)
+			  struct fec_enet_priv_rx_q *rxq)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
 		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.pool_size = size,
+		.pool_size = rxq->bd.ring_size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
@@ -3552,7 +3552,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 
-	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
+	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
 		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
 		return err;
-- 
2.34.1


