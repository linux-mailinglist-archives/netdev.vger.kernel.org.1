Return-Path: <netdev+bounces-59928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702981CB10
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA7B249C4
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23591A5B8;
	Fri, 22 Dec 2023 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zn2LhT6/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A81A703
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f64q0ux5BzYyLB3Kboxx6acaH/deRp2hMz6pRmbGvvsTOXAQZF9BxTbsFLMO76f9UV+jiFHiLB+ibBqsnj5Zo2QL2OnNxi21iZPqkrWosSARHoXh8L4G2sb3xug0FlkXBL5qd/Zpk+I2h5ptOJFRdzJpMrP5q1V+/L7p31Wjp1DyOGQWZ7xEXp1ykTMaKikxOghbjiabA3nZ8VTABg0G93FOeHsTnDGYZSaUd75bsuT9BPW2Ns+ZXcCDdLRjBu1wFiKIJNneC+btSw+tMMstbmJE2h8AcDJ16051/m4pAzOaVJ25ZHBQqtZ1eba8LCpcZGGKSr9nBVmbAvzHVNOx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z2B9Xb7kRzD5tXxv3uFoBvjw6KNB0u8HK4zrWlosf4=;
 b=gmMed/tnGW00gChPPyCxVomlYBC/fEp5FdGrG+udxgZMZ0rca3H6BsGhm6m64fIm3dE7XDmlHmhe/FZVbEGZ/ABt7VvqvV34jojbiiwrY/ZNI/pqkr0vH8h9paCdWLVlu8X3Wz+Q98mHyhwadhhqGwuOIB/hlhlwAUKRt7de0YH5j+auBWwYTh1dL2KQnMUT4CNX3y3NOlsrvaR3LmW9gfLPxQusbP0Io9noZ5fUThEXqxDLZ2HX1zDmte+av/3HrOQQW97PRG2eVnp9C4dIkYvh1Jl646LERkVcH7YadpWfHS3osg5H5Nvya4TSAYNrQbwxCuyZxm/JlxbzwKURpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z2B9Xb7kRzD5tXxv3uFoBvjw6KNB0u8HK4zrWlosf4=;
 b=Zn2LhT6/MJHkS54wsUP7U4z1xF3FTCxiz8ODdzd8mXOftfKQfK+DoJ+NplVLO+aTF90vlbrT+IhV2Yqjcl/OQ8DKJPPvMW+gcHlxqhzGaolRsH/SSp3enLi+26D2A4TtQ1iyS8JbXKl11fioU4wnBvIdZ79XBhLLLP0PnpjsJDvq/BtU8GutiHefFD52XtD6j+vrikt+elzTEp9MMRcqonnbNNb7LTD8v6i2W9IivASjGihSQvwSOPMh9iGHHkDOW+jihIt3lUAmFHXpaSkoAp0e/NwZVZFim9avT3uVQLv+1H+faiLq05c4IUVactgTqKKl6x4BjPEXWTkBBATlVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:12 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:12 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 08/10] selftests: team: Add lib.sh scripts to TEST_INCLUDES
Date: Fri, 22 Dec 2023 08:58:34 -0500
Message-ID: <20231222135836.992841-9-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::9) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb7ffbb-3df5-4930-e662-08dc02f65124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m14hK6Dx153l+z6dfJXBxJWcV3v8lsQpyZ1inutHIXwkzhJXYQtayFfF20xzESRvabnwsqlC4I7rLRB03TegX1/kvmb6XkjHh3HP8fMmjQHbekAeNYFfNYMIn01ZQbMEz87UrQXCBkPSdYZBOvjOGBGW4IkCf5wzSCOUGA3vcDuWTpijnubjEbFVR2nhyet4HkdGfoKbaT7pvdBdFiSU+7lImYMHwvSH4oO0XNNAOp9FEUNWgSCBNoIlyc+00tJLwdq3keePRDedPambgv23fzMMyqt+5ozQXCLejKOcfvU2rILPiBb+GKTyg4uKoOHsPlZa6VXUkEJ1NFcqwOFeIcgF8JFFcg2eSse2FZDXTfh4CR6mW3IYMrdfgHOtx8EPmoDuzxhdwvccQ1Jj1oXj283nD+OpWT6F8/V20GjqWXLHD3obGMlWRL9h6tbbEl3IwoB+kudSnzndWW2FBrNqm8fd9euL9Lk5PVDPGU5hU0y/RO0VqLY8f6jz9Be40xibWNXYuostkQORk/Ul3IFhfPkSye+gqh01Qa2XabYrnvVFbyuFbiRHAJYzKlEhEtRl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(2906002)(5660300002)(478600001)(6506007)(6666004)(6512007)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(6486002)(41300700001)(38100700002)(83380400001)(36756003)(26005)(2616005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AbSexFeUJVGNk1IAsn7aZ0TAdoF6OT1s9FnUdLKEVATX6rvnw7bFUObfwEJ7?=
 =?us-ascii?Q?oAMMv9xk8d1CuPSaZkxhc1se1GFxvdxhGTTwAMmZHun3yYgCxwl0zx6ZoO6T?=
 =?us-ascii?Q?Ajyg5AUUvHnqhI9O8H2HJGjXqtJX+nfNlvQGdFCVdS5U24ra072t05L7fnQ0?=
 =?us-ascii?Q?R73D9RNWKaw+sIr2fdVmo7KBiVBHT6P8ShF8Y2MbH2ntpXDUn1neorwre5sW?=
 =?us-ascii?Q?WNlCULtO64tWj5CRRPHPNNnE+CNeXHMd+8LTQ/8tqO1CyULM8+z6AwzWiS5p?=
 =?us-ascii?Q?yYSCI3Y0GD0BNvkLb0nhHcaMllv6Sn5VeQcsx+Z16xv82WFet7fG8yqw2TuT?=
 =?us-ascii?Q?Qo8xDzqtmlsz+x8JUXaNu+H8gVeWP0O1VAH10gx34Bb4wRISQLwe8JyFrK84?=
 =?us-ascii?Q?1eh1+OhTtS0Z4CcK9xz7x+3iUtS+lkdSV2++WrOp6TesIeTvQJROfr+M9xi7?=
 =?us-ascii?Q?BVFBHUffz2riy9Mv1kVMCTB3JjtACO4M7Bk4S18zN+y9pUkSeFu0rSt/qN7i?=
 =?us-ascii?Q?UUOgmGFMHaGMVZaZAM2GFWtLfWOSnTfjP3Lq8CZnVMqUwI//PSQ95CipFhrA?=
 =?us-ascii?Q?E/zypdoynQP7ddtTATmKkLEzoR/Wfl7cz9RT41X1tv4wH0aCjh1YkjYCRmYj?=
 =?us-ascii?Q?fNoc92NM4lrNw7TstDRhdVqaj1jhB3aW4LZvxETwaOxJ9iqV1MhsNBiC5H/N?=
 =?us-ascii?Q?lQYyJDZqDAd1jH+skmL1yMUA7+xAAFLPNJ+lXNgYs9q/0OQZeX2RyBpTrMJo?=
 =?us-ascii?Q?Q7m9dWBHmke7lr5R25EC+cw7gvoQx9jecrpujAjkLqp2GlGvMBhCMzINIp3p?=
 =?us-ascii?Q?Z59R61JqlYsxIorc7LN+QluWSUyIMc+yOMpRmkzeIRJ7oqr5j1OWCS91gwr2?=
 =?us-ascii?Q?9UXmc1t8ZpzqLqbkUaOMOU382OapOfRJgCYC+aZ3OUuVPBTAwtdIIz0Ea8Rc?=
 =?us-ascii?Q?jf3rotuQ5OtP6u8Zz7D4Wv5xZD6QCzOf0NkKfXpWsZ2/8lC7QK/w5HSwwG8I?=
 =?us-ascii?Q?SSBdwly2MHpTyQIFT8T8fe1x3HfFTB3MohfaQwMjp+nHc5um5RPcsRmwkxph?=
 =?us-ascii?Q?GwD4GBrtmbRZoCfEsCxqHni9rTE8SaC5Qgm/maS4OAuSA+EEpn+BDmOWaGpA?=
 =?us-ascii?Q?Fe+n18uH22WuIoAqetE7iIRmZkS1S/8QUYh1MHO2RGkRTCeZWzUAUWyflGwS?=
 =?us-ascii?Q?zsbGTBSy1qxBqJK2izXpOhUdv5Ku7E8SNK8y1QNEHpwr+Z2dduvJqeF8qVCz?=
 =?us-ascii?Q?zmSdSp2pyJh4rGqyb58Jk6V9rWmuLvBtWMiT+x0dF5FP6z0zP64tJvltL9Df?=
 =?us-ascii?Q?ffkW7ghVKd7NUlJNC0q6DXAD3oS3A1S5KkQrcJtAXkIyqt2OSjSQdJ6HiRA3?=
 =?us-ascii?Q?v0Z9SGJD6yQiPwXl0zZUb9ONPD4GmWiTAu+/I4SP2ZSgTwSNl9J09t1fD+bf?=
 =?us-ascii?Q?OqaXGKqtA420+LtU8sIS1Ya0US+rH8whJbGSOdss4I2U0UotQG9wSK4FKN6E?=
 =?us-ascii?Q?rDJwfhd4ZlPoCgMsmBjlnBvmE/L+FOhEL6MUPxqGJz5ldas2+DL1baI+9k56?=
 =?us-ascii?Q?wZ2IEPpfPb4xkzEjItKh5OdWlut1tA1IHFvULmSd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb7ffbb-3df5-4930-e662-08dc02f65124
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:12.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fS3bZXCMU4TC6WbVtMj+hd6SJKSpUfMO+1SNilkbg7FqOtiWmLjKlyTnXy+DwRCFHhQfHGEwIWtU8Hl9HmksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849

Since commit 25ae948b4478 ("selftests/net: add lib.sh"), when exporting the
team test and running it, the test fails to import net/lib.sh. This prints
an error message but since the test does not use functions from net/lib.sh,
this does not affect the test result.

Example:
	# make install TARGETS="drivers/net/team"
	# kselftest_install/run_kselftest.sh
	TAP version 13
	1..1
	# timeout set to 45
	# selftests: drivers/net/team: dev_addr_lists.sh
	# ./net_forwarding_lib.sh: line 38: /src/linux/tools/testing/selftests/kselftest_install/drivers/net/team/../lib.sh:
	 No such file or directory
	# This program is not intended to be run as root.
	# TEST: team cleanup mode lacp                                        [ OK ]
	ok 1 selftests: drivers/net/team: dev_addr_lists.sh

In order to avoid the error message, net/forwarding/lib.sh is exported and
included via its relative path and net/lib.sh is also exported.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/team/Makefile            | 5 ++++-
 tools/testing/selftests/drivers/net/team/dev_addr_lists.sh   | 2 +-
 .../testing/selftests/drivers/net/team/net_forwarding_lib.sh | 1 -
 3 files changed, 5 insertions(+), 3 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 6a86e61e8bfe..d31af127ca29 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -5,6 +5,9 @@ TEST_PROGS := dev_addr_lists.sh
 
 TEST_FILES := \
 	lag_lib.sh \
-	net_forwarding_lib.sh
+
+TEST_INCLUDES := \
+	net/forwarding/lib.sh \
+	net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index 33913112d5ca..bea2565486f7 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -11,7 +11,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 source "$lib_dir"/lag_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
-- 
2.43.0


