Return-Path: <netdev+bounces-41973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0F7CC79F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D34281B3E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA2450E8;
	Tue, 17 Oct 2023 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IDRK+5IV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74A450D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:40:32 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36801B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:40:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so5699647276.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697557229; x=1698162029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWlMX33FalL5hC2vTqTBeU8TrOfP5yKdb1bOgLBpHLM=;
        b=IDRK+5IVLpSIdU80BHpPAlKIF3HM1tWyzoDPI8kdmkcJu35TLKNPnaDxb8xxxo+SYW
         hBAG4IXjhdjTOG1shZhH1V48RF5pGweJ6xg9JEPBGv9eldT3toeGFZhtJTqplEtiqi76
         eDmGmSuzaNcafpgUmOn6Obhs46OCQI3DIULjWVrFAVyIBo/jp7iXS9m1LjXr6xkeyY6G
         zHm7k3oygWE875IJ3QAKoq4nOEReSwZy86yxDVZQ1ee5/Koret8685g2dUufvB3DOlXF
         /LX+7iQfeA6iCfv2EqBbVmaCHktoUHCBLA2GxrHPthxJoRUg/80qoFWYGoCtakT03g9N
         mb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557229; x=1698162029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWlMX33FalL5hC2vTqTBeU8TrOfP5yKdb1bOgLBpHLM=;
        b=lxKs48pFn8Ai1kmsDbPhVyZ5KneChun+fHR1mpBqZmsxtxvCDkwk8dV+YNnqwVn4lL
         KOxuUPy+ypkLWldrhyWdTQKRly8u6RYYmoY8GLhhyA317Hr8cSzKS3zUJ2QnD81mCPUq
         751kR3X8oWBPEsfCWTkOc3Eoaec3sA9UAg7t/FCV0w0iuLP5dzr10jGfAVwFAFXNPmMd
         vdOTCtQIXGElipMJOjfz5YeQzLtB9LygZ4nFlckzfegIy3Kx2VigbTK/3khvamQiM573
         DLQn93Elu8++HWOwwhhTzHFu432KAn/tPu4w2bzp6DBc4iPyW0X4zsaJy7F3AAxyVniv
         GRBw==
X-Gm-Message-State: AOJu0YzK2IAeUK56gUoInSAaNIzPSS458JnqZN2XRfhGFUFHlwlGm540
	jQt6PBkdQU+X01HQXfXiHbAgyTpqOTbIgAoJ1yRcwQ==
X-Google-Smtp-Source: AGHT+IHnUgut4D4oUnQUU/cAVpbd3OLJz39gIM2y/bC6B7YomxYLEP6Wqi1U6nTPNIAhn5CwKFIIEb6oi6tM8EQtFt0=
X-Received: by 2002:a25:e695:0:b0:d9a:4ae7:bd68 with SMTP id
 d143-20020a25e695000000b00d9a4ae7bd68mr2487832ybh.21.1697557229280; Tue, 17
 Oct 2023 08:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017143602.3191556-1-pctammela@mojatatu.com>
In-Reply-To: <20231017143602.3191556-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Oct 2023 11:40:17 -0400
Message-ID: <CAM0EoM=R6aaFT+1wsdfWr48cZ9r=if1LAKACZQH6MLyf5zUTuw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it
 becomes a inner curve
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Christian Theune <ct@flyingcircus.io>, Budimir Markovic <markovicbudimir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:36=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
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

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

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

