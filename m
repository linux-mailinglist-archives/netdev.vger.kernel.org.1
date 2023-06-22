Return-Path: <netdev+bounces-13174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B473A8A5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FB11C20831
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B949206AC;
	Thu, 22 Jun 2023 18:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB721F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:57:11 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C710F2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:57:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ffd7d7fedso79139937b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1687460228; x=1690052228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbvWQ3oVVmBg4Jc9F4GgvW3+1dPSj8SPi0vOl+Ekl2s=;
        b=F+OcuocKslR9lFX4/fEaymtIEfn+9YT7xAMrHrGjDhYm4fFWgD9dTjk7F4UHcIibQD
         CT45i33a41jWhCHsdHn5Xl/CnbBf458914xX2pG68lV2FDBlpQX4xaAmgc7RPiw3g1is
         /ebglh38ZTrBXZ8U79lhY4Z9Z8SqzJ+O1A/KRiH5uxXxecZqSRc5VRXJ28WtvjqlfoLD
         wmRFr0OZEElnS9SatkdzEZ90tA+ycKSqwFkYBfY0fbOslt+ob23btFsggTDY7XaB56fs
         E44VZP3k+8ZBjnRTG1t+jSKmWGYbcQA2Ac8ukGwAq59fh0oSNGzDIkVfCebNOpm+n/g/
         Jssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460228; x=1690052228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbvWQ3oVVmBg4Jc9F4GgvW3+1dPSj8SPi0vOl+Ekl2s=;
        b=AGMO/UrsoWD/FiCTyOcQSIKHUpY0wy9Nq4+PNv2R5IcAd2SwPGC3A0EU4iQJvM15B2
         Jlj+NLVGsiDIBHSEFQqWPKxmI0cm1IVVcFr/Slu3wcDnzOh6bRCu/bRHLT9nbn7Pz0Ff
         qos83qGBypYhyOOHdwm8HJdDVfJRWJb1fvav6SjwbNvhpaexG6pDDkrfapivbqLxCpAl
         sfJwLrStaMJcXl/UThuJ06rPOjDpBan4G1PvJppRs5/boD37V5ESCcOGA64tptiiNQxD
         RvAA+US+4nGHOkzShgiiqDRBzC2MMIuJM71NAeXNOnHZU+NW61prHuHGQTBEzcpLF31j
         px5A==
X-Gm-Message-State: AC+VfDzCJh+/MxY2W//PQMZf2TjOcn7cWg8Wc8gDk50eUhyqtSp/Ix1/
	HBKGdbtkURx+qYZMjiug62kGOyyH+KUnP4LDsQPyIg==
X-Google-Smtp-Source: ACHHUZ5at3tSbad/YFpz9VeEdB9zpwBon7aWOANrt58+KQ5ijmLFlmetBuhaUr6k0bQHTkAcY0FRc6+B9LUYFxJKSRk=
X-Received: by 2002:a0d:cb88:0:b0:570:7bb3:77e with SMTP id
 n130-20020a0dcb88000000b005707bb3077emr17285624ywd.33.1687460227860; Thu, 22
 Jun 2023 11:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622181503.2327695-1-edumazet@google.com>
In-Reply-To: <20230622181503.2327695-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Jun 2023 14:56:56 -0400
Message-ID: <CAM0EoM=uBjgBYdF7rPhk--L2n+_6858cNu8SON2_ZDRUSsOn6A@mail.gmail.com>
Subject: Re: [PATCH net] sch_netem: fix issues in netem_change() vs get_dist_table()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 2:15=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In blamed commit, I missed that get_dist_table() was allocating
> memory using GFP_KERNEL, and acquiring qdisc lock to perform
> the swap of newly allocated table with current one.
>
> In this patch, get_dist_table() is allocating memory and
> copy user data before we acquire the qdisc lock.
>
> Then we perform swap operations while being protected by the lock.
>
> Note that after this patch netem_change() no longer can do partial change=
s.
> If an error is returned, qdisc conf is left unchanged.
>
> Fixes: 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Simon Horman <simon.horman@corigine.com>

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/sch_netem.c | 59 ++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index e79be1b3e74da3c154f7ee23e16cc9e8da8f7106..b93ec2a3454ebceea559299f9=
0533cbf1c0f7c26 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -773,12 +773,10 @@ static void dist_free(struct disttable *d)
>   * signed 16 bit values.
>   */
>
> -static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
> -                         const struct nlattr *attr)
> +static int get_dist_table(struct disttable **tbl, const struct nlattr *a=
ttr)
>  {
>         size_t n =3D nla_len(attr)/sizeof(__s16);
>         const __s16 *data =3D nla_data(attr);
> -       spinlock_t *root_lock;
>         struct disttable *d;
>         int i;
>
> @@ -793,13 +791,7 @@ static int get_dist_table(struct Qdisc *sch, struct =
disttable **tbl,
>         for (i =3D 0; i < n; i++)
>                 d->table[i] =3D data[i];
>
> -       root_lock =3D qdisc_root_sleeping_lock(sch);
> -
> -       spin_lock_bh(root_lock);
> -       swap(*tbl, d);
> -       spin_unlock_bh(root_lock);
> -
> -       dist_free(d);
> +       *tbl =3D d;
>         return 0;
>  }
>
> @@ -956,6 +948,8 @@ static int netem_change(struct Qdisc *sch, struct nla=
ttr *opt,
>  {
>         struct netem_sched_data *q =3D qdisc_priv(sch);
>         struct nlattr *tb[TCA_NETEM_MAX + 1];
> +       struct disttable *delay_dist =3D NULL;
> +       struct disttable *slot_dist =3D NULL;
>         struct tc_netem_qopt *qopt;
>         struct clgstate old_clg;
>         int old_loss_model =3D CLG_RANDOM;
> @@ -966,6 +960,18 @@ static int netem_change(struct Qdisc *sch, struct nl=
attr *opt,
>         if (ret < 0)
>                 return ret;
>
> +       if (tb[TCA_NETEM_DELAY_DIST]) {
> +               ret =3D get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DI=
ST]);
> +               if (ret)
> +                       goto table_free;
> +       }
> +
> +       if (tb[TCA_NETEM_SLOT_DIST]) {
> +               ret =3D get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST=
]);
> +               if (ret)
> +                       goto table_free;
> +       }
> +
>         sch_tree_lock(sch);
>         /* backup q->clg and q->loss_model */
>         old_clg =3D q->clg;
> @@ -975,26 +981,17 @@ static int netem_change(struct Qdisc *sch, struct n=
lattr *opt,
>                 ret =3D get_loss_clg(q, tb[TCA_NETEM_LOSS]);
>                 if (ret) {
>                         q->loss_model =3D old_loss_model;
> +                       q->clg =3D old_clg;
>                         goto unlock;
>                 }
>         } else {
>                 q->loss_model =3D CLG_RANDOM;
>         }
>
> -       if (tb[TCA_NETEM_DELAY_DIST]) {
> -               ret =3D get_dist_table(sch, &q->delay_dist,
> -                                    tb[TCA_NETEM_DELAY_DIST]);
> -               if (ret)
> -                       goto get_table_failure;
> -       }
> -
> -       if (tb[TCA_NETEM_SLOT_DIST]) {
> -               ret =3D get_dist_table(sch, &q->slot_dist,
> -                                    tb[TCA_NETEM_SLOT_DIST]);
> -               if (ret)
> -                       goto get_table_failure;
> -       }
> -
> +       if (delay_dist)
> +               swap(q->delay_dist, delay_dist);
> +       if (slot_dist)
> +               swap(q->slot_dist, slot_dist);
>         sch->limit =3D qopt->limit;
>
>         q->latency =3D PSCHED_TICKS2NS(qopt->latency);
> @@ -1044,17 +1041,11 @@ static int netem_change(struct Qdisc *sch, struct=
 nlattr *opt,
>
>  unlock:
>         sch_tree_unlock(sch);
> -       return ret;
>
> -get_table_failure:
> -       /* recover clg and loss_model, in case of
> -        * q->clg and q->loss_model were modified
> -        * in get_loss_clg()
> -        */
> -       q->clg =3D old_clg;
> -       q->loss_model =3D old_loss_model;
> -
> -       goto unlock;
> +table_free:
> +       dist_free(delay_dist);
> +       dist_free(slot_dist);
> +       return ret;
>  }
>
>  static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> --
> 2.41.0.178.g377b9f9a00-goog
>

