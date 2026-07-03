Return-Path: <netdev+bounces-304491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C4wsHAqWR2qYbgAAu9opvQ
	(envelope-from <netdev+bounces-304491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:59:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C970186E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=gESXRTmo;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304491-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304491-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13C32305B973
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2793C278B;
	Fri,  3 Jul 2026 10:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6ED3C1F5E;
	Fri,  3 Jul 2026 10:42:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075325; cv=fail; b=gqn0QOfsvZjD5jB6sShLELufnrYtJ62BY6G+fVLT3obaOvCvq6+lO1JDnYboC5wZF7b7LmfmVZvRgdFo2kwYQq65jTz+eIjhykuZMmoatVyTmp7ZX46WlCDw0Du8rFLExg09mf+lUCbfWFkOXtoWJMdzsWvb4ildJ/vBYfZfqyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075325; c=relaxed/simple;
	bh=Ui0fPZpEKH2pqDQlGtaewPxbsv7L8xlm378do7zLBFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nw2bqEq8JaOWiDc1E21mUhLt7INwXiuR1Y07jfoGZLTjFa01mHQ9TawaL9BZlK66vXg3I93cJPPDQwi1pvxymVZ3ZLhpJNebKMoAT6DtW9VrHOqK7F9s/9MrOUOqF54R+FhTsaQ9JPCDRk+ZGzd4RTVsFxIX3D9gA8mRfjmnl/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gESXRTmo; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5Ka6XgY5QL8F77NIe/88/QcYPGxvR29KEQgHPQyoL+YNgBV5JNByBvAUe0yGORQSts7NHLD0aSBKM6M6GA82bt+HctIfBv6L6jv4vYLKTB7T2Ql6QIKVbd0/M+gh0WffD8Vo4qwNzb1NmCkWHFL0EYtUHjNExKuj9gMhKebPOKcDZw2nNiGCI7rH8bMeH2X4mIvkqenBO1WBENogMF8E3EWRmKI1EIljDbvBoyw5biIoEfBb8zXIUtUk/a7Fdv7F9Y8RVlkcMLI/NAJ4w4cjC4ddH2x3Q2960epPfYdMtLKS7iDwuEk6pjnoxX5bH7lupZJYpsqLG8zUDeSe/UcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=khJsHxC7MBD18Lus9dl1gRugP1OZhSs2XvpJ4LBW5BWW+g0Vqj70ZAsuxkZK6EqLEOr/wV+w92VPXQS0n1Ozp1UIDCosNRFGDOej2UIo/D6u0/K00b0fkI5EYQEiz374nmJp4bZZNZbvnvTblbvJwvl2DdtUSIWoQ2tJSflCun99IEbpMMTOXJpusbaKrshlnnBfcE2xCQ6sWNL15EjXpf1x6rliEMBGtF7AK8GiYimmP03RPUGCpSTv/aGilcF4hi4mnqbNiZ+VbfX43T1AEht5iL4uJJIrklSXbqc4WrEUYcJPC6q+U/mCLo+zJURk4wcruHAChiBzG4CNObRgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=gESXRTmoQFVT4+GG3PkqgdnkBVd8+fQ4xI9AhfWNT31OMazZpHWWi1owV8M25tNNX1ftEEbb1idSAm1iMyglX01FCnOdIQqCY0K2e/X51Jb2Xn3SYxm6tNiudGy/ekIQzxD+aCu6HWeFXcmDmJP+Ie5x3tjpGBTri5vYC/ufdyFPrcRAc5O3wZ1ht4gy7FiwyI5DIfDfYw8TDNiR/8HLdEpV7UsywfhOpShrSV1RGr7U0G6kyHbBxVt636Tvr34md57AzfckZLjnEvyTS/nzeKSjrU6aLOUBbl2HePF+CFfkMykMjmyOBRba9ihPIkiWzzPG/KQOxZOGPiruuGLcPg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:00 +0000
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
Subject: [PATCH v3 net-next 02/14] net: enetc: extract common helpers for MAC hash filter configuration
Date: Fri,  3 Jul 2026 18:13:16 +0800
Message-Id: <20260703101328.550714-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0264.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb47b3e-04db-4748-65e9-08ded8efb696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Kg4ssAX88A51/TYdvj3y5Mg1E4Dbygqv365I/hoIf1FJxrlEwJ3e+631ozzm+pc8OtdHldO2J7caQ5Mmb6IsIi6PG2T+1rBu9OCqbUtRRrWqd/xQiPMf5qmK5WNLZF74RtLOodQvNqZLGXN98Dnpmj3Fdn8qa19OA+uyo5g5IJrl/C96w/c7mjSCdLaC9hyQuqShc7G/lNOZ653cLLAjlqO6UV+gi7Kjb8wmQ0YqdysUooPvX010JrgEdsdqgrECegav2tfvpb90nsDOyuaO5wi+wHXZnNO3x5iboOLLiQpXYRxMeSDW0qct2mq//Lcfg5dtUMibAshcqkmxlJuW6Gkr4ViV+Qf1+j9klMsPJECXeMNYnabztPH4oQnwbN6vQPgzz0ghewk8sXaFjx/a64FnfSM5Zbxbrh3hOxCzCTv41y7IO2+yAPUuiQXL+yJ9LbpJwkmAYuzs9IrA52IP6A4Iu+SpIHiJQrJOVjsmoLWtph0ko1fhKs6z15DC1muScWKzXGnE1I0nFeOKKM4IU4sUGNd6UCja4xlu5aBxATl9H7gDYjiQT4hSSwZkb5ZZQbdtXZPOqpL52TAWTegxErTllr4bcyrR5d7+I6wtTDimGbuf4w2wOlH8R+whVaq/796nOIILIIpL7OOR1r+6gMkNOWeCeK41vzl9p20u2AA5TbtUvZGAuUZulvVpk9nct+0/XWDybjx1ftIU7N6NuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58GhElenC9wiZ/fpLwgQZEkJv3MpK4dkbju4yJWE0CAf4PHv0lWemCeqkL0Q?=
 =?us-ascii?Q?09IEFVas61drEazB1wbSv02WNlxhGjrYjD32Sg+2TzkMmWvFcZUJsQ6fvUth?=
 =?us-ascii?Q?XW2tDQDzWaiGPghivjyKtYiwu4FHqxTIaCrStZObjAus+pkYeMK7tlzzJvKo?=
 =?us-ascii?Q?apz4/IlbBWtDS2G/sswn6M5Dvt2cxAty+fPaRKPDKvzRH1QJwtpcqvLO9tgA?=
 =?us-ascii?Q?Pznzoc1/Q8B5BR175CQaYVxnQEjtAZ+qbfseDo+Q5fGIrqqG0pAFj5MMJ3e+?=
 =?us-ascii?Q?5PuM6eQUpalEiCSC1UB0NT3qDqLBAPb9V6CQojxLa3DxlZ4HOCOGITBtmCdz?=
 =?us-ascii?Q?YlWz9u4Fus6QtPQ7ajlB3QEyVekF3bkppgK9ETcmIsEV9t03e3ovSz4K/lyE?=
 =?us-ascii?Q?9TUhQUGRA7t9herMt/aDuenm3C3v14E7xKC5Gv7tsse9s+Sq2FqZeVzSziPe?=
 =?us-ascii?Q?fD4pT9PhvQRrhMcXv7X6Q6mx5KFO/tLRVV2mTXSaMiJA+GyXPPhzgA3pkTc4?=
 =?us-ascii?Q?4NTzdpaxrimm0apcUBfpnWNntaWaf6yC1XKE2prHXpv60zMdbkO/bET6hif+?=
 =?us-ascii?Q?fr0VCh+lr0Kyb3LfeVqE7E5JVrWifUFYLRSKP38CC6Yx4dq+i0f2VMmxzWX6?=
 =?us-ascii?Q?7oIzOcheisuXcpBo8leKwYBja4yVDM+jas+POkKAaWHhYRsR/Dnk/N+9UyJ8?=
 =?us-ascii?Q?+ng4xzyL2Th35VV459owdxHM1R02Cb9k8mHl9Cb5geuFiMnmUfMbsIqNQdNs?=
 =?us-ascii?Q?zp6QRienY+yN509V4hiVUC60yn5LBfBQUBcLSnwi0TvLe8//VmyelOIfAHdL?=
 =?us-ascii?Q?TOedeHwHFioOCMaaNkw/GcW/aVXDSvT8IZitB2MQoYrodg/VtT6zbBXe9klx?=
 =?us-ascii?Q?jtMOE8p5PEcPyaGGzE0eQEm9v36SXKn73s5yucm++OwDoosNH2UyQ+wwarRA?=
 =?us-ascii?Q?CSXxJJhsbuuHGlUZ7gM/x/Woa1AiQxJPIltKlht6TjqdTvGcxBYYoeaSntKA?=
 =?us-ascii?Q?+SwPdAO3lyZD54+Lmz0SCvu742qyU76hlxEl70lJzTQgvejL991LyTU2uq9g?=
 =?us-ascii?Q?JWKkfXJL5trTLRUdKvauVG5cWTr+DGoB1WkqLLPbV6R6V7KLAkNXqSBnOwOQ?=
 =?us-ascii?Q?Ry7GQRYjdYWFeZqG6lUOXeQ6D6fBLz8jHTqKMRaFYeV7FNB2NjyXheFfb183?=
 =?us-ascii?Q?SISr4FmaMrEmX6kBgNqdAqodglmWHhkBm+71a4HBW8AHLxO9Need9HfldFdA?=
 =?us-ascii?Q?RcQIUczhEJAy74j6RewBvgXsg8s2e4neeyqpauroXKNHnJgC/acZp3koJUZ/?=
 =?us-ascii?Q?hRT0kS1Uh5zKXpIbBX8Iao3pHRs3gakuE8BTHbh3CAzSd0eWIyqt0agPnkcc?=
 =?us-ascii?Q?Ypug9PtGESRC1zRbofuJWfHdUbwlUEjD3JkYjhrYE1wut8QhaY/JSCOLVsbx?=
 =?us-ascii?Q?uAbaM3OR2bpWAuoKGVTyZplhYZRES7rP+pBGH/LgNwFHhoLZrdBUp5yBLdYF?=
 =?us-ascii?Q?S+++aN3V3Ut80u+alBtVjPZsxL7UDaKlq3tXpdVgej94s2rF9gwv3qbdqEMX?=
 =?us-ascii?Q?0ve43W/S+77T2RnhKSAyVP2u6iwruZ9FzP+9x5F+Rnuqp6bdCkMG2Vmo++5s?=
 =?us-ascii?Q?hYaaonAnuZc/SHGDJYfODiRFK4ITgZK8LdlKWzbpzEH09WmeeqXE5nzt4O6R?=
 =?us-ascii?Q?GXDeFSsWb0BOyo59F9CYA9GgceaRl8LoA32aAxYpp1Z6MJrSJA/osXMycu9z?=
 =?us-ascii?Q?PNPNPTxbwUdOk+xUn9y0gdVm3qXKgj0WUQDszV5lLmDM+XhJ+qst?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb47b3e-04db-4748-65e9-08ded8efb696
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:00.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RmqmB5ZdoInCski2PYUXsySKx2QG+5NK4fNI/NTOCOhJxpQP3uqbefYlPqakR3CcMcIhp2aapCG5opfAJKYyogf712A0QFd6c59ZHjbwXMdXM5qDqWp95qISVlqI2x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741
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
	TAGGED_FROM(0.00)[bounces-304491-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 602C970186E

From: Wei Fang <wei.fang@nxp.com>

The PSIUMHFR and PSIMMHFR registers in ENETC v4 have the same bit layout
as in ENETC v1. The only difference between the two hardware generations
is the register address offsets.

Since the register functionality is identical, the MAC hash filter
configuration code can be shared between the ENETC v1 and v4 drivers.
Extract two new common helper functions, enetc_set_si_uc_hash_filter()
and enetc_set_si_mc_hash_filter(), into enetc_pf_common.c. These helpers
select the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove v1-specific enetc_clear_mac_ht_flt() and enetc_set_mac_ht_flt()
from enetc_pf.c, and v4-specific enetc4_pf_set_si_uc_hash_filter() and
enetc4_pf_set_si_mc_hash_filter() from enetc4_pf.c, as they are now
superseded by the shared implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 43 +++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 51 +++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 40 +++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 304ec069654d..48a74db90ed5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,20 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIUMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIUMHFR1(si), upper_32_bits(hash));
-}
-
-static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIMMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
-}
-
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -147,11 +133,12 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	int max_num_mfe = pf->caps.mac_filter_num;
 	struct enetc_mac_filter mac_filter = {};
 	struct net_device *ndev = pf->si->ndev;
-	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_mac_addr *mac_tbl;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 	int i = 0, err;
 	int mac_cnt;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 
@@ -159,7 +146,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	if (!mac_cnt) {
 		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 
 		return 0;
@@ -186,11 +173,13 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	enetc4_pf_set_si_uc_hash_filter(hw, 0, *mac_filter.mac_hash_table);
+	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(si, 0, hash);
 	enetc4_pf_clear_maft_entries(pf);
 
 	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 
 	kfree(mac_tbl);
 
@@ -206,8 +195,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 {
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
-	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
@@ -216,8 +206,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_uc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_uc_hash_filter(si, 0, hash);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
@@ -226,8 +217,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_mc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_mc_hash_filter(si, 0, hash);
 	}
 	netif_addr_unlock_bh(ndev);
 }
@@ -480,7 +472,6 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
 	struct enetc_pf *pf = enetc_si_priv(si);
 	struct net_device *ndev = si->ndev;
-	struct enetc_hw *hw = &si->hw;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
@@ -501,12 +492,12 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (mc_promisc)
-		enetc4_pf_set_si_mc_hash_filter(hw, 0, 0);
+		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
 	enetc4_pf_set_mac_filter(pf, type);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a97d2e2dd07b..db2a800a7aaf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -80,37 +80,6 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_clear_mac_ht_flt(struct enetc_si *si, int si_idx, int type)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx), 0);
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx), 0);
-	}
-}
-
-static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
-				 unsigned long hash)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx),
-			      upper_32_bits(hash));
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx),
-			      upper_32_bits(hash));
-	}
-}
-
 static void enetc_sync_mac_filters(struct enetc_pf *pf)
 {
 	struct enetc_mac_filter *f = pf->mac_filter;
@@ -122,12 +91,16 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 	for (i = 0; i < MADDR_TYPE; i++, f++) {
 		bool em = (f->mac_addr_cnt == 1) && (i == UC);
 		bool clear = !f->mac_addr_cnt;
+		u64 hash;
 
 		if (clear) {
-			if (i == UC)
+			if (i == UC) {
 				enetc_clear_mac_flt_entry(si, pos);
+				enetc_set_si_uc_hash_filter(si, 0, 0);
+			} else {
+				enetc_set_si_mc_hash_filter(si, 0, 0);
+			}
 
-			enetc_clear_mac_ht_flt(si, 0, i);
 			continue;
 		}
 
@@ -135,7 +108,7 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 		if (em) {
 			int err;
 
-			enetc_clear_mac_ht_flt(si, 0, UC);
+			enetc_set_si_uc_hash_filter(si, 0, 0);
 
 			err = enetc_set_mac_flt_entry(si, pos, f->mac_addr,
 						      BIT(0));
@@ -147,11 +120,15 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 				 err);
 		}
 
+		bitmap_to_arr64(&hash, f->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
 		/* hash table filter, clear EM filter for UC entries */
-		if (i == UC)
+		if (i == UC) {
 			enetc_clear_mac_flt_entry(si, pos);
-
-		enetc_set_mac_ht_flt(si, 0, i, *f->mac_hash_table);
+			enetc_set_si_uc_hash_filter(si, 0, hash);
+		} else {
+			enetc_set_si_mc_hash_filter(si, 0, hash);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index b0c0dc668e34..3597cb81a7cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -131,6 +131,46 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
 
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psiumhfr0_off, psiumhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psiumhfr0_off = ENETC_PSIUMHFR0(si_id, err);
+		psiumhfr1_off = ENETC_PSIUMHFR1(si_id);
+	} else {
+		psiumhfr0_off = ENETC4_PSIUMHFR0(si_id);
+		psiumhfr1_off = ENETC4_PSIUMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psiumhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psiumhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
+
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
+		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+	} else {
+		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
+		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index a619fb8fed9c..bf9029b0a017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


