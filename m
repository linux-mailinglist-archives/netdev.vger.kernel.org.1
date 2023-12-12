Return-Path: <netdev+bounces-56527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060980F36A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830411C20CCA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00287A222;
	Tue, 12 Dec 2023 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="glQIkI9v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0AA8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBhw+EnVulfHun9LTCW5G7NreT08wY8I+Jmucc0rEyLTzNVXEdwA/5njCrRGelSfyXIjP6nCKJ46zY0svv488CLga5K/thkmlG4nvZbrEtNxUvsuHuCpUI/bTNyWQdNhPjr4L3J9UvOaDBY1oTfyBKWDwXmBRMYeZIsz+2C2Rq+PcxiknE6s/WaF20E/gOLsZuxO/GCUosK5kg8cHS7k1v0xPCGUZeKq0unxGoM6DkDI1GVLqXwfEJrQzoryN9bIKMkItenehLl5Om4K8CpGhdte8DnYAuJp+lI2Z/pDWPXbL0ZUqthY/PEMb3sqf+3QIa3cVkmEIABUBo2z9WH2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8avFhKkeX4yghMmBOGwn1F/uQfjk025LQrBsAaNKWx0=;
 b=i1NaHhkXf7k46n1fh6qORa9UWK6nX7DJAImcvNxMKuPZYE201bH9tPu8Ckc96kjUVknljfJ9n0Hd/UeJpRmJPKSjO5q2y8x3eUHUTvFosxnf41rZg8iRZoCzt0FSuXtYim6XWWLsFO4SyBwY53UobP5oQdxDJB8a/6JK6B9fWyIGumBONveXvLZrplPEa6E9HgK2q8VLq9MhJWKT42MnHqcpsHC/0kkKn4Un9kGoPeW7NvsisaXeu7zIJM8qmm3836t5P3J0xYtKSx1Cb0mP08cynS6PKPIE2kNOqimsdLN/AQe1IoGXLysUMaguU7kZSI1NoX/yQ0m0VBZO6QbtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8avFhKkeX4yghMmBOGwn1F/uQfjk025LQrBsAaNKWx0=;
 b=glQIkI9vh+ycEMtKlHNctWO2WYMw/V8HEwPU+RTEVXjhghP2rrC6U/wF98PBujNi3W1Jf+nzk/lSRaKB82otRMtSvs5OK05on4tRSnZg2beYD/NuKMx4AOgClclBAiexqXgoVx7lJ4mW3L9IrrjbtP+BVEgM/+kkR4DUfUBSAV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DBBPR04MB7641.eurprd04.prod.outlook.com (2603:10a6:10:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:43:56 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:43:56 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net v2 0/2] dpaa2-switch: various fixes
Date: Tue, 12 Dec 2023 18:43:24 +0200
Message-Id: <20231212164326.2753457-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::27) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DBBPR04MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: d384c1a0-0438-45df-0d20-08dbfb31882c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M2FTdXbv5Po9m0BqnDRI/Oi6i5jBAcm4FX67wRXY5ThsZ4+UzSvVDfchuRRyN+D4O/S8auPo52qrTsP5YlYuCSBrWL5V5DC3CKqHgWKUR/VKrMSwx1xaIq3qdYJ3VY9GHPMPoPq6pR/75niCMxysyNQIn/0ij60vS3sWD/uCPYEBSYWFkObNUMj1RYVLP3Rx5dKrVBRWG5L/4IeIe3I1JG5+M0xoWKkdR9H9W0GSghowiGCJUUtZmMbmoLzFry6YidlxNLRRbXarBqd0njY+ynq3mvKTt7KiqPczXTzOwN4oWb6fSXXJenbi2XB3MBQJRGijnVfM3rdfRZRxO5X52jEMzPJrTODs7kL4oSquzaLUWs4NLEH5PXW4jvYxsHpqcMmTimgh/v4sIZ25O2wxXqkZp3rEjuHo5Nji/2pLhCYb2Mw06IXERZFZ35sNi2CK2rVlPYd70qMIPfNdgXDWW6ap0e/Inek9nSqLQx55TielilqObEXKflwwjwy1VWPLNNCsYdfHsTSrevdlLVWXdutH1obfRj2/o1c99u3rFHhNhBA49xvBTCoyKH/bKfUs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(83380400001)(41300700001)(8676002)(4326008)(2616005)(8936002)(66476007)(316002)(66556008)(66946007)(44832011)(86362001)(1076003)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(4744005)(2906002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qlpt9lMEPMoFrLT+t81/exXjRXVynzKr2bMunqbyANuHUzbmDv/uN5wYtq7R?=
 =?us-ascii?Q?0+4R6PgNTXGR557U5ADDmC6WG/MVxMXD8YiBZVLn/4+SU7LU14kMFV5kKgOn?=
 =?us-ascii?Q?2pa+FVkkoPaN0xLOKuEKhbhjxtwextdyM5JaEI3nknYmcmJQDCyco4rRs+Ia?=
 =?us-ascii?Q?rO+CDBtS1AmBrFxQET17Yj4ixBfeELp5NWSX5Eo0/KMqAz1wY6plbh8lTZnP?=
 =?us-ascii?Q?p5aGjC96t/QMIXoJHKMHNJCcyo+C1+iT7DySVIDBsQBiKevtG9RIZR4jJ3M4?=
 =?us-ascii?Q?QvPlEt9U/eljLj9IaoKvNJVU+4w/+dOW9L2ih6J/dVEo6rVAjxUB/IfYJ0O9?=
 =?us-ascii?Q?WLkA3IL0Lr6di3jhbv8oOvErAHQ27oTbOvwccZoJpuLa9iviFU9qhvAuBFN/?=
 =?us-ascii?Q?wPm9FqhNVmYyMdiC/ZtBofR6ZfS4rd+5ya9fGVJQSC9FwrnQvoVajXQJAXm8?=
 =?us-ascii?Q?cqlEdQa8+l6NV8zp8lSCLYIxYt8r+FtLAaQnXrxSc1e4+RS13URvi5x6PwaX?=
 =?us-ascii?Q?DTjlSX2GucZfaaEdkcANtzq/b5wd+RW8JuUF1vlIqC+G2mw48rDLk+ecMsvS?=
 =?us-ascii?Q?VUmJDITzfoIT52/eqUSakUmXjoJ4PAH0x85aifWV5VmdOwcQ1Na6G2Lbgpmq?=
 =?us-ascii?Q?YC3CSrXytrSNh/dzBwo55A8YMtBIT260XgzupvJ+emkDBDlQM/Uyv+ZEUtiz?=
 =?us-ascii?Q?01pJVKRCe2dBJ/lCcNjr/GRdMwViXoTOjUwT/gIG+hWuwUzHzx4ETqd9BrO7?=
 =?us-ascii?Q?W2ipMM52exFjHpBD2hoCMcLPRMDM8euDeMcuqpwLzc/fHH03p5MTHe/6hLsa?=
 =?us-ascii?Q?qcIzESyC0zGxRmhlWtnVedQJcCNBsLrOkbDgBgnuKt5cqwg/34I6ZPfx1qvQ?=
 =?us-ascii?Q?iTei9ebG/xLmR0HlL4wcRTtWzjOwYP++vMsWK3zjOMVzjbU5ev5sQcq96jMV?=
 =?us-ascii?Q?rn8RsEeLY7m4gEzjbtHEFrSarX9LIYnjv/KTfADeKo4DkdyVRLde0+NlKu1y?=
 =?us-ascii?Q?uhz/2yEFAncnFG3oz83PV+B2etN/jIXQIoaqDwgIg7tuAWMd9QTPweH07/Zh?=
 =?us-ascii?Q?l5RYGI7S/XJtb/aTvWmfCb9LbJnbJkqJISf9QLEjthpepYOE2upyitYQevLq?=
 =?us-ascii?Q?xeEh5aLqGos344EnpxhWatBDY/IAQc/8j9Ra79TQcPFEHijieDOsY0bxvWFO?=
 =?us-ascii?Q?HxODco54Uc1Z+f8sU472bz2FhXP+zNbHumTE8GRq2IRfWTmbOOl8UDlWzNHX?=
 =?us-ascii?Q?N7/nNdn1NGh+tcI662bGCpl6uOFTgbBmGy7JTRj7px12iUIeeJ+kS8rYgEl9?=
 =?us-ascii?Q?DTPEItZa98H1XoDn20ZzXtCOgkVH5LaX1FJhZE3CRZ1qLjJVyqetso/Zbei2?=
 =?us-ascii?Q?ECZ0KHujDZBOzEMh+XEWgWTAHfPyexjBn1ovrY+WTGyt8ZBVvBx/TMbxGUU2?=
 =?us-ascii?Q?klQPv2pgdEi0ERlttmhgJA40N5QP0xBV3dbAFQbwOqaeodOXggVTc0gjEo/9?=
 =?us-ascii?Q?xlUNrSQ3EvRi5owi4yhZsNf9ZQiC9Q8ICfePbStWZaaBnmCGSLG+IvSO02eP?=
 =?us-ascii?Q?NwrpvyOhzQzoZRJdCvR3KYv0mfxWLPJdMDK0Mo8H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d384c1a0-0438-45df-0d20-08dbfb31882c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:43:56.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: munY6s9km0YK8enhDU10ZoGPw7+hUjCaUGMiNSmkBRPIdw/0Mexniq0DpsCrRe1qFAhdpOvrjXx7Jd6DZ4Kk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7641

The first patch fixes the size passed to two dma_unmap_single() calls
which was wrongly put as the size of the pointer.

The second patch is new to this series and reverts the behavior of the
dpaa2-switch driver to not ask for object replay upon offloading so that
we avoid the errors encountered when a VLAN is installed multiple times
on the same port.

Changes in v2:
- 1/2: Fixed the same issue in the 2nd dma_unmap from the remove path
- 2/2: Patch is new

Ioana Ciornei (2):
  dpaa2-switch: fix size of the dma_unmap
  dpaa2-switch: do not ask for MDB, VLAN and FDB replay

 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c    |  7 ++++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 11 ++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.34.1


