Return-Path: <netdev+bounces-295697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5b9qCZ97ImrzYAEAu9opvQ
	(envelope-from <netdev+bounces-295697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:32:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E574064601F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=f84HLonE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295697-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5760730CDCF2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC74480DD3;
	Fri,  5 Jun 2026 07:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DC478842;
	Fri,  5 Jun 2026 07:24:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644274; cv=fail; b=qbECvODbZUT1T+x/hav7z8XJqAOOAXL2lU9eOEodSy/oTAeHoDuBeXkcs2VvRIVjsshPVfws/3QjnfEVAtpMyYigPNhUNwmUqERzRt1+mQUw+yMSei9IFZALVWml0qMh1Sv9BogJE4Ma7Nqy3PlMOKMmpGWEoQAOjciBkB18Yts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644274; c=relaxed/simple;
	bh=ADvgC8ccm58S8AIlbtr8AvCnpZ9OLPLoAH3f/0Ezo5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gjt9920GrjFoa0LR4KhZC4QnZkha8nb0UHkjtJHDQY/3z71WcSRJuGH3RPbnVjJMOghFcl2L9ZH1qhkGvQl/x9sFSknDz+7qpjUZBnbi9NhPhh84EYbVtY/FDEP8KjgW9OZwSegDGz9vt8IgyEIVv+f8tHC45sn1WKelH2sQZAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f84HLonE; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBc2gKK3eX7ZKFBRN8T/g/2EZTw7/CvfumP9NmXzEoNQz9sgX0KwAa+xnzxQI4FVWWPnWbmru729kSca6F6Y+iLnwoQhN86yxJwQM+DaRIf30SylmNNrvSbgBZXCxvmeMKRlXzo7mPq0FKb8WokL2W2I+bVz8W8UhE74C67TT9TdqJ6rIlbx+84XsZwbasDGTdrFvxz55G92h41fc89aHWCJDJH5tag5+z8rNFgZIipVWcdfe26kvGWb5sgxZgA257s6jVR0SIYLAr5ZM337CRQhMTxSC6bfBJt6V2omGR55q0a/43CnFOBtiu1y4cjfEk+Y9OIQCyquDRoxVPOBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKi2ebomMDmQhnmJj5ysvZQwK5EPb1gi3deQNvZpsLk=;
 b=HsVPEN0ciQ7RGvyo2KVEK+q7rd7IkpxW1oYAbWwL6OJGFlfeZUOZMvpCUP9M9Ttx3iAUolPTgJ2HXmHKrE0AAbznFJ+fFGGELjaZt6Wdp70HB/LU5fKW/uKWGnInsRO4ns7LrkPRE4Lx8JpWqd4JNc7FwMGT6YUuhAFDtlVgGeLGmpzUOixREiBhF4H8nbIVut6o+a9LhbuADzli/WSW6rOXKWgdlRtKre5kLS+d6P1k90IAtt/AyjaPI3vaG5F2FbdiFr3iUtg8R4eoVVeApogFuWuiVgOCkapcDgbtTyl5vHBmD5eNS3motGqen20fvX6QQCloEzLisc23EnN4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKi2ebomMDmQhnmJj5ysvZQwK5EPb1gi3deQNvZpsLk=;
 b=f84HLonEoJ45HldZpFFDJ1pBKDFUSNT8DpVC2vZABSarax2F2Z7DQNK8cxUBAK6QVPz8c7anhKvXXYoy4+cdNO5SU9q3atFfEcbChotstTukzRLSl1WPI+QDP+JMg+KFRCscjk0+URBibXjgL8Qy1QWG7B/2IUaxgoTh/d6MDJqAxmOna9PtBhjMQAuSOsRsfisvFNkR49SH8mTIb6NjYN1rrP1sdXPdalOdTFZuSz4zSLTaeW30QMRmYG/GXdoqEWnN99pbXgAeazASXWlvs1qFWjDU0hglEfSfMmX22iP7P8PL0R2npe6ZKC9NKgP1+Y5IbvF2XSlEbrdKv/kD7A==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:24:28 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:24:28 +0000
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
Subject: [PATCH net-next 15/15] net: enetc: add ndo_get_vf_config() support
Date: Fri,  5 Jun 2026 14:55:50 +0800
Message-Id: <20260605065550.3038579-16-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6455acc7-8bbd-41c3-ae78-08dec2d37ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|3023799007|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QV9dwWA7mU95mRR9V6ZIqFeaA4W7c0+Bacm0IdgKxRq5j17e1s66IPRGPySheVnIiL/bxyEULUAwMqlOnVIllHNPl8zLvq+m+YQE05A+ddytmY1u7OspGeU+qNVOd6F8aKxyaoNF9+kGSo9w32/tHDQWfqgJiukA+ZKQ1v7VouMCi4YCBmtiqSaw6Rn/GNwL+6WizrbnmXhuGBJImgSSXbWHmn5JvMrMWg0gB7TayPVp/E/pVmr92JAVsuFVE2p2F8Cqk49Mtrgf4gtGmT2nL/Br5htvOfK2rI0ewC+6JlI2bRpfgf3XxsSPFChXxQDuBRFgH6S3BV61kH3Xcqc2eURvIIJOLb/Xx7kJLrOGzXDhm3iCcF6LPA3ZvTT4KsgM//0qOXt05m/HRNClDlNeZGsS0TMAwinImhPZEwfB5QAXIx6GuGCfc4XK682YBJESuRuEDqV9RPl+q2e6LzaJf6tQS8RAKw28+/SjdejQMfQ4QP+YZ5gtQFi8E9US4w3TuPuG5pckLgktwl3zml2XDq1CHo7ZcHbNCpY0f3Xukft4swMYd4o0YAFguHt/+LTah6Po9DmAWrDM4o7xw50uExfsn1mzFXcCIpjsr6/LyjsRFQc+gEaomhboRMhiVPIuQcNW+vj0mS0Njm5FWqYr4HmXsA5EMzpaYQo76DIyY4k4/UgW3UMb3obSeLP/xYrqVPIZDYos+aGoKknRjq5j6jpP+7EkU/dRorzL22lJRXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(3023799007)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8q12vzcPCP2vGDVpNq3qFdOwn7h7S3rTX6/qVo90LT+gzTWSAO0Exszfj4Cx?=
 =?us-ascii?Q?Ho75fNWSUYEjUb66f0AFe0TSQj5DZBe07rsruCsNOMAvnqsNdIoExBJ2nu1R?=
 =?us-ascii?Q?V8jU5VNgYIHAgcLEeqPCkCV3UF99Jx7pX7iS3C8zrfpcghZqVFUXk2ggKvA1?=
 =?us-ascii?Q?sdh6vtWwFbeFHEIyFlk9SlBOLpJJxAzVUg8DyZgKzHkPfxRzPT/hOvgYN1AF?=
 =?us-ascii?Q?+++wXWT10zbIG7FgQVPixltoe8dGr0o7RRq/XXbtdAS+xycE/M61je5Uk6/7?=
 =?us-ascii?Q?MMzAg/nKamq5a6czw75dPePTFrjVKmePvS8xIL4NLZPu3loQLEJGY/VqvReq?=
 =?us-ascii?Q?G+7IOxllcUE3rqBWhtNAXbJMvQMwAimOqocBaYphTfsdAu1NnaD28khvZW6F?=
 =?us-ascii?Q?m8tXnSAtHQT7/dkhWpRSowh8YzM3/hPCDQbMq81L0F7djomWROxqNGhQQeCF?=
 =?us-ascii?Q?+hRvgHLCg0dLL4/Gd4pkOyINKrnRCBCakh/B09BqMEVzUkwivhuCa7nX6eB1?=
 =?us-ascii?Q?C7UiM5zXS7sC1POTluTK0vrJlrdLlSjzj0NlIzH9CfBp/BUlVtDaOYdg1YN2?=
 =?us-ascii?Q?4NY3rvliIdAqUHVjN+7zYPXMIHzC+n3ngo7GmdOFs1z29qUCD/WASVpjcytU?=
 =?us-ascii?Q?8Ufp3v7+th8/6EkmhslKnx2e6nM1tlnaZZvxCDOt/5K6ZDTLpaI4/lvMcjf6?=
 =?us-ascii?Q?sxFo42DpKlfA6C37OpZvdZaED+9nRKWWgyCMYzs7eeT7X5wcjZeQuqLTuFaM?=
 =?us-ascii?Q?ehNpwHMWcxqmjvEgRjUWIT8AJ/GZ5pROiGx8Pn6/fVwkbPz904Pn4ZmlT5tR?=
 =?us-ascii?Q?tskmf6NFc1J7fJiihGzplxN55ybjBqY6eB2D0lBMFc+XNBQKBasfPH+aCOS7?=
 =?us-ascii?Q?xIJ17CAaCpYFYIM2sWs3kSb2EEsF1WAn36HCdVKQZfEpwpySbeh/eNcVSA+M?=
 =?us-ascii?Q?R+9RTICbT5PWi27qNp+y30gZW2r/999vnDx5m9td1+HfPvP4gFLsjw6O/TRC?=
 =?us-ascii?Q?IlG0rxnp2MplnISy1KpnbhnKTPmM3BqJ3uqYirwamgCmLrpjP+trJnE7PZfr?=
 =?us-ascii?Q?D9ZFggWyV3oaF1b25wgy0q9CbDBcZKFZnAKrF6Cm4gJkGIoTex+0fK1HEI50?=
 =?us-ascii?Q?atpuH2cT0Q2mYIEmJAo+S5c89hHreB1eyF6zyGLlUesRVpA2Eq5F/C/LY0nb?=
 =?us-ascii?Q?mye3teq1NQuibDnOMKqWeMZ5d9FtXGzQowYcbpFRQpO8dkFhCBYq3vDYGrSD?=
 =?us-ascii?Q?HVSFtO/xtI4ZF1AQBevWeegTyMdeFoLQFLPpGWbNdDFA+U+hHNDsuvQeCYzr?=
 =?us-ascii?Q?uz5P9uOtvl1At2y1nM2VyBMWMXFOfJcqddmCEkGhFpZu19XPjzL2i04/BsMU?=
 =?us-ascii?Q?ScPQhrznHHCkP13W1bp4WSiBN2wkjuRt4gs0nfcy3ps/eRcGEpfnS+qhxMed?=
 =?us-ascii?Q?8KT+Q1HVc6Zdno95LRpXkCXjb7KerKbXHNxDfXQZZs3jQ8n2TuNpm4o36fwo?=
 =?us-ascii?Q?9OzcyUO3posuEKT5O3xjkAwbfla7dhD83hmbobd/+Qd+lNOiJj8Ae5wnSsXM?=
 =?us-ascii?Q?bumslH3UkQ1uUUsEx7z5kjUmecvRvcxpAvvBWbFxT2Ytv3HchRlz0Q+QN3mr?=
 =?us-ascii?Q?82BG4G1wwYjQ6BYeGx4WMPdNG4oD4gZonUD0JwFfpm7jgMJbIn/xez9jIstD?=
 =?us-ascii?Q?XCqR31HKskHp5R9ZLmID7TVLTr6h6t/G6NUdjqHVk8d/pM50NzRFiSSix+h5?=
 =?us-ascii?Q?Sni4LWkVDk4C0ey2rWmARovsFXguOHhpr1aYleHtw5apTA6RamAZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6455acc7-8bbd-41c3-ae78-08dec2d37ab7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:24:28.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUhnHi6yzf2sBV6qg+WyMRbU9dmGTphsXCl7aiIlz8XBZ52JKaLYMYhMYr3jEeZ30H5KMZKnPbWcOLbh4lsoUUwYDVfV+OsE7WJd5PcGAXM0VDoILjPnpLw8Jgvpd+9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295697-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E574064601F

From: Wei Fang <wei.fang@nxp.com>

Without ndo_get_vf_config(), userspace tools such as 'ip link show'
cannot query the current VF configuration from the PF.

To support this, extend struct enetc_vf_state to track the per-VF VLAN
and spoofchk settings, and update the corresponding setter callbacks to
persist their state when the hardware is programmed.

enetc_pf_get_vf_config() reads back the persisted state and reports MAC
address, VLAN parameters, spoofchk, and trust state through struct
ifla_vf_info.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 22 +++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  4 +++
 .../freescale/enetc/enetc_pf_common.c         | 31 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 ++
 5 files changed, 60 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 868ed694e120..a3edf5fc930e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -616,6 +616,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 209a3503609f..fa09c875d09b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -243,6 +243,7 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 
 	if (priv->si->errata & ENETC_ERR_VLAN_ISOL)
 		return -EOPNOTSUPP;
@@ -255,6 +256,15 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 		return -EPROTONOSUPPORT;
 
 	enetc_set_isol_vlan(&priv->si->hw, vf + 1, vlan, qos);
+
+	vf_state = &pf->vf_state[vf];
+	/* Currently only C-tags is susupported, so tpid is always 0,
+	 * which indicates ETH_P_8021Q.
+	 */
+	vf_state->tpid = 0;
+	vf_state->qos = qos;
+	vf_state->vid = vlan;
+
 	return 0;
 }
 
@@ -262,6 +272,7 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 	u32 cfgr;
 
 	if (vf >= pf->total_vfs)
@@ -271,6 +282,16 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	cfgr = (cfgr & ~ENETC_PSICFGR0_ASE) | (en ? ENETC_PSICFGR0_ASE : 0);
 	enetc_port_wr(&priv->si->hw, ENETC_PSICFGR0(vf + 1), cfgr);
 
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (en)
+		vf_state->flags |= ENETC_VF_FLAG_SPOOFCHK;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_SPOOFCHK;
+
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -528,6 +549,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 650735a7de81..faead2bf684a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -12,11 +12,15 @@ enum enetc_vf_flags {
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
 	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
+	ENETC_VF_FLAG_SPOOFCHK		= BIT(4),
 };
 
 struct enetc_vf_state {
 	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
+	u8 tpid; /* SI-based VLAN TPID (0: 0x8100, 1: 0x88a8) */
+	u8 qos; /* SI-based VLAN QOS (priority) bits */
+	u16 vid; /* SI-based VLAN ID */
 };
 
 struct enetc_port_caps {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 1aecaba04cfd..559eddfbba9e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -529,5 +529,36 @@ int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
 
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	ivi->vf = vf;
+	ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);
+	ivi->trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
+	enetc_get_si_hw_addr(pf, vf + 1, ivi->mac);
+
+	if (vf_state->vid) {
+		ivi->vlan = vf_state->vid;
+		ivi->qos = vf_state->qos;
+		ivi->vlan_proto = vf_state->tpid ? htons(ETH_P_8021AD) :
+						   htons(ETH_P_8021Q);
+	}
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_get_vf_config);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index b2a2b06c794a..0e487ea9c0a5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


