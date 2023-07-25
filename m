Return-Path: <netdev+bounces-20833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F47761802
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D864D28183F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6B1F184;
	Tue, 25 Jul 2023 12:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5291F168
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:05:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93010E5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDoKdc533MLKTiREXH1F6sC+OXm2FwBDzmAm+FhjzIT0pBc1BU+LMSQMVl0FwPQ0rx2bKvk+jofxIBkIVctqWeMsw/11g8FHgaqBCRjPyCvC1vDGPsdILGb6pQ5zMJAsyxu1Ot8oCGrpiBPcYoXr6sgjeJaNPkhGnIU4qVlLAxIaH6qR4Ya4A0AWf9axkKc41onl9NwsEfGuw+7i1mM7saCTLRzLVgVCJ0/w6rJCOx/ar/HWlGCZWDaGWurpE7fl8wIYnsZCy7EwtOHd7JyxbewdqihCCZMvjOhsM44qh1/WzyCzX021pz8wJ3Dk5vUuQmCWQLAFd8WPNqp/ImU1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbhFeqqL+vur3SiZQKawWEVZ2V/ttWH1rNZHfXAYeO4=;
 b=UqRrui1kCIlj0wgqg2YV8oK8ZqKDaskYeDWJ2AL48pdNsRugu9IVmVa6YfxhLwC+JQYxYB/NDJ6kgeT0RKsFuKOq3tfU+JlZg/+g8Hs+I6wYoW8koyybhki3AAFk5szNHJEiio7580a/qA5qigWc0+xo5gd3UBrQEVuTHAge+s3t5JjXa2ioNNBc5lw9wwkgRWEPNM8jQEEv+VmCryFwCcRFaD57LnafWXeAlDAGWdwxuFj13DzOI7x3vdY8ukEX40v4qfUVvo3SyZPec0D25QdOUtrSlmVflcfF71B6F6hChvsoxyfpYC7lhya3hL1ODyjA2tCgWkODsdQnXdq1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbhFeqqL+vur3SiZQKawWEVZ2V/ttWH1rNZHfXAYeO4=;
 b=sa591VQvMj4Ej3M/ksVItIWx3Ajrvrw6TF2Ur89uRARDFZO79X+rfcvYs0A/c638vRLQHkyf+6Aqy1prhRY5E5wfwPl7MJkOkMk3rwnu31WLnqCkp4qDpVc6DUilO9z6oeHmG7s9MQT8j/sfZ2NqJNTN5SQo3gTO4w1CPMRfRTAaCTnsLKvyHMqXq5+wyVPwO6I77Tk/daaWOkR5PaE0UXOG1eVB+HD2q7GfAN2bHsqLTHGSsM6Gn0VPOmpR+xOnzcoBCOSvAHC9fyq4kerO4zSGtVwGtfaIQSVSrDuSh+lZLuH2JgljlhsOw28u8yer5ucRpVXNAS13Ebrn/MWpbQ==
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 12:05:40 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::4) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 12:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 12:05:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 05:05:26 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 05:05:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/5] mlxsw: reg: Increase Management Cable Info Access Register length
Date: Tue, 25 Jul 2023 14:04:04 +0200
Message-ID: <ba5c0f631e2cfd61bd21218d0cbfe03fbfe521f9.1690281940.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690281940.git.petrm@nvidia.com>
References: <cover.1690281940.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: cba6e5e7-cd43-44d9-f377-08db8d0776fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KPkWyCHGNEKEYOILofToKDRnaxnc3fCTpiNoQlCboqJPbv3H5/J2xPfEp0qrZ6R0GOOIA2IjmPBPcrhYueXyp76qpEODAM1jX6n1vX0+C7laWtRFvgUif1oIQt63k0g8pQyByihRPafXmVd/VswfFpkJVWlNOPkwLipbd90WYN0DcG7lijBmFZVZybnp1927/jtl1DGRfEFaJdnxV9yvX2GsoLTl3+XtQCCjITi2RxhWyp5c56YZXOInuyJF4GeuFlClCOa2bKCijxHNeVgkgKlyTQX0q0kpI/tm/0Q9/7Tvgqx94fVLDpfvyA3S2uNL+FVewmzkdz/at0lNV/RLg3cK2ipVF8onHnMawxF2RUgqnU064dgxCflmykVmOk/6K1Tv5XrtNGv2fpEgZlxxjiw7I+i/xByXTsTpEy2ySdsEedI9uzZP6GlwHKpG211AVOQrGmfE6L0j6NfKCkoMiwYmjH4zrHZiN3i4yjMo/loX9BtFCr9aNxo6MkF0unGMynsnl0JY8C3gbLvClFJGAEj1BJ3bHSX5RmEIjYvNd/ipU3wLbQNHJLjjqgc+IUn9cWQZGR3L8L4YAUlZcpW7ncUBxjVKTH5TULxXhKflM8LcMJX0KIazsq4AN8icb4XTSUoWtpeX9l1GIMBiQZXksePBGiSpiFELMuYewWwciXlx5sa7clUp0MyoOcjzunAvQe5kC/AWofK9YXdDByhkfjW6itlrudJjWeTOrqWPZCVZO5MvObloWlzWwPHoy79d
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(336012)(186003)(26005)(40460700003)(16526019)(5660300002)(36756003)(36860700001)(8936002)(8676002)(7636003)(356005)(2906002)(426003)(2616005)(47076005)(82740400003)(86362001)(107886003)(40480700001)(83380400001)(70206006)(70586007)(4326008)(316002)(54906003)(110136005)(6666004)(478600001)(41300700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:05:40.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba6e5e7-cd43-44d9-f377-08db8d0776fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The layout of the register always supported 128 bytes payloads, but the
driver defined the register with a shorter length because it uses a
maximum payload size of 48 bytes. Increase the register's length in
preparation for using 128 bytes payloads.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 6e2ddd0aae35..71d42bcec0cd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -9631,7 +9631,7 @@ static inline void mlxsw_reg_mtbr_temp_unpack(char *payload, int rec_ind,
  */
 
 #define MLXSW_REG_MCIA_ID 0x9014
-#define MLXSW_REG_MCIA_LEN 0x40
+#define MLXSW_REG_MCIA_LEN 0x94
 
 MLXSW_REG_DEFINE(mcia, MLXSW_REG_MCIA_ID, MLXSW_REG_MCIA_LEN);
 
-- 
2.41.0


