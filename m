Return-Path: <netdev+bounces-27179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEF77AA24
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7341C20341
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2149442;
	Sun, 13 Aug 2023 16:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C199440
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:49:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DAE91
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj6IbsotqbtSIP9qGgcuCu+KjrUR4dnq68L/yw1lXghF+yaTsOE3kOJ8/i6EzDdX5/n5wGE6psymyiOOXYymeHMSG1hkKJseEGZgvrnI3vPmEiv8f7VEKdHG2RBp6odocervUXm/gStbn508tEV1++NupRS+8EHOuhHI8llSocMpXA3XCdxzBoQvrcUTx8r1hsWEs0ytASknpxO/t0BWm2I2VeosbrkK7oez5nIwDORDcRcc2fuBrh4hcFQEKOs4p1X2m2yVG8C+y0+GSsucIFKE3w5IUi/piULnOqQ0aMFM2gMfUk27F6Qspt4Zik3qwOG1ccgTXHE8q0+SpijCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB1oMeL1Gxgbna9b8vmvmlHbkpPiLgZA/Snnst1pDjw=;
 b=gSpAnmeG0hm2k/dWTqLjLTozIXVYZC7z6ebQSXYdlmb8k6gi50AnIJlAWsDcbS0Ru+nD3HZuNCsUAkioSIGyKpqIlrfN/Z8ZVRfUag71YAOabnolOcpw069QgqnnZhM2ioHaaThtN0J4TXjO+bi/BYYeth9BXw8yQbkHJ7YMPzX5L8HKQZwSzjreAjRrD2hlW5lLmZPG4VdR31oHrBeqRK0q16KqSLJJdUD1mx18amSikv1y5i6RfL+eCm/D28RRKarV05IUa2y2SF/EAHsm9JmY6pixCu1/ByYv9ORZQv0p+6TBmR8hN9mIOyTOGgphXIXCb5v24i0D6/OMvbh6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB1oMeL1Gxgbna9b8vmvmlHbkpPiLgZA/Snnst1pDjw=;
 b=XXiZ77R30PD39ko1BuLBoqbOuyQMoloycmx9+95JSicwxGT2LYYtzVyqyBDvRHmzEp0HlDTuoQDSNAjQgxvMHg8WWlMQCk5CXA48YbI/18XFG4M0fGQCo9RQ3CEyvmuVo5pxIF32xmAVhU6wPdxSqldXc2jRm3YKWLdPyzHOTZgm58kglfOhurcBN7B0PR5u0+DxDvhhPYQnMSxEuhXivRaKwEbX48fx/oyqMF2kVYL+FQj0mmvt6TvxC8lROvZgowMwv1mPsmYFLCWEkia/B5uQoBpV9gqwe94Ot5CpbZ9FOIcNT1ptR+yx+pJZxhiIOvvuBJma19W7MpecMNQHMg==
Received: from DM6PR07CA0115.namprd07.prod.outlook.com (2603:10b6:5:330::6) by
 CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 16:49:38 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::1) by DM6PR07CA0115.outlook.office365.com
 (2603:10b6:5:330::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 16:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 16:49:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 13 Aug 2023
 09:49:30 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 13 Aug 2023 09:49:27 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/2] nexthop: Do not increment dump sentinel at the end of the dump
Date: Sun, 13 Aug 2023 19:48:56 +0300
Message-ID: <20230813164856.2379822-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813164856.2379822-1-idosch@nvidia.com>
References: <20230813164856.2379822-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebb311d-2cda-461c-5226-08db9c1d4884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qm/+JHqXGqJcMd9UIzDIRdFr5AzuuBcetuRsrKayJJC09iDdvVHd8NF7GQAkbwZboa833ZNAFeiYutik2q30WgryTpZB18MmhyKeZa4JFqA5HgJtOi++19lIh8i7D8uQBziZW3dUZAOl/S04cOM4jDoy0rMMbaLMwuxrVKpMq9gbKnm8xWR5jEzjn63rymBryjh4jNtQGLQO4cT2rKA8Or5DajwB31fBkH7JjYW2sf0H2K/W9IsUHcA+4DFmN6FUtzvRMG+dyeAALuObw1BrztQLkqExYfXYS3zZlTV4QExeDbyBN0MEvkrNfujO+EOAq7IVjBMsFKQeJfQhMtHthE22HJ9EQ8313bxuOIeW8dNdmz5rpZykl1zgjTYUW7+Gaf8QAq7hIfuWdqaivznxBHg+ERGqwgnJpE9g8xk6ggXE92K/hMUwXPlfJAjmW9VlP16FUc5HINfkgNSzAIFLTsBMywaPEpYfagovC3RNdhYg7Ryih5P6TH7DYkKm2RBE8LbCFz+GPzGTgJAFbXC9xcC1uVCOS7y+u07bt3cK8R5pRt84CAZeiDULyCjhAeevPiZX/O8SaWEPyo7pTgLs4kjb7KnEJFrbe7/s0zR3JzVlhIzJ8iDL4huwb29/vlhf1FwqymJdZzKXeFi/+8If+vOKYRXmxNppNH/HhuVqAvofCYWIHGRAUJmI+JDFPH2TAc76whKMQfU7sTB+1HXRPLQcO5ADByqkOdacv1ppP+GfUqpjZD328aEUFwAFCHNR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(82310400008)(186006)(1800799006)(40470700004)(46966006)(36840700001)(2906002)(4744005)(40480700001)(41300700001)(5660300002)(6916009)(316002)(4326008)(70586007)(70206006)(8676002)(8936002)(40460700003)(36860700001)(36756003)(83380400001)(16526019)(1076003)(107886003)(336012)(26005)(426003)(2616005)(47076005)(86362001)(82740400003)(7636003)(356005)(54906003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 16:49:38.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebb311d-2cda-461c-5226-08db9c1d4884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The nexthop and nexthop bucket dump callbacks previously returned a
positive return code even when the dump was complete, prompting the core
netlink code to invoke the callback again, until returning zero.

Zero was only returned by these callbacks when no information was filled
in the provided skb, which was achieved by incrementing the dump
sentinel at the end of the dump beyond the ID of the last nexthop.

This is no longer necessary as when the dump is complete these callbacks
return zero.

Remove the unnecessary increment.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7e8bb85e9dcb..bbff68b5b5d4 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3209,7 +3209,6 @@ static int rtm_dump_walk_nexthops(struct sk_buff *skb,
 			return err;
 	}
 
-	ctx->idx++;
 	return 0;
 }
 
-- 
2.40.1


