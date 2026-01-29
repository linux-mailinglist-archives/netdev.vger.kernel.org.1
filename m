Return-Path: <netdev+bounces-254723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNeCE8Y5e2l7CgIAu9opvQ
	(envelope-from <netdev+bounces-254723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5926AEFDE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 608E930F8CEA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA57387576;
	Thu, 29 Jan 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jtQguKMB"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208B387561;
	Thu, 29 Jan 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682932; cv=fail; b=N73zSroo441kj/C0hnpQF+4m/aSMbzKNG8mAVoZ3YazDCbCQHaMPUzDr/3NHkqTuaY4qRrVU3sNK7GFD/eR5LlZG9H2rwAt+GFQsJt9AvgEE/z5cgjGZCt2Lf8iurt4WiHC8UZ+U536VfqML6c/Wt5fxYeeJJ2ePiYPNwBF95Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682932; c=relaxed/simple;
	bh=xdG5pfEBCJMeWqKCay7/HwCZKDqtrffdQOUV735Oz8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUqoQSFaDbBAf3qfuP9QWNbpmO/7EOpVpzKE9B2SlptVlaSqyQ/tFyJpUgCPpVigAeuDxvuE+mFSPg6hPXXWUv7x0PNdMjrPxSHfPTCtHkullSAG0J6at74KJPAHEe2hS6p5Bk0HWYcCxCwJX4lgsJi0iD0zsn0F382zbZIxZU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jtQguKMB; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW30IMdDNKj5qy3f4HySfFR8ddHsZHY6qDHtSdxO2N9b550DNEvYEbe4AkeudJNpVTs16Q83e6aZ9zBvH4/lUkI8qJzqhp9/81YLeqZ+1fyp9USgNjFvvFoezgMIU5wiAelE/dL40ZuDTdrXkvJ3fjCZq0x4wFCl5ooY3Md+Wk/BYkf/mpe8PDxzeXmjDyhRS0yGb4ilPx1/KfcVBoFPKsr6wJcgzNuExH6jZ4DJV0jM7XZ3wJwmlpw+3/i+RbbIveHdOgHaC2lGepsd5Zpux7PugA79uD1ZPucTmrbSCIptMMhESt/tD7HKKT750dmROJ47cBByzkCU6R/uiYuNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=ElA1LCoB/MgKYk2O6XIr6xo6Yu0NvyYmBRQtkSL/eqGEiHIkBmvUPyZCFmVP2NNNzc4d+lVLRF/UQfZbg2BpIiIXTCi21scDkCKOSi9nSulSsuWiiEgicJWC7a6978WEL+ltxG4D5rEHSdGKThX8/NNFDoW+xZq4KkWC6j4KisPlTajTnYKUoX8ONgSSnWmOvYI7zBnRkat3e4IZVtfAvWQTsjG0KjeI4UEkSZAkFQ3flvZy30cMWtiqB2RqMuQt47Ze43KPxYkc7RVy4ko88lWDxJwviDJDeHtnutzoAEQKDMo7NHV8XRCx61BTecUXbSgfVQxOHwKeX+QsJ5Njeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=jtQguKMBzDZgR5dUYrDq0NAMCemEaQdWLfmDGtwpYW9We0i+vY2L0TtrXdGaGeUdvX+qa8GSGlxv41CFUqzk2snsnNOHGFW/WUw72s0xcMYfHWj6fJeX3z0Tp9CeODbiDNKj8oYi1DI55TDDfcEhHbcaVTblazGI8IYaRw6HoW/F9UlrSlzk7DhHrMcGKTXRCgqH7ic4z1i1AjSl35GWVFr/6oRKDae2txajVmVEEeDecWS5Vi1xesRiwV655hxwfrNTh+fMsYewSfi38Cvq57ITewub2vlvGdaGh+GW6MGfxfbLvs/MQLpScmuye5FeskCYu2RAy9zaenQsnWMiVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:23 +0000
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
Subject: [PATCH v5 net-next 04/15] net: fec: add fec_build_skb() to build a skb
Date: Thu, 29 Jan 2026 18:34:36 +0800
Message-Id: <20260129103447.1893129-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: d540f450-01c1-4b80-e776-08de5f221b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Bl6GDPWkxr/Qp4+x4pkrG4cV8xh4DL5Yi4YKj5TZCalEWivbFYqNkvd6FTe?=
 =?us-ascii?Q?ySaD4uk9UysCaMV04TYOQbCCkGn3NXpLz+r3NZqU+QeW4Hzgh9RG4VH7GzOA?=
 =?us-ascii?Q?OlUiNAJlBn/HJ2DsNgbixCLOqgNJnrhs/xzwN1yFqum8mnuJRKkT+FSD8cNU?=
 =?us-ascii?Q?SxjHDGr9cbmVFqChqCVdbSDdlJHuIG5aUqpc7v1mLYQu3EhPj4otCMzSJo4p?=
 =?us-ascii?Q?fH0Es9aKdHtUA7/4WegIbwwIuj+rGDTtSOXE+QmgNHZKEnqR7MYLyyUcwdRO?=
 =?us-ascii?Q?T4YvS0WZxu1GDoUwXnlZwy6xrMee+q2zvfYzQJ+jk//f9a6a+LpR6UlGU9Yh?=
 =?us-ascii?Q?A8iT4HaA51LrAkjskHxYbi2UDoWzX8FF9ovenpj+fq/7Ib161IyUARcFdR8q?=
 =?us-ascii?Q?x66LPEYLq8LYErFPwbz819PN4wRJsXtaxTUxXclosfTcom20EjXUkopQKgzy?=
 =?us-ascii?Q?SHKpF3SK/GdYWopB1Y3g4nUzYFtty91GQQyQAtEC9+XdI3tFVSZr1DhMlwK+?=
 =?us-ascii?Q?XCDmkhQ6kpVwHrvCJrptb97BbQu1QQj9lhM/7Jq4gdEVmEjkS/c+BGF3hK/9?=
 =?us-ascii?Q?0n/Nnx4BVE3hT/NcLmsOXgny9Z8QBc2APSowalqu8HtYEH0knRuRBI3wkK+R?=
 =?us-ascii?Q?ansuC/dnZO36CQJULzb+n7X7Lc5wbh//8aLXGEqn/lTVfsRwxZalDQT0S10X?=
 =?us-ascii?Q?TLPkll7StpHiNSEYBzGSRJFEaibxDnvXKAaptytVn/OvyhS42ZZQAmeAYi6r?=
 =?us-ascii?Q?PjHrJaqLbODa0QSaeiwR2kPWvNbmdy4SUu8ZXGBMsXDryox3GqJRUqO8Mggh?=
 =?us-ascii?Q?++JMnT1uTxwxWTdOqHyJYHu5LYJhC/dPRYij6P8ee1j12qQKaKWouh2O97Rn?=
 =?us-ascii?Q?AsvEC70po2n9E2y3QOJR9aXKdTNaN479n0bbI6PqCQD54Gelix58rlTVUnIs?=
 =?us-ascii?Q?QC5tIBdPZ7nbbT3ffRgktucbi4lR9OA3kPTy6ghIIL/Mg1Pe+/t1emifpCgs?=
 =?us-ascii?Q?+sy5pUi6feG/4N5O+EqUnD4AjAazL6mVipRElR3v/cozikhaHPWKPge20Jfm?=
 =?us-ascii?Q?mRbAhlxR+Qv6BU6TVgB/afyltuUCB+6ijZsfVEHvza/S2u045YhtHarlC/t3?=
 =?us-ascii?Q?wBRWPDdrZ9jiJ+eiPiW7cwWnNY+mrKA2ANeghYG/8MFCinIC6UeZM4u9F8bO?=
 =?us-ascii?Q?N/PYQEgCnQ9TCogXY51p+DwhxEaHmQVnyDY2BrCBWy+RSi1+AoXhFjkiE1+O?=
 =?us-ascii?Q?A6+i+sGqMPCetK2A8Ag9ZAdT6UD3/3pvEXjHS95QqJ6yJlMnrRpVxBEP4RHz?=
 =?us-ascii?Q?o0y9D3P2VRaQLKkh8XDd04kvZrVZw3jjceGichagSkDepEzKxeFx5P1oW/3Y?=
 =?us-ascii?Q?sGN2RxDvxmWqri8rilKIE53WwlcbEe302tkuqXrzV6lx9xoADlXxXd5nL2g3?=
 =?us-ascii?Q?zon52rLl2v4gge/6s9g1ULCd6ZWZOML3TM+sEx9kyw2rolUxXAvQBXZHUeMD?=
 =?us-ascii?Q?KK2+41WNkEwpoSeHskvB//8fKX6YGfS661qob270VV7X7fBxvnyNJivBg41L?=
 =?us-ascii?Q?PnMzvCRd1/51wrVMIJ+bpfdPULIy11BuoKbUP+YTXmMG4qwQG869SiyXT70+?=
 =?us-ascii?Q?A1q/goDPp7blXGzcD5pxh8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/hgkMDZ3PFoyB5N4VTp5MNfeW7JaHyOxOydeSUovBj6ikbSWg85Li3jsO++?=
 =?us-ascii?Q?pRKp5vlltsNNd7IlnMXqwM8UWEYei8FTTL//6q1OccKtKFlC/pxKLyenARtq?=
 =?us-ascii?Q?Fhs8YY/gHrZv07fNZ8uDqBsDUmYgQVrXkMzNlR/dDHfzdSvXCM1G4bJkvlaX?=
 =?us-ascii?Q?qZbu8dlCgjn//Gk10JMmO8VFm2jffjO9bM2D9SyyTWbg06tgYcZj26jzagXI?=
 =?us-ascii?Q?i9DBS/rjPr/pGEqu4mRC9LuonS+xmgo36lrZ+W//iUAGwXvZLcDATiJIKzcw?=
 =?us-ascii?Q?H8aAJ2j/dqTedd7jbgqgNouBcR99jF086OCk1Tw/O2dUMhQgC56RearUonjs?=
 =?us-ascii?Q?U99fB8PV38z5bCv4juusdNFtHxBP7q8/FXHoIlQmBoVRf/UJBB5V0PtjqxQQ?=
 =?us-ascii?Q?Kf0cFmR5yQ/ipq1o4MZvqlFqYfavnC/OMUSo4aKkSE7KgahoSwnvNP6eWHcP?=
 =?us-ascii?Q?PryzTMOZfz+3H7CaPFNNJ3EFuSreDOr1LkZBURBYbP4Vyi5yEC53TCIMAZGf?=
 =?us-ascii?Q?MebTf7DrHyBhhUUpvEeb1Zhe5vUsYni0bNHon97vzzAIMl9/VDR31FIbHVfe?=
 =?us-ascii?Q?uTBDO2BlJgA4TNNwBj6vLFCmVoRPPBXnh30VJIdLiOOEdcV6O+Of8N2B6jTp?=
 =?us-ascii?Q?6HOpxOfAxOVqwJHlDXWGY+Xn1r4+Pkj1ywb80qy4Eu94qLEFTlgRhApSJh3H?=
 =?us-ascii?Q?tjOEwZcQJPl6iGEt4ejRDr/qR0ry37NdBZ9p8v8Y0/fS6WcgxeWARGETSgyg?=
 =?us-ascii?Q?BIWMYTha+ryVvxmHCxHXcrV97iJfJlsCFkB3GOtb/9g24Dni/QmWVDhnZlRe?=
 =?us-ascii?Q?eZNmqD1r1WlGODEqJnpGUK1ncNj5LxHL5BGEgY9E1SckPv5mwzx1tpTAzTby?=
 =?us-ascii?Q?iJwa+N0bXYkcn687yXwB0ShF+Xq83SFwRc704MU1h3kpzd0pjWle3zNDaPas?=
 =?us-ascii?Q?ikdZdxt5qnbMWRjislpdi57scSv5+UeBoGj3Wj9Ou92+wvUzJI4sJS81iScu?=
 =?us-ascii?Q?LyobBgGKN07ASzvmejjXJ6CrEMbOr16b8BRx78Px9ZhTbaWJvw1E1fayDdiR?=
 =?us-ascii?Q?h0vn0tAhATdl1DRwNgfjcfiGCox5DO9i1UmhR1zfHtO3v4t+n+HEaihebHi/?=
 =?us-ascii?Q?vq0SZg5YTmh3ikV5kQIl4Aq/coARAkCDeI9l8zjc3EHjaEitswMpYGSBd5uP?=
 =?us-ascii?Q?G0Y7iYcrvw7q8jvYYg/TIF9bhV96hOVVdq8mZu395otBn24pj/IavhfZWDGq?=
 =?us-ascii?Q?kFj1Kk3yJ3AuuUrf6E0uG/EzCXz3JoU1tzmxtheD2yLBsTDop12rT0BWwnqy?=
 =?us-ascii?Q?V7ZCpHtOT1Je+aLQyzDy3jMDukUFd1zoSVD0A1rG9JULiWBUC29ZTub9EOHF?=
 =?us-ascii?Q?fGgrTh7OruF+R93VvJgiq6GYVOfTgxwxz8oS9/WeUE3hcXEMB9S29F44aves?=
 =?us-ascii?Q?/QBA+lu68aKG4kDhZgDIOHEYGreu8jKq+KkemEWRtUZPOuPQOzhNcxr6ln14?=
 =?us-ascii?Q?EiBz+TKZWXlN2mMxdZQiM0HZWtD/eltIhjjJClf7O7inPToT949d192pFHN1?=
 =?us-ascii?Q?v1aWc8IBxaU8OEThK1D/NNjeQ5NhYD2BZjbpV1r0fDpxDqBt+H5huhuRrwWI?=
 =?us-ascii?Q?u9q3fDGJ0aPMWEkapVLk43TYaSeMfoxNOWwt++xy+LEF2P1b5XG2HJGxvs6U?=
 =?us-ascii?Q?OP7YDQh8vP6xCOuis3jz9lyI8HZSb6EAlEOYpGWO22mTA7fg8+9Em7L4iT1M?=
 =?us-ascii?Q?DdAsvCG4HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d540f450-01c1-4b80-e776-08de5f221b5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:22.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFIO+bC1oddTCIiGiC3ygVVXPmWhj4hz86GNvVMcL4ncwcrNw642UnhcQURzmCqyxuKu23SKB1BxwFxNcjWkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254723-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: A5926AEFDE
X-Rspamd-Action: no action

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c5d303f2aaed..851608d04084 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1782,6 +1782,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1797,7 +1850,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1867,24 +1919,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1892,34 +1926,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


