Return-Path: <netdev+bounces-29972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00F7856A3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB101C20C2D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716DBA3A;
	Wed, 23 Aug 2023 11:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9A4C75
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301DE5A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5l5d2Ifzkjq1MO4wUs0cA0igafXxq/uutPSbJnXiZisjiFrLJ+AbLokujOQ5gAaEA6Lds3QoqVXRwS+XLCCC26SB7joG6tfWROKSVeoTje1fD4Gl6YvfGm9++mKq1M4CdqEoVM+P7qVoH8cMZfKUSqj3dqRrdWRkL0HLTozvY0p8OMVPAj5Uf1vT39o3zb60MDWUeYixKSQ2aF5Gz7K9tJIIvU5S0foXu3XEuHX8N7wk/5OY50DZRl2om6gIBsz31y4QaHTGlnhBZBgqTpW6IPtynvs2jAB3onvjVISsHjHkJgwCsbm5Bx7aIAhd/8MVcccVR8Fp3MnVr/spwga6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkxrMtobbWOBljv2pjlZAgVNMmqpktbdDvo/mB21Ypg=;
 b=Atndd2Ik6C05bGUGZncygeLFV8hUJam/wmvl2PQA4zoP9LZ73TdGK7wHBdIA3lO8JCXC31qg6KzzIMS9FkvMMXZohyRYRei7r+vV92mvFF0h5xxM0GPMx94IdS/pjg0JksB1qbCsM28Fbd+Q4FIFPk3RWYZgkoU5V4wRsIbkZTamWTDF3qFPpX7XXfB5vPNqkIQBNm/oWOnI7I/NX3svga6tOi+r+zn78uqwLXdnHpAczMF+fOVaCErHTAIRUpEUel/helNIgH3W74dGYKGhNXmBmP0I3/UUiThBUAmSGJAv2lp3Yb/NFamBRi6L8Hc4Fwp4Skq0zK86sYSlEgXqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkxrMtobbWOBljv2pjlZAgVNMmqpktbdDvo/mB21Ypg=;
 b=b5Lh/lMVedbdhEFEUUENNu2mj2weqRJIchG1uWoQvbMscBPKqfUrNW4Qgc0qA5pWWjIBtgV8jnoI5Y40V3jbBoPb+J3rlvIyMw4EM+UxuEWJTeb5rysjnzASSwk4vqNCsp4s8oJN+lJ9S/kASpVGNI1jg0Ww9XzSkQe1vrrMVCY=
Received: from MW4PR03CA0268.namprd03.prod.outlook.com (2603:10b6:303:b4::33)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 11:17:34 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::f1) by MW4PR03CA0268.outlook.office365.com
 (2603:10b6:303:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24 via Frontend
 Transport; Wed, 23 Aug 2023 11:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 11:17:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:33 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:32 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 0/6] sfc: introduce eth, ipv4 and ipv6 pedit offloads
Date: Wed, 23 Aug 2023 12:17:19 +0100
Message-ID: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7a0e21-5b10-4855-fe6f-08dba3ca8cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d0UI0ih3LRRtw6Q6oXY52/HlQfxUuh+5Rhd7kep/S20J6RWACqOJyiDy82fo7JJyP607bm85PjOaADrmcKiNN0Bi6iI48aNYHaMS5Rp1qPFL4Jut1Jeh12hQpJwYcYmc4BjXhPZQueRVD3Zc/v+UNgAKGOJs/o+KzatvsK9WGAETuCCnN5UpQOuwo0ICN7FaFCC597ncm5l3HlbPBKKCkWGSONlUm5m9VXdGSrCIHSSq/YUillDNgOof38d+XucMaDTL1PPoQ0kfI9D/WvXmDa99TKY//UlIHuDyt7YnE7iF+IvqST042WffmkPH8x0pPpZk/7NbZYGCup6VEdR2z8LBdNPJn7dMX3IQicJs3G+1+fuki7ArewTdx5T3LngkjoCYqkOIhesltdlst5v8MQ+/ne0NGunnb7k7SzavCpEpBbsKM0x74v6QD+OP6H0mDS42S3OborehiyiXP3/FjRRq7PL41LgMiLc1UULQAEReWUigb0upMz45U4wcqyIQpathHjYvSzsM7lriNn11+U44thD335l7fgHIJKQ+CrU0HeEFtjg5qLdSuzvGSEbPTwK5EDZLFrbz3S1LXU/Hmc74AVNL0lmQHEj9Lio5nfRSmHwektbfWP+ITTWnl/cYMdJDDD51dDoUYc9mH/5M24DUYdyFAsxJJMZz753YmDrd3zSREIOLhKfZvf3Z2qe4Kat8rNKD6kj2dp5ImBAxuN2Q8wsjNL2bbew37ZvxNi9mplWrKCISGcd0wP9qhuemO2W9KvYyPZVMVWWdCAUzFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(36756003)(426003)(336012)(26005)(86362001)(83380400001)(2906002)(5660300002)(1076003)(2616005)(4744005)(82740400003)(356005)(81166007)(36860700001)(47076005)(40480700001)(8676002)(8936002)(4326008)(6666004)(70586007)(70206006)(54906003)(110136005)(316002)(6636002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:34.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7a0e21-5b10-4855-fe6f-08dba3ca8cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This set introduces mac source and destination pedit set action offloads.
It also adds offload for ipv4 ttl and ipv6 hop limit pedit set action as
well pedit add actions that would result in the same semantics as
decrementing the ttl and hop limit.

Pieter Jansen van Vuuren (6):
  sfc: introduce ethernet pedit set action infrastructure
  sfc: add mac source and destination pedit action offload
  sfc: add decrement ttl by offloading set ipv4 ttl actions
  sfc: add decrement ipv6 hop limit by offloading set hop limit actions
  sfc: introduce pedit add actions on the ipv4 ttl field
  sfc: extend pedit add action to handle decrement ipv6 hop limit

 drivers/net/ethernet/sfc/mae.c |  89 ++++++-
 drivers/net/ethernet/sfc/mae.h |   4 +
 drivers/net/ethernet/sfc/tc.c  | 474 +++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h  |  58 +++-
 4 files changed, 612 insertions(+), 13 deletions(-)

-- 
2.17.1


