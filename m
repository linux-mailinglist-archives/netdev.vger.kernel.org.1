Return-Path: <netdev+bounces-41975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC47CC7E5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BE9281AA9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0408450EF;
	Tue, 17 Oct 2023 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQXAeThK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF643AB3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:48:29 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F71ED
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:48:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso1986726b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697557707; x=1698162507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB3spnyuB25Rr1PFbpwdBvPYM2lvxJ9yOzC5WVfNFn8=;
        b=gQXAeThKZX1iTihSU/zOuvlUyIvErfslWeqEBiVzM9FYwF08Dn+2l9oOA5Hi8iT62i
         lisEy/mld6WmQ8KGkcV3S2ieroGM4ouZJ3MCfiR1weU15hYe5x9yKAbRA8QzE3qUhsa8
         ZSANTURpea8QMSDyDIwbcNQTVjcsP8OqGIETWWKX1EQ7CCrFlCWUCaFiF3wOO7O3xzma
         h5xCAEeK+cnA3p//xKVPz2kBUBd4KsYYpBmHOQvIPiaTyAz14AuTXT3ULGLjwhwQx/g0
         05gJhtrqeebd/jR3EE+ob5pHOpAvisAAjocOkYUjg6XhQ7iBeUfZ29Hvfzx/xbU5+VWh
         eH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557707; x=1698162507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB3spnyuB25Rr1PFbpwdBvPYM2lvxJ9yOzC5WVfNFn8=;
        b=RKVC4+6oJCqsJtwdMvFpa9PjWTP4G8nfuXVvQmRVIQkf4NAJ7ucNhoCS7iMv7bOhEQ
         LLipeKTFRU4aGTN9MlPxek+VjdETbGXRvZGE+IyZRYuLKJmJgBev9OQiTnXwWtGAvgj3
         ZoTvf8aUAWxGegclof3qRK2PVUwGMpWkIpz5bgtzTb27kemfCAG5Mk/xpjhYFwVd7ETh
         kzWpysO4pHSSVDhxWFat5u1yDTkE6cQqISTP9Fjibi5S6vKkeReAKQ+ZX7X9TknYg94j
         9Wli/8USbg5y9Qcd6760cXj7smqQGb//u7oRwWmpyIbDE4hQaC3Brx+2V/8sWUndopL1
         Ntvw==
X-Gm-Message-State: AOJu0Yzsmq55cX14WqJRYNV0w5y95jPTI5d6KDzUXO23W4rzULTSMbNu
	llOKBzxcc42pyNLogP4ayPJMl4z6/0GpUO0udgo=
X-Google-Smtp-Source: AGHT+IG45U5G/eVia5EBy/N70CyFS40TfPI+iJfcQLu1/zU0occ8ti+Y+vsGKs0oKDvLLouRxgGd57suh2Gkwc3iVSs=
X-Received: by 2002:a05:6a00:13a3:b0:68e:42c9:74e0 with SMTP id
 t35-20020a056a0013a300b0068e42c974e0mr2927081pfg.3.1697557706985; Tue, 17 Oct
 2023 08:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017143602.3191556-1-pctammela@mojatatu.com>
In-Reply-To: <20231017143602.3191556-1-pctammela@mojatatu.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 17 Oct 2023 08:48:12 -0700
Message-ID: <CAA93jw6Oh66k+tA3Ad8QFA7-gGnoY_hsk8d2bRDgs_0AjE69Aw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it
 becomes a inner curve
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Christian Theune <ct@flyingcircus.io>, 
	Budimir Markovic <markovicbudimir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On occasion I try to get those still using hfsc to give CAKE a shot,
or give me a benchmark as to why the view hfsc as better. It is a very
interesting and hard to understand shaping mechanism.

On Tue, Oct 17, 2023 at 7:36=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Christian Theune says:
>    I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic =
shaping script,
>    leaving me with a non-functional uplink on a remote router.
>
> A 'rt' curve cannot be used as a inner curve (parent class), but we were
> allowing such configurations since the qdisc was introduced. Such
> configurations would trigger a UAF as Budimir explains:
>    The parent will have vttree_insert() called on it in init_vf(),
>    but will not have vttree_remove() called on it in update_vf()
>    because it does not have the HFSC_FSC flag set.
>
> The qdisc always assumes that inner classes have the HFSC_FSC flag set.
> This is by design as it doesn't make sense 'qdisc wise' for an 'rt'
> curve to be an inner curve.
>
> Budimir's original patch disallows users to add classes with a 'rt'
> parent, but this is too strict as it breaks users that have been using
> 'rt' as a inner class. Another approach, taken by this patch, is to
> upgrade the inner 'rt' into a 'sc', warning the user in the process.
> It avoids the UAF reported by Budimir while also being more permissive
> to bad scripts/users/code using 'rt' as a inner class.
>
> Users checking the `tc class ls [...]` or `tc class get [...]` dumps woul=
d
> observe the curve change and are potentially breaking with this change.
>
> v1->v2: https://lore.kernel.org/all/20231013151057.2611860-1-pctammela@mo=
jatatu.com/
> - Correct 'Fixes' tag and merge with revert (Jakub)
>
> Cc: Christian Theune <ct@flyingcircus.io>
> Cc: Budimir Markovic <markovicbudimir@gmail.com>
> Fixes: b3d26c5702c7 ("net/sched: sch_hfsc: Ensure inner classes have fsc =
curve")
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/sch_hfsc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 3554085bc2be..880c5f16b29c 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -902,6 +902,14 @@ hfsc_change_usc(struct hfsc_class *cl, struct tc_ser=
vice_curve *usc,
>         cl->cl_flags |=3D HFSC_USC;
>  }
>
> +static void
> +hfsc_upgrade_rt(struct hfsc_class *cl)
> +{
> +       cl->cl_fsc =3D cl->cl_rsc;
> +       rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
> +       cl->cl_flags |=3D HFSC_FSC;
> +}
> +
>  static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] =3D {
>         [TCA_HFSC_RSC]  =3D { .len =3D sizeof(struct tc_service_curve) },
>         [TCA_HFSC_FSC]  =3D { .len =3D sizeof(struct tc_service_curve) },
> @@ -1011,10 +1019,6 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, =
u32 parentid,
>                 if (parent =3D=3D NULL)
>                         return -ENOENT;
>         }
> -       if (!(parent->cl_flags & HFSC_FSC) && parent !=3D &q->root) {
> -               NL_SET_ERR_MSG(extack, "Invalid parent - parent class mus=
t have FSC");
> -               return -EINVAL;
> -       }
>
>         if (classid =3D=3D 0 || TC_H_MAJ(classid ^ sch->handle) !=3D 0)
>                 return -EINVAL;
> @@ -1065,6 +1069,12 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, =
u32 parentid,
>         cl->cf_tree =3D RB_ROOT;
>
>         sch_tree_lock(sch);
> +       /* Check if the inner class is a misconfigured 'rt' */
> +       if (!(parent->cl_flags & HFSC_FSC) && parent !=3D &q->root) {
> +               NL_SET_ERR_MSG(extack,
> +                              "Forced curve change on parent 'rt' to 'sc=
'");
> +               hfsc_upgrade_rt(parent);
> +       }
>         qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
>         list_add_tail(&cl->siblings, &parent->children);
>         if (parent->level =3D=3D 0)
> --
> 2.39.2
>
>


--=20
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos

