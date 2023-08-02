Return-Path: <netdev+bounces-23553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF4F76C799
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FB21C21246
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603E63C6;
	Wed,  2 Aug 2023 07:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FF539B
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312FD3C10
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/OCvS/GNT8acDush4t8dfD9YSFucJkncMJ7tuKxUT5G+NCbG8fJqezI0iwGOB1M4v5d7GuFA3fqQ9izG9SqS+U2Mt6nTg24dNMjMNxV9CozPaNqADt16DnUd/+Tzzo1cKZxgy7tdw9TVgkvyaThEaNSbdBuN6UvC3VYT7Iw3PWR8tXSfq4myoBArbDZk4gTYmPf0NDbSp/ye3CFozw8j02ZTXKU/rjUDb/B3Vz8gJArw1d8Xm3p4tToTbXVJYhHfYq0z2ZBE5QNOWJkg8xWcCYCY9Gih5bYQpu3GIuzRWKZhzzdwwJX6HTJABqX3dv61AGOdzLmv+4azHHEMjV64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hok+nm1fXdaKhuAYPYL6JVCMAh6YRJfLHbgFr3unjws=;
 b=IAoJO3ELvyXt2ed0m2jr77u6iXqzl1JXP6xDWtAqXvpn5P3Ab8EbYnvsWVfoS+9UsWInb4AhOf/tp6Vn+DzWzFimaOEjZRJYpds2bffhZtL9E9Rme5Yi3Sr52Vg9Rk1TG+YtIYJd8kwYe5M1r+/W0pfTeMd3Bs5O76ySj4wwBsb6DMhPGR9/fZsw+fUS/wEY1pHsCNN2DNBQWg1SZEjTKDq0OWsF9iNJEwk657dW6vz6P2O8l0A5NjqzVOiCvtgdlzVSDt8SZh4oLAzr1Lbrnn+eV0jUPOG5+YLAdHCalylHApYxDGkFmU5TpmA6uQ3taSzSWhFiFWObAVvYYFYMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hok+nm1fXdaKhuAYPYL6JVCMAh6YRJfLHbgFr3unjws=;
 b=THr0S5HK2mKFrPu3Lt9tLleIXzkgeTe+IcBk+MdGyauDh3aLmpWjec/xkd9GrDrBT2rWZ0iS87/G+XrCR6Z4A16pTjFeQ2ebig4Q+a/XcHe5DmQgbSzgPVaoDDFK12DihPf0atWUAQHJCZopMwBLYsZS5S7zr+GPyK26W/aOFZ2G99fHymTgNvY9W6xq96ve9ryvHMUQgnOJm3Qxxd+XPERZCr46kbZaEjYlR0ChI1gvPVjAtis2InTW/NuX6lMTygf0vKYr0pzSq9yPEOfxe1ICaGWBpM8KB6wgoR1edCBDdDd2XQC2wfnnN2G/CEIkoAva1a261RfUD3jPBxEYqQ==
Received: from MW4PR03CA0109.namprd03.prod.outlook.com (2603:10b6:303:b7::24)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.40; Wed, 2 Aug
 2023 07:53:00 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::99) by MW4PR03CA0109.outlook.office365.com
 (2603:10b6:303:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:47 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:44 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<vladimir.oltean@nxp.com>
Subject: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when using veth pairs
Date: Wed, 2 Aug 2023 10:51:11 +0300
Message-ID: <20230802075118.409395-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3ff94c-0629-4647-e3cc-08db932d7e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7hUf40adY5SfbSEg7nvNvM/QCCFE674xb6Bt450gMkRjU2J9LHmPtL2QfGu+ClHs0geHi23w2AVBRmG6NcP/sVbF4IurJniBwbsXVFe2uLpbxWHmyAbPFiu8BFt1DXCaemcvambUTc4zw576UZMMkywU1iAzhGU0Y7H4ydpvx5UdKYI5KiAjzWqhf6sh+ZiLRVH8ND8jghWAZIYOgYJ/V6jW4S3sp1W12/ElYcj/0WEqZIZ2NIbcWcUS3b+4OIC+PMNxqrGQa/WG62w5RmhL4UtuDjdVlczag+JyA8pvP2WfakKIB8tgCRfVOkSRcUXxbZnI/t1E5rmIvTFRMhOC+PIdQ+1p1uv0PtBNDrLVRQUJIgDZ8fuJkMNa8FAmKw6+huvlguoYC7NudBx6YlPg6v0f+0UX5ifAdJxQwlB0CuYYF8Fyk3+mhtuxzy5zItzp34NiSCEgYizjdZQNGKOSFr0RBVOB4GIcmV1R/5Fvz5q0alF7+zEMULoqB8dU46+lalozpM8M084Y6nj9kKAap402+QsbYzZxijMyWLhO4Pt5QhboUQN88grQFvvEOpmVWTPJM+jCrP6g/01InEH+/rY6WIisr1AvOnpGpqonLdGJ2ACurUDWYpTN7k3MZLQH+OiWXJ7wztpB5DAfl7XIE1od7UU++dlR2v/QwffvKau6nxumTSrKt1wOp3dW8S3mmt43rb1B63aBTGJz5nFgQTNLkbWZcsAw+JEqcxy5exFcDSMxThlwCSkBgg58kSoiEtB0naS/XApPbqSpvS0i+i6bxPWGEAzAUVXVhBrqv7Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(86362001)(316002)(8676002)(8936002)(6916009)(5660300002)(4326008)(54906003)(356005)(41300700001)(7636003)(70206006)(70586007)(82740400003)(478600001)(2906002)(6666004)(36756003)(36860700001)(47076005)(966005)(1076003)(26005)(83380400001)(426003)(336012)(186003)(16526019)(40480700001)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:59.9180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3ff94c-0629-4647-e3cc-08db932d7e04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

MAC Merge cannot be tested with veth pairs, resulting in failures:

 # ./ethtool_mm.sh
 [...]
 TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
         Verification did not succeed

Fix by skipping the test when used with veth pairs.

Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
Cc: vladimir.oltean@nxp.com
---
 tools/testing/selftests/net/forwarding/ethtool_mm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index c580ad623848..4331e2161e8d 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -278,6 +278,8 @@ cleanup()
 	h1_destroy
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


