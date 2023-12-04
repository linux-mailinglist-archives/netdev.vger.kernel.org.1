Return-Path: <netdev+bounces-53550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F394803A6F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D981C20B19
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B032E825;
	Mon,  4 Dec 2023 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmsKDJRk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099EAC
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFleXATEdiXfLXlPj9B/qYxrDkAx6zi2swZN3CkG1Xp39YrSh/E3NhxipAwlQhnSGjQxEjJt91TOKc+nIIX4sXWtK/7PhH8eIODCgA9HxitwoeI2JC+zVzfnqCGW0Pdk7C9AP+AeAtFp/lxsqGQrllwCTijeBTS7lxILdm9J3nHtgiIGVbbgb+2w7bRYyf6cRWdHD8C+lHL0uvlF/WQWEf9cDfI48/yAIKcybbSQrFmjlmHrxdpw5XO4KIzjmS9om/WgKCZ4UXNNhwePonedxD4j39uPQJA1dfHPHOMv+L9OjgKubYq8MVkMFTHpMN+ePeUWSRoxkf7SK01nxPzg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcH5EAKh5BjgC+Tt1rK3hkC5bPjXvBqe9aoF4ipsv0Y=;
 b=RKDIXOSPAk2gJ48duudilDvkyhXAw+gcTPTm0TQAuo42Oc3OEqdRBH+BnXWdYU5s16tFLGmMlbSAYANG6fOFxKdIczNoHiCO1BNsaPByqZUNegv+XKc1MTiIBlH4de1d5RRRNaEPenTjGgHC6IdtuYAiVAS4sd9WVxk9+O4wXO/Um0MUqjB7wRxoRyQbqMIxZZ38JJfENxPwswICClOTA19K1FUKK6mPPf3q5hBwdOAucdg+DK5ioP9ODXS+oCgak57G0niwhI0/r1l0ybKMHLK88+NZwoX9iT1B4anwlq+RcS4OmhDsnr+wcUVdV56H6EemGNfL8h+DhiAywY6yUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcH5EAKh5BjgC+Tt1rK3hkC5bPjXvBqe9aoF4ipsv0Y=;
 b=HmsKDJRkaX4q4satx9WKjcKkGb3UVu/UN4F1YId47rmKw1F7oDL406ViI/bci/hueqLkvujfBRSK51eYGir1ifRStHaOxXyl/stP6gN4mhpsyRHSUb3Vyo9/AOjg+XBtURhR/H2Vjw4hdF3Oh9MQAwaOFXXfLA1RjaJkKOAt1jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:06 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:06 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 6/8] dpaa2-switch: reorganize the [pre]changeupper events
Date: Mon,  4 Dec 2023 18:35:26 +0200
Message-Id: <20231204163528.1797565-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac0a760-e387-415b-3842-08dbf4e71cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KcipSOOTkmJjU/+cEfowSmCm6WERotvNlVQdCe0vskFtkTciaSJRew6hyBDbAWprtxQw9G9eS/A+y7J1KBabXofzpKbfDC/loncyDDW/o34dKT70q/uVNW0You1qCYZrHd5UED6uFkmNGCtwKKVqBy1TDRsBad2taDAAujv4Gdwekxh8ANkE3VQoL/ZQZo2KPBIDmwTnE1/UE4kYwiiPrZikJ6k2Dw161W81sL/YOWsnmwTJ5dcPx5RB19jotBmy6RdxfH5hV6XN4NYZn+9DYk6HwkxHBfuj9UW5RgE2SR1ySD158K1RZgqGB68Efee0HhJc9EWaPPGHDv0Y5UzGWv0Q0EjnV1UwmoanDIW97EVfdc2TOG7CKso1CQy9nOMC1HyeaqbS/F30DTVJKlWITxUNVJiaI4AgVBsLFkuJx2VVCXkjBwH9ggzLMQ5uWQfSWgvKYAyEEmZ5FkDDabTy9CvARl4jHHDEWQnrYFz5U4GMFBFuEkCK4vgXSZlE2sU2QjvaKDosFBvLrs+PwQNqMaPB5nEyZM0t/mTAqaLFD5EHvhRVVCR8I5ChfXzMK4Ka
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTLDFRlFEg2hmNim8sGaroM59he3wWHeJmCz+lhr/hAaEQnh0HIOMunltUtg?=
 =?us-ascii?Q?RL6H/wY+/VvrINU1ee44Q9n2iFhMLXQRV3CaHq4obE4E2wSGimnaYIwHLjLP?=
 =?us-ascii?Q?Fv8U0NceVvSWDKZAVDYqTCCHS4JE/1bjtGseI4kn9/A2drqcE5DeAcySxANX?=
 =?us-ascii?Q?AnHM44k6oRmhUJqI8v0Zi+0g4LZ4amSx6DnBO1qLSuDjw1vyLz7zpHyEZbwW?=
 =?us-ascii?Q?//NZtg6v3hXv6jxFiHz1BU6dAjnVIhDW1kT/wGMJo+au/HDi/+2Peji0Mre5?=
 =?us-ascii?Q?SkBGOsJqIYxM8Sk6WE/J3xdI5PflYeX1vJ8bmPLFC1mBdsMEHrk4quskJbGA?=
 =?us-ascii?Q?oHAsGg93dlCsUonfTGToYfjw/u7zdUM8numwzIOMGGdwytH4LNZSdZiPFKvH?=
 =?us-ascii?Q?JMthqnhIQCLCbzDGwLm54pfvJ/gH3kPnLqCWMlLnTtt6OwIZ9SGs5K+e7ORx?=
 =?us-ascii?Q?G1UOBgOgtHimu17j6zTDKNz1GdMKLiRtytoocYT53vzfG6iiT1ooMYb6LNWK?=
 =?us-ascii?Q?wTH0wzCP8djuLR+32kF7P8jnAHLNXH9yhzU5zhHlcSj+N/+Fn8XRYr83FGcD?=
 =?us-ascii?Q?AOrqGWQXh5FiVNk1NlpzS4fpNkNF8V45nJ4lxlk1HgSF/SOSHCJEnS/+tGJZ?=
 =?us-ascii?Q?NmeFZxbLw3x5bka8t+gqhptOSVttb15mcPSr9SsLEVCXYwlk25LZzIG8MwfA?=
 =?us-ascii?Q?FDzJPl7DpbaJ5MQXQlkgFN/op/M4mqsSRVw7CPh4rKWSDoLZ4zTXUaWJ/6FI?=
 =?us-ascii?Q?gVpCFsczXZogDGYCWEleolYpnqGPl6nBdeAiyXFC1r+4+Z4TFeNwCiB1eJ36?=
 =?us-ascii?Q?qnkZMqo4/HM2fee+IuCX0FlDlVLHwFBvLVsmGXyz2H5AeeI0GlS26lgHDm0e?=
 =?us-ascii?Q?k7+JXWv1hDthkoTRnN5M+2xgFWhxHsbRsf1adIqycqhIOQIchX+nLquVgSY+?=
 =?us-ascii?Q?kro7L0xXxLON6rOhEB7QuXGkHFkKXiPHcECi4tqIQIXPwBohfd0uD7GF+Jrh?=
 =?us-ascii?Q?8m6JgUZs451qDHV1C223inUuXYkAVMKA07dKr8YkLtOaIogz84mHp/eiRt85?=
 =?us-ascii?Q?P6vTwPlVTC2cKuXMKe/mRI3JYHqM9NjEbwVGNVtEDiDijrd0b3e1PJgaNKR/?=
 =?us-ascii?Q?nfdwQUQlPPGLpNbxnOVHZDCQUNEZClliMzs0sM1JdXMTXs/ExNjgj9pyGgJl?=
 =?us-ascii?Q?HX/RNuH/yqQz6X9F+RDEiU/tzkyS4JFr0LdVTb7X3z7s48y5ItaQw2SjMPG4?=
 =?us-ascii?Q?lCQuxEpchxOwbbsHpapbg0ojcMg2JvsZPXqOkpKtJ5plGgT+F4vbhdvv+cMa?=
 =?us-ascii?Q?4ZMUxB8wnSIhTctT6atTVDitM7QBdkm+wHyQvBwbNac5IFn6Uoxl+AnI3zhs?=
 =?us-ascii?Q?14TaHZlqZaOJuUUDdDVhLQgnEu65dSkXbUAalrAJSIXNdZ7Aw5YyPd1cATdk?=
 =?us-ascii?Q?TjZkZCoqCVGO3ZT6r9fn9wPmGFeV7dY9z7cS9GLlq88lrE4mHuDvhBWudINd?=
 =?us-ascii?Q?yX6HWUVTcqCUauNXk5CXgRrbMm5nzytqu2G3mSxXCqSeAFDcpP7bB0y8Bgco?=
 =?us-ascii?Q?chbz0udNdq7shXfbNNS7VEBpd85A0i8g9pzqUljJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac0a760-e387-415b-3842-08dbf4e71cd6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:06.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /teOqqEI4mVny+2AX/yWmi2MvfzSHswQhgDFzE9ceNIa1w+jhNGrY+UUoia+sOrWisz8pcZEi0A/Gy+pG0yL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

Create separate functions, dpaa2_switch_port_prechangeupper and
dpaa2_switch_port_changeupper, to be called directly when a DPSW port
changes its upper device.

This way we are not open-coding everything in the main event callback
and we can easily extent when necessary.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 76 +++++++++++++------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d9906573f71f..58c0baee2d61 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2180,51 +2180,79 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	return 0;
 }
 
-static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
-					     unsigned long event, void *ptr)
+static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
+					    struct netdev_notifier_changeupper_info *info)
 {
-	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
 	int err = 0;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
+		return 0;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
-
-	switch (event) {
-	case NETDEV_PRECHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (!netif_is_bridge_master(upper_dev))
-			break;
-
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
 		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
 								upper_dev,
 								extack);
 		if (err)
-			goto out;
+			return err;
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_port_changeupper(struct net_device *netdev,
+					 struct netdev_notifier_changeupper_info *info)
+{
+	struct netlink_ext_ack *extack;
+	struct net_device *upper_dev;
+	int err = 0;
+
+	if (!dpaa2_switch_port_dev_check(netdev))
+		return 0;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bridge_join(netdev,
+							     upper_dev,
+							     extack);
+		else
+			return dpaa2_switch_port_bridge_leave(netdev);
+	}
+
+	return err;
+}
+
+static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	int err = 0;
+
+	switch (event) {
+	case NETDEV_PRECHANGEUPPER:
+		err = dpaa2_switch_port_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
 
 		break;
 	case NETDEV_CHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (netif_is_bridge_master(upper_dev)) {
-			if (info->linking)
-				err = dpaa2_switch_port_bridge_join(netdev,
-								    upper_dev,
-								    extack);
-			else
-				err = dpaa2_switch_port_bridge_leave(netdev);
-		}
+		err = dpaa2_switch_port_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	}
 
-out:
-	return notifier_from_errno(err);
+	return NOTIFY_DONE;
 }
 
 struct ethsw_switchdev_event_work {
-- 
2.25.1


