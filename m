Return-Path: <netdev+bounces-59931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DE81CB13
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E801C223F6
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4D210F2;
	Fri, 22 Dec 2023 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xvpx6XuX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDD1CA86
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv445gbQyOIxi1wPACkLVTsHn3P3R3henlYKNVVgaulEaYqxmTYkyJfjoJRnLZbJZCD99KX7CxowKSJ/SLWRAmtQsEQOGEBvOjPI35DzIkwnN8Y448LmVlgFcAV3v6315MW6X+dzB3YRIfFvuFiQC06KRBNADdVfjXv+te4a6a7xWocxq1yYkgrOpxJHuD9S2ZTmfhQWxe2g9BQWdJDfqiugxSzdDLz2aKkSrvUKkilhdvti6K96fxg2T1nYbKDPMMogAxEIsGBgjhscvD+helRn8sALTNeEPGtK1ZHXFOfxiA2EgykZn+Fxvj/clKhB/Q5NlbSrRsMsz6vfgnYm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/qYEPgXrwgHYPkKe/k8+mcKGGQOM7/A/fIp9XtJ6M8=;
 b=gaxLarTYZoVOYYiV1oKMuqXhjwfvK+/gp/R2DZVK1BciqHTKNF+LhQSJPpj7T0utHHTy+m22T6y/zfRkPFNTwdI2AysfEgAt61BU6R6dfDqYPsQdup1yp1z8I5q+vFcb2wcpGk8j/8g/WTqaUKjFlvy3iacVBajCbhavFS++jip2S4i53ml+e+VdX4G+FCQa5cj9Zpb9Aim6LJv6MmTOAt7+iEt3YKHmxzdelPrzFVRKVwibkHAcoowEw1ABm4W1TJ2q28L/YPdhs0UDC2ozouMZlD/Zl5zrgecWrFh+TSqKAcUBJ+3bglOlny4THnuS6UbZiJg2XeBaUhM6SJxzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/qYEPgXrwgHYPkKe/k8+mcKGGQOM7/A/fIp9XtJ6M8=;
 b=Xvpx6XuXAPytPtViNNqk+Y/zwUb+KK/iLPzE0AnL1tuK2ZLUxuXsC5kKEiv3nzIrH+jrI8YnsJYDjYeXj38l0P1F1VeteTMPFHWPtlk4nmhOAWuRD1QN7EQs69z58yR1RiZWUNr4JmMiPtTY1YosvKRFhJY7RpGogbONvSCP9Tb8tJD9CjW2AIuCc0YAQMXgkX47I8wTT3i7FhU+JkUhT4FD0T9OsDFMoxzp/3RRewzFcPaRRIAmeQ4VpRHXwOZHGoD07wt3Zw+H3V5jEyOhBr5BM6Eq+qRxEi0VtRQT7V5veKuw1P8ly/MYFz7trGSrNxwg3AqYnwMYUmFyvOHNhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:18 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:18 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 10/10] selftests: dsa: Replace symlinks by wrapper script
Date: Fri, 22 Dec 2023 08:58:36 -0500
Message-ID: <20231222135836.992841-11-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::29) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d29428-87f1-4419-ec75-08dc02f65451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A4D07CGMfMy+Q6Q+8XQknW1C0ntIsTyTr1O1k9og8gvqo1HUlAdhdvZ+CL/IW1hBWyGbFXHaPUllwj42GAGVr0yU1cPI+ZphRaxzCnUF+sczr/s0POxowdJeEhD1YWYE0Gim76zf4AqrRxm9v11Uhm9BXu5qxqPIaJnIkE3IdMZbAm2kAXpNZIqAFU9pKhrDyj5hVJe6g1QNVJTzSpZq6M/CmhtgwJ42NBI+CoO45IQ0X9VkDVrIFuA4Tie5LajO+35ERvd8TWBglskqUdMSqo2hRhjcQ1ur5Cc5CRU3rkvJmVfPKIcHtPHIPEwlS1HZmJAssIWmssFDivxi7UoPuP8wqYEKsgaKeMULEqAfH4OnlLL+RNeY7jtOZq9TJENfcTbeeHvSoVys2KzRyrBdDrRPH3zk5TPeSvuzvECoiWeNlHWgP4/KhvwfXZxp/z+lcGJYbS+7Dty0hjk/nhHcVqS6odlIXG092707w6d4+CyzCR5mrnpDLO9TsAzumlv4Gx6Rn2hcHLRuwhncInkoR0/8td5hffqXCwt+QvjSJ7p+OXW/ZTDXjFufE+VHbIRc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(2906002)(5660300002)(30864003)(478600001)(6506007)(6666004)(6512007)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(6486002)(41300700001)(38100700002)(83380400001)(36756003)(26005)(2616005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPM5MiBO2kMm5n/OqYvP6zYfoY1Vh0Xc4dFfcnGeHVBa7XYoyZMwDtGSwvHt?=
 =?us-ascii?Q?QPLy/lLkSk5eSpRLWc+JUZiv+S8fjLmzp5omOoVd1mb61eivnqfU7HQN1IGM?=
 =?us-ascii?Q?B3Iy4ZkbloOY8SPl3BzZ30pMhHuDk2nngN/d+jK2naE5A7cdu/bfqX1YHBfL?=
 =?us-ascii?Q?JEh62JkDzjw3DTFEbkutLYe0rwCEbOP2TpyC4k++ZYRpowoZ9rpUJxk5aUKq?=
 =?us-ascii?Q?JRpv2Kzl8amIwTfyoAC/2Z0+aCxMQbE1yJTiSZLxubgiY2KACkemCaYPQaWU?=
 =?us-ascii?Q?oWFlwRUDqwuU2b/B0p9pXENICQNiC8Ubca6Xipp2Ve6msPDL2Z+oJv+3VPvi?=
 =?us-ascii?Q?BYB00ixigFMP668XnqgpY3e+L7x2xOP2FuH+8sAW8ogr2UGsmnfV/rlyZcpv?=
 =?us-ascii?Q?G4y34JJAkv0zfTU0Si7d2OXaqTjwgIsyQc7K4rRfiZieIrCz5sSpam/Owhsi?=
 =?us-ascii?Q?uR5GOmfSB6yiKT5WTO0qCGTylnX5jZfFtzBt8DR3jduUUOI/+UjHTHkJDSQo?=
 =?us-ascii?Q?HZ1QZJUgWAfbK1/iU1qUgXzjb+S7Yc8QoRHXe4KMDOZwWQsrLPZohZyulv0R?=
 =?us-ascii?Q?D6L9l7ojRLSWzMwvyeZrLEM0CB6Rsw4hIn3GpkMjNs4icKQZxX4zwvpeqgkC?=
 =?us-ascii?Q?Q7Dy6wy0AfSrcVKfPUzWYogal/ywh/InS939568/QBtjEMCJdelXIOoaqFOH?=
 =?us-ascii?Q?OwlTLSX5yFyKDW7au4Q+s0JXfENBextpMu8n2gcCBx95XPqhIStPbCfxvTaN?=
 =?us-ascii?Q?ZlZ0CNnTwYJiqPEbM7EksaKRXSJ5N2I6KBYr740SApDI8lz1khGtSKBx6ZDJ?=
 =?us-ascii?Q?DRMBX2REqRcAoGYhBWQuvBktFuPSE2ynthdf7IsfC6jRW8rR5hBOXPcUYTtI?=
 =?us-ascii?Q?rjNKwkm9kX01JsFMuYeWDXnXCo2LL1lRAFrbnKf49N8FW09j8tD8aWZUQHpV?=
 =?us-ascii?Q?9HkNCT/5kblJuS6PIEwbvgo1FLjvCLUX+Vn9IVO0fm/8WfJochAvWBs1N6x6?=
 =?us-ascii?Q?UbX0AeG6G0O0efOODAqSAARjdtuv5oxtUJUlmQ4Xr00A6Eh8YWXNymjRAsxn?=
 =?us-ascii?Q?WtrhaVnhKwMUF25kiJPVhTt+fHn0i/loVG9IsyywSvHopW2lPJr3QIKj3lzH?=
 =?us-ascii?Q?X0+bXxQMsZc3+d8M7/jQ2MNI1I+PddaAxTvl0+BJsVX/UwaCTsJ+3jv0v1yu?=
 =?us-ascii?Q?g0ownM9mBDH+lgc5bJzrTPbqUyAyGpDgzJK9VKonju2NM5qWnc1WYg2Uy9gb?=
 =?us-ascii?Q?9jEVLp3IMXy2PAW0yN8czm1FRHhIlYOZHOACInHPsqLEf/4EK8/rzAWUSRK+?=
 =?us-ascii?Q?degdx/8g1pKvAHTlqS+eHSXIBtwKDWVwUPe419fmNxElQMfFf5EwyB/flETd?=
 =?us-ascii?Q?iDza38QNfrMHEHq6/2GBydsTun0FjXaZUIXpV2BXLMCq6fzZhC3VhJhDojVA?=
 =?us-ascii?Q?dGbhhWYvkJPfHYLFIoWDajusaGu7QvDFUdNjgrvsKTxlmfdDVbhh6YomZEFi?=
 =?us-ascii?Q?esiNVe7jHVHF21rRooF/6trpYuyHzAS2YFBY8aD786+nW8SRPrZj1mX1q5LP?=
 =?us-ascii?Q?LvxyEOAzS5NF+KtGUwgx77Y2/6qLjP9lzweW9jsdzvstVZF86r1NafeMt5YE?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d29428-87f1-4419-ec75-08dc02f65451
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:18.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5lnAsSYWcSC8ve6bHzPS0msnMNnd+v4pDIruZLc0AnFOmkkyKd/Gimkk5lf4D0mOUlGZMU90GavxgFiOkPSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849

Since commit 25ae948b4478 ("selftests/net: add lib.sh"), when exporting the
dsa tests and running them, the tests which import net/forwarding/lib.sh
(via the lib.sh symlink) fail to import net/lib.sh. This is especially a
problem for the tc_actions.sh test which uses `busywait` from net/lib.sh:

$ make install TARGETS="drivers/net/dsa"
$ cd kselftest_install/drivers/net/dsa
$ ./tc_actions.sh veth{0..3}
lib.sh: line 38: /src/linux/tools/testing/selftests/kselftest_install/drivers/net/dsa/../lib.sh: No such file or directory
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: gact drop and ok (skip_hw)                                    [FAIL]
        Packet was not dropped
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: mirred egress flower redirect (skip_hw)                       [FAIL]
        Did not match incoming redirect packet
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: mirred egress flower mirror (skip_hw)                         [FAIL]
        Did not match incoming mirror packet
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: mirred egress matchall mirror (skip_hw)                       [FAIL]
        Did not match incoming mirror packet
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: mirred_egress_to_ingress (skip_hw)                            [FAIL]
        didn't mirror first packet
tc_common.sh: line 15: busywait: command not found
tc_common.sh: line 15: busywait: command not found
TEST: mirred_egress_to_ingress_tcp (skip_hw)                        [FAIL]
        didn't mirred redirect ICMP
INFO: Could not test offloaded functionality

(I manually created the veth interfaces just to demonstrate running the
test.)

The dsa tests which are symlinks of tests from net/forwarding/ (like
tc_actions.sh) become regular files after export (because `rsync
--copy-unsafe-links` is used) and expect to source lib.sh
(net/forwarding/lib.sh) from the same directory. That lib.sh then expects
to source net/lib.sh from the parent directory but this does not work
because net/lib.sh is not present under drivers/net/.

Since the tests in net/forwarding/ are not meant to be copied and run from
another directory, the failure to source net/lib.sh is solved by replacing
the test symlinks by a wrapper script which runs the original tests under
net/forwarding/. The links to shared library scripts can then be removed
and all the files needed from parent directories are added to
TEST_INCLUDES.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../testing/selftests/drivers/net/dsa/Makefile | 18 ++++++++++++++++--
 .../drivers/net/dsa/bridge_locked_port.sh      |  2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh    |  2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh    |  2 +-
 .../drivers/net/dsa/bridge_vlan_aware.sh       |  2 +-
 .../drivers/net/dsa/bridge_vlan_mcast.sh       |  2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh     |  2 +-
 tools/testing/selftests/drivers/net/dsa/lib.sh |  1 -
 .../drivers/net/dsa/local_termination.sh       |  2 +-
 .../selftests/drivers/net/dsa/no_forwarding.sh |  2 +-
 .../drivers/net/dsa/run_net_forwarding_test.sh |  9 +++++++++
 .../selftests/drivers/net/dsa/tc_actions.sh    |  2 +-
 .../selftests/drivers/net/dsa/tc_common.sh     |  1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh  |  2 +-
 14 files changed, 35 insertions(+), 14 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh

diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index c393e7b73805..8259eac80c3b 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -11,8 +11,22 @@ TEST_PROGS = bridge_locked_port.sh \
 	tc_actions.sh \
 	test_bridge_fdb_stress.sh
 
-TEST_PROGS_EXTENDED := lib.sh tc_common.sh
+TEST_FILES := \
+	run_net_forwarding_test.sh \
+	forwarding.config
 
-TEST_FILES := forwarding.config
+TEST_INCLUDES := \
+	net/forwarding/bridge_locked_port.sh \
+	net/forwarding/bridge_mdb.sh \
+	net/forwarding/bridge_mld.sh \
+	net/forwarding/bridge_vlan_aware.sh \
+	net/forwarding/bridge_vlan_mcast.sh \
+	net/forwarding/bridge_vlan_unaware.sh \
+	net/forwarding/lib.sh \
+	net/forwarding/local_termination.sh \
+	net/forwarding/no_forwarding.sh \
+	net/forwarding/tc_actions.sh \
+	net/forwarding/tc_common.sh \
+	net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh b/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
index f5eb940c4c7c..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_locked_port.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh b/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
index 76492da525f7..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_mdb.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh b/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
index 81a7e0df0474..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_mld.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
index 9831ed74376a..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_aware.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
index 7f3c3f0bf719..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_mcast.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
index bf1a57e6bde1..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_unaware.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/lib.sh b/tools/testing/selftests/drivers/net/dsa/lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/dsa/lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/local_termination.sh b/tools/testing/selftests/drivers/net/dsa/local_termination.sh
index c08166f84501..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/local_termination.sh
+++ b/tools/testing/selftests/drivers/net/dsa/local_termination.sh
@@ -1 +1 @@
-../../../net/forwarding/local_termination.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh b/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
index b9757466bc97..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
+++ b/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
@@ -1 +1 @@
-../../../net/forwarding/no_forwarding.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
new file mode 100755
index 000000000000..4106c0a102ea
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+testname=$(basename "${BASH_SOURCE[0]}")
+
+source "$libdir"/forwarding.config
+cd "$libdir"/../../../net/forwarding/ || exit 1
+source "./$testname" "$@"
diff --git a/tools/testing/selftests/drivers/net/dsa/tc_actions.sh b/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
index 306213d9430e..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
+++ b/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
@@ -1 +1 @@
-../../../net/forwarding/tc_actions.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/tc_common.sh b/tools/testing/selftests/drivers/net/dsa/tc_common.sh
deleted file mode 120000
index bc3465bdc36b..000000000000
--- a/tools/testing/selftests/drivers/net/dsa/tc_common.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/tc_common.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
index 92acab83fbe2..74682151d04d 100755
--- a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
+++ b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
@@ -19,7 +19,7 @@ REQUIRE_JQ="no"
 REQUIRE_MZ="no"
 NETIF_CREATE="no"
 lib_dir=$(dirname "$0")
-source "$lib_dir"/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 cleanup() {
 	echo "Cleaning up"
-- 
2.43.0


