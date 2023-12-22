Return-Path: <netdev+bounces-59921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4281CB08
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720BC1F2307D
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF1199B7;
	Fri, 22 Dec 2023 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLoOVr70"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C601A58A
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9fw1bfoWh0lHvZOsQCKDpUF8EDgjNfjkgc8f4JaX4hiMHr7Tbgl9N0RDqt8G0j3AfLo809rJhB3MYzddID6xEhzN7evTU7VNZNWCbTUIuGhnKurHCtkIz/LnyzUHClHJBRltk0sm+V7T0yK3n6m5goDzPK1LV5ub0cLcDSUwZ8bAOPtSnlGoSmrrU/NVZVNWev3Fg6/wc3pjT5LudatL9rtIsJ6zIDyVagZzNdZXckjWVk/FH1ziw4YJk/A6766QKIfglOFccUxqKW3rXhODfyOoz9IZTU79BrkLbhJjtoSgm9eHMi33q2ensC2ZsVwuhNNyu6jbhzBKABUzHmSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxZBB9+mNND3WHQ0zcCc2xTcCa/KMdcu/DHSJhQSof8=;
 b=FZEGLt6k5u8paDzxuJZSZGpvw3u0IzPGIakNxpHmftroGIjYnS3Eg6RGNcNDngRQgWDrWm6EBkyfcnCGM+pwy474AL/4kmgDbNFuPDBs98GmtEDNCv4ogdMm7PB0qQrCJkuowpTa9yjhnlqnflpzZOV+HleLdJFiURIdYQiH0B7Cf1oXZ0DphzAzo0mj9n5WQA6h6qbbDiaznuo/a1/pNmCCbezs1Qu3G/YVEQmTOttPN/htOZI2BS2WisHOmKnOigSxv1V/ci7dt6C+NpHFwRBrflBaCF47I8t9wYq82ibGgp1NhP0zXwdD8yFWY4hj91Pr6Q0DGV4Xn0Dpuzj6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxZBB9+mNND3WHQ0zcCc2xTcCa/KMdcu/DHSJhQSof8=;
 b=FLoOVr70o5sVjGaFUJiprXs4YTF4t3cBCduGi6RaRPz3cF0hvffVIb1wiVTKjl4BqqPdHfoUVU7RK2D3wtcbGfdHJ9dx9IDQmXSqVYDH00ONLa6uCstzmCOqn5eiD6aZh8sg+WkIzWt/LQkPB6hANFaCkoy9sDalNgFUkAQvVxtS0Yf1Forbvnzio+83GjwQbsAYBnxZc2SWupI8F9njfPNhbi/hshe7kkTPFDKrKQ4nbwD88h3OTIc1yWxFiyLTZz1FgfsMo0jtzwBKoWl6+9/zxWWw9VUvdb1ffxatsm0dMrAH+J+pz00DXexJCINgyYqkURfN+yZGBi0C+K5OJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 13:59:59 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 13:59:58 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 00/10] selftests: Add TEST_INCLUDES directive and adjust tests to use it
Date: Fri, 22 Dec 2023 08:58:26 -0500
Message-ID: <20231222135836.992841-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acbae87-b14e-4c22-2a9f-08dc02f648d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GUBk8Z+tNuySIXqPxS4VaQuhVEFpC7j3yxFpq5C+/hkQalWSLAzY8S54aTvJDkbPG5unXRic3rb3/j+BqszKPowcIoIUB3K7G672CZAeSIuyLiuYDGBQBrGknOMuXK4XxoLYRmQHzk4kyabp4Ng3/w89me+oSWYDgTi6P95w3b5dEI1o4UWQE+7yICNZaY+GxsAeioDbsCm1gQ0+55UxDxJArvcvteKWKTwD2uiB5AoJpKe4xMlmruT2jh7IGmYZKwleq76fmjJMyAc0e/6Vfvah8XrCcxQIR0NZcBUTBIt1cLzTicT4RiiKUyrAHpaAPYDS3XZphg6VZdR2iVnE1AEAchhbNsyfMzZFA2iALBSghMleqADNK7iEcFgDWxMG5Jq6NtntoR9kpVPL8ViA9TO4LSDzKlAjEl38MsKCt5DMCa6szg3jMO38+Vci8kYMXlJ+Od3ALkU2d0TwyHGyxUOSlHU41OpupWEJkpQyKG0SsEWGgrO4rm3sLev1Cho51SKmlBEMZujz+wx9LhM+9RHhV5uV0KWS8hEkhPicHSAXc86ajcYAdjVJNj3BH8uXqjVnOrtKLdxGSsVmJlAw/TXFpOJUVZK3iA4xfjlxnbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(966005)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muVaW1nq8Msq2SufD3LeBuBu+GdaXUnAaxYWfL1E9g8wfnx5XRO+OTyRjvGY?=
 =?us-ascii?Q?QM5jinbR07Do7Z6euvlrxl/ViHrsfAMeiZSofHbgCcYiC6KxGrbdcRYvzMOP?=
 =?us-ascii?Q?tzxopOViseaCSOuddO1RTSzFLOtAjqxtJwosK/NEjdhTWVb0bzCym3sGilS4?=
 =?us-ascii?Q?acN5mvQhInqL3PwgWrgd7Kx0BiWWuwaxg+fvvq4hP+NhbTnGF8eSQRYwhLOb?=
 =?us-ascii?Q?8dIvqUU7xbImoiJE37HZnzzFgCoCgLl6VdoqlovSApcP8CbTFvry8uZ2Q7eK?=
 =?us-ascii?Q?XkiV/4jsjUvJrBbOPo7RnxeBFcBrKHZ5WmYQ9YXpuj587Lw8TmgXeSoDg0no?=
 =?us-ascii?Q?U/YxWWIwdDnCVjTnG9mzlF1bp8KYUq2PirkSTIUDnwZaQ4cU3Bif4o6Thu4u?=
 =?us-ascii?Q?4jbCqUETEFsSvna6Q0i2S9z5qtRmN6eWCdmPJgyjrHYXZ/hLOoFkzpGhh3NW?=
 =?us-ascii?Q?7QJwsNJZsp1pAstdXgKeSOsJraB/hpynRUUUQ/+Ec5HwNLRY4xccfirgnM28?=
 =?us-ascii?Q?gvyQHTRmoZEPuz30fblF3taHPzLvHT2NOlElgQ3sPO+ma2OUleiOoAk8U1ng?=
 =?us-ascii?Q?ZQcL3bY0TFzTg7Kk68323W+fnEgiGQDIjQlOLpir2pofkCszRh2Aks143fQw?=
 =?us-ascii?Q?/TlPzmXCbJojYP4g9duYqGIUQwuSsGt2BMJZeo+3HM+8vvlyLe5M3//6buoH?=
 =?us-ascii?Q?aLSR3wbkd4fX+Wjp9LC7ZS9dUHmaVV4Wynnoa+Bd5RIzAHZwt7vbTqYnrA2w?=
 =?us-ascii?Q?rkk2NUECeLGOSADBTGLjWJQS6s7P0SISHTDzwDr3xEgDFVo9puLPmMOruZDv?=
 =?us-ascii?Q?2D30hjJ6E2ValaaDzEa6QLY5xdDurY3HZGuNf2W8z2nPxkmgLw/j7r6z/m2n?=
 =?us-ascii?Q?U5+D1jfxjVEIBekDzxzHnsav4R8G++ZNnJgOeOWBn0ORh4JIthRLhiBUji2t?=
 =?us-ascii?Q?Opn2FpHm7so8AUhWuIxJK6dCKW79YioXQG4MDVsFWZoobSX+xGBbk0shzzD9?=
 =?us-ascii?Q?bJ1GifeqLZu1LneCjHowWRpakFnfyT3SRqDPvrAh5OdqZDcaWzrH9XJ7e1x5?=
 =?us-ascii?Q?D1YR9RXNi08otK+fKQ6sPqvjw1E4cupAk/yDYBU6eieRbrsRWwCAtDgTNtWa?=
 =?us-ascii?Q?wS4+x7fiGI0O4jEsb8SExA7QX+LkJtYcE1i+XsSZMOvtlvLW/FHU5KIR55Nu?=
 =?us-ascii?Q?oK9EhfNRcb+ftfzTLXt9y3CbEN5mNQRaLrepcH/e8rFWtlbNkVfYHEYB5t6i?=
 =?us-ascii?Q?xzPR7RmUYtMjyZGxwADXXilqoNtOdg9IGlAP7jrg/tAabdFlhMRjattVvmkJ?=
 =?us-ascii?Q?djRvqV8+FdoS6haYvr/qRwtXHoKmAmaJx1AXE91y/XNz+zKANMyI1i1lcHFc?=
 =?us-ascii?Q?zaNzaxCy0PlKz7rxCV0hrstE5sMb2TXSJKhYnPdw0p+N55XrqP4mGIVuHOU5?=
 =?us-ascii?Q?4ZQW3JU4RBwp0sfptbh6lnLvPqmJYUNmcZygPxGyOmKDUuFPzjXuNgLpFWOy?=
 =?us-ascii?Q?otFrzujIplUaDVcixgA1EZqFU2Bb96838lqGimGpaRpt6PSd2ikdPpc0rCOS?=
 =?us-ascii?Q?xAYwPJ/jNojNi76c5PrcHKIs/MwGqq1LAYvOeHFv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acbae87-b14e-4c22-2a9f-08dc02f648d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 13:59:58.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21H689uRGPgxOvBsRgIFfhNhjeHQiUYPOJnVVb6JV+iO+2qds1waSyfKNTKvw5vb36JQm6TahcYrIZnsu+UhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

From: Benjamin Poirier <benjamin.poirier@gmail.com>

After commit 25ae948b4478 ("selftests/net: add lib.sh"), some net
selftests encounter errors when they are being exported and run. This is
because the new net/lib.sh is not exported along with the tests.

After some related fixes to net selftests, this series introduces a new
selftests Makefile variable to list extra files to export from other
directories and makes use of it to resolve the errors described above.

Link: https://lore.kernel.org/netdev/ZXu7dGj7F9Ng8iIX@Laptop-X1/

Benjamin Poirier (9):
  selftests: bonding: Change script interpreter
  selftests: forwarding: Remove executable bits from lib.sh
  selftests: forwarding: Simplify forwarding.config import logic
  selftests: Introduce Makefile variable to list shared bash scripts
  selftests: forwarding: Add net/lib.sh to TEST_INCLUDES
  selftests: bonding: Add lib.sh scripts to TEST_INCLUDES
  selftests: team: Add lib.sh scripts to TEST_INCLUDES
  selftests: team: Add shared library script to TEST_INCLUDES
  selftests: dsa: Replace symlinks by wrapper script

Petr Machata (1):
  selftests: forwarding: Import top-level lib.sh through absolute path

 Documentation/dev-tools/kselftest.rst          |  6 ++++++
 tools/testing/selftests/Makefile               |  7 ++++++-
 .../selftests/drivers/net/bonding/Makefile     |  7 +++++--
 .../net/bonding/bond-eth-type-change.sh        |  2 +-
 .../drivers/net/bonding/bond_topo_2d1c.sh      |  2 +-
 .../drivers/net/bonding/dev_addr_lists.sh      |  2 +-
 .../net/bonding/mode-1-recovery-updelay.sh     |  4 ++--
 .../net/bonding/mode-2-recovery-updelay.sh     |  4 ++--
 .../drivers/net/bonding/net_forwarding_lib.sh  |  1 -
 .../testing/selftests/drivers/net/dsa/Makefile | 18 ++++++++++++++++--
 .../drivers/net/dsa/bridge_locked_port.sh      |  2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh    |  2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh    |  2 +-
 .../drivers/net/dsa/bridge_vlan_aware.sh       |  2 +-
 .../drivers/net/dsa/bridge_vlan_mcast.sh       |  2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh     |  2 +-
 tools/testing/selftests/drivers/net/dsa/lib.sh |  1 -
 .../drivers/net/dsa/local_termination.sh       |  2 +-
 .../selftests/drivers/net/dsa/no_forwarding.sh |  2 +-
 .../drivers/net/dsa/run_net_forwarding_test.sh |  9 +++++++++
 .../selftests/drivers/net/dsa/tc_actions.sh    |  2 +-
 .../selftests/drivers/net/dsa/tc_common.sh     |  1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh  |  2 +-
 .../selftests/drivers/net/team/Makefile        |  7 ++++---
 .../drivers/net/team/dev_addr_lists.sh         |  4 ++--
 .../selftests/drivers/net/team/lag_lib.sh      |  1 -
 .../drivers/net/team/net_forwarding_lib.sh     |  1 -
 tools/testing/selftests/lib.mk                 |  6 ++++++
 .../testing/selftests/net/forwarding/Makefile  |  3 +++
 tools/testing/selftests/net/forwarding/lib.sh  | 12 +++++-------
 30 files changed, 79 insertions(+), 39 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
 mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh

-- 
2.43.0


