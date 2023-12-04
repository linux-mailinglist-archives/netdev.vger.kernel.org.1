Return-Path: <netdev+bounces-53480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BB8032F6
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF1F280F77
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD51200BF;
	Mon,  4 Dec 2023 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DfOCsV/a"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25463A7
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 04:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g58jacHNpfygj64F5caIDLeLoncvY3dTvBNC+l+xkT3a/+93c+xiJ0hS/uhFPd3DsfNKYqrdwQbxXdj9/ihMlywC8+KhS55iChNTSqFrJFwsg7BZiUzEQCbXtO0Fe//SD3da6iNja40NjXOXpWnTolIrNQ0JZJzR7YmRVoSOiIJl9J8CzqaE0Suocw9UzoBaQnm1dChD1kTgmTCo0rCmMVYxoehK4tCQa8Cl3W7240DO80R3a5J5vJYVjOSKO2MUiSgQoLNwCKHugD/gykeJJzheKS/jtKJdWEk4Tc/ckt7NemNyQu5c8dYSRL/2oTGJPcYm0iTDA2KJOtMHs69yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBtq063w/f8JM15aw6d+1ZpRdqhmv4+waPeuOObWi2Q=;
 b=T2lEAe4ptL8nJsKyyA+JKaBXd0wfLh8TBduCMv+qGp+5ErLixA42b3olG+f1lQGR1/WvkWFZkk/At1Q4kILHENNlO0WHZ4hMHMNwXNQtc+5g/MVNOV+joNWj9qz+WftJPDYOA4PpnnUhA0VSzlP5jS69qnMfl1TNDh82p+ZBSkwP/a1ROzYXMQOp+6gQeCiwOemI3DUenbzYv6QJV11ulVbZz5ovCRx4GR4FJ4HqRRvmwu7c7tE+qjhZmcIkR0cWtzkgRTbgvlqfoFx9EAdRDd0rMEDVfRHrZlMD7WnYP18UxLBibT5TxXQz0Faq++prRCHxhGRqf6JAizqGP2AOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBtq063w/f8JM15aw6d+1ZpRdqhmv4+waPeuOObWi2Q=;
 b=DfOCsV/aDwsebS+UFFMqFja4bKcprVwUu7rtEkDSasuQan9A+/ucXBqLkeB4BR0lo9VZNrJpDrUwbrWTttn/noIqYJE63FyQk/x1Y7CQ+tv2Q1QoCm7m+yNwF6l3XFvHFZhQqh8C1NHp8KSFiMxTjAYXLJh+Gb4cVTqINJQlyIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.21; Mon, 4 Dec
 2023 12:36:59 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 12:36:59 +0000
Date: Mon, 4 Dec 2023 14:36:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 8/8] selftests: forwarding: ethtool_mm:
 support devices with higher rx-min-frag-size
Message-ID: <20231204123654.2fsaq4tnkctauodc@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-9-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201135802.28139-9-rogerq@kernel.org>
X-ClientProxiedBy: BE1P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 7393d26c-374a-47c4-8bd0-08dbf4c5b55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oy6q1bSB6YGC5z2qjVrys1cTCdX3wyYqMQmDmvx+7KnX12FTzlmLRZ7WGRQ47cFYH1OyyG9ieyvAGXS0xzm8AfH0hNw50PnBcXXztCLNB1ek5oqNwYWWKpq6BXWluHLL4+tMV23jxKZZ/dHvEt6PsnZdFp7n76uriWwP5+LaX2RnL/BoCD5Od1NpR0pDqN+BtRPPte+rxMXj2jrsp5lvVzUsHnirF2cfiUxI+JDWM6Asb+EWlKyeqX+rdc62Ty/buoOmIKDCMR0f/Rb5EDdi5MgYLnefPXLrcz7NpR+lxq6ustM6DH/CxtfJkHZexTIRG2q0Zl+lbc5zWLorTcjFK2WutnDJR9Vyv2YMvMz4nNWIr66ArxT487d/U5liT+1KQ7OJudnkEx6qEK3BJInOSZYMGFDuQpNTCPGkjVfSJ9w+lhrrRWV7mmKGoCUoeMQuMsdqq3izutefI3Ne9iws8N882IiJYMB5ju3HQD0L1l3m00ukZPxHgk1MwPyz0TMyS+hN6//kvXH5gaRrUr63EJxRyXK/Od/IQvBTXvoMf6+6MjB7FpE5D8ZcqfX3CcPB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6916009)(66476007)(66556008)(66946007)(44832011)(316002)(4326008)(86362001)(8936002)(8676002)(33716001)(9686003)(6512007)(6506007)(478600001)(6486002)(6666004)(2906002)(1076003)(26005)(83380400001)(41300700001)(38100700002)(4744005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/Ar9K4PnaFj3CwT4n7DJ03i4fe1mARcZG/Sli2oPdBrEIlgKt2x+hEaHkjB?=
 =?us-ascii?Q?4UIKSjzJNd+TRdiXyvGmlf13KQuKSMNynJ7yKsmpjbXjY19MQi3NUCDN/2b4?=
 =?us-ascii?Q?HTH4YZwG+jUJmwXUTziJIkxPYHnlQQMLxcAJ5JtK1xdqpSSF8vu5UwhzSZpF?=
 =?us-ascii?Q?ZX65cFz0x6ytXy18Ta8C3VcCIOk1u+uFtiQ/oUSk7vkF9cFDvk6/rZyx8Ur3?=
 =?us-ascii?Q?j+lVgqL8l5xO6PAdbHR4JOqSwoHj+bNu2raIaifT28Tq7eI3eRfla80keB1v?=
 =?us-ascii?Q?BJ9D5tJCxXu7Cdd3XRf9/4+nwrX55HsvpbaNzk2kNvAejJ/Whf2BjEszk/To?=
 =?us-ascii?Q?Djy2DUEihFGy/EkMCol9MCeZgQNWECpHtXWFG1pWM99hE0tipHYNupSavje9?=
 =?us-ascii?Q?1wSG0ffoqZzRMknzS1gvkNrlRMqIr0CBrKctvU8od3MBsBhFROqQfLS8NSJg?=
 =?us-ascii?Q?r4LfESnyBPRWhMO1gKNS9T8V3jtugOBuh7BdfkMLL0hQ+7qR8P1tKAXtJhKG?=
 =?us-ascii?Q?OLl4a25hE5iWdqaN9sWsp5YKmOoRiJN9eyvFcejSr6Yq8BnNxy4W6Y//w/Xy?=
 =?us-ascii?Q?f/XO9CVV0l8WQ426+r+Ar+iNIdmZARUGFX6WaiNINAms/qm3Mos142gTD/C+?=
 =?us-ascii?Q?N9BKSlnz8kEjSuQo+Nr7znDDT2G7YA0/81YmuFdo9JYGGaJ2XLWLioZiOuph?=
 =?us-ascii?Q?/zKAWXyJLnJCk0PRvfE3kRMqYqZ+VS1w+O7/2gKM7U6rjfP7kYnUISWPO2NH?=
 =?us-ascii?Q?cx2R/j/ffQLLkPnSfxen3Nr4+NW+XvW0nApaeLUkFAuLoB3w+5u5SVsJ1u2j?=
 =?us-ascii?Q?IXqFzzOAmU347Fk8ub8rYFo1SQttqzODKDNp6n9k0eprN2JgC2pE/tJiaVjI?=
 =?us-ascii?Q?9jSKEZbtguxUvy97Y7gHP2sHQRPTdDQr1T5l4oVXIEpGhXQtF63LrhADNYsK?=
 =?us-ascii?Q?bzg87kJ2ASItEYc5jR4ncTJREFSeDUJxLmBn3Ia2S0usW76k14dpZuULLAuv?=
 =?us-ascii?Q?OAL7vbmwRv0J6izXUHKw0QcQimsNxKaPoRajwUs3fE1x1mQ+Ei/wAd4yTjMp?=
 =?us-ascii?Q?FxPU3BvjAC1KiuPER0T/H7Dq5KxE/oHHNhReNN2mGeN2yxypv1eOuhSjf9lP?=
 =?us-ascii?Q?Jjf5pq6yvxw8GZwfOXZ5cZzlDKVMAcqlsC27QpPxGhnAM4ssF5mcXQRbBvDt?=
 =?us-ascii?Q?zW3fFqjxObnZ2d/iJs1MPHIL6uVPKTzR8SHBYSZCYQbVq+i+p2BP7or770SV?=
 =?us-ascii?Q?xMkjN4NLnfg9OIwU+Xp7ZU3w885Kth1TUEKPTFjom91n+RjHWufqssoieyIC?=
 =?us-ascii?Q?dS58atNtKAcWV6NC91REFAIBQYFFQkWgH3Y20Q1+0dCGYF00CcAi5dzh2xW0?=
 =?us-ascii?Q?Cv+6ZAheReC+f+mhlgy38tuF/OI8c41Xg4TwwVquIkJDX54IAvYjqiAmc7Bn?=
 =?us-ascii?Q?JyIFcr7OL/1roEx8vDC/DrSHJ7MeJ3Kyk/2pj8eCTA5xgG7Kr9+S+SYya7ux?=
 =?us-ascii?Q?gLrs+rZEkUAIJP0CemTQ2PvO5nLqx0EeGGB1xmLYcXeNfcEvAjfV+RvxKSKM?=
 =?us-ascii?Q?/AOcQIMju7j9NQ1jeuNDe8ILgiB8bnhb6t+jxwDtHzG+z+8lKW1nfGh8wZgO?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7393d26c-374a-47c4-8bd0-08dbf4c5b55f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:36:59.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z83kkS20H8HXiCEk4+w8He7oP9rZzUP3ACbyOlEIfyeVJGvQylWDv1f1vQ2b//XWG2+VtgISvKWhxyB3BQV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

On Fri, Dec 01, 2023 at 03:58:02PM +0200, Roger Quadros wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Some devices have errata due to which they cannot report ETH_ZLEN (60)
> in the rx-min-frag-size. This was foreseen of course, and lldpad has
> logic that when we request it to advertise addFragSize 0, it will round
> it up to the lowest value that is _actually_ supported by the hardware.
> 
> The problem is that the selftest expects lldpad to report back to us the
> same value as we requested.
> 
> Make the selftest smarter by figuring out on its own what is a
> reasonable value to expect.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Roger Quadros <rogerq@kernel.org>
> ---

When you do resend, please make sure that this change is present before
your driver support, such that bisections show that the selftest passes
since the very introduction of this feature.

