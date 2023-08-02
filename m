Return-Path: <netdev+bounces-23547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAE76C782
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBBD1C21235
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748E539E;
	Wed,  2 Aug 2023 07:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBF5663
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D810C7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBjrAPqY+8ALSXAc17qHr+4YaruUR4zevgVDtCi4QIktOKY+SPZ22CBImvJPx9ynr5v8sqF5FHrixHlqMzpuyOST4K9NYYfMh8tcJ4Iubf6WyCVzRxUg/no8b9h4VoohCJcawCw9GcqioWjSiPwNwg46nUCML6B1fT1dnm5pLZiOyWP5FWzNy+74SOXVRtf9oWjlD+91g0QtyxFtjH5e4ULTUxXqvxEEzsrKajygFuz5e6YwgZKZRidd5TgfqpIeoEnUajq0d/QSd3ARNheYdyhtvUayftWHx2tfjQxLyE/y6mMt7ODiN0kMOXELvS9sLxD92y2gLf5BSpPlziGn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eueLGk0RhrCOosWXR1wN2r8+GscuwDPOVVgs5RLAhu0=;
 b=SRtP5k+rUIa7IG/Zip8ayylFjbR0ZPViG8qlx6EZjQd2AeASnnBuovTAcysk3S8aPhJo7Jc2wkrTrZyqTSpZQtxknpfwmD1u5zWt//hpZ33goA46yXzLKWEIHQQhBwBz9/dmB/GvqFTD35WkGh8e/nv0W08U+rz651vHGs7TGQKAAIGE7l4YmpAIBtIGAck4K6e1beHdZ6kcC+ucF97zFsYw2hchq3BJr7tbm49C8Mtm85BkGNZOQdxgQMvRVj8sdTvHPBQgwc1FR1WktVLYgyu6MUQHGoHa7Hk13HCm64AWmORBcDCdtpo3+2Tp+vFmbJEQsIFDbOuUVHwRNwgqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eueLGk0RhrCOosWXR1wN2r8+GscuwDPOVVgs5RLAhu0=;
 b=uVbDWQwDHaw82FVAzJYAFqxrvDuqy1HORQWZ/lWoFfl28ZxFHukXayLbxWHjuaQ06MgUXvgvv/qGhdPawewACJylB1Au0vNv5MW63lymoxfDwP/zD4wcm2zgXovqgjph5jYjnfCTcHKAnx9Fi7hGOTmwJUwjnNwgDDiRLK27b0V2f+RAFkGxh92UR/yu+MqAQHp4qiR1o3bPFYd/1jb60OXLQumrJQ1ULFdURHerXC55rKoSwVVUFvwJPtldb0zcDifo7lhbnI3mxhVxIdeGWIW1QeaeUFlzeBuQmeDv2+60HhOefGmJDsc/uASNboxNBvkvcSHHGQuiuoVg8NVlVA==
Received: from MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::12)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:39 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::76) by MW4P220CA0007.outlook.office365.com
 (2603:10b6:303:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:26 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 03/17] selftests: forwarding: bridge_mdb: Check iproute2 version
Date: Wed, 2 Aug 2023 10:51:04 +0300
Message-ID: <20230802075118.409395-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802075118.409395-1-idosch@nvidia.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e58c1-9ae3-421f-f99b-08db932d71ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xRzylU22J+GE55ElSXDnxM74oT612op8uhFxMOptLk6X6sy/82yTaVvVYA1pLSwzrvPzq/cg9CAI62US4vU0PcnlH72ep8JZGAjpE/aB0rcQHvjU1WcVfZxWjAg2YQF/1lz8VYgXtpum8gKL/oDUUHfn/b6raVjp4dPhryJJ6p/Q0BXin+j10xrTzT8KEtdtNXcWVbcUF0opmIEWyEIa4VGSYtUqAtOCjHvB48TqCDe0ZnI5dv5ZXhjfFfeEMUK7eafoB23ZGez44crQiTlKmaP5iXcczPFtj2jlFbM6qk5zqw75GQeLSX9qpnJnMOM+MO7DOQkc9AIyg0hVJGfxbQ5zY3y4wT2lwllYoRwaSo1JfY9L5inOxyiMKxkYCYQCfCZN07u89onb5+1KhbNxzzY8cFH0NvEXUvSr6THRD264J9mEfCzNRQ6B3U65tK029STq+gdjyq3CrPY2m8ccV1iqoma19ShxuaZNzCZfx9Gr9bzlmglMcThb5XYsoYyNVPXZBV/OYIMyfk85GyDqmeaC66tVbF2v8jMdWSsM7WAAQwAhyh2pGod2I+DWffJeF9Qc0zh3XGp88Rl2drMf1ve8xJxHr/tjlxLoUi50xQFoCsIiv2kIOw8jXy7fWPU2GCUSblic7nYNxYUznRSUb12KO1OxRqeO1aTgCZpkU/IMa0Ul1Uln4tEqdRwvPr5yP5udQF41AOoutvmnC1DeEQkwWKTsCIpeZl1AJyDt7nALz1Xy705YVekLJCg1mahuA9jOzPo5K9hMLNHUu/3jIgeFldXQofvPH+i26c1lErU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(336012)(16526019)(40460700003)(2616005)(186003)(966005)(316002)(86362001)(478600001)(7636003)(54906003)(70586007)(70206006)(6666004)(356005)(6916009)(4326008)(82740400003)(36756003)(41300700001)(26005)(107886003)(426003)(8676002)(5660300002)(8936002)(47076005)(1076003)(2906002)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:39.6352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e58c1-9ae3-421f-f99b-08db932d71ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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


