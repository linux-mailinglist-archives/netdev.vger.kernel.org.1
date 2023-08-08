Return-Path: <netdev+bounces-25335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5B773C04
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2BB1C20FD0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9E171D6;
	Tue,  8 Aug 2023 15:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77C171D0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:46:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213B7ABB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8+S9cUT6XIEHZgVgJHwEjBsi+TyLlaJWKZj6IlYAjEkJDn6yrUYHjnCJiH8k8O4H9bJK/yzGEKq7aD1oI2HhtwejjZZHBZUYKmDHLngVWVCeOUetzRlctxMYYoHzjuwHt8QGmPhOgr8hWALB5WodSrMCeiUMAPILRcfwYaUkF8tnBjutCSsUf23zvZE9NTcLxlhk6ZjvWaOSUX9TXqHL1fV14Ps2dZk/qrdrG+ABK/xDrMt05/0A3VP6kkEuMa51A5WYvCsqJPQmvYORc3UQlZGbZMPxZU4otZNPVvuCbp3jl8U1GqhtPqgfPNFKBMot9rRw6KdheDuOhGLAlSgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZmsyxattMjLt/Gppiqx7yvwYdKp47rC94asz9Wwv0Y=;
 b=jSzqsu5eRU+IlIuE23MMjwvioRTTGn4AmJZ/yyp1PVZ6x5pWhPNadiVrN/fIhDdROndX6PELRRcBAE/llPTAwkA432cpUvQPA+jYectm7FAwH0xHTk2kRkciZC3bSrGCsCeG3OxUHH1+yfn/NTd8+hv7bRuy9xGaBqgfZGHOtiraCISnsla5wPZ1WTgSx2IriHykC7upzeuYrlF5BDDAEwAFcM6r9qUzZRUym02+jyxR8sSsCg8Sn+RPeYyXLH+XnDww6HResrLKWbkHVGbf/ihMBpxawZQMNAAHbJNvZy44uRyTsYGnEQckH1mdhc6lQ0WNEY7xz+e2AVzbTY7u1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZmsyxattMjLt/Gppiqx7yvwYdKp47rC94asz9Wwv0Y=;
 b=Uk0Pb7QXpNo3qppiVlRCPI2xOQgqLUmx1vXhAn0m2ptrawpFhonj/O6PAjlJpd8ZGCQHQQfp3M37mP9WYqOpRmxRgZUDv+csoAo/YqwyqzkAN4HVarysJkbn72/gVWK/Igyg3tdWuyXE42V6MxB4MzTdfWHupn+doVWck8A/R8SQiWym2aRkMxMw7Zt6X/OFFrJtLuf/JLWpvReKZGhnXCa4kN1PuOFYj1AYwYKxKvykAl/MBE7vKkctlEQMVvakBx5lEcws01yO2MvDGJ7wf8lACZ4+su25GzVdNd1FSRWIhnA3s/OE4fdxU15bV15JzQ8pCsgL167XCkVqgaIfXw==
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 8 Aug
 2023 14:15:51 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::82) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.2 via Frontend
 Transport; Tue, 8 Aug 2023 14:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:15:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:37 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 02/17] selftests: forwarding: Switch off timeout
Date: Tue, 8 Aug 2023 17:14:48 +0300
Message-ID: <20230808141503.4060661-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: e088e476-7da1-48e9-48be-08db9819f886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UzNm+gzoy82MQfQSu5Io2ZfOpG9t7BQ+9KpG0bIQ9pIOqLRqjBsG5wg8ZoEKCqfJyTOGgh/kOjLaSkPn+qOgA3N9lA39o+jm/hcSvdXzGew4Yb4Bco3MN3//63Z6XGRaI9BYNCKgN7SiEpQjeADi4DAvpGmFucnAwZcSTK4YBVvPcwF69cN79pJjooZX3zLrZePgO9EcAQymUHxts9i77ALUu/IW42h+Md8AsmDOPnv0bK4yCyEOf/73APRZPk3tApZixsPjKpsoUv7QCOXeBa+xRcSeS72uss7KcTH7UNYSEhbx7V0cCin/ycWjlccKKz8/dbXg0e2r3QC+JNGaAaGOQNXFFCJeEIBr2Q//dqSP0UcUVzCN2EWFItUZMyK/5Q4e78vverbhiQXqsYW+xbbyBQkVr8V8wYeX0C+2hPiUPZZ3fxzyypQTgXaGVtF5J79hGZpnZnZ6Zt7v20FXAEQHC7D/jC0nWdh3BYEcSVP5tzkUd8B2NzGKqsOcwi3Nl+OE3Iv4wfm1726opPbmMOLSa4hys6S6Si1IEEhttBs0tU8nCKcdB554La1XIKjjRW5l4y0RWMH0gfRdkDF2+D+MeQdVeQRXN8q+UMnO6qAvaz7K6EFPVxqGKqAHRFokoTfezX0UDIl4j/tdCYapgKku/3KtDHws+V3KXAi5OaSUttiGq9DrsrR+8THn14P/IZ9m3eXTkP/tRjBP+WLltuslmzJSDm6dGy3oxtt+HFtD2vWhqttSbhniQk7vlwHQTa9t3TpKSc4E0A2Ke1xN35ZACUqa4Gr0XQA1BD18y3oHKJ4HTNoejeEPG2hJ34doS57EX4/VyYAff6wvN2LEQHs8FVMF/MEwdUfGljEKROA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(186006)(90021799007)(451199021)(1800799003)(82310400008)(90011799007)(46966006)(36840700001)(40470700004)(40460700003)(966005)(316002)(86362001)(426003)(83380400001)(47076005)(16526019)(1076003)(26005)(5660300002)(36756003)(2616005)(2906002)(336012)(7636003)(82740400003)(36860700001)(356005)(40480700001)(8936002)(41300700001)(8676002)(107886003)(478600001)(6666004)(54906003)(4326008)(70206006)(6916009)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:15:51.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e088e476-7da1-48e9-48be-08db9819f886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The default timeout for selftests is 45 seconds, but it is not enough
for forwarding selftests which can takes minutes to finish depending on
the number of tests cases:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
 # TEST: IGMPv2 leave 239.10.10.10                                     [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 is_include                         [ OK ]
 # TEST: IGMPv3 report 239.10.10.10 include -> allow                   [ OK ]
 #
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # TIMEOUT 45 seconds

Fix by switching off the timeout and setting it to 0. A similar change
was done for BPF selftests in commit 6fc5916cc256 ("selftests: bpf:
Switch off timeout").

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/net/forwarding/settings

diff --git a/tools/testing/selftests/net/forwarding/settings b/tools/testing/selftests/net/forwarding/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.40.1


