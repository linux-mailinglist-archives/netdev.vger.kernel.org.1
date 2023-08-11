Return-Path: <netdev+bounces-26833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EB77929A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA058282272
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434B29E1B;
	Fri, 11 Aug 2023 15:14:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDB63B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:14:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3B30C4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYiPy2qlLHcq+pYCQv498kqz+qtvygzuHION0E/tVNIfx1cyS+WcrFGudFE0hNdnM7uVsHpA/PxcOzkaFG0Yb892HFQpqRuO3aZFBY+dQ9HIiw4LthTofo9CzwYBIlFoNfHPelAbJqntmJESLBMWK3NSQ/swrUcPfKZSOenZ2s919uOPcggvC2gtFzpsak8Waz9xGegIssA87z7RTFIZLMWguy+6cJtAsx1dL2T/PkymfFSbsDkDDIP/UViy1087gKKIrIKFUcuDm37QxgQioobNKcV09DeSAO3ByHT8/ienGTYTUHeq71NNRFfA+21CPvTjswQjXpFGRB/5bkh1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0xN5cbSj78hccADOv0I9JajsJeFaaEdW5rCRERHF8I=;
 b=hCbdYmFTrFebPit1zgmTa38QMVu1Ne/lU6DJ9or6RjReCvhAMbygzuVfJ/sA2oFSL+VXxQgGXE6OqiHgzTjmM1XFeLWDgcfSNch7XLGFGuowO5xOe//mkRYU31wDN6hPOfvIBHvp09lj4KyzNadZAOgmSeEOykmC4d3WuvFkql5KqIRpunZqj2vuJggGoiqKFxh6dIBh6pCfjm0su4zovjlLwJOHu3uoWje5juKZan9PSU3gmkfOSJBaAKwX5ufZVWzB8t0B4OFOa4aaaHO+h7dYkS4kNBYOIBbaaaLJq+SLVGpT49fUWFuBbMwSt54QSxF1cxVyAHMh9mT2yWfiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0xN5cbSj78hccADOv0I9JajsJeFaaEdW5rCRERHF8I=;
 b=mVXI3XVBt8n0oh1kOzzk0k7MvtScG/WPPT4ibSspz202ZdhrxiPB9LYhlzAbh+PSeW7qpQW38h3n3/0nsgcCDfMjez+K6uW6oCTnSk2O2e9h23/h3aFqE4LXqET/6Zn61vXRwcJv234rhJHC6dmenMHV4BFO0Wd5PN3S9j+cj+/yM20+9wJroOaqW7XkuNOJ0bri9iHBa30UOaJkHpysGZmeGyzM5oUEBtVE2y9ixa/lRNwvrkdKJ2ucYzTIyN+8aLaR3x/90b8qfV22fgUt0P++ogEj2mLqUXTuLKskJR0LOXRR4XZFeXZ+ngHlwjexQvFAq6mXtWNRe7jtEQud/A==
Received: from CY5PR15CA0258.namprd15.prod.outlook.com (2603:10b6:930:66::29)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 15:14:31 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::fc) by CY5PR15CA0258.outlook.office365.com
 (2603:10b6:930:66::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:14:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:14:19 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:14:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/4] mlxsw: Support traffic redirection from a locked bridge port
Date: Fri, 11 Aug 2023 17:13:54 +0200
Message-ID: <cover.1691764353.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c91ab5-ddcb-40d9-411b-08db9a7da9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZASvpSDo8ab10npdo+2rmrV/z1Uh2PzJqpfuYs01WMq6cX45e2biATaNlyRW/OJjBDVhOALD/fMcCTR7fLnK7/wu3iJw67QG+DQRsiqhp0XTC2SvzaWs0fho+0DuR7FgqiukwLMuGrYJZ5PNT5Ll4SPLS/c3W7slEXdhAYncfg0A/F+fvbysXPU4bUKGL+JNz+8tR5voFkszsAMHZLbCwAMw9W4sjI5eNemW64XLttaOCmRptc1bHt2zJ/DirIU2QkBUFb0uRhEqfnn6q/BULN5nbqD1cWa6l2P72Y24N771dczgn+njKHD2fwS4sdZRttM1ApLHZDiH/szqQtL+pAtfKyKawEaiMJagaWe3gqPBmaWD9LKPITp4yUKjNhYzhQ4WY6NPnVSi/cv9yntSdJOp6V3KXwHKJT7fq728sLlvnoAVKkPq6YL9MhUa++ic1UhQziPHhP/oNi63wUdDUw0Z+XnToozOCd9p9/yvsZpmQtLBWmd1riuiS2Y3rJMePIcOKosCvoWE7LlAJBmam3DJq4QA9ZIFw29qPmOPjsweeWEtxFc53lQc92dp4BPZUSWFdJxPC+LUcxrPLIQX+3PRF7TyvSK1PzvKckTIHvW1ry3Uhu0Y8NrWqJt0OB/7mHwIGIipQMA2V8GQLwh67UubwOxq2z8hOAmT9cgaoh9chd6+vJeE72dSI6D5Ocpf4nHQmPPVGEyS71UIIw2HOuZYngjRxLgpWfQgAmoJqk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(1800799006)(82310400008)(186006)(451199021)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(70586007)(8676002)(41300700001)(8936002)(4326008)(70206006)(478600001)(36860700001)(6666004)(2616005)(107886003)(40460700003)(26005)(336012)(83380400001)(316002)(110136005)(54906003)(426003)(86362001)(40480700001)(47076005)(36756003)(7636003)(82740400003)(16526019)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:14:31.0403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c91ab5-ddcb-40d9-411b-08db9a7da9b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ido Schimmel writes:

It is possible to add a filter that redirects traffic from the ingress
of a bridge port that is locked (i.e., performs security / SMAC lookup)
and has learning enabled. For example:

 # ip link add name br0 type bridge
 # ip link set dev swp1 master br0
 # bridge link set dev swp1 learning on locked on mab on
 # tc qdisc add dev swp1 clsact
 # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw src_ip 192.0.2.1 action mirred egress redirect dev swp2

In the kernel's Rx path, this filter is evaluated before the Rx handler
of the bridge, which means that redirected traffic should not be
affected by bridge port configuration such as learning.

However, the hardware data path is a bit different and the redirect
action (FORWARDING_ACTION in hardware) merely attaches a pointer to the
packet, which is later used by the L2 lookup stage to understand how to
forward the packet. Between both stages - ingress ACL and L2 lookup -
learning and security lookup are performed, which means that redirected
traffic is affected by bridge port configuration, unlike in the kernel's
data path.

The learning discrepancy was handled in commit 577fa14d2100 ("mlxsw:
spectrum: Do not process learned records with a dummy FID") by simply
ignoring learning notifications generated by the redirected traffic. A
similar solution is not possible for the security / SMAC lookup since
- unlike learning - the CPU is not involved and packets that failed the
lookup are dropped by the device.

Instead, solve this by prepending the ignore action to the redirect
action and use it to instruct the device to disable both learning and
the security / SMAC lookup for redirected traffic.

Patch #1 adds the ignore action.

Patch #2 prepends the action to the redirect action in flower offload
code.

Patch #3 removes the workaround in commit 577fa14d2100 ("mlxsw:
spectrum: Do not process learned records with a dummy FID") since it is
no longer needed.

Patch #4 adds a test case.

Ido Schimmel (4):
  mlxsw: core_acl_flex_actions: Add IGNORE_ACTION
  mlxsw: spectrum_flower: Disable learning and security lookup when
    redirecting
  mlxsw: spectrum: Stop ignoring learning notifications from redirected
    traffic
  selftests: forwarding: Add test case for traffic redirection from a
    locked port

 .../mellanox/mlxsw/core_acl_flex_actions.c    | 40 +++++++++++++++++++
 .../mellanox/mlxsw/core_acl_flex_actions.h    |  2 +
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  4 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    |  9 +++++
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 10 -----
 .../ethernet/mellanox/mlxsw/spectrum_flower.c | 10 +++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  6 ---
 .../net/forwarding/bridge_locked_port.sh      | 36 +++++++++++++++++
 8 files changed, 100 insertions(+), 17 deletions(-)

-- 
2.41.0


