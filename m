Return-Path: <netdev+bounces-15443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389A747983
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 23:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D391C209F0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA43847C;
	Tue,  4 Jul 2023 21:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1DD79CC
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 21:20:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5B127
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1YIjMvICLYyuxeA83CvcOAJEk+wGqSbncoM0To3tgYj0gC5uuaFG5kBGGPjsHCSpls7t8FYokb0+nEKgECD4Pc059no21o4KqafyzY6DEctNpEJ9cBZRg45Y0CCvLKb/z2MlXizyMeNBE6msrWvVBjGsdjuACxgdhEaQM4AKj6EuAxf91RKkButCtMOAjiAKwz6Lc+pvjfkixhyWIrYkttL8cyt3hmRTmT9TOim5KvNTkZUpucCVjcGq8asDGpNmm6fC8C9m1uDp9QimPBr/cCemkioMM2drjheoddASyAOowg61zV3nwTWNpVbMuR+cK040M32cAH/hay/HndMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZkBtPYBi1ylUBSxMpjeCQccbue+5BiFJ0X/hg2nX8I=;
 b=fzE0CeNP4wxQi3gO8FP9q5Tm6b7oRDmN2mAaquei8/P/MtPvhqEwtkewYPKr5N1Rnr5cnia6OtpFmpMkwWyxwKECSoWc8PkOfqLOmXKmA80OENZLy2GKuMCC+iRurMxciJ289PS5ZoeVHo4YRRdzfMD819JE2n8Jeo6IIm/iDaKeroeu+8oLTNgX0T7dJ+u6JvM20OR5QZnmVHZGEGLY6auHlBD02VFdSKlNuXThlcjQi1FnwyQabDpgv9G5WnYU4WSdjN0hSgndG9nkVjIZ5bYmlgcQcHgb/isHlUxl9mJkV2mF0g+E16xnoatWYFhZyj365/qHRrlCmUe6bykS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZkBtPYBi1ylUBSxMpjeCQccbue+5BiFJ0X/hg2nX8I=;
 b=RRJvyWFsMp35fYT2tplccRfg75b1kG3r5lk/JbpRIsoi2a9oYydwTSc2UtFcSRPtRw6hnc5cAgw7HWbeLFT3JmJ+s2uUAr9LNFbXkAiEb91iltII/akPWjkehHcUVmVyDOV7Zq/4o3kDfN/uY4hem0As8BXoE5xKZXBJIy8iAow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5668.namprd13.prod.outlook.com (2603:10b6:510:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 21:20:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 21:20:05 +0000
Date: Tue, 4 Jul 2023 22:19:58 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pctammela@mojatatu.com, kernel@mojatatu.com
Subject: Re: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in
 case of an error
Message-ID: <ZKSM/tWeECfu+lKU@corigine.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
 <20230704151456.52334-2-victor@mojatatu.com>
 <ZKSFrSW2zJZYelNj@corigine.com>
 <CAAFAkD-WppW_Gf+Dfm=SSr62PNQwwngwXe2=XKo52AkWD=sSPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFAkD-WppW_Gf+Dfm=SSr62PNQwwngwXe2=XKo52AkWD=sSPA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0667.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e282284-13af-478f-11f5-08db7cd46fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pNwSiALFqa2r9I2TyiGZ/yjlu4cVClE3TUw9CehOT4murveTmkJJ+bim04Xmwtb2N6R5fht2GgUM/RpuVJv4YSOcuQIGpdDl5NVGgQrTlvgbk6Fcfl7puj7i5m1tppIAyAErVpXj9UtMZBXzLwkpK1m/MUKNKBgA0tD0LhssHcUx2t9GDS9S4mvccnEtnPC4qT8YE8xWQxIpNJ20Gbzv82E/Yizu0gZHnZB7GU1xg2uDqRtozXcdeBNIRgGWCtWwSqJXXwzQsW+XdRYi/K0PRRbV2hNT9gpExGYM3P4NZBPfkgudaB0qUiuoUl91hE3NK0madhseB7jAKJwnh1AnBtQzUVgpdwi6N/CMJ5BI7oeYvkhDsUVqCAUAE2UcQoIGGE60olLm22nibQTY7qfABjodZ/nLok7aZAS2f3B812HlYotZo9inj2dCOA9e5Yf8DrTwnaX0b6oY+0XuphHncymsjnEnk9llgoxxI1GCIlK7VPRLlEC+0eTfOkznPK6VBI7FHbdB1ELGnaxGbax13k6ZO4pqmPssQJJV1XRPrgeeAxBU+YwMMJXnGqxl/bebwZwreU8HW5kGzHF7R1uwFJ/dm7o9RFqSK4THssZmtoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39840400004)(396003)(451199021)(2906002)(86362001)(6486002)(6512007)(6666004)(36756003)(2616005)(44832011)(8936002)(8676002)(5660300002)(7416002)(83380400001)(41300700001)(6506007)(53546011)(186003)(26005)(316002)(4326008)(6916009)(66476007)(66946007)(66556008)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JGT1RHOFp3cisrSWE3U3lTcGV3QWtkVkR3MG9qTExCTytZMWVzVDVOelpy?=
 =?utf-8?B?TFVCRFFrS3A2NmR3L3h4Zzg5YlNONFBpbzY1c1BXZ2RRUklBUENZaDdidmRx?=
 =?utf-8?B?QlRCVk1adEpLUlNtdzdGU3VMVitmOVpaZFh3VXFwSkM3UkNoVXNQRUpFWlkz?=
 =?utf-8?B?SXhMQ0FJWjJoUDl1RWZocHQ4WE5PTVpNWWZtMmxyK0tzSWN3TjVTL2N1cmlM?=
 =?utf-8?B?RFBoeGk0enpqV1hJOVhrZi83YzBUUkl0aW5BRjRRTTdFOW1hRkdkQmQ0N3ZU?=
 =?utf-8?B?KzlyMjMxQW9qVTZQRjBWdUUrOFZ6V28rcFBwRVNNemhHM3FsdE5Hd0RiamE1?=
 =?utf-8?B?TitLa0poSXNRWEhBNmlOd1QxZWRTeTBMVzdsNkNub21ta2ViUjM5RGNiMEdu?=
 =?utf-8?B?OFl3eEdEcGRTWlp3QzJGTXZqanZkOXNsc3hzcjQ3RllNRDY3WUdQL0ZYc2Zj?=
 =?utf-8?B?Z2JZb0txYm54b2ZmU3Q0V0ZiUFVDa0gwUHpPM2lEOTMzOWJKemQvRDMxV2w0?=
 =?utf-8?B?d21EcEkzVjREazRjT2dCcmNSOXltRlRBWUlxMjhJUjJka2lwZTRiMjdRMGh4?=
 =?utf-8?B?aFlEMkk5REdDZHQzZ1l0OGl2QWNPM05LdG4zRFpOclZnWnozZVNOVlhTd242?=
 =?utf-8?B?aGJSYVhrL1B1Q0lkRUZLK3h5M2E4U3FqMG84WUZYcE00OGY1MGpWZndpSFkz?=
 =?utf-8?B?L1ZqOWRJa2hKQ3FMbHJFdTN4M0lnV1E1WERiblVMSmVGMGtoTUErVDNkWHVm?=
 =?utf-8?B?a2VoeCtNSVRtV3NPcmc1YWwyWVhVLzBsU21jcU1TUTZTeWlMaXNWSlYyRkFq?=
 =?utf-8?B?MGlOZzdYV3NjNFVpME1sYVh3VmRNWmFQSVJyUGJCdW5QQ3ZaWFVrRVNCZzlQ?=
 =?utf-8?B?cFo4TTNsckNzVzJNaFIrVDY0cm5FL3lhb1lrV3d2VmtWNVpZdFhvbUE3a2I0?=
 =?utf-8?B?RldpYnMwN2NJWlJkL3hZcG9SY1hEQk1VSmFhYS9VeXJyay9HRDZValo0MDIv?=
 =?utf-8?B?ZnBWa0NtK2M5VkRUWUo3djFDeisxem8wbHRYMXRWdk1VMTdVNk1WZ094Snhx?=
 =?utf-8?B?ellKVHR2TUJZdndBMFpYSEFmYzdYcUMreVVYV1BvL1cyay9EclA4VmRlK1p5?=
 =?utf-8?B?eTMydHBQTTdHWmhnenpmamtnZFJwcTNtVmEva0t0a21ESXpieGNSNW52OHhI?=
 =?utf-8?B?Y2l0bGdIeDNFYVVrUGJBSTlZKzJPOFpsZUl6RjJITXBSSStWU1gyYXFXL1Bn?=
 =?utf-8?B?RlNrKzU3RGoxZ2QyQVFsVE1TOWoydWxHRGNmclkxb0lURFJtT2JKRWE4MVRZ?=
 =?utf-8?B?TGExTk5jUE02cjVHa2xhRzNOZEVha0NmS3YwakdkZzRYU08waGRBdHVqWXp2?=
 =?utf-8?B?NzVzUmlUNUJ5Nm91cFplZGpoenJ0eW9FVTRPa1drMHp4OUdyRW5PTGpWQVR2?=
 =?utf-8?B?YklmNFNoWnZHQXRqMzVaTmg1dkNkeVNwVTZBdFhLdTU2cThsdUVUc01TZ1E5?=
 =?utf-8?B?T0dWQnR0SDZFaWJocU82cEhjdzZLd05VT2x6K1F0aWlmSFJTNEo3V0FYZ3dW?=
 =?utf-8?B?d1FGb1dVaFhGUFFBNUxOc01nZmtBbzNSRzh4QjBZZUZPUjN4SzJjVEk4eThr?=
 =?utf-8?B?WU44cmdTcmpXOENJTmxVVnpMdS84SG9PSXo0d0ZtU0picU5NVmJxZ3g0Z2hN?=
 =?utf-8?B?OFVKUEJ0cjU1ajVwMDRpY050UVluUE1DN3ZsajBFNHNONWNiVWFzT0ZQVk1i?=
 =?utf-8?B?MmcyR2tpR25HWWNxa1JhV3RZUm5qUVh6RUg4Q2NkVGNIN3ZIck5aWVQrNTdr?=
 =?utf-8?B?Ung4SWE2U1Ftb2lUZVM1R3lFNWZjTUlueGp5RGFnNitXSjZPcHBZQ3V5aWl0?=
 =?utf-8?B?eGFBNnBydFdEYXdJVkZpTE42THVDcTduMXkzSE41Zzd1QVBxbUE4S1hBcTFX?=
 =?utf-8?B?eEhBblBKL1czM0ZjS3JwdnpvL0ozckpLMDRPUnYzOXJ4WmpTQzJBVS8xYnU0?=
 =?utf-8?B?UjhiTUpTQ28rck00ZmkyaXl3VHo5SmFKTGhxZWloaHRsM3hER212S010S3J2?=
 =?utf-8?B?aWxHeGNwRFN1NHVLL2t5aUZ6SE9jeTFHTnhFdHV1ZFAveWdSL2xzb3RQdmdZ?=
 =?utf-8?B?eXFVVjBWM0QxcGxWVlI3VktmbmJ1KzN1VGc1cGRYbHlrMkd5M1A2b25qVmdv?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e282284-13af-478f-11f5-08db7cd46fd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 21:20:05.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGnXRnagP54H8qWPXqkqFabsXPZQnteW2LdCyaVEWWj2CGkoUpQ1f5e582zk8zFOeGcRUBR69EQwc2ppfG7cWzSHbJQmTsSDk8pLMNlim/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 04:55:25PM -0400, Jamal Hadi Salim wrote:
> On Tue, Jul 4, 2023 at 4:48 PM Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Tue, Jul 04, 2023 at 12:14:52PM -0300, Victor Nogueira wrote:
> > > If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
> > > was done in cls_bpf_set_parms.
> > >
> > > Fix that by calling tcf_unbind_filter in errout_parms.
> > >
> > > Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
> > >
> >
> > nit: no blank line here.
> >
> > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > > ---
> > >  net/sched/cls_bpf.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > > index 466c26df853a..4d9974b1b29d 100644
> > > --- a/net/sched/cls_bpf.c
> > > +++ b/net/sched/cls_bpf.c
> > > @@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
> > >  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
> > >                            struct cls_bpf_prog *prog, unsigned long base,
> > >                            struct nlattr **tb, struct nlattr *est, u32 flags,
> > > -                          struct netlink_ext_ack *extack)
> > > +                          bool *bound_to_filter, struct netlink_ext_ack *extack)
> > >  {
> > >       bool is_bpf, is_ebpf, have_exts = false;
> > >       u32 gen_flags = 0;
> > > @@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
> > >       if (tb[TCA_BPF_CLASSID]) {
> > >               prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
> > >               tcf_bind_filter(tp, &prog->res, base);
> > > +             *bound_to_filter = true;
> > >       }
> > >
> > >       return 0;
> > > @@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
> > >  {
> > >       struct cls_bpf_head *head = rtnl_dereference(tp->root);
> > >       struct cls_bpf_prog *oldprog = *arg;
> > > +     bool bound_to_filter = false;
> > >       struct nlattr *tb[TCA_BPF_MAX + 1];
> > >       struct cls_bpf_prog *prog;
> > >       int ret;
> >
> > Please use reverse xmas tree - longest line to shortest - for
> > local variable declarations in Networking code.
> >
> 
> I think Ed's tool is actually wrong on this Simon.
> The rule I know of is: initializations first then declarations -
> unless it is documented elsewhere as not the case.

Hi Jamal,

That is not my understanding of the rule.


