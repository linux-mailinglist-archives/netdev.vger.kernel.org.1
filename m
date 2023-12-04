Return-Path: <netdev+bounces-53547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F223F803A6B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E231B20A88
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44B2E626;
	Mon,  4 Dec 2023 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSajtSau"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589FFF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJJguXoWbHO99gkprBO1OMTCsH+5f9WWRlJ0SBZQpuiNKNyK6bDaWFpNdUiiOkwWgd3GqCR5uFQEMJncVGLPJZIAIlpfXwkTr+iJG7e+Rh5Rnm4VR4QY/J2J68IWS0STV+afMwxLZmsYr1Sfu2ARUBWLXeCt/8QBw8Tkmmi2vXXyFuEXgtGLKSeWkwv3HxNlHnw8BMR9OkUUBKIb3ZZVyy1nDda8nmvKr/IwBt4PEPn/0h1zAwMWqXtOqmBT/02cxlwb6EM4PesjE2jAaNe882UTtr/jPCaIgFrkGc/4aDfY2zJcB4KGHzOd0cV5o93BZkqvF7GIc9blL2kz18vN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPSzyBb7IY4KN1FJSY514GEdmSffSJ/0pCmlKMg/BXg=;
 b=FPC5MgRkRATxPtCf/gv3exU/VF44yrCc9bQrKeGpGDto394ooE0uylTG5oeGk2hTtU1o63g5JyhIXFoMm3zmjkaYnCFhnvqayI91mB/SM1r+GWqM3ekwnORumMBxYz4anmaZKYZUdbmEYNQkWIEhqhZdA1bh6pIabBvH/EJYSa0wh/J8DYGWJcPih6043Pos/93mg+1qaf19mGFjyRNeSHcL8P+4kPqELJ9OAa5yrnc6bS+0VMHQjSr1cHHsfxuSFLVZlBa7NfasyywXu8IhkBarwh5It5V8vKjTDGZLHuGXVpnrb496qnyZ/npqIz/c6FrC6D0xtdgHEbN4/yOb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPSzyBb7IY4KN1FJSY514GEdmSffSJ/0pCmlKMg/BXg=;
 b=CSajtSauwKXy4oD7mJEBvSNJgGluvOxZ7ecFMqn1i3HmbqJYi5uObrI2fKiyKaXvJwn1bSPh6lGBB6vDQiyOgOIxwo7HaMyiPdgIO5tqiM9gY8eK7S+mHpH6YzqrsuYxCTtmJBaIQTy0t0SQ3aJj9jRSEdKooZdNBzX/t9LAamw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:02 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:00 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/8] dpaa2-switch: print an error when the vlan is already configured
Date: Mon,  4 Dec 2023 18:35:23 +0200
Message-Id: <20231204163528.1797565-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: ea628f32-2c73-4ea8-8611-08dbf4e71979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	212TiGSzyt8TT1Q/aTRLbEUAxOJk8kc7VQ+9f4TiWO9KdJdvlQ5XFftedQiTxwgGMAS+DQ0d0hJyox8S4wUpo6q47orEvQ0VVqZaj8r09XsdJJXNpGoLpUXrI1SsOJa/KO/0I5/8Ba2zN7TXHWnU9KJrrfQwYgPdhetqVUlyUFRRVtXR+dlpge671zrMCFDq9UxSVPm/pr+slkIOS9X9ZB7eL42sLU7kTGfCBeh9eZ/9+XgDfKtOMZq/VQRKo+KPbOZHkQGi97UE1fLCuB49AOps9wakjfWRw3SGSqW8TyniCPmlOltoiS7zJPnxQlEKYAACvm99Q9viNAYhCgh8lyvZJUzivhiRANHqvbzvJKvXOYmNno0sIWWZyL0lebtmcCjirYx+FPK5WNVsjkQ+W8tmvL+Q8Myz5Set8RSbe4izhAvly8LLAgF7pEkqYpJTtOHJEx0q0rtMGFRQGuCssoFwUI1dc594KdwZCqWW1ipsSrxhu4n23bX5SLBctVqPxLvUYTCFX5PgvtOM+OfRrRmLpCqYibGPpO1+RqIPa3AyblkRPo8fzQdeVPj96S7+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4BOhpyL0Ys4NTWeAW+RMzGY9SNmfAw+/WGYaNIi4cQA2QQz1Sg/a8K1KFpo3?=
 =?us-ascii?Q?t9+ZqimULWtrIiWaLnlYZlbmG+x5dh4yEV8rq7y7cNzYIe6aiVqq7N8j0y1y?=
 =?us-ascii?Q?JWFE/DvhQKQhacU9XWEfn3gvS+2XXrAZIP3hRmw4Y11h3U0ztQhfOmMhWaZT?=
 =?us-ascii?Q?E7t0RHnPKsGIaNxqsXYZIA1SfJi3ZLJJddsK1CMFFBPOXDA1SqHcaF3TUyER?=
 =?us-ascii?Q?GJDifnA6AFxgcx8kiJfnBF/l7JiTTPviLci/j05jKCDPCxbnVlMBoU35wsSv?=
 =?us-ascii?Q?773Jejp5r+0vAVSY8O7rndfHGdVRMFX1OE2p2WzC5DcHKnEDuMx97x62ch0L?=
 =?us-ascii?Q?FtLlYvEGX90UBeRNTO5Xt11b99ShG2oDdoEcl2MrXU9gq373undGuSIYWOxG?=
 =?us-ascii?Q?Xk79yu2UoCWpTSDAyT227YpZqYiFxpQAzD0/bUidWPxgntaIHGnoPLFdOeGh?=
 =?us-ascii?Q?RvPlSZxDY3GnN6+0R7ka/t8Zhrhf/68e6wuKLA1b3HWP1WrWIfRMUxcd+RfV?=
 =?us-ascii?Q?zC3652fTAUaq4CC4juqU/0mQjdkMvdkEUS5x5Ht2atTcmKox6qfUoUmmna9G?=
 =?us-ascii?Q?sLH3Xl1YojvUXtM4OukqKC2b7gQc8XoEowAK5d2agHI0cUCqVtR5xh5p9Nbr?=
 =?us-ascii?Q?gnUkjcZV8r5/QA2u2G2AAqUpDfoapIrdtJzHY7rAOHmf0fRGOCDgXjIEui9O?=
 =?us-ascii?Q?mhyEIZ0wg5OYDf94UMnzlmJDgA2AaPwy1ixrxkNMDvak+hc+Ds49n7CeBII7?=
 =?us-ascii?Q?xxtDSRsbAvI9d5+dTWcn5F/8n4j71KDlexWgXB9VeQEza81D3BDBmg0BE9cH?=
 =?us-ascii?Q?Tbu9wYCzrCU3lSLaxeOb53pVWhjNBjkkI/fXkzZmmGjyZFrkl+A6BznnyenV?=
 =?us-ascii?Q?zqG5rO5Q+90HBf7EfBmsaDp5otKuK4S1WQT/3T/7wLcwfnXGXfbo3rZKhhWr?=
 =?us-ascii?Q?rA/jCiuBjJVJO78PptH1lyvtvYKLEzbmbERGoTzVdCijxHRQmSCpfmCps6Wu?=
 =?us-ascii?Q?4aKFJLH6kE2r7tieV0Fl9BDWu6eR/hZ1aKW2je72in2PECe0laVnZ4gZ6rbu?=
 =?us-ascii?Q?bOhP1j6dk/NkfTAcWbKpaI5iCgNq6JWCwmdirzeaalZDdWJUc6YKATRoJZhP?=
 =?us-ascii?Q?3vybDbNg8sdKKCpNQ35XHijI+w+saZgN7KzLfM/F/zTA5i1YaE3TPf/rmeSL?=
 =?us-ascii?Q?unmlRDMpRNy5JsztC2rKnPVc0d41NijqPwWPSXeoy/4b70vuSRSQbI1Utf/F?=
 =?us-ascii?Q?jHK8WjD2Zsy7p9HHTtHqgjmxdDwyKQ7phwLjfBv4tV8q9rcQi6zQf45PkttI?=
 =?us-ascii?Q?X1zHo7tXQv5OwyUKhyHhDJioY6qMeLCrE2BgUItXitYdIkv8Q058lvsXfXew?=
 =?us-ascii?Q?kdbB4o5SEHpLC7/2XlkBTwczjPuEduLuv4fkQZabmadYBF6Yl7pcTGGUtHU7?=
 =?us-ascii?Q?TzgGgZNwlM2rJpoF6i7E1net1VVgzoawVUe37DzWPW2PqlCSMl0aucoxpPAC?=
 =?us-ascii?Q?HNCm3Z9WLpgKuRFcasXMEqit8kSAL3+AFK9NDWxQF8+ZUgAiIOVGnp+MxPhi?=
 =?us-ascii?Q?cmM8/3Uabjz2peVO6PsS4Bgbcc4LeN75rTu8jIoS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea628f32-2c73-4ea8-8611-08dbf4e71979
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:00.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LrJuwb4wxFwgKYuwwqkIKXj8mtL13Dbeac2FWbtHoq3a7LybgilEf2n54bTzvgPRN6t7S4u9/IMZoNP4feqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

Print a netdev error when we hit a case in which a specific VLAN is
already configured on the port.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 5b0ab06b40a7..654dd10df307 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -289,7 +289,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 	int err;
 
 	if (port_priv->vlans[vid]) {
-		netdev_warn(netdev, "VLAN %d already configured\n", vid);
+		netdev_err(netdev, "VLAN %d already configured\n", vid);
 		return -EEXIST;
 	}
 
@@ -1774,8 +1774,10 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 	/* Make sure that the VLAN is not already configured
 	 * on the switch port
 	 */
-	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER)
+	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER) {
+		netdev_err(netdev, "VLAN %d already configured\n", vlan->vid);
 		return -EEXIST;
+	}
 
 	/* Check if there is space for a new VLAN */
 	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
-- 
2.25.1


