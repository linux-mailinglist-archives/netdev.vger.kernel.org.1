Return-Path: <netdev+bounces-55915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D280CD92
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01171F212C6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0879487AC;
	Mon, 11 Dec 2023 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PzYRi3VU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302E9EC8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhtb8cE8ldFTu7PbS7+RuHIaGABlmZpQ1lwP6X/F1VqMyM0yBTxLp3awEApt11f3reOyBxOzGHcXWJO60E39JP+FsUj/10mCBeo+Ns1rdmwk3AZ3GUv+/smUWqV24zrT+OHCgrTuYampo39+k7cJ+DrmO0CNcCGDxS+LBka8TPCkFtCn4XaXbjyuFTwRRCcn7ecmm+0Xvs7XtacG6aIqcjEKNwicLuxTX73yHhlv7khI+65ChOt5Pgw8OSRMo3UOtJcpHXYASpDguM143v7yHBavybNw0rMkKsWMWOn7KK61+tZKQXZFt/+pMOWcDvmhdgGKNo3mHg2gA3e7fL5rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAb0WMr9jiun2Myj1tk98jS/ef11/WgFrUsMtXBWQYE=;
 b=WNqrObNb3EVre0+1XFeawUe69AryVJHcDVSotAmn6b+08Yetm33mrFtnSo+IO/+kXK1VLQAeTeeMgrIFnZSSLt9mHm3TVBZGurvuzE0YE4zrHf6z8qPzkVw0rW0pb1i5VUABT+6BbRvus3VuYpZ0C1K8pTOPpRYBwwzaKZzu2ax9OQyF81or958dREL38G/3bY0Uz75eNfB1ZEek/9B08WIavqx/+ZPmhi5xz40F++Sc3GyBtGsb/Es3ydtszQgfSPY284D58lJAdNhGk8yo4MGkbzEeVt/irbYdhd77TDcO9DGbu5lXf77k7C3MbfW42qZwUhXymlBd7hwG+CqylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAb0WMr9jiun2Myj1tk98jS/ef11/WgFrUsMtXBWQYE=;
 b=PzYRi3VUrCWejbt9ORmAgoTlEKm4i9N8sns99VOQk6W8zt2H+/WASZwYj9ti6W6FLaD7RTO25dHJ5Xv3Iv+EaquBVBpc1fVhpFJWKTk1Ka1W2xXoaPxUvyaTNli4Lr+LvTREm95IY1gjP/VspUovaAXzGwbUetxs76X2obp6eVk/6h5NaBtUufI9GcP2YKQdHj/MGDIb8zSSJvUKnIjBTvORYDjqNJLm+VziPfnTeEgraBDLh9EJVP/TOVm9/SPCcdxYkqvclU/IDC1w/+NYXernVGe6dNr81NH28WjkzD2GKe+Gh+HMKYo4HR6HqaTGs33XI4Klt9nOZercYfmboQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:49 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:49 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 00/20] bridge: vni: UI fixes
Date: Mon, 11 Dec 2023 09:07:12 -0500
Message-ID: <20231211140732.11475-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: ede2ad02-bab2-497d-6463-08dbfa528edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+lI5FRp4FIRqyUnjpxgPUxGGoULZCrbNaHqekA4cax6wyCiQYxe+bDZZLjX3HBBt03X59PXxnkA881c9leGGjB11qyKqGBQsVz4wQJBsjZGw8ZOvk5DxW02C6XHrGiaptIVVAz/5JvNZtzb3pFqFbHC0rowQRruibROxXifGr6owa6SuZ3JGEu333MHsdRBbN/h1uHvRNqeQYXEe+U94PxDZZ89eYXHGiGilM5DZO7g3WoygE+jKz18+cSb/VEh5E7LSE32DnzXP0zN5rdfvZWkI9CzoYbr9L5jiOhcd/jSf0M8Lifabu4W95DN1IgaXnBP6UCRMFKWfH9g6DfBsBlbh6T4i4D0l/530x8GXbcVetVXa1JoMegsOBkE3i5eiT6zvr7w/2/Hm/0K6aWGOU8m0mk7ylzowHuEIVILYnhiauCMficV4fDHh/Ejrt+2UdJBd7kLCB9WMlYPoyYPbPNRpxg0TZtRIWl3F6c6OhmcfLy+U5pNyR838mqAUEFOWmv6YWRGT7O7ATbIIc3/eerFhFvIGB9RRa3vijW93DSuxwb9QriFGm0xpRAhfUc6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNyEHfjHACh4qnRO4Q5L0GytAQukXW/rI/1oUojRYurKVDEIMmdNAQThoulB?=
 =?us-ascii?Q?fnBfWo+ikNR0f2erw/vbWAzN+KX/iI9HwsoJ9PCN35ftSx6m+lqwhRK1nyT+?=
 =?us-ascii?Q?2NTsHAlZKsyuJhloJFEFpQ4+LNk7kgqxf6zBgyTIAiKYc4Pn7GJ2tjbvRF2B?=
 =?us-ascii?Q?B+pTKCvHQWYWpBMzEvaEhhBbMh+c2U21Hfl+yzxjmrQYud+keq17BmWfnQbM?=
 =?us-ascii?Q?9mPRIszZwtckpSlUybdXMW0q+tUwe1Of8TAi0zDov+GK5dOK9iG3a0VH5WQ8?=
 =?us-ascii?Q?WgRlMJsrtiogf9frCMkp+yTCqn5qFRBEfFfPwiYXPcNGljj+TCvpD7hzRS34?=
 =?us-ascii?Q?1499m3MuOHtXUW2X/SVBXvuRzxbEew6AEIxc1hJ5HrLmW5dRueGfZhhJghOS?=
 =?us-ascii?Q?KXjAjjcHlZWqpkCXknqXoP/07mS6KQDWz5LjHVjZBXc9mgTXIaY9yFUEECO6?=
 =?us-ascii?Q?REM5yQIEMrQxRfHccYmxY6K3PBl33HUOjr32Ou9GlpuRUY84BvPs5kvJK35o?=
 =?us-ascii?Q?k2TXThSwFJdQi8Ly7cwv2H4NZ/gM2VdVnXqMqT0QVnjo8os8hvdsBo8DWFc2?=
 =?us-ascii?Q?OpLnDXL6gXPuxaJVELyZKn7GwPwCI6bHRTQTB+Wn/kHneUqKUAIxd//7o889?=
 =?us-ascii?Q?nbzhKJwdgMHjMCf9zHC07192gDpcLqIq7wrKjiGSTTvhaLBxL+cxL9sXUWjo?=
 =?us-ascii?Q?G9N2Mm4HaQz/a0fiDgkSmGSxPvEc1jXKoHDh7PD5rkfjlMUupbkhXC1UsGHg?=
 =?us-ascii?Q?fKuwKVV0XHLZu57Lphxdc7g8GFSwYexzZ/+HqPkUav/XUkXKfJ/cpv5aXV5D?=
 =?us-ascii?Q?Dit77MX1Skmi5tVETPgTh6IYvaCkP/Gfstk6z8+rGJyLPuuxz10/jiID32eF?=
 =?us-ascii?Q?YFqydU/F+0nmUvXJ7MLETmMnbUiOiyyBx+pzme1vYaMoYUM2VUdln8kzKQUS?=
 =?us-ascii?Q?tFPLAmTG2uAPMPuGKxh8r90xx1UEZsfgT4dt4ff0hpen5P1MkLV5zQLUGb/R?=
 =?us-ascii?Q?upatzQ9y4pfQ+W3IIQRfskQQoiQOvXQvIS/9mq6ClZ/C+i2/z9GQ48d3uC7M?=
 =?us-ascii?Q?yQIToMRYSiG7r3Q+BiQ51eV5VMyZIZtLrG2mgcwOuI1ok8/ld+cB7VYbeFht?=
 =?us-ascii?Q?2W3EgTu9QbjhjRGmjjEU6n/etmYsa0+pmBvPw+7ZtsjIAn4yQh4cyUVE23QR?=
 =?us-ascii?Q?oYEXlrAfZmdhG0R6ljr3WJizxtSUZlPuv1yu6wezuBeKOeJRkowCFny9yBoF?=
 =?us-ascii?Q?+072iJz5l3v2slo6pImqecP7dJC8EDDrWkykxkrILz5Rg1Vl9SFiaVHpzL05?=
 =?us-ascii?Q?osph/LPhibFVymbbWaI/M/XuA25ZtYdozt9JEcT9mFawQbkM8ggZaW+Ku7N4?=
 =?us-ascii?Q?dzsC/UhPUyoOYBf6Nu8RNhlYpZuRc8FC/ZySvEQZsGlOKLoxuLDSsHVANMea?=
 =?us-ascii?Q?WskGU5Fef0XmiZiZP7Dno/AQgPI7TJ6lKRRO8QCNdRMu7TFXdK8MRdPPGOSu?=
 =?us-ascii?Q?wu3xgBNW2Q8YKCumjGOkM8UBjqalJ58+EBdtwKZ2+SC+zs0tJNhUAg+evKnM?=
 =?us-ascii?Q?FM4HHoAl/B6mwoaGMb2ZU0tOxONywhH9xakIIusM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede2ad02-bab2-497d-6463-08dbfa528edc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:49.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmZqfB3Qlm13lqBzojCY14Btsj2RFiabyX9zf12d0bSfZ3pwTh/hSg0NuulpWiw4gIIucEaiBBxQuv1Cl8pUZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

This series mainly contains fixes to `bridge vni` command input and output.
There are also a few adjacent changes to `bridge vlan` and `bridge vni`.

Benjamin Poirier (20):
  bridge: vni: Accept 'del' command
  bridge: vni: Remove dead code in group argument parsing
  bridge: vni: Fix duplicate group and remote error messages
  bridge: vni: Report duplicate vni argument using duparg()
  bridge: vni: Fix vni filter help strings
  bridge: vlan: Use printf() to avoid temporary buffer
  bridge: vlan: Remove paranoid check
  bridge: vni: Remove print_vnifilter_rtm_filter()
  bridge: vni: Move open_json_object() within print_vni()
  bridge: vni: Guard close_vni_port() call
  bridge: vni: Reverse the logic in print_vnifilter_rtm()
  bridge: vni: Remove stray newlines after each interface
  bridge: vni: Replace open-coded instance of print_nl()
  bridge: vni: Remove unused argument in open_vni_port()
  bridge: vni: Align output columns
  bridge: vni: Indent statistics with 2 spaces
  bridge: Deduplicate print_range()
  json_print: Output to temporary buffer in print_range() only as needed
  json_print: Rename print_range() argument
  bridge: Provide rta_type()

 bridge/bridge.c      |   2 +-
 bridge/vlan.c        |  38 +++------------
 bridge/vni.c         | 113 +++++++++++++++++--------------------------
 include/json_print.h |   2 +
 include/libnetlink.h |   4 ++
 lib/json_print.c     |  15 ++++++
 6 files changed, 75 insertions(+), 99 deletions(-)

-- 
2.43.0


