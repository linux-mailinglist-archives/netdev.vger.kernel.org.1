Return-Path: <netdev+bounces-269462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMpyM5AJvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:34:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1F2CCE8A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3EF93037FEE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87536F411;
	Thu, 19 Mar 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmUZy7TD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107035B656;
	Thu, 19 Mar 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930245; cv=fail; b=k0omnxkHPMVb6kKXZ9S4rlBWBnyxPLJqcOnsQlg5kRQvsIaZn3Y2RPICrcbQsUDBSrVfls5SNyiXBR6AMiZ15QBD1EUR/M0lRH6KTk/TONcD8GxgkZvnsTtWC0zHUFCQy5kfMJFrE9nRv1RVLD3d3mHYdIv5u5Qa8dIQHl7jZfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930245; c=relaxed/simple;
	bh=Qp6hR6jrZC2HuqkSNC1LBdqCu7sEoeCApJ31hV3VIGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anpj0exqrrdlH0vddTaEltjw1PIlNca5h0eyrwFmyLmwig+jlt1xAVAlU7UQE3HK/5I7pfzpUQ9IrV1wXx08L20liDlT4ww+frgNg27Yx9ki7+OsKRK3R/0MciYK2WZD6MsV4WWsFW3vARrk546Ba0G6TUavAxlY8UavjlocNVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmUZy7TD; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQEjQZGJEjxmEkafOi6PAzne9rq4Bu55YbLMdIpiH/2LjuuTPaSL/ME9qKQmBa4WORDyQLoTWBqPoWMtUvVCPFFwiPH6RAOHrhXmIJwKWwL0UH5oVjfjXlJB/UBTGKn16m6mExuTGeupP0WMdTV465Vz1H9SmK0tBiOXaHq3yflrEGmHbCEcr7iVeHrA/H14oGEi62Gu3DG44tU6UkY+c9qAGh6gkjxXYqvRFes548wJZlE0DS+/06QP4bB4ySuylza1uHXOp5zOHnfd88iqkxk6WS3a8A2RdXa3J33t6qbZ84Uorftb9HNiP7dlfWOwTqacrstREfCYaE3tnawTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC74Bmqo79BAkEiKPuB3X7BXX60un+txbVYi3XfGsKA=;
 b=QBPY0RwYt4bSfc8S2omOJ1uJ3k5juxQFPZ8sPNc1gdzqj1pBGbl7eDTXt/34yiWEjVDSmxF+xF/oY9yzaH8CjxebCHXBDgqcd7/lzrwwtrZrkG1ZF5aYLvfJeFUQxJisEThe2dzwcuE8f9CdJL3TbF29s9tbhS6cze0ILMuNeVPGEhtpTlmeEmipAV16BjKRTsJxBe+cgrBfEKQOXl2e9O4g4dyK9uXjdmhNdnV3lQ27KsRNPtHttUEfsaS+UDGhdLZk4a+IjpOc/YCx9/QOpfkZWODFmMK4jyODqRCm6ANxmqNhvzl2oh/nebI3aCauEpE9lsiNWto11eHbc6C7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC74Bmqo79BAkEiKPuB3X7BXX60un+txbVYi3XfGsKA=;
 b=jmUZy7TDM0agr2kHm0arcrH4ZWlmmffC9YlqgPDiem2kXM6uVJgpnfjKiGXobXzeaI2Ck0McGVpIWgr5Tg0ejO96muglNg7r6W2rLfK1DFFbN4yF1vJ28x4tS95f1X50dUirIxobdoctqabox4sH1/CHMcipcQT1AUWF0/LPVGFgPQe2FrAmAndAv30MfawBj/+7L6LGEAp0hsa8P12DjaXvZ/im5/aq7YTYQjfW5Ql77fHUnSR2sCkNPUfpdPEOA8dZFlbgyQxiaeNouZvpO24/mvELuqJaBoeV39T5CUhDyNABVsaUP6Uj0OSBXPUGDVKp+wT55yHTlv1QLufFaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:23:51 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:23:57 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/3] net: dpaa2-mac: extend APIs related to statistics
Date: Thu, 19 Mar 2026 16:23:44 +0200
Message-Id: <20260319142346.2483232-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
References: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::8) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: e6db3070-7b87-4766-c931-08de85c32807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2wHi1mMQ3zvvVwN2y5DUMCZK2P3dgsLQXuSkFlX2B85i0ZbYjSOUBPKZi/fwpcasdq3ubytgaD1R8wOv4lvwOfw0QnmM4dlU06f091eMN19HJrKo/EUCN6zAaXcyd4Si9Bub/9niPr1sa3KI97LiFj5M8kkyexe0bKDf0hisDiHXWqTdwJjimPoMUVmyLqYS3TokWn9tuxmA/5nbC6uXOJ3w/2DNm+LA5An0xuN5zfcFlYyPuPNowhsmIGPB44nsHkfjfOOFofL3/qt8+IN+PFu7egsfEMLDgOfIJvoHo5cBNKirQGbiQJdns3p7xhrTiZN9yALxm0JtTi0q97o9fK2IMIe2ROzbXHVzZn4+Ctl70ZKzjb6kskfC4cRBZiaolNZmGdaApVgADDuKMrUL+CrlRGEqR3JXS/F+9SszWWiaKBiUqQWTMquDh0jb5fIEjCytTHq68ElG67GS3AkQ6IbD9OMlPGnM9q6eP47R1EqoEjYXgRM70K+eBGSe4Ris5C1GSHvrMyQFAfTF6QhTeSs9AEB9v0TqSZgVW4YefAqpNjXKWsU+g/AZ9jWc3tV8mmYFNy7dPrexP+MB9yce8gQHKznviluWWBfRfXcoNIyZHRZ6+T+pwxeIvk4ywpsKQL8Ai16yHuLIfsTEI+XbHDDzdD/gmCcE/tCMZ0LkXfAgdLffuvQhCaK2JC229TGKPibBbdqB53jX8zTFxC+OE5x3qL7Arjhbnc02cdBRUjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7f3P3qQ02NN6slZvdV7vMxZYS7SvZwYmFU8z5P7ofTlDjMoiUKBCV+5+Z7x?=
 =?us-ascii?Q?RB+JQkTosgdPyuO18Zss7qPd9XXjjC2okAq/ariYTKQw4Sxop6cz7VsnaIQe?=
 =?us-ascii?Q?6n+fRm4VylZODNPWx+v+zQGfpENgwHAbBdxNCnphT/ukI/uvBuEah5hves6k?=
 =?us-ascii?Q?xhcaHCCqmY8a6E+Szk+9y2gJsE4QU47i50QEa8MKypL4JYWu03Wy1SA/lX7y?=
 =?us-ascii?Q?oygjwyKu4mGk9BLhJg8HRaqXKFgWA8qniZ346JtP1uxCwND0GDQ/G66HmCj3?=
 =?us-ascii?Q?gsbiS0gDsPPgBG/G2JWKMNoz6CSIaKPHD1zk8AaDrd0h//KWj2AcCR4wCNPs?=
 =?us-ascii?Q?u1SG/BdYSSy4pyOpFQs/edgyRlLGhg6qSbg374BpRQClgwRiwUDl8oNizgEi?=
 =?us-ascii?Q?oJkoYR0oVTM/CbP7rdavqgrJ/ZLOwSN2i0yXYM59c2M7zsiBHJlzG89Nvakq?=
 =?us-ascii?Q?fQ5cXOnOr7pXKt7zE7SPx1NUg3g6UzRk6Lth8vco/WaA+nCf21r6WMx6JL30?=
 =?us-ascii?Q?0WDMPnWzHnrRwyWfsXYzTxRQuJ+wj7M6HpnfoN4dWOX6AZFZqZhpoRN/c9vQ?=
 =?us-ascii?Q?0HgFPAFJaV9X/+7CFTTRR0QEhCinOpq/WJH+Tp9UOlPBJK94MuXRS6FsHNfy?=
 =?us-ascii?Q?NGw/qxk4PrtRHEosoqhCYUfm70zd7Cdt5Fvae4vQoGCOVJ3011F6ekwpIh1l?=
 =?us-ascii?Q?jS+6msS/GYPvSTH5X5Fc4zQ4HAlipTTF+R0RZScq+VLMBCIKm5tkgw8o8q2F?=
 =?us-ascii?Q?SdqncCL+q1FhXh4u+dD0kuaLyIR3GrLjluSheZFi9vLbk9eZ57ShqmN8S7fz?=
 =?us-ascii?Q?TJkchC4KZVyE2204DcqTPGnKQEyBAx347fFp/Z84xWdDHe+uKLI4rlC48L3H?=
 =?us-ascii?Q?zeTAroxrHgoqhqeTRPEUdGQT+z3NSengqWUeMjlW1sGySVgWHWIpn4Tc7GDr?=
 =?us-ascii?Q?CpES42j97BWrk1ySyAGzXbuS0sMYrrD8T8NcVMLrHg70tCtzMUI5NeexGd2E?=
 =?us-ascii?Q?m2Wk8xgZ6s5jFjPcvgpYzElbZZvS6aN5NypqHckVTM2MsyGngle6lrocpQ9K?=
 =?us-ascii?Q?E+CXEjf4XXoR3o09/qO8txjr0eHMPYar8dZlMat1Nlf4xC5y/+qlcr/P8M3b?=
 =?us-ascii?Q?PmI2eRkLqPxDK1sdPUBh+6YUjp38IOt5WB5PlUdXWik9gPFQao3JcYrcGWEz?=
 =?us-ascii?Q?zvA/JZJsAd9ELLHljqsm6PwFG+OmSBjIogqHQMwrChJ+aXnA2u9bwLe4p0Ko?=
 =?us-ascii?Q?J7W+pvtm7a1MELrip3g3V9wI3H9r5PpjFczi+tRI3jMLNtRlcAtskbsKS8on?=
 =?us-ascii?Q?a9sZXZxLqMru27LW8kHK8GKIKzxHl20RdXE1gkHB1JXD5/GBcnSK9Bk/1KAE?=
 =?us-ascii?Q?inT84cwAg5WtsdSYUmZgvWDYNfIQbxd68a8ZTG6oKbrImJnkDCerOJFBRR5k?=
 =?us-ascii?Q?dWfw5hQnRlx8fAIB5R4geRTuOd4lQYJ8h4Na9jjB0C7l8YvuL9DkTmQw4RMg?=
 =?us-ascii?Q?ep8xBlWA2ZX04CHUH5HvrRbeRFer9djyTAU43UlwiIwNv/tozmF78evg4X8k?=
 =?us-ascii?Q?pYgF9NQ0MDxwQdFlJ2LudFneYk9F3WzNQfoMyJOuBDsdSkhH/RA4NRcME1oX?=
 =?us-ascii?Q?+FT72ry5B+mLMfYlvwgfD+WF3emJYqsJag3HENuYwLMGxOl+Pbd357y2IArb?=
 =?us-ascii?Q?v/6lFiGycLnQFN6jBHl1foAWLIDwovOxQkhhIOUsgYRyG82r3IiOEAxaEWzM?=
 =?us-ascii?Q?/FC+l/vsSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6db3070-7b87-4766-c931-08de85c32807
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:23:57.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D7Ak5nrv6KlxctJK/BsQI6kK42lw5C5ujlN4KC0WJiAg1HRUixEY5OnMKGEEnjiCewFPTiFkQY73EZIcYRwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269462-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: D5F1F2CCE8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the dpmac_counter_id enum with the newly added counters which can
be interrogated through the MC firmware. Also add the
dpmac_get_statistics() API which can be used to retrieve multiple MAC
counters through a single firmware command.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- none
Changes in v3:
- limit the documentation entries to 80 chars
Changes in v2:
- none

 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  | 11 ++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  | 31 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  | 94 ++++++++++++++++++-
 3 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
index e9ac2ecef3be..a864a99a0f75 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef _FSL_DPMAC_CMD_H
 #define _FSL_DPMAC_CMD_H
@@ -28,6 +28,8 @@
 
 #define DPMAC_CMDID_SET_PROTOCOL	DPMAC_CMD(0x0c7)
 
+#define DPMAC_CMDID_GET_STATISTICS	DPMAC_CMD(0x0c8)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPMAC_MASK(field)        \
 	GENMASK(DPMAC_##field##_SHIFT + DPMAC_##field##_SIZE - 1, \
@@ -82,4 +84,11 @@ struct dpmac_rsp_get_api_version {
 struct dpmac_cmd_set_protocol {
 	u8 eth_if;
 };
+
+struct dpmac_cmd_get_statistics {
+	__le64 iova_cnt;
+	__le64 iova_values;
+	__le32 num_cnt;
+};
+
 #endif /* _FSL_DPMAC_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index f440a4c3b70c..efb9864d051f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #include <linux/fsl/mc.h>
 #include "dpmac.h"
@@ -235,3 +235,32 @@ int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpmac_get_statistics() - Get MAC statistics
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt)
+{
+	struct dpmac_cmd_get_statistics *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_STATISTICS,
+					  cmd_flags, token);
+	cmd_params = (struct dpmac_cmd_get_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.h b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
index 17488819ef68..b5276168b869 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef __FSL_DPMAC_H
 #define __FSL_DPMAC_H
@@ -170,6 +170,58 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or
+ *			     bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good
+ *			      or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames,
+ *			      good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ *				  larger (up to max frame length specified),
+ *				  good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ *			   frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are
+ *			      valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ *			      bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ *				 but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ *					   truncated) due to internal errors of
+ *					   the MAC client. Occurs when a
+ *					   receive FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ *			    packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ *			   for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ *			      are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ *				 0x8808) but not pause frames.
+ * @DPMAC_CNT_ING_PFC0: number of PFC frames received for class 0.
+ * @DPMAC_CNT_ING_PFC1: number of PFC frames received for class 1.
+ * @DPMAC_CNT_ING_PFC2: number of PFC frames received for class 2.
+ * @DPMAC_CNT_ING_PFC3: number of PFC frames received for class 3.
+ * @DPMAC_CNT_ING_PFC4: number of PFC frames received for class 4.
+ * @DPMAC_CNT_ING_PFC5: number of PFC frames received for class 5.
+ * @DPMAC_CNT_ING_PFC6: number of PFC frames received for class 6.
+ * @DPMAC_CNT_ING_PFC7: number of PFC frames received for class 7.
+ * @DPMAC_CNT_EGR_PFC0: number of PFC frames transmitted for class 0.
+ * @DPMAC_CNT_EGR_PFC1: number of PFC frames transmitted for class 1.
+ * @DPMAC_CNT_EGR_PFC2: number of PFC frames transmitted for class 2.
+ * @DPMAC_CNT_EGR_PFC3: number of PFC frames transmitted for class 3.
+ * @DPMAC_CNT_EGR_PFC4: number of PFC frames transmitted for class 4.
+ * @DPMAC_CNT_EGR_PFC5: number of PFC frames transmitted for class 5.
+ * @DPMAC_CNT_EGR_PFC6: number of PFC frames transmitted for class 6.
+ * @DPMAC_CNT_EGR_PFC7: number of PFC frames transmitted for class 7.
  */
 enum dpmac_counter_id {
 	DPMAC_CNT_ING_FRAME_64,
@@ -199,7 +251,41 @@ enum dpmac_counter_id {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME,
+	DPMAC_CNT_ING_PFC0,
+	DPMAC_CNT_ING_PFC1,
+	DPMAC_CNT_ING_PFC2,
+	DPMAC_CNT_ING_PFC3,
+	DPMAC_CNT_ING_PFC4,
+	DPMAC_CNT_ING_PFC5,
+	DPMAC_CNT_ING_PFC6,
+	DPMAC_CNT_ING_PFC7,
+	DPMAC_CNT_EGR_PFC0,
+	DPMAC_CNT_EGR_PFC1,
+	DPMAC_CNT_EGR_PFC2,
+	DPMAC_CNT_EGR_PFC3,
+	DPMAC_CNT_EGR_PFC4,
+	DPMAC_CNT_EGR_PFC5,
+	DPMAC_CNT_EGR_PFC6,
+	DPMAC_CNT_EGR_PFC7,
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
@@ -210,4 +296,8 @@ int dpmac_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt);
+
 #endif /* __FSL_DPMAC_H */
-- 
2.25.1


