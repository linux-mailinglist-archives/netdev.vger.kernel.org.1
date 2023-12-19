Return-Path: <netdev+bounces-58878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3F8186D8
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3ABB22E14
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1931641A;
	Tue, 19 Dec 2023 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wnqt1Jxs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2B18023
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMoYFPX6rnK31dbKBtBrHvJvyF/MYBH+qMRbO3Mnm6dMCKkKQncJHhVbEbzR0Z9GGj1ou4fyYCVmj0HbW8KrYWog+zQPBt3yY3W7ICOOAbhNDR9NPZzqktMmL/DwAUr0r+Uf5UE2aO2KJuNlf8sv/NCJVTiwBJmy4ki/qIeOnAXg87XG9VATAmwEAtpRYRII903q/UBR7II9T4Ew45UKZO/Ifpkg+UIJ7xSzpIeGvj13WDc0txYrvZEa/mJsOBw4MrgkcAoG3m9xk9r5Q/tmtVkBQwFdzjV5BS9dt59p8LqcPZoCTWBMqrvwM+GxW1ouKXzunmsHuJ0cXBV6Q3haVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YFwNfO/cl6DqDp7BBjQmDETEr7rX+MJiZ36U4wGM4A=;
 b=BlpIz9Rg9zXbwfDHB5jvxanfxLsdw7mnaD/UVcGkm5iFHEpabnBzZPl3jXIV0BdRCqIimtNeh0rqq3Xi3+2RfknMGS/slMsOlDxWPn+eWHWWxpYDf4Y/xvVKY7SJYBeyecKsCJoxvNit9DTD5K0LKk6A9FbTDDf+6Wq5vbBmWe22wyrVDPX+TeZlSFZT1/XeDkZXpwWyJs+R2+M4V3ul5WJB/AhH6tpuon8dPhyytn/1yGVqTxWsqpRbfj1H9Sz3sshjqwK/o0jI6YNX1TKWgUejLS6gwXODIFptLHu1X71r1FARpIPrMDgqULvk3HnYJqbIvuyhZAJxN1Gqwd1rVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YFwNfO/cl6DqDp7BBjQmDETEr7rX+MJiZ36U4wGM4A=;
 b=Wnqt1JxsbF5rOQUksxxyxrQPlNi+BX56anh0lhJCNERa9buoSwn67XBoJ1r2/MV8ySvGvMYILp6rTazgGvjCElUkrj5nyWx7E7+MrKI90A5NPI5XRGswgVWtMEP4yr4UK1RWqb2YpcEjmBACqL5ErLOqOZH2EAe1B2AnIic6d4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:08 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:08 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 7/8] dpaa2-switch: move a check to the prechangeupper stage
Date: Tue, 19 Dec 2023 13:59:32 +0200
Message-Id: <20231219115933.1480290-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::13) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ef4b9e-aac4-4ef2-b516-08dc008a0bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xyjOpwH3sXJBI5NRSnTieTM9EpRuQNn5Sqph1x3xsTtjn5kLheyQ6wqY5N4hvOCIcmfY7pc9s5WhBOVlPIszlg9z4A2pH+qIggbcCyV29QMOr4BqzA921XNPrMQVhoTqfcUJ+Y7W7aEeGi5brng+GwYRfzFo97ZzcepWmTaXFwlMxpVDgtED9v5Y06vlCJMkyJzxf8z7xDKTx0Hcj6zOhbBvgRMxvTxRGiXIuVfcyATDJhZH1lj7XtC2za0hSuvaeR6hqSGTvLTzyZmZhdB6zRGcw5tmNkseJFZRxnWSk+Qulfiu4Rmz2o0sGAOwMFvXb2Km62S+8ZMweFAif9Lq61ITRr4xPPhN2ON3nVa7AC5aWUsvoRi8X10K1Iy0jJNDPqtP/u9Fmuah/rvtDu+93fPQOyWze1l1rUBPg5GmF4eGJvNYS+FtUrQF1ol7D0UZFEawF5MrLQOiRJS3Fok/5c9qY98qMciOBAL19uJPm2DeEzISR8W2xTn6AKG3HFq/QAkXzJtjfqMpCBif6GX4JqTxZuWRQjNAI4NhOXllHTAKU6M0t28fChOHi2RPegs2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(54906003)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxYbc/QibF5SfDM7PgpFAR6hpTZKQOP7IHZebk6nJW24RVF8uNPEu2JgIbb6?=
 =?us-ascii?Q?D+uzFU+bT5UFvWp1cl8zLCFm2cWEENQ+2D9ntF5wSBuXsoyMGttNNUPK7zOI?=
 =?us-ascii?Q?barM6Md3YKD84ftbfCTxy3Dj/qcuPip5sYyN6nWbGFb7TuOZunM4R+m776i7?=
 =?us-ascii?Q?pY/K7M63GkX5UFw9x3s0iisXLgUO8Y1Qzs7KGXutGBjbRac4FAmFqPWDsrMi?=
 =?us-ascii?Q?SinYrkAs+L1XJDFGccikL+iyKXJpxHa2/mu7Uv40J6Z7H4ekjusphhytEauP?=
 =?us-ascii?Q?aMwVVaSioGK9furC3c0N7ZRdZaWN6M0MYPxo7fE77ukOmD2aMPIMCRVLw7Vj?=
 =?us-ascii?Q?KzY3Etx1Ml1kIxy/RRsUeHUP6EayvIvRK4zbTD8+ChtP41iyy1j1kPi1iPjN?=
 =?us-ascii?Q?CtSdUJb3IE/o40j/eEhhkdjS1pVv+kRScbanGiE+5QJdmEM0Dg9tv6KSEuDj?=
 =?us-ascii?Q?bbdgiWSfqJHfFD5rK3JhEYMAY+x7JhMgq8fcqVB1IYLQK8nPRPSaYml0y59Y?=
 =?us-ascii?Q?w8a1uykDvsDQmT3S1vHO7iTJt9nOXyt/+6avJ/YEG+d5JHUQh6VqyOEX4k0S?=
 =?us-ascii?Q?5yPFHZHwuts/zM/OCnocrpkL2YylWuZEo7gWNis3Q69b05YC3/DZWq0cDHpw?=
 =?us-ascii?Q?MFXVfDg2B1w/9owbarYjrtAr91jhmCRY2UPP0S85T30I7vsAtF+iqfS7zB1R?=
 =?us-ascii?Q?UwZGA1PR5JWFQcDL3ZkS6vznhwqFzpQoGAJmFygjz3oVUJrZcvoAXhSVNhMU?=
 =?us-ascii?Q?v5NfU/yiqtFiRbMmbpAfrnYsSfeM2Tm8Qpy1z3zco0zNMHV4oFzlM6n1rcB7?=
 =?us-ascii?Q?GBJ0XNuOVqEKWla8CtVG6lw3sCn7nUMW5q6wCLmclOKYQEBArPPpfsHwRtnT?=
 =?us-ascii?Q?X3Hm6zOeV3laHm4dL5KecCGOkzAT8ybHuRjvvhfVSXvQzvINivIP9HKyifKc?=
 =?us-ascii?Q?ANr4SKvu58JULv8z1FNwmHAEjSx7vqMZ+xplxtRcbos/fVvXCJPTLahqwbwj?=
 =?us-ascii?Q?vjMJm6FyNZpGFyPp93b3f7q+ARKF4aZXbyh8sY/3bmNZcWaM+cEAXHHNM9oL?=
 =?us-ascii?Q?dDKMqdA3+Le5yiQTkonnmTRHlsMZHRtnOZZLQP9jG0Fb6Z5seHSAJ50PFRMf?=
 =?us-ascii?Q?p2SEKV066EFvu84N3iTp/mUsH8/eDwASW2fw5u93RsXszxjqMUzLd9I/rP8c?=
 =?us-ascii?Q?BZuHT0zpil+Izh4In1g9I9hoQcjGn6hxodJkKqxUEiCabFRlOPuOFvNwKUTv?=
 =?us-ascii?Q?KY5EZbsnl8V6emHPez2wv61Bp0PRmi4399l/9l3XZecdVdkfP7sDJ/RRBH/I?=
 =?us-ascii?Q?0A7uGONR3xdA54cR/A2OjjoSkgAFwPIvxjt9mf+ORw7Yf+LLQEEhcCCu3rcs?=
 =?us-ascii?Q?A3/Iqrj+6OZdC4WtVhYIxT1KuCX28KUcy6e7SyiV1i0wsCCPvshf8yfBWsnU?=
 =?us-ascii?Q?6hw1FVR8dYyHZpIuq+yw62sFYYUHD8U+LCyhbuX7/HoDdacVCdGWzjehKp+W?=
 =?us-ascii?Q?O9e7gAwagn+IeNE/BRpDl5WYeFvVm40bPLgD+TqbouGhhR9xPf49tTgAkLMH?=
 =?us-ascii?Q?1zO/X9CdxhNTJNlPmhxcr+gqfeZVmIfFPshKI5IA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef4b9e-aac4-4ef2-b516-08dc008a0bff
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:08.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZQlxWfjeV2NzaF2L2N8v+XFqYEmNjt4XGb277J3yDbuMrer81nLShN/iwOysKw3fIMForgNEHEzCNmjz7xt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

Two different DPAA2 switch ports from two different DPSW instances
cannot be under the same bridge. Instead of checking for this
unsupported configuration in the CHANGEUPPER event, check it as early as
possible in the PRECHANGEUPPER one.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a9a76d640bc8..bccdaaaf5ea1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2005,24 +2005,9 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
 	bool learn_ena;
 	int err;
 
-	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
-
-		other_port_priv = netdev_priv(other_dev);
-		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Interface from a different DPSW is in the bridge already");
-			return -EINVAL;
-		}
-	}
-
 	/* Delete the previously manually installed VLAN 1 */
 	err = dpaa2_switch_port_del_vlan(port_priv, 1);
 	if (err)
@@ -2156,6 +2141,10 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_port_priv *other_port_priv;
+	struct net_device *other_dev;
+	struct list_head *iter;
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2170,6 +2159,18 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		return 0;
 	}
 
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interface from a different DPSW is in the bridge already");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1


