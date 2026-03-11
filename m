Return-Path: <netdev+bounces-266540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAK3AWEvsWkVrwIAu9opvQ
	(envelope-from <netdev+bounces-266540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5725FE20
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9387D32364EE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0ED3BF669;
	Wed, 11 Mar 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mu0o/TXf"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688C3B9D92;
	Wed, 11 Mar 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218368; cv=fail; b=c6VqTePuXsWj5es617vFO99m3KSDT15sbDMJtCujrIXRVkQWyIReo0plQiWWZFahnZVLJeFMiYcJrBCcc8sj8U8QnJQ7dNxLiWDGLvRKsFkI2I5k7QLnuHplnxfGrCCDdBlZ25/FNcafRahdGIiQl909zGXYZ3ijSHRdw98QsOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218368; c=relaxed/simple;
	bh=P+l9/HI922e+WijG+y7TcBUczt85XREec2fmx9eVBLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBLE14QgohOzBszbPTF2n696pw9ujTDljjXkwx+Eurvw61/itJ+MUjsn+JAKPVB1/ENU2mKGb5ry1MkJcwwD4WTQruamSwQdsAVy/fW6rJpiOUvBExCKD4V19pIp7kl6WuBAFS/hUiyNtr+nDaONMBnYiXS3bHDVx0PRuhowCrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mu0o/TXf; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE2+KN9KXlfeYfN+Fu/VJyg0hnpAHSkE5sLF8dXH254RBURIuz8XfpTrxUHrIy1wDmTCjR7sgmLpRHW4OMVcNZNyg1myB1eq3/VFm5uW6H0K9Ge1ki2i8Yp5fxFNaC5xXZwB3WmVxS7Icu+iQkyXzKFyJ/aAZvZxUZ1BmCPk8zsUbTrkOPNCs7vCd8li+RGT1P9SZZe2LlWzSho/LvRfw+6yup9TiJ5txkQjtB8Db65MXh2oJMRlmDJ2VNfNaODJrJdOwj0GkDU/xNQEesnsGjyXkaWh4twX4qZeI/ybkiqmwYDaAv/F7xOxJaxc+0khmJoQoJsM9qIACHqt3JgOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSdDti4M8vTB5IpmBivurz+iVs0cGLs10lo/m6w8OCo=;
 b=E+SwX/z07SffX+nBzO8eNn3oDBO3ib7ILVPwvqlvyPWBGgbNLts8fLwDTcOL2hFJGrjcOkum0uETmFxA29iLX5ym3JYLrBv5gOQ//jK6v1gH90DnCPB956daTiWpnrXhQOK3oAB0jesFg5BzbgzB7PyKd7+DtiNd+RH9+vu3lMQ+ZWh2UFxpoSAki9U+sxfYf8C2FRivheYLWuBtIQArmZmFYtgA0VRQ7PVZ7Ehvepzi2xNd8xh5Ys/MrO5aB3/VEpumZZC5u11u3l0nvpKo9CfcDcxNCf0bWVTnbV0aq00m7K3j9upPFbAwywsW/6UfeRQqj5rjRADuF3pxgEpZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdDti4M8vTB5IpmBivurz+iVs0cGLs10lo/m6w8OCo=;
 b=Mu0o/TXfIl+2DWR1OfKgeKcEriQHYY825e9SDe/nACLKmNDuEdu9Ug0cHopE8pFBLoYUNaSwsmcKu0ZULCZaFSjw/uhF6uD6GPzPh5KzLZ12uV72TVxRA9TmyEC6tNofImhQ7SO4njWDAZhAJcVFIDoVxaQE1p9Apij54Yb6lxJSamGH7CcfXAlWJ8JkoOWajhfUW6Rcd34yMmxN9wn+gdTRwnQv0/34xHqYH/CvSFBANXZkTpIuWUnUEtzu2LiXTbHOc9gY93DlR/PcWu+yjcLd5raF5r1ZYRvORKm+q8zF6nZEaV+bd9hjyWaPl+9x7aara6jIwWsLC/zN8lctxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB11624.eurprd04.prod.outlook.com (2603:10a6:102:50a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 08:39:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:39:21 +0000
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
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net 1/2] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
Date: Wed, 11 Mar 2026 16:41:04 +0800
Message-Id: <20260311084105.3982037-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311084105.3982037-1-wei.fang@nxp.com>
References: <20260311084105.3982037-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB11624:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d0a6a6-781f-468e-df0e-08de7f49b0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oulMVPVs5Bgve2l70fVp/C8FLCb83eSKteOPYZpgZw2Cxijp6wuZ7ZWGlwuahIjejHHZG1N/bLxqwqrZR7WqBHicIW7xqfkGtXig2u47myBQHUpuOhK6l61Zru2XRG+F69+0um4YPSk+7mFkpnKUWNn+zAzDQRWGnVt4U99OP7zsyZUI1gAsiAR68Ixnyy9si0Q6sY80w/t6DzigP4+ja5i9nCd/ph2axnI6TqAjVKQm0lsLCgdywX+fbJPzlkdMDaL7UgXPQZzagzfv1uiqN/1FRUjXtXqpFMZr3+gksuc/gSSvihPDpSvH/yN0+b0MissM9VA+6lWQwle9z3nl6nUDVjcHBeygtjuWAQoiDIZzmxzYxsiGILjwWXXGHMET93BpwPioUDnN15JklosyYq+81cV88b74oyVEjGeP0hUkSSLzxZyr4AFK41wqpwlvcxWrtFj3SH2HhiC1IrQ0LIHEEtPorlSj+e5EgVkOMJsdNCYLKJ6r1zjSiDRVXfqilLqpR4HFyKSv+SMiGnSAdgDok4QBJXQxd451EBObcca9XmKb4gy5BKDlfmR32GuREnzNQYfHG+lVGJnmFv9/Q8g75dJrehitHBxEi32OaV8YIatjUAzoBBasxPUKEYZFpwVwfyTO+URvZjKsmxIpxJVGGp7HBlLVinieAnBvVHjYDF6Cyzvj6XU+16XWjCFxAJT0YdgCjxz2OcDl5JsgZnY/mfi5UkN79brJTov0oo5dd3ve79FqOwnitpfFM4Zr7M7pKx5tVanYnxy6FcuOCfojRONa8VbInFsbds0N9iJZO12c1Qqi4bPUdW0IWH1E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZnq5wd2ezQkjhASYNil7KQnqLO3gHDmJnKgPatjcCMV7iRnQUNoWWr0lica?=
 =?us-ascii?Q?dUkAye1AzNkueaavaJzpvUVYt8ziPaknpJAHk+7D4dgMxHP/pAuGMZLSiG57?=
 =?us-ascii?Q?B7QqiO8scUE/8SEI1l/3WpXSF1R4Y5cCVHDm353u/z7esRuFeB3L0boD9ErK?=
 =?us-ascii?Q?VHaOhv+uE/cDiGnKA3CCpyJg48appZUUu+thIWTnh1bPv9H5l+N2AWpUoCiA?=
 =?us-ascii?Q?RpK3+L9hrGv9mwrG+Svpzkx87ia2k5hDFzgqm0cX0R0b0CwuCdJeLrEjQbh+?=
 =?us-ascii?Q?HEfis9GGeozSudWI8J5vxL80neXEpAwXnt53SN1Gg33wTGWCumA+eg8NR3hk?=
 =?us-ascii?Q?OQRVwPwcg9PqCFEWXZabGXKK/IT0p/vBjjgY3tT237HsXkspsc2UDghimDOQ?=
 =?us-ascii?Q?Ev/jloumFHSZCiQCINKT0MeFpA2HO8WSZ/P6MaQftXGJrzc+MzlyQ98ThryD?=
 =?us-ascii?Q?Lfifi35B3QemfsjoVgw/BEvxs0QnalgmV59yyM20vev6oYS7IIIS9lIY1y2v?=
 =?us-ascii?Q?+PvuKFmz4wGZeXkRnHsfziwA+CkD1Ou6WR4ZlwtyQmT0aXpMA3Crl9oLuTrB?=
 =?us-ascii?Q?Pq1f/pinbu3Y1QnPtNQHTib07Oq85alHgQNyK3Lth0aGFEgWDkORmrvChs6g?=
 =?us-ascii?Q?HYy4t4aqQlbx0vI2ILY8tbB8k6rK34BFgB4lNPGKYBvbsyP10irpITStEsg1?=
 =?us-ascii?Q?/FFtZPdedvxugSTYra/tMd8zvu0ZzL0WBPlPmhf6LQ8K534kxZdwRWAKqX0G?=
 =?us-ascii?Q?UpPxJj7sqxL4evXYl++5i2QHj3J1VDwv3UuRSJORMBE0PHuiN5OSDfj9vTo5?=
 =?us-ascii?Q?CRFstOhX3gTML7qqtbpCpSBQfSPwPjdvIWtQEx7HxnY7dAJFZURfEpbOu4Tj?=
 =?us-ascii?Q?0GhirouJ0h9qRjYAYdhEGFrOQDDx2sX2+RHXEEg4WfTM+dj0bsIv0gbsR+wU?=
 =?us-ascii?Q?FLiFuQ9U7Rwf2JiDFqfZylLWgq6ApLfUEpG+rdMckYjnfv9WLNdffY4L9hFK?=
 =?us-ascii?Q?PRN59O8xQHLzA+KqGxfG7xNmMM+5D1CWacEDc7aj4PXUtE/OrqWSIKUsP0ic?=
 =?us-ascii?Q?rmu3u8Rhhs2ysmMr/segtfLQtohcJK4B+Xb4e1nFXG5lZeGStgXTAlL4pmm7?=
 =?us-ascii?Q?ObPlVwmKsS6PrxN9lEcBEL9Y+Oz+mLnf2V6SOSthmFukX6pNlSMxBJ7bSeMO?=
 =?us-ascii?Q?efQ4olnJtoVsHDT/Yciv3pjvDQgRPxUIDvY3y5SlURaT9W+oFlKKH6fld5ky?=
 =?us-ascii?Q?vGxI4N4BDKb0S3K9I5dsf6lOWgcVKA/CTMIKuLuj9k4gs/0wVh7gBlvOi9KX?=
 =?us-ascii?Q?JlCaZzRF4xgQR4OOc+LMJuJeRw4sxVXZqZSLJDxYmYYKyQBhfy7wsy0c7pgP?=
 =?us-ascii?Q?ws43E8kxNrwY/irrnbBbrwZ7KWEjeyBDVsXZY0T9lVBRAB3OJgyVSe8ir8Nh?=
 =?us-ascii?Q?pPO5CSHTLRPZD9F6ybtuBDppS+Kdv5z8I5omrcT96kpVLSeIdfQHnXQOpovr?=
 =?us-ascii?Q?OjbD3HZ84xZ81YaZuyFWI9So+8vGZME67EBwjwlU5f6qs01pQuC+KnmX5dx9?=
 =?us-ascii?Q?tBqlR5VJskLGMrTdJk4fbSrZntJw/a/Uydr2k1nGwKQcgOjUxhXOdsvx6pwV?=
 =?us-ascii?Q?Eh++hX3P/jQtySW9ydKieREmb+dmljvAK37CTvYa6sZ+lM8fx6QwjtMQcSfr?=
 =?us-ascii?Q?SrEnrSFM9X6436kwSxhtW0+lNSotmTZUCBR7B9/5sMDD4u4B08OSZw0J1M4e?=
 =?us-ascii?Q?Mt4UfG902A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d0a6a6-781f-468e-df0e-08de7f49b0bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:39:21.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmvRLBDNQ/ytEV12qVyZ+a2auvkQAABt8FnCBjeuoFUlXQSRsTpG/VLYbcAOJ7cQAGOsYnR1+RX+T5HGXhxmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11624
X-Rspamd-Queue-Id: A5B5725FE20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266540-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[wei.fang.nxp.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work perperly.

For ENETC v4, it supports software to set the PIR and CIR, so the driver
can reset these two registers if they are not equal when reinitializing
the TX BD ring. Therefore, add this solution for ENETC v4. Note that this
patch does not work for ENETC v1 because it does not support software to
set the PIR and CIR.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a146ceaf2ed6..aa8a87124b10 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2591,10 +2592,20 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBLENR,
 		       ENETC_RTBLENR_LEN(tx_ring->bd_count));
 
-	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
+	/* For ENETC v1, clearing PI/CI registers for Tx not supported,
+	 * adjust sw indexes
+	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
-- 
2.34.1


