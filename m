Return-Path: <netdev+bounces-276292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B94B7L01Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B0D3B7898
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E898430387F7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3863630AE;
	Wed,  8 Apr 2026 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLvwA78Q"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C73624AF;
	Wed,  8 Apr 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629466; cv=fail; b=d29+wI+7iWOcoyj9kJamDFA9GJgxZT+U+zXpS9x8j5kwAhY7rqilatwYIXb23xZUNfm8jAjdN44n1wu71yBpgbdwjsTU6jkD0QJQGSw2FHGmGFaJBU8O+ScT36J5xrwbVQj/vYSlALEsZ0RBOXlBtsK3o47KHJJ9I6YhAC/hers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629466; c=relaxed/simple;
	bh=FVgJandqEl4nJ2uc7F1PcJ9ONA9rfbchEy8+mIjho8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLZQT9oJbzrBGu7FFe3XocGv3z/vsDx/oqC362e4gJ5qTfe3fs4nFNPyYg92COikjPNfT9IRWITrEBh9il334Moh0bO5aGYe+0SA9mjEV2XvjYviVFPsXw9rG96aQJiLAdbDILxiDZJsZw2ApkuB7ywq1qXpCYLTCD7UQ674hCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CLvwA78Q; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ1p948QXi8D1VcZM0ugAdFyz6kFcEIS7kA/7BD74EpneVurTVqKeQpF0NNSRef0cCRiMQBI1tIRKhelWXWdhfUmTmc3k6dp0lfFswV2kcgCt69kIFNsZlPyGBGGVLBPhgkC+EoK5sw/OdaKqrriZIiEDqREDBzNEudmWGA/5Sks8h4y301ikhkZv2OJXdxFBFgtSfKG8Y8xABoO9s6dIKwkgJU1bvnYRcYB5sMwMtqxE2fa7m20/hFtFo1gVOTFNjlYWAMrcS9VDiVL+abrVunpNVkc2rkD/4IcP2Rk1mCXuIb2Pv+ns3x6R7bcMYN/L5IJLTyjAfB2VxA+o5JLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbyD3dw3yxNz7fRfsLUdhlYa+pMj/LZBwyKyGZswyyg=;
 b=WESQe6OFyLb5xFTMU71ZpasrCycxjPL80gu881/Nt8F7ULlvcnrSoNePRMZCbLUeIx4/FMZcPnc50v9iomkePntp4w1clTwDXgefPf7HpwSZt+I0IgvO8fQdp/NFe5lHwgQj3xEJ0z4ZNPT+AC5zRqV8XvHmFymmMzIsgnElvgHmRsQddquV6wQLOo0q8QKylUCdEyHNCKA4nt8jlC/Opo2dPLFKh3geG+EM70XxqYkBWss7MIz5BGM9bAM3hEzeVeCeLwdNPWGeGy9Tk9B0Yt11fTDpFHbSfUwQMxOgkOZWgYN3R+xsj1XAwz4lnsqjvtQC/TYI043uBrbW33uTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbyD3dw3yxNz7fRfsLUdhlYa+pMj/LZBwyKyGZswyyg=;
 b=CLvwA78Qy4lbbioA53mTdZKyH5reoWxDWEFVzFEvp0NaZJxvOo8NLazEbQQP7RYYhoi3Ds67dh/LqW5c5LNC42pKQPJ4ujTUACv1HYecbXE56ew/pKhOQTEjsPDbtNtE0dVpSPnn+3a9Qotub+gnjnGzcd/VzBEcr55mqMrBev0avBwSkdw8/Ae/s2w4WgrMJz9pmCO0GI932gWHuTTiYHvqQ3FBSxyj288/h2hV961uyszPqIwekGwgYks+CpdOr2LcsXmfSoxaDv9hoIVCDnXYZS7OMBTsnwtIwjCqYu4aiqyFVq40XZjpgHPB/GOcbzvjPR4sADq7XCtknyU2OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 06:24:23 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 2/5] net: enetc: show RX drop counters only for assigned RX rings
Date: Wed,  8 Apr 2026 13:58:46 +0800
Message-Id: <20260408055849.1314033-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
References: <20260408055849.1314033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: c6df5b1c-e0d0-436e-7e2d-08de953779bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jWNxJeEskvAODh+ic8Embr9hvBsCrtXynYSqtAON1DIwbord2HdAc124i/XLDjjM2LoGdeZKEGx+72EonKWRlZJQIyTu21nkkAeYDZpyYQLILAMQALA0vm9lRBCU1a4V63hh/TbcBpqU529eULc3iNgSnC3rbflClPMYGq/S1whataPvf544DRBLOhET/Oce6CTB/tAx96lmP4GC9sy5cXE5J+YYfnCnBPGIxlKRDRcEUza2D5feJ1oGCoXIz1uACyZ93mZctcaKV6VV0Z5ltXHIVqA5KvgbtlG2uCvW6Kn3QrfZvkENHyTcqLsP+QmCcayOFL/G0aJSSeDI+/kjjpY1yDPeGwlN812vt+PIKZxMK+m19vDPk+5UWB05EBAuHBXQlhVTdQAmTWoexrPdtqBzx3xY9arlPIhj1Wh6cXKA6hxUNDrJqQFSeCiBEI0BQXuQYkTFdfu4xGMydceoc/QbDZeHCSg2n4+fRmo/LTFZn66aChad7onZe9Fg61AcJ5YEHVOkeT/7bBD49C++c5nnZBUMzLqceYcCmdTqz5gDKyCPAYpCTw1d5tRrmcOc+4gCJf4O59dlQ6VH2rZvVyl8RSUl2kenE/BSr77dqOeqzcvPgf+7OMjH1qwOeIdZhSim2/LExI2JrXfOkLYvpsbZX0ak+AWn4Wq/2kSwY+GNyMTvzu57HTxtCxER2sdV3Mi1VyR3Y7VFrT36eS2aETMr0VXNBcn4ID1iQdEpvElvPBV/mgvrXaG8h/yHgkPO4sbAnPdmnp+dRDDO7cP/Usd3SJ0toeimR9lKQzX2654=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arWo77e92kjypIjJgH4hmpTvQcCX94iG6m1ZWcPHQrW2ykDTOdJs/urvuSQt?=
 =?us-ascii?Q?MWqIBjkmWdV3qspPVyqTB+zYWW8qh1XPf9YQvzhfHNwYMiGfSIWZi1O+8hES?=
 =?us-ascii?Q?OmNt9cS65vBK1bAtwSsuOHpg26khjNJ0iIxlhbjpyKGEsMraO3HYAOLgwGJE?=
 =?us-ascii?Q?QsXoV6FZqJhlxhmJobtp1K0le1eWRJd9IGICObkRdWsIeHADf83oNRZx678P?=
 =?us-ascii?Q?ykCHlHT90dubTFFSa5lm9t9FQFn8T1HvgU+r9AQq0O5MGNk03U/AA8z2rE4M?=
 =?us-ascii?Q?xTPOxszvhJCnLIJ5YocZj0OKTorSISSJvMWsXUYjElmRuoRk8LsV2kWkPsub?=
 =?us-ascii?Q?xW8arVTEd8NxbE9J+ctBp7FmgnY4RaQF0Y7ocGK+f3up9Q1t+ykcQkaaIqkL?=
 =?us-ascii?Q?ytbc8z8/F83ss8Wuk9wE67fkyUfr8ANGPT4Yrmg7W1is6pOPDgHy/XghqGRT?=
 =?us-ascii?Q?JkjzIcsaCE6GMjiETr+AKMqziJvpb3uVENNXKi4yGxneG9T0fusOxaKCEqbj?=
 =?us-ascii?Q?iYXtPpcWsynuil+ORC39kBNkIHUOvvZbrLEJmOSy72213vkFuPNf7swKU7qv?=
 =?us-ascii?Q?2HGrYTQqGTdaJp+ehAp9HGkJr3oCrJ/z5Q03I50JfbG8Y8FNazSeN02VDQr+?=
 =?us-ascii?Q?r/Cb7tulM+ygCmRZDzlx1meRqDjUogGZF+sCcp/HTOnaRXE8w/FbobCqnuxy?=
 =?us-ascii?Q?z0MOkuwS1xtO+U7/2u1VBEtZsr+HUKSqPkzNdZqDvWI8ZthBdaYA/BBkAuug?=
 =?us-ascii?Q?WKpjJWNcj1lLc8hyatUmlUivYetKPXTei7SkNE8lb1H1oFIFLRvNZpvrRjDq?=
 =?us-ascii?Q?D9fvZ8MsPzh7sshT42yzxUQ+tSGRlrb/tXI5heksifj/jSqSFDBmx5KVXT7N?=
 =?us-ascii?Q?SkXoqSE16Ym+ZDFZReNgowMvbmg7/Xt19VvfY74BgIBAD6aPtiQifLjDsXND?=
 =?us-ascii?Q?rUJnB67In3A9EASR9sxAZ2LsIm15JHdshXWbc9z6keKZRB2wif0BM79K05+N?=
 =?us-ascii?Q?MgF745XNpCXhQJfLvxLjfusMde6bD4zigopx8cQlh3dhO7icsCh5ow8T+DmC?=
 =?us-ascii?Q?bJlGlWSbafqg3KgLpxD98CKSeT33nvHzN8sdE+qvbIJKW5raHj3qt1yayTDr?=
 =?us-ascii?Q?YVKssnLOH+r/tj7+lg/bUihJ8k8bOatxvW31zsMLbkLp2WcHe1RL+Cq0gwaP?=
 =?us-ascii?Q?jglVYB9ze5KTLpG8fCmppq5+Ve0orvtHfFtxHDmFIVJMva4g3NygvV3nXl0+?=
 =?us-ascii?Q?u+JdkAcppoQ41X8usZSvulbGWc8xQVyHE6mR46ClKXiN81ydwXYgtRceXIO5?=
 =?us-ascii?Q?4ABBBZlLmglHAp15so1YcGzbS39qaIyyjDgGl2lvgYkzgFUa6TyQmRN6tWM4?=
 =?us-ascii?Q?45EUNlJ24NR16NoLUch+0zwZO3ktG/j6S2I2K5lM8xW5R+IBdCCNXdOaeAy7?=
 =?us-ascii?Q?DQFjHCEgp86joDgvLfOnMzkHUSewY7cYoPH6pnovVo4A5fKvbr0n0hQNgXlK?=
 =?us-ascii?Q?kU9H6X74TYMFz62r8gomVTE7LgA83tk8vHZzHl0z7S84kGB8J2xBCkNGMeXX?=
 =?us-ascii?Q?ztqzi6NzfRvIB2KmnQpcZXu7EhxrJmkEYgHVeQibz/8fdiRs1ZHeMw63Wr2P?=
 =?us-ascii?Q?8YW+eV+ApGZjJo6GDzQe+VKDCoil8Cm09AlwdodeBgnJrPJhbeYdOo8rGZdk?=
 =?us-ascii?Q?ON5VAzX+fDX7IVp+l7Fwgpja2kwkH+PMo+0NyeDiY6jIvzzUOMtPMph3Qxqw?=
 =?us-ascii?Q?Kvi5zZoxuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6df5b1c-e0d0-436e-7e2d-08de953779bd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:23.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F1ROLEXG28S1GduW8vdwNeYiTkIA5khTD2l0eg9S08aEYuUVAOAgCJG5SazL/ge4BMB8G3K3McnT67KGtF3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-276292-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9B0D3B7898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v1, each SI provides 16 RBDCR registers for RX ring drop
counters, but this does not imply that an SI actually owns 16 RX rings.
The ENETC hardware supports a total of 16 RX rings, which are assigned
to 3 SIs (1 PSI and 2 VSIs), so each SI is assigned fewer than 16 RX
rings.

The current implementation always reports 16 RX drop counters per SI,
leading to redundant output for SIs with fewer RX rings. Update the
logic to display drop counters only for the RX rings that are actually
assigned to the SI.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c   | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index c30a119e9142..36d1a2b810c2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -124,22 +124,6 @@ static const struct {
 	{ ENETC_SITFRM, "SI tx frames" },
 	{ ENETC_SITUCA, "SI tx u-cast frames" },
 	{ ENETC_SITMCA, "SI tx m-cast frames" },
-	{ ENETC_RBDCR(0), "Rx ring  0 discarded frames" },
-	{ ENETC_RBDCR(1), "Rx ring  1 discarded frames" },
-	{ ENETC_RBDCR(2), "Rx ring  2 discarded frames" },
-	{ ENETC_RBDCR(3), "Rx ring  3 discarded frames" },
-	{ ENETC_RBDCR(4), "Rx ring  4 discarded frames" },
-	{ ENETC_RBDCR(5), "Rx ring  5 discarded frames" },
-	{ ENETC_RBDCR(6), "Rx ring  6 discarded frames" },
-	{ ENETC_RBDCR(7), "Rx ring  7 discarded frames" },
-	{ ENETC_RBDCR(8), "Rx ring  8 discarded frames" },
-	{ ENETC_RBDCR(9), "Rx ring  9 discarded frames" },
-	{ ENETC_RBDCR(10), "Rx ring 10 discarded frames" },
-	{ ENETC_RBDCR(11), "Rx ring 11 discarded frames" },
-	{ ENETC_RBDCR(12), "Rx ring 12 discarded frames" },
-	{ ENETC_RBDCR(13), "Rx ring 13 discarded frames" },
-	{ ENETC_RBDCR(14), "Rx ring 14 discarded frames" },
-	{ ENETC_RBDCR(15), "Rx ring 15 discarded frames" },
 };
 
 static const struct {
@@ -224,6 +208,7 @@ static const char rx_ring_stats[][ETH_GSTRING_LEN] = {
 	"Rx ring %2d recycle failures",
 	"Rx ring %2d redirects",
 	"Rx ring %2d redirect failures",
+	"Rx ring %2d discarded frames",
 };
 
 static const char tx_ring_stats[][ETH_GSTRING_LEN] = {
@@ -308,6 +293,7 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 		data[o++] = priv->rx_ring[i]->stats.recycle_failures;
 		data[o++] = priv->rx_ring[i]->stats.xdp_redirect;
 		data[o++] = priv->rx_ring[i]->stats.xdp_redirect_failures;
+		data[o++] = enetc_rd(hw, ENETC_RBDCR(i));
 	}
 
 	if (!enetc_si_is_pf(priv->si))
-- 
2.34.1


