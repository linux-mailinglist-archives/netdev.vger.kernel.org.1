Return-Path: <netdev+bounces-304489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NSJIO3eUR2owbgAAu9opvQ
	(envelope-from <netdev+bounces-304489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCC701738
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:52:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="euTMMd/T";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304489-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304489-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1F813075967
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930903C8C48;
	Fri,  3 Jul 2026 10:41:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409713CE489;
	Fri,  3 Jul 2026 10:41:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075312; cv=fail; b=rcPssZ3RRLOOW+irvXlnYROE+RdMpBj1UWCleCEcH52bnb4O7DDyqemlL022vHnJv3NE8M78itz/moXI9khAm6QZzR60GBwd/OBKtBopXz5zGk/jNMpe7S4UBhiEeFjditlnSh+n5I5+pEkFApiL7Na9cGTg4OpP0NFlYYvWKkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075312; c=relaxed/simple;
	bh=6gaiVf8yteHnL4vm6ljTIJSd4t+MfOCj3j0KzUweELc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GvarRpk4eIekC0SeuA8dPhTY1or7dSin8C193SDzM92ggxcWG+Xx9mmwBsVeoA8JmXXNacdRm4VT4e6PZJd0q27PCN3zC6j85ICgSLYcFKjewlVdGddBJVuz0Yay8vIDSf8EZHDdV6EYz4g32yzpI7av/Qt7X7SAuzUOPqxuTd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=euTMMd/T; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTF7qIlZXodupflGFlkFZj///LOjlramIYVDPfwLoWZWWlk7P0hK36J4SWYbjnnFDUSbYw24jj2DOLOz3uLzrduGF0W8YGZQRj/M3fuTgi4chDeFyTD+7XbNlVBBL3OzrUxyqM9WfQaRosIWi8Gb9PznsuzUklZ/zzGj7X5ZiYNL4UbBkIWSoLwbyWwM4FAUzQXPUfmrxzwWTVpRqZz0HG1cdA4qijEz4i9iFhE2enjcCgaE8rMuCiTTAXFztlwjD0z8XiYG8y5y49hERukL8C7p7n1FeKRLVEz8VyOQn/SA1ayd1igVGyAgP60BbeUa+lnj6wLwIXW9bnNponyJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr7g0vGTjY7JyNqWCSffK40WR1pTE+c5LTsuZA34Vv4=;
 b=AZJYuyBKyiQYUwcO9RpUHVg2hAtuYKGqtG4k8xZ08xPV0QWUgI11M+ilEJpLKG2L0/ryz/jO8sAYjddMuAnMvJuJVOxEQbDGolunzerlutbi+855cybBUVqSuMfNcq6bPekFN5hB2N7nqHJsFQTVqZ2n/pDWvvS8Zz0Z/Twgkd7fvLbwmxCJAVpJQSwCCZzepKkX1DsLmtxVeseR7YKtaGS9Q9CEV+hmgZsv0TtNx7D86xXwbxdNtv1q5Q2SqfjBTpxn0m2Xy9tGuTjbalxnFN2K8vh0+zNfRedcc/GNsbjJuHa+4RF/4d7O9LMHs3HmcLgtK9ES43IlO2NEwOq0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr7g0vGTjY7JyNqWCSffK40WR1pTE+c5LTsuZA34Vv4=;
 b=euTMMd/TjGqqNldNJ6zHDZCcvMxsHa9Y/zLIouIlC3Rf4A3A42h3heBxui/qAvBtkPUbEiudsjSIN0lbj2UHwBN4w0KPBVFnT2lCzIkPq1ENTFwgeac69CM1Ho+gkAZpQQgxAZ/CP5kjy/QR42uQt9PECSPpJlrwdMy2nH2LKaDxnlA0vGEda0JNz2v1AHrqlxbtJ+YHb4rUcXJCJJHyaCEGh2JAsuatcRdzGQCsRa3WgCiqDhZivbPKr4LzkUhvmAy7wXiXJohYiRQjvGYSn2ktKRi8TxRYhm55xjzhBs5BaPHnCQR01/2bsMOB8/hGPWkcU5ZhZ9t8mCYXtDuyXA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:41:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:41:46 +0000
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
Subject: [PATCH v3 net-next 00/14] net: enetc: cleanups and improvements
Date: Fri,  3 Jul 2026 18:13:14 +0800
Message-Id: <20260703101328.550714-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 64910e44-c272-4756-6fee-08ded8efae33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PswWCAD4QyasXCC4C7nVuCZ0pJmQaErAVi0CyDXnayZFCiwEj5aXvw+3CrDcMH1PaUjnIik+WG7a3WQ20Hyov6ejpf+ESLY2YlkZJROBH9Ft9fNdRYZ6a9o5sWckJbq5Ghz/uTJUTWrLaVfgQvdakQgfIUtZdiwFxCt84Ny6eqpFW7iDs8HiJwAXBMGqqPHJ6qX7SQYSmgr+bmYPv/6blQ/c/hA9Um7uyQSSh0ikfN0pTMET/GlPRcIpJTubsKgrwUFn8ay5y3GXwOuBoML4mNx5bKW9nRYEgIoRjRKX9bGcIBveOpSRtWW6TmCbBddg6GCWl0PcvX2HC38ROnGNxF2HygkikYHOzjSg0Kth/bLjNg1stZioXasBuElTUJTEnl9iwCGqjdx3z4uUcEz3dRjObgO4J1JLMbJ2oB3liMijCeque6ovbvgfl9TCHZxWUJ1EeGlYRcCkp9B66TAgb79P9lOVr6xr9HZn2Rdwk2sPN3OqPwvRiptfA/T0MSEwbNkV70nD9QyFNU5AO5sP7gYC6tMTG4IdGmJetLAM0hwr2atQrQFPVoqIVjYQzvMMTtC7gTf8r0AaWcEDrw+O5RqwCOvBx/qGo4uv8fvg1H9zK+RhIHpdQ4heS1CwT8F049E5V75aXOxfxFep2ZVzjzLwpESWA6l56ppyGYIAbxCEVJuuU4BiHKDFar4EYrCvfuDkaTange4X6DfioycEhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NrXDrBC+5lkxIrbQKmNIGMgOQ60JpwATpob1ymIo/GFZHB8U5whacBGBGEG?=
 =?us-ascii?Q?C5seOCv+sa6E8qmjUXoJYflFcr1hHfTJCnIrws9z3mrNVKz3lJ+FO38FNxf5?=
 =?us-ascii?Q?zo9uZUbw3buBnBzBSv/IscpPZJ3g8S8VdtO5sbfkEf8/aurlyjYvlcs+Nhmy?=
 =?us-ascii?Q?hly9k2eRIRPThE3b7FXmIgdlaPRj3n/Se675VD0szEHlRt1hhMCdO/p/2EjK?=
 =?us-ascii?Q?3Wc1wZBB2dC42gmKxG7EAgQiwkxMkjRd50A9/+vrfJWmBxaQlNibrnIcPQTU?=
 =?us-ascii?Q?mkfW1tzXhnTDSWe9kKjANh1lHaJr7PnBE4yeklB7i0YZfe0NbTa77Nj6sQES?=
 =?us-ascii?Q?2PU0ff17vyuDqEYqcScfAELAJhgoPvxFBQeT178WN6/CQuFTj63DxDLbbPDK?=
 =?us-ascii?Q?B0WXaN09DxSHF6DyAzWEpdVdQYE+5rGgutOVjbavAK9HOqJBjHlF1wB6Jg6B?=
 =?us-ascii?Q?GbiL6qImJncRUbH4IfkoodtX0sOIEKHm/EjgQfxqTfSau+jIpy4J8bdnU0oI?=
 =?us-ascii?Q?8zMQexOKYEWtKQUtMtr/EhGUtUvGyG1soIWPhiExg+/mTtA766AOt1iWl1vP?=
 =?us-ascii?Q?PnyZY3zs3JHTVdftld5LN2GYlT5vk1ky6MRKJPS7D8acgKvBYe9vm96LegCT?=
 =?us-ascii?Q?QIjjASiwZ/MGablOMLCFyXopzumUJw2JtX2tyGumu8klbSUKKFcCsCIImLRo?=
 =?us-ascii?Q?wONAbaIfQzLrLdqL6nMD/shjLuX1HHgpaEKkNOCdNcp+XrjY3LSFmrP2YktP?=
 =?us-ascii?Q?EGj/X3PtCL2PTYuW8jy4OIJclp4jOKfkaGOkWHzhgM+2XYjkckNWu3lT3XG8?=
 =?us-ascii?Q?g2WvkLGom2OmroirHfeV04TENC/HH9Z/5hNgRhxW3F216hWrS5yReZ3On3bW?=
 =?us-ascii?Q?wEcZKvU18GI/A2cicV72Sgvt7KSqz6Gg72aIbax0FlR8smwGYRhO/t7YafJX?=
 =?us-ascii?Q?RfEqDr3bmQ5u0OJ6+RZArsg4/e4u8q1bSQ7/g/iXt1VLZipoC5lD4PiAchiq?=
 =?us-ascii?Q?wsf9E+EHWzG7dw0tIzvQ+GkJRTS9TwrIKlMP4RdEfS4MgCqjnonTTQiHWxYU?=
 =?us-ascii?Q?GSDHEW2EOafXfLk88n13DUX+bnfOmwsI6AWvNEvOI68p8e0Ysa1aULK2qJzr?=
 =?us-ascii?Q?BYH5FuMZlXPUmMREsxYSdqX524CjLb/DyVmhZSM+DcY2itpe4/3aXiayPZEp?=
 =?us-ascii?Q?J1kX1TpwWbcp1zoi6TcONltSVpt+OEhpZ2gOfBdQOtpYkB15AUKX9yUR7o+F?=
 =?us-ascii?Q?FS6XpQ0H88lE5c/9eEvkncGvt9rBniax8Olj5mtW6N0Nkj5ubAf4qxJXzXVa?=
 =?us-ascii?Q?GaGlrdbDUWPLQUEpoBzZ6WYJyg4IAavHOjFyqCGkNeBIHQFY7W3At6fm3hYZ?=
 =?us-ascii?Q?FmAzKdJg3qQF+KL6em+inwJ7HZRR3XxfXtRWs8rQUzi6lOs6mA5Nxn5LWuxa?=
 =?us-ascii?Q?Vr+k4dY4WREichhEOqfLHHiPaeHMAQ+KUxxHelLb38EkSnKDGGLxJqJTYvah?=
 =?us-ascii?Q?7vhkOmNmP6upKk03fmr7ed3kH9KywOJCDI0OsbshDfK5OWzoyOH1JEEpF0fQ?=
 =?us-ascii?Q?xmNMsiaejzSHXdgBcLDzavWdjVJYDGUYc2vRaHlFVRpjyX9Wq3d5Kvm5F1Sn?=
 =?us-ascii?Q?oBFVWb/0Mm6sKWBROazN6e2MvZs2d02gUtMfBl+HsCg7GcPx0xNkmXLeuvdI?=
 =?us-ascii?Q?Ja1rMI/qZ28so58DRzENvpDZ/zb9I/UiPsOuNrAplKCEEuHPqFV0YDqXm4qf?=
 =?us-ascii?Q?Nd+uK3km1IPSCKkGxJoCX5I1WOw666Pu2GXNem53cWtwMJrsr+aE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64910e44-c272-4756-6fee-08ded8efae33
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:41:46.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzzGIyCxwGuVCf8nV+ox9gBekW8HCvv4nW/SPigAMX83NsQi89Rsy13WKuqf2M9CNnc64pRJJlXfwt23KHZFln10HgHL8PF1/SbSQc4ZFhQVuA65lSpAoYfO/QAsNV/y
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
	TAGGED_FROM(0.00)[bounces-304489-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8DCCC701738

From: Wei Fang <wei.fang@nxp.com>

The first group of patches (1, 2, 5-7) eliminates code duplication
between the ENETC v1 and v4 drivers. Since both hardware generations
share identical register layouts for MAC promiscuous mode, MAC hash
filters, and VLAN promiscuous mode - differing only in register address
offsets - common helper functions are extracted into enetc_pf_common.c
and shared by both drivers.

Patch 3 converts ndo_set_rx_mode() to ndo_set_rx_mode_async(), removing
the dedicated workqueue that was previously needed to defer MAC address
list updates to a sleepable context.

Patch 4 replaces counter-based MAFT entry tracking with a bitmap, which
keeps hardware and software state in sync and avoids partial failures
during entry allocation.

Patches 8 and 9 fix phylink-related issues: removing invalid code from
enetc4_pl_mac_link_up() and properly differentiating phylink capabilities
between pseudo-MAC and standalone MAC.

The remaining patches (10-14) are minor cleanups: removing a redundant
VLAN promiscuous mode initialization in probe, using the PCI device name
for the debugfs directory, simplifying port speed configuration, removing
a redundant num_vsi field, using alloc_etherdev_mqs() for the VF driver,
and using kzalloc_flex() for a flexible array allocation.

---
v3:
1. Add a check to speed in enetc4_set_port_speed()
2. Remove PHY_INTERFACE_MODE_XGMII from the driver
3. Restore the VLAN promiscuous mode setting for all SIs in probe phase
4. Remove half_duplex field from struct enetc_port_caps
5. Limit the maximum value of txqs/rxqs of alloc_etherdev_mqs() to
   ENETC_MAX_NUM_TXQS
6. Update the commit messages
7. Collect tags
v2 link: https://lore.kernel.org/imx/20260702025714.456233-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260630072036.382761-1-wei.fang@oss.nxp.com/
---

Claudiu Manoil (1):
  net: enetc: differentiate phylink capabilities for pseudo-MAC and
    standalone MAC

Wei Fang (13):
  net: enetc: extract common helpers for MAC promiscuous mode setting
  net: enetc: extract common helpers for MAC hash filter configuration
  net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
  net: enetc: improve MAFT entry management with bitmap tracking
  net: enetc: use PCI device name for debugfs directory
  net: enetc: simplify enetc4_set_port_speed()
  net: enetc: remove invalid code from enetc4_pl_mac_link_up()
  net: enetc: open-code enetc4_set_default_si_vlan_promisc()
  net: enetc: refactor SI VLAN promiscuous mode configuration
  net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
  net: enetc: remove redundant num_vsi field from enetc_port_caps
  net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
  net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation

 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  42 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   7 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 424 +++++++-----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  94 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   6 -
 .../freescale/enetc/enetc_pf_common.c         | 150 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   9 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 367 insertions(+), 394 deletions(-)

-- 
2.34.1


