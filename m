Return-Path: <netdev+bounces-287153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIiVAZwsA2pe1QEAu9opvQ
	(envelope-from <netdev+bounces-287153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:35:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878B5214C3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F98C34FFBE2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDD39A4B0;
	Tue, 12 May 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iguiUB00"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658733905E4;
	Tue, 12 May 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591776; cv=fail; b=Af3owkGpW3CxdMg0kmIt5j3QS6jnqlwwJkkltjFuT3AZzGyo6LMvTaEAKhjh+d9kV9Orkexohbq6uRVDk158wULdLo9tjYPEx2A8k0S3BRVuZlNVpB6/HuQcKSCn2wWHdPHqnFWErd4Mv3Oqebnl7KFPAnQoYdub6R9awzsewkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591776; c=relaxed/simple;
	bh=ftT7KAhNZYhGf5j3Zm/xYubwS01r6Abe4vbpODfIcfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Raf2Zz+4VVI9E2WvxdgzNrwRlCcVrTWD+kDVq2TAqlwm5NE/pMqQtw7OaVnaPMoWmtWjSSxM+J4fXj5AUR98edjV+49IPKwAZ2skQmwXquSVzdAEQRRYZhQ/HLRbbvEomH55GRqIrvxRVAd5crWPmgg18iuJWOZhitGC9tAV8eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iguiUB00; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvtkyu2l8Y3GQXDq8XzQi4yhapWbyesn/XDnEeQOZJeP2G8N4THmfhIn3cwVhhJ798tDmTsJlxSSg9yGpmRYPPtqxSmXJkt6fiVviz+tTIQaRXRAT06pq3Bxig41nMLdxxQSFSggHtMpO+nSHvddxxg3rn3c3wMon89HRlHWAh0tM+l0qCng+YlgFhG0uOcMukYYdV7y9WTjCCEriteeulKDgSjgijIMJaLlgUtPXH8yI4VkgHdMyEGD7a9ngPKGpui4V5phczkwd7cq1otWQGId7cGKcKOBLCmBdyTfQHwoDz7t2+zByZ8gxbpV2j7PMYmy3V8HH+7wfPeOta9Jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSFhZ/S7FJYtlh3dR/faiuN0FD5gKry3sT+9nqsQ65E=;
 b=kxpwUSMCVbO9/P0tNy29Es/vBkhq20UX71pmjKgLOurTLFqYsmgXl3OZbx8z7P2cqk/miRLNmNXJFDjKt737kSUyVnAUIeQeyubIch8QV/67d7DMfpaa0BCLLW8oyXaFaE051aNatDiHQiAroJ1XUTCeJeOP9xvKDEMRxhLyb4BujNqoMNiK0MjHkHUUlsB+dg1rCNu1QdepyFD4lEi2waaI8Kx8hFFum6m60znyyzJ1fkJC3hCbKSI6t4CBlPPXDBv6goxk147gKWEOMV3+mo2cIjeXURQUcrvZ3WYTPxoTGgxZNhrrtaCNdh4o2K7vSpxR0UXOD6Cle2ATCm5GjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSFhZ/S7FJYtlh3dR/faiuN0FD5gKry3sT+9nqsQ65E=;
 b=iguiUB00aq9601EPK1sFgXtYSKjcJMaCEvTB0QAEYIvs2ww1Bc+aKlygVRUX2pqfGVPbPY0QxGeZTpoRwsLp9z/SGVlVjWYJxjr7QZimF4pw6dLKZDKlFs/cXzNWEpCp8Fa+Rjt0DBxU/1Gfuj3Ut+UkhvD52S5GOM8F64sKoKo039hE4ayxcPDnoDhVH9WA01gGuLxKyA6Bqx5ah8M8xKEEwLCKLvFcwFhwzD0singRk8WeLfcauwMzbwHaVK2VuvS/1DrwokC9dvUN1bfpTxQIvCadjNTkk9MjMEh5FOFmYhXSRgd6ueUTzFuxEsLY2QUOyYZcrR9fOmH/7GqYWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:12 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:12 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 02/13] dpaa2-switch: add support for LAG offload
Date: Tue, 12 May 2026 16:15:43 +0300
Message-Id: <20260512131554.952971-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: a615e5a7-f6cd-4961-b630-08deb028a36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|3023799003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Re/1XcYAGJ2aqAkyVcQp5QAukz0ByjKgNVCMtnj6vRhH/Umk+OFMhz34VQUXn9st8ohWAhByvGpd1e020qk2eyuYW6kQdIkXRpfuvmvAG2w6nhk1z3QMFyEF5bkHs9ejjJI5kpp1YZc+P8DUQpx1Hg+WmAVtBX8TDjGsdN3cuHlm3vwxnAm4Cfc/GY9wKFdD22dgdEEtnDoB5vfUc3UmWRVsXCik9/ecxSRyhH3CD0VZT7v2t75ECMUpyPemYmlEaESiZ7Tg4n7nDe9E2P4kNFHpMMjOn/ustEH/alPXTrrE+Hq4lnsvUv5pWTrhyOmVOiRDEw9Zq/RbT1QF85o/Ij96QmAoSshlo4egYMwvPJGvvZ2icm4al5/1KXBC2WCnMnyUZjgmrnZYbgLEQwUpDiankAXLmQBStRhuPcxB91HrCFsLehWvGNgLoouikZnHK+erhgnjYDNWB2ysZ6wXhPDsBrskWbm8bcMaCyF92UinlPgPJgi4r/rK3JPX2LqKmTLLIV3BsON9n546zi0dRYKor3+SKtUKMw2rGaWQWBH6v9ulanvzbVUJ94iAQWoGN1nDvkRVWhLxKyGPoiNlGq1v6/i9rCECK6Y4pJZtWHEzeGk6ZqdEVqjAbeV5qisQZNgMjSaE1vXbxcTIVx2cDk0OXKpJKQq8BtqRCwjMs8v0uBIXg3gsHQkWdBokKsnT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(3023799003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzkAOV+rxg/kSbc09VLGqe1cJR6zkjQ0lpYbWcchhuedMopmlHx09geokF12?=
 =?us-ascii?Q?krAlHKTlPUcxndSr4yo0met2z+IEpKF9khseXQGTS+L/PkG6I1uMgXAJKAQX?=
 =?us-ascii?Q?6UGWw/tZbNyJuhVp2qiem3VWYhKj2wboSarzRd+cHOOTow20AH0k+mQ7vPlG?=
 =?us-ascii?Q?pOHEJgB1WZ/yBAyEc/PhbSuZu2uSxJgrSwbjPBzFolqRiUs65ZwaFD6gBn//?=
 =?us-ascii?Q?xjxivYwiMyZWmgi3Lf7g/1lnUdArJMVI9A9gmAmW1NCb19udrYagBYLpHNMS?=
 =?us-ascii?Q?phvFLb6KGI2jLZJpZISt4gpQlEXhOmXX2rnV5yu2w29mTQGlqPlOIc7Nz/oR?=
 =?us-ascii?Q?JmItkxeurXQ5sYxq3/lgASuaJb9yklEpf/hQMmQTx83o4drLtop3jndc9/wu?=
 =?us-ascii?Q?vXtz6QMQxP6ot5/QOZbO6FJWc9HrhYY5KitgofCuQjCbE+zltAom2J++4Lzn?=
 =?us-ascii?Q?WJrzYg85xy2HDxl8e2ys1fWcv6l6NzKOnCily1tZ0/TdcH51iVfYYIqEHjiT?=
 =?us-ascii?Q?mUm6fTMZZN/DQqoUZf4u7hxyvsevuACHX3pDXkzDQs2CZlAfDitgs6UNMwvZ?=
 =?us-ascii?Q?WiuCHBK/JUdhEWWEJO8+h2lH54YhdVRE/wKafBPSVGC76OvjYuIFzx+cVnPu?=
 =?us-ascii?Q?yyQU/EcbjPMcYAEYJOJS+CeyGWMmxMnGXYE1d8otGs6aLPfdfn4JpHSy2NDd?=
 =?us-ascii?Q?l6KWZ34zW9SMmx+Q5Y4sPieUtbf14LtTscnqqAIxC0zfnggutNvu4VvwthQW?=
 =?us-ascii?Q?vSQax+jRxvZaqimrI5WljCFfxHlgY8dC5h9YucVRa12CZdRXzILH5nLiqx1H?=
 =?us-ascii?Q?1CeRXa1hJou9SLKvjGvbEvbZFJ+Wv7KLQfxPiSyBy1AqHSpuGHKybWk9MSRi?=
 =?us-ascii?Q?XIHPHWplojh8SOaJn6L5fcMWf95EWsdB9/70X45IZILHYiNAZLdZmrBbQz30?=
 =?us-ascii?Q?1aR8KaOfVErpq26ijKI8/VBaU9NvTDgL4sGB/XhFCqg3MnW07XLN78RPEi2L?=
 =?us-ascii?Q?GkEo4sA/ruLnjIgHz+vbtf9TruBGaysS6wnRQSVZof1kpbZwWI8oUMJ7hywO?=
 =?us-ascii?Q?cgj83c89Xd77kNjgJXupscQYqxmKfsU4e1tziJXhPkceyV+mPyDzDTEijUnM?=
 =?us-ascii?Q?mJ9bNOuIDt+OSqgYhy6fgm8jf3Vy+YOa4DLGtTBiHKx7NGw5i+OEjsm0Ug66?=
 =?us-ascii?Q?qY+dH1Ym9IVco+qKpmHzKjEOirVLM/JJCNdHeCbz0BFguFbnFVhg6r/3hWKT?=
 =?us-ascii?Q?Ojz6fpMvwNqHZ7JL6zVh22Zt/iZ1ideIQO6LN9AP8GXIZGO0N7FJ1aKUYdMD?=
 =?us-ascii?Q?FQ/4FbU+88G+3Ra6c+Tdn2iUWvTxrnKH7RpJ6TzYphLUq2ZPlpzvgw4jIlp3?=
 =?us-ascii?Q?xl65Ead0+Jn9gWPsjk8XWg3CTHQbxrhAHs5kX+4rK6aKIDYwsasdZo5jczMh?=
 =?us-ascii?Q?oRGOiXdKeo7VvEUOZQO3lMfxJJ5jPdFczEm9S1N+48sVgBmk1vnJj6lzkNMo?=
 =?us-ascii?Q?iTu4gcrpU0JS+C6nv/WovvJvn+sy3Td2hLWIbVfLB8CxwLrbcBzyPGIl5fSy?=
 =?us-ascii?Q?0FcVyMrBtuIkSn16RCc714msI2PtoDcriiQoVFNMAr/OPCTWbscNB4cUsO/l?=
 =?us-ascii?Q?MK2f5bcuiDPFXrqztlBOgTK7nXYZWdmas8JYuzhccuuVlP4n3wr2FFEayxng?=
 =?us-ascii?Q?T9VFce9rm1qg4Sy30qFnDZf4rI42RA0wN7Sc2LCB0DYq1IU+uQudEzLfm6GN?=
 =?us-ascii?Q?LaPC2zw3Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a615e5a7-f6cd-4961-b630-08deb028a36b
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:12.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU+vvYUB2MKgm//5TKhLvBX0m02PyI5wLhC0MXz3ysyxGyi2P81AsHJNUSp/Ak8Zs/fHPXx3xqbi9hE8fH5Abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: 5878B5214C3
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287153-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
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

This patch adds the bulk of the changes needed in order to support
offloading of an upper bond device.

First of all, handling of the NETDEV_CHANGEUPPER and
NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
to handle joining or leaving an upper bond device.
All the restrictions around the LAG offload support are added in the
newly added dpaa2_switch_pre_lag_join() function.

The same events are extended to also detect if one of our upper bond
devices changes its own upper device. In this case, on each lower device
that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
function will be called. This will start the process of joining the same
FDB as the one used by the bridge device.

Setting the 'offload_fwd_mark' field on the skbs is also extended to be
setup not only when the port is under a bridge but also under a bond
device that is offloaded.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- Extend dpaa2_switch_prechangeupper_sanity_checks() with
netdev_walk_all_lower_dev() so that checks are done on all lower devices
of a bridge, even for the lowers of a bridged bond.
- Manage better the default VLAN on bond join
- Clean-up the error path in dpaa2_switch_port_bond_join()
- Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
which is also a bridged port
- Update dpaa2_switch_port_bond_leave() so that in case of any failure
the driver tries to cleanup the LAG offload configuration.
- Call switchdev_bridge_port_unoffload() in a switch port is leaving a
bridge bond device.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 454 +++++++++++++++++-
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  14 +-
 2 files changed, 461 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 52c1cb9cb7e0..88f52ac04c0a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct dpaa2_switch_lag *
+dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		if (!ethsw->lags[i].in_use)
+			return &ethsw->lags[i];
+	return NULL;
+}
+
 static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				     struct net_device *bridge_dev)
 {
@@ -2157,15 +2168,30 @@ static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *net
 	return 0;
 }
 
+static int dpaa2_switch_check_dpsw_instance(struct net_device *dev,
+					    struct netdev_nested_priv *priv)
+{
+	struct ethsw_port_priv *port_priv = (struct ethsw_port_priv *)priv->data;
+	struct ethsw_port_priv *other_priv = netdev_priv(dev);
+
+	if (!dpaa2_switch_port_dev_check(dev))
+		return 0;
+
+	if (other_priv->ethsw_data == port_priv->ethsw_data)
+		return 0;
+
+	return 1;
+}
+
 static int
 dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct netdev_nested_priv data = {
+		.data = (void *)port_priv,
+	};
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2180,6 +2206,70 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		return 0;
 	}
 
+	err = netdev_walk_all_lower_dev(upper_dev,
+					dpaa2_switch_check_dpsw_instance,
+					&data);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Interface from a different DPSW is in the bridge already");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_pre_lag_join(struct net_device *netdev,
+				     struct net_device *upper_dev,
+				     struct netdev_lag_upper_info *info,
+				     struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	struct net_device *other_dev;
+	int i, num_ifs = 0, err;
+	struct list_head *iter;
+
+	if (!(ethsw->features & ETHSW_FEATURE_LAG_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "LAG offload is supported only for DPSW >= v8.13");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L23) {
+		NL_SET_ERR_MSG_MOD(extack, "Can only offload L2+L3 Tx hash");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dpaa2_switch_port_has_mac(port_priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only switch interfaces connected to MACs can be under a LAG");
+		return -EINVAL;
+	}
+
+	if (vlan_uses_dev(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot join a LAG upper that has a VLAN");
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		if (!ethsw->lags[i].in_use)
+			continue;
+		if (ethsw->lags[i].bond_dev != upper_dev)
+			continue;
+		lag = &ethsw->lags[i];
+		break;
+	}
+
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
@@ -2187,19 +2277,240 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		other_port_priv = netdev_priv(other_dev);
 		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Interface from a different DPSW is in the bridge already");
+					   "Interface from a different DPSW is in the bond already");
+			return -EINVAL;
+		}
+
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+
+		if (num_ifs >= DPSW_MAX_LAG_IFS) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot add more than 8 DPAA2 switch ports under the same bond");
 			return -EINVAL;
 		}
 	}
 
+	if (lag) {
+		cfg.group_id = lag->id;
+		cfg.if_id[num_ifs++] = port_priv->idx;
+		cfg.num_ifs = num_ifs;
+		cfg.phase = DPSW_LAG_SET_PHASE_CHECK;
+
+		err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot offload LAG configuration");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
+static void dpaa2_switch_port_set_lag_group(struct ethsw_port_priv *port_priv,
+					    struct net_device *bond_dev)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct net_device *other_dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(bond_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (!other_port_priv->lag)
+			continue;
+
+		if (other_port_priv->lag->bond_dev == bond_dev) {
+			port_priv->lag = other_port_priv->lag;
+			return;
+		}
+	}
+
+	/* This is the first interface to be added under a bond device. Find an
+	 * unused LAG group. No need to check for NULL since there are the same
+	 * amount of DPSW ports as LAG groups, meaning that each port can have
+	 * its own LAG group.
+	 */
+	lag = dpaa2_switch_lag_get_unused(ethsw);
+	lag->in_use = true;
+	lag->bond_dev = bond_dev;
+	port_priv->lag = lag;
+}
+
+static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
+				    struct ethsw_core *ethsw)
+{
+	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	u8 num_ifs = 0;
+	int i;
+
+	cfg.group_id = lag_id;
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		other_port_priv = ethsw->ports[i];
+
+		if (!other_port_priv)
+			continue;
+		if (!other_port_priv->lag)
+			continue;
+		if (other_port_priv->lag->bond_dev != bond_dev)
+			continue;
+
+		/* No need to check against DPSW_MAX_LAG_IFS since this
+		 * was done in the prechangeupper stage. The flow will
+		 * not reach this point in case there are more DPAA2
+		 * switch ports under the same bond than we can accept.
+		 */
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+	}
+
+	cfg.num_ifs = num_ifs;
+
+	/* No more interfaces under this LAG group, mark it as not in use */
+	if (!num_ifs) {
+		lag->bond_dev = NULL;
+		lag->in_use = false;
+	}
+
+	return dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+}
+
+static int dpaa2_switch_port_bond_join(struct net_device *netdev,
+				       struct net_device *bond_dev,
+				       struct netdev_lag_upper_info *info,
+				       struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct net_device *bridge_dev;
+	int err = 0;
+	u8 lag_id;
+
+	/* Delete the default VLAN, we might change our FDB in this operation */
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+	if (err)
+		return err;
+
+	/* Setup the egress flood policy (broadcast, unknown unicast) */
+	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto err_egress_flood;
+
+	/* Setup the port_priv->lag pointer for this switch port */
+	dpaa2_switch_port_set_lag_group(port_priv, bond_dev);
+
+	/* Create the LAG configuration and apply it in MC */
+	lag_id = port_priv->lag->id;
+	err = dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+	if (err)
+		goto err_lag_cfg;
+
+	err = dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+					 BRIDGE_VLAN_INFO_UNTAGGED |
+					 BRIDGE_VLAN_INFO_PVID);
+	if (err)
+		goto err_vlan_add;
+
+	/* If the bond device is a switch port, then join the bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
+		return 0;
+
+	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
+	if (err)
+		goto err_bridge_join;
+
+	return err;
+
+err_bridge_join:
+	dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+err_vlan_add:
+err_lag_cfg:
+	port_priv->lag = NULL;
+	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+err_egress_flood:
+	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+				   BRIDGE_VLAN_INFO_UNTAGGED |
+				   BRIDGE_VLAN_INFO_PVID);
+	return err;
+}
+
+static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
+					struct net_device *bond_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpaa2_switch_lag *lag = port_priv->lag;
+	struct net_device *bridge_dev;
+	int err = 0;
+
+	/* In case the bond is a bridge port, leave the upper bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (bridge_dev && netif_is_bridge_master(bridge_dev)) {
+		err = dpaa2_switch_port_bridge_leave(netdev);
+		if (err)
+			goto lag_cleanup;
+	}
+
+	/* Delete the default VLAN, we might change our FDB in this operation */
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
+	if (err)
+		goto lag_cleanup;
+
+	/* Setup the FDB for this port which is now standalone */
+	dpaa2_switch_port_set_fdb(port_priv, NULL);
+
+	/* Setup the egress flood policy (broadcast, unknown unicast).
+	 * When the port is not under a bond, only the CTRL interface is part
+	 * of the flooding domain besides the actual port.
+	 */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
+	if (err)
+		goto lag_cleanup;
+
+	/* Recreate the egress flood domain of the FDB that we just left. */
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
+	if (err)
+		goto lag_cleanup;
+
+	/* Add the VLAN 1 as PVID when not under a bond. We need this since
+	 * the dpaa2 switch interfaces are not capable to be VLAN unaware
+	 */
+	err = dpaa2_switch_port_add_vlan(port_priv, DEFAULT_VLAN_ID,
+					 BRIDGE_VLAN_INFO_UNTAGGED |
+					 BRIDGE_VLAN_INFO_PVID);
+	if (err)
+		goto lag_cleanup;
+
+lag_cleanup:
+	/* Recreate the LAG configuration for the LAG group that we left. In
+	 * case any step failed, at least we free up a LAG resource.
+	 */
+	port_priv->lag = NULL;
+	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
+
+	return err;
+}
+
 static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 					    struct netdev_notifier_changeupper_info *info)
 {
+	struct net_device *upper_dev, *br;
 	struct netlink_ext_ack *extack;
-	struct net_device *upper_dev;
 	int err;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
@@ -2216,6 +2527,23 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (!info->linking && netif_is_bridge_port(upper_dev)) {
+			dpaa2_switch_port_pre_bridge_leave(netdev);
+			return 0;
+		}
+
+		if (netif_is_bridge_port(upper_dev)) {
+			br = netdev_master_upper_dev_get(upper_dev);
+			err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
+									br,
+									extack);
+			if (err)
+				return err;
+		}
+
+		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
+						 info->upper_info, extack);
 	}
 
 	return 0;
@@ -2240,6 +2568,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
 							     extack);
 		else
 			return dpaa2_switch_port_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bond_join(netdev, upper_dev,
+							   info->upper_info,
+							   extack);
+		else
+			return dpaa2_switch_port_bond_leave(netdev, upper_dev);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_lag_prechangeupper(struct net_device *netdev,
+				struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_prechangeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+static int
+dpaa2_switch_lag_changeupper(struct net_device *netdev,
+			     struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_changeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_port_changelowerstate(struct net_device *netdev,
+				   struct netdev_lag_lower_state_info *linfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int err;
+
+	if (!port_priv->lag)
+		return 0;
+
+	err = dpsw_if_set_lag_state(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				    port_priv->idx, linfo->tx_enabled ? 1 : 0);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_set_lag_state() = %d\n", err);
+		return err;
 	}
 
 	return 0;
@@ -2249,6 +2651,7 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 					     unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changelowerstate_info *info;
 	int err = 0;
 
 	switch (event) {
@@ -2257,13 +2660,29 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		err = dpaa2_switch_port_changeupper(netdev, ptr);
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
+	case NETDEV_CHANGELOWERSTATE:
+		info = ptr;
+		if (!dpaa2_switch_port_dev_check(netdev))
+			break;
+
+		err = dpaa2_switch_port_changelowerstate(netdev,
+							 info->lower_state_info);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
@@ -2500,8 +2919,11 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	skb->dev = netdev;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
-	/* Setup the offload_fwd_mark only if the port is under a bridge */
+	/* Setup the offload_fwd_mark only if the port is under a bridge
+	 * or under a bond device that is offloaded.
+	 */
 	skb->offload_fwd_mark = !!(port_priv->fdb->bridge_dev);
+	skb->offload_fwd_mark |= !!(port_priv->lag);
 
 	netif_receive_skb(skb);
 
@@ -2517,6 +2939,9 @@ static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
 
 	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 6))
 		ethsw->features |= ETHSW_FEATURE_MAC_ADDR;
+
+	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 13))
+		ethsw->features |= ETHSW_FEATURE_LAG_OFFLOAD;
 }
 
 static int dpaa2_switch_setup_fqs(struct ethsw_core *ethsw)
@@ -3301,6 +3726,7 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
 	kfree(ethsw->ports);
+	kfree(ethsw->lags);
 
 	dpaa2_switch_teardown(sw_dev);
 
@@ -3328,6 +3754,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_priv = netdev_priv(port_netdev);
 	port_priv->netdev = port_netdev;
 	port_priv->ethsw_data = ethsw;
+	port_priv->lag = NULL;
 
 	mutex_init(&port_priv->mac_lock);
 
@@ -3435,6 +3862,19 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_fdbs;
 	}
 
+	ethsw->lags = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->lags),
+			      GFP_KERNEL);
+	if (!ethsw->lags) {
+		err = -ENOMEM;
+		goto err_free_filter;
+	}
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		ethsw->lags[i].bond_dev = NULL;
+		ethsw->lags[i].ethsw = ethsw;
+		ethsw->lags[i].id = i + 1;
+		ethsw->lags[i].in_use = 0;
+	}
+
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		err = dpaa2_switch_probe_port(ethsw, i);
 		if (err)
@@ -3481,6 +3921,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	kfree(ethsw->lags);
+err_free_filter:
 	kfree(ethsw->filter_blocks);
 err_free_fdbs:
 	kfree(ethsw->fdbs);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 42b3ca73f55d..56debbdefd13 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -41,7 +41,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
-#define ETHSW_FEATURE_MAC_ADDR	BIT(0)
+#define ETHSW_FEATURE_MAC_ADDR		BIT(0)
+#define ETHSW_FEATURE_LAG_OFFLOAD	BIT(1)
 
 /* Number of receive queues (one RX and one TX_CONF) */
 #define DPAA2_SWITCH_RX_NUM_FQS	2
@@ -105,6 +106,13 @@ struct dpaa2_switch_fdb {
 	bool			in_use;
 };
 
+struct dpaa2_switch_lag {
+	struct ethsw_core	*ethsw;
+	struct net_device	*bond_dev;
+	bool			in_use;
+	u8			id;
+};
+
 struct dpaa2_switch_acl_entry {
 	struct list_head	list;
 	u16			prio;
@@ -163,6 +171,8 @@ struct ethsw_port_priv {
 	struct dpaa2_mac	*mac;
 	/* Protects against changes to port_priv->mac */
 	struct mutex		mac_lock;
+
+	struct dpaa2_switch_lag	*lag;
 };
 
 /* Switch data */
@@ -190,6 +200,8 @@ struct ethsw_core {
 	struct dpaa2_switch_fdb		*fdbs;
 	struct dpaa2_switch_filter_block *filter_blocks;
 	u16				mirror_port;
+
+	struct dpaa2_switch_lag		*lags;
 };
 
 static inline int dpaa2_switch_get_index(struct ethsw_core *ethsw,
-- 
2.25.1


