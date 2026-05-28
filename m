Return-Path: <netdev+bounces-292788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO1mA39/GGpBkggAu9opvQ
	(envelope-from <netdev+bounces-292788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C55F5DC0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B841A3192BBE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95219421880;
	Thu, 28 May 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fcQqCQ9t"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0F410D34;
	Thu, 28 May 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989720; cv=fail; b=AFoOnHJoTuADBnjxZCRE98mkM+xgYZKMAR+RQokk2xuYEpnJBTgLZdrHjJfSwhsUBbB1wEr9lFACj7ppBWixfXEA+cj+d2bE1S9AOYkf1W3rdGDHXctA9o1E8Q/mE6vv8JLgpSInMWG9lh5Hy6VCaZpWKv3PpR5LNq8S71yOzMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989720; c=relaxed/simple;
	bh=vOfE3dhYvUIrJy0ruPlt8AIE3paJ6daT5JD1fICQZjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObDWl4JAFCe+ldve1eUzMX60FslFY4UCxl9UQF6CJjnE6aiM1q+haLLIVMEY3G0NFYOuYO9F1Kb8DrKA8iMkaSCyq3OWaZXJiMgxWCHCHV/7QSrBT12UbAjDw5SOMyM0cQKv6z+wDEwREgPadMV9t64nn055WzU6lOlnlD10ZTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fcQqCQ9t; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRXLGISIBPW/NmNDPcCI9M6NWY29NRMlwbr5t3is+2KiWQgoGzVmCJ+NUb5x2xGwmHYrw0lBl7uE1OuTIC3Y9uRqd58VOuLTuSJ+zY6c5BtZX76P9qhZpA6OaTs1C5HZyd0MYvUU3uyMCuL7D2SmmUF8Z1UM0C5RYHoX6eNBJRgNdN8HbyjOoJCjpUuwh383jTwJCf4nNYdjC9PR6BZLdMre/HE11WnIv9UwVSJ8vRhTsSIn98/TSRYvJqnll/gkstgViwnkavfzWy0gvqR1TOZ9Isrc87u0l0IcGXSoyYdqRLnNm+jVSPo9I/DgUKTTVFpjMyCyiwPX05OHY1OpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA5qvFL9p4KatHGLd99IBZFj7AkseWOL5kTSC3n4ZgE=;
 b=a1JrJWVohVkX5bKcRtOO2EpCHCxtDIYj0Silklp4kO0NUUN+xvQIfokdn6+5iCHvrNJiZ/VgvMQ4zY86DDEG8B/u8MiMXiviYUhhOrGky0ljF2rwF+W8VH/llhn2W40i0IBiFHfQdwW5qgXiiAaMPXAZQ+G24Uo2LGWc0WHmSljkadhmwX6UUulj867+vfZm1cleoRGjbE2NYHyqw2OBVRVbmpolwB19hR/j9EQ09th8c7PXJV3WO/V64IuN7mLLKBseYDHOpbqSoi25QQbZIli/A1LEkFZUbP17zkATcWPNgEC9aBz+5a4Wy7p+soXT1F1vivBZcoxpM9IMHuJmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA5qvFL9p4KatHGLd99IBZFj7AkseWOL5kTSC3n4ZgE=;
 b=fcQqCQ9tGlzSoc9o0YNvxiLrrchAnZDixnM9ATxB7CjR4bSIEuS4RDIfHmWklOrhcpLUvyMiafR+e/r+1yRn5T3boaaS6cIMqcG1wvnUn0wo83ySGWuSv7r9mJQTQgTZQZli29R8C12RTOZA2J12u97Ql7cv29nC8fmiLHatqY5R3yOwM1Nyu40KZ9aE5fajsgUk2xLrmilUU3iVP6m6RINZAPvwswfnOn3ZJQz7zcVoUZtWm7dCUuVpK2s299SLOxc2sk+IymHHjR436TiaqVnElSx66oroj5F+lXzxiYmtZWZShqnT6l/jeG71FGGgH2XOSskSK4Chfs37OQybGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:13 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:13 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] dpaa2-switch: fix handling of NAPI on the remove path
Date: Thu, 28 May 2026 20:34:52 +0300
Message-Id: <20260528173452.1953102-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a9291f-8fd1-4ff3-4f20-08debcdf798a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kXaJM1vt+UC23AjeW96WkJkofndFGtjzME59a1yBAzsjLhrgo17b5DjC33mSfkHrKu5xo+6TJ66Mhs68l2AcIo8K79qK4fKv9Y2ME/B3HDv6+jHM69bUlcP13tj4iUUa68Ewts1c7WdDH/pcmTufI7K0jNt55eG/6KdVR0lAYB0jxHWcpDQhFdUewaXwrR/rRiLHnlZ+ludLNN5LbFcHYpsbvZvP/TvngLROzrLFenDrbOGRKDok01uGFLOoB8/mOUgzScmjZX367k8iqsTse8ptJ1MLCfvoeAvPHN30epbZdlnGAL9/F1W8hjVF4YWj+mzzUK3qqIvpu8NvqErrQQ40cSD/S4Vl73UqO1AJasdBMJFPH1U9fy955+2iHlYqTq31aT/Q7hzzXuzIagnsg28JG1OYDub+q1Jk66Va5WQHwiHNqiYl8MI5DjKhzyFwJ+cuAkSWgZAlMuqjU+esoG3xrkaM4oBjx6RMIGJnjUEwm+6oaVXTsfaIchmN0hwntFCH6Sc+siZ1GMxb5zlEPuYD40If17YIjXT32b93RlIBD12XhDJDCSinFCCgbhE205UIvkPhFtZmeKYi5P8taERp9OoclfSuCS3Vgw4AEk1/zKJ21lec53b+Lm1EQmBGlizMNiRHnlQn7SGeGeOVaxETnrxKIuuq1Or8wCFA1m3lMRzlBgE6m4CqMpEdBztg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yJ2koxmTjXPgZ1E9fiLKuJlL00YKkACJRnbFOlj9hzs+NMQwgWzTUefrw3q?=
 =?us-ascii?Q?DLU/kgoSEuMYm5m5C/UWZ/w3uOqNUZD62vgBc3iW2WPdsds4FZXbpuK50Qjo?=
 =?us-ascii?Q?xqJrYsy2MyGsteqpbZOf42/OLiK5RF3bcXD++xT2jxqVFsYRuZYyv6VVkHN0?=
 =?us-ascii?Q?/MJG0hYgTCc4HPtRYno32Tn5nzhqEfsua33a6VabJ2bWFI+fMU+9L1teS6Fu?=
 =?us-ascii?Q?0Z//TUfUzfKZpIy1iMAKuhqhMdSYrTViTNETk8RxmrmaJYZnsXo5SAIBBy0L?=
 =?us-ascii?Q?XjZ759Zcvg8BukKQ62sF3SWCUFbTm2K1NE2ZVQlGWYQiG4wf+Ao73kuNCTOF?=
 =?us-ascii?Q?nIaVijKa0vGt4vq1XNC2vT+EuymgfCo8WbwxRLbBbGGQDQHN1rgER4lWnRmT?=
 =?us-ascii?Q?bdNwnyP6uwrgb+nbv7GIAK4U+Al5g0PwBmYEvjDa3S6MvkVc/XshmUx0isAx?=
 =?us-ascii?Q?CMVMYTU/qQpLXvrRnugQxybQWiWN7fI/pjIue4e25iPOJRRewzv4OiXa1JC5?=
 =?us-ascii?Q?oR4Lvj7zKGDE3WTi/N/CZblLD9twhbi3ccXnuKTxQBCiS+VzInpwwtTEg7qG?=
 =?us-ascii?Q?+6rqPA+S8vj8fxEsEQjAdhocJ6j7KjOxtJF86109Ok+gH+TBG7voVffK0kle?=
 =?us-ascii?Q?jVgZ+8CHdUlFWHkLllg6XKdMJEUnhaiBvj0RiJ4qL9fQ0HIvccqrMbItpLXf?=
 =?us-ascii?Q?G5ipOVpPdep/d/Y505lE+gdd8WjyMmxr8TcSgpb6mUXLCPkJzQ0WORE2+j6v?=
 =?us-ascii?Q?ZqagJSB9Ni3gAjf7ngeReZV7hDSXISsntcY7ISFXQ00wYSMGcEOlEz3BIwXP?=
 =?us-ascii?Q?6+vZt/pMixO2s1hwkCIE3ow2OdeXaTNAKGaQ12Cqm27X7EjvVHYBFIxlcHRG?=
 =?us-ascii?Q?XPp9wZDWGYfGPo9jc+LLimCh4LdVo9WTpfrMcCJwgsnIIo8AAkqVs2rBA60q?=
 =?us-ascii?Q?ijchebgPWCbIbnWwGQ8MLQlemeOvOqbB8ziuutBcCWz6k8CwN3K+p3x422tV?=
 =?us-ascii?Q?SdftOVvfBDy+6W7rXfqelZvPcPNK2idldpaHY0pkCNTPFP95RzfYKblEilc8?=
 =?us-ascii?Q?AiB7Q6f+D9EU5HfhNKCq1ZrdewyPmMT5AAlPwJSlZV54DsPMnrcSC1HYuBRW?=
 =?us-ascii?Q?kNkmrnCA87mdQXHVwszzp7370oSxMqE+gRxwuREXN5PQzbfv92RftSUMv5Qs?=
 =?us-ascii?Q?+Z0BGY2sYup0Hv/Y5vFlsHEZ6MT4Z1XVRdhdJTNVRFuFT6x1XiUl4rC6/snc?=
 =?us-ascii?Q?5qTPjIH8ZFfo8PezdVQQJoNGOg5pwW25z+nA4MNtp9BkbDtvRxqkHXqNU7XW?=
 =?us-ascii?Q?X0oeOV8q05dyuFwa1u00idaSSmYRqUfqdOr8vDL95DbXMH+IVKLt8ofdgEPF?=
 =?us-ascii?Q?4guSLpChQAzmc/SDVnFcCNT9MKhdeOge2ZC0JA+7a/wneStiHZPUqUr18HU9?=
 =?us-ascii?Q?aHUW7DB3eQDeSqz/Nuw69YMqZSBf1465K3a8d1y/fPJk8yQCQbYCvqyhyrkD?=
 =?us-ascii?Q?LtYKe534ua2gFVyzRK8tX7YBOKyNcNByV2Qj9Wxm0VLFOm0NSOoKzmUArWGA?=
 =?us-ascii?Q?cu+KOvAxyHomX0OeNHYUHNHMLeY2VanMSau7EU97X6KQGX/RpElHHIk12w/6?=
 =?us-ascii?Q?/d/zirP5nz2F1b/p0JYvDzsHQ+tujEwFY72zbZ9+tj3HcsYZAqeedZtpfMbd?=
 =?us-ascii?Q?XlDo6CqnWYJ6Fxp/GChj5M8snPUBDF0KGdBfPiUbglL9jI+j1WWjPGMDrzqb?=
 =?us-ascii?Q?KGHYoPo0cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9291f-8fd1-4ff3-4f20-08debcdf798a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:13.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKsaRXxxMNgm912mznKO7lElm7CrmNtRrjLCAWQubc0Ngwi7poLhuzKogTFLlpH/mnyGNzlYuxbuAy0ub0/bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
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
	TAGGED_FROM(0.00)[bounces-292788-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 803C55F5DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All the NAPI instances for a DPSW device are attached to the first
switch port's net_device but shared by all ports. The NAPI instances get
disabled only once the last port goes down.

This causes an issue on the .remove() path where each port is
unregistered and freed one at a time, causing the NAPI instances to be
deleted even though they are not disabled.

In order to avoid this, split up the unregister_netdev() calls from the
free_netdev() so that we make sure all ports go down before we attempt
a deletion of NAPI instances. Also, make the netif_napi_del() explicit
as it is on the .probe() path.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 505ccaa93ee4..a0bf5b50aae5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3304,7 +3304,6 @@ static void dpaa2_switch_teardown(struct fsl_mc_device *sw_dev)
 
 static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 {
-	struct ethsw_port_priv *port_priv;
 	struct ethsw_core *ethsw;
 	struct device *dev;
 	int i;
@@ -3316,11 +3315,17 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-		port_priv = ethsw->ports[i];
-		unregister_netdev(port_priv->netdev);
+	/* Unregister all the netdevs so that they are brought down and the
+	 * shared NAPI instances gets disabled.
+	 */
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		unregister_netdev(ethsw->ports[i]->netdev);
+
+	for (i = 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
+		netif_napi_del(&ethsw->fq[i].napi);
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
 		dpaa2_switch_remove_port(ethsw, i);
-	}
 
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
-- 
2.25.1


