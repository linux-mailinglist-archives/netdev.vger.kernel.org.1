Return-Path: <netdev+bounces-37254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8F7B473A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A220428188F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCE63A4;
	Sun,  1 Oct 2023 11:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DC9CA66
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 11:41:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2117.outbound.protection.outlook.com [40.107.20.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE2BD
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 04:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsLOUj6CaLXNIxLikLWCEqkzNQqbEBwZKa+sWeqCzoHt36t6v8eJr7l3J7P8HKAS9a/5ZUHgwm+9A8ywO+kp+Y/U4AHQF75wDukzh4MKahYQpuyd3u/CDoTl7vE3fiCFXYUgZp6cA81tiRcU1FFVg61BfjWZFyvZ/8/5F1agoBVLT5jxsp9cktk/eIQL2ynYkKaVtjc7aIGblwCw2eGCviNmq4nCma1Z5eFRtk2o4eK/wUCBbvlYgX/5F8vM+xsGJPtEy5vbbNfP8KsdOPQmNiQlBGWEeFr2WxDE2AZBFnQAmR5+zyR4d/H+tELZl7C275SfVX6MKPJgpNt8JBijEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhup2zizJRIr2ZUCCVdPbRY4T4koZmtvDIlj4lZXgHs=;
 b=oaU/NvThpEVny2FABBPWq8gkvMhMvuwo7c6uDgaA4yc8f5vaSmL50J6NuaNbTZQnTOeetEwI8gv5f8F+j6TVb4oX9uGwglBeOeJ/4eGk1qZtZ57kP33h9cmzo3KqsfLsquY9LfB+wZLEt5MtxGe9YXwzMKXG2A9tq3ObGWFmJv3/3J5RrQIwwhuTHhbJa41c6NrGD5bRCOscrHE2upA+vp4XY4fqD9vkSLndXsNe5Ru25nuqF6LsKViBrGbYlQ5VpJakW49kiDUYY+LvuCkjvVBGYL5T3Ce/ar7ABGxMleCDM3RML2ziLi28DmbYUzcUQ6+hQnl25NXq1Ax9L11JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhup2zizJRIr2ZUCCVdPbRY4T4koZmtvDIlj4lZXgHs=;
 b=JfwvkuVy2sojq+2+6cGkk3ZSrreGkGRDyD7Gg1CCr+25YaY/eHeUD3g0UGtI8fNxrHR7dRgkff3uBCQGKXPN/mPDQ5xiOkaU/avvdSUf67mybp37/XJLxq+YhnE7dhKJ0Qy0N3mYQrTirW9K08EwF6wZ4MlDsqGou7GtSzME8yU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DU0PR05MB9679.eurprd05.prod.outlook.com (2603:10a6:10:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 11:41:18 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 11:41:18 +0000
Date: Sun, 1 Oct 2023 13:41:15 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@linux.microsoft.com
Subject: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DU0PR05MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 69172017-da71-4d44-eaae-08dbc27353b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QQKYzQQJZhU7/O/FWVCMyGjB5QJ//a5JhoMm6uBkTAJckdo3xLXLc6IeX3OSYj5Y8lB2yj9g+s0KvjMey9AobFDu7z1e0B+M5FzjYCfr3JDWvUN6dRlhykOAOdrvbbQaObh+kzjeBKklfGz0BYr97XNpw3z6BVWXQcwBXAgVPiHBtOLp2SZG5T7jm1ZKkdboLNU/aVmHtRrqkVMRwpBMNe8bualh6q05UR5zNJ6WmnErP9h+stgsj3Gjx5UShaVpLJyNtQRZq2oR6W+qi1hhtZwkYDaAAc1q80R/uk0KVvWjzNto8hIyacGGKcDKAFckWwUBtnFO5jTRy+dGPgzR9dDh//S5/sZVYNhUMLBiWJv/39PFJEJPicrS3gTU5cHfRrXmfmH1OeO40DvcAYGcuKoPkHRnQjKrNjuyxkvF5BZEdDfHGgHc0WEDvJ6XiylzCh5yYn5KfnEQFl2VN20KUUtKDQyiw4C/fS7AFFr/lFN0SvggfG27BqN8IxUJ+CJ/VvJB4/jksOhlm/qXx8s9K8H1J4vFuuUNd1F3WB6u6eBUgBv8cJYjb49NhTIsYbWp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(39830400003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(66946007)(5660300002)(66556008)(66476007)(41300700001)(44832011)(6916009)(8936002)(316002)(8676002)(2906002)(4744005)(38100700002)(33716001)(478600001)(26005)(86362001)(6512007)(6506007)(6666004)(9686003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zY0+mMy9qHps3SzPky3xTORWEC0DBh68ym9roZTj3dZZLjg4VerA8+D4suUy?=
 =?us-ascii?Q?LZxU+xeNQIUICk9FudmkG11Qa1NWtGl/Jy0n+71Caxdyr1OgaSVUIl/2eWQ2?=
 =?us-ascii?Q?bBUScIiFMeJgN9lQDgrn3Ht6+mpKwKRV3gtEh1mgFSfPvlQ5+kTL2ffx0Zof?=
 =?us-ascii?Q?Qrgre1An1QEk+CbAqcFQif8xd/gBGx2c8UozCbUMcludK+f7EzMHb94gjaYQ?=
 =?us-ascii?Q?B1MPyWQFB8kzgES7Qls/J3581qg5foQYF/IYZlyv6XZN5BtR6dUAhfNP1gea?=
 =?us-ascii?Q?8aUIQWPpKudPp7SKnyPYq/rEXN9vNE7TNp9irRU9g0y7ZNGJPwDc4kIu8STx?=
 =?us-ascii?Q?CShwmCZFYxxdGhrl2i6UleQ54LlfhwMrCd/CraC5i3o0BPH4f+6aWoNl6Vgw?=
 =?us-ascii?Q?PCryzga7TohNoPoNZ9PC12GnNQ6FUzm9bZ/uL7xcMa4Q9exxtAL5LIHxz8P5?=
 =?us-ascii?Q?ye3994RiUiNwP0Nwb+YkOb4ZARlEA5u5LS03Xv1eOEUApexgAMeOUv7gu/Qd?=
 =?us-ascii?Q?GofWZyaVNVbXoizEiuZCYFLNaWo2rP9jfOKWpS0asC3VNdzahdSwU9rag+Fv?=
 =?us-ascii?Q?/qeS44EFpcFgXnJjbBE8BdnYt2j8QlYJLtAdh49cJ91W8LOo/WU70sBXOOjw?=
 =?us-ascii?Q?LcncNXt6Qb8JBIHSWlaH+69w6vJyv9+oiUhX4tAdfS5JCSOkEHZhwEJ6W/X5?=
 =?us-ascii?Q?ju3W9VkbEw6Hyu+sfoLmNe6nf/GLPkY3ctmLB1v3RxuQrvrYNPdA1lkyz7v3?=
 =?us-ascii?Q?olP1gS75bRXbk819xxETlYcSyGiGTgwaXZqxMZbej9O3dtySJtReMaS9oiMg?=
 =?us-ascii?Q?MS0G3V+bxotgLgkTV85yUznimjSCvz09zOVbLL21GxhuwlKIgnyLHIU+1x9A?=
 =?us-ascii?Q?QJdzPeHjy9F8XYWSchIsQBnjOkOLedW5d3w+xhc+u1QXdL15LTitITFcyD/g?=
 =?us-ascii?Q?VzEBvXNW1nEdj9R+QCOO37qw2nf53ec07tRFpOXLN4KDPLVS2nuEJG+oUE+7?=
 =?us-ascii?Q?JFG42Ad1c9wh7kBoWMqAruOGybfHcRwNwYisP/NFct7tLSZwpWlctPdeqSoK?=
 =?us-ascii?Q?bqT3AINZoMhy8b2kECWtENwifOuqgiZpI7zcMJGCcGMTN18iYotQ2FOAGsg0?=
 =?us-ascii?Q?49uJcbZsxfZdlupC+appon+Pl/rxA6c2jKb7QfHOtUjONqQJULYiHTkx9jOj?=
 =?us-ascii?Q?qHL6bwt6q7y4opk4O3eEJkLMJrAuMBzqtmAVuFwAee96o0PUGXtX2wrAk7yX?=
 =?us-ascii?Q?zHBV2CFjO+73qsLfJUwAIai3wCUqfhu2F/BXCy1F1A5cPfUn4i1I0/2taJll?=
 =?us-ascii?Q?hcI654zW7/49NXL281Rc3JNJsh9fXK25ptlT+A2q9GTHtsSo1Myw3ezUPYfy?=
 =?us-ascii?Q?I9QkXL6qyXesw6f4OMKrY3nLXChCqjSBECRw3OOy0ea3MJBgNBJVYNUQ2gF6?=
 =?us-ascii?Q?48DOCUL22WImcUJyfderDcwnaS5Oo61Eo5e2+e5p5Oj8Emn93l/01/CRRllt?=
 =?us-ascii?Q?b4lAIGXkC4dXSBeLbM2nwjQlqvZqtSUSEHS5PB9dCMOHftZO7ygxo/g+/SgC?=
 =?us-ascii?Q?a35Yb2xHrkf6geN6KaCjChy6yoA1wP9vQIRxF3B4z82EPlnA3g7XUz69lZHv?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 69172017-da71-4d44-eaae-08dbc27353b0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 11:41:18.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5mkpyAPTypgVVhIe+i/EVdVLJObnEQbUWf/JPz3NadhWP5+91U2P9bUAnjO5OFrawu/H3lgakVITvLAP59cY5dFLLoHDwhEx6PoW7bjKls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9679
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the page_pool variable is null while passing it to
the page_pool_get_stats function we receive a kernel error.

Check if the page_pool variable is at least valid.

Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2396c99bedea..4c5dca6b4a16 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -65,6 +65,9 @@ bool page_pool_get_stats(struct page_pool *pool,
 	if (!stats)
 		return false;
 
+	if (!pool)
+		return false;
+
 	/* The caller is responsible to initialize stats. */
 	stats->alloc_stats.fast += pool->alloc_stats.fast;
 	stats->alloc_stats.slow += pool->alloc_stats.slow;
-- 
2.42.0


