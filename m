Return-Path: <netdev+bounces-25339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304E773C24
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890BB1C20FC7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18918031;
	Tue,  8 Aug 2023 15:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B4174CB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:47:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305517A91
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQHCPF5yFhLtW66m6IIRG5Fy0f127gtQ277RWenr9xExRG12iQYmuPEo7SfkZOEXPrHf31sAgoMacGWLL6lcqXDtxkucX0uWbDKEKpk9h6BwgpmG34u8xQD7esf+ktHEExkTWjlGs+kHe9OHXoFGKoZMlbrvTLPAFgJDCiS7NVlCvnOEfofZIUkdyEj+vI9Bs0LEwL+lXAes/yIIIlRIDbIamVJeHyFKifQBNXklCdVQpKF0MQ9Sqw/ukH3lndlOjZKs95SfP1ZJaVyAUB124rasW4qrfUri9vPC1ulhHdQ6THXiJCOjvkqOSHaxbHJoJ+tqpubJFWb3mTKh4RlMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eueLGk0RhrCOosWXR1wN2r8+GscuwDPOVVgs5RLAhu0=;
 b=WF/rUBLiEZrzABt5tNOhnKsFabgghqPAS/PwK1JNJFZsH8f6dxclTevL03GJajg4Mid9tKn75m7D9tQuYEta0nKzlxc6ghJ8gyeM+fvwlJf7oXI51zVJXYrlOPS01XfYSn+QAdHFe+Z4KzwqmqLogkJNucZ2/rhOLQowrwfvVcqzuAM0HgEImzgEqKX5Lkw1BnjhJvR7V3sJR1nYNeER2ENwgzQ9eH+YYzQUNMxtKz237Yag0itirgiqHVOyIUIgEIrs9Q5gHa0zrGX4+E7xQnaue0jnUaPahjpIBEwR4Sndyr5I2xmZ5yceX0bgR3TgSzlko6ceqdrRH+YOP1aitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eueLGk0RhrCOosWXR1wN2r8+GscuwDPOVVgs5RLAhu0=;
 b=AJUgNi1h3QSyAOJkAXp/4belBNu8Us3SYfhXoIdWKYqXf7Kkq5Ov4IH69hlx0FabQ0zF62bwndr5v2b3lEElzsUOWvPjlqq6M2nT21L25H4BsQ8aC91rynYoroT0iwb7LHdTV8fsSVL/FV8UgR4iZBlMKkPfrmtw1db+LFHTq2UBVgAmmU8ZeoihfGBmxOuT2Pku9e8fTW0yQFqFxI6hB1kPCZXJmB7TkUuZmfUs5w8gOhwNDMcYkA4yXFpKKuP3gO2F5cOwqAn9pGR0pfIU/cWhTFh95yBPc2RpWVZbQZVBZ80bRomY47tmi52Hz0bUapDCb4RaQjKhaA0ws4PIfQ==
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Tue, 8 Aug
 2023 14:15:56 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::8a) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.3 via Frontend
 Transport; Tue, 8 Aug 2023 14:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:15:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:40 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 03/17] selftests: forwarding: bridge_mdb: Check iproute2 version
Date: Tue, 8 Aug 2023 17:14:49 +0300
Message-ID: <20230808141503.4060661-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: fe887e38-d747-4844-a11e-08db9819fb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fgNqWjT8qeiM1TW7qJQOQ7tiKRG71fHBrrZqDFIalbtqO535LyVrQF8os1mmBKC5Pm6YIJ6R5GnYkDfThWbkAE+2mTuPsWHRsmr9TE9uPNZEHJ1b1mV5lGZDN1sHzyTSi/E7SOQ0iYHiVFyaP58EsMmCTu+8DAQgepFXhC4NZM/yxBxxycHeieueIZyZ1MjIxBcfun3rDXVx+V6ULjBNt2DaRLoL0avQUp92yAAtn1K86EKawoYkg8FlScpqLtrLZKXrnd8MMhPCyKYeDOGsD8GTeJqXLg39iqDuGuv2dDIEYH/0sDoD/bhsjAoQDKrT4uG9eSHRaLhBMte0Ke6SYidpfGGEAGv5OgNV7YNWMB06c2lMw+igSwmom4BeEqh01eO3LXD/QzuvHOTGfz/9SDsql/g0or6heN71HSsHf2ILSURFGQpCowlAAN9EOrHzCasGUZIlemRKqfAkDu9bTfZasIaYpH5q88mPi/9VXt9XCZhME6AY7qfXLY+f5RLUNQ+IrD2COoEloWMk5dvML71rE8s7Uxy0QZ4n2cirVbyC7bkPcr5nsyeIzwEoY/s5GlHyQvWnO6pkrsA3BvLCwHge7uJUzbUhpokERSD7vH3blPPyokhsDNQIl93TOOou+lVNN07UwKTIinJ5KprrthEu2Qz2PdfdXkdL5EkETn2IWQF/vzp7nA9D07vcNZfsBTUUgNCq7cOnGuyuQ38jpj33c1Lzyk/jH3CW5kGuTHejMnB+SBK1NePX/4S1aT0dZe3Wg/B1mPYlGlary9E94p7L+zFI0uIgtu1JKB1PEZM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(1800799003)(186006)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(7636003)(40480700001)(6916009)(54906003)(356005)(8676002)(70206006)(5660300002)(316002)(8936002)(4326008)(336012)(70586007)(16526019)(478600001)(82740400003)(966005)(6666004)(86362001)(2906002)(41300700001)(1076003)(26005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:15:55.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe887e38-d747-4844-a11e-08db9819fb26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The selftest relies on iproute2 changes present in version 6.3, but the
test does not check for it, resulting in error:

 # ./bridge_mdb.sh

 INFO: # Host entries configuration tests
 TEST: Common host entries configuration tests (IPv4)                [FAIL]
         Managed to add IPv4 host entry with a filter mode
 TEST: Common host entries configuration tests (IPv6)                [FAIL]
         Managed to add IPv6 host entry with a filter mode
 TEST: Common host entries configuration tests (L2)                  [FAIL]
         Managed to add L2 host entry with a filter mode

 INFO: # Port group entries configuration tests - (*, G)
 Command "replace" is unknown, try "bridge mdb help".
 [...]

Fix by skipping the test if iproute2 is too old.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index ae3f9462a2b6..6f830b5f03c9 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1206,6 +1206,11 @@ ctrl_test()
 	ctrl_mldv2_is_in_test
 }
 
+if ! bridge mdb help 2>&1 | grep -q "replace"; then
+	echo "SKIP: iproute2 too old, missing bridge mdb replace support"
+	exit $ksft_skip
+fi
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


