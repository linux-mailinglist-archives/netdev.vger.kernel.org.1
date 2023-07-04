Return-Path: <netdev+bounces-15442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7474794B
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F57280FAE
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7F79CB;
	Tue,  4 Jul 2023 20:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27331806
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 20:55:37 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1DE7B
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:55:36 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77acb944bdfso297732039f.0
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688504136; x=1691096136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQcL95AqTn9xxdO7zC4FBYNIj8Wh6VQmeUXzzi3jl8U=;
        b=0tasjvckrgoItNxsV1VndrcWbQQnzIgbwZeTz9kiNnWrqFqigVbHUbBueuMaxg4Fov
         dAdaWhv7YgrWAfXJqmG1lXxXKhb+7FCfHgKlHxQQFg9lWYf3xJhyG4BK0yrG8uliftvN
         0TU80G1ryLY3Cd3Z0DpX8UIn5SHRlOb/zUahxJtcEVZHsZBDJblzLXk2fquBEN2GXdfC
         gq7f9Lt57vvPXXCYN/EyfSeNQvbjDuBXYneRp8GJVXQjREeOfNAUbkWsoGfgIehOYD2h
         L6v5y2d8T2yCgzzRWWrD90+w9Aaq/nnWejAjAXMk9RQ5reAV8RHu5pDKQdKaCvqiS7XY
         35nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688504136; x=1691096136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQcL95AqTn9xxdO7zC4FBYNIj8Wh6VQmeUXzzi3jl8U=;
        b=HXdhJtyvLXXvdD2RPpOhv3PG3bqsAI9T7NdUOgdOeGSkqRZpOMlQu7AJlf8f2CGTSS
         bpTJyzKwGiz/ZjVjG14T5K5yK7XI9PwrPQXokDVnMrAHSfp8dktYYXO8KiCiM0qBCZQh
         FpXp8QIzF+Mu9Zaz6e0uT9tSktMIHvbb4mwjsIsckLWb5Wev0RS2iPRHdXv3oAOFWpYg
         k63Tepi41juo7MRJ5RZoxkjZ+eSYVpn3MnO/pSngWIS+KfpHi8MG41JNAW6gFRtMfMwJ
         T6u1I43SlKV/zSytlBCyNDQI/TFpDWYYWCiWEoLIVPh5UbMVYXFWqSAy6Tq1wr9cAfoi
         czVw==
X-Gm-Message-State: AC+VfDy3abmSbMme3mJkPrvnqePxgKgj/ffNFeqfuRGYttxMaeN6CEmu
	wraWbS6HNS2p9YxSA0iulaWJuxQZond/9gw2ew/97A==
X-Google-Smtp-Source: ACHHUZ47UWLAoQOJLhMRmAuJOpAQ/zEKSKS0bDjLmzjPxQAAptOwndJBkuqzQGHEP4St/XbpUGnv1BkF6IPg1eClhW4=
X-Received: by 2002:a6b:630e:0:b0:780:ce72:ac55 with SMTP id
 p14-20020a6b630e000000b00780ce72ac55mr15629649iog.10.1688504135956; Tue, 04
 Jul 2023 13:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704151456.52334-1-victor@mojatatu.com> <20230704151456.52334-2-victor@mojatatu.com>
 <ZKSFrSW2zJZYelNj@corigine.com>
In-Reply-To: <ZKSFrSW2zJZYelNj@corigine.com>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Tue, 4 Jul 2023 16:55:25 -0400
Message-ID: <CAAFAkD-WppW_Gf+Dfm=SSr62PNQwwngwXe2=XKo52AkWD=sSPA@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in case
 of an error
To: Simon Horman <simon.horman@corigine.com>
Cc: Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, jhs@mojatatu.com, 
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

On Tue, Jul 4, 2023 at 4:48=E2=80=AFPM Simon Horman <simon.horman@corigine.=
com> wrote:
>
> On Tue, Jul 04, 2023 at 12:14:52PM -0300, Victor Nogueira wrote:
> > If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
> > was done in cls_bpf_set_parms.
> >
> > Fix that by calling tcf_unbind_filter in errout_parms.
> >
> > Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as =
hardware-only")
> >
>
> nit: no blank line here.
>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > ---
> >  net/sched/cls_bpf.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > index 466c26df853a..4d9974b1b29d 100644
> > --- a/net/sched/cls_bpf.c
> > +++ b/net/sched/cls_bpf.c
> > @@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb=
, struct cls_bpf_prog *prog,
> >  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
> >                            struct cls_bpf_prog *prog, unsigned long bas=
e,
> >                            struct nlattr **tb, struct nlattr *est, u32 =
flags,
> > -                          struct netlink_ext_ack *extack)
> > +                          bool *bound_to_filter, struct netlink_ext_ac=
k *extack)
> >  {
> >       bool is_bpf, is_ebpf, have_exts =3D false;
> >       u32 gen_flags =3D 0;
> > @@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, struc=
t tcf_proto *tp,
> >       if (tb[TCA_BPF_CLASSID]) {
> >               prog->res.classid =3D nla_get_u32(tb[TCA_BPF_CLASSID]);
> >               tcf_bind_filter(tp, &prog->res, base);
> > +             *bound_to_filter =3D true;
> >       }
> >
> >       return 0;
> > @@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, struct s=
k_buff *in_skb,
> >  {
> >       struct cls_bpf_head *head =3D rtnl_dereference(tp->root);
> >       struct cls_bpf_prog *oldprog =3D *arg;
> > +     bool bound_to_filter =3D false;
> >       struct nlattr *tb[TCA_BPF_MAX + 1];
> >       struct cls_bpf_prog *prog;
> >       int ret;
>
> Please use reverse xmas tree - longest line to shortest - for
> local variable declarations in Networking code.
>

I think Ed's tool is actually wrong on this Simon.
The rule I know of is: initializations first then declarations -
unless it is documented elsewhere as not the case.

cheers,
jamal


> > @@ -505,7 +507,7 @@ static int cls_bpf_change(struct net *net, struct s=
k_buff *in_skb,
> >       prog->handle =3D handle;
> >
> >       ret =3D cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE],=
 flags,
> > -                             extack);
> > +                             &bound_to_filter, extack);
> >       if (ret < 0)
> >               goto errout_idr;
> >
> > @@ -530,6 +532,8 @@ static int cls_bpf_change(struct net *net, struct s=
k_buff *in_skb,
> >       return 0;
> >
> >  errout_parms:
> > +     if (bound_to_filter)
> > +             tcf_unbind_filter(tp, &prog->res);
> >       cls_bpf_free_parms(prog);
> >  errout_idr:
> >       if (!oldprog)
>
> --
> pw-bot: changes-requested
>

