Return-Path: <netdev+bounces-25338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44745773C20
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4017A1C20FC3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28D174D1;
	Tue,  8 Aug 2023 15:47:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C51775D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:47:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8A7D87
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xem2gC/N+F0I55eyC/OfZGMNkucuJG2RUET4sfgXJWBEIkbnye5VVU6nXJ+8VZKQ0hR0OuqhimdmPzCfl5wA5d20ioawGNzCs6OB7Ra1iEdh+LdiR+guMqT2cRgI5nQpudB+m1Ry2NaWyYf2Ty0G9VYWiY735YViQ/VBlJGqJX/bXBLKRPrHcuxuJg42H+68ayGyYV14Zz7kX56wH72kuKfzZRogRJFdlOdkpnir6sF4tf3HPrseWyJjaK0Dih4Nm2gzzbhXig3RMYALaU9EFx3bHIQY6uTJnzbhRTcAHAPVxpauHmy94qRUqEoLWyRSPMZ1McgbE+sa7kKLWlTmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMH7/T/+FkOW7OBEITpo7Jk2nnS/EDOloQLZqEulg0=;
 b=CYC/Ztc4NGGp0K9OhAJhvhBWFUJfn7QjifnDlWeHcCp9hfkmLInolWMVB3cXjZE54lbhxHkyEeO15sY+r6cPuZXfbjzgxggeBaEl2UOGn51U1sWYZJx67+S54FVRF+lgT64soZWCWTG07wdlEb83IZt3uOPliWfviV9ydx3t5mAzga4+RICM16u1IHcNwRtpTvKOQSlUCRsdbka9MLVLMin6KmCnvtZRyIMaCOcKpj7e3ptkQ+bc7AuEYiz/GxxthxUlFGW7wgcF4SJCs4fY2+ZWDzI18M9Efsy1rEQgo2iw+USppw7cwYxnhxWSDIAhs8QvTZ50lATxVZvaaOVnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMH7/T/+FkOW7OBEITpo7Jk2nnS/EDOloQLZqEulg0=;
 b=cPmIwBJIYs59yMVtrAAwqTW/Fs/+SczdWJmd8JpFdrU3klGDtBdMmGmKnYMvtLZhSIZtBDHeMgDVV4h8jict6SmBOnN63+YhN4/wcH/0W7qVr1CokBWJKgxxIY6IufVoNzM6qbatvprY70WxdCeAmA7veQiomiLp5PkzXCxNzYn5z0zS3T9xyxRfOCtT+UxzABGMayw0oZPGpFeP+q+WbUH1Wm++A1dZq7Jvq7lkvK6FCDmKj+J5pwh0oIKG8STcX4e7AcNzD3HuyAEz3OUuQT0d7Tf9vWGAxslSwOIVBbwxNwQWCFUwxlM9D4vNoosEwSWAMORWsxp/S1iLGkkoHw==
Received: from MW4PR04CA0045.namprd04.prod.outlook.com (2603:10b6:303:6a::20)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:16:03 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::5) by MW4PR04CA0045.outlook.office365.com
 (2603:10b6:303:6a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 14:16:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:46 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<ssuryaextr@gmail.com>
Subject: [PATCH net v2 05/17] selftests: forwarding: Set default IPv6 traceroute utility
Date: Tue, 8 Aug 2023 17:14:51 +0300
Message-ID: <20230808141503.4060661-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: c365bda2-aeaf-413b-3989-08db9819ff8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IJ3UFBzkWY9SiVbzvVuRg1UXqv4++/48+6KnZKkPz2whPIDE4HgfRnbh46M1czVeB/AeQ+Sv8JC7VuE1SSWjVcaKGBf7eBgLrLKaV11xcdDkBiH6RMt3fBWu/xhVSVCRTzRNOjdw6nsA8sT2eliHZ4ofNxDyoFJZpSRADROBRfZUORcuBj0Y9SMNRdQfG2jWnuA0x/U1GkcfDXnAAp9dc1QcCXmtjFntw4iSFuD6wgTRwcc89XxxBiWtUVphRVClB09osqjXJROBj7MtXYEGVL5193qxhz4ORlpw91AKVEnjBenNHtn5JTB1heyjpXTwp+i7vqU8k4QLfrNijJSrSmvmakTKGwIJV2YtCdzfYjQc55Vx+ywJTjZ3upiIVzozlo6GmkKXIxijJYF5mjlQxOZFIhyasQGBIyUK3zIjsVGgcZNdL967eXlNrwAQ+9fDpP00Tf3t0hXh83YEWKiQvwZu7I/VBbtirbEOKD3ijc/qCGgq2sAjYd4fr4Vr15Li+Q/W4bRCKfQBka66lTSLE3eYchfxphXxy+pYouMiLJzKg68bv0IfFuw+q2JdW9YwaDRXCKYNXy51LlmDXohSBtfXeoqD4yHi1ra6lhEQy5PGyEP6McBAH1J7OolWM4A+5gxEFaRCUHEMVC2sWuJYChG8gq69B15nLluRLc2vBWNeT6z3WxtQOkH7GRP4DzcycG2RUt1y7CYYbWe6vf3Hg79U8pc4HRiNd0FghvfGTE5+Gl95aGKpverf1tt2j0hYkYMCPd7RjkFSFsevXp7Lig==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(186006)(1800799003)(82310400008)(46966006)(36840700001)(40470700004)(7636003)(40480700001)(2616005)(40460700003)(82740400003)(86362001)(478600001)(356005)(26005)(1076003)(36756003)(41300700001)(966005)(5660300002)(316002)(8676002)(4326008)(6916009)(70586007)(16526019)(70206006)(54906003)(2906002)(336012)(8936002)(6666004)(83380400001)(47076005)(36860700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:03.0972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c365bda2-aeaf-413b-3989-08db9819ff8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test uses the 'TROUTE6' environment variable to encode the name of
the IPv6 traceroute utility. By default (without a configuration file),
this variable is not set, resulting in failures:

 # ./ip6_forward_instats_vrf.sh
 TEST: ping6                                                         [ OK ]
 TEST: Ip6InTooBigErrors                                             [ OK ]
 TEST: Ip6InHdrErrors                                                [FAIL]
 TEST: Ip6InAddrErrors                                               [ OK ]
 TEST: Ip6InDiscards                                                 [ OK ]

Fix by setting a default utility name and skip the test if the utility
is not present.

Fixes: 0857d6f8c759 ("ipv6: When forwarding count rx stats on the orig netdev")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
Cc: ssuryaextr@gmail.com
---
 .../testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh | 2 ++
 tools/testing/selftests/net/forwarding/lib.sh                   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
index 9f5b3e2e5e95..49fa94b53a1c 100755
--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -14,6 +14,8 @@ ALL_TESTS="
 NUM_NETIFS=4
 source lib.sh
 
+require_command $TROUTE6
+
 h1_create()
 {
 	simple_if_init $h1 2001:1:1::2/64
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 975fc5168c63..40a8c1541b7f 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
 REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+TROUTE6=${TROUTE6:=traceroute6}
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
-- 
2.40.1


