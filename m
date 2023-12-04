Return-Path: <netdev+bounces-53551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACF803A72
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24638280A17
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF599241E9;
	Mon,  4 Dec 2023 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHm1mMQb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706059A
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtoffRw3m4ktJUn5Ckjy39dicKfEj8bPFRB19Ggg0MAij1PoAK2rqRdvSOHpuw/VvUT4lBpfuaM1eI2nBuvSrF5bg1O/WPZVnZGzm5fp2wmdwcuGosp2Wt91plMmGjJweGHQsRov4mRA/QvxEA+OfQ9j2COIvZtIcz0jANxqyDcRvx4A6PNRqhhwAD0cIF09+qwso7JTdn5j7hDW+kxYc4+RXYZcLrxnupqh1Dkat4izQqOoLLVqxUb/a4Ityg2iIpWUV64YQxtpld+xHugyvtFv8ub/sz4MdHvKZ1zGD7XN1o308dFntoSmY9KKXiRr0N8wvRIHCxLzWZvUCLRCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTC+LOuF0e72iWOWgE7tfXPmldx7jJAEsDXJV3JjePA=;
 b=g/7KW+VliyLcgPohPNhoo4C5+tNy/mlZETCvqIfZ8TqaQIxC9J6HZpXQB5tmJIU+o2hjmryskixh8Abgf+q2t+ycbWFxMckxFBZw7lb5pnz/8j9sKcpqHHT7rJbrhI6uAYjmjZPvyiq+6wvlJukLxqkeRSsnEF6AmNArdOKtfOakOLN2XvVUaETlQKjlfs1sBGWl2PGbP8S/3zdF/q79dLO/P/ec+NpkWCougkk2aCjPxtVEMi8XrnUynMWwFgXu6KJBDSwP5I8enjVbKEAAsbWNfQE4GtPzaXH+q47r9v3WKCkSy5p716Z68lLVpwafBkCyCblc8hzY+IBN3cr0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTC+LOuF0e72iWOWgE7tfXPmldx7jJAEsDXJV3JjePA=;
 b=lHm1mMQboiWF3zCNDW8BtAgiegiNHstbKmQUscDo3tEA/r0yztjeVBra03USOPkdXKg+jeuWYilKcwwMuepVgYfTyiJnn4IL8Vgl6IXFvwYsYn1qgV4URaixj8G1fCJ5Y4cQ4SQ5+sFvW0yxReZVcwJSB4vO1JfkMewWgvp9gps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:36:08 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:36:08 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 7/8] dpaa2-switch: move a check to the prechangeupper stage
Date: Mon,  4 Dec 2023 18:35:27 +0200
Message-Id: <20231204163528.1797565-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3e0580-3342-4c88-f086-08dbf4e71df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3s/hAFk0Jk5YwsvjTGY+KD5sI2n4vNmJD7/0oRoydDmptLHJF35I5lLBeuFwfeQUPgPHR8kiT/gjYNBTmvXYJp7wJxa7+nAJvpUXXnMrW7Bv49CYqVdN5k2zTwVRMyI2zCkdU0jT3LSaGQbpiz5ta/g+LRjdAkAqClh1DotsWRgvLRGH7vnONnQv+hyF7tf+8njOWANXlQ1YQqeQZleYzLO7/X8oM9b1+QaEY50pK2/AqiXHJQdNftLJtwRVYCQ903vYe8l1hlcc91/fJMATKXKewvRYVZSZf3ChXIUi4Gd75mKIuB3firjGXeR8iITolAu9lsOhmytUsSCVuzLHB/yk71md7RRRA/Sou448HjI2GsaK4469tKlf48RXabIml5NTrHvd7TY0wPUlJi4Qo1id9JXH8u6jBj2f0S94V4ieH1N//Ia/gbKRgFPo0UiKMRXfUd1fBHvMlxLlpMVrOjvnc428XLIz3xWoaBPUYt6C38utJ7YclDmUr6iIyTVdPvehiCHnclpSDsYTJauw+MjTjEwoxfkj95vVScIsG/uIjMqypmgA7J8p+GezoC1b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XiyUlrdMOH2FwoPFF3DAUO0c4rzO60TyzUOAQ+B8eHypu6FDPqNEE7swFgKk?=
 =?us-ascii?Q?PoCMBlIkYPRr6NVPcVmrteiF0R6xO5tdo1L1fXz/B4Sdz23AlJvGBWoTJ689?=
 =?us-ascii?Q?JVx2qrwVhC8rtsRMOv9hoD+yPg/rGsW2jTSPFLjYOtO4j59kTW/oktN1hB/D?=
 =?us-ascii?Q?Xj5q1EwoDy3zPvfnTTrkPFiWby+b6/u463c+Mhbz4jZNU6dv195aSsEw4FD9?=
 =?us-ascii?Q?1/PlGzBtcnpPUphjx6g7n6X68CEOLu6RHRy8gJUmEzf7476X8czUpY2nK1ls?=
 =?us-ascii?Q?JfiCND5Jiafh8szFnowgB1KCpX1alJolkDpmu5zKiQHBH+0mYxAVD83P3g9I?=
 =?us-ascii?Q?lYB/ZL7XQQTK0S3sifto9pgSaXZ7idYvlkuYKIl1yI1Sm4xHuK51fTIRJdAt?=
 =?us-ascii?Q?jsed2VqXu5MuE841PCJGZti8kvNby0uDWCdE9oXnd8xa1vuzx9OzerFutaqv?=
 =?us-ascii?Q?Qo/oSNqfGs+vTvfp/tCVgqvRFBoa1EnRCZfC5Nm5MjGJ5ngBq+klEjSR2yWD?=
 =?us-ascii?Q?cxU1qN+OR77gR/1A0NQaSw75W0bigwox7lGoKEHRtqFmkNPiw1OKUl/H1/ao?=
 =?us-ascii?Q?T0vQDpWaXH4DwDGvzmRZLqpqT2MAvOZPWZ5oQDnvU+Pu6DHV6LH7Mu25a4bG?=
 =?us-ascii?Q?ZclydLWxBwRzjaAJecOquXT4U4zoYNkcSvEgTElcMKRxmxxwcLmrqbTkgXNl?=
 =?us-ascii?Q?BxodDy38ycJs03oVKFL6kXzC6VDilLcJNHu+GFZdo6EYU1A598vSU5toV7V2?=
 =?us-ascii?Q?kghgUP4BoduMvjZuMLG51tq9t3Ifis13wVwxZEOBCHYcvxVBTbAWSoiJbCl8?=
 =?us-ascii?Q?jZW8bFP0Rg3k4ZT7Tnt0fcyZfcntyXaNnrIl5OoSG19XDc992RF3syEw/fPs?=
 =?us-ascii?Q?ms8VCQonUB1fMz+g8KruLW3xelwsuaVuMmEVVbZK2O+r2ORV2B4GU/94/JJl?=
 =?us-ascii?Q?77IB8XoAE5qg9Eu5hussybMFdYm+PYBJxwXIVh4WylH1okSaCPkbsquwHc/M?=
 =?us-ascii?Q?ZgIQMa+AVlzMXl2jiopyYucNioEwHKfxzvEuIbYnPLRzLTrudUWKUeTj9FGH?=
 =?us-ascii?Q?rIYBvmKBB4T1B8VXULhPuftnCKRLe4ZqvpidD/DKxYiHMj+H3gdHm0YH8B7c?=
 =?us-ascii?Q?PA2qvKW5zGFdFqC4UFW/cPnkWyEx2nabVd7DLBPp8rQyJZph3uHbmKVDb2T9?=
 =?us-ascii?Q?X91r5V1f6zUxZpHYvzAo5cNQa7ak0erfjTSyp28H03JTEzYJsRWar7syWPH9?=
 =?us-ascii?Q?KzgjYO+uM5IWwzgwM5PTw+RMHOS0ZxjyfUPDI4Oq6dw9DxTGoP777GaxHv4M?=
 =?us-ascii?Q?CO9obyUUgtHuEGYfqqoEhsgPHEv2iGbjAqz6o9B9OwAxrxPeV4exBC7XhJ0s?=
 =?us-ascii?Q?w09JtEcqFpuwXdf4zzF/GqrYOMvw4Rs4U6NMI6CV39lYtIdCVhrJoeQ7mVZU?=
 =?us-ascii?Q?6l/DPcVYVTaO3TOJEa6tQA2caqOvzENEs2oEkmcyqQpBAGc1aHchsloXBG+p?=
 =?us-ascii?Q?7XCiGCXpNUHm6hb425WG3AzZebDXw6VNhjCrPOEcYOXUW4aa4EQAzdPLJWbL?=
 =?us-ascii?Q?6IgxbdCOM6Lo8BJv9L1BnQI75bevy7B1RRoWlI3t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3e0580-3342-4c88-f086-08dbf4e71df1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:36:08.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQTKCrm0eFdDGJplsmb9a1O7nM/mZ5pjSNLELwVB9FpDlQmEnDCaFUV4oO9GXioHaphVOkIxC0Y+Ut5DL7A5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

Two different DPAA2 switch ports from two different DPSW instances
cannot be under the same bridge. Instead of checking for this
unsupported configuration in the CHANGEUPPER event, check it as early as
possible in the PRECHANGEUPPER one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 58c0baee2d61..dd878e87eef1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2008,24 +2008,9 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
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
@@ -2163,6 +2148,10 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_port_priv *other_port_priv;
+	struct net_device *other_dev;
+	struct list_head *iter;
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2177,6 +2166,18 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
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


