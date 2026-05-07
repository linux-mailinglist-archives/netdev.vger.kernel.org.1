Return-Path: <netdev+bounces-285303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDEeJuOC/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:17:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA14E817F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0C3730074BA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A33B895E;
	Thu,  7 May 2026 12:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F035F8C5;
	Thu,  7 May 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156255; cv=fail; b=u3p7CyHShbkWBscx0RE4REU4MLn2MTdjVec3Sa2fc9x/hUd/7couPRGSHYvOdotzh3sJr3A+qmlHds5r0zhVK9KwfaZS44+2HTf0m4vxO0e7AaupyJTJoUPxmTSF6JpAOnPPrEd7r9rdMqQreKD3xDtw+WGVjZQAMX+hJtmeZWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156255; c=relaxed/simple;
	bh=WDfi3GrItk+nIdBwGgl5JNfzQQoCO4uajg+G2yluUMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjEPv9qK4lbYpmVf3wT+2s2/zRjtR4Lrt7cDilVE1OeSsGN4TbmNTr9d6+RmE1vIY9f0Hwybms0zqJ0D6H7aIzKlYeJxRS4rJD4/eBSSQaLlyV148E1tXVqd8d1LZg6emluh6PmhS5FcqdRrM/IoIkM59V6Mu7XIbrtdj4YkJbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZZWyrCgmY9RgU7bhpds/JhE8tGp8QvQ7GYnTJi8RMhHN+qfQfZWO5dR7DtiaYu9Aiag/WZGX72w1qts8vS7KlC/LuOuJxHdgAeWWT+MALWReY6kfV3OUn0ZvmVJGZ7dlD4xOKOBWYQ6QW+azQI6fCB6rDGnRVzw4ypvxBdQbsrGd4/T7bgAEj6J7bi+3pRxnxk6F9DroBDYc3bRf+qFjFpaCIpNXZwKnEvN+tu1XrXaZn+R6wbHoAU0ApQerBNbKTXIm76Iy4aL+5Z20xYo8ufDmA33CStCoY14URvFgsVrXd8WkDvwAudlOivNekZsYOKRMz/VStXuGQcjMbKSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wve0yqKAnwC7Y0OQAQZUCEndcyLS/ujIG5e1M+Qtoc=;
 b=c3tSETA0al32blsv8hQ2UUiFWwJWJDs2zatVx97Pv/sbDHbHIlDnfX3QbLcUC8dT79r15fFG6SIXWtiAggeRGiyUOMBnQK2280Su1PLqs3CcR6YDInIURDqxBpppYazX5hE7bM4vhs7u5xKgbS48Khd2boAZXRWQEzO/IzbgDhjj5hogirJcTBgLM5RTDrC13OFr0yzyKN4cHs+Tmcsv4FpLwhYpSKHQWyhDTerya8fFIY++YrVkiIA/zBM/t58ZvKT82eNQ42q3m/TbeTAzb+CDTWOv284ANxciR+NOL+tJ30mgo1roYJbv1r+tIdika5qBsa2f7vde1xSnD2ryOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0870.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:41:30 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Thu, 7 May 2026 09:41:30 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 5/5] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
Date: Thu,  7 May 2026 17:41:15 +0800
Message-Id: <20260507094115.8355-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260507094115.8355-1-minda.chen@starfivetech.com>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0870:EE_
X-MS-Office365-Filtering-Correlation-Id: b52ea212-2d94-493d-4f28-08deac1cd142
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sx9YUrgXBSUhW2O/oXemz8UvNchd5bh0HXNK6qGJMvmfG/tphxa4gHVIrtcENgK0514JCjp+i0OthOrmZ18D+7XAlWnTP9lYTc/IW77KnzRXvTIE/NrzVSCRyzqC6ty3ZDw/03hFm6gjk4JilRyzp2uf/cAZKPg5l54CuQC44q3z5YuHJprrU6lqrlH/g36eq97Vass7yzCMLFzhCq705eHIbAZKhrL5UPu0RthUG87950PqY2r9FRC28eV9+kwNW71PpaV3cRPJgVUgLQX53m+Ulf/D/DFXF0hm8pnDgofCCblJxGfKX1f76MhZ/jM7TVnDek5eIMPobZ7EdKmftf0zYDAMY+ofLtHWv8zNw27PmB6c+PpMdKh9N8UxJCKkifVgYXkbu9jdJUlLOu22Y5WJX3/Lxnvxw4TjVZRZQ60/lpgVm9zm3wLI/RsGpgeSuwZR2AFigXRoc/bxEvwJ99VJTWhdIB8vfCk+bxMwI/4UAa8qTM4oNvrl1yqqNbwZAKWusvbq9BmxF+aPZAXoTlZl+6K2177JalpOUiJArk4iZ9I2OXKIDKu246TXe5IJKlIgJ7YRWtc/QdG7G2FROQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROJcXeR1IvyHQurkKLZFYzGJGIi/SpX9BO4CWeidnJFnIs1PrFu8zVty96gu?=
 =?us-ascii?Q?L2bLeJlDRucNXBur2fyHyV+tCAjsCAZMWG+HmnmvEcNAhcHBXlBJESh87iJT?=
 =?us-ascii?Q?ZsnNMp0Ietk3lOLN3akPCiSd6DlH4LsP/jt6GMc07k2M88Unh0MFMOdGZ2IS?=
 =?us-ascii?Q?NbsNAMKfOZpyAJ7BuH80Ql7zTzPl6pjWX6M1iAbtFwb2SLbq1o8yKVzLxeOJ?=
 =?us-ascii?Q?3IGPz2N+GJYYoQS4PCKC5w/Ai//MP0KBWFpNlTyJ9lUnPB2PVgVqdP2trKBH?=
 =?us-ascii?Q?qK5MwvwWW8g9A/VadgOprl3p/EqGF0FwW/Y87VEoVHUPxqvXBSbCxv8Yf+CN?=
 =?us-ascii?Q?eWbvRjhjWjQJLIeQDOCAJ2xB+KzaZxUsxgdk2MUYkBnxRw4L8RcxE8IWSUtA?=
 =?us-ascii?Q?2NxAKuZyavYQLb+lfrSILl5Q6slZryQ6b8jMYTYEy3cC/Uv+S8HIvmhH3UBz?=
 =?us-ascii?Q?9RoUFyLm6Gk4mv14PKIQR3xfZrYS46c7nhC4w9K4RhbGwB+rIjq+uVGQSXhD?=
 =?us-ascii?Q?w1r4pPqrm18ytr7XSGCu/dKOHddSK8/knWrepcxfE/NdE8wwc7011Nb4yVss?=
 =?us-ascii?Q?cXYHA5ZmAvjUcS6lVez8R6oglj4ZwBNoYksSlxCQr8EbpRAjFTrA525goM/s?=
 =?us-ascii?Q?xueswUsTY4Zkce0veBZQVNlsTCq14rIfgVsUwJoN0i8QkoVxIIrgfZAi6V1c?=
 =?us-ascii?Q?xB3PYcZTcISbMx2jHbtkM71DFJINMs3UjAq83+m/lrJSMh3xESF4ZffKbucH?=
 =?us-ascii?Q?MW8eM0KIQilbPp6fob+u+sdNE5eg++ma7xxveVLMF/nonPzZDwAtqA5fxe29?=
 =?us-ascii?Q?a4nyOgFKq8o9f+amkHztvg4s9470/dpMp2pz1EtBmRO+hqq8MK4TFHExmxoC?=
 =?us-ascii?Q?RLKL1KSf8ygUzIgpUo40i1OD0W7Nx8UQ/PziU9gCaxKNR0f68crcxSbx9COt?=
 =?us-ascii?Q?K/wOl5CG07jIoIoWJqOURWOaFQR6j9v13QLFEGCSGhMZSO4IO4HCcxTa/Jvd?=
 =?us-ascii?Q?MPmN/wTm4yEnhtscfVwW5BJiGY4Ue8itX7zQSRuxQxiG4RKxZK7d9Bpm9qnP?=
 =?us-ascii?Q?G5IvLPNsxBLWBZmYguoWHE0h+WQKG0Ua3oc0E8zB9wSitQlhn/av16wAmzKt?=
 =?us-ascii?Q?ozXP1vGARGSwGwQRH6eRD4GW3lKgx0elU3fdcjW3GtP2qGqGh54Vvg6gPOOG?=
 =?us-ascii?Q?zwHdfUhuXtGSz+mdlXTLL13uxKvp6sL/MMgjQLckrZQdgslKhgXv6UcCOgfY?=
 =?us-ascii?Q?VKtxkAzrUxKIP/jrZndnuAgNcRP75WA4CC9Kl8TkibI/ELdZBP8dXP/X9Mat?=
 =?us-ascii?Q?KVdHh1KEIDYRUPv5CK/WOPAaexjhpRmwpVhzOOe0HoBZhVhuR9GvBNf2JKzf?=
 =?us-ascii?Q?3lugfX6X7kGbOxVbIr/Hob0jh/wBc0VPCQ+l9OqPiMJCo7h0OeT6UXWvoc1Z?=
 =?us-ascii?Q?hPq6Jod4mX3DYCc+CLpbs6Xf4Vu1Uj3VemeTrVwxBRNQpVmxg1pcLSQdXrbL?=
 =?us-ascii?Q?WkhHzYWJMTh5KiFVyXJck7RT/cWPxFnswLWkrHJFfFTPrhTIQ3ppOxQqmFHM?=
 =?us-ascii?Q?78LyKiuD3qDAg35nw4mhbSSAt7nx3pc4Bm7V7D8HA2CsAyyO31RWI00NGJ6N?=
 =?us-ascii?Q?g02FYJcBLU8q5rTcgUgEd16uJzRhksjFg3jRBdac791hNVQMQMue1izR5lFb?=
 =?us-ascii?Q?gep9w2Q/XWEKKyyEezNb6X3F0Xw/AwAHuS3gK4uw8TPLQb7/qB9lvKRrZH32?=
 =?us-ascii?Q?/0QPw3wG7TL2TaySp9GPJdKM1mI7aco=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52ea212-2d94-493d-4f28-08deac1cd142
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:41:30.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2D6wxp9bECn8Y2C/yl85Zw7zF9DfU0/JAX8nJKF9F/izHJUHedXcb+XXe5/IxsAFvcUlrsqvN+rC1GKEZB5lOgwaYaDGlvq7oI10a/3oPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0870
X-Rspamd-Queue-Id: 0EBA14E817F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285303-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.780];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add default disable split header flag in all the starfive
soc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index bd86a39b79f0..935c4fc4c29f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -147,7 +147,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->flags |= (STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP | STMMAC_FLAG_SPH_DISABLE);
 	plat_dat->dma_cfg->dche = true;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-- 
2.17.1


