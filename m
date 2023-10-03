Return-Path: <netdev+bounces-37555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3D7B5FB3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 38AB21C20847
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282BED2;
	Tue,  3 Oct 2023 04:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A82EC8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:13:22 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2092.outbound.protection.outlook.com [40.107.247.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C375CE
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBU0Hgsr4KBDeFzrupPUsDhRBL0wr4NO5+uq+lvA22TcCwKx9g5Gp+MyeVIMeIewM4PT6aHd3TN8annubI+q28VK9jxO4Y+2O1rVipYmu6UZYRjCtvQx40hENBenecQyQ78TCRvQ5ySkWYcjonuJfr1j/6W7R2qKtqRYqfSkbRNqZyQKj1hcCI5sgy/tkWufTUlchB4lwZRSdkYdSSmjV9JwmJpBK1/4If4Lxi7BkE0fp4obysupRt/q0gKc73MuTqHqJjMxKIxli8cB8/3kqANVQ5mvSNEtMrn8YmDSrEa9pmOI5VbhXRdJ0/GZooHETvQ1XFY2t+1kJKkUApW4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKv5oemPFkpwMxYGGXqo21ZbrfvsKKMMFbbOJw/yI7Q=;
 b=V2tLvmPfeBHClCNRp2srepXoJx3NPgcv44hCkPH8fAwsdTj6oo9o2NLeKZE4a0Auo/gyGCR4lmnfrwAwqyiIYPUr+Qc0NuGFivPq+dkUnJAjI7gpQy/ZbzPTk54eQbzGPM8EQeumtmRWZ68nQmphlg43KUq8EgQKJLKtW8EZaMoThgBQbU2qi0vdtaCbKBe34kXAQj3trV+jeNN6WsT7ZtYdOfdM+ZekdqyEheBsiETY1RHv2E6LoxH6FrkFdEu9V0AwD9W+6ylYCaciP6t3mPcrPwzSDsXqOw4l01l+xBr94QxGrpCftKDxtOj2W9A/y1XLGmdkJ0DvOTgjjUbCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKv5oemPFkpwMxYGGXqo21ZbrfvsKKMMFbbOJw/yI7Q=;
 b=UfZPCDTMqlMGJsSzNF/5mzvjAvZBwPiQ4xO33efA03cBpTTW7Se4YMAtm+zCQCgEezecqLNNIEIU/KGG6ZErzGVz7tRJUGUhnUQGa53SkVA/BV01bm2EkZz63fIiIuF9rKXCU60vILXybRAcBwTsnW6734558WL/tVvJi7XYDGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by PAWPR05MB10164.eurprd05.prod.outlook.com (2603:10a6:102:2f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 04:13:19 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::fd04:c41c:d9cf:21b1%6]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 04:13:18 +0000
Date: Tue, 3 Oct 2023 06:13:15 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, hawk@kernel.org, 
	lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, 
	mcroce@microsoft.com
Subject: Re: [PATCH v2 2/2] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <chrjnpekoyw2j3nbx6bqgbffe5plx7ffpg27vc2gyp3hnbwdvt@ptk5bfhj4dhs>
References: <uupabbfdmaxzkglgpktztcfoantbehj6w3e4upntuqw2oln52t@l6lapq6f4g4l>
 <20231002124810.62c772a3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124810.62c772a3@kernel.org>
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|PAWPR05MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb1a4a6-69bd-4722-82c0-08dbc3c712fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6V0n5D2+5+BA4xU4pl5VDRR+Jnm0kacvs81bJ5/JWxKAy8/0LmQ7GR6S48Du2Luh5zv/kHWUqbabhHKWNFzYtFzE1RZN5Rd8njTgl4qggjENtGOq0gi54wEyDyP2pUbOgEcj0Ac84znuvDH9vReMeaFDU3GjIFDRgFoHLNGIgLyynSJy8BplVUeVXAjIMmKhvwuAlPwnpzGen/HDO2kEk2PQZbVPEa2CL3Q0GnfjAiEZIHY4v8VKJBXdgEal5mpkkhfg3iz04hMbx1z3PgkEwQLHioe7TJhMqifvgXN5v5NLfnAkSieEfZDPfUsyAKPcfxA1eoTMTZakmwiSoT0GXVPCViY8pJc1SVBHAZBS89VCp4vNTbM26Em41bATLiuZOhc4cxCmmZ0bI/YqBBZTvKPqAZghXuzTu3jFmLxbAY9iFdYMD9Dl4kA6YwWZ5qWu8mWTM3Ghl2PeRltmqcTy41zbcLTRpDCNERRAAgSivoQqRl81nuD6HAMcpGmbPL/8Avg4Zk3ULS5f6BwlYvviACYA6nNl9QibZAGdmAo/qY3JRl1TTxFmm0ONF+uV5tuP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39830400003)(346002)(396003)(366004)(64100799003)(1800799009)(451199024)(186009)(26005)(6512007)(9686003)(86362001)(33716001)(38100700002)(66476007)(66556008)(478600001)(316002)(6916009)(5660300002)(66946007)(44832011)(6486002)(8936002)(4326008)(6506007)(41300700001)(6666004)(4744005)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y3fCTgLF7SG0PvT+tFI1URjMy1zm8r3EQ+YW5a5ltH3Mn09dv/UN2jSqAMaK?=
 =?us-ascii?Q?CPk3oetPqgThASDp2+z7phlc8fXs/gnhZ34/Tg89/QKaEdSmLeBDo/RA7fAr?=
 =?us-ascii?Q?zxuLHrz9MK5L3ehfkabAY8sVK02woYwheTmEU6QrtTP/nvaeUe2YBiSBDLCP?=
 =?us-ascii?Q?rHdxrDIqU7YJo+TxwjE46Qf1+swPYiv4rAXoFKYylb2YbJkYQHj2kkoOWrlT?=
 =?us-ascii?Q?2cUp3f6MZqA8N3wRJRZs40AfHHx4N4FE73H2QIsP1T+dn5JB5xtaSTIS+ols?=
 =?us-ascii?Q?QGWoNh8OMmCFy0iqvztZFNDL+eoyuuCq4fyqEjxe1AOMq67vbuqSWiVpSrXS?=
 =?us-ascii?Q?/Co2WXZk8nzd9gse4+kFtLBH+ighUgYQZX7G/YhXm2Y5rpEdsYBlkBoyJRFu?=
 =?us-ascii?Q?jJeHzI1FIQUBs/KgX0c4duq1Pa5yLBOXgM2NN/btb9LwI6SnE8WeO8ms/W56?=
 =?us-ascii?Q?CrrXISRPYj18WDElrIVNbyVD2UJvDIxlGAPA1w/mBxgaStq3hHymeiRHbvJp?=
 =?us-ascii?Q?YoJonADFqh/QkDWgYESJUCjfwoKlxALQZ8D/sxrROzcfCCrIswfVLEup1caV?=
 =?us-ascii?Q?/WHGKMR5Rw18R59HeEJ5UQsqZDmpich8rp8dPWcmZLerhsj5Fn1u2TrENN6u?=
 =?us-ascii?Q?goThWVM0byDjn9l/lK6UpbH41434QqX1YapP0dCjAI7w4YWZJJG/qDZYt+oE?=
 =?us-ascii?Q?Xvyy33IXQ3Z3rNPImM+m56lfSCOCfeQ3CSEivOLycRbbeVjMNFVHGSMel+Br?=
 =?us-ascii?Q?H732ZQ5uVgRl3iM/PQF0g9FMfoNs9EzxCJl3f36FX24aM639N5enC1KU7pl/?=
 =?us-ascii?Q?zXh+JWR0TOap/NTjfx2cAFOsa9wpB0MOfKUvc1b4sPpU09GIhz9F0TIAbhhH?=
 =?us-ascii?Q?hQafraD7c4/Sr1oYziVVYMarQWDw3+JKP8rZ3TbmtOg9VD3KkgVG0jBzNtzT?=
 =?us-ascii?Q?+K+4ZUVg9cm8cXNqlaPNwyKNlTotFlJN2lGb8mqaI55R7I6R7ynU2rI4vGH4?=
 =?us-ascii?Q?r3Go4ELjsltw4ItQK1ZAeRpeggLwqCgWpYXny3EMgChqxg7ZGsqE2H0wALWv?=
 =?us-ascii?Q?tkqRln7VKFIV+Y6YIAv2HtH3GNVkU2SfdARB+/bkPVW/ihzHyFwz1e8dDZf4?=
 =?us-ascii?Q?LDe3UFyGFJDaz/yJrDEluClaWvSG2cFW1Z4p8pn9MK2BqqzDCgLf1Y46qNI5?=
 =?us-ascii?Q?5s3RobjUVQ9hizebCFQ2naWuX5j2Femq3x+4euWs4jDPUHhOgz4IDTPpuHpb?=
 =?us-ascii?Q?VMbC0Y6y/5L1jx36b8aD0JBWqt504aJ43QwXC08puBA5Ll4suAryJ29EBRKT?=
 =?us-ascii?Q?Qfz5Mt1qw8pQI9g+06zF5gNtki09II1u5dvd7d3aKTtcGg0rcHBmB/T3KWpN?=
 =?us-ascii?Q?m0zivcsqCr8glMeegN2MqgayxNkIZYGQc05CzgYqSlkXdmkoutzoVrGJ0hLg?=
 =?us-ascii?Q?Ph31484wAe5rebugVplFejbUz3R4Kn+IIJcGV9Q7ZMp7VhAwBaphc3utFyQr?=
 =?us-ascii?Q?0AgamHW/UxHz5MGSo+AOR6UYMUfDj8o84qFYbi1s0wUDty7FDepwjKE+EIzx?=
 =?us-ascii?Q?mawaG7DRtCE9yd0nVjOrwUVPaFwCVEXpeVurhDUUThNiup7T9YPCyROmElip?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb1a4a6-69bd-4722-82c0-08dbc3c712fd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 04:13:18.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOoi48HUedVBVwsLGexUrx+ILXyofG/LVEccHFPfd3mW7plcQd7pCcPOfV/TjDplZ37qzIA+2a9e8+rrTZfVqO6myjDAKkikss3KcL1Hy5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10164
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 12:48:10PM -0700, Jakub Kicinski wrote:
> On Sun, 1 Oct 2023 13:42:24 +0200 Sven Auhagen wrote:
> > Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")
> 
> Missing letters in the hash, the hash needs to be 12 chars:
> 
> Fixes: b3fc79225f05 ("net: mvneta: add support for page_pool_get_stats")
> 
> please fix/repost.

Thanks, will do. I will wait to hear back for some more
comments regarding the check in the first patch.

Best
Sven

> -- 
> pw-bot: cr
> 

