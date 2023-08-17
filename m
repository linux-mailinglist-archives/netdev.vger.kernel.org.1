Return-Path: <netdev+bounces-28465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79577F834
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A074A1C21355
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A414AA0;
	Thu, 17 Aug 2023 13:59:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23614A9F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:59:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE22D62
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Jz59ntKTpWU7B2ktHuaXLJ1em+K6+eHHzgAfIcT+AAhRRUPJFB/fwgnCcMDHpWy0jIrBntadki8ej37lqqSppvmfnjnBcCBkeWDC71q58jk6ZhfUd6+Jg4KmVZC6K/4C5IJAZTFwPi4auYXcTA7jSl2ohiovGdBGTAwzhCV57t0ekeUrSbazwcMofibRmNkxba7HtLQCZ/CgJPhbfYZMchP5vYHIMQ8imlVmQAXQyKkZpVJQ8pXUBF4AT5rXRuwWU67soVjWxssAoHw2FuVieVyHCa1mTuwUXJZgkpiqgZJlFVnteL0gNOzxQ79ZOEqbY+hUc1v3pu6md96MsTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3JS36wuqeY7tb0RfntN+Na+6Rj507kQNg2IFY8SSAI=;
 b=Dz+a0d4JHdow0upAVsp1SsLydiAKHGFLseVkQSaSyeQ9BOUyyXY/WpZn20A0tBWhIXwOM1dpCQqS0rBaKAfAx1MPvcyyRlrUAGzzHTCtlZNVNvNBDRyTnkUjzKd0Y/0Wi2CHQraUJD16afkSPSzHC9tl+W03LfNKdYryQMJjOt7VfPzpD9HH4Z8fZezKM5cE5VZk6JYlo5hZHELtpwbyjpJ+IuJEIvTbLkgUvyBlDiD4w//pLRotdovFLDXxUo5pzSK7I4TfaLgy/Emr/j7XJznFUcg2hOJEskr/cOkuw564dqLOAJb2AXOcWSU47+F9gEwyhnvD3H3jpPTs/U82bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3JS36wuqeY7tb0RfntN+Na+6Rj507kQNg2IFY8SSAI=;
 b=kLJFm/V2XmrjtFSUhvaAdTxv6TtYKI+UUSnjD6lZ/l3EsqdZr08Kc8o6km271y5bP8S4tpww70PNPvIJgi+E3WGGEXCQz6AAjTFqKtfx+WHDWgd/fo4TKc5EJk+blzZzabVu4ScmntNcKqdiCa+iX3J2QH0lsioIl5bBoxNyG1h36ouI2vrbE7WWAs4hXeL2t85vOM4gmEEoYk3EKjDOFOdgwWfvy5LAm6QFGMu7pkc4PnIJXChSjUE3mE0v5XHVGwQhIkF2SR59a99BN3t2aoc55hXqVHguw9ngOD15+yYI2T3n7kwOCz9RhIJuliIts2/7jtw2WUjQOZtIO3iGMg==
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 17 Aug
 2023 13:59:17 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::d8) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 13:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:59:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 06:59:06 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 06:59:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 1/4] mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
Date: Thu, 17 Aug 2023 15:58:22 +0200
Message-ID: <bcef4d044ef608a4e258d33a7ec0ecd91f480db5.1692268427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>
References: <cover.1692268427.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 2529714c-1853-4ed6-04d3-08db9f2a25b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fkuRNomPCMZ6fYDsli+opKA74cftbHjU0+MH3y06ECktafwdbyCp6rfNv4JOlDmC27FarUe9Pz9sd31S4SD20qIwMhuhJrtqHlDS4wDfHSDD2YbfzmstIj6AJTfJcOYG75P2VzVJkMd5OqKp14zAULiONVYg07D7/Ekr3M/3pfJR1Dvtg9G6rFe5JA9yxycizeGAUGKP9Nbaj8ctrb+ruCJ2J0QW2nIy8Cs0VvvoIfAao6PSgpFNL1PS3nDb0K5Fjm00vuwnrS14wr5DMFrfp3C/CvMb4UJrKb0o/G4f1/LCNbm2iEhxgciqsEEE/wwKoAHibwO0zFLzxeMvtkvxNOK5qklliro0xjiOTzlcyWRU0Z7pglusr5T2znL8HJCIKlkC+C3aO2X593n5nyBKda6JXHTL8Wuty39ssmaN1Ls8mxbrpAfw4VD1EMA/LGc/DRAj2etiv0TXf2gHDn/q3qgULxfxoTS9rRez5gOD/x753GtrkXm/OE0LorJeX6/CpJc4j/ncSxVq0QCGFs4qMdlpR8RdW0IlTlNXijB0W0TErunBKfazP0VESZc4qx4+AxwwEGdDLfF5DHh7eKlvxamOx4SrsVwdRYpZVIiUfmmtTbvn0u8y4GN/0Uwv8c42CzFC/0mlim0DccD8vs05kCI3wXDLaHrOa3TSUXTyWeWL9P7vOczYAkPTpJMYbzbFhZkA8FZvOsIqx1++1g7Y7Ou2jmh8iBxZa3xebRkPc2pZ9Cwz2uj5Y/uCJ50PPAPh
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(36756003)(107886003)(6666004)(2616005)(16526019)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(7636003)(54906003)(70586007)(70206006)(110136005)(4326008)(8676002)(8936002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:59:17.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2529714c-1853-4ed6-04d3-08db9f2a25b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Danielle Ratson <danieller@nvidia.com>

Currently, in Spectrum-2 and above, time stamps are extracted from the CQE
into the time stamp fields in 'struct mlxsw_skb_cb', only when the CQE
time stamp type is UTC. The time stamps are read directly from the CQE and
software can get the time stamp in UTC format using CQEv2.

From Spectrum-4, the time stamps that are read from the CQE are allowed
to be also from MIRROR_UTC type.

Therefore, we get a warning [1] from the driver that the time stamp fields
were not set, when LLDP control packet is sent.

Allow the time stamp type to be MIRROR_UTC and set the time stamp in this
case as well.

[1]
 WARNING: CPU: 11 PID: 0 at drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c:1409 mlxsw_sp2_ptp_hwtstamp_fill+0x1f/0x70 [mlxsw_spectrum]
[...]
 Call Trace:
  <IRQ>
  mlxsw_sp2_ptp_receive+0x3c/0x80 [mlxsw_spectrum]
  mlxsw_core_skb_receive+0x119/0x190 [mlxsw_core]
  mlxsw_pci_cq_tasklet+0x3c9/0x780 [mlxsw_pci]
  tasklet_action_common.constprop.0+0x9f/0x110
  __do_softirq+0xbb/0x296
  irq_exit_rcu+0x79/0xa0
  common_interrupt+0x86/0xa0
  </IRQ>
  <TASK>

Fixes: 4735402173e6 ("mlxsw: spectrum: Extend to support Spectrum-4 ASIC")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c968309657dd..51eea1f0529c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -517,11 +517,15 @@ static void mlxsw_pci_skb_cb_ts_set(struct mlxsw_pci *mlxsw_pci,
 				    struct sk_buff *skb,
 				    enum mlxsw_pci_cqe_v cqe_v, char *cqe)
 {
+	u8 ts_type;
+
 	if (cqe_v != MLXSW_PCI_CQE_V2)
 		return;
 
-	if (mlxsw_pci_cqe2_time_stamp_type_get(cqe) !=
-	    MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC)
+	ts_type = mlxsw_pci_cqe2_time_stamp_type_get(cqe);
+
+	if (ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC &&
+	    ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_MIRROR_UTC)
 		return;
 
 	mlxsw_skb_cb(skb)->cqe_ts.sec = mlxsw_pci_cqe2_time_stamp_sec_get(cqe);
-- 
2.41.0


