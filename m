Return-Path: <netdev+bounces-142897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A99C0ACE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF5E1C22D3B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65369215F4D;
	Thu,  7 Nov 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="jXlXCRS7"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C834215F74
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995522; cv=fail; b=RM/JVMmexHHTrfkrEcD55RWM+md08Ou/FWoCSeVi2RUMr7GAenfQUvIJF06BgY+RXLAX6UKSsnjWKct2frORTDjbl8K3LSMlUJb/Q6wmxYleIxMTmX4gHJolsabzJQSrctQeo6bVOhqk/qZU/0HxrPng95YtpDD2ulf8bpExhM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995522; c=relaxed/simple;
	bh=vha8sFkkE1jBaPBpgiv5yQBlWzP/+qr1zQEzN+mSacI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiXCtpco7L0WIX+eoIZ82wQR7ovwU/0WQpIpVPySn6OZEQPjz93D32bKcVRE1/uOW3uRXzMgbD70hB5c0VAS5XYnIJJzoCXkmAOqDALCMkq2U9qxYc7DI+djl8J61wEWYRaaM4llxn9yIWKXv1/bkJHGCB5qPpVcLJswpFRX8O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=jXlXCRS7; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AB8EE480057;
	Thu,  7 Nov 2024 16:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW31m4eV+egM9GQkzcrarJ9SMzjcNpuYBC2rm+FuBpyK+Bo56AIg+bHVyUlerqyuj3oUprP1WGaA26fOKspjhqhpsfoOEVAUlxSD3xWC8oo9QdOoNp+EPXFOtkx+EzcaN2edkNTHJYHlZq+tBmDEmWcwNBKe04sKt2sUv4Rf67JIQ5wIMjmkMzaE7XLyreHwigDNOK07otdXJW9EvInK/XZld6/FD3YJ7p7r7l/kaXNLyXjlWcfsUMAU35UNL18NivAx7bzPSZ2wzWOLMsheAq1hufjJ7EyVpmancKg4L1zT0rOh/G5UBU7oQJ/2a1ciJo8JEOYfXp47uulAy2tGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu6nyI9AYIjPx4yrevqVlnreiSklbmXgVOtC88UMn0Q=;
 b=yHSR0SJRYMfrLyDBqk41C0y5OaNJSPz92nyMguKFv7W/K7375V//In2fPpuG7j2rDEGQL6fMo0dbZ1rgrGwjd6xfUWCJqxpzMIin1nSUrxq8NNQYUe2Byvf1QqLcyyNh6ZjIKEJYYA2OvmqS+7MPjAd0jDjVMoFnwYWJWY48KTRZ1078cP0Cu71HenkJjhEFTb1KPF/SATtpwNCUtAnvfvx61u/cequcGExKCd1uuAfN0NcQpO1qGIRFWEIX3pDJV/dt1nySB9eh1VV2b+Vzd9+nAThbTZSTMRtEcW0QZfuswnib0f4fzM0OvGI+3WztBU1E3H2p0tn0zsTtYzN5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu6nyI9AYIjPx4yrevqVlnreiSklbmXgVOtC88UMn0Q=;
 b=jXlXCRS7RaR8R5nArLHDVIbh1krx9bVg7v+TLQ3BZ7A44kmaT70k9iD0OEZugnnu5OlANZvJa4ml7DBabN1OYX94TKb4GbX0jesPgpD9yLXUD2g3BaE+UGBCncStb+fosUxVo9xkML9t4sLbEp724bBypfOA3fn8x1sh8QDBnL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:08 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:05:08 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 6/6] neighbour: Create netdev->neighbour association
Date: Thu,  7 Nov 2024 16:04:43 +0000
Message-Id: <20241107160444.2913124-7-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107160444.2913124-1-gnaaman@drivenets.com>
References: <20241107160444.2913124-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: cc73fb05-7cac-44a1-bd54-08dcff45f3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUNMc5BcpetLetl07clXyrxZ0NQ5dvROkuIJZeMOmL8q7HuGpnirQKDbGMj4?=
 =?us-ascii?Q?L3qfUqmaigDXWmr7xglBuU8XkZT8kj01XlrwN+sNoAHdisBR09K+EEIhtHgM?=
 =?us-ascii?Q?4BTMhdBMGW5L0fqolsCb5sPZ+aJwI/AAAdgz0Hpd8yqT0LBcQ5Ex52t/Peck?=
 =?us-ascii?Q?2u9k924l/kwmDWAxHuMmr8Lw88ZfL81h3X8I0o4oL5I/0aownf8O/JJSRNtb?=
 =?us-ascii?Q?i5xnu7biYuBYC/0MGI8rdJsCEFLKrGzRq5HA9BiRTijHeHiBdEq6m7AayplW?=
 =?us-ascii?Q?g3YHocTmiqnFiRio698UQZs6SWX0qQf0kgT4bqc5F/JgeUFvVdYHARPrw3sv?=
 =?us-ascii?Q?tlSek6T8mK+QrGuLqHZAqgshFVCoVuyLOsPwTva14g0w5vwjDvhtwbqLM8yJ?=
 =?us-ascii?Q?Bhoz6sTIK8RIGkUuzr3f2fPdNHjs7Hf48kyQvKpPE/Iy6dcJV7M7lUpTNWgQ?=
 =?us-ascii?Q?ijdFQ1e1K+hHbN/cEOCYu8tyhL+2+5ZV3aowQ5N/2H53fmielI19imcd6ELx?=
 =?us-ascii?Q?NVIvBGVrFQeuS+pMWQkgRPYGv27haK+7Bep2S3jA2021Vf6gfSoAbQc8sX5P?=
 =?us-ascii?Q?F2bfIQI0HGJA1n0bpFa7O5yG5rFr7t+GYILgtMJAjfOu9UnOAnSpTarOUsH4?=
 =?us-ascii?Q?SqOQzmAdk17VGFNbq52mF/bjCASa1xDSL2WjZ2c3WumuLBFYgcsEY0zDX/Yl?=
 =?us-ascii?Q?B5Mg2xlFbLvZNq+hToZsHJEZtdMvnInTSwONk3D3d+2GnunkPPgW7x/d7qV9?=
 =?us-ascii?Q?NQpvC0WNm+oUN2vZI25uE34KXT6al6QA6f/5txdl8aIBOy9S7PLK77MLXAp2?=
 =?us-ascii?Q?z7z2nkFSsx07TXCVHCR20sF3FSC1M9xxSFQ+NQagn1sFL0p3fwnF+9aLOHyJ?=
 =?us-ascii?Q?ZUt7Lmd3bpwpqDJpQn4kCPazpK8sShW4cnouWa3M1XF4BLo1FBm2cDEIHvlx?=
 =?us-ascii?Q?3RFJkkh5D+uy17Xpf8l3y/HYCXvsR8vW6c2HlwNaQJB0G9TgbWmNLEMKImuC?=
 =?us-ascii?Q?VPmg9olFNkztG2MH2hmGiLAJuOCvaR1WIEG80ZWtfRQhJdTLt6CkiD5517Mc?=
 =?us-ascii?Q?Fo5YBJjCc8K62BeTdh4ReyRsD3unQSUXNJQ1CXqOPTcMRzUh25azeDC9lVOa?=
 =?us-ascii?Q?1XFIotfKVcsRy/FZB0YT7pQe81oJi8MXRWQnXcC0scXwNYH2ZcShxpixGXlX?=
 =?us-ascii?Q?lhQLxOueOxmV6717dGsw9ELWBGWH712f2kr7MfYhJgJb3JzpDlUuRezLunQH?=
 =?us-ascii?Q?c4jZ2scPq8oHAo3WVSiVx3dz8D7PtIw55RIfvKlckbRSptaSpTu2rXDMZT/v?=
 =?us-ascii?Q?BGWsXHp+qhdPaFP0iLQ8wSnzyZTgebXIEU8kLhnX9Rfdg4T3kuuNA2dgbrrb?=
 =?us-ascii?Q?wJZazb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+oDI0sm1MQT04jLBOAKhfXV7bXtlt8uOKMsgTd4ctQ3EKi1l9FEs6fwhq9t?=
 =?us-ascii?Q?3ZzpTYt69ZbHFriiF9ysoUqNU64Ao43py0c4oxEuTgXmBbIYyZhH3asv0AY/?=
 =?us-ascii?Q?w0y+beuUrxE53K/VNjSaVXY5hSZbEiPLC+aZ7B9s+86OsG7b0KWFKxtnM/zD?=
 =?us-ascii?Q?3Q4yiFBntQ90CZjqFN/tUVLrMAUpP51ATi/U23vT0iaWpjTCyg3zwvOIvcEd?=
 =?us-ascii?Q?pjkbxVXpT3hCxU4CUpPHie3wd1x5F+UDoOeM+FoN5iFoj3dyemSqvfcjHzCv?=
 =?us-ascii?Q?BEwWiA28dG4dDJzZMrpe2Gf4tziaPIGa8V4AzAaSxASA0RfNRPnUB0mnVUjm?=
 =?us-ascii?Q?bCDjjQByyMiCBNSRUgxOMCJCzsUOgclQjKm6kPMYKtUHShhhvG2EuTId8PEe?=
 =?us-ascii?Q?/cz7F2/LdkXr/tFwST2/RzcIyEBUpADONSa7K4+ptrQKcdm376RmVu/jore/?=
 =?us-ascii?Q?CqDZy7GaPNaXraJo0QvMT9gaIdkg/+8ZSHsTY8J4AhQvCSUmkYAPPBg4rOPF?=
 =?us-ascii?Q?qQC4L1DYETajcti1w1vnQ2yBXCGMe4gr/O6KWcJamgNmTYWrY1erbhAcBDK2?=
 =?us-ascii?Q?jiwOglWjfmssRNVL4BYJ7sE5W+7Bv9y1SH7+OQKrLYsXoz4RDvtQuxfzYDex?=
 =?us-ascii?Q?uzabOJPAC6lVZwGyHawrxrAiYM4IjTtxx2jx2MLR/Pu5ZCoKMRW+R44Xupn3?=
 =?us-ascii?Q?OteyJ2XxQOcBXdWFdx3KHlfUAadeRXF244X7obE8FDVDG4JAcSy3JSw6VaH9?=
 =?us-ascii?Q?UDGwgCAV0Pw9T9y5SVh252DKDEoJJHm704yhZBgMH82dcingd14kpH21PP7+?=
 =?us-ascii?Q?k2iXX6dbbTPGEmKqKyHa/gG9VVusOLydyavR8LJPurOnZ41rW2eJFuw0eAtL?=
 =?us-ascii?Q?jHda6EBywhAhz97ymdxH3lAW3ipMTFrp4cptOi0AqC0TR4BqaS9vPT9LfZNw?=
 =?us-ascii?Q?gxpbibLQLQrB5ET0UqMwRMx+YNJvnqFQhFnv8Z04TGilxZBaAfDRBZElfnOT?=
 =?us-ascii?Q?QRtrr6X9SYluUzUp6WGU8kbLkpVpxG3E5HatbFYEBiPFCx1brtUHkKY5xXOs?=
 =?us-ascii?Q?PMPLGhfcSLUbLpwbSPfmHGO5IJx2hn1dgSFbdvO0fl2whND8g7uV+mYgW7NI?=
 =?us-ascii?Q?CubghrtD2nW2CwNUAJru/ASJ2dw4yatUFsQr/3TXXuvihKOPt+pgN1NA3Kc5?=
 =?us-ascii?Q?ql3zqwJy3OyTHgzHLke4uKxUfOXkvYCgHWXPwyeL1OCHEdL0aIIVWyymHIPT?=
 =?us-ascii?Q?yT6abgy030M5WoC7zvSQMb5/NT2MTghg4jFqt9zRm9f5noGQBl1iUOc4hsT9?=
 =?us-ascii?Q?0vIaQVYajx1eBNVQJllym5UJLr/FGIeFVTHnyYklYnz9GBHT1BSdEING0AxE?=
 =?us-ascii?Q?3fZ89I2sUuDZCfa6l7yT4o5CqmmlRE8syzVTkflx/V7LttSOgKqNs1kR8YPg?=
 =?us-ascii?Q?+JS90+kT/Khl8u1t+WCiAy6j54G/0WpDtNAB7owe4XewZQIK/qqbYSYWsGyX?=
 =?us-ascii?Q?fJFa+UBYDVLDFiTItos1LhPHka9MvQmD5VZu0bv7fp8H4Py2Ifu8wKKlOHV2?=
 =?us-ascii?Q?iCIr7ntaPcZ5fCE4uzcUfiN/OB8bUwaOK/XI6vUR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MfUvZpBhNWebyomgLSZzIMazJcEOJChg5lZoGU2/PaRLhwXB0Yp007P8tri2ykDk4W0VPZAuo8JHvb5pnoDUTuPcKqAQKH6hbG3RUJ1wpXlOCJjYRUrUSSZ8e3L3uyl2q9lcgtlcbB3XtpxCy1Q9Ywg7NXnXC6nkcGLYgeXJj4LGmMmPZmRAqtPJYhAGK3rytO9Cf4UQ0ujhTEzddNZ5mPuc0qFfmvpcymtu9r7hMe7uirTXLH089SIkhlSEsmdELXBXrB+fvF13A4dnWfV0mtLFuae3zeKMagROrUkZbrzt6/ahUqGv514JCmd0avlgfjlc4ndxA0E9n9zO5iCS1DHftGGwFRwSmIyuY2M7R+VGmcO2lKESWUj8HnD2vShpTr4VkrIRaeebyFrr0pQ2/9ClEeHgkUED4NajdSTCmIb4wWLpO80tJKRV+7T2haqsvj4TuIYOyg5XAMJJs69byF3uErpymTYixxBL7Qpf2wAUJlCDDpyWZRFxzhggTNBwNlXn4llAWHDx0yktwDyVRrFtlUb+cMBwmWtK9xOofzI3vaWp7U5N/NNALsv0EuFi8I6jaHHKzfheOIKk28hqgw9gMSMzm3r0YtZ1V9B7/7W1Cm6cytqFe5XMCZTAicLE
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc73fb05-7cac-44a1-bd54-08dcff45f3c3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:08.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlHj8/E+GcI6Q2NW7X/q2F0iFwj+tq5nfL1MGfOkNvNfbjDvE02zk9ZHsyll+PMkPdnpDpp6M2n2vrnloNAf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995511-e50j2hFpCRx6
X-MDID-O:
 eu1;ams;1730995511;e50j2hFpCRx6;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       |  9 +-
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 96 +++++++++++--------
 5 files changed, 80 insertions(+), 45 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index ade50d4e67cf..15e31ece675f 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -188,4 +188,5 @@ u64                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct hlist_head                   neighbours[2]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c552b648b27..df4483598628 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2032,6 +2033,9 @@ enum netdev_reg_state {
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2440,6 +2444,9 @@ struct net_device {
 	 */
 	struct net_shaper_hierarchy *net_shaper_hierarchy;
 #endif
+
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 40aac1e24c68..9a832cab5b1d 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	hash;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,13 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..bcffbe8f7601
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 59f359c7b5e3..5e572f6eaf2c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -60,6 +60,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
+{
+	int i;
+
+	switch (family) {
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		fallthrough; /* to avoid panic by null-ptr-deref */
+	case AF_INET:
+		i = NEIGH_ARP_TABLE;
+		break;
+	case AF_INET6:
+		i = NEIGH_ND_TABLE;
+		break;
+	}
+
+	return &dev->neighbours[i];
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -211,6 +230,7 @@ bool neigh_remove_one(struct neighbour *n)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -351,48 +371,42 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
-	int i;
-	struct neigh_hash_table *nht;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
+	struct hlist_head *dev_head;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
+	dev_head = neigh_get_dev_table(dev, tbl->family);
 
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
 
-			hlist_del_rcu(&n->hash);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
+		write_lock(&n->lock);
+		neigh_del_timer(n);
+		neigh_mark_dead(n);
+		if (refcount_read(&n->refcnt) != 1) {
+			/* The most unpleasant situation.
+			 * We must destroy neighbour entry,
+			 * but someone still uses it.
+			 *
+			 * The destroy will be delayed until
+			 * the last user releases us, but
+			 * we must kill timers etc. and move
+			 * it to safe state.
+			 */
+			__skb_queue_purge(&n->arp_queue);
+			n->arp_queue_len_bytes = 0;
+			WRITE_ONCE(n->output, neigh_blackhole);
+			if (n->nud_state & NUD_VALID)
+				n->nud_state = NUD_NOARP;
+			else
+				n->nud_state = NUD_NONE;
+			neigh_dbg(2, "neigh %p is stray\n", n);
 		}
+		write_unlock(&n->lock);
+		neigh_cleanup_and_release(n);
 	}
 }
 
@@ -655,6 +669,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	hlist_add_head_rcu(&n->dev_list,
+			   neigh_get_dev_table(dev, tbl->family));
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -935,6 +953,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3054,6 +3073,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.34.1


