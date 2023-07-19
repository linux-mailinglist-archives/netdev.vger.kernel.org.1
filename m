Return-Path: <netdev+bounces-18961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C007593B1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46111C20F73
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE1134D4;
	Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBA12B6E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD55E42
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4lPoGpJxkpCrjt7im4xaCMhxaAb9mN3SpILxyuFWcHUO5eHhZrHUuMnb6MdwIfI5RU9+e+riUiTaMTJgBpc0/GwED19gS1thTiLp6acJnEdAMGaf6c1RPcY33IjjIVmI0b0iYVuzlOEPOSxI6L8ZhiT6UPZfTFwHJGflt+pDZkG0vRvXXxRt4xYqQu4PDzOPownBkXHSfHP53ycdgxgnPoF5q/m+S7UshT05vgVq9Gp4U2IN2lmpVaXF8aUACDygd5GK5omnHil4X0b7xBT4ddEJy84L6DBH/9t0MjQhfEOiopNAd7LvLgICstKxot4PTuMVpi2ZTIZ8JBh8dxDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFiqUMPZYUeM+OZB5tTJsc4Sj2J9oLGRNtKxYJZx6b8=;
 b=FJiNHLvOlLo2ca0muXdvgFahC/DPdPYnBgp7Hs2Ur9oAQjX1+ObVoGMBwolWFcP4hBJWQCerdKS/zMx8udMsu2Tm0HJXIYPjZzR7vpVplEjAKwaSqBLmabIonA9VmbOd/kmbLofnD5YYNLitgg/UV3Ap+yERmL1MQQDWgrezGLXIbuncoI79C98W2kFCbf0Ta3g7+vrowG/oAkChIHibXQh0vicsFsyzW2WnoI4KyvM+o1axThr00G9nr2N8wgLTG3i4guHn4CRs/SnZl0vjXRzerjL+liQ3bvMjuU+qLnsp0bOUFwcjx9nhM906sdXt+Hkw4YDHccIylEwhv7azrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFiqUMPZYUeM+OZB5tTJsc4Sj2J9oLGRNtKxYJZx6b8=;
 b=U6LUIglaDUwShGAF/N0P7PXgxL0K6ruxvLTi4opf+jBEWA5JWt28u2VzhX6I1QK2UUg86xY3OYzMfXgtx2e1KTUUOCJEzhcMNATCqK8IDQegthgvwgbNzkkAq9WwE514O8QHdqhAzNz1KA40xnd5N8wZw/WNdeKLV5an8yfUoNlynXHrZXrKzh5Ct+sCFM4of27gEHyTQyzFT8PPxCDjY/eQlqOUzAccq9vgDIfUL5BaRLyaPX06Oadm58IDT50dqyCxDB2PlZEfMbJ6q0frDpltW1ovqCqb8SUDl7Gtfjn4C5nn2P4zG0tdZdth/lLjDitoyuPqXiQhzuVItg71/g==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 11:02:30 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f3) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:14 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/17] mlxsw: spectrum: Split a helper out of mlxsw_sp_netdevice_event()
Date: Wed, 19 Jul 2023 13:01:21 +0200
Message-ID: <fb0cfe48d8eb3a271ece73f12d2fa00f94818a85.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: ac629cb9-fc54-4329-d108-08db8847a55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4hCk8+jAtm1tnrsmQ4LCMRxWIwTnJgJvkmN1cvAiB31PiPe/AhXUkFE0x8C2V7H7pf0BH8EzKX+lSzICW32lRI4IQLZwB4pMAYxQAuYLniqzwUhBOiDsZcXNB13GwQ5g7kWMib3MV6TJGr1Qs8TeRBAaLQjx4SSqqQSkdj82D5Y64BVqM6Q7mH8dHIAqvTOYlvHxg3D6+YlpXzFPfw/67Gpd6eCALoTgSbf1CNo2W3wzhh7ouu5RnSJdzM5AjInPqOxpzKNYtn5g/z5ZnUh73dUSzM3pVZUo5oQH4uZ/znzEC8XOEIBJIJukPAbIcS485aQmVHtaQrN6a4URxSAAbNiSQcS6LltUepScemTH43nhb1uzLulnFnfNp2Xuo3OgqId9eEfTIlvrSXnCcZP0AFn8Nk/GQ8ZZHDgTrMnRh3JPmXV2FToEp6YwYPb1jg5E8V2wE4tFq5euWn4g+3CatKaD/CvopFx+CyPJoR0up9vWsFdYcwdpVyLPqrAKBD5dPCIHug91Sf8LvbJIWeR4YJEf6CjDKu4Lbhaivop6KKnb+cQKwTt6MZu7gIUUc5urvGaeZmZvYadof50ov6/+45cus8gntlKoGb9wfup05owc3g1PK59yxvTFhaGlmZrXEBJMt+6KI7/X/x29cMWMcDK6HJkiq4/vuAiGTwkqltGS9wK3eITCtwjFCGLLrASy50c3Ljo+SYd13hiuOc0GR8TI/s8iVR6ELTlQePrLOSI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(110136005)(40460700003)(6666004)(7636003)(356005)(54906003)(82740400003)(478600001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(316002)(2616005)(426003)(83380400001)(336012)(16526019)(186003)(36860700001)(47076005)(26005)(107886003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:29.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac629cb9-fc54-4329-d108-08db8847a55c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the meat of mlxsw_sp_netdevice_event() to a separate function that
does just the validation. This separate helper will be possible to call
later for recursive ascent when validating attachment of a front panel port
to a bridge with uppers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 86e2f0ed64d3..0488fe5695bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -5146,21 +5146,18 @@ static int mlxsw_sp_netdevice_vxlan_event(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 }
 
-static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
-				    unsigned long event, void *ptr)
+static int __mlxsw_sp_netdevice_event(struct mlxsw_sp *mlxsw_sp,
+				      unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct mlxsw_sp_span_entry *span_entry;
-	struct mlxsw_sp *mlxsw_sp;
 	int err = 0;
 
-	mlxsw_sp = container_of(nb, struct mlxsw_sp, netdevice_nb);
 	if (event == NETDEV_UNREGISTER) {
 		span_entry = mlxsw_sp_span_entry_find_by_port(mlxsw_sp, dev);
 		if (span_entry)
 			mlxsw_sp_span_entry_invalidate(mlxsw_sp, span_entry);
 	}
-	mlxsw_sp_span_respin(mlxsw_sp);
 
 	if (netif_is_vxlan(dev))
 		err = mlxsw_sp_netdevice_vxlan_event(mlxsw_sp, dev, event, ptr);
@@ -5175,6 +5172,19 @@ static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
 	else if (netif_is_macvlan(dev))
 		err = mlxsw_sp_netdevice_macvlan_event(dev, event, ptr);
 
+	return err;
+}
+
+static int mlxsw_sp_netdevice_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct mlxsw_sp *mlxsw_sp;
+	int err;
+
+	mlxsw_sp = container_of(nb, struct mlxsw_sp, netdevice_nb);
+	mlxsw_sp_span_respin(mlxsw_sp);
+	err = __mlxsw_sp_netdevice_event(mlxsw_sp, event, ptr);
+
 	return notifier_from_errno(err);
 }
 
-- 
2.40.1


