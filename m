Return-Path: <netdev+bounces-287537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHqTKalaBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:04:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A9531DA2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D610631466C9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F303FE374;
	Wed, 13 May 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jtuKIgMl"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F033FBEBB;
	Wed, 13 May 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669840; cv=fail; b=AHg5lWTTznFZ/0gE93ZH98USv8kHu7rxWSB2V3s6abgGNu/9jKlkUP0kkSVuCMO8QchawwRFm+EzOGTSm6hKG9+Q31WqWNM34lcaI8pOmMUtIh7r0/22q9R7Ot7Q6dPIv2lxhDopTdyuBXIU465nwyfnWtT7FsgcHDmF7txurJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669840; c=relaxed/simple;
	bh=Iur5/EtmFT2zL21Jh7pMQGrXgctdMZa93XjWqR3bj1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blp4W0X/8/rKm7Gx1mzSCMtfTRPlK9u4Go2ZYRmNckZxGb0ko6DQyBISt8kKuaENTk/tAAjbVgyZzPAiyRVYEPrOAJLmUINI9qBlEODVfCzCFP5+zAbqPvZorvQrVuXAAkh3ZXwROGg49CiOAwAothOg6eS0EAxelTdBNgFndW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jtuKIgMl; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9B3XJj1fssCQ0arZ7kQ8dYy0O4YWR7cHw5O0vaWS6vJ8bR2rv6wM35FQQbJKmw2J6R+QHG6GefrZoqeQtOqV3QXN+4ENlkfcN+b52npD1o7mZXMXtTYsVilmyHO1B0/2QkocH86kBHXHHqgZSz9zgHcohCpYrmkZpusB2Ebiu+wkzgxXHNYI6tnz4OlGlIRLDA//yXOFaXFm/Q/EY5U93ci4zkmYeIqcUMzrYcrtqaxH4xvaoYE686WzAMJfpfbztzzuTQ62OhW95cIRINJtlqah+C6Mqj1/CuQm73zbdLQTpJ1D7c7lhrrEMi3SdrWsAXbiA0iwvgpICVDRUZfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyLzV7m5QIuSXCBQxaMXkthoJ59wstg0QIw9FXal53o=;
 b=tuschVQ0wgBhRctgecbevREOsK/ZoiVWBXLuRlabyoa9XA9SHmTJLLloBgDJND84TfQSka/Z8jcdqRY1j4OrWDA8Pmyq7v1Xw2W4VnROfTXASp9qFvfr7//43jpWVYRlke6gy886ABVB2YB8Fg3okPpzaZCiPCsNw1HqplpqrfqoErPwjVdL819G1Wx/FPmb9IEZ3o0xIxtHm74X/DClXVvNiMlKQAEjAx9ZDrcnCgL2AWjWj9aE5AkxFTSJT16leD2hC11q4eps1zNCHtGV2kyqUYMFy3sZCdIs4z5VXrwRfv108kG5JChAZhryCz9wWRlA7VN8BG2Dwytt7oajCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyLzV7m5QIuSXCBQxaMXkthoJ59wstg0QIw9FXal53o=;
 b=jtuKIgMlpArWW6P3K2bM3IOnI2MS5pjOtrgRV4v8BUHsQMF+wY6ZiVkOUKPxKbpsyQWxat7Pb2KPugC7/aGAbj5wseEPd1SVBJgpVeMs9o5GEPgqoweNISFIPfnCnhL3lzH8T1Hd1wKnReN2T2GoPbs1Ir5l4t+w56znoap2CHzLb9g2fViWTkrj3awNK05PLJKB5fIDyN6RNkgxXM15Uyv7aTEXNtzls+NL8HSRcIhDyI2wD8z4IllNJ+E3gagFdy3LWwi/7t70KrUpHKpnS3feVyiMMSynzinrT9KFKfwbXXfgV4Z6tTEh59rktttZo23mzT2YvdUrjuO8cV3x9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:57:15 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:57:15 +0000
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
Subject: [PATCH net 6/6] net: enetc: add ratelimiting to VF mailbox error messages
Date: Wed, 13 May 2026 18:30:21 +0800
Message-Id: <20260513103021.2190593-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c93c85-a5c6-4591-6952-08deb0de64ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|56012099003|11063799003|22082099003|18002099003|3023799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	KngjcANmSLVZAqEF0WqCsdsYzR7wafXOBU9Ze1cgKonVfaoGmVQ30q46tz0sPm2UY2PDikBDwL6c7soopvjmY5m4vyTflKWtOF7aGevLXkMoQQENMBc9a5G6vGbMv9mZw/RlIU+j/R0SbbuV4cdPWVJTBWNHhSwGUotLGr8BDXXUVYjiliiB+n2jULVUfRvhqcXJstADsdzLkpnEAh0Lok7c4yeBUorYtlAG+5shqKAXQ4l+cuWfOC4wYzyDfFSDYkv9uIY8PmKHk/vD5GEd/Zty0QoYKQU9rG5YK6Y2+S0CEzMW2M5SnOJBmoutE9/DNPf8J83BxSWMn49pA2HFfNqNCuyS2YSe8rfXKAdgrVdShy+r1TBN5ZJFketgbxok4tI5reZTViRJBUzScxzf1RClDgRz8fn1Rq1XXCbSMH+FGM7AWDs6l7I4sX3A2s5OoWCR5/vIkqdDxzIfRE/o7YHsa3ge95+SOe0a2VPdF+qjGNXH8jz7jwYBzesoYt2uUCeWRI5FzM2qXU64iRU+C2mdZcJWJ+ru3CigUcRCiaP9Eqs63GqIKg4EGtwxbNMR9f0anvLO4AN8kM9y3J3uptaR4FfCkWYXCvSSGy4VACpw+Suo6qZCick6d4EpJQWp0gfIm7Ilwd49wYC/zmq/T3yxXycluVcwFvUul6nR5nRThPVTkj75YoVrkE32c5pc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(56012099003)(11063799003)(22082099003)(18002099003)(3023799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dxll1sUnGWS12fx3oFivoOHl3k2lTab0wkMcqsJ7VdkUfRtwl9BgAdWrdp8/?=
 =?us-ascii?Q?UrkAhnCqcU0qJ2+NCiLnq0q5A2eA/t4uQU55vd4taASkRt9Z8EStZreyr4zr?=
 =?us-ascii?Q?7/zR/IegVDPYoDQ83ZoKucQdHpM48WLKpRCVqUq1HIaL5gnxI+LLr8mB52RL?=
 =?us-ascii?Q?jg496gZpmHsJIhEyroDY43CqBYbBAw2XClBl0LxGghuaZ8/p4ELMX6AOz25m?=
 =?us-ascii?Q?QgZ5Rq86GzeGrQbbH5wqmSfNminrVtEdkjhSTOKImFoE3PrlcN5LpVsUdOxa?=
 =?us-ascii?Q?HIdFmahHDQ8Kodq1M8rKabGBwSxrl98l48awWIJKVnwd57sftOs0dPw8fCXq?=
 =?us-ascii?Q?RL6gJyeu5rKuIpDpenv1BUhSxYFb3s9xHr5/ZlSzwsLy0tasOqKZKdSo8pjS?=
 =?us-ascii?Q?U/YEZuk+kBLZMJbcvWcLlwYb6gglz3FweSK2npt4uzwtIfgDP8y9nbWW/KVm?=
 =?us-ascii?Q?Pt/K8N0LQGKBzmGWKnSKVU3n05jc15Bu3Osn19osHsm8nn/KiPBFrlgPFPI7?=
 =?us-ascii?Q?BdmsqSi7lbo5T1oR2KSqIbjYhpnGPk1kJtZ+9cDvlFxXUz3aVyPpxBWnem27?=
 =?us-ascii?Q?Mv6MwhUsISxIdcZNjwgGzo8boFc8IImSetJFLbtbpwKve4SWIqad4lDOUgou?=
 =?us-ascii?Q?MMyBrgQIptUtQ4q8oqYLScjaq/3BM4VMKcRq3foLkev86QCG355rDqZlIqG9?=
 =?us-ascii?Q?OKvwGiDTAPzBYLp/K671f3+OQMEokf+CR9PBY5hmTzen50HXIxC043hZdIyZ?=
 =?us-ascii?Q?ba8r0BzLWgIj/d7XAKBQvtkqb8QPGOpyWGp9tD8qINLShvbteTEUWJjfTLIR?=
 =?us-ascii?Q?Deke/5wIptPABntS/9XOWybPkCdfPEavy2m8oVNgUkER0bbcbCPngvtcTa5e?=
 =?us-ascii?Q?+4edT18WQWnyqrktDf2vj8m2lRNwih1Jw/yuH9gnzLQMlomC40VSTeK0ciZp?=
 =?us-ascii?Q?ArrKaKrUw3qJHcgxpg65rzzyu4Y13W5VgS5pNgyUIisvHoG2n1H10GAJlrHS?=
 =?us-ascii?Q?Lj+YwYljjI615LX71vqIhUH2cyZZ1lOXT/F982kYkkGbUhX+9bakPrbeOwDE?=
 =?us-ascii?Q?f5/sQhjxWNnlGQdRysY811gl4WhRdg5BTRneUFwqmSgEOTz8X10wi4sDwjU6?=
 =?us-ascii?Q?UOF5X5egOZNieegJdKijO8Ge++0PSnbsBaNpu99DLqG567W0SVeAyozzaxvQ?=
 =?us-ascii?Q?xbP+i7VU1nV006ZvzMCHFOnUc2XeBcX+Q9LQr5GVcRQZ+HdT45/bvei9x8eI?=
 =?us-ascii?Q?r8ycnYOWc3uzZiI3gJzEa24ws9OmWKy1BN+8CLXjPP1SZ46a9QP9lJsVhsj+?=
 =?us-ascii?Q?ZJjujEIdPGTpJUIFf+ailbHKTv8FrS55355R3r/i0slQYI5O0sagHv8JDzFY?=
 =?us-ascii?Q?QfQZuwgjL5ue+WlNbF6171ZYvCDMt/ykxVCJeNwTA4spC4DhkOcoUBnEYJLN?=
 =?us-ascii?Q?nzfFmZ3AiifQMyJdvKE47yDoncxDl21e7CGIW9cZhCicQS/LsGpPkfkj7X3V?=
 =?us-ascii?Q?hOkIWZ9Z26J89oyrwtgT3eoYP+MjAkHS/t5jc/kkiMvaS1E/lu/16j+ySm7a?=
 =?us-ascii?Q?/BDbDWCLXlVVJqhrwCGrXJQol3/Ad7+xV8Ie7frWgefua8DJZMgFvHVR1sL1?=
 =?us-ascii?Q?4Q5ysRcchmN7vGmWzmZBxVjUk8MG/swiOUJsxEAatLiYoRSkTtgSsJUghd8A?=
 =?us-ascii?Q?h/Son1xJUDMJUdlb/W/Az6/CQfYKkIirc5ll4Rkz7TIcTMSOkWU0L7z95Yly?=
 =?us-ascii?Q?nClCZx/ZEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c93c85-a5c6-4591-6952-08deb0de64ef
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:57:15.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTGHv2MxR751CI4z5gxlKXudwWoFTYDrbC2+UIcdNvmFK7qpbcX9meq6oXK/20baLKC+TqE5HBnhY8Up0Z0wMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427
X-Rspamd-Queue-Id: 482A9531DA2
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
	TAGGED_FROM(0.00)[bounces-287537-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Sashiko reported that a buggy or malicious guest VM can flood the host
kernel log by repeatedly sending VF-to-PF messages at a high rate,
degrading host performance and hiding important system logs [1].

Fix by replacing dev_err()/dev_warn() with dev_err_ratelimited() and
dev_warn_ratelimited(), limiting output to the default kernel ratelimit.
This ensures errors are still logged for debugging while preventing log
flooding attacks.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 052cab48df51..73a899b00308 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -505,8 +505,9 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 
 	mutex_lock(&vf_state->lock);
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
-		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
-			 vf_id);
+		dev_warn_ratelimited(dev,
+				     "VF%d attempted to override PF set MAC\n",
+				     vf_id);
 	else
 		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
 
@@ -531,8 +532,9 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
 		break;
 	default:
-		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
-			cmd_type);
+		dev_err_ratelimited(dev,
+				    "command not supported (cmd_type: 0x%x)\n",
+				    cmd_type);
 	}
 }
 
-- 
2.34.1


