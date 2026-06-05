Return-Path: <netdev+bounces-295688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4JFCyJ8ImozYQEAu9opvQ
	(envelope-from <netdev+bounces-295688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30997646086
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=lk92DcBR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295688-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295688-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEBC430612A1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715447DD4A;
	Fri,  5 Jun 2026 07:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D747A0D8;
	Fri,  5 Jun 2026 07:23:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644215; cv=fail; b=i9ijEIRakQ38Vke6QYv2NUOcA1mulHZqOyRTtAMEyiXxFs1vZjhDw4QgJjvMZT6kWuOrTDb0NGgWSvcjb8qrisMqRYIrgqqaz0qhaB93oEqCx4POlo5d3g8dG0Z27YNbalkxFP/Itsd5YMxykk2/NptyavwZHlEQaekp/1FrlRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644215; c=relaxed/simple;
	bh=XxeZ/6ouPCrMIRkwxX+wcjp3LtI1/BIFTmRcB7sItyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiPKjyvklfsbSrjlsoe4ubqnWZydny+0pOU7o0n9MzUNqMnItpXNCf05kYcvrkBKbGPa2o9VWzpsHszPsunuPhiMrPDrd654gmPOb52NFZ7d1aku+h1ffGiVTiDPFsHLy3Z26DBpxWsWmtzjwRCe3m9UFgXgZKZzXyfSsbUnPwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lk92DcBR; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxBrionR+nYmWcgFF9HebK0pN7v0c3GWoyDnm959sdIIPaJvUNVzO1LMMYD33zjvU8W8u+H2eoqDOUKKKypuMs0rLSDBgL5cjeymCwbjgN73cG4VHhIwEVcUHNM9OyNZ4zQ25pxyFavHTNw0TAPuo7Iq8+FOz2BrRfvAuMzpjab3VGkhopi1P3i3Hbkld2NZujJE2rDlVJ9RDlbB/ZIN3cMLVjTvqt+xp/rmoSdAGj9FR/4O8m4j49ECgYUPwmzZFmVySpuV9H0/ca6dXbN0IFpsF2wlK9r0vJbgyQLNf+WgJRqoXCBw/yTDWOqG4wtgoe3D6kHftsuqgNnziumJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNe7Bgv2V+0izV61aNppqC+zu1Zp7JtRwezOnrijuDs=;
 b=x/hBUInHyI4S9W/ZMssihkpKl/+7qJEho7dibG5Gka2nWUhzOcwbL9ejYaGD6omy0nQ56AY/H1k3vHxz0J2KcbHQANq81nOM0RjeBtpFcHRqA/PEO9aRz3GGGbEpZ2M9Y67pv3Xf100m53PuR75kEx1YCQ85dwDUfnFBljVrOxUO0upHAwmUz0hSyccpppZvVzgfxM7ejVNM+DVxyvwKCuX3bCEDHubYmDV9bDjZTwPEcowQUeZS1ggyJ8coDx6sulHTZ3MOqiCwv1D7rakq0wZoW4SVul5Lo7VSNCL2vY+QwpTCqJjrAxDORdYRd7X+oWSck+IGcqJlOMnBmnqkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNe7Bgv2V+0izV61aNppqC+zu1Zp7JtRwezOnrijuDs=;
 b=lk92DcBRDiR4EFDmrwAney66rZrPFSDiBo/9d+cStdjgld99S2z6LgGQcPj1ojKwdpgha3T7xmsvrnJk9ByBCTsDiUrpAgC5iFLuxS1yMpSAtGIBghoW/TCVE8LT1qR4KaRIwiNBx8SzDgwX5yGUf92EEZvtqo/XrBiYoiQleqpj81Z9QoZL4hP6V3BPsRYH2yafaKmpj+I9H5mmez8JKixi/iWtFdzD6+tgQqOhdwr8NWRcuwb7J0LNXThwuk/gPF6a9r69xLwC7OGQ0kXu7Ke5dFUTqobvb1NcA/UNEQVw3uC6HM6HKDU/hNYj0GM1cqo6HfPZZ00zz//P+5C2mQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:31 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/15] net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
Date: Fri,  5 Jun 2026 14:55:41 +0800
Message-Id: <20260605065550.3038579-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0308.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ed30ba-2fbd-4f15-dcb1-08dec2d358ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	EgCLKF2TyT4KuyMX8PNaDFM5kuKfmThhs78g44LWYwLpnO6+XiRmr1gL0GShCdJcqX/EGk8pJq8rOT3mOSxY01V/3/B7KTLAKDlNmMgv4SoWi+kIeSyxgfbt5BTgQg45VpmlyqV5q/Uy1SWtaFL9b+q0OhOMlDnPvlgsl+5x1B6eflAbDqTJ0nA8P8yjZjDzhHV9lmLsMlC3GcZTmwIyX1205waAAwVrA0aSKJtm67EHoHnUFe1AffVyPqxIEgkTqx1XMYfl4ZkyWXvu/sO0o3H8kFL35/bT6MTKBUeawoxq5i05sS9zjJBqL1BsgEnpgVIHysVbQo2Nrix+Yg2Jo6oY35f4P2pPFRMWI7FSqrTvtofBA/msa7/8cWq8b87zQ35Gwdw1tCfBATmhRf9oLsCnGqsabheSHaaHNNmu36m95nLtRuMzARXxMsjvqCb5M2rfreKaWJxT1WLcr+xCm0RGeFasIBrToGs10SFVmQjqPTvGNT/MZj6XLM6H3Kk7dNtQGpLlLbj1MFX66baIv1rAZZFh/4RVZXfJntdTQfk/sM5yD5ueqPv+myknZQ1xUz/o0ZxzIzZ8N8tmF8/ufx6qlVSqcOzfZ5cDbqMYzIPXnqQqwpgT0lIQlWb1gH0jW7xqLw5Pfb0rBSimvwyrwI7EA8k0R4SeQwH1v4snVPwhIZEdcxc3pKXdtQVcKMbecNsZgsKtHHLg58kXz2LxgtvbM2/rqjrppef2mJimN6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGw0rCtXrEri+75WRlK6vNDj1mCzR6jip8IKVU4Qa8MTUYeK1XFaKC7S91uJ?=
 =?us-ascii?Q?cDon9CyZi6aANvb+eQ6reu11wK76IARcetPZ/pA/UkdBatYvDoCH5I52Tkwk?=
 =?us-ascii?Q?2xXgXKYiZwEq3i0WwmdIH3xVtknaiVW+B2chfLFpoBUMfV+pmGGza3493wgP?=
 =?us-ascii?Q?xG+sC4cba4Waz4vqEVs2W50rsJTzPlZyFNC9AHEMWEVbUJrn1yzRk1aFb3PP?=
 =?us-ascii?Q?MyMZx/efkqUSwgO82hR/KZdktLv4sEcuB1Va3OrgZtZhdeWSZq8gZDRx8Fu5?=
 =?us-ascii?Q?jXDS+pg1xUpDIxNiam8wiTnbhnlua8dOvw5aNmS6SLyJ5lIxtpmVdI1P+6CG?=
 =?us-ascii?Q?JjPk4VbG4gU/m5IVke0JbfSR3R2ncz8RsC6gAN9NjeeU+Ea5ueRwq3b7msj/?=
 =?us-ascii?Q?9ftHa+GpEBJbzjWhNfFdjbMDEAfPhYC9qslXNe1NGdz82fFQVgInXxUs62E2?=
 =?us-ascii?Q?hjnf+3bvk32B5gcVeJvwKY+6xhP1kwws8jWGCgIgUh7DRAu8BkK505ZML4HX?=
 =?us-ascii?Q?/liQnwDyuf+jzfrDkQ/uc0apP7eIuJqgaJxYxCF8pgF7iEV2+dlgRvaf2+5Q?=
 =?us-ascii?Q?d2XdSNfF/PvNukVCfQYxTcHGpaTsygwH9rzBLsL7fvnweRWiC4KU5sBrWVgf?=
 =?us-ascii?Q?xM8i0awip/xQGhsqpl3LICwz2LN+SvMGtNOBlyG2M+0c/Vh+2INyjX1S+XMk?=
 =?us-ascii?Q?bBsF8bxLhWPOCG2XKMGMVaVLXDaJhZZY5SJfvKV5VQKHG3o0WKO5NgKsk7KF?=
 =?us-ascii?Q?QNGykDvBSEPL7L9NJ9r5ba2QvyPdOBV0O9gPMy8VcoAzo3joT4QMuBsYhTjR?=
 =?us-ascii?Q?JydeYb1yAFDP2xSGdTp4xlCs1AZyYrOjfRfbZR1CV6OxSz4JxiOwokBTxvuF?=
 =?us-ascii?Q?LDQHxO+Zg3+djUHpQRAa3+AtXKhyC4o4JaHIaidkVLjEDEF3F3wOKPHbAHww?=
 =?us-ascii?Q?6Q46UYh9EMY3ieuZO0b2Bs4WEQvZEiA01TrKX+JQedMQQzcoQaVjqCgaKWE6?=
 =?us-ascii?Q?KPLGEw7rUnR0DbDIXXcnqwRgJ4uv9yX8+FyV7L69wQ6MeF9bAzHYgWTIxc1W?=
 =?us-ascii?Q?UIQz8+QyFcSNIs2P/utUsuZPdCB215a50sH9V4Cf+EH4/aSLa5uLG+auXURa?=
 =?us-ascii?Q?ZTdjVZrADivPSXtnAnhbPDn20BqIZ2csQZ5HGmOgqTEoVa70o7UaLPjIm0zW?=
 =?us-ascii?Q?pR9KbCROgowGjxj1Q9NBLNLbhJI0BSMAQFVEJpGxtqPCdp66LYblL4OHOfRe?=
 =?us-ascii?Q?FM8TRGP8EKwTggajWr3ZF05slh3DUW0Ixomhu248POznzOb8Qux2l/HSZEne?=
 =?us-ascii?Q?uEVX/KNJqDVOA5k0JXX5r6GxJgJLUhwbGY0AE2gNhNt3MjwD8syV6ahqYulf?=
 =?us-ascii?Q?x2lFC50RKWPImjtwLKdhRG0+f5Xme4grc8dhkATndW18el9isn6t2PZo5JZ3?=
 =?us-ascii?Q?qbEw/xpAq7pi/5fqz26hxGtYWYGxa4yyOfS0nhDbCGlT84yz8Ty3Z2TKgSmM?=
 =?us-ascii?Q?MjS/6u7iPRFfGwku8bxdmwMiVE5GAAFtHRoKGIJJRH8U6Vjo1lNlf2vKwfAe?=
 =?us-ascii?Q?3WoTbd4Hw/bH67PtsHAMbfSiALOXqdy9Qle1Tfss+ch/f5UmVgAEnKYbhPls?=
 =?us-ascii?Q?tsZbIBojY4EDmixISQDXrElHUneSbnSkQ5YRPm8QKg2r/x+63qIyn8VDdv2R?=
 =?us-ascii?Q?N7UxxSR+bNtv4Pv7R2Qwvp+6k1P7Qm+3iEW3BUKIbRJ2Y3X0D4/XpPJMb3q+?=
 =?us-ascii?Q?j7hYABWlLX3Cb3wnTCzm5IRiWMw1K9HGQoLlrUN5vFLvgrQqOE9N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ed30ba-2fbd-4f15-dcb1-08dec2d358ad
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:31.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVIzxDEIDDID8j/7sU2ZQKivpbt2X58F9U7kKQ7pxAsnZG8Yx+xbKM9hrN3/HpSVsoxyjwizmLHljwkJjtA42bo9IC63p7bRnDVWLPS8iJG2SZ05evZja01sXHC1YeY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295688-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30997646086

From: Wei Fang <wei.fang@nxp.com>

Move enetc_pf_set_vf_mac() into enetc-pf-common driver as a generic
interface for both ENETC v1 and v4 PF driver to use.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 22 ------------------
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 4a16bc49312b..38fcc7b5fc6d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -239,28 +239,6 @@ static void enetc_set_loopback(struct net_device *ndev, bool en)
 	}
 }
 
-static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_vf_state *vf_state;
-
-	if (vf >= pf->total_vfs)
-		return -EINVAL;
-
-	if (!is_valid_ether_addr(mac))
-		return -EADDRNOTAVAIL;
-
-	vf_state = &pf->vf_state[vf];
-
-	mutex_lock(&vf_state->lock);
-	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_set_si_hw_addr(pf, vf + 1, mac);
-	mutex_unlock(&vf_state->lock);
-
-	return 0;
-}
-
 static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 				u8 qos, __be16 proto)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index e3bed5580d17..85e1efa6a8ce 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -487,5 +487,28 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
 
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	if (!is_valid_ether_addr(mac))
+		return -EADDRNOTAVAIL;
+
+	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
+	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bbe21c739cf7..b2a2b06c794a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -18,6 +18,7 @@ int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


