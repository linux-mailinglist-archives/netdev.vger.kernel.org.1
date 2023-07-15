Return-Path: <netdev+bounces-18059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21F75478B
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94211C20A21
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794551117;
	Sat, 15 Jul 2023 08:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E857FA
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 08:50:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2106.outbound.protection.outlook.com [40.107.95.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683EE30DE
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 01:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrdRCdM4yYF85oIxdBwfKF/R9ME0pxB6UexEV2yL9mZZsbnA0i4X0FZzgMDun/zP8y6rKWnZ13XBk633dwcKz8/E4a6qQmbwmK0Wbu1UEhKPH8nFG0ijdbY/NGFlu1cmSqegMTmLWu6c3TXGIuX0+2x9IMcqlNQXqrt8acpQBConHRUoOwGCT2ctkdWjuVtLZedmwfx8Q7viUVM0IhH76rcy4mb68ouqfCOymHK6EvUqJZ7Uk3yluPVtRUMC0ZtktAqh+Z9KG3pLrHKICWygDaR+ItfoKzsJ/LrFH5R5V4WoZ0J+SeX/CzGmRr62exXj95LiLNxR92zAW68U4M1Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG7yB4ZEvO9TP+Gqg/r4sSZFdeKbum3Ew0tmUEwHnx0=;
 b=LBj/rP02ij91cM1QZCOWXwvt1WSyhDt+rAOtKpUTqy3N8BkPuvL1GUUsCm2H1a00ZXgY5gFqaMEv3FfRJ9ce8g6IaIo5pCS0w10VMDmkdpsTBvMlc2VwDA1gcoMVCsZW6/dAH5R721dCfhx+7dKYUeV8OZx4AedJlfAL9m6VfR4GWZVxHTzQLqHccwYjJ6xFp/IayoYhz0vnfZkczwmt6VWMoHv69Wy1jQWsadYwjH/TTX/CDv2EgqLVoOqmBKsX/TYeBZnQJ04T1pqtKtItCLVsYj6xCJ5DUSYT9CaUTsU1mx0t+n5Q8dwpCPhsMpW6qXDph7stYtBO2AUa8Hv6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG7yB4ZEvO9TP+Gqg/r4sSZFdeKbum3Ew0tmUEwHnx0=;
 b=cbK4XbvtRWxEAkn6u6lsWPf+n4VWGP8mQD4lGQdCGihNZBDL5c7vdkIc+q//vxto94LwKDnQjby/RQKsxBW7B7GItoMmVIoieMlZ7PyoN4ZxjuKSq5L5OxFDQEoZwzVHsNWLXFy3zWHhKoDUvjOdfuLmsIP5yqmBsYeEekhuHPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5143.namprd13.prod.outlook.com (2603:10b6:8:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28; Sat, 15 Jul 2023 08:50:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 08:50:12 +0000
Date: Sat, 15 Jul 2023 09:50:06 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 00/10] mlxsw: Add port range matching support
Message-ID: <ZLJdvjzDU+DvIQah@corigine.com>
References: <cover.1689092769.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 80beaa26-5693-408b-a81a-08db85108059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GojxbhIU8iR8SkKHzvm8b7c/XbfKX51mrf0/Pnh0XL/I/NYT7Epw2NjfEXMj4cxXz91ZMmAbQE/r/Q5mYAXyj/epTWTy50YWUHjV1BuqoKOBTIAOTIeCZNU4gtW2MGKgedfeQERueX/fOvEDAigZWOj+v4iiQ6oWFnE3ZzYhg1xZS6UuVkK1eGMYJ+ruliZj0XhV2pbiFLb5P/2PJ8Jh3+dxb9PBwnYmKC8U0rKbEi5XndVpZUR2elvdjWOiiO0yqtUGoCWj4szFFlBIh/RUoEj+KUiBsyU5KU7Dy3VQtD9a3xcSan5O6oFgLveaY3/M+chKKFQbo+6rybFSWDoHYbFJg9GmvVOleEHjB5L2j/eBL0gA+rTLgpB5oNt4wXtji9RYsiliLvo2Skx21F948OlAKkYGAUlBxWLeZzbPIHRXYxDipUPz5rFccoblItbNGCpzaAH/32nbdzVIDrjoq9RPD89BjSeVCnywyrsIAmJQ3frS80l7m+xDGV6VyMbALw79PxwiDcoGGik9o3q0aSviG6aGCJyJNGaiALUYDpWuTYfHuiS+tPgUAfHkI5xRml1gqAD/jGy5cLvxsjP+4u4ILvDXpynd09mP0+8fevqAN6W92Z+YxE18A2E3bg7SVnfhJZHgnUB9oqeDsDFkngEyoBz0Gx2QzzOoGxXPm+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39830400003)(451199021)(26005)(6506007)(38100700002)(478600001)(54906003)(5660300002)(44832011)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(6512007)(86362001)(6666004)(41300700001)(316002)(6486002)(2616005)(186003)(36756003)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZbf8thsdcB8H0N0eO8Q29WrQX8C68vBvAI9/tDIiJeJ6tSCPvuKCEhg8ao6?=
 =?us-ascii?Q?k9ETQCBr/bmJ8HIjOiV0U2futlP/A93YyYikwxcO+eCchbWko1Yqx1XPKgOr?=
 =?us-ascii?Q?OhFTUILLkvLo68owP+OrOSpV9EBPjvK+21U9pCdTE6ZejKw8s+Nwg7dioEaJ?=
 =?us-ascii?Q?rB0pv7c7+XZnr0VieII5XHrSPxlrvqMecM/l273KkwMt8dWxh/3lAmbxYCsV?=
 =?us-ascii?Q?Jg7zt/sEY/mSSuYdW7vCV6pPf27m8KqeSgfMbipId2vKyHRVws6ZGDY7F8+n?=
 =?us-ascii?Q?NKX3syN0+hHBMQraGPRqZnGZ5SWZoL1bU3In3Vt5ZOXr6Skyx7M0RnZ4ya4v?=
 =?us-ascii?Q?Y1Y74PAUBLECdCIFgI+MsiXwL2VqjXJYWfpqLvuXBjTZVIs6dyTsnyhq4BL8?=
 =?us-ascii?Q?XvRlNh3yPS7BWu27hSEOClo8Y2yqSQ25xrgDh+2GmoSu6inYHf4aD9UIYzFD?=
 =?us-ascii?Q?VKPVRC/ite7zAnCU27K8ycgDG9Qtp10o/PeLHZIUB8P+O49OV0Dec3wJf/lH?=
 =?us-ascii?Q?7dgZhjAvkfY/B5epUhGaFmauNQkc4MeSgGhQ3xeFBB7Pg6T9ZPJg7yHGa8jT?=
 =?us-ascii?Q?vc384FAtOatDG27u1KXcnE/KKv/FvOeIBgfpSZFy2eK+QYhu36qWphSOqRLS?=
 =?us-ascii?Q?8wHjsSJQB7D9pBEHB5S/EOIHCO6knCv6Q8krL1L50NnJ3sptSLIvP7ZgOPU8?=
 =?us-ascii?Q?ZyTnRTWNguIG4VDMU0RBqpM1ic2emlBt6u/UI60RuB74PwIhVlnhuSNISHXe?=
 =?us-ascii?Q?vtSw5BZK7nHLSKLbXNZofK31GilzCeEij5tmT+yA8GQKrqzMv8Ul0EBt7ML7?=
 =?us-ascii?Q?Dq7DIxBCzJTjdGAabylzMIXG/n8ME4ZVVg+bMMdMrEfueQ6KZ3W/fHXy3UlN?=
 =?us-ascii?Q?cGqroSz/lhUOkeZUE55EV2gmPNKZePXbW4Jlfqf/cBRW2aU6Pi0GKfu8x+Tl?=
 =?us-ascii?Q?B0I1tHhZRdsKz30T3L8ydLnMa8PYkDyRgoVE96siJ82t7k1eUc+nLh59E/a8?=
 =?us-ascii?Q?Z5zQeIR0tE3Qd0xB3O2rIStW76KqzBcx96X2gg2Gfgj8yoblI4eMyBVL0rrt?=
 =?us-ascii?Q?AskQCMMBjEw3cPfHa1Vw9bDip/4vnRW4Djg5A27h+aLTxY1esuWYg1uA+W4Q?=
 =?us-ascii?Q?PDDr2ySsOII1f9AgGSAFpPSrTCIWtTHLRIabVJUBMWtMJiDRjEVCaQq1kygj?=
 =?us-ascii?Q?SdyMQp8F2WcBHdh2+v5GsR4UAm9nZHJaUhj+S6uhgBV9TEFb9oHhtBXFhAFB?=
 =?us-ascii?Q?SxMNNXUkQcrFZOtEI31NqsfZdgtbXC3ei/kQsBzd0/5UaAzvdZeb1SrJAUh3?=
 =?us-ascii?Q?c0y3+8mKYH7VIXQOkHpKY4JU8cnri2Zor0yk8WV0I+G8GeeOAN5dNitO25QW?=
 =?us-ascii?Q?Gr7+sAl7FtslTiun6dqEx1mJnmcPn4uYNsiVr/DzQpHNjbMHbnB8roJc+UnS?=
 =?us-ascii?Q?jD1+Ac4Ww7BWz1iIO0eHQx0obDt4yZFgX0vcq1cehdJJ2/gU/0lCUA9dOrJR?=
 =?us-ascii?Q?WsAhTVQKw+GBS243swEq1CX+GXgT0sxAQxGp6Nq1KPTCUY8Xn7NENiHklst1?=
 =?us-ascii?Q?g0pe5hYjq4B4CKiRbHGGwfl5xljBmor1gG2Su93a2h+lD49hzHDQ0m/Q1srL?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80beaa26-5693-408b-a81a-08db85108059
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 08:50:12.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjZGoxNv9Qr9KkqLO4v7kBFqHV8NWIn7BIS+xGaZtjuDeZGWQFj83fbgYkdF8mOUKFjE+PSGznuIl9P5nlWeuDtipeGkyNSwJIqLnSLVK9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5143
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 06:43:53PM +0200, Petr Machata wrote:
> Ido Schimmel writes:
> 
> Add port range matching support in mlxsw as part of tc-flower offload.
> 
> Patches #1-#7 gradually add port range matching support in mlxsw. See
> patch #3 to understand how port range matching is implemented in the
> device.
> 
> Patches #8-#10 add selftests.
> 
> Ido Schimmel (10):
>   mlxsw: reg: Add Policy-Engine Port Range Register
>   mlxsw: resource: Add resource identifier for port range registers
>   mlxsw: spectrum_port_range: Add port range core
>   mlxsw: spectrum_port_range: Add devlink resource support
>   mlxsw: spectrum_acl: Add port range key element
>   mlxsw: spectrum_acl: Pass main driver structure to
>     mlxsw_sp_acl_rulei_destroy()
>   mlxsw: spectrum_flower: Add ability to match on port ranges
>   selftests: mlxsw: Add scale test for port ranges
>   selftests: mlxsw: Test port range registers' occupancy
>   selftests: forwarding: Add test cases for flower port range matching

Reviewed-by: Simon Horman <simon.horman@corigine.com>


