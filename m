Return-Path: <netdev+bounces-59927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0915781CB0E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61582B24AA7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562F208CA;
	Fri, 22 Dec 2023 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OENRXMNR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616C20320
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNCae9XunNYVE4iO2+hI99EPmCVFffK/DCl7UBr9156AulMei0DrUnGoyrKCxMzQ9BMk61OGiXwhUSQmEJC7deKnYUH71M9z7ApckW3BonMkIZQxZ0zuutD227fASCEFjph71caRajHDCZsDwsnqFoQ+ulGTuv9fe3Dts6GlmD+BWrKS0X9+/+xize2usGmWgr7f0oslOYTraCkx4xxUNpQZFe1cGisUK3MIAWIvdkKr8yU/6Jf0watbYTLSCFBPoVSN9Ij9/Kld+LR7TcS6tEno/UahmC/v7J7+3xPP+gZQ5iiXSnTyxlg4YLJEFAJYOzBr4yitQnmpymKEynMUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMu214ubRKVCLvQtCJR5uPgmwck/cVIJS3EEqViRICA=;
 b=Z7CpT9k3Phntmi4yftwQ2Jo5ArWZ+HK6Ri+ZJkjT7eLPAe4nRLpx8xP8byrJvCGxP0mM5H3z9cLQuydgA3CJB/GovSypDh30WGAL7d4wHTRRnkv9Xg0aPi5F8MQHifxbcYk1P3dBRtExpvrbgi6SWGYwwzjxLhPBvdyhS+xwaEq8+I3VcpWtJGyttVSA6btxdNaCguUS5Zi8rGainRp7Bl4Jo01QI2PQXPr56cCkyQaZPr5tzSCSY+qv/f85oM+XhZ5bAK62Xuqxiw5baz2LqIeHouZN5iqHHBG7nU6KPM2uuNPWLdHr10PIGaVelnwX6Ly7gizVQNKLd2+z7RJUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMu214ubRKVCLvQtCJR5uPgmwck/cVIJS3EEqViRICA=;
 b=OENRXMNRFQqcI4rhwm12SHnYSl+SJikhm34vclIkYoHO5UefMVcLF5RzmdabOGjodIRPxCe9oNphEQlprEq2tsCxmxTNGph35JK572fOoWfETSJaxoRr0z6CceIdhCkhdfth7UbKSzYdgEGR6PX9T6cf7Ke2HAKGJCZm0g6lCN4OJjzMzQWzV7LKrBrFMNbGa6ah84rqr+FTU9d9Wkp3YVLgiEAvdG5d+OjY8jikgjoAk8ekRjHppXRNwoBdx4O0mFamli2ZaZ2Ks+n1sl4QF29u6eDl/ATQmjmEI+LfAmmDwnZxOQGv3pejLK53l4pvru+JHXFwQar6VAxNg7e2yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:08 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:08 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 06/10] selftests: forwarding: Add net/lib.sh to TEST_INCLUDES
Date: Fri, 22 Dec 2023 08:58:32 -0500
Message-ID: <20231222135836.992841-7-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::28) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe2910b-b134-4c6c-c4c1-08dc02f64ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vJmufmTUT8tOGPuFi48mNncAA0lfBr+imwNVOwtPy46jsGt34IMh1lLJCiRVFMEWL2Qndz8W8jawoiXsOoqf0dLFYSCN0IxNuwSeV6Qs+qkiC9l9zMRyJUpQgW8hdtu1rz0fLKE01dZeYNMk3vxdbAmum4wiL0C4OBeXyV9BFWuoID3gbkkjmlrUXfySisce54Shx1ZlmZERAPt/1LOBdML6E1r4ld1dEav7fG22L/AxmRKSpfFMohZBEZP5kl9rqdmo/nN2hIBmD/PYfuy3DjW3Kk4dogfizhIzpAeaIoY5VqyBVVyVC/6WEtHJZ8OBGmvmzAx4KamKhzYcYZm/Lo7rNwj+WPStS6xpA/x8fe7S7VMMo7rEzdddpD3EvPvSSWOnBt5iC0Dm/r+bjH+9DebuPfl6ZKgt6HPqcB7DBeflWYo+/LucTv9A8XJYbmjydXvl8eBb3cTitRqvJwsvbOQxMQh8Z3xQ1HNs0bsWE2koTgAAHLi2safZP/tNl2Rr2c8n+g9rVx2Ukg8cdTIrxbGTqn9ozafIzGeLOvaxhcNIebnrXWTgRaeFcScZqWlT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdjZEX/fZvHRYoVme27MqEqfwEq8zMzUxOlF3sqPWAZzjldip3YLvUY0frIe?=
 =?us-ascii?Q?KAOTqFeSpUlV6hUVXItN4B5XHvIUS1//ZePrY3T6QtNPcLYuvk7xPoKgYi32?=
 =?us-ascii?Q?zXoLnkmIiaC1iRVzEWc2YopgZ7J3dFLh0cWCWCv0Cl4AcXmC1FgVE6OtjdTy?=
 =?us-ascii?Q?SXIbpbiDQNcBKZU8QlPCXm88we0atysQxpQhyDMVimtInhrBvaJHijsl0Q1l?=
 =?us-ascii?Q?AMLyUfypdZsAbBOFuXtipxGBVWIpp8RWQjKUk/y841W0KeBRr7zz7TbwFYrY?=
 =?us-ascii?Q?yz1jpEF2bCoVodD21SUNjC9056jHMQc1CVtn2+h6J5F81xPRZzYS6DPGbPl+?=
 =?us-ascii?Q?/jOp4S+C9Q45VKCzbQNqMXoPZ+DV5zTfl1rnv4TBqkW3uobayUSFbQUNA05C?=
 =?us-ascii?Q?S3sdWBHizQnEbcKzPFbdfmfBgG3xKiQYwAfwaaBXiNFDNKOIKs5LT4uj00Z5?=
 =?us-ascii?Q?wd1lOtBab+FKtX/VY++1cyZDq5a6tWaQAeWQlWXoI2IGDFujmvPa9n77hIw5?=
 =?us-ascii?Q?m+Vr6fWGbjvzgJkuXN1QJB8yV2c2cQydl4g+J27VKQNxf+xNOhK/niZasnE4?=
 =?us-ascii?Q?DyypiU6Mx6HOb0HqS22mJP8RNE1QNpfdSVluPrjaWgzjDfkcZoCE2g1SjRH/?=
 =?us-ascii?Q?gSw4E7dmxtFSjTfil5LTAEPVjNAQKJY0AcYJcPS7zJIW92lxn1J5KOkQ+ZHD?=
 =?us-ascii?Q?ufbVHG7m7Sr0Z56ZnoTW3Cc86w4jZppVvgflsy5aJpyRIjbx/cpYqmEg4skq?=
 =?us-ascii?Q?TmkJAJ3jdjlKNXQHmwsTMbFWnXUAvUIJDONa30znp87WLSuSaRF1GqRyNxkc?=
 =?us-ascii?Q?7ry6SrUvxJXYKzoW/S9ts7ttEpuQz24c0IJqOrUyk62h9Bfl0B+o0azx1Duu?=
 =?us-ascii?Q?JxkxvwqdXf97C+nGXry6q51wAY3zM2GbhvO42I28+9T+7JgMfUQ1IyycVRlP?=
 =?us-ascii?Q?stYX8+s51K7P9pqPFs6VQYaakw0/5yvWPVEOSQTr6q0Jpsd+0bQ2oPgfSxgo?=
 =?us-ascii?Q?PA7s0EwrLGqy0ZIfB3nHklXioI+FmyIKPn4apxrt5rovcnMqFaZVCDvMmozw?=
 =?us-ascii?Q?uZ4ksXyXzXcSg/Nw4KwnKeZvjSMunB7PG22yczE20TvAASZVJw6egPDUbjs+?=
 =?us-ascii?Q?WrPZaO9PfG3KXzKWndL8nq9Xk/lV+OMnFNs8sn+MrzxAZG4gt+VazMyw0fK+?=
 =?us-ascii?Q?xurIaSZJFOkvuQbhcZYgLEZ2xiOYnrW5XQ0GRb8TA8h2cvEfLJ4c0brYumOj?=
 =?us-ascii?Q?2vLzM6qTswmZgiH8QQbtKxaPEnVBi7kYzHPPVFLS6k6X30WsKCbl2WL3P9SZ?=
 =?us-ascii?Q?7IIaGXb3YjAf24uTC16sq+Yb0IjjSzTI3uCtBpS2uBnXLnV+4Xa3rIUbweNR?=
 =?us-ascii?Q?hkDb0cf9HFeXXGwdW0PSa56k3qYLtABJx2GHI4EWaDpyjhlNKOqbH4iux3Ga?=
 =?us-ascii?Q?o227wxtr12eWfPcxpdeOKNhYs1epfLai4Mp/pIvBXs5jH/Nn4KCXGe9RbukT?=
 =?us-ascii?Q?9DXbWFcyASnjcX84/6LzuzZLV3nshz4QHzo2TyXp6ZssYsDYFhBE0ADYmo0G?=
 =?us-ascii?Q?OcioLJCnKLxaungqD9FzF63rjMykzNP6eNazoxTO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe2910b-b134-4c6c-c4c1-08dc02f64ebd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:08.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBkcciW+7czE31ROv2wJhnCXE/ncl1tyFYmbdb/XyPlrBUWQf2rRPnVSlhpkc4PvbGStdqdKQAtr44RsTjswzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

Since commit 25ae948b4478 ("selftests/net: add lib.sh"), when exporting the
forwarding tests and running them, the tests that import
net/forwarding/lib.sh fail to import net/lib.sh. This is especially a
problem for the tests that use functions from net/lib.sh, like pedit_ip.sh:

$ make install TARGETS="drivers/net/forwarding"
$ cd kselftest_install/net/forwarding
$ ./pedit_ip.sh veth{0..3}
lib.sh: line 38: /src/linux/tools/testing/selftests/kselftest_install/net/forwarding/../lib.sh: No such file or directory
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip src set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip src set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip dst set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip dst set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .

In order for net/lib.sh to be exported along with forwarding tests, add
net/lib.sh to TEST_INCLUDES. This is the result after this commit:

$ ./pedit_ip.sh veth{0..3}
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: dev veth1 ingress pedit ip src set 198.51.100.1               [ OK ]
TEST: dev veth2 egress pedit ip src set 198.51.100.1                [ OK ]
TEST: dev veth1 ingress pedit ip dst set 198.51.100.1               [ OK ]
TEST: dev veth2 egress pedit ip dst set 198.51.100.1                [ OK ]
TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1             [ OK ]
TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1              [ OK ]
TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1             [ OK ]
TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1              [ OK ]

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 452693514be4..5b55c0467eed 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -129,4 +129,7 @@ TEST_PROGS_EXTENDED := devlink_lib.sh \
 	sch_tbf_etsprio.sh \
 	tc_common.sh
 
+TEST_INCLUDES := \
+	net/lib.sh
+
 include ../../lib.mk
-- 
2.43.0


