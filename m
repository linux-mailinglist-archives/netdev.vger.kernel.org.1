Return-Path: <netdev+bounces-288832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P07MDeCCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE45654CB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB878303CE3D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867E380FE7;
	Mon, 18 May 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQ6/WHjH"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637A380FE0;
	Mon, 18 May 2026 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073413; cv=fail; b=jq8JaKFuwBNlVYtUEZ1vqXtEL9jDpYdEGQn4MRUWfd9j1ntnuJ4PbUT64fd+Dmq9HMljpMCmG2WBc80THl1ZTQCe10m3BOTnBFe/fYRB7//Y7Bpp+SsDpPXLwhLQRqc/qRaSsKts8cThGqn242KKxxLnGWPQepkPsrzK7mxU7ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073413; c=relaxed/simple;
	bh=gm65hv6LY8sXWejYz5epL6QZeFl+rH/dvNLjACXYtTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9S9WexEYFxyRlHQ3pSigbzQtdRcgyrVnEuXVz9p1Q9Xz/I86zQJkDkbMP9xN1pUV2Pje8FGzY4ltR9tacfVid6LyY929zq2Ovlr0lp02r20o8qD4RaHnRzodMwy8LnwLhT3n0dnT29WxSxtLm2uwrtEHgJC3MpUyzDqEHDOxjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQ6/WHjH; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5DJkeq8vfho/iD12Ylfqo7kDJ8C7OGQ+HoznXlZO3EYuMEJ5tD6EXh4sQKQDiHkmcZHQvgiaK639jeMb7WkpkeIkbIoP167lPClg5ctW4F7r71mYC8PJU59hXtv2SIWHk1oSJ1f1Cl8Obj6rlOXU/mPanlongFJpn5P4AM8Woyqoo9feZF6pJCqpIHy44KtYaRndxSIhEZSbhoQ3ZoeKp/KUXt2sMLuKeGwKjtf9bGejXm8M3pDhCvRSgVmY1SY/zuKF1EsAVNNESPUflNSWpXeIJiQ/NGia0V6/1hQrxDtpg405pqkTXzbkN0M9cqo/Qmx/DIzwhe9TOFymMJqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTvL4vozdMGCyRRMZoHSC4MHvyNqN4T3ZkhJrcFToTs=;
 b=RGXgypVZ+9pIydACT3QHQ8a6GY6gQ8yXKGv6RaeA9yhZ0f6H781Xm7RobKR70vzNg6REDyWy9ZsJHAonlH16Bc5jgYKZ/HGTEPwepZfPRsXk32COm4POgMugrA89aXQjTrL8U5mK+besCqK/PKSN/vonDwypGxVE2izx1/AzzxumhUAWp4ZrWRhIf2K0znk05/rk+9kMhYzgtCo/wLPI+UaYdAEA1ejGfcukgoLKCpPURo0X+hP9kWcJXdCcAPnqBNDy8dT3cntZH+wmVpCun6RqIcA0oIlotqZuT0WCvb4T68cPD38H7FSnbancGIsvACvie1VHqnLMdjJkYraM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTvL4vozdMGCyRRMZoHSC4MHvyNqN4T3ZkhJrcFToTs=;
 b=AQ6/WHjH81ebN/7RVgKiQ9OJ+4Y1jnvKsAoZ1awG0UpOpQRrmwUHr2mo/mN/FKauXRlbGCnAIySGVYUgoJCaaKK82LgjgDoKGHoNNp1LuEswFSRbrVa8vQPrM48N4kWAPJ+c5mLdFk88vBtF1LMff9H+iLr0UkEoEmWjJqKcn9iMyAC69aun+nZzt72hnaRw1kGdoacUBhLQuUDwJdidc/HaGSPOookZi2WBHldvtkHPd6dXLMbCealINVAdk5uCXTbOwvuws6Aay5tVOzpk2jOXOhzRZdyrrNp8/ix51cvgEWSQGG+5I0lSbh21fFV63l2uZMFeHqzny4kxSaC7mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:20 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:20 +0000
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
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 5/9] net: enetc: fix race condition in VF MAC address configuration
Date: Mon, 18 May 2026 11:05:31 +0800
Message-Id: <20260518030535.1057228-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffa828-64ea-415b-9c8f-08deb48a03f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	9HwSJe3IqagAQmxVogiwt3zhJ9WgQOoDcgyRoVCFbKe3lPdd7fQUmqba53KGlrjT67VtK2Qy1ppDb9XMwwxFokEeP1icx8iDpL9En1NXXWwKBSr1Ur8tZU0aHjaIaC/8nRrty4fnPF+cJN3CBZJvUN5K3KaJj7RhvVWxYDRPHtuUhCz6ljeZEuRKBASI2dNqzHwvF0uxbLmspCjDnU9Ev7lhyBt2/1CEo2Eyp1kCrFU3GqgklczsuUDmuz45HOWQRwldveePb9Ox9/JsOOsq82UTpJvn3aO+cWwOfcT29haWCnlPD0fGa/kxFZwYFSkhSG5asap1+mtrPIKGBOHzhIlcbW2OhlTKSGBFboTIcKOeptl57C3KW86ENl8/Ww0gEx9qwEIEXeFDG50kcrzX4WxX1N9axnVDzlS4ETrW87Caobv05ie6JLeqXffBFPGLrH0OXZaDosuhCj2Ybdi0n5ltXguODG47C7RL1Q5snmwJBLE2A/rAOQPKzM/iZQm6OrZ65Hml1mh6UaEsFwLtDJKKemT8c5EOpSAqFdDVuXBQ66bYVZloQXTpb2/WFmGVpcooweUqS+oJL3s8bNkPl1qOQWkJIq2tnHHTkayLXfFNgZw+dAfwpH3gOIgqA1rUcZSzCfTrduopSjtyHG4WQhtPOwRuri/A2fve6v3a0+J2r1Pgcx2ZfNhH/6+VTTCG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFcosxOjXbz9hU8nK2POYFioCLifo+2XTNVfxgZIAe2dRM6o1qfGDPBankCI?=
 =?us-ascii?Q?aYy3DPZi6oDjN5YvvV8QPPmL4aXXPfyv5O2iAUcylDYOsVlfKH9baS5jbH+Z?=
 =?us-ascii?Q?YATSnTS+XuPs3sFi5jnsRv8wZIErscbSC4mR9eSVaBSrulS3trDyRhnTFdU7?=
 =?us-ascii?Q?Wo+FQ+AqOAsLm+fGX8p2H/21SNTrOisZSWTIM2SsObL6+Lf23rgvw4THPy4p?=
 =?us-ascii?Q?pytS86CPQj0CtLZR6bKmXHui6bVEi1M4qLC7jORXsSJmCwrhqmKZy1rd1XQJ?=
 =?us-ascii?Q?FdIQ5WO4nfXEZzcbt+wnYo8q+e4AvdFbB03LICrOdVEzk1oug+pD0jJKWetP?=
 =?us-ascii?Q?//mOtDvcQ/o8+Te1sHGU6T6FR547MTbOpezi2pTaIGEBXKbYbtI/TDaFLgsC?=
 =?us-ascii?Q?CZVTzTCH80fTKqlId0IpqoKOHVYr90+L0nV13P2MiiWLeTV/4jOga/MivtR1?=
 =?us-ascii?Q?A3r2Bc0IjaeGDFb7eVbrJDhoZ5PX80PkJ3dJelXyMqoUtLNk6w+sAn8mLuR5?=
 =?us-ascii?Q?H4MFYao4kYZbRFEEPuXuaquL8P09kQ6OWkn6M23fPztbC598qWDRQmSIpLDy?=
 =?us-ascii?Q?anYlqhamve0tF16VcdvVyDewRG7stFccp9Gpqmtad5oZglzEG6/4F/7XFir6?=
 =?us-ascii?Q?y6K3AbluibKMQdn7gKsDOgHyHqpbq2dJMWl4q87RZMFn/zt/x7st/kkDUIny?=
 =?us-ascii?Q?LdZSvhTv+X9G3EAfa/TUgrFnqrCX9/nyRJhJUBTf0L96asqAOqzc1KIvDcn+?=
 =?us-ascii?Q?rJS3H94BreIcICgEa6B3vhnh7650iAFJTPZDADEqk8pXi9M7s0xRIuSYjz1G?=
 =?us-ascii?Q?zBrb1prWoEFDyZnjAc5DOxaHslp3DkJNkcftebStWTb3bSx5aV9R9qEIyGiY?=
 =?us-ascii?Q?DaEdg0nuHlKyijprmldLbL6J+IXcUCJ83Hahpj/KLhY9vNaINK10/e6o/93b?=
 =?us-ascii?Q?1sRCeQa16wDHtJbzHwwZPxLjUSvlUc/9wZWZu12+zdqjuoxIi6PjxkJv42XG?=
 =?us-ascii?Q?a4LcrBEorLyD8YpTJnYOT28nW6YQt8yjxswVGpMuRZSfTNcpm3nrUdZqhDnV?=
 =?us-ascii?Q?opi4fKHPJDDg/98d/JFYuwMDvMGBlcp5tHRtNfEomGNQ4tqFEMWo8Yjdi73B?=
 =?us-ascii?Q?YRkT8gvntWURpAqzaIGy1pD9ovBrQ15SSw4RvC+vdqXDfbX1bPqIXJ22lqcN?=
 =?us-ascii?Q?USyGPvoDA7IQ8BS3EJNMh6WiOOG0JBBeR78sVYWPGuvbdkLpoMlydsH4ksp9?=
 =?us-ascii?Q?nKUauItcQ5j8kTqhSZERMg8HwifxPgaItiDqOgTbgrZDQLtLtLHxi/mpTGVx?=
 =?us-ascii?Q?lF30x2RW5UNzRsGDDOKR6v1n/jsUuyyz3o3AsgYqI1jR9RtyF0JLI7uF2E3M?=
 =?us-ascii?Q?mJd+OHOyC2aHu7u2LYFghe2+lczWh0IHcUZ1vM7eApNyLpwW3LBxTrLnG+02?=
 =?us-ascii?Q?aobc+uTzSyVJTjW35im4mkpBIxYiCqXurEeqz6ECqc9GPgdBEQUYVJA+Kqzh?=
 =?us-ascii?Q?OnqU0c6+Te9izXbshRUoF/78u6M5xn0tpGjYGhcuP89+4LgOoacJgPrH3SLs?=
 =?us-ascii?Q?oI0CjL+2U8OevuQYfQ1JoLogVbdjvkAoc8jVcRVLeIlE5cZTQAWpGqqsKUyN?=
 =?us-ascii?Q?Tlx09P3GRo1gbkyrqdXeFYXv8jj/M8WfbQMMVT+LpdC4ZoTsoXVMGCCfVklV?=
 =?us-ascii?Q?PL2EAxwxvjigfOQeTUwlw4YgZg39C5poAQfN7E8LRSiQHxVc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffa828-64ea-415b-9c8f-08deb48a03f8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:20.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW2ctmtlVNfbfo8tKG+iRHcGjXn/A+bYa2LCukg1p0Ze2L2l8OE9AEciRZMf+lx9qAM0zMPGAH5Jw6X9EGWoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: 26FE45654CB
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288832-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko reported a potential race condition between the VF message
handler and administrative VF MAC configuration from the host [1].

The VF message handler (enetc_msg_pf_set_vf_primary_mac_addr) runs
asynchronously in a workqueue context and accesses vf_state->flags
without any locking. Concurrently, the host can administratively
change the VF MAC address via enetc_pf_set_vf_mac(), which executes
under RTNL lock and modifies both vf_state->flags and hardware
registers.

This creates two race windows:

1) TOCTOU race on vf_state->flags: The check of ENETC_VF_FLAG_PF_SET_MAC
   and subsequent MAC programming are not atomic, allowing the flag state
   to change between check and use.

2) Torn MAC address writes: Hardware MAC programming requires multiple
   non-atomic register writes (__raw_writel for lower 32 bits and
   __raw_writew for upper 16 bits). Concurrent updates from VF mailbox
   and PF admin paths can interleave these operations, resulting in a
   corrupted MAC address being programmed into the hardware.

Fix by introducing a per-VF mutex to serialize access to vf_state and
hardware MAC register updates. Both enetc_pf_set_vf_mac() and
enetc_msg_pf_set_vf_primary_mac_addr() now acquire this lock before
accessing vf_state->flags or programming the MAC address, ensuring
atomic read-modify-write sequences and preventing register write
interleaving.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 09c642040892..8e11a023d516 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -252,8 +252,12 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 		return -EADDRNOTAVAIL;
 
 	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
 	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -496,7 +500,9 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 	}
 
+	mutex_lock(&vf_state->lock);
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
+		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
@@ -504,6 +510,7 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 	}
 
 	enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
+	mutex_unlock(&vf_state->lock);
 
 	return ENETC_MSG_CMD_STATUS_OK;
 }
@@ -989,6 +996,9 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 			err = -ENOMEM;
 			goto err_alloc_vf_state;
 		}
+
+		for (int i = 0; i < pf->total_vfs; i++)
+			mutex_init(&pf->vf_state[i].lock);
 	}
 
 	err = enetc_setup_mac_addresses(node, pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index ae407e9e9ee7..35d484858c7b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -14,6 +14,7 @@ enum enetc_vf_flags {
 };
 
 struct enetc_vf_state {
+	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
 };
 
-- 
2.34.1


