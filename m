Return-Path: <netdev+bounces-290745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJDxMlIiEGqsUAYAu9opvQ
	(envelope-from <netdev+bounces-290745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1041F5B1381
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54A0D301D640
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A53C9EC3;
	Fri, 22 May 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4cqg5t8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC03C9440;
	Fri, 22 May 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441769; cv=fail; b=R2nmbKXzrIArq7TMe38YhcdLKzy++aZJ+qmaUmnE15r+0pd6bQWwONNutsQ7HX3+o/b4ESGaWxf8sMhDfsjArhajG1BC7fGfyLevZ2BGmNaTlkKVeP4PVRHvgavrk2nMGEJD/l7dMDMQcnCM6gVrPDxsb7nEZa+ITeJ5+dhxVXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441769; c=relaxed/simple;
	bh=si3DiiFetDX3gsNsNn00udYes6pNbvr2ZrgyMLnQPHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2l37XDZ8nqRTH/mkXYPZUSn5kKPZHysX6fi8/qwdzx5spOs1Wi/6NneFf4kHkixTbcVakUDw6xPVSg9saItX7Gu8/PO8JrYTfFN29B8zBrFy9F/T/Sa+m7lkSghqsAswCHkNKi+2Jc9I8QWc09vSje9u34hx7E3cuMgFENBB+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O4cqg5t8; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNoa1Z+hLIi055IP8BhTaOuXqpJOMa1gKjUbHChshX2EsLSAM0toCiMXl2JPtjtzb+Yq7U1YVOq7d7guA2EROorfZDUC6IEQ1cQGjS4CE/MDgLEWCs8SysenspBD4ptpKppE3zZ1UOu7zrAfPOnpxEIrK+5otbu17/wMoOxtXT8R7RhLy7NbIWWCobcz+XgR1nq/hFXHr1Xn71Wunc6O4wqr1J2DDucaqAfhVI2jVfiEGkRjFfrddH9bdiZ3EEVKI94/wOUCs4FcdBVkMq3x2UuCMhItg62J0kLTUcj/xMI97NnW1fQlkH7Ar2X36CTyEEno+WXtjDziyK1Vxtyl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+ViJH1zKOUQ4j31gyJe/bGbwV1iuODCAGNzR0+2lY0=;
 b=S9iNm0Xm1Wt8XFuLFMkzU3KPlPxArjkkOAWVhrxHyHtNMelqMeGvO7DaOeY2+0Z92AQVaS996lPgf7Xszee/dfgxkLQwu6HBDdNkWOmDszoPr67Nq5/R51n3Tfywfr5yQ7FTLfRgwHhEuB3wqLtZCfU9b9J9blKsS2mNsBi7Uw6k3JjEAjLcsfTCjaLoh82nxxdu/Sa3SRvO5e/twcLtsm8n8WhnBYd5fRslt4smLNIvi2N429oPJ3TapHMib2fJy+PKUqBA0k0xTgNm3ZswLpPKokYq40KopGd8avLqYbYI+yAI+1mJzPHeKAashC5qddkr9C0PZfK7eb57zcAnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ViJH1zKOUQ4j31gyJe/bGbwV1iuODCAGNzR0+2lY0=;
 b=O4cqg5t89msBQfW1fleAFQS90fu4JeEHdkoyIoTQNgm0gsZleYC1M+RjCf2CcFq0eBJic42NJj7AR/GW1YgOpUNT359H/o5uF0pEr3I65n+/jF9lxAHqjkrrCh3hEN3O7tOdCWeB6+8odZtyG44NIdC+0D5e76zsxoNZzzmeILFB0gDAE1frwU44BRDTMtVQp3h+XvdJuLJvjvst2Ur9ibomh59B2XYy5qedoY5pEU05ZIbTFd4wFIOdFoKw5s27aV4yaA9ZOHEm1bDnRBswTzXalh4/H4GyOdG3obXUy8HpiEum18y7Wjv76VOmZsjrfvdDps2uNVljR0QZiPb1XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:45 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:45 +0000
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
Subject: [PATCH v2 net-next 11/12] net: enetc: use MADDR_TYPE for MAC filter array size
Date: Fri, 22 May 2026 17:24:37 +0800
Message-Id: <20260522092438.1264020-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b2a992a-f5e4-4cef-72c3-08deb7e3aeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	11Vsr8XEnLacMeSeQ7huMQzcfw5IHGLo0q2qPbk4DjEdURI69OEEh3GEGCOQfCu+OjtCVzDzZBHyCFKKA1F9JuPR0VgXd29P0r3eWgOtLJjJFRA8ggIiWXS3dH73BOwWDuVMzovNxefMmwmLu14f6jt6YB++G02KMzLDiwf9+TvwqDmfXygbGDn0K3E1dNeM1IDDFvRlz38PPlb+xcXN/7W6POGKDZNYriBXI9VQ/LTAYFe1vAN+zejkAJZCVZQJvBr7zlu2iUP43BriQOVJrcmvGyMbxAIfE7mcOsJOt6/7X4w3vXvMI2zGeh6uo3Ufy8hhy/dT+ejfL/VSiVbgP4g3d07Gf+U+wfBddVhigyfQiO1OjNCXVI6618n44UXs/YjP0YnsprpUJKq/zhaq9DWEEkegFaljdhq6q8Hrb01b/BZ1xrNbkFiC8BBWgcWnBILBjrg0fkwLqzT7HK7OuW1NPy6I5FiAwnNJoCs2RjdTPv9xQPb/Hrh7MdIaxmvFPQxrKinpG94wjm9RUDmcpwRwqmkYhIQ6TAGeeGB6jjQh0ywOmMfgASGclJbhFjZaqIIxDJFTNm1HX44VD9JNPxw/+VdrsAX60lSPbjW4l9PwLvRjGmWDPnncaT6ciMs8qXxavz28MPqrmwqpIr1pMaQkwYnVteUXz56gmzWFUmuyrs1z7QHDS25vsTDgi0Pq0TSIpGO5P6agv2oKNWdJ1G2YtR89b17LLY3hCxaPY5eSSou5LeAzNleK6AJSMtaw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S5+WJbIgXkTkfMYwefo7qOuE460yGf3D7g+P+QUcjgZc6HcPyroKY0WMbgv4?=
 =?us-ascii?Q?XTxjuJrel3GZvnQRNhIXpKeuOVmK02p6/NqiDC37V+xdEPpZVeZIWgNdjnKE?=
 =?us-ascii?Q?65Rg+pcfbx2x5caZI9WJw4K9ZtmqwtBxj+o95l4HJUfWo9KLI+nE/0knw40r?=
 =?us-ascii?Q?Fn4As7AORJA4tTXfopMdyvP/7Zot0twywFc3iUbihauAwpltUHyHKTE4QMX/?=
 =?us-ascii?Q?HKC7aT5KpT6rotEllXj+yRQWXUcwqgAN98zRdROAsymnWhcBOHYfq7kfRQOs?=
 =?us-ascii?Q?v2ataaO2qeqbYtJ6aTprNQMUT8YzsckP6Ccr2yFupr/lB2iPHVI1nzxdow+u?=
 =?us-ascii?Q?/2PUNHqpxzwxYamemAzy/V23TWho5g0Aayw+h3sN4t4Jv+G1BvY9FLSYTUNd?=
 =?us-ascii?Q?AGwH3+xxVzshfqDXLOsUuMv4J8kK+d08iNKMY51EWjNlA6alNfkVol/jlbAZ?=
 =?us-ascii?Q?XfGdgNmsmNMlohracOaYkWe/cxhuKKQL1m/7YHA2IztzfMX4thT4kzNsnT/E?=
 =?us-ascii?Q?4RvTbPxrR6D5xZ+mD2fKm7o5wKYEcKU4fOrKqiPM9tgeWVP7tf1LJGU/BHc6?=
 =?us-ascii?Q?u+Y1CyDe6+sghAtP68q7sID987NdyOPCSqbOQYnXTelXY2OlgqmVtNSUuK+2?=
 =?us-ascii?Q?qp4KBM/g3r9/I9mutJdYkG8EQ5tpzOr5S8MZGx8ig9aqWLjzZjwBeroe/LD4?=
 =?us-ascii?Q?XZKRh/aV90V6PnhTOL9vQcyUjL9aNK+FcCRoHz8YLQ9OWAdyr8cqdiB9QdXG?=
 =?us-ascii?Q?0tshJw65VFMq4rnSxSSAn84UjU/K/sDdiv7OV7CBvDf0zs/ZB/w28nTme2aD?=
 =?us-ascii?Q?QT6xarPe2wtJ4Y+EgP6VRFzILozJ9xL0hNxWQ/B1natA3tUQdkAojS5R9hL/?=
 =?us-ascii?Q?27SmxqgEerVzJIGeXMO/QAupl7+jfcMHDu7nbRsAnqOooJUeyYxPLzS/lD3r?=
 =?us-ascii?Q?ejlCA1PlbAGjQFRLswmCF8dEEhBKgHXrzon35N0uJ0KBgwJFOHTzjJu0+CQE?=
 =?us-ascii?Q?81A585ZWx7yZpuUqSSl3WY/D+cOX3wwRuzVdfaIUzU/ffkJNE7i5gL6thSrK?=
 =?us-ascii?Q?c2Q7wr69hlHkCrpzZV/rYdsKpF9Hb1V1AtCDWswvTO4NCsN/2rXSPtXwfu7X?=
 =?us-ascii?Q?bN6W49LLPKlNdWdNAB6/FISUAr4pZVLqM0u3RDv3RpHbdIcVJLol6iMex667?=
 =?us-ascii?Q?XzuXZl8/i1YHWWi81s58+L+aHZbf17dd2Oti9+5fx0hvHI1fHNua/8L5HGJt?=
 =?us-ascii?Q?9htcdZQeJqr3kyUv28/tziQn7Ug3eBxpiZyyMb7v3y93bi/dYsuZeUr0cs5L?=
 =?us-ascii?Q?sfy4JZcJ5DvGURih2iY50WzOp6AmTNflIgDOjfs/eQ1kkLRfv9CmjB3di96v?=
 =?us-ascii?Q?P4WjZeEISc3wcdr+uTaIa8aOor1jZRy40pDb1uO6LND+zTxNQayuHig9XL5R?=
 =?us-ascii?Q?LyuzF3g63/+nzQJKzIJPXtu6xbUXSBj4e1T7GXm9T6GrkQVC7Onsy9xiIuAY?=
 =?us-ascii?Q?Cxoc3UAerDOrQKUn3+QjyHb8S4LouPwia5ancW8G3YBb/CJX/pQE7ain6YoU?=
 =?us-ascii?Q?ovJRkdG3VV3SXPYXH/qBUi7jQjeA7iqzz/hP4HlkaJ5AuwqX5/jqJuay271b?=
 =?us-ascii?Q?L2bAmFPE0huGWLJkbjQpjoS8C1/rKbistJEjNQRRFOo7Jy+PdudaOTZ/dcRn?=
 =?us-ascii?Q?3oaT2uiGlGAbe4cPRisV9gadlJe8kH4fiI73T2zNFqLHR60IF4N7SxYcArQ0?=
 =?us-ascii?Q?IkeY7OyWUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2a992a-f5e4-4cef-72c3-08deb7e3aeb4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:45.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzTXPk2BBppldB5dVl801BGebAPFuEJl4RY6MGUDm40QNApnxGYpJhrnsmQQ8b/BSbLx2PxCa2b4CUvZUg0X/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290745-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1041F5B1381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mac_filter array in struct enetc_pf is sized as
ENETC_MAX_NUM_MAC_FLT, defined as (ENETC_MAX_NUM_VFS + 1) * MADDR_TYPE.
This resulted in an array of 6 elements (for 2 VFs), but only the first
2 entries are actually used.

The PF driver maintains MAC filters for unicast (UC) and multicast (MC)
addresses, indexed by the enum enetc_mac_addr_type (UC=0, MC=1). The
code only iterates over MADDR_TYPE (2) entries and directly accesses
mac_filter[UC] and mac_filter[MC]. The extra space allocated for
(ENETC_MAX_NUM_VFS * MADDR_TYPE) entries is never used because VF MAC
filtering is not implemented yet.

Remove the ENETC_MAX_NUM_MAC_FLT macro and size the array as
MADDR_TYPE, reducing the allocation from 6 to 2 entries. This saves 48
bytes per PF and better reflects the actual usage.

This change has no functional impact. Future VF MAC filtering support
will move mac_filter into struct enetc_si, allowing each SI (PF or VF)
to maintain its own independent filter table.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 5b4094f8d5d4..64e2c738e8e7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -5,8 +5,6 @@
 #include <linux/phylink.h>
 
 #define ENETC_PF_NUM_RINGS	8
-#define ENETC_MAX_NUM_MAC_FLT	((ENETC_MAX_NUM_VFS + 1) * MADDR_TYPE)
-
 #define ENETC_VLAN_HT_SIZE	64
 
 enum enetc_vf_flags {
@@ -43,7 +41,7 @@ struct enetc_pf {
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
 
-	struct enetc_mac_filter mac_filter[ENETC_MAX_NUM_MAC_FLT];
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 
 	struct enetc_msg_swbd rxmsg[ENETC_MAX_NUM_VFS];
 	struct work_struct msg_task;
-- 
2.34.1


