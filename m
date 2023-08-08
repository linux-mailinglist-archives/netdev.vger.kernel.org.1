Return-Path: <netdev+bounces-25359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C5773C94
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E61C2074A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC61DA23;
	Tue,  8 Aug 2023 15:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE91CA1F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:51:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5F67CB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXtc490MM5aIAiK7VOO98IThABEYa3ekko8QGrXMJzCmx47S63ouXVKUcU2mufijtX9F5397IQWFoF7LO1+qz3g6h3ALDAaCmLVk9K0ZKCEL01m0z2fPrmDlVaxlro3ehZNuj+jCDG6yK8Y7L9Iulx5BKGQlgA5fjf+deB7AZS0WcahvoFQ1mFgCMb7D8D6Fr7HwMW5CL6pRzXPDuiprObPMUW9sZ1h4O2E9XhTbr2RIcutTOEIkfv7IglIDvH8d/ue4td2ygZJW/qGNA0J7m7WGcU82wSh8dFm0QEv5EhV40fJHWxBfA01y960GMhzCzVPySSsMVpitkvc37nP4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAXhzczemSnTcSQzDh8EtQv93d/+8NXIVwfBy9cL5k0=;
 b=i06d8K9QqiwFx/i/68tNmxxREPyZdoid0r3tSNxYNwUu6huFQkIT3Az1SWrhMwq4q0cUcoTgNq4vRQ9KJrRO7n9yl/E00T3ubjAsNdi5QC7ioxVvuYPo15lgYP/rSCwk6qokh4bY9wnPzuzoa6o+b5jEhspUuCrDHpFr6hpr63edsguuozU/f02kcMdv5F8Wm0pFsCtCr8hvPJKVD0aqCB1lWofcX03uqA0mpx3cModydhIq8EKWoF9xGd7aTw9dQ0khUktjVn9NJ5eawaywou5Rk2CxjBNSDFAutC9CQeQvC6rDSkhfCOpJWQnsJNpQKCUV2gsW2duVnBQmrMqwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAXhzczemSnTcSQzDh8EtQv93d/+8NXIVwfBy9cL5k0=;
 b=IQ9+tJGLd6MdkQIPRAxLFYtNQiMEFsDcPTVAFohnVecLtCiny/sY8xZxN/QVKjZ1KlrAJe6C7pHCR8xfmrMQnkn/QMBIItOxsGu4DRvVyoVTeiccFskR02qm17JE0KAmOudntD3s+0AbwRRdSsUPaJ/Zdl0d4qoVXmv8mlaq5aimjcmxo75TAw2++95f3Ypjwdogo5kiuBTGc7kfh7G6YPVpD08qbewCZGT4Z9KQwm1E58N48k31ZQTaRQ6bUTBH3YbTOSCyh0iOyl5W2oYU3uy45k143xPs0KJHlTnrDDDkFL7heTCPqoyx4kZPfj/bfYoDSGXBOOpK1w6jVOjE4g==
Received: from SA1P222CA0166.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::10)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 07:53:13 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::83) by SA1P222CA0166.outlook.office365.com
 (2603:10b6:806:3c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 07:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 07:53:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 00:53:01 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 00:52:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 0/3] nexthop: Nexthop dump fixes
Date: Tue, 8 Aug 2023 10:52:30 +0300
Message-ID: <20230808075233.3337922-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 67898cef-34b0-4986-c9a1-08db97e48483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SI/LpNK7d1hI2rvr4hjLkb8Mx6oWEmuOufiR+9fM1PS3YTT0c24hNp/ynWPbkMxJVnx+F/Ymcz4fqw6zy2+R3BXxd1LnCOWdtVFeqxcF7gwLT1Gs76bFuYaak1igprqRXEOJUFNBWVyUfPldX7fL3R37HbFsY/RugAp6MSNuDsfy3efoECowSNihbOMoXv2r5WPQkLsLPUWhuQB1GLxrOeT7MDvhNsYKRuaMsRmciL+a/1n0qJx2hQ25WI3HowtF7TdgFpkQYvgpLbjicnrAzAXsKGXlo1jDf+zWAXXKA5eu+hvjbpY71rImJF47Rc73vom7GlcZD41GMFAwtXtobuMo/KkiV0uhgPqJaDtuDomOU+CBfJ5CUau++81zX4sIGPtdKix/VR4mnpRWWYt5ZuV0r/AcqMluvtcWkzrIAx0gqsupfIEPtVr2EMIs+h1fszLGBGv0waJ+oLCKUe12ADyXEtJLlkrI8h1BiQlPcE8AhmcyhgAHIWhe1921H9jPdmgDk+QD8mko7fqw3gNClDrMpltb+WWu9HaLMdjeA5EC2Erwdfyx64CcbYrHoY8MOwv9uc77KhTycG/qxfXOng2FOl1t5vjDeoF8kJ+Nzvx8eTrMa/7e8QaBikVtMNk2CHqE4reTEl2Gf3FsYp1qB3AQz1pVk3fw6+OpR2+WAQeyA1MGBUYvwbyGfg3tMoAvRVCsTOyey/7Z0z5Xxi/IEKO58k4adj7rQFBxlP5JoDF42bSD6SiGN/TiytV+CG7v0CmiC2Hh8jg3AWTjf77LvyKngYK403MPAo9mI9wFq8o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(90011799007)(90021799007)(82310400008)(186006)(1800799003)(46966006)(36840700001)(40470700004)(40480700001)(336012)(16526019)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(478600001)(7636003)(54906003)(356005)(70206006)(6666004)(82740400003)(70586007)(41300700001)(1076003)(26005)(107886003)(426003)(8936002)(47076005)(8676002)(36860700001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:53:13.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67898cef-34b0-4986-c9a1-08db97e48483
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patches #1 and #3 fix two problems related to nexthops and nexthop
buckets dump, respectively. Patch #2 is a preparation for the third
patch.

The pattern described in these patches of splitting the NLMSG_DONE to a
separate response is prevalent in other rtnetlink dump callbacks. I
don't know if it's because I'm missing something or if this was done
intentionally to ensure the message is delivered to user space. After
commit 0642840b8bb0 ("af_netlink: ensure that NLMSG_DONE never fails in
dumps") this is no longer necessary and I can improve these dump
callbacks assuming this analysis is correct.

No regressions in existing tests:

 # ./fib_nexthops.sh
 [...]
 Tests passed: 230
 Tests failed:   0

Ido Schimmel (3):
  nexthop: Fix infinite nexthop dump when using maximum nexthop ID
  nexthop: Make nexthop bucket dump more efficient
  nexthop: Fix infinite nexthop bucket dump when using maximum nexthop
    ID

 net/ipv4/nexthop.c                          | 28 ++++++---------------
 tools/testing/selftests/net/fib_nexthops.sh | 10 ++++++++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.40.1


