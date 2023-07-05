Return-Path: <netdev+bounces-15480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46461747E74
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA5E1C209B1
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65F1C16;
	Wed,  5 Jul 2023 07:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A61877
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 07:46:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67737E59
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 00:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdQiaACUKydMzseAEhkdfEY7uCK3y5fIHbd8Sehe/Gq8Jc/SaiQAhlhIwUXHvlcSYqyS/G1jmLzHyUcAVVpV3Gm9IZreZhjly6xMyA4HRum746YIfKAnZBbrAfdHBo6Wyz4I68FCyWnlbBTDjFc/NaM0whdPhnrZsfVWoVwadh+opB8np6ZU7scVssUZidBL0ecEisXvSIqeJbAIkuMIxTWAMkG4oSiS2RXVWhrKbjhvyH8S/nDozt7UelJNwsqPMmWsJ6vIz/66UCOse9WE50MGMeR8Z1xeZYZ/LTaeVEtMM/ueuzOaCWeOE/0qcZj7fkGRNPlyubjezkBXniG9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocAzheh+cSdUcSlLENoaIHntXgAmLJBlCjjW6KYlCJQ=;
 b=aOPolpxZjpCHdI7ta4QhbiXT/hB7QnKWNp0KkaAc/MU47Pndl3E72kV+T8bJPTD64FzcJmaJhDuBCrCIuZzdo+xm0Smh191pw6DGt7LwVUiaFlQy/MQ8oJlTkgF1j/sNt8T+GofdUeyYZHWkKdHzkwnsqAq+hDV2hPB6V9XhrgrBx8g5iif5r9d6ShEmibZ7HTjhPNWXpQ/+17kBbZWYFxtsKBs26jpsMUovgZxGbRhHKeAjknRpyWUHdQAeD3ob4m3uAkVssYP9ZTZ/0Uv9yIA4YiDzqN9Xy0A1W82Tm8VrrI8syL9yipjiTQsSpE0M9+3XhQ1jDvNPpbyxksZmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocAzheh+cSdUcSlLENoaIHntXgAmLJBlCjjW6KYlCJQ=;
 b=KyzN+P2bxJIKFqdPjLey8ARUJuPMvlzazifV67lSpMdlQXWFo7tvNyNy4OaHXO1FjfMTuPa1KiKYf6Dn1hV3qLfMdy2OYxBSiQHeFABiXrtQMk7QYh6YMpvFEqU7BCwFXZETBjWvrdKU3xAyfooWf5YBzfrVBESSTsD0CMW7dOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4675.namprd13.prod.outlook.com (2603:10b6:208:321::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:46:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:46:05 +0000
Date: Wed, 5 Jul 2023 08:45:57 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	pctammela@mojatatu.com, kernel@mojatatu.com
Subject: Re: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in
 case of an error
Message-ID: <ZKUftWakv7v1C4h2@corigine.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
 <20230704151456.52334-2-victor@mojatatu.com>
 <ZKSFrSW2zJZYelNj@corigine.com>
 <CAAFAkD-WppW_Gf+Dfm=SSr62PNQwwngwXe2=XKo52AkWD=sSPA@mail.gmail.com>
 <ZKSM/tWeECfu+lKU@corigine.com>
 <CAM0EoMm_Ry7PDwwtkS15-Ri5r_mSXYznDZ3Q5b5bOQmVZSWNdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMm_Ry7PDwwtkS15-Ri5r_mSXYznDZ3Q5b5bOQmVZSWNdQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0d97c8-8823-469c-498b-08db7d2be34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+je6fMPUvJp9f7PHQUwdKfLMZXJnTs5h/GafXv/bNELqdKPp1K9zQtcPvpb9vmcItH32jD05RLpJrgn1N/52hb/4RJbrnPOPdkhfevSKDCI4jYMrEPXq8xxZd4gQC4xYFyrwL6EXn10Iw0jlYFeCl0BEAqdvmfCFECeNHVkTKEgxGY0DOC7F/O60n3C1ol7uV6dAgbqGQiKElC3KprirGrvVmUinwvmchlhSX7XbSy8mZ5WHrdNL9D1MP7vrCTfw79CZK2eQOtDEbxmqAb15N04ITFwWw0ieC2uk9rTFU+0taOKzfXJjOAU8t7tqV9/P4DKXTDr80wAGNfV6SCgf01JSAOe6/sH2zRhip7KrntZ7LbWznH1Dbrol2EqVl2hE8d1UFyCLOgG7sYlcaVxd8soLLWzvr5WIqMBYJ4oEL8C8TYnG8ypO3A7v4jhd0jbzFBHTYNwPjEsE4+lYwirbpqPvXR6CfQJHx55dysNceWCpPQ8wtwjU85iuViVpTygrfHaZKL+CoED9ZE8i7QyDca2eAHztTCbcs03mhh3IULKPIjIP5o1B6GvvVSDgRquAD+NuYtZA29EnSfNmsInqhxjEiDee8HGyDMoo/d0b9L0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39840400004)(346002)(396003)(451199021)(2616005)(6666004)(6512007)(6486002)(478600001)(54906003)(53546011)(6506007)(186003)(26005)(2906002)(7416002)(8936002)(5660300002)(66946007)(66476007)(44832011)(41300700001)(8676002)(6916009)(4326008)(66556008)(316002)(38100700002)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlKckVLZlFEMmEzVXU1VEx2ODBrOGg1Tlh3eDdicjFWVHZJcEJvc1phcGRm?=
 =?utf-8?B?M3kybUhpRnlmQnhTMmVhRkV4SWdxMGhrSDUrWjBhdlBoUlZ6TFpOWTAxd1VZ?=
 =?utf-8?B?WHdvNEZ5OFh2UldZMFZGQXhxM0NwemMwZExvSXUrK21neXFpV0ZuRG12MTVK?=
 =?utf-8?B?bi9lRHg2Yk1YWlphdFU2YUVtU01QejFMMUxaek1HeUduM25JVm1MM0pVNk12?=
 =?utf-8?B?cy80dG9jMFcvM1l5Q29wMzh0RVc5U2RCaXErWm52QjlSOGR5ZzdMUU1xeXNz?=
 =?utf-8?B?K0F4Q1dQT0F5d2NYZWI5SjRQaEJiWXdqTFB4VGNqT3NpL1FZUGU5WU1XN0pj?=
 =?utf-8?B?T3BXb2FjM0plaEx6dDFnckpnVEVEZ2xxcHlGVjNuelZhT2ZGMVlJS2c1RnMr?=
 =?utf-8?B?VHhNMWYzRjNVQUR6dzZab3dLRVVwOTlJWGlNU1lNZStWVTQ0ZTVnMnQzN2ow?=
 =?utf-8?B?NjVlVG5PRlcwU2V4dGc1VWxlbzlOTFU5eFFUUHhCRGhYVW91V2tQS0o4b3Uv?=
 =?utf-8?B?Uk1yTW45Y0MyU3RldkYzVjZLa1FFVzlJV2dPWWZRK2lNRVpreHdpaW1UQU1o?=
 =?utf-8?B?MGpGaUR6Mi9lRXdPY21HOFZ6NjYrSlZ3cUFPVGRlVTNLQmMvOXMyUnJrRm1l?=
 =?utf-8?B?TjFFL1RwVGVVcWVPTFBHZnRXRWEraVhtUFZrMFJVbWtPWW4xUnlhU2VEMzZl?=
 =?utf-8?B?MUYyUDUyTlZYUDE2TlZIeXRwQkRqWkFmSmVtNit3cmtPNzdMb2NnbmpzclBV?=
 =?utf-8?B?TVR0SWRHQzR4aFlEcXFibzJzSktIUkl5c2lnc0JEeWNuQnRRZWtPNWxqVjc1?=
 =?utf-8?B?ZnFPbytFaTFDWlorVGpKaURVbFZnelpDVXRLZHo5ZEdBSGJZVk8zTk9XN05G?=
 =?utf-8?B?ck5ZckZFL3UyMTJRWWNybldjYXNtUm53YzU3TWJLa0FOVk5PKytKR2pnQTAv?=
 =?utf-8?B?RFNIYmUzVlZLYUZuNXlOS2FQbUNYN0VmN3RxZ0FRV2RyUG5tcjFoM1VNUzd4?=
 =?utf-8?B?aENVZjJ0TmJ2WWRsQkYwRVh2WnpIQ0d1UVowVG4xemo5YjZacVNtZkZxbWlv?=
 =?utf-8?B?cEZlREs1L3dnMW8yUVlEN3NPV2RvdFlGazV5MnZUQU41cS9FOFJRMnVhQWxT?=
 =?utf-8?B?cjRhZTVIM29TQTN6T20xZ3ZPNkNTeTRqSkcvNUUyTDdCS3FNQ3hkYU9ET2hw?=
 =?utf-8?B?bGhjelVsMWFnZklIZ2k5OEZIZUlNbUhCSzZJVFJIc1lzREd1bmhIVHJ4dFJY?=
 =?utf-8?B?MU9iRWVMdnlleUcvMkFnaEptV05BbW8rVThWSWRnUFI1RGptY1JDMmZlQ1BB?=
 =?utf-8?B?N3lXcXdpT1pYc3h6aUpRWENXL3BjM0lVZFVoRXNaV3FMSDJieXkxa1E3OE9F?=
 =?utf-8?B?VFJJYmgrRkdLREx6MXJuOUUyY2hzRE85VGZFQndkY1JCb2hyWjFMd0wraDBV?=
 =?utf-8?B?SmZ1U09JenJUYlhLRkZXV2s0bGRWNzJ2THBiQlN6a2MrMWJXaThpSWxlWUFY?=
 =?utf-8?B?Q1laUzhGeDR3ZnMvVDVnKzJXTmQvSkNpT2dtZlpPdWpabzNMTDlERVpTVXJn?=
 =?utf-8?B?RktldUQ3aUsrcDlaUmUxWEMrbTU5dHA2NHI4cHNPZ0JyWDczcXY0ZjQxSmZN?=
 =?utf-8?B?RmxIRCt2aW1MaGJHNE10YTJYaVFZYkpqUVBBMHVGL0ZydDljUi8xNVpMdWV6?=
 =?utf-8?B?UXcvOW80OGE3WDU1dTVuNXZDY3kzR0xNR2dUNmRmSDZPWG4zcDhFSUpsTkhO?=
 =?utf-8?B?cUI2UVJ2UW1HeFFKaWZYaVZ3YVBPbWJqQjFnK1dsU0dZRDhDNVJRUVY5TWZN?=
 =?utf-8?B?VHF2a0tTM0pTcVMwai9oa2FxUS9lZkh3NGxXbE1DU1RFRWtrS1JhNHcyVkNF?=
 =?utf-8?B?c1o2Qm0xNmsyS2hXUXlHZWFHTjNabzROMm5HSVZxNzBOdGdJNnJWR3d5dXhr?=
 =?utf-8?B?NGN6em1BVzdIc2ZPamVVaDZ2L2M4R0VldHBQamt5a245SElsU3dWZGxDdTBH?=
 =?utf-8?B?LzVYMC9KaXNES2s4cE1KYkYvMWJQdTRrL09wS01hbHUrTnREdStvRFROVHJS?=
 =?utf-8?B?bDEzRDNGaWUwR2RDUS9XUUhkSXRVQU11cW5lTnlIRVYva3RMbFJ6V3pFV3k4?=
 =?utf-8?B?LzNoUHZIZHpmK2VWQ0s3a3dXWEc4U2d2dzc3eCt6amFuL016SnJmUSsreUp0?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d97c8-8823-469c-498b-08db7d2be34c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:46:05.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHonMOYckkVgJZmDS95gkyJCZKnoc3kvawC5fuvtW/DhavZscZH+prm6RSRhHowjG7e72XcgZXTsxMfs7xA1i8FXf0ToDjkbPpXOcVo2pck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4675
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 05:42:29PM -0400, Jamal Hadi Salim wrote:
> On Tue, Jul 4, 2023 at 5:20 PM Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Tue, Jul 04, 2023 at 04:55:25PM -0400, Jamal Hadi Salim wrote:
> > > On Tue, Jul 4, 2023 at 4:48 PM Simon Horman <simon.horman@corigine.com> wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 12:14:52PM -0300, Victor Nogueira wrote:
> > > > > If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
> > > > > was done in cls_bpf_set_parms.
> > > > >
> > > > > Fix that by calling tcf_unbind_filter in errout_parms.
> > > > >
> > > > > Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
> > > > >
> > > >
> > > > nit: no blank line here.
> > > >
> > > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > > > > ---
> > > > >  net/sched/cls_bpf.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > > > > index 466c26df853a..4d9974b1b29d 100644
> > > > > --- a/net/sched/cls_bpf.c
> > > > > +++ b/net/sched/cls_bpf.c
> > > > > @@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
> > > > >  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
> > > > >                            struct cls_bpf_prog *prog, unsigned long base,
> > > > >                            struct nlattr **tb, struct nlattr *est, u32 flags,
> > > > > -                          struct netlink_ext_ack *extack)
> > > > > +                          bool *bound_to_filter, struct netlink_ext_ack *extack)
> > > > >  {
> > > > >       bool is_bpf, is_ebpf, have_exts = false;
> > > > >       u32 gen_flags = 0;
> > > > > @@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
> > > > >       if (tb[TCA_BPF_CLASSID]) {
> > > > >               prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
> > > > >               tcf_bind_filter(tp, &prog->res, base);
> > > > > +             *bound_to_filter = true;
> > > > >       }
> > > > >
> > > > >       return 0;
> > > > > @@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
> > > > >  {
> > > > >       struct cls_bpf_head *head = rtnl_dereference(tp->root);
> > > > >       struct cls_bpf_prog *oldprog = *arg;
> > > > > +     bool bound_to_filter = false;
> > > > >       struct nlattr *tb[TCA_BPF_MAX + 1];
> > > > >       struct cls_bpf_prog *prog;
> > > > >       int ret;
> > > >
> > > > Please use reverse xmas tree - longest line to shortest - for
> > > > local variable declarations in Networking code.
> > > >
> > >
> > > I think Ed's tool is actually wrong on this Simon.
> > > The rule I know of is: initializations first then declarations -
> > > unless it is documented elsewhere as not the case.
> >
> > Hi Jamal,
> >
> > That is not my understanding of the rule.
> 
> Something about mixing assignments and declarations being
> cplusplusish. That's always how my fingers think.
> 
> So how would this have been done differently? This is the current patch:
> ----
>         struct cls_bpf_head *head = rtnl_dereference(tp->root);
>         struct cls_bpf_prog *oldprog = *arg;
> +       bool bound_to_filter = false;
>         struct nlattr *tb[TCA_BPF_MAX + 1];
>         struct cls_bpf_prog *prog;
>         int ret;
> ----
> 
> Should the change be?
> ---
>         struct cls_bpf_head *head = rtnl_dereference(tp->root);
>         struct cls_bpf_prog *oldprog = *arg;
>         struct nlattr *tb[TCA_BPF_MAX + 1];
> +       bool bound_to_filter = false;
>         struct cls_bpf_prog *prog;
>         int ret;
> ---
> 
> I dont think my gut or brain would let me type that - but if those are
> them rules then it is Victor doing the typing ;->

Hi Jamal,

Let's not drag this out too long.
But, FWIIW, my understanding is that your 2nd example matches the guidelines.

-- 
pw-bot: under-review



