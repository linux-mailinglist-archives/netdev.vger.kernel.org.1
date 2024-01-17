Return-Path: <netdev+bounces-63969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53F830917
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1089D1F26487
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D920DD9;
	Wed, 17 Jan 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZwAP+IP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55D20DD0
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503915; cv=fail; b=XGjAS/UC7WSUvZvOyMfbK5aqXy7J3ssRCY3kkhEpN6kOMeSPwFQUw7XHHXp7dX4SwYXH9/KaJMrGBwckwGxttDM3m9+PBuz747Y1805bjI+oAp7Ptp8K1VrBJ3VNaFd5SZmuismREyOF+KROvJmmTiRdYhQQo3E6DJxjknoWAVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503915; c=relaxed/simple;
	bh=ZNRfpCHMcvXBHMLnQ3GVOyHqJol1qYEPL8dT0lqnWkQ=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=TVBPrJGEbSufIPUMLuF/0aFwm0in5vO8gRfKjstvtVkY+Z0oOA4vLgSoFvnSTmMF1DxNQXC2Z2tn1hkJ+apa7UeDv1VWLzAbiCS1aSfE4mhTDyc5V9Zc8emQXxXXt50h5W2I1w8RPktJkLJVoZuTZcIYorgPzQUVMGjm7tDE7ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZwAP+IP; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGYKIbwna4fNQdMHFFdiRvcC39S96fuiFIs3vEBt8wZRJubXn3ezZ150zwgt1XwLfsmAhnXzkC+vGXBH2i9ZLHctbVVRxzjfdM7ZT5ndi1pnQ7KbD31Rp61q8yJMhN0XUB4nnT6YzXwfMJz3xN2hYRsE+t/1MI7E55k7yqV8pQlZ2isVYgFHASuo94fDKy9v7sctwCzljRuqzOAOW768825K3F/YoYL8RkhubjEswmDFKBWbclaD93QbInuxQ3KkHMqlkEXEoXpK/5DLLuGEeQ2eHB4wIUM0rYFDjhIx3KM+ohTOtMofHkAhz6oPyLm7jS8zK47EX2aBAl04fnPPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGlP82V/d32NkOOVbQKjyi2+WMb7fsa2k3qbU0PD9CM=;
 b=EMv/x9+rWL1mbP6WvVq+u0ar5HopY5qI0yHc3PUHSzhw5FU83bKxGbDJ1ohvi0o5cZ9JA1EkAfyZL3I3beIKwAOI4iFRVwukKBK0WbaZBc595uJlhkbqeflcLFRdus3Ah8aomH+fz/dEKLjVGOYBAoHpAdqosJ00bg0rBpanszqY6vyqDoFgHERQw8lXZKU6mO0Qy9KFCaBlhg+A+CNFImnTrM/idskqoPAfh6Etpa/ww9KqB1SOLS+oy8cbcK+0xsydxTLVmCLu8PLFxotFntPLLPnyTWUY7qB0Ru8XUbKWmLItAqOpa4NRSDIly6d7qsg48Ykm1qiHMpGDFVCo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGlP82V/d32NkOOVbQKjyi2+WMb7fsa2k3qbU0PD9CM=;
 b=AZwAP+IPMD8XWzHnz1WVMNh3WE1RHblm9QpHjUVHKCj5ThQYjFD9FuMF6Yhq5V1E+WOCqFlKB7q/Dd/7UD+fGEoufDD7gGYcphHtKEFkUj1RYcf9UVA3R+ar2CTVJfVcB3DRqvfS+1p8y7AG3nE3na+lASh8Xs3Z5YpALOAcLJBKwTgNZ8Aw4kbTxXc6oUUhTXpexzVhczuB6miZdmZfSDz3PxKBWlPDnnmtO1uc735Mfd/QI+yMidVDnXbIF7zROWWlMLRHKR7HnEgkjH0oAN7nNEJZrmMzeaZ11aPPWyHM8obPdFTOakzmOBQhFP2RKemYOO/BGM7Mci87mPhFUQ==
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:05:08 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::a7) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:04:52 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:04:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>
Subject: [PATCH net 1/6] mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
Date: Wed, 17 Jan 2024 16:04:16 +0100
Message-ID: <4cfca254dfc0e5d283974801a24371c7b6db5989.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ec9606-a21c-4196-08a3-08dc176db075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WCUHHLEN16hADcWJiKlezH7bVnLDg8Au5rRrEg7F1NN0n3gTuQtRq79am9fofl8s3E9uOEg+LVdFLFTtc/myNMLRDnNq4LmhpFZYuefQy8KVA+oISor0B7FIZiU3KyiHrAZtUNs05g8iabWRW2tTUyS5lMSVks9F0/bD+2xfvdsOs0qWzpwqmCkDzLVSyYq2Ibf9St19iKPq8h59w6ugj1vwaLVimHmtUw0E+k8gYLU/xOxB8tCPxkLUhppBPi9uRKeIvijfXjA18pGD3V5c6kJgX/Q9THXsjqO3SQUQ+XQL3B1mszb8Dhn6BKJl9Lpex3Rq/1FDPS/5OuuGh2D1+FH2GPwxgY0VKfSufovm1MiAQ6bpotNauVqiA7INdIexB7gY7MI6Dd9lMn+7IRzRMDfLsI7LF5RmK99GIJdjIXiRNkIDyYQv9DtEzjs6VsDqndSlVw+i8q6H0dbPyeST0b1GU3td17dE8trWoLx/fZ9tEBW/XJZ6iWbzN3HGB6Gl1ZuQa5ZtpOTn2wqp8XIFH1BL1DmdfPgd5wMmHmRfLG6bIMhQW6nCGeBkBnudyESt9fkgEv7CwpMDlJp/+WqJRfBjAZ+db8/5SbvW9GdtK33rmgJmH9Gwfls7VgD9YvvKW50yEC4KzogRat2LrH9q4UraMIxroQcOPedoWHA7ZKxFmv7At/p6ZyS1h0lxTYEo/Ehg0OGB72v835QKYn9i5yAi+Q9Vf4Z6SMp/kio8pNNTAqyOF1RjqHgnfItUQSqR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(26005)(6666004)(16526019)(2616005)(107886003)(336012)(7696005)(426003)(36860700001)(83380400001)(47076005)(5660300002)(4326008)(2906002)(8936002)(8676002)(41300700001)(478600001)(316002)(70586007)(110136005)(54906003)(70206006)(36756003)(86362001)(356005)(7636003)(82740400003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:05.8008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ec9606-a21c-4196-08a3-08dc176db075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482

From: Amit Cohen <amcohen@nvidia.com>

Lately, a bug was found when many TC filters are added - at some point,
several bugs are printed to dmesg [1] and the switch is crashed with
segmentation fault.

The issue starts when gen_pool_free() fails because of unexpected
behavior - a try to free memory which is already freed, this leads to BUG()
call which crashes the switch and makes many other bugs.

Trying to track down the unexpected behavior led to a bug in eRP code. The
function mlxsw_sp_acl_erp_table_alloc() gets a pointer to the allocated
index, sets the value and returns an error code. When gen_pool_alloc()
fails it returns address 0, we track it and return -ENOBUFS outside, BUT
the call for gen_pool_alloc() already override the index in erp_table
structure. This is a problem when such allocation is done as part of
table expansion. This is not a new table, which will not be used in case
of allocation failure. We try to expand eRP table and override the
current index (non-zero) with zero. Then, it leads to an unexpected
behavior when address 0 is freed twice. Note that address 0 is valid in
erp_table->base_index and indeed other tables use it.

gen_pool_alloc() fails in case that there is no space left in the
pre-allocated pool, in our case, the pool is limited to
ACL_MAX_ERPT_BANK_SIZE, which is read from hardware. When more than max
erp entries are required, we exceed the limit and return an error, this
error leads to "Failed to migrate vregion" print.

Fix this by changing erp_table->base_index only in case of a successful
allocation.

Add a test case for such a scenario. Without this fix it causes
segmentation fault:

$ TESTS="max_erp_entries_test" ./tc_flower.sh
./tc_flower.sh: line 988:  1560 Segmentation fault      tc filter del dev $h2 ingress chain $i protocol ip pref $i handle $j flower &>/dev/null

[1]:
kernel BUG at lib/genalloc.c:508!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 6 PID: 3531 Comm: tc Not tainted 6.7.0-rc5-custom-ga6893f479f5e #1
Hardware name: Mellanox Technologies Ltd. MSN4700/VMOD0010, BIOS 5.11 07/12/2021
RIP: 0010:gen_pool_free_owner+0xc9/0xe0
...
Call Trace:
 <TASK>
 __mlxsw_sp_acl_erp_table_other_dec+0x70/0xa0 [mlxsw_spectrum]
 mlxsw_sp_acl_erp_mask_destroy+0xf5/0x110 [mlxsw_spectrum]
 objagg_obj_root_destroy+0x18/0x80 [objagg]
 objagg_obj_destroy+0x12c/0x130 [objagg]
 mlxsw_sp_acl_erp_mask_put+0x37/0x50 [mlxsw_spectrum]
 mlxsw_sp_acl_ctcam_region_entry_remove+0x74/0xa0 [mlxsw_spectrum]
 mlxsw_sp_acl_ctcam_entry_del+0x1e/0x40 [mlxsw_spectrum]
 mlxsw_sp_acl_tcam_ventry_del+0x78/0xd0 [mlxsw_spectrum]
 mlxsw_sp_flower_destroy+0x4d/0x70 [mlxsw_spectrum]
 mlxsw_sp_flow_block_cb+0x73/0xb0 [mlxsw_spectrum]
 tc_setup_cb_destroy+0xc1/0x180
 fl_hw_destroy_filter+0x94/0xc0 [cls_flower]
 __fl_delete+0x1ac/0x1c0 [cls_flower]
 fl_destroy+0xc2/0x150 [cls_flower]
 tcf_proto_destroy+0x1a/0xa0
...
mlxsw_spectrum3 0000:07:00.0: Failed to migrate vregion
mlxsw_spectrum3 0000:07:00.0: Failed to migrate vregion

Fixes: f465261aa105 ("mlxsw: spectrum_acl: Implement common eRP core")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_acl_erp.c         |  8 +--
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 52 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index 4c98950380d5..d231f4d2888b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -301,6 +301,7 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 			     unsigned long *p_index)
 {
 	unsigned int num_rows, entry_size;
+	unsigned long index;
 
 	/* We only allow allocations of entire rows */
 	if (num_erps % erp_core->num_erp_banks != 0)
@@ -309,10 +310,11 @@ mlxsw_sp_acl_erp_table_alloc(struct mlxsw_sp_acl_erp_core *erp_core,
 	entry_size = erp_core->erpt_entries_size[region_type];
 	num_rows = num_erps / erp_core->num_erp_banks;
 
-	*p_index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
-	if (*p_index == 0)
+	index = gen_pool_alloc(erp_core->erp_tables, num_rows * entry_size);
+	if (!index)
 		return -ENOBUFS;
-	*p_index -= MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
+
+	*p_index = index - MLXSW_SP_ACL_ERP_GENALLOC_OFFSET;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index fb850e0ec837..7bf56ea161e3 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -10,7 +10,8 @@ lib_dir=$(dirname $0)/../../../../net/forwarding
 ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
-	bloom_simple_test bloom_complex_test bloom_delta_test"
+	bloom_simple_test bloom_complex_test bloom_delta_test \
+	max_erp_entries_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -983,6 +984,55 @@ bloom_delta_test()
 	log_test "bloom delta test ($tcflags)"
 }
 
+max_erp_entries_test()
+{
+	# The number of eRP entries is limited. Once the maximum number of eRPs
+	# has been reached, filters cannot be added. This test verifies that
+	# when this limit is reached, inserstion fails without crashing.
+
+	RET=0
+
+	local num_masks=32
+	local num_regions=15
+	local chain_failed
+	local mask_failed
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	for ((i=1; i < $num_regions; i++)); do
+		for ((j=$num_masks; j >= 0; j--)); do
+			tc filter add dev $h2 ingress chain $i protocol ip \
+				pref $i	handle $j flower $tcflags \
+				dst_ip 192.1.0.0/$j &> /dev/null
+			ret=$?
+
+			if [ $ret -ne 0 ]; then
+				chain_failed=$i
+				mask_failed=$j
+				break 2
+			fi
+		done
+	done
+
+	# We expect to exceed the maximum number of eRP entries, so that
+	# insertion eventually fails. Otherwise, the test should be adjusted to
+	# add more filters.
+	check_fail $ret "expected to exceed number of eRP entries"
+
+	for ((; i >= 1; i--)); do
+		for ((j=0; j <= $num_masks; j++)); do
+			tc filter del dev $h2 ingress chain $i protocol ip \
+				pref $i handle $j flower &> /dev/null
+		done
+	done
+
+	log_test "max eRP entries test ($tcflags). " \
+		"max chain $chain_failed, mask $mask_failed"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.42.0


