Return-Path: <netdev+bounces-23548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF76B76C78A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2ADA28141F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864A5679;
	Wed,  2 Aug 2023 07:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BE5677
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::61b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C52728
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcumXyvyg2Jo3dz9bi5zjV+0aFJfHh2jS2/TKNbs48gvrngKVEpPOq7UUK6nY2WOb1S1wmq8zWRG5DXs7FJf1hNGMniwnu1eUbdWcymWHkvyYFu3O1vzAEQVuRdzFWhW2r4rGKQ3Y2fR3aifxLEyVqdLQ91EQoWihHyYQJb/PFrr6oVyM/aFHKruBkjT+TQlLxt1FL2V2lrgwNpzzOFEE/HoR1s/5cLTWlFLmMR7N0wPKf+yzL8WA8nErMXo4LFsXaadehgs+jp4vwAx9yp8mbIzu3JvLm9EkWLIjdjVrhoHD1pnH+KBajjjDxgdSFdfqqH/r8/NK9G9BUOsDiPx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSbpzq4rsPNvwX0AHf/LP+kveatQZloXX4+2cqcZ1Rs=;
 b=O8876uf8pMa16t8e28Rj+M4BvGOJRv24XAla88m4XpkIHNcUqGJ7KHAOlnTnIUU68DaRc2Wg/X+1UGKooIB583YCtihshnsrdfFBBW8UtvGube0eT4Rp0CsAIXsU61YzCdXC6r4g4QDbvpEHueR7njcjv+yy/KVFjbgLpZ3ZTDzPuJm3NSWF5756fJ8fvrzSQJfxWelhEahJaHNIuKRWkDSa2giWPBiYjTvef43hYyatuRY3W4gLwL9MGeLMmieUa3tyaQVFUe64C292mEtL84MO32pAFhDusnsia00AXlixodrtoRl1Ze/UhJVVTwYbASKHXTsNGf8wuWW8RUZlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSbpzq4rsPNvwX0AHf/LP+kveatQZloXX4+2cqcZ1Rs=;
 b=fwui4V6lny4hCaRSO1eoaMDqsw09Kd3jVkz9hjfp4NHcDQTtNs87ow2XAiE5LmX1AHtER2yUMNC9XCdvF9DcW0wt3GOdspjipLctsoX9dZffU0X/nTGQcU/SY3NU/F3elrv97g9ijWYH3q9FWNQTzMAchxcxSvj3YbfU2xYOW08CUI5MwKUnIHrlYWptNr91RlEA9EO/75JAzU+7ZQTNYJHVyMHl//uJe28DpQCI8ypmklAIAI0qQwoZXEP2yX85Fq621BFzo7w67fcIGwkiuK19mKZ8UTQoIYfAdapn3Bv7m4fb23EHcb3BFlXtIixid29kOp/QfUsoulj4+fO7Bg==
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:41 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::bc) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:29 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:26 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 04/17] selftests: forwarding: bridge_mdb_max: Check iproute2 version
Date: Wed, 2 Aug 2023 10:51:05 +0300
Message-ID: <20230802075118.409395-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3add8578-32b8-4037-77a2-08db932d72ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xoVgxqsDtMKVMRtdKCoyyTOGGndh5SKdcOCfnaATBNOkfVjqfQW4A2l59L4t7QPS/XV+ip37rQcPkmaWmsnTS96FyzZpO78zSxt2rbm0bVpw9Flg5iNVtI1N+S9xEe14ScOT1ADbs7vUWpn4gVD6l/Rdn5qPslvZI0PnAD2ooTNFEqOYuNxBhEnJTwmnIddnbZuN5z7SQRUVsgCfGYMPNpBsCtFv84MW3h6psNsWJ6ko/9cvPYXAGGTMP7vqTkoosEQwITPEKDpHkve8aOggZtH85biJskGQ91XWG2b3sq7rFzcHRJyZpzCGSagTc9EyCLxROHApY6i0OPuxMSjdMmv3Mn4n3onyNFoznSXGQJW40TZu/LvN13imzk6pLhsVXrwFWSDKpQVl4MgsmV3A/AKJZvT25H52Kn4+K3cb/Ahte3uybcEp9i98+cSKzWWO7YP89N1h10uN1CMEU2I/kOwGSDnRcoiPw7wR/t9IgyusrKenHRXK/Y5AVHXVMqHMo5GJOCmlkwE7YZUS5EveZN74Vxlo43AiSm+AoJRWGe3SvArx+IXyI+p+vh/jtMElIF+/KQDnGgB6tTis55CvQ+7LdUmGlAiPOvK2K91T59zo6UfkMvb1FJIfmzT9qTDOGhUeuc7SgoWHWe8QQa1xvW+UyXSUVSmSKgd7v4Rq05zgIhQbwpIryD+gnWlod6gHbeIDsgM28AhlEdHCsI1FjVVsc8oP8hTY0q6JPzR9GY8ybUjvYNEyATzyZX4l5ENebWhV/nODjyTnkn9wRrOHMM4y0GRZvMFBxwKbk2rh6e0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2616005)(5660300002)(426003)(8936002)(186003)(336012)(16526019)(36860700001)(8676002)(47076005)(83380400001)(478600001)(26005)(70586007)(70206006)(4326008)(54906003)(6916009)(316002)(107886003)(6666004)(41300700001)(966005)(86362001)(1076003)(40480700001)(36756003)(40460700003)(2906002)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:41.3227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add8578-32b8-4037-77a2-08db932d72ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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


