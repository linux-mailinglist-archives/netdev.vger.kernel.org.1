Return-Path: <netdev+bounces-25333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAD773BF5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1507B2800FA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3485171C1;
	Tue,  8 Aug 2023 15:46:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156714265
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:46:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B035AD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibXc9JHnsZqcW5LKYU75zWhQ1XYVET4QC1dWGoZHiK6QV9voTG6QlicM8L0lfSdmSCPMxClE92jTzfGq40SQg242y+sXrX2+NMMTuDRQVJEy0W0dI3hhZir0070CovVzLQlX+caF6YQuG7sVU7RPlfzqRKnx03yRJ7QHuvTc46FlPqo+EIAuN0FoxGsug2Nv2kBkNe+4floB+Rt0ofDpacevia1Xe7DCN5SXQxICC/wrZlMANdU2478X/9jEd7+GfPMCie3wTHLZJO3K5muNZqGkfsZlXEziKnzLPGinECL8nlfAjWsq1tcGteQ2YYGqASZeVi+HILX6SL5AtPBsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSbpzq4rsPNvwX0AHf/LP+kveatQZloXX4+2cqcZ1Rs=;
 b=fIJrAIDP6TL4Cq+JpKcZU/TyDhydZL5e2gIzncYPtrl2NM9ysKhwe2oEy+0hlXFDDTEGW3sZnIaifBavM9rk3hM3YApiY3JSH/ZOKOAoU3XU/XmMerLT2AdhrtbmbvXc3E6j18w2QFNH0ikQoldtuUWcIrooygrxCHvZZnDBKlM0eAkzTEzNTjsh8Hu9WtFfW3augWRnQSmLANLibKYnzzu/AvuZIGxc9fbs3koKK27wJkHSRbHFHtQ/pJv0DUySiMPPlEYCRtdWuhA+U0Y4EQAHMBWoEZU8CNoSxlTJcRamx2fM+vncM5z0Ws/U5ciUFz00XtdEwnbA2DIaObUl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSbpzq4rsPNvwX0AHf/LP+kveatQZloXX4+2cqcZ1Rs=;
 b=hmTaB4774WaMMPDON2zt5uz5E2/6LfvK/wEuk91An50IJpDf31VRhAZrwO1FyJpz4kWdwGG+lGWAhQ/otE3B5weu1IKmLfTxsonFq+G0pVnk0ESxdqPk5HZEQ9GUScDeHgI3mh+MXwkJmkpzqnf2wFmY3QH4fsjjal8N3/G3lwBneUyFl++LjHgM/CW3q0d6d4LI+tAQHczrMBnHfFdfGbP+iBvKGgXWevYSKGp20peh9jCPfACBzKnaCXZEnWIHETU5px7LuuZAoFhfL71kK+/TWpJMYR0PH3wOlhlm5XsNDV/23BO6/7/juZ5D65Yai7nwpNmXKUfxu/sn/3HyUw==
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:00 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::da) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 14:16:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:43 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:40 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 04/17] selftests: forwarding: bridge_mdb_max: Check iproute2 version
Date: Tue, 8 Aug 2023 17:14:50 +0300
Message-ID: <20230808141503.4060661-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8425c016-c589-4ef8-8589-08db9819fe11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jscUos0di+QxSurQjxVSdEBT8xuY2mfvXeVVgqLNVY4PZjXXHViZod3dGteQAExrCc64f1WRdCVuxpq9syg6nPPrHUgqUDpPCpOpWEZY8tOI4ag9+fThXIbw0leGdh8c9OlWqp/7NXZGeo+B3WllRxw3TYeLyunNlXHhLaT5ArrY9H7EBp/xH7Q/MgTzIQvPyyq3IWFFFV8WwG8+Kur5S44ZfvVU10AeCBS92Cv1d2ArKlsxzjBBdibIsFPcEnj0k2X1CyDJARQBjV23a6lxWrjBOEfoUALwtK4ls1Iv/T0ZOuidpG2xjymTIfdH3gRDLhpq5zMRf26Kz5LgIK2CYfMmon+oa12a8t+2bdtdwNyvDeUZALH2bRpxHkreJo9G4HnU5L6zgPacSNmyGU92y2iV+43rE/kR7kfX43MWUKjDko/gP4EQ/bQxNcifMHrd7Q+oigxUnwfmXewaK0SumUW3gHny2ELhURM43wkct1M/rVqo6vXK7klvfovSvV7sjiV/mMemUuMJ2z/n0kNCVqFc/uvEUFNkxGnWeClUUWTBSCcuWWOuScHfxRTjGiz5TqP9u+UQAlh5VXIJM/XafTsiYjcWAdwWdof8ovD2Q+OWsH4ecg+d5x6dT8fmBhGTAukctWiYXkhnH9p3NsYDdevmm4HBAkGNVKHbQfS/aE9hHH8pmjpaZcopFSrlVPHeGdrixGs43///yK9ILn/Rzw2CmyQ716q8qydxsKqJTRfYpg8RBFIcXfhNMnN7tJ+p/CCS5xW2okgp4VSe45aoQpN9uFbz+EdYlkp1m0auHjs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(186006)(1800799003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2616005)(107886003)(1076003)(26005)(16526019)(36756003)(336012)(966005)(6666004)(82740400003)(478600001)(7636003)(356005)(54906003)(70586007)(70206006)(6916009)(4326008)(426003)(41300700001)(316002)(8936002)(8676002)(5660300002)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:00.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8425c016-c589-4ef8-8589-08db9819fe11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The selftest relies on iproute2 changes present in version 6.3, but the
test does not check for it, resulting in errors:

 # ./bridge_mdb_max.sh
  INFO: 802.1d tests
  TEST: cfg4: port: ngroups reporting                                 [FAIL]
          Number of groups was null, now is null, but 5 expected
  TEST: ctl4: port: ngroups reporting                                 [FAIL]
          Number of groups was null, now is null, but 5 expected
  TEST: cfg6: port: ngroups reporting                                 [FAIL]
          Number of groups was null, now is null, but 5 expected
  [...]

Fix by skipping the test if iproute2 is too old.

Fixes: 3446dcd7df05 ("selftests: forwarding: bridge_mdb_max: Add a new selftest")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/bridge_mdb_max.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index ae255b662ba3..fa762b716288 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -1328,6 +1328,11 @@ test_8021qvs()
 	switch_destroy
 }
 
+if ! bridge link help 2>&1 | grep -q "mcast_max_groups"; then
+	echo "SKIP: iproute2 too old, missing bridge \"mcast_max_groups\" support"
+	exit $ksft_skip
+fi
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


