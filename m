Return-Path: <netdev+bounces-25292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D857773B23
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E76D1C2101A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2E134C9;
	Tue,  8 Aug 2023 15:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30373134B0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93B449E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgMPz7hV/+goxxrbkx8OrWCSNxqM4OuwweOuApq9kR7Pe7IteXOTM50kI8oGfieAUx2JrogPK9yw56Ea0qhe9VNLChQRsCSlq1YfRo4fP6scVws7ifSFvLhKK92PBIy2+6H+gUcBOE87PKrYKWZEtMcuzXz8Btn+KHUsjNRejkSSiX7jR9Rw6Nx6tflFZVpUxqyaDPcznY8iZ1AV5q94iMYi5YjCX2e+IChjjhKAfirpmS/24OtpAUQNCS7/rcpDanfc1gjV7aFdddqdAeYJR2ne1eCTyVhgter04u733e4UNfpVM+ILsc0EgDgBcuSbOUx/yy7TrxbDbWSY4Q3reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5VkkkC0kHYsz2qYN8awxYx/iCwrIFevc/I5jcGXBVw=;
 b=GM5KvkAg5oIKR5Fm/cAXSrvIt8/s8EINvbCQV9yvuZbtgbKMKLcpBhwcnu5A6QivoTzCNSaZ/45cU5jYK6hUiPkdpEc7X0GycFVq5zR/uYydMEQQgOvcUfrxjb52mYgnvKfpXFsg6SfnT1RPpoOQfrGHSjFdsZ77Aw4jwEa4fhNvHnp5G9eKp2MxMmxc5lKZg4SZVf7SE9bABACC9LLbUhchdMpt2+RKXohjus0KtpPHMvsX9Bac0BgquXqepBymS7H4qBgX9bAkMjSyOzQGCQ/vd3AjbnoUDXyetZWV8S+OzZRmSg3j14i4PBI43bxI1VbviWE3B76CUptsKbebYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5VkkkC0kHYsz2qYN8awxYx/iCwrIFevc/I5jcGXBVw=;
 b=QxU/VCnFP4qsj7kYRg3q7t824ldn9wnwPkudqCUhmqhV6qjBbnb7dqgHlq+mL3DiEq1OB5/TNzkrc2tw4/2bvrea426+sbisiIu1yHVId1pIjJtT7uhKb7I3p/VCfMcxzcSlH88OueyjzCA6vgRswLmBpsvjzdVe+QjnaEhTRS2OuHzYAVfcYbRnm4DOR4MBYj0LP5GbMKwCyOcJ1tvcbyGwe9/2xRqPY7J0q5Lspg0MkDLNxznIWIzfCIAOFG7w5X5LYKOQ1jCONLvK6l7IODGxI1R1jOK55496ISJheQOA+uLao2m5lE6rzG76dGlz9JpVT3UcYA28DPplyb0fVg==
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:18:49 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::bc) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 13:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 13:18:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 06:18:41 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 06:18:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/2] mlxsw: Set port STP state on bridge enslavement
Date: Tue, 8 Aug 2023 15:18:14 +0200
Message-ID: <cover.1691498735.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 18656efb-c01a-43bb-817a-08db981200b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ufnx2QE51tA3v6VKN8XnHRKJG+wUhCfHOAW6OdBuPLKrGloBt9LEFwxwFQoAB6pv6FStk2ETNihHxuwG1Il78GWwRKnf21mwdCdp91OxILgn5/pDEc4qlV1zS80of/DGzyCAgwp/n3d53I7XOAgwaA6u62pwUZWrEigoYerrXL72YPr8ZCQZfdjNrnqszYR3iyIR0Dagt7vuXeupfcJ5O1L44ajZiqB2KG2J7dcO72KYkvQY0xv9vIB0bfY8fFlLB52RX4BWft9EbYpiThcqIZx3eJ7MuyNG4GUgM8jWvw/+Z4OAGR+XvWVwvUKRvUNhSSruWys18uwKUmr9R+BhHGz9l5q6uj1ZJBZPa5wYpqHBwayz9T4HcjOC+F3UQyu5zQ0h5grD1Ili6PzACAc00tmbHwSKTiSK+N0nx/eej+8i9pzy5r6kAMNoeb/IEFVNffhPE6sFn59AUXf194Lt/H8QY8pZxMnXXxtrPBXbUsw3ti2r8XYlKbbxa3RJhcBC6D53vOdwOLwpVcREs9bEQiglxD5Es/z09U13Yke8KCmiWwfhOy6xt0QGCSl7yz449CpwkJoZvjHDwmfp7hDOGpqHIoD80Ky5WbAp2lynFMTclcHbq4i2HQ2W1nrIWFhCU/kgxGvczEsd5S4G9UbeqToKRiY/+zdC0pyvNs9x5+YQja27UWQKvpzgD8e0ViIw8AGc7lB/jeeHtM1lYU/WuOrsZi1A1vBVf21jJ16dVzNqkb/Gx56CJzz4sKCQRotr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400008)(186006)(451199021)(1800799003)(46966006)(40470700004)(36840700001)(356005)(82740400003)(7636003)(41300700001)(316002)(70586007)(4326008)(70206006)(86362001)(2616005)(426003)(66574015)(47076005)(83380400001)(36860700001)(2906002)(5660300002)(478600001)(110136005)(54906003)(107886003)(40460700003)(16526019)(336012)(26005)(36756003)(8936002)(8676002)(40480700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:18:49.0354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18656efb-c01a-43bb-817a-08db981200b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the first port joins a LAG that already has a bridge upper, an
instance of struct mlxsw_sp_bridge_port is created for the LAG to keep
track of it as a bridge port. The bridge_port's STP state is initialized to
BR_STATE_DISABLED. This made sense previously, because mlxsw would only
ever allow a port to join a LAG if the LAG had no uppers. Thus if a
bridge_port was instantiated, it must have been because the LAG as such is
joining a bridge, and the STP state is correspondingly disabled.

However as of commit 2c5ffe8d7226 ("mlxsw: spectrum: Permit enslavement to
netdevices with uppers"), mlxsw allows a port to join a LAG that is already
a member of a bridge. The STP state may be different than disabled in that
case. Initialize it properly by querying the actual state.

This bug may cause an issue as traffic on ports attached to a bridged LAG
gets dropped on ingress with discard_ingress_general counter bumped.

The above fix in patch #1. Patch #2 contains a selftest that would
sporadically reproduce the issue.

Petr Machata (2):
  mlxsw: Set port STP state on bridge enslavement
  selftests: mlxsw: router_bridge_lag: Add a new selftest

 .../mellanox/mlxsw/spectrum_switchdev.c       |  2 +-
 .../drivers/net/mlxsw/router_bridge_lag.sh    | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh

-- 
2.41.0


