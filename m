Return-Path: <netdev+bounces-286528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /dpKMkuXAWq9fQEAu9opvQ
	(envelope-from <netdev+bounces-286528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190A50A476
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8571B3053DD0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0B3C345A;
	Mon, 11 May 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZzXhNpK"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DF3BFE5C;
	Mon, 11 May 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488551; cv=fail; b=UKz5kb7J/ddrgbJEtxnda4gA3ExSPt0MC3PCqm4wiNctvtPjzfz3uMO0WPtwPxDw0S1GpQyzlTUHhae8Vbd77ADnc9EgUbdOHsrNLC7jM9qoJacBJDrlNVOmusjy1TuLSBTU0o6bwdoQK2FLIGwvreKu2PY0EddQOB9nGAc13H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488551; c=relaxed/simple;
	bh=5S9vTN7dtMBvn0tuT86H/z2mD+c5GtieOrKAYlHi9MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMVWxQxlnrLp4rlbSmxL0kjKQx/6Tpa4HIgAtlif3oDbnG0bqsM+6cFUtUWSyXkppRTKz74WUONslbFLYDywgQZ6X/jMSyb+NvXkAy5tL7uEpi9MZetwZu8tHimIevaL4pk69YQkvcnAHW19PWtg3DI2C+dkgVmNyq53YmMAShU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZzXhNpK; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkpnuBb3SMHIHIOzdLWCNwDPH/p7UWX0A/6FRxFSvpUfZ3BGnnXNMshxmx2LT0/O/WsnkY6PsTheesB7uLCl/XpegWX/Ry7ruA03oAmyapn4gewLl0uKiH/w8GQxQbzAe8DJYJcDyCHy6pi+EEv9lnLbaDTvQx1E/kkBRdVg51Ib2qAEtBXC3CDxEH4WuoHO2o3QlF0YHnlAB3x2TlGnUiIy954VUyXOGOBNam5z1Uj//fT9KsB6MsXBYoxUp2erR4vaSAPcV5OmUAvDQuCdBZn+F3km0dC/uN0KHPRGOlz7KanPhYQJ5IEWy3RE3nbW60A3eiLMz2o3Nykd5ZsnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oFNZ3XmoXKbFV0jEd5RpWiKTQIjFNMgtvFZdXD8+Ig=;
 b=HVtkl7vV+M3SgiWJ/nCOm1mfs1Xfm/pnV2nz0r493ZZUEqBjfsI290PWl5HIBI10uOwh4bauJo1fQAjdahT/9BvjDnzaXr8qzI7eRYIrvU6/0QKziUMyivvMv3MurXuPdeNjmsOceATH5QYPCpPvkD3bNfi5DhrQUUjIqAidREmKuHTfCcSuYk/aBaHS7gLTftU5Y+AZ+TKD9rPoRuYHL0Rq2iHz/TGJF7Kbf4vEwGvUC2A3zzejnge8ty7SL4I2jDBXo7jOrm9xToAyi1GEbcxMgftASOTvfPQKCEaZMzV825HvugsKdyiagmh3kSCzLN/yyrh4X9E1bEQB0e6mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oFNZ3XmoXKbFV0jEd5RpWiKTQIjFNMgtvFZdXD8+Ig=;
 b=AZzXhNpKSon72gCzG2ReUuGtCBc4pugvoMXINDk59RFf4B6JgV+YjKiJxKCHPXpcMWgkUcynVx7XDqM727jDYMGvaS4L+t6Nc5dFLTGtEYr+5yQDOZALVdm+h9YkFgAOZww7u8XLo1EeL4Hr1OlHjyA0LwfPEjdlzxXYFdwXkcxFGBzh+IMoKssisQ0jOMp56YYp78+9WExerlm09Yq3dw6IXAcriG75AoCx8PC7IK/eidsJK9QZFRIKPGR9ZCUjWMfmfnqXTdP05IOQcAF4Rc+HZyONgdPIWHEbE7aRCig87hwqwN0CcTSf0CoyHfQ9s9DcYUGknljXEzq4CLYT2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:35:13 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/15] net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF support
Date: Mon, 11 May 2026 16:08:00 +0800
Message-Id: <20260511080805.2052495-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8982a2fe-c81b-4854-5967-08deaf383818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xC6CQyn/DJHF5nlJBVJ7NPcQQzXKCu44c9SBrEeTEQ670BNCFtRHXqmXicW93JmHAVbhjY7l8SqpHkR6lQvAc6/lS1Da2Ufnjt0zlN15IMQYBlkY4RgXjdzndxPG4PvbLovc9kRLEt5iT3RTkir16JDrCo1tHlEbCfwRx/QaUBy+sOYqwoLSEDKTw8qj/LqN/+2c22qsq9Sql3rHs6cW4/4oMEGe9X3MCKBdgSrpJR2Dfh9B4LMlBFQf5U8mdWA0GmqRfVoFKRHQIsiZCjOa8kK/xGU7U1bS9pT4KLCANrgzrIUnk5MoT0d2qggPqM44mXjic/QkKwCuHzw6mOEXHAFjCaYsV0fOdOYet/ifNzFV33/sffiXaIgidehR7FDwbkSCZqIUvrJqkMN/w1txNFddW0R2Om1Vigu3pe+ipxsVCvCj0+xPFqlzP4as8f0g+/y5C3/o1SWZ7vaoHgRUEbQDTp3UCx19QpgOAsq65xMgk2r0JEij5ChAFmd938f1SLtRe1C62tUzuhyR2+NXflGPt7aiQiMPjP2Tg+ZthzD9hsiw7j+kxai9z/p7NqQvhZhxlntKp689gWqKYKMXAh8u2vK69RIJVpRINBSypkq3+vDYJVAhqyh00F+swUtLoQErC7xvcafod31UhZ2/rMlep0Nuh7+QVhkn828mqMGuT8WBZUHXaJ8bgg2B0a9Vj44NMX+jyJpoi6wWRuKGaQijpC+wdoIWAJEnQKhNGy732x+KYprUTD4QA/huctNZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ww5on4R0YH5j5U7b9AdiT/l2nDYooLuHAFfNdlEZ8B04kl7uEMqSYHzqt35V?=
 =?us-ascii?Q?0e5Qkw9k0u9454QqRFBP0yYJMBKCB92zWJiwl8k474jWEjn5QF5dsT19UFxc?=
 =?us-ascii?Q?c55sQ7b+s7U/aspwg3JSAbMCsR+4P0pR9vMsFOs7uyR5WodbAuRavl4xNkwI?=
 =?us-ascii?Q?zzbrQysQ0FnuvZwsCgZp5oWwnVWh8OObfdbngKF94oNbCdzqGhVyUEIUUYjz?=
 =?us-ascii?Q?fQs/4GAu4nCvQ3giieORM6SSn1QX8Sg2aKjbrWlaUWyl6mo5p3+nYtlzBPiJ?=
 =?us-ascii?Q?mkL7FafYfJTZNtggbLo9jH2PCt3uoR2f/m7x64ftNIxz1HryPh7AuYrxSwJG?=
 =?us-ascii?Q?WCh6S7zec9RKw7PNqbwiGfHw1M8XEclrl9368OjlbbA6R+dKpziiilnt6IHP?=
 =?us-ascii?Q?jaMsWQYxCv21Zimn0XcZWO1mPK2Ge8OGUzXsl/n/XKsHm5kRX0yo7ddtMqyz?=
 =?us-ascii?Q?QRW819127bmu4Fk+HNnP3FG/VOhVADQziTaYNojv1HciZjwCQ60JwnJTEoPW?=
 =?us-ascii?Q?wP3EmSWivcaewZmm71oRGVmMy9h0rbsOTZ607KR01ndtfrnsAZZ9UgjUts5r?=
 =?us-ascii?Q?JEWO1fMdMAp5LSppcGpykueRT0x2Lvg97uYTSdHh9rcsltweVXSPvWVByMV2?=
 =?us-ascii?Q?F8kLkVqFEiuyeQt7MHY3KJR2FjHRAURqQ45tPFRGn1Gb3S8Fwh98Icjo05QF?=
 =?us-ascii?Q?NwoY5cePieZn2AaMUBaPGDvm2IABHoOSex3wGH/dXTQ7i7GWAw4kyh7D2K9t?=
 =?us-ascii?Q?H3HvvXqAieCCy4YEKqa/ihCpWFTjyne++pfglTmPGLoEH9yEL+SHHPWspmwo?=
 =?us-ascii?Q?RRvd2K4kt22DNYCiW6YN9b/t61G/yE2z+d1ixegItQqqZLF4UsYAHeGorUn0?=
 =?us-ascii?Q?PgiS6dvlcyoeY9sRZRIpsQVgpFmPCfLSRaEblgoil1SXCYrkfPU9g8MwPj29?=
 =?us-ascii?Q?zsGnGArTqwmkXOV13+etw5AyXjVH69C4H0Hj6Y09c4nvkVXCPG5fSPgOsnsi?=
 =?us-ascii?Q?iKGtbQPyH5KGytevqmnVqn88BUAdzKZtI1yAqH2+gQrlOjE4FBcE47vwqQSR?=
 =?us-ascii?Q?mzDR5pOBeopns1AJRogHhbbWpTMRC5DcPssBTK5qXxWA4tNA2r5jnr/cJ0qD?=
 =?us-ascii?Q?RFQmjjOPxaDXGXof5QVLJKHShmfHNA7CgxnRnJgc8rRxsLdw/1coJh/2/vB4?=
 =?us-ascii?Q?3IvKgqKP/9brTMTiItiaoBmmvclLj1Tdpn4E+HsYItbOkVc6+hq3KjGoRsCb?=
 =?us-ascii?Q?5wgg3sT0MJFkz2H6A1dQk/qpX75xFabTRNsOpLqGwP3Gn8SzmxrXPT1dCR72?=
 =?us-ascii?Q?NC4JHCtAYCw8ZoCDpb1bl8YHlpbSrp/vqQrTIaZIFrXYcRAv+uGAYSFCaRes?=
 =?us-ascii?Q?8cqTcPz9Sp0p3+RuWyU+NwzwQ07pjqfI5d7KUPmo7lpiLBUB6cvjvg73SJsZ?=
 =?us-ascii?Q?UoC4nolDEox3+Bg9ruv76emmxR5MfZrC+jP5XKP8YQVcTp0EHtNVG7ZdMrHh?=
 =?us-ascii?Q?b9v1QkuFmQi/WVSsNCYuar4Gpjzbzb8ZtkQHuwOlFWVzkdmtvwgg8iw/fKNs?=
 =?us-ascii?Q?BD7366L/vRO5xR8CnnyTZ4UgFGINSkPf7MalGLyv37KUZfoC/75Wei9egCPi?=
 =?us-ascii?Q?MK2Nx79Yq1+YEgSZtFwh3cm/OZcjC5aUs0R9LgFeDtv7+Bfozpi55ABat4N8?=
 =?us-ascii?Q?ZiXoi6uMIfs33W8wqb/lJN82BQ/1cd9Gu210J8eckHle4cV9ikJoIQjd1bks?=
 =?us-ascii?Q?VI5FSS3Xsw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982a2fe-c81b-4854-5967-08deaf383818
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:12.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsGkZlVQAWVKCyAcT+QRMOE5tgByBLfp3cmb+3AzK5FeCpS2IfB0OuJhcxhHA8l6zidEnjQLFPOs3SYt5NUj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 0190A50A476
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286528-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The upcoming ENETC v4 VF will share the enetc-vf driver with the
existing v1 VF. However, ENETC v4 uses a revised CBDR (command BD ring)
setup/teardown API that differs from v1.

To support both versions in the same driver, add setup_cbdr() and
teardown_cbdr() function pointers to struct enetc_si_ops. This allows
each hardware version to register its own CBDR implementation:

- ENETC v1 VF registers enetc_setup_cbdr/enetc_teardown_cbdr (existing)
- ENETC v4 VF will register enetc4_setup_cbdr/enetc4_teardown_cbdr

Update the enetc-vf driver to call CBDR operations through si->ops
instead of directly invoking the v1 functions. This enables runtime
selection of the correct CBDR backend based on hardware version.

Changes:
- Add setup_cbdr() and teardown_cbdr() hooks to struct enetc_si_ops
- Register v1 CBDR functions in enetc_vsi_ops
- Replace direct calls with si->ops->setup_cbdr() and
  si->ops->teardown_cbdr() in enetc_vf.c

No functional changes to existing v1 VF behavior.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h    | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 772f0ab2f8c1..04a5dd5ea6c7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -297,6 +297,8 @@ struct enetc_si;
 struct enetc_si_ops {
 	int (*get_rss_table)(struct enetc_si *si, u32 *table, int count);
 	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
+	int (*setup_cbdr)(struct enetc_si *si);
+	void (*teardown_cbdr)(struct enetc_si *si);
 };
 
 /* PCI IEP device data */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index eb6f8065e1ea..11ffd2083abc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -281,6 +281,8 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 static const struct enetc_si_ops enetc_vsi_ops = {
 	.get_rss_table = enetc_get_rss_table,
 	.set_rss_table = enetc_set_rss_table,
+	.setup_cbdr = enetc_setup_cbdr,
+	.teardown_cbdr = enetc_teardown_cbdr,
 };
 
 static int enetc_vf_probe(struct pci_dev *pdev,
@@ -320,7 +322,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_init_si_rings_params(priv);
 
-	err = enetc_setup_cbdr(si);
+	err = si->ops->setup_cbdr(si);
 	if (err)
 		goto err_setup_cbdr;
 
@@ -356,7 +358,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 err_alloc_msix:
 	enetc_free_si_resources(priv);
 err_alloc_si_res:
-	enetc_teardown_cbdr(si);
+	si->ops->teardown_cbdr(si);
 err_setup_cbdr:
 	si->ndev = NULL;
 	free_netdev(ndev);
@@ -378,7 +380,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(si);
+	si->ops->teardown_cbdr(si);
 
 	free_netdev(si->ndev);
 
-- 
2.34.1


