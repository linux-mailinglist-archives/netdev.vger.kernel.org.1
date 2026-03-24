Return-Path: <netdev+bounces-270890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLzwKu8twml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB58E302CD5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57CE7301EFB1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075A3B3C0C;
	Tue, 24 Mar 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="djqqkFP+"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DB3B3894;
	Tue, 24 Mar 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333179; cv=fail; b=Ub9olKnavQraxBP9XPyn/2GnMBnJBAkzlLPwVCNsqvbnodYXKDCFTfQ/gRYsq6AMRpLUJWFCUu+7bOjxqd9hRgzlgM3p3jvPnPs0SDSgltkkGx6wF98u07BusADXpadUMz3pnfKqTvF1Ab4F0rrhsXnpO3Gw4M0jPCmUJ+7iDPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333179; c=relaxed/simple;
	bh=Xggy+GLr1SaNCoXIyzIKQYa3si7mxqyK/GrEmlk+ecA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuKxVIOVf40cxETTnFACKghpeFBMkyOPUHV4tx9QY9iAHMGH13Upe2B38nWFxmiLVEwcVvE7w/l6UJmKFyzq2Bm4aksnVRKqp1tD7gy0gYbaOTshC1mHxwqG9734HJjatsOSHEf2LlW5LHUiIPFeY1wK7Ta8SkIOOyUFMeXcnpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=djqqkFP+; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqaUraMbY1UKpFUkLRG+S2qkZ/VcVZO0LBox4QOj2FOZt7VxeDYZrujybVQOORx7/F3vhXohliA+ruKSdvJRkLilZ1T7QA50RXoZf/pMt/YmXNuOSOC4M6PkLlqrXxFmJVQeakQ0v0iQYJ9qNFToNONGTobDIsVb7cqfBj/KjWAMQcDk8CTdw4Q4NeHh6fxMVHBu3VynJFAJpL9UxShSdb4vwzZ9Gw7B0R2TccJkKigh3Bq6oCQRMgJnwu67qeKU7r+5QqGt3sTfFxjldWP19A8uQzBZNjkndXGiWVYDy8E2Fj3wEL6rRxMDmBnCPUnaDBei/TmsC4u9qnr+ERUWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaQpjJ1J1OOdmeURoI9+1GzptqrMzrF5uR+nLaNhOg8=;
 b=yyAhXIEV3pe5dG7wJr/40WklAkoSwBkdfyDzySaPeM9WLaZxAY5nlMGUqi92cLELByhtZy8ORBA/YAaYxZud3y6bwrRlc9BYcBT8i99I/868aAJPdQuSeEQRMUgOsF5rd2yceUKERNCZEEXSQgz7po3NUlS6oPhugzh+vQ7Ib83h+FGovtu8axkA2+AkYj+vFEqutKWtvG//l+1TUeb9WVy5EnCsHzp4lzJkG3XBfu2btkI0hi4NPFBtKc7NLbp5bNfgcQvcOkaN7Qsw1Bnir8D8wvxl/9ej7eJ8kzAdn8RlZy1g1rgXDMz5pE99n14hSWKThW9vAxrr+4CdiFhXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaQpjJ1J1OOdmeURoI9+1GzptqrMzrF5uR+nLaNhOg8=;
 b=djqqkFP+l2f9Uco2wAdg2YWrULAEQkw8H5etf2P/sCafbX/iOCedE8LxiEpL8owHEaFjkDDNwSEezEHs2XKVI/lP9p+4tGdF7/1/Z4e+Pu3ngvi5QyTCVql8QhEMmLfSln2fKfaKmLhwNhZVwXS+3mmGe2i7/ydjLaS0y2FvF+hQ4my/QjFrUm/o0x7Nwwg6Ins08VC0pLPFQ4sq3d2cfdoLdyuSDmGuXG1TftI+7f583RXrW94Klhumt3B+VKv6DFYsmER3jdJMxS3C3iLV9tqlV6FiZtw6TZ6zkEwhRyTRa7Ju+hdlIK2czhTw6kPuvznTttbBjSFwlMjNP12HJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 06:19:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:19:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 RESEND net 2/3] net: enetc: add graceful stop to safely reinitialize the TX Ring
Date: Tue, 24 Mar 2026 14:21:20 +0800
Message-Id: <20260324062121.2745033-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324062121.2745033-1-wei.fang@nxp.com>
References: <20260324062121.2745033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: ac491c1b-9bb9-4927-10cb-08de896d4f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZeSx0Me0ZN3z7bSOvz1yVIt8yghB1MK1Zrzh1nHWuYoYcstgL4HLELXgXBANe430pYvwNL6DigQt0hHKwCKy6C4O++GHqp3Az/fpyt4+Ivn+xa8gic1BrByadSO4ec2uiJZnKJoky0B/SkKnqdAh+mrWmURs6KmKwwwoDl5ROObw6YkVm+UNKdrUeKUZQdyD90PZeLuBrfBloFPZO91pzQWlG0Uff7fkSY5sZy+yeZkgPxVFSceGzJcALPaw+55UzT2qiRp5ObOqZLk7CegnESQA/8LYYaPRhCjcOWAT7/jm08DnJkszHiIbvP3K9wOwZkkHdkNg0Mnrz0WFqg0ec0gRIU0MfDB6OsfIGnfd9etHP3bHiLvkP+i16WV7PFFogZkKUWUrmOmUR2hRE62MoG9j9cIXpw+UEJP6m4NvZRCDqHLQbGmIHfDUcTFtETnypffSvzW0T0rHo6p2FBta/C98H3Yy0Nxmfd9m4wbPbl3f71P5Fh7zo8sPFxm9c2O0BC5Gt7CAM+Mc+tc8t1QjCR6FuG9gmBflM63wetRAY85o3IOLPSZSTeQbncDZQdJxdANDpwn3DIuWP+JuBDq/7JzCrMM0P2T7kFQw7W/9YKWWk/QpQbxpkEIa6TO3EMXw5WZmwSVQD9hCm2wizI5bzddS3T27zU0L9bUxfCDh1M/r6NQa2sNAleBhw+xPQRGR4gbfBbeQSx65dOXFXwraGel+fihdZz9u7dNO9e4sA6OWovMAdVT/bM2e1+y6vqajj0OJ51foZKYYgbwvQm6wodCRK/trYbZj6yMKSNH/F5KF2yEe/gM62r7Gm03jdZLL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6waP0yKGKPTvvW+IdxRcICx1o5aHIFxZ4+3zaAVDB7Ck42P2m9BxuV2ppbWb?=
 =?us-ascii?Q?lx/+p68/Nst4IS8uZVEuC3vjbXIZXtxtDCF+vxFUk7bATk6b9Hcpr2RctrKz?=
 =?us-ascii?Q?N9dJjkVl9v8QbJsDigTl5djVZUP0aVi90MyljTAtYZeA1DEpGK71xu5Dv7TT?=
 =?us-ascii?Q?PrPZroZFDq4glAPn0lw+CLcQExBtzENnOEzKeKwdWaGQ+IzSJf4C0RvOXb0t?=
 =?us-ascii?Q?+SVeqgP83w2xtZkbuD1ftgywT3mCvX5fAC9EwsCN7ksoTvYBFkmSEIUSTjoT?=
 =?us-ascii?Q?SUhAoIguaB+y7BAlbLicgWJgAkyF06dg0hFnKkpg1+o7wL/wDgK/vBVpr+d6?=
 =?us-ascii?Q?yFxeWPvGwYgLzqzSAv6PlfhxBrssSguLS/h2M3B3yllk9SjFAlTMm4taXzbp?=
 =?us-ascii?Q?VmT3XbPn5eaJvD4EHgMm42kFPDc1GKsw14ZMBjj3jAaSf+DJ8VOvid2Wxw4Q?=
 =?us-ascii?Q?R35b19ixpfSkk5m1P1CgN+wd7GePCUgmRcHJWsglrXvqi82hnCmTEZWjkoaz?=
 =?us-ascii?Q?dMq3ubrvwONzWA/GaAMpHQ+j6bw9bqEXuING43LOkMTLI0dcp+Cw5VkBSgwA?=
 =?us-ascii?Q?CMXoQeFkfxiZunJiYgkfFny58PSv8cPUMeF9e/x7mFXGLZ+Bja1TGxZUT6Av?=
 =?us-ascii?Q?G8kYpv5TMjGuu9sLxFfexAUmme6fO656D3FfkBT0hU2dwlstprjSegU5zFsR?=
 =?us-ascii?Q?F90/s1niAtSaVZNKoHaFjtQZwbKttxTYTDNN7tDI7dK8yDK3NdQL/+mfCqMp?=
 =?us-ascii?Q?aFUp6JkfL3aOSKF9jkevD6YB7d+JJ4b0vTLLAu/J/rfrXCYtSgFnKVw3vmS8?=
 =?us-ascii?Q?+KzRr7qdL66zUo8g8WrJRSe7MEqQuPQXQArkEjQBMNbiJ66oMMnUPNxgNtof?=
 =?us-ascii?Q?j07UY147noL55g1F++PrL65w5IX7It1b406w5K0Rk8zHWA2H+a7RgE7iJjib?=
 =?us-ascii?Q?0j0H4reWIFQ3sP+tH48daQv2KT12LHcSBZZ0AXB8CMZbOnmOPjFIQIfitbBA?=
 =?us-ascii?Q?W6Uuy4SedRN+Uk7ujS4f48ZG6oXQSBhau438w6k25nSQ2WCWJdPgkaE2QRls?=
 =?us-ascii?Q?qXCLED9g/hzWhbluDQjfHB97cThmQvXhYiYzgReZv67JGMdiwbYhpaGjCgfi?=
 =?us-ascii?Q?ef0awTytst018+r/2xP7iHRgCM3OsdWC/zUyo7o4lblpMmtbPg3kk+5SzHqW?=
 =?us-ascii?Q?AKY1t1OzestwGKqfLHH45g+Aglw3NGDvZXWQ0+weFzY3KAb7fQRTkuSyrDyT?=
 =?us-ascii?Q?2/x2q7hwqvT6/DYCVOVb3kLk+Y1U2Dpb9Fqm45eTPekWiS/GY4acxnwbLeDv?=
 =?us-ascii?Q?l4Q8apnzlqMi5n956KIcBlESW43MaVt9Q9NjZXzHvSuc0NUJqZN/ebHy2fMZ?=
 =?us-ascii?Q?5bhxAXVycIZBR9FWR5gvbGqmJrB5l24u/x3Tve/8+Dy/YWVn+/kQO8L5dg6E?=
 =?us-ascii?Q?DpmK+WiJzjfMzQ7qq2O+1luaq7izotg6SoeD+eawETnmaKNLj9NvU4suOa6g?=
 =?us-ascii?Q?sR3ODx/8+WsJQn+0Q0HZhIMFRnP3YS/l79q3Y20dodjsWsBqvbRmyZW/fdOL?=
 =?us-ascii?Q?QZy0xxM6+mxu7T+eZZuomEiqdKfdcta6YBSyIIUYaHE8MXvJ2KsVtUnrzf1m?=
 =?us-ascii?Q?bF6+vsZ3oMNKJeq56Qxe+w1n55oq8rNReSl6Y0MkUiIgJHqgXz6CtQnsg3kJ?=
 =?us-ascii?Q?7l85kyZ/tqDbi7wXn+G3674q7YpGBPqUCSQ1w5GDgsf06kCmKKqY4qAu0sN3?=
 =?us-ascii?Q?+36Kd3FMoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac491c1b-9bb9-4927-10cb-08de896d4f6d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:19:31.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcy/RrKWNOsnOo8O1E3S7A+KBhcHNQXFL9mbCv3vuzoT4c98kf7+fJI4kdawFr8koPGGsQ8TyDUjs59aJu4hBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270890-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB58E302CD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v4, the PIR and CIR will be reset if they are not equal when
reinitializing the TX BD ring. However, resetting the PIR and CIR alone
is insufficient. When a link-down event occurs while the TX BD ring is
transmitting frames, subsequent reinitialization of the TX BD ring may
cause it to malfunction. For example, the below steps can reproduce the
problem.

1. Unplug the cable when the TX BD ring is busy transmitting frames.
2. Disable the network interface (ifconfig eth0 down).
3. Re-enable the network interface (ifconfig eth0 up).
4. Plug in the cable, the TX BD ring may fail to transmit packets.

When the link-down event occurs, enetc4_pl_mac_link_down() only clears
PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
ring after a link-down event, we checked with the NETC IP team, a proper
Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
graceful stop to the link-down event handler enetc4_pl_mac_link_down().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 3ed0f7a02767..719c88ceb801 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -134,6 +134,12 @@
 
 /* Port operational register */
 #define ENETC4_POR			0x4100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+/* Port status register */
+#define ENETC4_PSR			0x4104
+#define  PSR_RX_BUSY			BIT(1)
 
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
@@ -173,6 +179,11 @@
 /* Port internal MDIO base address, use to access PCS */
 #define ENETC4_PM_IMDIO_BASE		0x5030
 
+/* Port MAC 0/1 Interrupt Event Register */
+#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 689b9f13c5eb..53cecbb23a97 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
 	enetc4_pf_reset_tc_msdu(&si->hw);
 }
 
-static void enetc4_enable_trx(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-
-	/* Enable port transmit/receive */
-	enetc_port_wr(hw, ENETC4_POR, 0);
-}
-
 static void enetc4_configure_port(struct enetc_pf *pf)
 {
 	enetc4_configure_port_si(pf);
 	enetc4_set_trx_frame_size(pf);
 	enetc_set_default_rss_key(pf);
-	enetc4_enable_trx(pf);
 }
 
 static int enetc4_init_ntmp_user(struct enetc_si *si)
@@ -801,15 +792,105 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
 }
 
-static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d TX is not empty\n", mac);
+}
+
+static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	enetc4_mac_wait_tx_empty(si, 0);
+	if (si->hw_features & ENETC_SI_F_QBU)
+		enetc4_mac_wait_tx_empty(si, 1);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_mac_tx_enable(struct enetc_pf *pf)
 {
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	u32 val;
 
 	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
-	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+	val |= PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d RX is not empty\n", mac);
+}
+
+static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	if (si->hw_features & ENETC_SI_F_QBU) {
+		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
+		val &= ~PM_CMD_CFG_RX_EN;
+		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
+		enetc4_mac_wait_rx_empty(si, 1);
+	}
+
+	val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_RX_EN;
+	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
+	enetc4_mac_wait_rx_empty(si, 0);
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      !(val & PSR_RX_BUSY),
+			      100, 10000, false, hw,
+			      ENETC4_PSR))
+		dev_warn(&si->pdev->dev, "Port RX busy\n");
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_rx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
 
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_RX_EN;
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
@@ -853,7 +934,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
-	enetc4_enable_mac(pf, true);
+	enetc4_mac_tx_enable(pf);
+	enetc4_mac_rx_enable(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -862,7 +944,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
-	enetc4_enable_mac(pf, false);
+	enetc4_mac_rx_graceful_stop(pf);
+	enetc4_mac_tx_graceful_stop(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
-- 
2.34.1


