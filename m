Return-Path: <netdev+bounces-41073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28827C9900
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F510281671
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F663DA;
	Sun, 15 Oct 2023 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="ZQnN25/X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2033C5
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 12:37:33 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A7A9
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 05:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2E2JWgfaHVt/I3K8lZbf0UmVTtW3OQ9bzncw4L2fx/bTBvbJDn3U1mRl/CUppLMSvqFRUCzY9fDPT9wuFj89rkUaOdvUaRfoweSREFGaiVSdRtxGTJQtvAohL9cJsERrUtRkR566OM/vIURwejbHNaj3+7Ba1K0hSajKOJeMLKWn8I2mEXJnIm8Egkb5zXhIM7+58Wk84R4BeiL3G++XJY5N9jycbLCDruAP2sYyB08H03qhqF86qUEdPdvDyXbZ9QJy+XTQGeUgRbjYPThgmCr+LENlUOJC1/BUOZhDWBEj8M0w0g7XB6gD32onp9HiGvWFNHKdy8ILSxcHgr85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhNo5kCMAnhjKFvCYnwAh5t0U18szkdazU5fwIPNvIs=;
 b=hDF6wD7WAkKf8JqPODklqlh7/PDogNv561hEWl2TBQaoK6RGz1TtcnxRVaH9cVL7yxfY6epdYcIkUkwvLIu1BNbBG6E8Rr3ohn0Hu2Kis0JCbadXKpkwmdaJzpAEXTVS94d3bX0meiavJ5WpcqtTmu8pZwHDI7X9KYeMteqT8ZHtQxZflx0T7vgSAUciqWzaDLLdzmwsKkl908kaOnlqzFz6NBG/nrVc/BqPvLDEN+qNzqqxnruqV0m+1RMzG3nNxLoLNwx2cJRWkrTDCZr8oZcdNliLMRt+ETWr4miG1EUoF41qA9PLDcEnGd7xakWIJnzhSeXm6g9yrlEXdBcGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhNo5kCMAnhjKFvCYnwAh5t0U18szkdazU5fwIPNvIs=;
 b=ZQnN25/XXamaNQiWRosHkQ3fodqpGsJcJnIZk/LHfJjXmkfqch7uINOxq+7VcJwhVYhgH8BbH2ujg5jtukOcrOtyHNOTQdc8ihugxYRoVF6SYksJ7UknoWJpxMkJlvykTI4cWdqpRWeq2EIIEoO//GeWKez14TBP6Pp6R9CvFI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DB9PR05MB8123.eurprd05.prod.outlook.com (2603:10a6:10:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sun, 15 Oct
 2023 12:37:31 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837%7]) with mapi id 15.20.6863.047; Sun, 15 Oct 2023
 12:37:31 +0000
Date: Sun, 15 Oct 2023 14:37:27 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: [PATCH v3 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <be2yyb4ksuzj2d4yhvfzj43fswdtqmcqxv5dplmi6qy7vr4don@ksativ2xr33e>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DB9PR05MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0c750f-f0be-4430-c73b-08dbcd7b7f92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GfocrzJSRj9XjucJlufLdSz/eJxoUT/XUr48POu86PDRB69U+2bTSOiEtUGGB8iN52wdrGWjLfX/YmdNPwxR1YH0Wu56OlP+oL/OnWtBGLpNfllWQ0agQx1/AxrxeoyFLN4OuEvw6oku1InyRX7EACIJ2KdOGkHuXGD76q0Mu9QTOsUayGmpa0ZwGR/cunRLGhC6iRSem4F3vCRqRmYVBbKtSX/bV5Nh/2soN4OPPuYtTcJ+z8QlkK77erqznAM/op0OSPOMyX+dOvpRbXJnKZL57GY7XmksJMJ06dPYfPKke9Pm2DyvE6xtn5kOM9Qsvlv9hEUqyNIDR4Od7LxKsUWvzhIIM9CeLOIRX5BU9A8+RiMW9hcrgCiPKxNgYldW9oDrjpy4eg6j58Df5GmaRPo/8HIhGksZTqu5vXLhSj3+FPf0/o8v2LplL/yjUzqT5WLOYEFyG04GgErfRlzVfYoLO3WiOdu9qTPadKCJXGPqMgHmQmXDBKJJuXeKDZC1FKOaymM97ZItVRDub4/7B58HXOOAUOw3KFyln0H3IJsSDOQN+yziguvn+LyCSY/l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39830400003)(136003)(376002)(396003)(64100799003)(1800799009)(451199024)(186009)(6666004)(9686003)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(6486002)(478600001)(26005)(6916009)(316002)(41300700001)(66946007)(66556008)(66476007)(86362001)(38100700002)(4744005)(33716001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iqFLObmwyg6XdY6t61tgJOCIvGgRFlIrgN+V8exdy9+kSPdg32wUDb5hf0N?=
 =?us-ascii?Q?KWIiMeMGGcOIcWAguS2D22VPHgcn0Rn+PvqYxyYzKRGtKuYbOJYxkaP5Ll9z?=
 =?us-ascii?Q?i8Cx+L0zE8YAliIF3DELMzXF0YWAdVQGuY1wWKw20pjjS6n8z7aeqZSa7mYq?=
 =?us-ascii?Q?ho+bP7Y/z5JJ1OJhaHR0rPREWcCCd9micWLGGYIHL9i9x2CJvX0RY6G6V4yU?=
 =?us-ascii?Q?5b6UxvNvIwXJ4iJnt+C4rw6wKUgT3XVeRdx6j3xRs0XYIdGuPrwmlizIBrP0?=
 =?us-ascii?Q?CBQpzCndBVAd4MiRxSmmuf+lqdqPzHf1zrQYyKwqAtpkEJqamFO/3jIssEFw?=
 =?us-ascii?Q?xqei95bpjmoQTrGID66DP6rldjrorneyxPz57JGk4VAF2DrMHFbPN8jk7mx1?=
 =?us-ascii?Q?qgI2naY2J+/wBrNH6yttrJPMjcsiNDheaDIlh+1dKIpd25Tjjqq4+Nkv0/le?=
 =?us-ascii?Q?SQN/JZvuo6OQlOKDGz+SxmbbiXFZYa1wVd/tv+xT4S8qczrl6khmFOBNHAME?=
 =?us-ascii?Q?0ymzTdcnU1z7Xfzt6i6Yf89LyP5+V2AIKjTeD5mCWz4JfenbbiU4aouSPbNy?=
 =?us-ascii?Q?ofq5VbILCoW18Ex52PTMF8RPXM7VfRoJ3/gFbigO+7KX0PNfwFsczkhH97Ei?=
 =?us-ascii?Q?22wm4GnIYoUJcUj3tRyMuhT03xsvORwo8RSZ0MGgbWNgBQe8M0xhshP6gj+y?=
 =?us-ascii?Q?VwMdyWEkUQi1wrmIfpcQF0Ph2EVL1QtTCtJ+wARBElbWRp2cSSuDtGHBSYXS?=
 =?us-ascii?Q?cnu5J05od+RG607q77I4T3bJeuowzSiPykm7N5+byou4b8C2k9LnihoAC5bR?=
 =?us-ascii?Q?tiBp66GBzH305vagxOjAU1JbjjVTfSTo6QjeLtvXgY+JlBqWGk349R21MDLd?=
 =?us-ascii?Q?IW0L59xsMEs+wCqcsE1B+DRk5BmVe4Al8puekHspWkFdsPe6efRehAjG2zj6?=
 =?us-ascii?Q?vmv1RvYBsUEXP01qtRPQ9RL9LyJE46ahQIQNQPe2L6x3Q3GhOAVr7/fAib9z?=
 =?us-ascii?Q?hLtf47RhCFU3PfuF6Jr43nVaU2xwbcs1pg9BlpD2YwJ28cQshcsaM6dZgh3T?=
 =?us-ascii?Q?kGJLRlj59qBGF3XeAIZpiQlc6nrHYypEoY3TKII+cMba5LbcZ4wd/gQdvcD+?=
 =?us-ascii?Q?QTBkxFC70VAx/Emsa11wePO0JVrYzwzf1sidJ+cGE81vUS9uNtOzyWYUhck0?=
 =?us-ascii?Q?Fph4D6IImfjkmGhZFGBUlDPvgjqTiXd5BS79hmv5JCkkUmpaQA6xGYZ8S7Hv?=
 =?us-ascii?Q?crxkw5JMY0px773U1aB6cgWuKwgMEyCZYl8tyMd65AbfAMOjvLREoMKzqTjx?=
 =?us-ascii?Q?v725RkhP3FkYQ57V1brCDNRq6kUM83wHd2C/NBD0+I89c/Xk86bu4L4blkIM?=
 =?us-ascii?Q?SIsOvC46bB08l+yLYRzED2xZ7VxJymxL9NnW5tu4cd55mDPa/pZnRscFAY0+?=
 =?us-ascii?Q?nuATmS7FaITYHNo0hcnDBpiM6kG4MFFr3+aqNB83dCRxZkkzt5TCxUw6Wd/9?=
 =?us-ascii?Q?UzO8OMbPLKoggoPyRQHmOgI++4n6bzxSbCcWqusDr0bBqjWt1cUyZY8ukD+4?=
 =?us-ascii?Q?7oepWh9ol8nqsazN9CgtksLIQL3fvnyLhmjBsVcA34QmsHbtoZuZzb7M/2wT?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0c750f-f0be-4430-c73b-08dbcd7b7f92
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 12:37:30.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFxVXOC4ixnOalxf3A15nf7FIAIR+0u+mUg6wtngxwchaj1GMO1Q7TSIcRMy2fP6cbHOF5Zxo8C9JlusBYnl2cV/boI96K1S3+ydo16dEks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

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


