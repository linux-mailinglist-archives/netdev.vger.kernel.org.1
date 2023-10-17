Return-Path: <netdev+bounces-41983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C387CC83F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23C42819D3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8F45F4F;
	Tue, 17 Oct 2023 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="p8eHLRN3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB4EBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:59:45 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDDF95
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:59:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so6193447276.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697558383; x=1698163183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6IbsLo69yoSshe3I0+RHVJxg171ptbJv4TdUXb0T+4=;
        b=p8eHLRN3JzdQwZbCZxZw2MU568jgakR/dCDROu9TiRqRS6WZnTz9zV46Ny5n/YF27l
         hzKyYL7mPa39pYD5U1j+Dn6EOjWXAXj1TDG1cdV1Rt/mgE5j4BO6SO+18RcVm3GWvA/v
         m0B5YIK5pEAOnRpwTJaMhYL4YaISHfhocGKDTlCEmkb3t3GQp6dda7nLIsAv6ObgR7gL
         ZMOjlRtCQ0au+COlwqopFRC5vJv5tB/IVWfCwW++wyfoIfxkZApQ0xhoVsD+te9ltQBU
         EGvFoyuhi4iohczuwUt8fK8SqCu8saglxTG4a0tWq5Rwv1Wh3R6gEbeJgLvWdqxgUrIU
         fjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558383; x=1698163183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6IbsLo69yoSshe3I0+RHVJxg171ptbJv4TdUXb0T+4=;
        b=JRzJ6M2mdPjc5P+cjtcsICVTNcF1urqRTr9oDszB/OgxE8nOObq39/2ZD506SyL0rD
         IHsW/M+v9oogbhSd+MW7gCUeHRVigIA29bchqjJc9fK1qoFZYUysUsS9JGWWbUKLzzic
         rmxQtuX4394AqRjaJfL2DdtoQGGg46X48/TitJdtTNN0VPVX+U9h8/+FucREJtfHDWf4
         6154pSsqgmRSNnuDe34gtdUQBHSa9ZbA3mkZZSWNWiIUJzQk4Je4xDpL5k2bOhLNBML0
         8jXwNUwz16a24b3avtkC5s9f+zRfxiLM4+SxAbQyK8QK2sWLA51NZOnjAK28V2ntGKMO
         cJNg==
X-Gm-Message-State: AOJu0Yz5hYjz8CEDdxIQ3ce9CDmfJ6x/MJpOj3CpzJipaLQXhAKgE7R5
	Lg4TyMjE7JXqcSNeba7Nuf5IDQIKvgqp5VQcrGYKNA==
X-Google-Smtp-Source: AGHT+IFIFYh0ORiai4OrVpmog0Q/qSs/TJ/nHTNAvSG/0uSQn4aRsWjQcf9DYr6Koow+i6tAh6MkVZTWFw91T6M2pBE=
X-Received: by 2002:a25:42d8:0:b0:d9a:55e5:9a0c with SMTP id
 p207-20020a2542d8000000b00d9a55e59a0cmr2456497yba.26.1697558383019; Tue, 17
 Oct 2023 08:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017143602.3191556-1-pctammela@mojatatu.com> <CAA93jw6Oh66k+tA3Ad8QFA7-gGnoY_hsk8d2bRDgs_0AjE69Aw@mail.gmail.com>
In-Reply-To: <CAA93jw6Oh66k+tA3Ad8QFA7-gGnoY_hsk8d2bRDgs_0AjE69Aw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Oct 2023 11:59:30 -0400
Message-ID: <CAM0EoMkDJYPhCry=xVNh6=Nbr0iH9jwgD=Btjtt1c1wdJQ6HFw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it
 becomes a inner curve
To: Dave Taht <dave.taht@gmail.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Christian Theune <ct@flyingcircus.io>, Budimir Markovic <markovicbudimir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:48=E2=80=AFAM Dave Taht <dave.taht@gmail.com> wr=
ote:
>
> On occasion I try to get those still using hfsc to give CAKE a shot,
> or give me a benchmark as to why the view hfsc as better. It is a very
> interesting and hard to understand shaping mechanism.

Yes, hfsc is a bit too clever. If you have some results you are more
than welcome to present them at the TC workshop.

cheers,
jamal

> On Tue, Oct 17, 2023 at 7:36=E2=80=AFAM Pedro Tammela <pctammela@mojatatu=
.com> wrote:
> >
> > Christian Theune says:
> >    I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffi=
c shaping script,
> >    leaving me with a non-functional uplink on a remote router.
> >
> > A 'rt' curve cannot be used as a inner curve (parent class), but we wer=
e
> > allowing such configurations since the qdisc was introduced. Such
> > configurations would trigger a UAF as Budimir explains:
> >    The parent will have vttree_insert() called on it in init_vf(),
> >    but will not have vttree_remove() called on it in update_vf()
> >    because it does not have the HFSC_FSC flag set.
> >
> > The qdisc always assumes that inner classes have the HFSC_FSC flag set.
> > This is by design as it doesn't make sense 'qdisc wise' for an 'rt'
> > curve to be an inner curve.
> >
> > Budimir's original patch disallows users to add classes with a 'rt'
> > parent, but this is too strict as it breaks users that have been using
> > 'rt' as a inner class. Another approach, taken by this patch, is to
> > upgrade the inner 'rt' into a 'sc', warning the user in the process.
> > It avoids the UAF reported by Budimir while also being more permissive
> > to bad scripts/users/code using 'rt' as a inner class.
> >
> > Users checking the `tc class ls [...]` or `tc class get [...]` dumps wo=
uld
> > observe the curve change and are potentially breaking with this change.
> >
> > v1->v2: https://lore.kernel.org/all/20231013151057.2611860-1-pctammela@=
mojatatu.com/
> > - Correct 'Fixes' tag and merge with revert (Jakub)
> >
> > Cc: Christian Theune <ct@flyingcircus.io>
> > Cc: Budimir Markovic <markovicbudimir@gmail.com>
> > Fixes: b3d26c5702c7 ("net/sched: sch_hfsc: Ensure inner classes have fs=
c curve")
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > ---
> >  net/sched/sch_hfsc.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> > index 3554085bc2be..880c5f16b29c 100644
> > --- a/net/sched/sch_hfsc.c
> > +++ b/net/sched/sch_hfsc.c
> > @@ -902,6 +902,14 @@ hfsc_change_usc(struct hfsc_class *cl, struct tc_s=
ervice_curve *usc,
> >         cl->cl_flags |=3D HFSC_USC;
> >  }
> >
> > +static void
> > +hfsc_upgrade_rt(struct hfsc_class *cl)
> > +{
> > +       cl->cl_fsc =3D cl->cl_rsc;
> > +       rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total=
);
> > +       cl->cl_flags |=3D HFSC_FSC;
> > +}
> > +
> >  static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] =3D {
> >         [TCA_HFSC_RSC]  =3D { .len =3D sizeof(struct tc_service_curve) =
},
> >         [TCA_HFSC_FSC]  =3D { .len =3D sizeof(struct tc_service_curve) =
},
> > @@ -1011,10 +1019,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid=
, u32 parentid,
> >                 if (parent =3D=3D NULL)
> >                         return -ENOENT;
> >         }
> > -       if (!(parent->cl_flags & HFSC_FSC) && parent !=3D &q->root) {
> > -               NL_SET_ERR_MSG(extack, "Invalid parent - parent class m=
ust have FSC");
> > -               return -EINVAL;
> > -       }
> >
> >         if (classid =3D=3D 0 || TC_H_MAJ(classid ^ sch->handle) !=3D 0)
> >                 return -EINVAL;
> > @@ -1065,6 +1069,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid=
, u32 parentid,
> >         cl->cf_tree =3D RB_ROOT;
> >
> >         sch_tree_lock(sch);
> > +       /* Check if the inner class is a misconfigured 'rt' */
> > +       if (!(parent->cl_flags & HFSC_FSC) && parent !=3D &q->root) {
> > +               NL_SET_ERR_MSG(extack,
> > +                              "Forced curve change on parent 'rt' to '=
sc'");
> > +               hfsc_upgrade_rt(parent);
> > +       }
> >         qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
> >         list_add_tail(&cl->siblings, &parent->children);
> >         if (parent->level =3D=3D 0)
> > --
> > 2.39.2
> >
> >
>
>
> --
> Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.h=
tml
> Dave T=C3=A4ht CSO, LibreQos

