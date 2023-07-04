Return-Path: <netdev+bounces-15445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C357479A9
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5F0280EC0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47928495;
	Tue,  4 Jul 2023 21:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017E847C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 21:42:44 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F4E54
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:42:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c17534f4c63so6860129276.0
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688506960; x=1691098960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp6blHpH6x8BVnyACEKGQVCdrlYR8NBKk0wrcs03X54=;
        b=YWFTX4G/Mjad0IwBLXCpxD7PEQM9LPJ6S0kOdw/XKxoAqxxzSDX3vBR1kHkTCcrjKc
         SnN+Ei78gyCqm3K18rkewqSZEt/kwZRWK/8WVZ0fkJOt/08jayGijHZOdAkhwuDKr+lI
         XTFLZnKYyUgmWJnrEfvBrnTob3SuoRjATAYJTz0xDRci0APza8knsWfZWx0Jncs5UDtT
         Fba8wYwzssneKabFRLsexULy0En5uh2f/s0U/HHERl8g+hQE1/iP9W3ZeyXnvxD3oTOX
         pfWdj3uHHBuTssGydko64VQpfqpvXJMGWZZmsOnKp35M1fJttPSKDt9LdVsEv4I3Q2Eu
         yfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688506960; x=1691098960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp6blHpH6x8BVnyACEKGQVCdrlYR8NBKk0wrcs03X54=;
        b=DMvD9OT9c06KyIvvqsQW5cK578ou+kHhtoyVAoMaQ5XPC+UuDIXHLhGfC92TOLlIs0
         PY603L9ks6ugs8ZNDd0VSfyNgTUKu/d7OLH4wH3NSw5XRNI34HHcswNPiW00IjUAeuJ5
         DSXKZTAY/YQ7pO4g26AdeP8EjRn5YGRzTpmnKawQKnIQbspkcdjw6+wPu9akA4FxKCWA
         Q7Ii0mZ3iluxCShEQXaMqj+Ui6GH3950MvFLPdR9tJnCt+M3BR2FrmeVwVdXnz4QA7p7
         XdctqdrangL/Ehkc1lFYa46xBomCDvWbGfuIa9RfMPBJgfhoJntrTD0cR6TGTvDluIy+
         Csmg==
X-Gm-Message-State: ABy/qLZFbHK50dYtFLK8vRaAdwrOwZhjuMTT3MMExP0ZBiN8ljo5fgwh
	AQs/nT3GSkmHFmx9F4YKyubRfd/zmYrXEN5nZ8iqSQ==
X-Google-Smtp-Source: APBJJlHgf06PuJCis2MZaL+xTrANbdyw8vxED30EvddBc98DYbflIsFfg7cedbQS2ScItndUHKOmha8i9uysvrwaRj8=
X-Received: by 2002:a81:4f17:0:b0:56c:e2c1:6695 with SMTP id
 d23-20020a814f17000000b0056ce2c16695mr12474232ywb.50.1688506960406; Tue, 04
 Jul 2023 14:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704151456.52334-1-victor@mojatatu.com> <20230704151456.52334-2-victor@mojatatu.com>
 <ZKSFrSW2zJZYelNj@corigine.com> <CAAFAkD-WppW_Gf+Dfm=SSr62PNQwwngwXe2=XKo52AkWD=sSPA@mail.gmail.com>
 <ZKSM/tWeECfu+lKU@corigine.com>
In-Reply-To: <ZKSM/tWeECfu+lKU@corigine.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 4 Jul 2023 17:42:29 -0400
Message-ID: <CAM0EoMm_Ry7PDwwtkS15-Ri5r_mSXYznDZ3Q5b5bOQmVZSWNdQ@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in case
 of an error
To: Simon Horman <simon.horman@corigine.com>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 5:20=E2=80=AFPM Simon Horman <simon.horman@corigine.=
com> wrote:
>
> On Tue, Jul 04, 2023 at 04:55:25PM -0400, Jamal Hadi Salim wrote:
> > On Tue, Jul 4, 2023 at 4:48=E2=80=AFPM Simon Horman <simon.horman@corig=
ine.com> wrote:
> > >
> > > On Tue, Jul 04, 2023 at 12:14:52PM -0300, Victor Nogueira wrote:
> > > > If cls_bpf_offload errors out, we must also undo tcf_bind_filter th=
at
> > > > was done in cls_bpf_set_parms.
> > > >
> > > > Fix that by calling tcf_unbind_filter in errout_parms.
> > > >
> > > > Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters=
 as hardware-only")
> > > >
> > >
> > > nit: no blank line here.
> > >
> > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > > > ---
> > > >  net/sched/cls_bpf.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > > > index 466c26df853a..4d9974b1b29d 100644
> > > > --- a/net/sched/cls_bpf.c
> > > > +++ b/net/sched/cls_bpf.c
> > > > @@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr =
**tb, struct cls_bpf_prog *prog,
> > > >  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp=
,
> > > >                            struct cls_bpf_prog *prog, unsigned long=
 base,
> > > >                            struct nlattr **tb, struct nlattr *est, =
u32 flags,
> > > > -                          struct netlink_ext_ack *extack)
> > > > +                          bool *bound_to_filter, struct netlink_ex=
t_ack *extack)
> > > >  {
> > > >       bool is_bpf, is_ebpf, have_exts =3D false;
> > > >       u32 gen_flags =3D 0;
> > > > @@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, s=
truct tcf_proto *tp,
> > > >       if (tb[TCA_BPF_CLASSID]) {
> > > >               prog->res.classid =3D nla_get_u32(tb[TCA_BPF_CLASSID]=
);
> > > >               tcf_bind_filter(tp, &prog->res, base);
> > > > +             *bound_to_filter =3D true;
> > > >       }
> > > >
> > > >       return 0;
> > > > @@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, stru=
ct sk_buff *in_skb,
> > > >  {
> > > >       struct cls_bpf_head *head =3D rtnl_dereference(tp->root);
> > > >       struct cls_bpf_prog *oldprog =3D *arg;
> > > > +     bool bound_to_filter =3D false;
> > > >       struct nlattr *tb[TCA_BPF_MAX + 1];
> > > >       struct cls_bpf_prog *prog;
> > > >       int ret;
> > >
> > > Please use reverse xmas tree - longest line to shortest - for
> > > local variable declarations in Networking code.
> > >
> >
> > I think Ed's tool is actually wrong on this Simon.
> > The rule I know of is: initializations first then declarations -
> > unless it is documented elsewhere as not the case.
>
> Hi Jamal,
>
> That is not my understanding of the rule.

Something about mixing assignments and declarations being
cplusplusish. That's always how my fingers think.

So how would this have been done differently? This is the current patch:
----
        struct cls_bpf_head *head =3D rtnl_dereference(tp->root);
        struct cls_bpf_prog *oldprog =3D *arg;
+       bool bound_to_filter =3D false;
        struct nlattr *tb[TCA_BPF_MAX + 1];
        struct cls_bpf_prog *prog;
        int ret;
----

Should the change be?
---
        struct cls_bpf_head *head =3D rtnl_dereference(tp->root);
        struct cls_bpf_prog *oldprog =3D *arg;
        struct nlattr *tb[TCA_BPF_MAX + 1];
+      bool bound_to_filter =3D false;
        struct cls_bpf_prog *prog;
        int ret;
---

I dont think my gut or brain would let me type that - but if those are
them rules then it is Victor doing the typing ;->

cheers,
jamal

