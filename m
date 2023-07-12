Return-Path: <netdev+bounces-17123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5BC750652
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA33C281679
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4227713;
	Wed, 12 Jul 2023 11:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F227701
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:39:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354191980
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkuAQAMGgxqDGYjcSHZjEMuzLc0W6l9yMV9Jk0xdq0jJ/htmAzL9ieKORsByaO6/bZiuenUsMkd81uIuZ3ZQiCkWHLSYOcJdnluR3/qZVqjBdcdPXDAtB8ax0qQuXBdn+FXFBnCGtSwtz2VDkNtZsc3eGlW1fIMnvO8qUIwq/lC26cypbkGja0NcWVIe5DZzX+0SEBGUoy5YHmThKxIkjcaDRQoNZxZlDO8orjv+DYNH8JrcRP3zhzep207ptNyOimt/Mt3jFAx5urV1rPYQRz/74A4pKlxpuMu2N/qZcjZSDVoN+UhD6OOg9olw2NU5SIcTTCtGTbJrCi9HT+bVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPn6JChRBSADJ9Wx78l7DpfX1FEQ3eS8WHDz+3mn3k4=;
 b=MC2cOnJaUtP725/nzaOf+002Knasn1bn+V48oi+IXbfeW9cG8CGCJr+sYlRwFczjvHyVMCXMYOGtzWPLzKcwuJu/haU7ixfZQ9ZUfg+3nmHtOT1jnfO7a6EAhbENThS8v4SMRD/PaAF9gHr5xCZM27E0c7/mFzTS2jWgheKkDPjkdG+A20HyHfK+lZwcJ93jzmQWI6T0VzxydkLoZ/vcuy1WFwrPbiKUUH044Ccxc5dBKe3eNefb95Dpl5+P8exhwTwvoVKE3JM4K2oLAfh+2IOBHPJSLikaLtt5jCv3W5mTrboSiC+hmneHTyfk2H+DzXbDqga+KCqG9IJKDdjjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPn6JChRBSADJ9Wx78l7DpfX1FEQ3eS8WHDz+3mn3k4=;
 b=Ml0+KGbyrpqht93ThlD7J/SgS6gJFm7iLRMu8vaIZfCwoFjRWcClwdC1vgDE+4uxP9uz+py8Mb8nEsNE/hEko2MccNro3bXlobDWijYcd26xHo/0ebmtWVBZrHeV5B2bwdL9yrTFh7yKTBX7F/DHOPeNb8920USDnXvWrOzqljs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6420.namprd13.prod.outlook.com (2603:10b6:806:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 11:39:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 11:39:44 +0000
Date: Wed, 12 Jul 2023 12:39:17 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ipv6: rpl: Remove redundant skb_dst_drop().
Message-ID: <ZK6Q5bp7cYhfl6iN@corigine.com>
References: <20230710213511.5364-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710213511.5364-1-kuniyu@amazon.com>
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8a3878-ed3a-4403-b613-08db82ccafe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RB+3EQXvx378hsTD6W90LXQP3f/yw2FJGpxtDUkv3teINQWs5NLow69jVcORbgmCsN0f3GQydhiIpvZ+ZcKQi7NDSt7f2f0cg8B89xMgv/NDaMUAvVpwWUovNFSjWQpRqTHGrEyjLbCXWD3ACJ9QZL5MUSLFhcOzaeqKmd/gVVXEF+fd2dg9w3erya01rthFYtVOGeFWMVJnh2qCoETMdGdP5Iq3xpQ1/WICcq1lPMzyFHYnemBSw+Oy0UDu0uBoFyywLnyAP6KsxjI9TLuB+HupJQy+p+YTLN2tlzpRUjU5NsSheJw7CcbIFP79tpvSEDSKDTLB+TLtcosSBab9y7PUHcRbuI/x2RwxOQtU6LNRRmVbHgC+caNWnXLPOhihZ0KK+bD0h3wwaLocKfNxSvpLTxiUnBzpO1xAW+aRxHmLDyfrFVokpKgP+gfPUg9T+dXFs0NOsdDLGdN6n+nWUMgcXG3fEd7Sr2X4PwvwycSBVnVcN1tv2xB/Dtnc6rzrqeYuw091gmsYon0Qw3usVgR3uorvKkC2uLr9lfhoavGGTGJ7nSl4I/M7WhKeOL2NzIVT7XK8TfsTP81Uu2djv8gFefVetpB6nXW93HwWNLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39830400003)(451199021)(4744005)(8936002)(8676002)(5660300002)(6916009)(66476007)(4326008)(66556008)(44832011)(66946007)(316002)(2906002)(478600001)(54906003)(41300700001)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujuo/xfynXAbgDvrOMzkiWV89aqKTsXYTf2mmlVrQ38lxVnrlerbilDMs0gO?=
 =?us-ascii?Q?OXqSEAldmafnt+KlarAUecdkputSSnkE1glWF7CN/17n+MDBvxFBO92FTXve?=
 =?us-ascii?Q?KcMSn3Zv034PaBaOKdTffbc4afuE77B54+JNnUrjsPoTm+kausBSmeRPRtf6?=
 =?us-ascii?Q?M4YSbGL2GjDG44ZZb23BkP1Qz/1TZwGwaAEABoWj3OgG4ADrlp3PE37i0xHH?=
 =?us-ascii?Q?azn/gBanUwWPaGo3UcfQSqyEuaxdjhRhh0n0pUR4CfKwH9E2sHmRG/wNyjfv?=
 =?us-ascii?Q?HUkXFtn83yxk+TG+kbnKwaaIujxtOpSm0Q6qnIsMZqy7nz9IfdwNPDd69bjz?=
 =?us-ascii?Q?ICW1gIOSkMuRtbNmppp8ZQtqTyOoQaVnYWE+QzioLgfGlzsLyJMhqIWsSiOQ?=
 =?us-ascii?Q?21JFYfGVFxDpLwKuXbvIKHQAdTiLVHW2cIn84PrFGjDmt0Mk8avHuKjqHW/z?=
 =?us-ascii?Q?HcBAfbfM5M5L29jbp9hQj1v1x6iP74ESjmHLXoDhZAl/4eUNc6r23UGLyNqc?=
 =?us-ascii?Q?XefvpXSlw0NUdwS/QtkiUp3QQwUucg2szhuXVDD7KTxmKIfDFJ7gCLy+vBE+?=
 =?us-ascii?Q?RnucIVIXg5wi+/+jbMG7+PsqX0UUxLrKkmPRigLYXIQYQpC2MLgFtGqcgOA2?=
 =?us-ascii?Q?mIPbq95pQhXu3BENyJpaxoWV0bFMaUDw6PzJTyAfJ5K9KGgi7stg/mUVy3js?=
 =?us-ascii?Q?UURwJRpNvkw+uu4/stbE86XXqrChnUmoKCi5Zv0gyZt0vnncSV4VsDu0LWXa?=
 =?us-ascii?Q?5oOftXk8UnXG1SAXM6KJxCevAxN+v8CvPJWPlGsG6MOOhxbpgz1eoIne2zS2?=
 =?us-ascii?Q?EqA9368tuX3DoAcRlgpYme6AVHBwnY6Bg/DUgkAArrXerWARfmdG6PwIy0tl?=
 =?us-ascii?Q?yHFECB/Lnn7qj21pnPqX64WAO75pSYHrkS4kl7HlUJPgQXxOP/Th3M/kYIuL?=
 =?us-ascii?Q?MbgKAn7ubr6Ri4EeZoJ4GNs7toJQeEPt77KSHez/yrIuf4QXhF0pBovSHacT?=
 =?us-ascii?Q?dhoCOlLxwcXArW69uSij3Nt8rJSeSTPNuHUquYBs+YkR9DM1jfH0JX+WD9Ki?=
 =?us-ascii?Q?gMOpaVoNyreJhHnS6ak8xKx87CoSmnZKAHQWeJr6u/356PQAQ8nqgzBwKpL1?=
 =?us-ascii?Q?k3VWaen0hKhU+rR2S02fLWTbKTSunRmC/8shBhKT+MC9VW5WpMcJo6yB13uH?=
 =?us-ascii?Q?ILG8dlIUWy4EFqTSkYVEv3mupGV82Z8Dra3SGIipZwaR9fgvxX8vMMrgSRp3?=
 =?us-ascii?Q?qztGiFx7FFwM0QC++BX42sw8MUBXkKcuwMILKXq/g5nHeW0UGNKbA/5HoR1g?=
 =?us-ascii?Q?gLF/01mBDMyuTFH9ODx2Pi8Iy5apTynSrDubqGGcEIVkVCXjcqL7Ynl6M8R8?=
 =?us-ascii?Q?0AuqtvINSAS6b2yqjIg7MA/WZerXUozxStBV6W/wGSLM6G4osZ3W68WwDrs+?=
 =?us-ascii?Q?dsLKunA1wz2hyloH1WFUztkRedyMynCXd3Y/SBhpuYlknY5fokmRjoZiGOIX?=
 =?us-ascii?Q?v0Xm3IT9PvGSYPuY9hVVTskK5BDT32Je163wY+GoAacUJTm0Sx7iTF/bjR4H?=
 =?us-ascii?Q?FqNjjRXmbHRIyD/hmzYCk4b/Nah3rdQJmX/jpj6g9uHdwP/dAmmQZW7BeGCt?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a3878-ed3a-4403-b613-08db82ccafe0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:39:44.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaQD+kI648PzOt61UYuvSS2sUvOIyzXHDw/x4MXm+jINBEhNJ+9MV9uitjl+Bw1AxdS8P7lvR7M+Hq7hNJr72R6CnRQU8kcGvfx2VUxf9fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6420
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 02:35:11PM -0700, Kuniyuki Iwashima wrote:
> RPL code has a pattern where skb_dst_drop() is called before
> ip6_route_input().
> 
> However, ip6_route_input() calls skb_dst_drop() internally,
> so we need not call skb_dst_drop() before ip6_route_input().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


