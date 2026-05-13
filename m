Return-Path: <netdev+bounces-287532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MgCLDlaBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:02:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BEB531D55
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7F063133D00
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A43EDAC1;
	Wed, 13 May 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0WHCTUd"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1273909B8;
	Wed, 13 May 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669818; cv=fail; b=kSDjaLTCtf+rkVmlxhsXIZPShu+CJZzbkORvfEHZ84nejVvqsCcD/2IICxnJevU65Qjfhv/u5l/u1G9XN5njBl6aR7xymYwYZBawdxCYUZ1om8Z+hlH387ZS+iHtftDdplNXn6Qgh41O7UVz5VeChAzVuaHBxyMZJJ730hNcqIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669818; c=relaxed/simple;
	bh=fh7niOxEmGHCcyDMZXx8AjxDifr64F7uhehvA3RWPrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQSOwYCaUhoSAa2Rgd781+G2Cifc31x/ZLY4u9GHkd+fwigQmT+UfwJeIoci5fTCsa/+fDWVxIL5EOKNmcyEQZ7DY+kbcFToGiVDxxqKJFkRoU5Siqkt5FDvMtt0LQoFA9IRrKyQu3Yxd34XziooetYSf6+VRK86ngT41tkDFfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0WHCTUd; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8cJq3LlFCoQWATJ705/SH4+a9r+DRu7R60jJxxlNNTkZZ0an2d9itRorJ5sCCgWxa2Yh5Z/jXkKNt6jzVAywpyT/XZGiR+HGlPKT/nqYF9jcO4y0vfnF1DRYTPQzNqytyiaugzyt4Q2FNgw6vPPzPYesfLso7F+g93oWgO+w/fMypRUqYZbDQjXDMXljpKx/2EkWqYFdPXHwEAzm/H4nUMmnRhTb/fJclWsCeQh3NPP7ak8TkAI99DhxDsNFZRGe6LUe2kPH787na2sq++FqcD/H1TDtEQdGJ1svmq6zBp1yuqPXPMPjDZdWFxIkM/mvTZAddKFKTmFsPFyukZDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=333t3grl8PdiRXyo7BQfOGUaSJJGyzmSPOB0dYgjkqs=;
 b=GNDhK35Sr95KvpWij93wwcl08r5H9Xoe20OkbjiBGIeM5GXp0q3R9Ep07LYsQ56GYiGTPFAVWRJdh7cKPJzrEtP71/v4JTiRJ+HYblH7/4296UdRqBzff3nggXpQhA75UE1yF4MlDejYUYVqMpORW+Fv1x3p3mUYISEkebzjSgILyUSqPwCn0KjvZ+9RS7Th1Akg3YDS9+MkajoSyAnapGtw0RROOqUVcppmD9MiCY2cc7F2IIIoGrLzaW38XuFtnOdgGnSbPxxdHHEqE2Lqxx50ocLZ4/NPSU3lQPDayl90pd6J61i7YeFPhE9LeZ9sGcezE/kYMa0HcWilA6+bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=333t3grl8PdiRXyo7BQfOGUaSJJGyzmSPOB0dYgjkqs=;
 b=N0WHCTUdmWnzouwkdpbhK+dKmF521fJCF470Y2Ojjw/QLjRsh1Tt17lYlLd5fLSDWyJAWnRM8RlhgtDNixSE86mlnX7WDbHEaqkQgSJ7nRqPCJ+W6P/5SAKdACeU4keqgUkXObBsIwkRZqninXzgEa1kTgdBl8DX3mDQUZlu3hUoKwCWOAJpZQM6wD2vEEtblLetmArEox1fdr6GVONLKy7SIulJ5UBQes2A7ISkCKMPM5j50MfY7cXiWOhXe7hb93be/Uj8VYV1CVBbKvNZEWHID28J+E1zbCJ3bBn/qc4Qtf2+MKmry2Bka9AlLgAbMblNwjX+Q4NleKX1EQuwUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA6PR04MB11806.eurprd04.prod.outlook.com (2603:10a6:102:526::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:56:54 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:56:54 +0000
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
Subject: [PATCH net 1/6] net: enetc: validate VF primary MAC address before configuration
Date: Wed, 13 May 2026 18:30:16 +0800
Message-Id: <20260513103021.2190593-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA6PR04MB11806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ced972e-baee-4239-d02a-08deb0de5814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|11063799003|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MdwG8MRKPb/gwqQkKSrX2BP985F4rKkYKk5Q3noNPLuq26TDTDJ7/XnWzWHRO6lXRmoRDyXG8NSIeazmK+k6E13zIGj6Erg3YTvnf4WMQTEphYYMvCaVf6yKNt2JSxgAMHBReQ2394C6JqenkJKyEEHiRC9STPO94dxcY83M1wQlwVAWXnD3ukn0MI1LpMp92Yzlf6uj7LEcKHE2EZeoEAP74QjQBHysdD8jZMz1iEnvzEIa7ZwElY1ZV41wIZkPRphjFXgnmo0/eYz5RrV85M8iG/Z+Z49sAVNxdwXWZskyJsig86t5pf0lwhr8HlT9yFVn0oLEQVxn99jIQ5WUp7w4sGITXL+mt6kZ5MBnGekU4d7U7q8W04aA8dylnbWun2JBOb3HyOFAjFqrvg4SN+WBP+p38NXGIe/am102ZVOcPoBrlntD/g6d/AgSNnaLemLEBTNguGllR6EUh+NWq40AntgXWAKNFJP/VG8k2rvOHyH824nWhZH0gDHdYVbJtPo7XwF+HxPKEOFrcRLirGNbmt5YB1ybkIveV6M0LiOhrG9JXJU6YFJ7zovoQBKDRQagcfH0wVPoAORgAQhZ5QozodKlcdrO1KubAIGQaixNBeqUL/ii0w5zTNoK31+whMJR16XRpi1NG2UI6Yelc9EE+7xSu5cvv9S0dLa7rVUGZxP3KQIB5JWY/Cr6Rwfj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOnI3y99Tk/DoTtSFpE30ch1QWn2XcEOjxS3F0aPYBOtm7KxlFTpfixX+J+x?=
 =?us-ascii?Q?JhBZXCf8yazGh/Vo6lTELfo68k5Kri7r9tJycHY5QUphIiQsvVmIFokN8fhA?=
 =?us-ascii?Q?dBj3BUy2WvlQKP9nY/+AlHOqZcajcmneCLPR6fwjVN4vaaC5myfcZ9sfvX4I?=
 =?us-ascii?Q?9zLtEYLxqRvvC1RYqUz/0b5TDmZ0M1zscF3eJ4KWYPI8BvzFP+R0qpTV79OA?=
 =?us-ascii?Q?ZeLgNIWBSUB2VTVnASh1PStlTGmdzAaowawUr18d9MA3nD/xmMWIrD+yRgip?=
 =?us-ascii?Q?6kNLKIGyiod1pjKDa5S375lXO0qGvR+dxk5a4mVEApc/h6Um//IxyrW5XVsX?=
 =?us-ascii?Q?h5tueVAYkGhnWik/gS9a8WfJfpqVyklk2FlfTiu0ugfeXbWTkyGXmfKJxZRs?=
 =?us-ascii?Q?EauUJR4Vzc/120ZRvzjx9z31jsSSsjqZxKLAcPt/FG8Idnd1HILbISy6HiEC?=
 =?us-ascii?Q?lMiQZ3F7lUkyoo+cCtRabFwj3oty3yaDZw+MMTir772mdyZh+OIRpfrVw+iw?=
 =?us-ascii?Q?I4xuUEsnstuwYkTlltE1K/tMnBjv7LQKxXEfNIjM0nisQaRRtrrnwUTjw0eS?=
 =?us-ascii?Q?071JPY/sqRE7MN+u5Bl0q8uakhNtI+JLzKVZ/Pa5rvPklU0mPT7RwOeVN3Wh?=
 =?us-ascii?Q?d+waPiqT2h8Cf1q8j2E4mw2ntg+CwUPuCEpeHjoJjHgkRnhed70iV1TaX1DA?=
 =?us-ascii?Q?yOPt1zLLq7LziDLR9LbPSczDezRyoirkIYX0mt9OrFvuzBSzJg+Pi5k1FkEz?=
 =?us-ascii?Q?QZpJaKEsXyGQKcPjVDyTICUzOm7NqvsVuaMfJRooiMH5RCroVCKBaZi7il0G?=
 =?us-ascii?Q?47xnkYlRl7MJFAWv7qVBdQBSQa9UNKHl+bInmp8WTWCJeHrfJ2L2m11vB7nu?=
 =?us-ascii?Q?sE7he45h63OMiOwdSj+IMA/5MEnS3HhYxFTnjq74u6yoOZicFEceacS70yLK?=
 =?us-ascii?Q?ul8qX6uO40T0z59GyzP0PNsSURv/KUU5BOZ2n1lOdtYGk1nwYLiD+b+ZW927?=
 =?us-ascii?Q?Envr906vDyEHdLez8ZjbUy9FRqop7LWXQqNOL1WixY51EJ3HvU7x61ybcMNb?=
 =?us-ascii?Q?n6AFtN6La0VjMi/TxxXnx0LmnNpQXfy/Z6217Jqv7CbfQDsexiLNqcuH57gB?=
 =?us-ascii?Q?hdywiCB2HElp5PeEDJ1wISCIs3yYB+LSm5gPyh4rRwM5WDwW9tQqer97wJ8A?=
 =?us-ascii?Q?D/R75sPPmTSlxnj1+do3E9CThi+vqP8vDQcFm/h1LDkQR7BH44YYxPcJXS9p?=
 =?us-ascii?Q?oRfCGXjaUbUUDtzABZgqO8ty497dp1qJ5OqYmZi4kH3/05LAsO9v/G/ExBqc?=
 =?us-ascii?Q?L9FoBSxViRDjiP35OgsPB7CnhUJzGuQtwkdKJecSEmMR94s+YETQjaxV0gvD?=
 =?us-ascii?Q?06BH7g0xnCPa9nfqPqBQVb+kPAtLe1+W1A5Y1yr0c/ITdT8q7sI6zjucnoBd?=
 =?us-ascii?Q?I3E0qZ9SNDD8VN4Mr2B+zfEPpl91Z+Ozz7Im5ydOmxrbrBO+NCdwgEEbLj0d?=
 =?us-ascii?Q?K7A1OohutTDuJIIvSkwZgARt3WB5Aa2UyUob23WfIHDzmtyDFXME9EMOgo4w?=
 =?us-ascii?Q?aV1+M7a19Sf/y3eiBOjmaQnpBQZihzzd/ZIcNksaH3RQYkBEoET2+9tyc9QE?=
 =?us-ascii?Q?LYsXXSAHcsA1Ssmck0wx6xxmYigRa6GSs0IEE+3dcGdFM7MOVvr9SGJVM3pN?=
 =?us-ascii?Q?fa3KHYgS8tttEG3IIFX1ho9BL8cvx9blz6z3paE6iwsBu2D8KqD2YA8yb1vl?=
 =?us-ascii?Q?1OJo9Lb/QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ced972e-baee-4239-d02a-08deb0de5814
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:56:54.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znolo38tYvVnvRZA7EfoRWVa2DM+samo7TY8q4VS7kqkwG5vqwNWmTvTTAadMC3ML5tEyb/UD2Q4R0Szr/x7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11806
X-Rspamd-Queue-Id: 12BEB531D55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287532-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko reported that the PF driver accepts arbitrary MAC address from
from VF mailbox messages without proper validation, creating a security
vulnerability [1].

In enetc_msg_pf_set_vf_primary_mac_addr(), the MAC address is extracted
directly from the message buffer (cmd->mac.sa_data) and programmed into
hardware via pf->ops->set_si_primary_mac() without any validity checks.
A malicious VF can configure a multicast, broadcast, or all-zero MAC
address.

Therefore, add validation to check the MAC address provided by VF before
configuring it through the mailbox interface. When a VF attempts to set
its primary MAC address via ENETC_MSG_CMD_MNG_ADD command, the PF should
validate whether the provided MAC address is valid.

Reject invalid MAC addresses and return failure status to the VF, with a
rate-limited warning message to prevent log flooding in case of repeated
invalid requests.

This prevents VFs from configuring invalid MAC addresses that could cause
network connectivity issues or unexpected behavior.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a12fd54a475f..756614ffa8c6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -493,6 +493,12 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 
 	addr = cmd->mac.sa_data;
+	if (!is_valid_ether_addr(addr)) {
+		dev_warn_ratelimited(dev, "VF%d attempted to set invalid MAC",
+				     vf_id);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
-- 
2.34.1


