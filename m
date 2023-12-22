Return-Path: <netdev+bounces-59930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05681CB12
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81FEB2497E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340F199D1;
	Fri, 22 Dec 2023 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1hhh+vx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88EB210F2
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bziW9QLIyXuyTVX889SCBcqALwHU8gZCmwaXvMlmjCBsxNR8QuQAEcq+MhdwjYVyduS1Xcgc90oyWdpj2onQQQwZDQ/OzWqUucOSe4utrX0tLdOmydvwNdD02oOiFb2sqcfLwKdrsOvSMgbX43AW9F6EG9K0l/20oIbZ81MQI1zhAIi0ROj7HwH9nZmD3L79bYLTftk9ddLjVvyupc0fxpZZn5txLHJk7AJeD9YB9yK6M75N1Q4Eb+n12tdQsAKzonIfWeJQ6I8cxx9E9rxYxT/Lb687KxjUXbZ5fBuDB1b/BCu9N53XsxN0Yaj2SV48UT2N1LBCaJMQ3CqSqs6Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UONF/KyNhKsMBF81/OzMHIxa9GpzqMYgMnsHCBr4X1Y=;
 b=mctVvR/o5nxgW8k+knLPdMdu5qVXZH2nS5yMEMby67xMBa2EY91CQXz7JOlehTzdEavVWhMhrUoJC8GMQX1wYJ1tiqPtjMSbWP4m27pEM1ZLZ+aJzU9eLF6c5+6jSy172bJj0AAujyZfMfIKxmUvgb6NmS2XGEwyaLOGgIUkuy0XDjvLHnwtsn4i/e/9GdtTlYnLmAv9jwSNd8OOk+J4RfcYuXfrVr9a9Lsy+aZ782WVCwAe11j3nbCykmvDSURi068Q8ru23X2le+CdE8DXvCn5snPF1hA42S5dyLt1dxxWiOdP5CilBotSJG1CpcYmEBxv9Cp36cywOhbXHwUgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UONF/KyNhKsMBF81/OzMHIxa9GpzqMYgMnsHCBr4X1Y=;
 b=C1hhh+vxJwH5EZwsr8JC0A93BrIsUC29zbuHZSS1yZzCU5U7VoHdQlLE9GRaVyPZrjk2uMSg2aIBqO++8nfJYp1Lu3dFtGYPlDOx+bFU/pbzcKXvoatuSHeEtorDhDf4J2MbQDp6ynK7iwOMMnGcMu1JKyB1OQKO9wWW2KMdz2E+yeqTwPoZ3KujqFvDHOKg16iY9fLT1znFzCvA3ukKweNHa+MnrmZzvASxa1MkucKdCeYFpM3l1BqbyaEwpLBoAx/MLpA+TyKNpnjxbghqjhH9lH99/GylmIGscO+u4gLX/LP48fjuGcjt5iyJxcJ8D5sR8a8LYqn7HQH349ezVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:14 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:14 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 09/10] selftests: team: Add shared library script to TEST_INCLUDES
Date: Fri, 22 Dec 2023 08:58:35 -0500
Message-ID: <20231222135836.992841-10-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::18) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5bbd07-3d10-437c-3e5b-08dc02f6521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fsd7xfo+34lXrsyQ+SquNcVyL1TxhCxqpIyOHGpGgMpf1imqx3fTDUxsFLfIot3KNqaxCJzaUvyrNw91YMYS6DowfUfNBse8+YGsF1RZzV8jDDyGDNo6fEGltPfCK+bb09etu38ANUpayXPD8bErL/pSE0i6edwfZ6fgjJ7uzMLhyvTjw8qvPmqe1+GT54W3AeWFtdqDf+dFZyReyXKydd5qRGLaIQ8nN9O/ssBqLJ70zewtMlHphO034weFryWVImWLheK8Hb0G5xlhmAa7kOR9M+iFGp1OVvgrYlthJ+mxoxKcGSFktWSALHmywRgI4VffEq+H4/tGlWrExWip3tYdgA9y6nHTTj/RgiXz8rPO8XrxicBCsTpKsWwupIPYgoqN3JQcf+LJbGj+5D1lGhuNCc02JeSmQguDtqknebU9GBmQvBrkqR99Zt/IyNNfzQBYAKNdSFvsoEHk3Cpzgpox60OS5n0IKceLhqLMn+vzxtROIvcXKzLdQnbpbHkT1D2rv9ivqKjp/PoMpqWJuFn7esBmBRbH2XDxE+cGlujAiYjDwUP2SZKDASNqpQkI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(2906002)(5660300002)(478600001)(6506007)(6666004)(6512007)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(6486002)(41300700001)(38100700002)(83380400001)(36756003)(26005)(2616005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?007x0dMNDP59vE0erU+5+BKBSsPPLyMHbgguNBR9F+//923JcTi5MffgA/JW?=
 =?us-ascii?Q?IfbQVDgYbrjAP1Xynq0oxOCtxzD5iGQPLyFWvgaHvHwhHjkl4z7i6yj6c7Ow?=
 =?us-ascii?Q?FnQwGOO05NGpMrOmRJgfyUXdKJGVvF/UtQNzJbNXuL8RsRt3xiObDQamZSW5?=
 =?us-ascii?Q?MwLL8nDTMx5GRvXsEECksyXiBdnidpGGnKu6xGBTxx8GsTWihaO2YD7dinuY?=
 =?us-ascii?Q?fOM7jb4HaTGUXsjd43EGUwvaEfgSV4ENAdskwehRf2IyzCZhC/LMg2XJi2dQ?=
 =?us-ascii?Q?aqTxFbcu1ZKmBNQh0feSOECnqo518m02gjqyk8lNH2XbUd8U475DU2YRnwkd?=
 =?us-ascii?Q?leDeTGNuTo+z9Rh4fig7fWBV8gp+J0O59Wz0IYnWytssehzz8OxNPH7lJe17?=
 =?us-ascii?Q?UqZUbRK6a3Pvlwqgf7FFwLZOVM+2WYqya9MMS/2oLtdPYkC0UfQ6tEvQO6H+?=
 =?us-ascii?Q?32Mc0hwdn0EGfuQxwFQc4ctPrmCV6Nu3RZ/CUOzRMMzk7yUR82y7beQmtFNj?=
 =?us-ascii?Q?fyE98n96oCOxkenEIVKx4r9b23ryigpIx515FZZ1DXcIoVMv4lxbJSEPgSg6?=
 =?us-ascii?Q?JnxJ6xwFtl+jpbCBc+MEkRUnJSdjTd/KNDLzXV2WKMc63+I6ysPYGhsO6DmB?=
 =?us-ascii?Q?T5PgAljXbBV2A7C0/nZIWEcbqvZqMPBSHlB7P2zx1l27iYd4136SFzELclJ6?=
 =?us-ascii?Q?x049Ld981OCrgTIMU5jKM/vEbHPi62Rt9bys8z5r3VaP7Q/m2UeQEZ/5vRlZ?=
 =?us-ascii?Q?xhiFtIlycaHbruQUzBn0krNmmZ4jEeqnHPyfSOdESdnAktyxioCSR9F1obma?=
 =?us-ascii?Q?TORXwn/hewFGQMy05En1vl/0saGvM8guj/5CdU6eI8fI3LnAqK5QwGUaozML?=
 =?us-ascii?Q?dA+3J2FD0T+NifyauJKLc7zy+s0Fwan7RAUdgjq1NsERJC9xC9UoMOG0HvXu?=
 =?us-ascii?Q?LtDWAv1xJIlFUTJOYn/bEOOwPHhe2VlguMs85Z/E3dUdhlcdrXAWpy4zhHhz?=
 =?us-ascii?Q?TIoKrq4DmKbxbf5d9VsdmmBt8VsO0w3zKAXfzm7UBPL4hgZLSwhPHci3jH9Z?=
 =?us-ascii?Q?tyM+AlNNpjtYIPw4G4avezQJZar12Z2i4NAm0g1ifLVELV97ASAImIf030JG?=
 =?us-ascii?Q?DGN8UPCIjeeXzy4U2Zdo056np6IDQMkitSoO898wGHq8NGA4gh2JbUg6N7Ex?=
 =?us-ascii?Q?9FyZgtoNXAgq39qYiC/QjXEcca4InuGppKYA9aggDP3CkDY761oPW0LIcX1S?=
 =?us-ascii?Q?52ZQmEGSVQJu7mvzoqusRoKdibuennnCsWZsrO+ue8W44LQurZ5W0vLIYOTM?=
 =?us-ascii?Q?b3MF+cHlaSN63A8yPuMwtkHI7WcAVTfYUZCot591ZEBFV+IQEP038Nn6imJi?=
 =?us-ascii?Q?4VyevI6UnYJRJ2SjqtlQhm7byVWs2Fjio3gmRLc4zxWGrUkNTngDJ9jBk9qS?=
 =?us-ascii?Q?pR6aaUSsKTYDTWmA6tasybUKQJs7VgtddH2zXAUA+s53Ho30IvQ2ipaOEdFr?=
 =?us-ascii?Q?7Sm3SbzZoMJSzyxPNA46mbxkVhgnIFBcOw1vIjKLOe046Owz0dnI/MSol0Z5?=
 =?us-ascii?Q?zcbuDpLaTTzB5BC7XH08Aocs6/7NGYd6xGNsyAmx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5bbd07-3d10-437c-3e5b-08dc02f6521f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:14.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOCn5QMUbMaRpiW4YWypPou0bWLsFRl6LHcscsKsCuF0XU83toaXie6oelkqK+PDlhgIDRAyEkY5p1QzU2nBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849

lag_lib.sh is added to TEST_INCLUDES to avoid duplication when both the
bonding and team tests are exported together.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/team/Makefile          | 4 +---
 tools/testing/selftests/drivers/net/team/dev_addr_lists.sh | 2 +-
 tools/testing/selftests/drivers/net/team/lag_lib.sh        | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index d31af127ca29..8a9846b5a209 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -3,10 +3,8 @@
 
 TEST_PROGS := dev_addr_lists.sh
 
-TEST_FILES := \
-	lag_lib.sh \
-
 TEST_INCLUDES := \
+	drivers/net/bonding/lag_lib.sh \
 	net/forwarding/lib.sh \
 	net/lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index bea2565486f7..b1ec7755b783 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -13,7 +13,7 @@ NUM_NETIFS=0
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
 
-source "$lib_dir"/lag_lib.sh
+source "$lib_dir"/../bonding/lag_lib.sh
 
 
 destroy()
diff --git a/tools/testing/selftests/drivers/net/team/lag_lib.sh b/tools/testing/selftests/drivers/net/team/lag_lib.sh
deleted file mode 120000
index e1347a10afde..000000000000
--- a/tools/testing/selftests/drivers/net/team/lag_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../bonding/lag_lib.sh
\ No newline at end of file
-- 
2.43.0


