Return-Path: <netdev+bounces-23546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389076C77E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9753D1C21171
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A958853AD;
	Wed,  2 Aug 2023 07:52:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCF539E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0D3593
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqqIp9YJpd4HhhPuOb0/cIxhVpdLZYb5ogpYRRqd5TfuOVjNTgmBLbY7MmnDPdtWfrA7tnEgs6es+8NWQzsdyXJcOv4Ck08RRhq+xQO51g1LEKkHdskZZBQ05IFF2coN94sGVnK9O/WIy28xcre1kTgb46jFNjbx5LtHChUe0xOO+WcCwwPBNadP+u3pPSCrWx5fz1I1nRL67NfrJt15Q6kSGfrBQSAmeWa1z85C5ikrAbNfo7hBmkdhSTuZil850BCcXZdDyaOi9tqkoVF6OB4sfzhC/vnQmivkODDSOZdHyEyWxyMsWk7Xm5XOvWLc0lgBkxQDcSQUBY8RzM873w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwgRqpdSL/ICEN4nx078sfEVZjEKcVeEXYdn9IGtlZ4=;
 b=IiTq7OrPLkHY0CnaRCon7kgorGBMSaxWd2TygIG+Lf8CYcXo+9WObpkuzmBROaDo/BiS2NGjKXV4rQnIBqYkjc33pASSLan1eZF+cE8Klw+gXc27I3uofwuGQmNobPujkSxP/rCW0iICIZF561b6EGfRRrO2YM5bwalXcR3nDMqNjhUpHFN+ES+c+uKXAAzAxs/RxKXwy0WlLtoEfkBPtCa8ZFkQY6FGKhoLxSdPoSS621hQrAp+r6h3g0D55Xsd4qQT85jTMYqi+hXm8VS1dSi05w1lcJMe+Gqp2IErTxRKpQbJsxPZusM/FYbh6uoigJZTngmTNvPB/3UybmZIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwgRqpdSL/ICEN4nx078sfEVZjEKcVeEXYdn9IGtlZ4=;
 b=khrs6pX3lhmn47rop9IZ42tH7QhVYtno+9CoSe87VvmQV1pxi+XkXNdgUVWEDwFM9bIPtloD1kRpMfEwYr8ayED5OATc3WMbbqVjPPNno87bcTFO9mtvGdj0Co3oaRuiX8lqn7mnujmLKENK7oBua6pQs1P3ZmGeO53X9uho9Gm+57w9WltiiBiBHyVfS4srT0ytK8cW3X2fIgoL42LRUw/5QvBCuxNagkdqz6Wp4+WuLlmHJhmxKJWmjeyLbySAowLyaQh6BtO1gh/srZhNzC/bSs4/UmGpN1dqQw2aU+tXJzhiyFY5kdJYjS6/cMsfL+gpjirp4dVOCTDh+QsfLg==
Received: from CY5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:930:1e::17)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:38 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::1a) by CY5PR04CA0027.outlook.office365.com
 (2603:10b6:930:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:52:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:21 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:18 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 01/17] selftests: forwarding: Skip test when no interfaces are specified
Date: Wed, 2 Aug 2023 10:51:02 +0300
Message-ID: <20230802075118.409395-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 932d6379-867c-4b0b-573c-08db932d710b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AyFSl6B/ASMcl3neJN/Nm6/afoltK/GkoC1fU5AFwyPJ+lbkW/fs7rbcAM9LhtQYA4kvURo9Sh6wPyiFlEJSaF/bHX7tU9PGTPW23I+ooCTuD5Bij1DUhEs4uoS0eg+Aae14Fxn2NfDwURr6tOyL8GSTsf3RCaEWNXk016tviySrx2l4R4Ync6ZCsKIczT9JrfUJko9DDRQsQNiOjBzer6siBa1aHb5f1DSPBrnLDNlCydUzAQvDRhJzGLh7zwR7oLepUXiZ3ja6yBE1qb1IPpGv9SG2K/tiOmXq/QVG0rDW3nWLmghh+BEDbLALMLe1+dLhHNvjPuVd5j+uvC3m1zHsxa4CQkYOqWtevHARpgidpeVF2qug9HujMXLm3EVc5fRMeXzBs2AzFyYy+EzN3BDm6qDLJcm6v3K0VL/TKAlUmh3i3R+6Jt+Rwtq8YIoD15FWJOAAogDXu9Akn8/y1ba9F2UCUt5IGsOg+kJcz0U60ROKS9sXZxBRnd/fDi8AgxnzDCXqFqYFeRZsgJwSuEKJzqvTMsuiZO1X0c2UXgLJXozLGiYGt+bOxidKCuMMeZpnQQX96OwTLisVNP8JpGa6Qr0wiYWJcaiimMhNsO18QBkoNu2cBLmXIwhCnntH0GBiwK1XZv3epdeH3P5/jwO6eqmVtvPvtEKaSvB0MA6AbkncVG2+Qk8j0bPfHxqKpop2JOS8PZm26iGWXTRP+klS6YGRm7b9Cm0DRclCihu/G/Ut6TKDcWRmz1LjhfLFZce6tUjZZ/IOvNOsQLVqrg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(16526019)(40460700003)(2616005)(36756003)(966005)(316002)(86362001)(7636003)(478600001)(54906003)(70586007)(70206006)(6666004)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(107886003)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:38.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932d6379-867c-4b0b-573c-08db932d710b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As explained in [1], the forwarding selftests are meant to be run with
either physical loopbacks or veth pairs. The interfaces are expected to
be specified in a user-provided forwarding.config file or as command
line arguments. By default, this file is not present and the tests fail:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # Command line is not complete. Try option "help"
 # Failed to create netif
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # exit=1
 [...]

Fix by skipping a test if interfaces are not provided either via the
configuration file or command line arguments.

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # SKIP: Cannot create interface. Name not specified
 ok 1 selftests: net/forwarding: bridge_igmp.sh # SKIP

[1] tools/testing/selftests/net/forwarding/README

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9ddb68dd6a08..975fc5168c63 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -225,6 +225,11 @@ create_netif_veth()
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		local j=$((i+1))
 
+		if [ -z ${NETIFS[p$i]} ]; then
+			echo "SKIP: Cannot create interface. Name not specified"
+			exit $ksft_skip
+		fi
+
 		ip link show dev ${NETIFS[p$i]} &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			ip link add ${NETIFS[p$i]} type veth \
-- 
2.40.1


