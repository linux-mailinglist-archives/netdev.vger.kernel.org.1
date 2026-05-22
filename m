Return-Path: <netdev+bounces-290740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIVWMsMgEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 594CB5B119A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5859230170AA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C73C3789;
	Fri, 22 May 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TsOO25vD"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A85309EEB;
	Fri, 22 May 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441754; cv=fail; b=JWzgLl7cOcN+50kUe1uI1rQZCeaxwmZmBIVSQ1GfStMQ4LXJbv0TACD/fWXgYRJf3zwU9anv64sM8wPtNkbEbY/LZuNZB98bVHfYPfgAN6fO6V0Uf4vXw7tjgEUHNuM2LTlKQtVv14jFzSWD7ZGTPV8jTS/6cxldnwz5Ibti8Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441754; c=relaxed/simple;
	bh=WXADH8RklLM1nxkINyg6vdExQxLDtHhRky1q78jYBVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE33t560YZO9RS+WTeLzvIrwOlUUSMqMiQqelGCVBaAXehff+OQsvlS+VKSzPAwNp+7153FsLFl7SlWNbSHn10zd5UxMNKDWU7GXffU0GeDBgsAzqCF/ot6RJm0eIpZ/X0+Kw0fbbmyo7ONLRZaOFxbdKwXYX2RJgiJQBsn+c3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TsOO25vD; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdAOVaJhOctdZjCdzwVdjMdfilpZ/FEW5whV26nEg6kwpUMIgkEmQ6S1Ntk6YZR60BLN5vyFfObjACT1lSe1ze08XE4+Zsnp2IyXdLSB61GEIP1EBPTkNjt54dpMyx0MR1cqjzer79RbHS7AcsVTYmMVVpSsljm/61mIhKz60fZbsIXfzvzLGaVn17WR9cN4RF3qtyrTTXm1TQBS3HaELHNjlMCiLQljN2PnfM0OznJwgx7gvrU9xNTabh5evhue1PmdEO7OXxq3bomMNYUTLTWE6ETAkwYhOtlPwIvqL2CrZmYqhEtpTbCwf0Zk2hhqOu9NSGNk7MwG9nj1qxaEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruaErZIqK/b8/f1QNCxsWsqk+lb9Ky1zB1CJcLKqeCM=;
 b=qwuGdwxd3cLdJXleWDhOAp5NCYAEDVFel2BRcchoxC5ByVeV/eDkWllHNsxeSMd8cZRgjRC9YiDNYWuNNhgpxdsw83U6ILPYfYLFTt6F3ZDOSKA7t09auCrY9L9AIL4RDGl0dKLHLvVqr9ifysETQ6c9QfTaV01icCYeJ3pYuku6WX7yN1GfdNp9KvwbJchPH7WMrDOPHUR7YQ9/o9xDb/ZkwEx4dyY83gmBXeTXulWIu0FSWKFX2THVsg4EzOB6gsCFcKaNlwwbgIUvymz+eGpHD1YE8p41zhBAhkq1GDv8UYc/dFdHtYm34rYfsCvBZOpkrnF/fOVU8E44oN5dvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruaErZIqK/b8/f1QNCxsWsqk+lb9Ky1zB1CJcLKqeCM=;
 b=TsOO25vDxLshQ62NphTbQqo3WnmfkVCgr1+IvC7vYTpNrMgrMyaqQP/o/kSTICBZt/uhfofFJm1EHIx/M5Z+LuyozSRfFixV6kMQSmRvhPf8sAoAWpksFmmgfQc6eNwhCgMR32PQGPh/DPhSGXVIAf6a1b0DkIGPaOjPwQYPv7C+Xg20CSotY7Shtu9KnhBn8U8Y6GRwFo/ColakcO5y+XNoMHTzMpoQ6gx0nYJIlazSNS3NSip5tDhoji2r5ZjxCupQcoShtf61iHxYwY7JfDmoN2fx59LdNdGPH49qzm3oBXzqDpz0kE0sEM6u4A9iNeD4uh5W5D0UKLvhQXFokA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:29 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:29 +0000
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
Subject: [PATCH v2 net-next 07/12] net: enetc: add VF-PF messaging support for IP minor revision query
Date: Fri, 22 May 2026 17:24:33 +0800
Message-Id: <20260522092438.1264020-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA4PR04MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ddeaa5-93a9-4907-adac-08deb7e3a4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|21046099003|22082099003|56012099003|18002099003|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	S3TYl/51CvcbR0ksVmzDyut9vXpZGtYQ3G5HC+Ux5kccWMesnWdjn8IQw/GtcAY9TMHviYYROvI0k6YVKN+d+G2JRKB3nCF4q1PI0KmPEzkgH/BYBzdKKPizkicOwl0YuPRpKDikS2aCGAZSv8pLEQK3MFQl9mujJALPfq6Ciek04FkXLLOeb02LYpNgYzEp2/90TDp84dktv5AmQyKHMgSAdCoV6D2CNw2P4qEoGEX5zap0xfATIolURSaEPH3U9w+yx5YfMVDM8P18ot75FUSBg85OcffnrD9AK++i/FuqgLEhls/1B7NiXDULOdjr5wuy7TVXrBbIvAcAXM8sAFKqXbqur856+gfQNbQzDCmlLFUwtcwrpP8Djpt3hBOm/Bp2URcPwcNCSLVxqV1Lcab2kO3sX0g3NWK3Nl5+qY86c6QTnkAVaaxcWc4DX5yhDN7/6+ZQ+H2QePEvHzNGlZu8AjrDXqHTJQVUz3HrhNBw5bhWFQQpZOAy9TTn0KZ84Tu8y3F6FwYlk1eKvVf3f1HmbLIUbeycuqiUiHk7VX3YZZnGx991jMhptPWztT8D9kPwHUP6705yg7lgrELZH+U1zECDnkPCPcUVQ9V9bd4Acn9UFh7bD8J/3mhH33L7J8cJRcwSUCLNgX4IcgUcyzkPQv4OgWrhunAbch9uWfAy6vFRtlYxkCTeyuLZNKxsNcvAe3NAgCs4v7AFCofpO01jceGBmch8m1weJIFpPgiv3LW1d+jAssS78EJFqE/e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(21046099003)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3x/+VXDY2EzikSsXuWH1SXsgQy332X2nBRUBvqJUfTiaqCyNXQCCPSt1j+f7?=
 =?us-ascii?Q?lptW25/JdDoFmIfGACtloRcXNU7ce0w7mkmEmszH1n7hL2bCIMJEerqD4G53?=
 =?us-ascii?Q?uD+MEpN0ULu+WVk1HOZ23Cibdmk26rCRll6IRLVIzJz1DjE2jwzQvUkerOMF?=
 =?us-ascii?Q?HUSnEJuWdig1vONfQMvpyFzvntFgSszkjuuH0s33IhyzUx7k/+vGd+N/XM6g?=
 =?us-ascii?Q?fIA0S2Arhc4CN+jHgOsWmtqNm5FhljEVGJAgRm7pCpDwhAI3PG0mrhsEBO2a?=
 =?us-ascii?Q?qtNaVymShv+dlLu+xzEUUkzKwBGh+mqEZnUFqZbDuKAcSvKWTP2JfjO5kbpg?=
 =?us-ascii?Q?t9F2xc+l3hwAiOQPuJTjgXwtQ+ieEoEULERwaQgYnQQmXMgLH16xlD9rghH7?=
 =?us-ascii?Q?t2o7p2oxYE5hX1CT5FXBJDkbye1v2dgstwX9ijGS8WVR6kLi2houE6eWuruV?=
 =?us-ascii?Q?0cFh5BswDfG3bDlNQqZtDILx4VjXWYhP9sxe0QdNOXgSD1S7jFuUcrzqj/BM?=
 =?us-ascii?Q?lazA2OS5AhvGsAGSRjdg0RNqU4Q2jxb+ycs1BaYsR5toxijacwzdWvv+y6zP?=
 =?us-ascii?Q?RZlS/hqGX5RcEDQ/iBK1ujJtrGz13ofD3fCsPwSS+rG0mDcitN3wEl9znL6a?=
 =?us-ascii?Q?KNHRAZI3FPb+8AZj8YMsMqqA2wZKZsLOr0LTdwAkpy/i6ZeDIKBKuEfFcKfw?=
 =?us-ascii?Q?SbLrqdB/ZZdVoO1bNfd3t/YN6Z6QoFTYWopQw+iSUKvzf7Q9jTdRZx3AIf07?=
 =?us-ascii?Q?pwGyAOCz03RI359PtSLFeXocMbxU/ZSksJpbH23hWkw+BGHhjOWcpspaHBqE?=
 =?us-ascii?Q?jrNnvcPASj6gPIC/DKMdHROK8fBuU5gi4JfqAwjy8VD5XWUHIaIbOvvHLXRe?=
 =?us-ascii?Q?qrDrWsyiiUJV2JGtxBC1pFfBxm/av2KObV6DlLAviJmIm7ARAAQ2SR1wqcvz?=
 =?us-ascii?Q?dH8RyhyC90f4uXrpw3EDGPJHox2ql/uj/Gykg0W/1IPSELDSqd7ZOHC7ThC0?=
 =?us-ascii?Q?5dSkshHpKrWGvUdQNOxBBitCtvphw9VloUT8+lnhs4r0Q4vRR5XS6R52sOnO?=
 =?us-ascii?Q?okr3qIBCQRjVK8rF5ctRQvd9BStCiGDlSOR5sFSb5+DGESv+3gVE+ipdzJnc?=
 =?us-ascii?Q?mKnG1bFZiGIhyZ6h4xIEQkzVhh0ERKQWSyk9BQ8+dIU3V5xodWLcpUtu7vUm?=
 =?us-ascii?Q?jAELh7atjX5o/FiRMPcXd5Nn+6yGi3rb+duGxdX1CR3ecffgjb07owPE48il?=
 =?us-ascii?Q?mqB8qbEQmES8/BaqlFU8in3nadDdKqCNE+doaRuYlvN3u9kcLuh1/4MmaeRC?=
 =?us-ascii?Q?5lS0IZOedS72BkvFnixd1pnAgQnJ+OWYvMRuW0R8xkqdTpVAaRnt79Zcj68k?=
 =?us-ascii?Q?8vQ8L0Lx9HZjP6ugxgEiu1k4K7OpaWMNbJg1CGccSgbRhyy1WCHzQkl2kmAs?=
 =?us-ascii?Q?fxP4KeWDmYZzsdPHRuZ/byUa5GJP64OTQc6UTqNa3Pxgm7T+KBloWw/EOhuL?=
 =?us-ascii?Q?jxVUY/nYLV6NAmnYorMljCW3nROTxqEpBwU7aCvByCUn5vDjLLOUOlDadw4i?=
 =?us-ascii?Q?TfuWfb5ugV0z4sI8D6GNtdXewdAdOCiFfgzWw1mVsGZUJYsHGZgLj2yg6gSO?=
 =?us-ascii?Q?sdhaVKduXkzw+aN2Ha2u7VnpAmpMrJc4uHL6dsWUNnEa8bh6a5ZdsuRmSjJW?=
 =?us-ascii?Q?fbWPGaZOgZRYq8OAAIxv2RvYtqKNZQ60iFjLvoKOv/xYYOUN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ddeaa5-93a9-4907-adac-08deb7e3a4fe
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:29.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9Fk/XwtudeCO4c1G9vpruXqdN8HwnQSbp83cVW6m7E6PS9ZVckkol99yOV92w9IQAJbQ8L+RfHm/uZGE557Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290740-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 594CB5B119A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v4, different SoCs use different minor revisions, such as
i.MX95 v4.1, i.MX94 v4.3, and i.MX952 v4.6. Unlike the PF, the VF does
not have access to a global register that exposes the IP minor revision.
In the current driver model, the VF must select the appropriate driver
data based on this revision information.

To support this requirement, the VF now sends a minor revision query
message to the PF through the VSI-to-PSI mailbox mechanism. The PF
responds with the IP minor revision so that the VF can match the correct
driver data.

This patch adds PF-side support for replying to the minor revision
message and VF-side support for sending the query.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 19 +++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 29 +++++++++++
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 52 +++++++++++++++++--
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 86a51bae19f3..d9677da38989 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -65,6 +65,9 @@
  * (blocking requests), and
  * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
  * (async mode)
+ *
+ * Note that for some GET messages, there is no COOKIE field, and the CLASS
+ * CODE field is expanded to 8 bits.
  */
 
 #ifndef __ENETC_MAILBOX_H
@@ -84,6 +87,8 @@
 /* The fileds of PSI-to-VSI message, the message is only 16-bit */
 #define ENETC_PF_MSG_COOKIE			GENMASK(3, 0)
 #define ENETC_PF_MSG_CLASS_CODE			GENMASK(7, 4)
+/* Extend the class code to 8-bit for GET messages without COOKIE */
+#define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
 
 enum enetc_msg_class_id {
@@ -102,12 +107,17 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
 enum enetc_msg_mac_filter_cmd_id {
 	ENETC_MSG_SET_PRIMARY_MAC,
 };
 
+enum enetc_msg_ip_revision_cmd_id {
+	ENETC_MSG_GET_IP_MN			= 1,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
@@ -148,4 +158,13 @@ struct enetc_msg_mac_exact_filter {
 	struct enetc_mac_addr mac[];
 };
 
+/* The generic message format applies to the following messages:
+ * Get IP revision message, class_id 0xf0.
+ * cmd_id 1: get IP minor revision
+ */
+struct enetc_msg_generic {
+	struct enetc_msg_header hdr;
+	u8 resv[16];
+};
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 4ab123cbfbec..edc1277bb586 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -101,6 +101,21 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
 	}
 }
 
+static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_IP_MN:
+		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				   ENETC_MSG_CLASS_ID_IP_REVISION) |
+			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8,
+				   pf->si->revision));
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -158,10 +173,24 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 		goto free_msg;
 	}
 
+	/* The new messages are currently only supported on ENETC v4. If v1
+	 * requires them, the current restriction can be lifted.
+	 */
+	if (is_enetc_rev1(pf->si) &&
+	    !(msg_hdr->class_id == ENETC_MSG_CLASS_ID_MAC_FILTER &&
+	      msg_hdr->cmd_id == ENETC_MSG_SET_PRIMARY_MAC)) {
+		dev_err_ratelimited(dev, "Unsupported message for ENETC v1\n");
+
+		goto free_msg;
+	}
+
 	switch (msg_hdr->class_id) {
 	case ENETC_MSG_CLASS_ID_MAC_FILTER:
 		*pf_msg = enetc_msg_handle_mac_filter(pf, vf_id, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_IP_REVISION:
+		*pf_msg = enetc_msg_handle_ip_revision(pf, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 77c0eddba6e2..7d022b9c12d7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -114,6 +114,9 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		case ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED:
 			err = -EPERM;
 			break;
+		case ENETC_MSG_CLASS_ID_IP_REVISION:
+			err = FIELD_GET(ENETC_PF_MSG_CLASS_CODE_U8, pf_msg);
+			break;
 		case ENETC_MSG_CLASS_ID_CMD_FAIL:
 		case ENETC_MSG_CLASS_ID_CRC_ERROR:
 		case ENETC_MSG_CLASS_ID_CMD_DEFERRED:
@@ -122,7 +125,7 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		}
 	}
 
-	if (err)
+	if (err < 0)
 		dev_err(dev, "Return error code from PSI: 0x%04x\n", pf_msg);
 
 	return err;
@@ -151,6 +154,24 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 	return enetc_msg_vsi_send(priv->si, &msg_swbd);
 }
 
+static int enetc_vf_get_ip_minor_revision(struct enetc_si *si)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+
+	msg_swbd.size = ALIGN(sizeof(struct enetc_msg_generic),
+			      ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_IP_REVISION,
+				  ENETC_MSG_GET_IP_MN, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -202,6 +223,27 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
+static void enetc_vf_get_revision(struct enetc_si *si)
+{
+	int ip_mn;
+
+	if (is_enetc_rev1(si)) {
+		si->revision = ENETC_REV_1_0;
+		return;
+	}
+
+	ip_mn = enetc_vf_get_ip_minor_revision(si);
+	if (ip_mn >= 0) {
+		si->revision = (si->pdev->revision << 8) | ip_mn;
+		return;
+	}
+
+	si->revision = ENETC_REV_4_1;
+	dev_info(&si->pdev->dev,
+		 "Failed to get revision, use compatible revision: 0x%04x\n",
+		 si->revision);
+}
+
 static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 				  const struct net_device_ops *ndev_ops)
 {
@@ -252,6 +294,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
 	struct enetc_ndev_priv *priv;
+	struct enetc_msg_swbd msg;
 	struct net_device *ndev;
 	struct enetc_si *si;
 	int err;
@@ -261,13 +304,13 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
 
 	si = pci_get_drvdata(pdev);
-	si->revision = ENETC_REV_1_0;
+	enetc_vf_get_revision(si);
 	si->ops = &enetc_vsi_ops;
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err_probe(&pdev->dev, err,
 			      "Could not get VF driver data\n");
-		goto err_alloc_netdev;
+		goto err_get_driver_data;
 	}
 
 	enetc_get_si_caps(si);
@@ -327,7 +370,10 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
+err_get_driver_data:
+	msg = si->msg;
 	enetc_pci_remove(pdev);
+	enetc_msg_dma_free(&pdev->dev, &msg);
 
 	return err;
 }
-- 
2.34.1


