Return-Path: <netdev+bounces-294778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHZtOvc+IGq3zAAAu9opvQ
	(envelope-from <netdev+bounces-294778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABD638C58
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:49:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=IBREfsbG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294778-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294778-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 710FD303BA5D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37137386551;
	Wed,  3 Jun 2026 14:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0A33F8D4;
	Wed,  3 Jun 2026 14:36:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497404; cv=fail; b=BLTpviI6lVaA4KzQKZSShydqC6YJMrEhzI2CfvYhMutEDxujIJcDvMK3Ku4gAk8PHQoYIZ2j/r7bpao4k+sN2LjJdfgEduP0Xc3fRqtqc2amRY07LiIO9ugcsSUfXaEm+B7jWWfrntWDTDj34mYP1aqv11w8PzkHENCBeftoi9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497404; c=relaxed/simple;
	bh=ryWu2/W/iy+GigEnQn94Z5YyK5tmmJsA3a+Rh5xWttg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjVVOZiNNsPw0W+oxvaB5kpB/L/+3hlEoK/6CyfpA3aPYnTwWci6dUUGM8H+3qR0y64BOwMQPAjYSjN+LjW6Yw+WxzcsKIRkc68oMjTL3uBFd5P4Tpo3+XubWrYphag5dFXQeCFF6xXO7r1gPY/TOJzVBX05EluCYfFnHQVvmTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBREfsbG; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHenufjnVA2wt6FjkQE1+Ost7HiQ5HMpletZAP7iHsoaiL9n38Qez/MrIkt1Bx67jVyzP7Bwyy41QKQC8xI3q4l1XLVnXFwbXo1qCzHoYdiXB2b7UZ7+R/yPmVCrxqCwLrxf8zBlmrq9OO8pXeg7AtCnPOxmyuWhM4d/vGlsLagdIL/PofM2nyWLUgk9z/Rfn6xF49U6+piXzIT/MO2ODOaR9paGJJ7dGv/GuPBq6ngfPvIiHRvi7VJpcjnlDomUtDrauDWXoWKvqjTxSbmJ5mAXeuPoiI5+gt6t+pSzRU0nopOSeQ6v+jYVpnYK22jZmXxZle102N2BOCtc/x/HIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV/hc4PaBP8coqtEesj+qKQ9tBOqkgRI15aC+Jrakq8=;
 b=ZIlSUUIGquvCdFfOgB+j9Bz8kji7GRo2ZoFcjv9rKHZPyyBVvJFhug/kvqO7nv/JIHnQzypN2xujohV5Rr6118dnHzjPMa3S1wLW6Jrtm34KUkfagBJdOxUDwnS5vXRtY+iJYHAg2oNe5kxDzHB1andGkjhswWxnO+tk7NmDsku1gasGs1E5e7s/65hGw1vrJO7/w9jno8rcn0Z74/OdJ07ekoHcdZXR3Yy8gun5eDeidP6mOTuyIOQKHSQLL4s7aFpsGpDAgw7k8mH3oIQWCUmClsuMCLj0fJ5aMQYC1cP/dgHxRfea2pyEPuZzU5PuAXoxi7iVp3PLVEv3ZaR8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV/hc4PaBP8coqtEesj+qKQ9tBOqkgRI15aC+Jrakq8=;
 b=IBREfsbGuIKj0agT3FyRSpwkovfCpEQv5N4Iiex9wH1pvB+SGyMi26h8KCdzUQi8uPWSPPKKaNgNJGE7fL2ksy6toFSJWqdf4sf0kSp1GpxtYrrj55AGM1e6TWd1NuFTrR4j+0n5xrpu8LpaW1KV/sXNPxJpJzLFlYvikr0lkYk+Z8qU+13T1TzGtVDAifiWE2CGNjFgU12XAPkwDOXBnHR3XyiLIKT1zdkcdgf5MlKVdOfMer4cK8YxOQKGV34Q+1rYVA0huGtC7eBlm0M1kVeFdw3n8wFSKr9pGFrN6pZ7SmO+41HOxF7vC65fmHXApRHvDHJ6vYuOqr9iu6WxxA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:39 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:39 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 01/12] dpaa2-switch: add LAG configuration API
Date: Wed,  3 Jun 2026 17:36:12 +0300
Message-Id: <20260603143623.3712024-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b38697-d643-45a9-418b-08dec17d8593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	P0P41JibqcTGQpztqnBNXVzBIWLd6VoPFTMddkbq1bi4Ufdy9swDwHZNolTVGaa4gd6SWPGWqqYp27r4T4C3k2LYqUggkFCJ4BeMrZqCCvqE0yJ5VBEZLEbSWOlxFnNCktR+E5oYEoRgl6f3grHCxV6CW+LCPRr+EmKzKJBZTnNbAv2BgVRW+Xkw8pHrbRRr+J3ubUs0/CnMvJSFh9+9xkB+GLb8LASpEBZFMkAcNAVfnxebTSwD27j1IquA9x5kN504MhsyoraNKXEa9wHdjLLowB3hIhhYwz0az1mS4Qh2lV+VJjjjX7udjtVerfYKKrNAJdJpD6nwlZ9U8TPf46HDnPK2nKsRHcImJDdWL0U+4O2O+gmqwW3qYkQmIKY+Upj4HZOWmFxXRg3E7S41B+h+9kKJF6qrbYUptDtkk61SuUuyMvKAAgPTa1HoXlQrgZx+911voJfjI247QfRFtChXzD/00cjW8wMpOOnuhqvHm2eqw7E2GqXHY0us4i0Wz0EaEHbwz//02LG16EDOGuvnqnTu9pxaqu2JdKNaAXlFa5q4dqKFvwMhPbx53pCQ6tGEMmlKnpSeABMc837OBKSGbPIqqbjTzYVMX5T2da+pG53A8a6heLuOOQFvkpCD7b6Kxl/fcqOdnntnQMHBtfhVMD62/JRpLTQY3DLPS6HWz3B/D6IffnW3925JSUFO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dU3DTtv6cQlIJap+C9xORH3bN0ib3c0iQ+sdv9RGTFJ762nRVcbC6nkyZYN/?=
 =?us-ascii?Q?6w8kW3qtmGsyJLV6xzRZhfbwndX7h/bbu26Tq0tbG3bSaxv1QmctKr9L3pU3?=
 =?us-ascii?Q?EkL6U0MBgs7+cdE26evrxXMW5BQTNmi3BKdFcRcscmm25YNsima3ugFN1aUT?=
 =?us-ascii?Q?P09TOT2EVNxEGzTHO928yebKgxCr8yg95Hvj/mTnZluWX5wZRm1uvWIvYjwM?=
 =?us-ascii?Q?ZfOYzEqBcSxeJsgeUXOTiglzcqi859DnWKdsjLFZ/lQR4T+OZtSHu0+We2++?=
 =?us-ascii?Q?z6VuLK2+oVYbYs/Gu4B9c7B9gsS966SF+p/bTa0ThB675iv0MmCOakSuIwry?=
 =?us-ascii?Q?i/bBZLas/3/jQoOctWcB+3bY2DBDPi6zlV10LGxOh3tfVTI9ffJvF0BobT/A?=
 =?us-ascii?Q?ax4CMvBj/B8fHMAkRuF/2PrwmQTcROPtQr1kIFAPvo9Ji66dF5LDEjafcs4h?=
 =?us-ascii?Q?lyogghIbgBFEK5R/h+Kyaj7aOJ7YTvBgF4FpTuZM6oTGOETWELw+sWj2ykbr?=
 =?us-ascii?Q?gtJqWZ8F8VMUZLDvVGNGF0U09H3klZVG22REKhvM64S6zrxxZn5jBXPQEu0l?=
 =?us-ascii?Q?1ERjOchKvleQ2HAjXEWh5vZ9C0F22lfRbjwD6pE2+kPWv6w7Vc4neSCodamS?=
 =?us-ascii?Q?HSATUdUWlj72POrlHm3ued1jOXfIj0UVBsswGS57YuZgVm4yrANWNTSxeHum?=
 =?us-ascii?Q?v2OznnMxrqK6O5lC71YNYL4vs2pR0dnUbFR8gn1V77JmDR/JDZEouvoVpW21?=
 =?us-ascii?Q?q+C2I5t3xz8/XYo+JHB1UwzxfKvOcqgrX9JZQ7FcaeZZaLFl6Y+m00GO16N5?=
 =?us-ascii?Q?RWQK3ESo4RxaWWcwROMDWhq3a470aGx+AspvJnB6Gl5V8ec0o/JcggQi6wFU?=
 =?us-ascii?Q?miRYcXhmqp2nHGi66CkmEgAWvco7a8v4CdlzCxr3O0FWunPlZUBwxDWpiavO?=
 =?us-ascii?Q?otWjOhQ+slCaFizdtCKAuLCnTaQ0cBJWIA9a19jbrmB/3zl9uiFbz8V502ek?=
 =?us-ascii?Q?d8A2O2bdLFrMzVnXy4pbAU27zNbbbs7RzyFxMHCP0JHTDTu5DgtH3osRXYTm?=
 =?us-ascii?Q?HClo3iggmIvvejPb2ZnuW2PWeksPuXLfbUamxaHwHtq2fhuwYNw/meegCPKA?=
 =?us-ascii?Q?CNgZlf0MGCdo9e0746yu25ZenoCsIUAr6JpUoaJZ9RIHNbvWnoIz41tZeGOt?=
 =?us-ascii?Q?oqJb1plF+N1oaWFWDikmUyTAcWm5RXL8Knt1Cq2BEcS0U+pOHMVu/ybXvKc5?=
 =?us-ascii?Q?NWuTVWH5ed9gr7i0RuKLDLe0pWe+gEY9cf7/wAp9rtWEWdeJoHlt32aUH/5V?=
 =?us-ascii?Q?AZrNJ3WH4DwUGrsGC1SGemIYX85YNST6Jd76Ddj7bTTYRFn2EMp080cxS3DF?=
 =?us-ascii?Q?ublJWtlpdDPHZowTy/9qwJ57V+jGB1gPCwCxBpHIpWuljtVwaovQ4G3vycjW?=
 =?us-ascii?Q?ipaBRfYpoe9og9kZtmw2TmtjMdUBg1dh3/PsUjODkV4KI7C2Ag/K/5cYlNe1?=
 =?us-ascii?Q?BsxKnZ+sjQlOFLV0N5wLFCQ2dzy2XM2i74SyBhZtFII0uvtRE0RuQiuolCng?=
 =?us-ascii?Q?j5ToN7uXFLKX+I7fiiN89uE+gnmKbcYgUaWVMDh81HnbODIFfuW5aYHq5XYl?=
 =?us-ascii?Q?wnQOs+kjvvSyOnv13Ye1TUoOt/slYZ7KDV9E9vl9PiVNLX3L5KyTpWQiU0iA?=
 =?us-ascii?Q?aVgy2SzkEEh05ZUgZwIqfDNoAAA6tHHkggs/q4ZOH7CeEEL3TJTfEFg0g3TZ?=
 =?us-ascii?Q?8qu+rUC4JA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b38697-d643-45a9-418b-08dec17d8593
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:39.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC3VE9J/MvC7oMKizmmiAJtxNZbwbMHwbQKaERhCyj1hKD+DMazkrx1+ePJny9jm67tMlWHns1r1cqPj29+1tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294778-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9ABD638C58

Add the necessary APIs to configure and control the LAG support on the
DPAA2 switch object.
 - The dpsw_lag_set() function will be used to either verify that a LAG
 configuration can be support or to actually apply it in HW.
 - The dpsw_if_set_lag_state() will get used in the next patches to
 change the per port LAG state of a specific DPSW interface.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Add a check in dpsw_lag_set() for cfg->num_ifs against
DPSW_MAX_LAG_IFS
- Add kerneldoc for the dpsw_lag_cfg structure.

Changes in v2:
- none
---
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   | 18 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   | 60 +++++++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   | 30 ++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
index 397d55f2bd99..9a2055c64983 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
@@ -12,7 +12,7 @@
 
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
-#define DPSW_VER_MINOR		9
+#define DPSW_VER_MINOR		13
 
 #define DPSW_CMD_BASE_VERSION	1
 #define DPSW_CMD_VERSION_2	2
@@ -92,11 +92,14 @@
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
 #define DPSW_CMDID_CTRL_IF_ENABLE           DPSW_CMD_ID(0x0A2)
 #define DPSW_CMDID_CTRL_IF_DISABLE          DPSW_CMD_ID(0x0A3)
+#define DPSW_CMDID_SET_LAG                  DPSW_CMD_V2(0x0A4)
 #define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
 
 #define DPSW_CMDID_SET_EGRESS_FLOOD         DPSW_CMD_ID(0x0AC)
 #define DPSW_CMDID_IF_SET_LEARNING_MODE     DPSW_CMD_ID(0x0AD)
 
+#define DPSW_CMDID_IF_SET_LAG_STATE         DPSW_CMD_ID(0x0B0)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
 	GENMASK(DPSW_##field##_SHIFT + DPSW_##field##_SIZE - 1, \
@@ -552,5 +555,18 @@ struct dpsw_cmd_if_reflection {
 	/* only 2 bits from the LSB */
 	u8 filter;
 };
+
+struct dpsw_cmd_lag {
+	u8 group_id;
+	u8 num_ifs;
+	u8 pad[6];
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+struct dpsw_cmd_if_set_lag_state {
+	__le16 if_id;
+	u8 tx_enabled;
+};
 #pragma pack(pop)
 #endif /* __FSL_DPSW_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.c b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
index ab921d75deb2..f75cbdce42ba 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
@@ -1659,3 +1659,63 @@ int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpsw_lag_set() - Set LAG configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @cfg:	pointer to LAG configuration
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpsw_cmd_lag *cmd_params;
+	int i = 0;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_LAG, cmd_flags, token);
+
+	if (cfg->num_ifs > DPSW_MAX_LAG_IFS)
+		return -EOPNOTSUPP;
+
+	cmd_params = (struct dpsw_cmd_lag *)cmd.params;
+	cmd_params->group_id = cfg->group_id;
+	cmd_params->num_ifs = cfg->num_ifs;
+	cmd_params->phase = cfg->phase;
+
+	for (i = 0; i < cfg->num_ifs; i++)
+		cmd_params->if_id[i] = cfg->if_id[i];
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_lag_state() - Change per port LAG state
+ * @mc_io:      Pointer to MC portal's I/O object
+ * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:      Token of DPSW object
+ * @if_id:      ID of the switch interface
+ * @tx_enabled: Value of the per port LAG state
+ *     - 0 if the interface will not be active as part of the LAG group
+ *     - 1 if the interface will be active in the LAG group
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled)
+{
+	struct dpsw_cmd_if_set_lag_state *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LAG_STATE,
+					  cmd_flags, token);
+
+	cmd_params = (struct dpsw_cmd_if_set_lag_state *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->tx_enabled = tx_enabled;
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.h b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
index b90bd363f47a..89f0267de8e9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
@@ -20,6 +20,8 @@ struct fsl_mc_io;
 
 #define DPSW_MAX_IF		64
 
+#define DPSW_MAX_LAG_IFS	8
+
 int dpsw_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpsw_id, u16 *token);
 
 int dpsw_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
@@ -788,4 +790,32 @@ int dpsw_if_add_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, const struct dpsw_reflection_cfg *cfg);
+
+/* Link Aggregation Group configuration */
+
+#define DPSW_LAG_SET_PHASE_APPLY 0
+#define DPSW_LAG_SET_PHASE_CHECK 1
+
+/**
+ * struct dpsw_lag_cfg - Configuration structure for a LAG group
+ * @group_id: Link aggregation group ID. Valid values are in the
+ * [1, DPSW_MAX_LAG_IFS] range.
+ * @num_ifs: Number of interfaces in this LAG group, valid range is
+ * [0, DPSW_MAX_LAG_IFS].
+ * @if_id: Array containing the interface IDs of the ports part of a LAG group
+ * @phase: Use DPSW_LAG_SET_PHASE_APPLY for LAG configuration processing or
+ * DPSW_LAG_SET_PHASE_CHECK for LAG configuration validation.
+ */
+struct dpsw_lag_cfg {
+	u8 group_id;
+	u8 num_ifs;
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg);
+
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled);
 #endif /* __FSL_DPSW_H */
-- 
2.25.1


