Return-Path: <netdev+bounces-304490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ++vfJY2UR2o4bgAAu9opvQ
	(envelope-from <netdev+bounces-304490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34E701758
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="HhVz3/Qz";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304490-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304490-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 466A23075F95
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42E3B14AD;
	Fri,  3 Jul 2026 10:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DF3CE489;
	Fri,  3 Jul 2026 10:41:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075318; cv=fail; b=bgQR/XmzwOJZQZ2bwvh1P9revL9CbJlSp3TYldmXLeZkK3oEJD0K9ip8khqTOV0ZTreSkT6GHtTE/Fg2LFV3bluOiSyTmnKns9b6QMzScjNTQCf+t7AJ2dCScnUto7OjldHiOyd02WwGUeDYPUXYA6BbG0rLhtq5e1284NmMEik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075318; c=relaxed/simple;
	bh=2VYtLzTkftiZXDSlxK1E+Bp/iE2Qdr0gmMRr/6DAznY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGZk2Qo/A8kyx7JccBHi/6SGHVmYZWqIqNazXCSQMPAk4oJvV0CKon7kNYzO7vH9DBt23kX3U835FsqQHutilsFhC/pS3d+8wRYXP5JdaPfwHup/luoX0lQmSlSVXhGdcY+cvyw1lv25J2l2GTpYhdTn43I9xcVJsxGHI9nIG8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HhVz3/Qz; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wnq3Za8U6InH5eHpwmti/viM+1h8V/Hnd8xyC2gv/C8XM8czp7ZkUhCP8gCB9NS25w2feeThV40H+1GdxTQt+x1Hal+WbViiyOJqPpRVHcPvs/7POUsc0rJY5Rkg2E+M0yzKFoFvfD8oA88nCxf9t/JjgDYjZ2FFRUy76nnsmsd4QP/896MFivDSuUGaRpPp2Hfjbtiw2j1sYoJxhE8W/BMatls0VlMn/P6hK4Wd7rEkzB08v1z6Ffw+DH4mtV5TPmoOvyfUx6MlcpYzRS4Vst9XagGi4/+ESE0LusGS17UlgS5NwP1ySQDoJ4qxwD4AoB6S/rL9e+aeznvVHX/5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=PBUzB9SVuMM1CXnaPrd/aTbXsEDls9HQx8lBs8a/Mqwxr+LVfBopOR8kD+jqN9LjWgmsnuH2ycWlABozgX0TiDmwB//9Tx+mT91XKXQ8b4k0jTDHzshvXw5Q4WUszsU7e5W0Ut8x2rjIxH+t43BRbw1brCjgVYmDXbeSvf+LodbITxIX76U1ILWvcLBBF8tUdJN420fDT7DZQDn28VOgRqyQdlgm4C7kV7GthK4V2eFTufcqu9qWjCXA6+CrFJOQcVkYVQs30IYpef/OJW1YEkFVO9xwWV7S3sBYCzcUIbhP8/q210wJ/jlD1tNigifuGAn7gonrB3UbZHmh7JeFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=HhVz3/Qz/g14vXiJ4QSTPqR8wEhDWCV97oXlc85MU3wVBaclKjYxL61DQcc1xyXGosmu5i0tDhDZK17bkw3725j+6wBzGTUzhOtvy4BQGkyHQQ0N0cxOmmi8iHBVBsJkwIaXSUPyZDZEyAAfKFzBXGtGLcKJ7tBYPe0O1+gQOX5LudbZJraMnPNoOgNxvmIZrf4GloUI+n5pyv944adVD9yA3WTKkuFMLEMM4XCiS4WqtgCOscBsJrDvbdu943cJlUjXI5d1ntR8OpTpYn9g3A/FOpA9ZpPhEMA7yEV4NfWpFxS1c94u2ZgxTvyDdmdc0LxV7kbchhGtk7dm4XOhEQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:41:54 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:41:53 +0000
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
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
Date: Fri,  3 Jul 2026 18:13:15 +0800
Message-Id: <20260703101328.550714-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: af745f1d-1738-4b78-9ea7-08ded8efb28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	E4+KiU2he3zAD1b3QSVe7x6NZNe9LgrG2WYmDUrNW8b91O+2NbG0LhGziBdmygKUVlQloJYyEuqy64yjpUxAswr1X6tIQ2m9coEaovFKrq4b0N4bV5H1ZhugSm0jrcGdWybUbCTt4Hmnim9pxD7ZEr1eM4inP47sTEr0JKPdyo91/DNxlGvInZvMQl5ivyhn5xE+bJNBmz7qQRlnpVFvYiOdzYCt/j2D7IxRPE95MrEbwMQeQuJKkj7hZkBN+2iUMrTYfUab64Iox80NKCnunGN0bEVowt0OPDfBhrOtIh+3JkyHCOmEmRp8ORLJrEDBAbRbtffRFO77z8bgzy0Z4WO/Lk5GV5dSMu1/8jTyn/EJw79xaftzMS6lwb9TaGCzzXakYkk3xxVr0yBCr8euwgFL6t/ARsavN4j1FZqy3BimKSul7H1OnRZ2TIb23BIgZ0DrJ00xkxoOSYSB6Nx3WSjk66wcRi4O4bGeCEaK406zsXZMwnEHpn+TlmWidbSTFG63GvonB/R0MKZBvXTD0iqE9FlS19n9Tk5y1Mfc2tLD21fwE0PZ96J8cVxxpRjDEweiusPaDEJFY8CtB0B4BQO/j8M0WU+7A1PYrBFVU7/j5a6POieAingG3Al8ZPAGBS2kdynoHeXzZQfz8sBDtg0jeY1borYQIbywDwP0c3SFDZq1QQZa41u1HB6uI1/x8HdJ9UO5CLZtUGEWDh6MVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rRv2Xt3sa+fGiDfpCxr+7uNAXzjSugjhmXmyogiYttS/Vlz0HISnjrhf4d9G?=
 =?us-ascii?Q?+JUy41/5Be0/wewivONiJrtO8waqrBUK9B90gDeucFj2UYlhxKskoBBAAB87?=
 =?us-ascii?Q?lIEdLQ3Hs6jFHMI8v1gzNixkxIMhIm9ryUPWdq6HZiBi3zD4R9rXDST1qhxG?=
 =?us-ascii?Q?qSBl4p8sqyPejxZLZaklYbAL8PgZLKrkhVoo2EM/R/qCRV2NEihC5r47c3qT?=
 =?us-ascii?Q?wsmZZYmVR3hO8R0h+IsalP3FPA0XS/cbCZrvkDuElEm1SEHkQi5UI+8abyzx?=
 =?us-ascii?Q?uNTtZTfXpAzgUCGzdWsjqC34dQZ0f1NtOgMcCHTR8tT4AWN/fPH47nPDIiQt?=
 =?us-ascii?Q?ES898VxoRalfI/MI9Qz3rcPfVfdj6v+bT9LcI+x++r9PPTcaodIgIygxxYjK?=
 =?us-ascii?Q?WjqUKtMZkQs0Sqc/ct8KYQzAPN9qLSivpR7xRqeI8hXVGlMyD0lFKZR3vQJX?=
 =?us-ascii?Q?gVTcxZGHR6dDOCn0a8D2NIiqq1VaOWKXuj/YZ9uFpRswABb9AevHxkMFBcC0?=
 =?us-ascii?Q?F0MC7A+7QimAG9vDBkjCeLDWHYR5bca4ixW6pZOAWGohTus7Qh3cXja159RM?=
 =?us-ascii?Q?YObx4uHqjnGRfUCYSjrdlRbEl2S4b/yZhk14PHYiV8owj0T6WMEdntkWlzTm?=
 =?us-ascii?Q?Ge8qqFJTd8tK1WqX+4xG+mq8NCSV/maoTi1uQpxPyX4+7uBvodJmZK7qyeZo?=
 =?us-ascii?Q?NxZ3dxNXXZFWhPq2NHFaHfQMzRgfb2TlhqlS0lcYi/JRGbGtwHy/6/Qs0s4Q?=
 =?us-ascii?Q?Bmfe0knpLCZXIQEw45p058HDvbNrNKwR9tEyItYeX1RSp5p7b4SxWNVP14Ou?=
 =?us-ascii?Q?GH/MytTK10pRDD1qrNAOJ4NoiD2e1pjQAYSx3PGGXZ5ammi5fszOHMiVx/jD?=
 =?us-ascii?Q?o4kOQcNw9/iQWDvGR7LPcu19Z3JIHS+ELP/MrKaamLkUKZEcFk6Ss3Wn6Wod?=
 =?us-ascii?Q?bFEVGbGR5Y1PFzvyIM77MN6HxXryOMaIXN0wh5EpwvjsjEvaISSs4pzBMgUp?=
 =?us-ascii?Q?GHoKXU1gpiuNZHjNj2KTRhLmd47FjmVNJyKXLKx3wzBAnS9l7PVQ72/UNDT5?=
 =?us-ascii?Q?wk3EkGHVJVRTiU5DqwAielvuSg+YilUbbOiJ4MLufVGgiTs97XNkXUt5uzow?=
 =?us-ascii?Q?nR9CEKEk7LDLUR0iNbIGAmWOXLWGq68ZBXn5daCrFxV1mMq4LDkwuhq/vI6Q?=
 =?us-ascii?Q?I5A+hX97A+BH+uGf6FqeSKhdEvAw0hDCihNpfMwOLw73o3hoYAW4SokR+/Gy?=
 =?us-ascii?Q?WdyKz+W3jWJhfH9WkLdNxbP6Rvbqm8Cd2O3csiPzxxaipcOJWe9HHjQYJhR9?=
 =?us-ascii?Q?GUP77we5APDsTq6EstNeBFquiOiMyT9HRG3BO6eSnFmJGoc5togKzQ+T0714?=
 =?us-ascii?Q?d6XphIMfLKFoBz05O+IKPxfSHe8Ria2jdEP5/yrTMnPkJk1Z0FSUCulumwgx?=
 =?us-ascii?Q?NAxA78dISZQMhQsH2uY74YyHErFjGEgy6Lkv+fW6wn72CTHe7LR234ba1J2m?=
 =?us-ascii?Q?BBd7VqwxnhBfqYd5l3dY0RUDlAeWez6F0fLGZOEs0ROOzwhobNS//HpiBHjr?=
 =?us-ascii?Q?pGpDve2SjC53H9HCwsJ27enzHQ6SDdb9h88c41SAfgZ4ilV7c6cc/sQScqy3?=
 =?us-ascii?Q?ZV0ZkSYNEp+J643Xt7ud+O8VX37K12zeLe5BL4DjRsCd5GfvtsjOO6eCFwKi?=
 =?us-ascii?Q?+aqVTSXI9vytZRE8z7w3z/MzegJzlwyUjaZ8ZAJQVq/x8ndUeeHtvUSpKtTr?=
 =?us-ascii?Q?e9/kP+NGRrLMQj2SioJC+P6P6uDt9Rithz7lPNWQEar+mknc5d2B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af745f1d-1738-4b78-9ea7-08ded8efb28d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:41:53.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBQWrBXG6aPD26U8OM8mxX+GBVsqWXAy0M6eJLTg0/X2wg/rFLhMGrdbVpu6gp96z2957UXBllUlYSh4VtHY0bjHCbCS4JV3xUb4Yw1AorquecVAURFF7uyBr7aYFUP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304490-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E34E701758

From: Wei Fang <wei.fang@nxp.com>

The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
multicast promiscuous mode for SI n. The only difference between the two
hardware generations is the register address offset.

Since the register functionality is identical, the MAC promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
register name used in the reference manual, and extract two new common
helper functions, enetc_set_si_uc_promisc() and
enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
from enetc4_hw.h, as they are now superseded by the shared code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..6a8f2ed56017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -69,8 +69,6 @@
 
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
-#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
-#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
 
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..304ec069654d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,24 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
-
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
-}
-
 static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
 					    u64 hash)
 {
@@ -515,7 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	enetc_set_si_uc_promisc(si, 0, uc_promisc);
+	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..07b7832f2427 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -29,7 +29,7 @@ static const u32 enetc_rxbdr_regs[] = {
 };
 
 static const u32 enetc_port_regs[] = {
-	ENETC_PMR, ENETC_PSR, ENETC_PSIPMR, ENETC_PSIPMAR0(0),
+	ENETC_PMR, ENETC_PSR, ENETC_PSIPMMR, ENETC_PSIPMAR0(0),
 	ENETC_PSIPMAR1(0), ENETC_PTXMBAR, ENETC_PCAPR0, ENETC_PCAPR1,
 	ENETC_PSICFGR0(0), ENETC_PRFSCAPR, ENETC_PTCMSDUR(0),
 	ENETC_PM0_CMD_CFG, ENETC_PM0_MAXFRM, ENETC_PM0_IF_MODE
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..66bfda60da9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PMR_PSPEED_1000M	BIT(9)
 #define ENETC_PMR_PSPEED_2500M	BIT(10)
 #define ENETC_PSR		0x0004 /* RO */
-#define ENETC_PSIPMR		0x0018
-#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
-#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
+#define ENETC_PSIPMMR		0x0018
+#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
+#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
+
 #define ENETC_PSIPVMR		0x001c
 #define ENETC_VLAN_PROMISC_MAP_ALL	0x7
 #define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..a97d2e2dd07b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -159,21 +159,17 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
 	struct netdev_hw_addr *ha;
-	u32 psipmr = 0;
 	bool em;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* enable promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0);
 		uprom = true;
 		mprom = true;
 	} else if (ndev->flags & IFF_ALLMULTI) {
 		/* enable multi cast promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_MP(0);
 		mprom = true;
 	}
 
@@ -211,9 +207,8 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 		/* update PF entries */
 		enetc_sync_mac_filters(pf);
 
-	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
-		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
-	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
+	enetc_set_si_uc_promisc(priv->si, 0, uprom);
+	enetc_set_si_mc_promisc(priv->si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
@@ -474,7 +469,7 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
 	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
 
-	enetc_port_wr(hw, ENETC_PSIPMR, 0);
+	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..b0c0dc668e34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -87,6 +87,50 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_UP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_UP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_promisc);
+
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_MP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_MP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..a619fb8fed9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,8 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


