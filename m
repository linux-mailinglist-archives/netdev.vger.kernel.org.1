Return-Path: <netdev+bounces-20444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B075F97F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B661C20A8C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962CDF42;
	Mon, 24 Jul 2023 14:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B5DF40
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:12:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A29E53;
	Mon, 24 Jul 2023 07:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsp0h9pYuluBHL32RMTDb2+CBsGrm7siFxzAkCzGe+nb/t/CfJ6LGkQICzKCArotEaa86b9bF2Xug9ncT9/4w7BznYy3kDUA+ET7R+eF6DSprvNnEewyRDJ1J/Gg81ZS3rN0ZdkuwRgwLfgmZZQOX+fKs+JGdDeg0i5h0bGQfemwm3Bya5vqLjai49RiD/7BwYfuP3RPPL/3NuAOpoNDRvGxr5fpInNf2uvLR1h5Rf3oW+CTNC1yFJi5jtQz1ljJzu8rizAwV5JBuSQSkaVQ2Sy5xaHuUhWK1qetF6UI7CN+7WZaeBJDlhepWONejh8vSdSnbqxt22qovb3qWY9Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzsk+mHGXhbZw7I/759xd9x+ML75II/ApusXCe27GC8=;
 b=gSX+l1Fj5+5AjQup/Vgij6IJFcZZe6if9eNSE8PTMzhX2RWEZWI4Jk+8M/4ZsdqC6rvpimkz86wbBONC3eum09UcOOwfOHNGGBb5RwlAGRME9fhgP4+KRvvGQM0xuP7aNrDVvtnWFuwz/FIrrpxMsw4vHPDLwnM1UuUNji1aHW5hcvEswVXJ5r4rDEGHQRFWpumh92/VkV1JgpEEyKccsedOCzEk4FbQ7+ehM+0+snRBLXBo2XRaQzuQWDlLNNH0kcU7LnTYDEoDruqv+nC3AnhGPtT1NPNZDLBJ6/7BwAaIhdxZk0K0pizTOvuoAht0a3RIbeFSYhZFNDuB2K4WCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzsk+mHGXhbZw7I/759xd9x+ML75II/ApusXCe27GC8=;
 b=VMfTiKZeMIEs+BQOEe9/nEX58VrNg4CnG/tDwMzSzbwgS5hKQh2R51ZmJWBFWKJXxjzo8z51n1wOWlMGuJgVQIf7KvAfNGZle1x5p0aTR+AfjWzYXrlRDidYZ66eriyu2k3gyOTYU8Gt1a7rDK5u73rK02nmW8IB7SI+/fz+CbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:47 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:47 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.tobuschat@nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 04/11] net: phy: nxp-c45-tja11xx: use get_features
Date: Mon, 24 Jul 2023 17:12:25 +0300
Message-Id: <20230724141232.233101-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e597ef0-1e81-4c4d-773a-08db8c500ed8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V4vk3SdPUCe833EPrDEX3XeHOehcrvHmBjxXwX06kTBYddkOsdUsrWaGWp+JOQVUedDuqgFxhDQC9OFHUFaDOXw8vvhVLFwh9G9L72n55Vhx3duQhGjti17n844dwLGwGn4JEVd29NDReuX9N0J7EPMtTOwXJeUFcnba6wDWIcf748fzVEDVpdcx1z0QmvaP5HCcOTBws1i5kG/fN4nCtKF9Iuf8uag4nIeMBJlkBL6YeOU0ahywgXSOP21gKIL8bR1xhbTOiFNEGyl9CMKFTxmxRNOeoV51w9S0AdA/vGtOsouJGK+6Cjz5khpUxFU32Wdgis+aZSQHKsfR2+Vmf8nmC8XcNAadAve666LdEvVk1VX07Rabb4gbXueRpNASr0bYQVmxp5pHZSuu/93U+DArmkTH/A/3HDLPYcmqZx7K1DSkRdQ+CUqV+xwvQoAuG3UiPN1X3Xx5mq0/lWgsnXxd8od9k5HUQnvU6VXTN5R4PqmMcAzLKUu8N3Q23aVv2u7niYvAVFLvtiu0/U7aO41Kn3P4+lnMtYx73ZNrLjemlstvXbq2bj6WPXb6Fs7yPA+P1PVq46a/GHyioPUaOc+8o5fyQ4vWvylyZtlfrIyHVkj+3t0enWehVnWoNwMy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8zJ/xG3rLzH2NYLEnxmHY8h51RG1EjhqaeHvixH1SKn3VbcJfFqMXrTzjyn?=
 =?us-ascii?Q?FeoPhOG5ppbUDasEVcF1EuBstNJAx+KYtYIYGEsuyHyvKiSPm5CBbFhIXzyz?=
 =?us-ascii?Q?PvVPo42HhkO9r1JbqTSzd0CHcLgjhi0svAYVw4k6oBVq7WCQ3vtU4KUyeIl0?=
 =?us-ascii?Q?FyMF0knSseqY75TrXmiycS63p6nZ1cxpSDmgrLihG/xMPthNRUWeJBrLlczp?=
 =?us-ascii?Q?0yUdfqBZWss1e/Rwl+GeCX0asj0XIq8m5f941onsymWSFScRcbCHnWA/pSsA?=
 =?us-ascii?Q?W2QiobjXfOdGEb8Zcj/wyylDUhaGpb1ZSQYSJ9+l+ycLYO0Rx2YFAv2/flW4?=
 =?us-ascii?Q?pgezdCOU/goNnhAcxcKSSY6/+FC8xtID1trURbJ/2yUNpglM2zTViTSYfBQe?=
 =?us-ascii?Q?5PozrLTUAPTUn3HnxFGihUUXk17t8DxwLxWL5G7p97UfFGjLlo4X/1LZMXhO?=
 =?us-ascii?Q?pCd/4qkpuUDooPE9TVaeYtHyN/UO+NOb8qIS4jMlwRgPkyu8Myl0F1ni/2po?=
 =?us-ascii?Q?5+LUB9e2H1DTzKDgo/5fwfrMKmTDnGNeZ59dLQD2yyLem79hzdO9vtrAgP/W?=
 =?us-ascii?Q?BDI3J1w7qpEPJd/fYE/4jY55ssWJd3AnQpNhiI+cAC4EGXoUp+sVW2qybYX0?=
 =?us-ascii?Q?u2JM65uPlVSHj3GJj/3xFKrTro2Lz3kpUbhDy1rDux1DDbMlIBNTumYgA9H6?=
 =?us-ascii?Q?6apr952bojNfeSW9CKq2WZFVjKM/lXGNSFQiHNIaZlOxij33lkhvbJaHnNIL?=
 =?us-ascii?Q?136S8AR5FS5mAWYgT6ooA2C1lUYP2yNTKBQPWBxr3x6nYFpUenscgN0L2uCI?=
 =?us-ascii?Q?naLVt2xyLdv5Ue3R7A88jPDkdnVEhECXS0xxtpuiCh+t2XWtNsjQJ3fL0mvs?=
 =?us-ascii?Q?brnbntsSU9XadsCztxMQ088wb5LUuEyZRmtb5koyunmaTy7uhc7O3Z0Cj9LT?=
 =?us-ascii?Q?zjel9fdqirvmVn6ziiNnxTFS6fPY7kL4Xnc05egwUFzbSDUFKkfDMuob9Aoi?=
 =?us-ascii?Q?7QE5JciKZMAABQBD9lWQNhJvmHCADVzNlneAP755yP6giQJdSjQxBuVYMfod?=
 =?us-ascii?Q?sittPo7S6F3m47o5rkfjujIcBYgeCDjq22OynUPWUhh7TXjcMvsMsbyG2Ahg?=
 =?us-ascii?Q?NFzpt4zLJqtjVNdugc/Xhv2rXCPF8SftECH5447dfHIAwpZNKeK14Qi/mKOc?=
 =?us-ascii?Q?XHeVWhkZJNjLxbaHppI/E8sQOaaltVqIosq5hnIkc+81q75KSYSDLwMXwhGz?=
 =?us-ascii?Q?XpA2el+b2LwApIw646xF7kJAH4YCd3N7E1KXKhU3JxCCPM5ema55Ktn4HZUg?=
 =?us-ascii?Q?3oozzruOs9EcFM7HDYWjSQiAQxr6IBTrwckkjdv7PYkggJbrbkUhe6z/pfsx?=
 =?us-ascii?Q?Shh4wJE+35S/28SrkL/0OVfDAj4sqo5jsmf1CIxHj4fg8QWqBb687qpgCXKO?=
 =?us-ascii?Q?Ui+NLEMAwLFfgf3ap7nKrFUuESlIU1C0koi6JBm+Ty1C5imrlaFWTerNCEwu?=
 =?us-ascii?Q?tpr7gxAI1gZnN3HuambgkaWGCE39HXwJDrIne7xJWYsXw2oWYoDKDjoSkdPr?=
 =?us-ascii?Q?8vALg5gT8UbOfrOGB1k2IjwSZNXtcPoYvwCUVdO77yabPbSQVWBLhJU51fhq?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e597ef0-1e81-4c4d-773a-08db8c500ed8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:47.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBPZEnj8YV4uOVF6ZBIxHNWZ/oNFWtptc5cQi8KUqQGOdZ+PCpJNK5TZ+vxol05+D2WRoNo6ucFqBwKcLBuC+Nt7UXkQHjNtNTxIhn8fEm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PHY_BASIC_T1_FEATURES are not the right features supported by TJA1103
anymore.
For example ethtool reports:
	[root@alarm ~]# ethtool end0
	Settings for end0:
	        Supported ports: [ TP ]
	        Supported link modes:   100baseT1/Full
	                                10baseT1L/Full

10baseT1L/Full is not supported by TJA1103 and supported ports list is
not completed. The PHY also have a MII port.

genphy_c45_pma_read_abilities implementation can detect the PHY features
and they look like this.
[root@alarm ~]# ethtool end0
Settings for end0:
        Supported ports: [ TP    MII ]
        Supported link modes:   100baseT1/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced master
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes
        SQI: 7/7

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 162886cce08b..11fb5a4f47fb 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1353,6 +1353,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	return nxp_c45_start_op(phydev);
 }
 
+static int nxp_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1507,7 +1515,7 @@ static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
-		.features		= PHY_BASIC_T1_FEATURES,
+		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-- 
2.34.1


