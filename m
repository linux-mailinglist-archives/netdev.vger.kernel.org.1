Return-Path: <netdev+bounces-15441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF7747945
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 22:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCDC280A85
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761C1100;
	Tue,  4 Jul 2023 20:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33FEB8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 20:48:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2097.outbound.protection.outlook.com [40.107.102.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFA99
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm4Ht8ccZ7B9P8j4PPNn+fDQJ+QvwHLmeuwX1JQRDfVmr1KkTBKmkiGPsmqvc0aGen99GHgJEd+KvLL7Fpi14Ck/oe0SFuwCJ0KpQcxNCnhRLCEZLCanVCqamPt6F3L9EmrpTmoBLrb/DxWYMrqkVvZ+TV9J8u+0Sr8zu1ex1CkE2sB54EOPA3I0ZAYQlSHGlnqjuiYku5EIHWjFXeZ4+kDGT2eB+eb+8YWogSoJI1BJqAXAaeMmak4zqFZKHht+3ERzZlaNfMiRZnMIHjjDMKjtRC8veV7PSH4SQi8EXlpY0cEM+7qrvPYFOwDpRx81UYf6JGKfLzDTyvkD9p1fUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25YvPSUHMzlg5zscKS0h5vo6vfZ/elmF8qC1fNuKJnY=;
 b=T+q1W6YqwiDdU1cgIpfgt+Yvci94zFlF98mpubZJNv6iT8FAme5Jgu7vkZcT5WGkZtQP/eXiE/WSsdrjXygV6/Zi5cqudfqEaEpPkFRDzGlHGZmzYNR305HAmigOPJHHPbwyf7uaJ/YdumXhxubt4Xy/jeBFVITK6ILQw1O6whNUIefsmZ3HcGzqUEhnF6HoeIuITXrmv7SMX7YrSMhUF3GLb1Meg2Sp4gLPCxHpcAwpuIt+6MTRU3tzeZa5iHgWzDscha4gezVkFtShIFl5Ydn7g0GI+kHHBcIVJ4bj2FO6VIH8sAFSdO/zwK6bWLd45zPdthjgWu/qv+7kfOS/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25YvPSUHMzlg5zscKS0h5vo6vfZ/elmF8qC1fNuKJnY=;
 b=mTAGnWX/8n5sxiEn+b8fuE/Jm58KtmLFYbUJHKAMdiyl1+t/3hU4v5OWO7dTRlblSTOmrssciCmLfAhGGcTNKFzjsyTyECW8eUzkUiO1YAstRiOqMrjv4oXgTwyyqGDfbpreCh096yp4T1tBaSifvc4BWPWDmMDWFd2XybgtzZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3630.namprd13.prod.outlook.com (2603:10b6:208:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 20:48:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 20:48:54 +0000
Date: Tue, 4 Jul 2023 21:48:45 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in
 case of an error
Message-ID: <ZKSFrSW2zJZYelNj@corigine.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
 <20230704151456.52334-2-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704151456.52334-2-victor@mojatatu.com>
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a7b1ba-a4ce-434b-2f5a-08db7cd01455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1VF85VW7wxybuZG+kcB8+XEinQXXm457M2kQo74150thT7vG2hHKf9oOgBquwvvBSC13VNKYLMmGFTvJP9PYZFLK4tXIQnSfQ75qi9Ba7D+Kkm3S4yXecd8yha1yy1tQ4oqrUL/a8e7oDS2ffp7RNg3o52/EO94IJu5dZ7zTQQ0YOpNXb2rrjggT8cjudSlRFgnNiRJYXt8CZT7wAyT1BtMjHCe0+gfphEvMEhl9qoqJFZH+4PQCd4/Wkt5RzpBaBThMyjsJg1J2GNvXUGVrWuSWGiidkXqd52qS9wsdKouUVPJ1B2fNrmb9BAlQRhicaRKPyhPae2eMBj+6iMo7PLvBjnggqRrHLd19VfpdRKn1WkoSkKKQUOPPoIV1E01pAhOLNZMPVDUJokLZ57j9uBo8QFjtJZsvvVbI3ghe5nS9bU2AOfH1vna8wAE/Y9TjANKDmHRXQoOV/izcksHWzOL4SXg9j9M3hhRFW5ksCFNAHZ833F4hdaOXiof+t4y+DnL0ifT8cYDjW4SgvRhKqCh75qfUxv1DBQsObzFGDeHaOPvMXMDna5L7D4JDfB1NyZkYN38KK/CEK4YRlGcHHrhdK6ol6TA/UPKVG6VF/Gg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(376002)(396003)(136003)(451199021)(41300700001)(6486002)(38100700002)(6666004)(2616005)(83380400001)(26005)(186003)(6506007)(6512007)(86362001)(2906002)(478600001)(36756003)(316002)(66946007)(66476007)(6916009)(66556008)(4326008)(8936002)(8676002)(7416002)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/TyIVCnbM8sQYCz2wpax5DHCMrr86BiPQA9wp/BVTxB0mVR6gnbV2bZR/Ui?=
 =?us-ascii?Q?5yBgGse2Jg66dZbtBj40v1ZsafJcs9OAGU1gaspOowus0V6isWJ9UdkAs3Ja?=
 =?us-ascii?Q?3Z+RxYvZuarIODaiB5DW20TDczcaYm7NpavPvNuvSkW8+7DFkrW6k4ZgSdMj?=
 =?us-ascii?Q?UlfC91A0YplF9xNHZzuOePasWLXJgUxAj2Puf1/jxTmDPy2j00SHnxXoIcQd?=
 =?us-ascii?Q?fV1s6UhzLYQ4Axf5k3J1KyzzyrTuB154pA6O7mUu0hyb2+DOVma0V5abNh6t?=
 =?us-ascii?Q?V3RHyuvlSxZVjuDKXBk+ARU8ugbhPmuW2+IBgFE5NlO1ao63uXc4hdRhhE18?=
 =?us-ascii?Q?qIJtlnxM/AF5pL00IOm6Qo6HLPjPqDcwZRuuYG1HXVy3BndTLU+Rd9eaqKzZ?=
 =?us-ascii?Q?KxDR5cFe+o4Km2GDrPSok0lm5nF1KJFs5bBT4IIvkX/4ec2HfI5SMiQ21tIC?=
 =?us-ascii?Q?JRiNkLpbsPdCnjFAEi17ovZZTnBB9dR/vzQ6dvMYUJG6dG5JtPXSOsO9Keeb?=
 =?us-ascii?Q?sHxvkrxEBXf/TEVz8J9X0Mlhor9oMHVyRaTDkcDWuW1pZQiow3xQpq8HueRI?=
 =?us-ascii?Q?r0CQuibCafZbIkx4r1RbHeM1MfevFP1U+eZE6C5QwPLIh0mQLTUr0pZiz1rx?=
 =?us-ascii?Q?t8uxczM44lnzK67pCyjd1g/P2DpIRbkMOhpFymVye06UMblqB/DAF1oL97Qu?=
 =?us-ascii?Q?zfvkMYJyL7bGeVKlKtg1PH5W1YgQLVKKzgFMKhIYL3hcWe5IP7A2t0v460Tl?=
 =?us-ascii?Q?IJS4NMWA5DnHdI/UIPkcsSTFKE3yLmfBDri48FWXYfbiIgIOSpWVEmFuxIIx?=
 =?us-ascii?Q?oylkFpWRl0hJC4n371N4VLVRrwK9fr++w+zaeY/PMG/J/X4LLNdR8oyQgS0g?=
 =?us-ascii?Q?wXe2i3v6DmvDTuSUcJl5/QDuVn60AQJ50mtzc99Ntzam5JQ8sp6rnfA2K773?=
 =?us-ascii?Q?o3h5C/xU+shUbqabLXwsOZuaEmf3DZfcf1vcISF4r4uC45l9jmpiGOlJ9m3e?=
 =?us-ascii?Q?EFM1fFH+/eT9bDMmB8m/428GVcFtOketziOCuzeKO0a6BsRHT702FguWec1p?=
 =?us-ascii?Q?uj9Y3MCBLgBd90qkdhOGRwpXlX7Nsxj4a7AMIzPH5CRuHH9R5UGD1v/8gw2n?=
 =?us-ascii?Q?uEQaZRXg64L42xVG45hUB098ahFFCv3AqLj1T57jnfOWBoPk/00FgmVKk5RX?=
 =?us-ascii?Q?1v7v4MfEBaO0Gw2JCqhM6aFcErs3hb/xOe1Peg1tG73MF086llK5RidOhLkh?=
 =?us-ascii?Q?Ym90Hic/l/Ka4c+KAhJ/eEM4ZbLvBGVCA4wMzjkqlc3N5Zf+aNpnatzkRPp+?=
 =?us-ascii?Q?3/hfG0SglL+F7hfGtwF9eBsMrL8Pi8NaLV03t6cmlmnqeXlWhR/zLKSJKUS1?=
 =?us-ascii?Q?ndl65/ZwpDH+dofSXQCunPsiWC54O0FBSoUU/QLVKXCtj7/Q4awKiHn2aa4H?=
 =?us-ascii?Q?EAAsIzcSn+5oYcwjYDT95TEIFv9+2B1JD2ksCleerWBUFMpK79Av+Qz5RhVI?=
 =?us-ascii?Q?AWC3pAENZhlj2czlRhi1vmXqFFyMKE5JAeoCfmcr2KO2umxIqxrqLsuajLi6?=
 =?us-ascii?Q?hH11Ksx59jhcWmBw7ukpbjZ439fA2MNhjNT65IO3900UogbbjXM+xb8q+Sof?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a7b1ba-a4ce-434b-2f5a-08db7cd01455
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 20:48:54.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqkhMA1om0zt9n/U02jpv/NdtZxMeVjkFa+BvZbOm4dnxvy0NN5tABBkJw6a51Y1aiBnHrBK9bl8IjsteslM/xSO4ihgjgsmxECUjmYG0do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3630
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 12:14:52PM -0300, Victor Nogueira wrote:
> If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
> was done in cls_bpf_set_parms.
> 
> Fix that by calling tcf_unbind_filter in errout_parms.
> 
> Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
> 

nit: no blank line here.

> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/cls_bpf.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 466c26df853a..4d9974b1b29d 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
>  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
>  			     struct cls_bpf_prog *prog, unsigned long base,
>  			     struct nlattr **tb, struct nlattr *est, u32 flags,
> -			     struct netlink_ext_ack *extack)
> +			     bool *bound_to_filter, struct netlink_ext_ack *extack)
>  {
>  	bool is_bpf, is_ebpf, have_exts = false;
>  	u32 gen_flags = 0;
> @@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
>  	if (tb[TCA_BPF_CLASSID]) {
>  		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
>  		tcf_bind_filter(tp, &prog->res, base);
> +		*bound_to_filter = true;
>  	}
>  
>  	return 0;
> @@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
>  {
>  	struct cls_bpf_head *head = rtnl_dereference(tp->root);
>  	struct cls_bpf_prog *oldprog = *arg;
> +	bool bound_to_filter = false;
>  	struct nlattr *tb[TCA_BPF_MAX + 1];
>  	struct cls_bpf_prog *prog;
>  	int ret;

Please use reverse xmas tree - longest line to shortest - for
local variable declarations in Networking code.

> @@ -505,7 +507,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
>  	prog->handle = handle;
>  
>  	ret = cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE], flags,
> -				extack);
> +				&bound_to_filter, extack);
>  	if (ret < 0)
>  		goto errout_idr;
>  
> @@ -530,6 +532,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
>  	return 0;
>  
>  errout_parms:
> +	if (bound_to_filter)
> +		tcf_unbind_filter(tp, &prog->res);
>  	cls_bpf_free_parms(prog);
>  errout_idr:
>  	if (!oldprog)

-- 
pw-bot: changes-requested


