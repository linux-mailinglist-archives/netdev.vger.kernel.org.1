Return-Path: <netdev+bounces-15365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643C7472CD
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025E1280E7A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B0612B;
	Tue,  4 Jul 2023 13:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF56124
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:36:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2106.outbound.protection.outlook.com [40.107.96.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4ECA
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHRAL2z04DfaE4qhQBfo/xwQNgKCEw1bk/F1AWHJMMA7m2QvYE0MlchC6ckSSmMYmR5WcbbVEXeCrvtjdljofu5f2N0cRH2D/pBd20KqVGUIllE3WkSLZiYXqghDeJjDOgi5GhJ4sIbCiN5kD8MqhklwQrTy7XIY6fe4GekCKa6JzjWnQoZ75ddFnU6nZ3eZ7kGhXtwDUXZ9xb/0gWsizOYLwQ0v0FsHD6OoyVTHu9zDvoORkFRVpOoEJzvkF3uTJo8PFDUC0vPXoEbqPocO7bEvMkLdZ+gy+g4zzLNeMOaeS2BtLJPzl6kOHWh3rshpY5QpZcw6jkopoZLMtWPv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T93pONCXX+lJlDq1YPJTQPEn0/bIoIFKa6YOl8z9JdQ=;
 b=A4I5bPeSO4K5b5QqHi16dlOg5IxiuxvbTM4uoWP41oqF+vWQMl3GD/EegRjImQlwXYyCvlmHsX1PQthyY00n4lnbwroMm4SVYG7R1NRmo6bivbLybBad26vqlXmJ7uJZOI1EqmTCXnbXftyKUFifx/AMjbkKQlkgAvziaepPUAwDvGmiQENPtJb7r4JlKR1PlCTWeg2BXwYeBX0whaHn3xbbp7e2/MXXPB9HolW1GYGE810unUAs6Q4ynds0YIURTNaNshU+wfv688EDmCORy+5n+netdjxj2dEnuKjDbIb6rrQTNxe+URgoh6WZT13+AIcRR70W8gwW49UjYOCB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T93pONCXX+lJlDq1YPJTQPEn0/bIoIFKa6YOl8z9JdQ=;
 b=KMCrl4gTzN1xkpiHgP1xrsUSZcB/Gp7nrpe21jfxAQpnl+hLuzZaxHW8ZZEK7f2SWvc4MvHABwszyb1qW+g33B76rpALk+kR9w1lmDn8NaP60194H1ad6YifVhWgsifXpeqa3dAFgtccmlPG16jVRP4S61Xsc9r5lULcgXxsp/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6048.namprd13.prod.outlook.com (2603:10b6:303:14f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 13:36:21 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:36:21 +0000
Date: Tue, 4 Jul 2023 14:36:14 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	shaozhengchao@huawei.com, victor@mojatatu.com
Subject: Re: [PATCH net 1/2] net/sched: sch_qfq: reintroduce lmax bound check
 for MTU
Message-ID: <ZKQgThjFIjflEV9A@corigine.com>
References: <20230703151038.157771-1-pctammela@mojatatu.com>
 <20230703151038.157771-2-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703151038.157771-2-pctammela@mojatatu.com>
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ae6d58-64fb-45dc-084f-08db7c93a74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ZtMmlwHvtLkdXp5qKJm89ewAKIQ9YdCwiwODp1BLhccTOTZRkHB5+qSJI/4fnEhVo0nEBJ36c8LLnAQeaguoYWdyIEP/F0PGfD8zr/NjjukfT170jj1X94BNqvIC4YJtE6siygwSsOmUJCuCMG5elmWM6nATGKTr5EGjcJIyQf0Eab10u9phRji9BRag8afqWM+Ctq3Fo1rTERW6LI3zMftTzU3Srb4iem6Zzb1qQ1km7tL3dwNAbLnPUTlO7rK/QGIwIUB5c/QIMHwhaVurVg+L+MlzLXxyfSiNbDWONJ1suecX36kQf4RACYo6F9KfzroyHd/5f6CNM06LGWzJ5W/vkuGQ7jQRZT7ua3FDDUB6Vy4b8pyhOlZNtwq25jJ4ql7QiNlp98EkaVCHYILNTOvmhVlLd0H0jycPTBeRKT7peCXEp0204B69Zpr5ZpjKiJzczeGO437NPlxJNlf7Qnr/oFT0zXCoxbeTUfDBCXxHOSNBMg2WbQtZQkUrwFQ93JgW2xcUvbMAorpTdvd2bNp6fR+zm9oKTpD/KFu7l/9RvLPOviHGc3xOTj9kM7yHRLvZoeSGdCqloVNuuI5W3Q5lvy0v54vCwXMO5SwOHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39830400003)(136003)(396003)(451199021)(6916009)(4326008)(66476007)(66556008)(66946007)(2616005)(38100700002)(86362001)(186003)(26005)(6506007)(83380400001)(478600001)(6512007)(6666004)(6486002)(36756003)(41300700001)(8936002)(8676002)(7416002)(5660300002)(2906002)(316002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/52DRV9CgkbesOPRIdhwSuwm0CJAL/o1Bf0VNW5CtFCmO6UsyTwsyP4zod2?=
 =?us-ascii?Q?5gTOWHpAYwnMgJsJmHPL34bSIdFojrErME6pQAS4hcJnkv4pwC2BOA3JXBOy?=
 =?us-ascii?Q?Q/yE0dBWAo7REeeZ/Tu50I2iya6dfgMVb2rI4rBPyYiLvsAkko+qgdUFQMqh?=
 =?us-ascii?Q?m9rhavECFmvpqofYqe+kOsZi/flcFAS8mse4p/IxY30FrBGvXolUqKiYU/7C?=
 =?us-ascii?Q?bg87h81FlVsybCjRDndyQQ+GXOBlKxG3Og9RfMFFjrNcPqrjgwsI7+lrjbLF?=
 =?us-ascii?Q?wg6zwGMeT/4fUrguC7RPvTk0sD+SiwGMjqb2lRR/UGqoZQNZ+Q5R/Qv1Xg5I?=
 =?us-ascii?Q?zZCWNWechHfZwQhpwBAkj8OiOUS58e0oISf5ob95AQgZkUxH6z3SysyFY9Vt?=
 =?us-ascii?Q?7ERwC36op+A/8Ael1kxVSHajMlHEa750tKogn8cONndUVRs5CY5jiJjFmxP0?=
 =?us-ascii?Q?WYLQ+WOwBrQ2F63m3cHOJ3qfnvk6KkqGZo4YbNb7i4vSKLKo+FYXph39muh1?=
 =?us-ascii?Q?Gm6SRCMxNTMJlsoHu+l9DlV15CE4rB1yoOJJXI/1mLi+kKxP8puS24E5g9P9?=
 =?us-ascii?Q?CVll+wa5Pf9n13wRSVRqDT3GWpLVuH3YVQM2JVIw16ajnB8McxPk7J2DNkR1?=
 =?us-ascii?Q?bS6mr55nAdx5KG+CBVRXxzxhERxURg9c8WCmRVbdtDLdoAtmarWsfiMpe1iz?=
 =?us-ascii?Q?FaddWm5wEQMUDw12LhoLOEIRJdO2DcSQNMVvNk9jlC38sm3c16eZeDJHsyGz?=
 =?us-ascii?Q?K6QFUb4KScKIvCNK71JvhmbC5iMXPF529wOhHar8imvFDQHZIaQdNKOWHBFU?=
 =?us-ascii?Q?PMlPP45noMKFHpqXFenUBc9zGshxY9UljcoEulpE8HS923xpUG9X7PiumKL4?=
 =?us-ascii?Q?idTCj7r5qf0BD28zGGF25Y+zx+vGlIqzkDOKtSxqjDqGBZW7VjSUBLzMxckQ?=
 =?us-ascii?Q?J3M49YBOk09fq9zPjAQg+QGXQaPwxzId/Lwv+XeLgYNJvpGQNRXP43LYHYIx?=
 =?us-ascii?Q?y61XppkICA3Bb8GjeGlWmYyt8MLUIWJhJHrBhNn+vYIA2byCNHQmGhEmG4BS?=
 =?us-ascii?Q?K3cGIdcs6vMphcG95WBFzPvBC0SRBMiPmkf/yRljUEVu1qNdqc8KwoYgQa7p?=
 =?us-ascii?Q?VRjoVqtUgNB/IZAZao0D0svBZKKbJNK5e30QwO9cuPfH/KX5h1wTlOonuMbm?=
 =?us-ascii?Q?aMr6pV1RypQqB1ZlM4UrFudaAb/57L0r6THPhk/W3CfvX+YTxzn0SujW9gHQ?=
 =?us-ascii?Q?AhJ6q3E3DNvQ3e3ssxQm/GKC4YHhOORrfzUC5k6rn36j7zxVCXgLoMdNX0bR?=
 =?us-ascii?Q?H1AMRinEUA1k587gQ3/C3rQWQVi+o7OQa2yBp8CO145qomjKn3Zs9Lz+CEgK?=
 =?us-ascii?Q?qypGe+hBVI+FiphW8cXOFitOlWFAX3jwahWqlTZvJq8DBdGTPrfezJ1IsqK/?=
 =?us-ascii?Q?LCxnPB/2UR3B3ybWnRvcEAmBCQrPgRSmZYfE/Sl8ELnZ5NAb+DtzwGK0Y43J?=
 =?us-ascii?Q?TGUA1Obno/vKkAyICG9THo/piZOPBuvmy8AOsd6190QnmFhgAdGopUdFy0ly?=
 =?us-ascii?Q?6j/D8l3Cs/UfCHpRzhQdm8/oHswSxumZx6Smzse5HJpG9C8IHd8Cb+VmgqaX?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ae6d58-64fb-45dc-084f-08db7c93a74e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:36:21.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHiBXUR9NjvjJHGlQ0RJSONVSteg+9dtT7fxlAktopgp2eJrp1Xr5xOV8ti0FMf7iI76SppGTPHS9QdzNvvvUJfPEzy347OjViRJvecopC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 12:10:37PM -0300, Pedro Tammela wrote:
> Commit 25369891fcef deletes a check for the case where no 'lmax' is
> specified which commit 3037933448f6 fixes as 'lmax'
> could be set to the device's MTU without any bound checking
> for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.
> 
> Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/sch_qfq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index dfd9a99e6257..b624ae539c8c 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -425,8 +425,15 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>  
>  	if (tb[TCA_QFQ_LMAX])
>  		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
> -	else
> +	else {
> +		/* MTU size is user controlled */
>  		lmax = psched_mtu(qdisc_dev(sch));
> +		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "MTU size out of bounds for qfq");
> +			return -EINVAL;
> +		}
> +	}

Hi Pedro,

a minor nit from my side.

If any arm of a condition has {}, then all should.

	if (...) {
		...
	} else {
		...
	}

>  
>  	inv_w = ONE_FP / weight;
>  	weight = ONE_FP / inv_w;
> -- 
> 2.39.2
> 

