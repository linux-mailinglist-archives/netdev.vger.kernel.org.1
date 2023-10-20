Return-Path: <netdev+bounces-43059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE77D137F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CC31C2102D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A81E52A;
	Fri, 20 Oct 2023 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ffMfGSDE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77761E506
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:03:41 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D7D8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:03:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7ac4c3666so10671417b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697817818; x=1698422618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oNX1Ea0thZprx26yEb4CusWjD9RdzHGy8cLd4HisOU=;
        b=ffMfGSDEe0sAQ9mF+RL2/Y95Wlb/ZQ6L5q2dDC8MEXybHk4ySJ9pY5Gd4od0ZY9Cfy
         JHQUtzReDHYPXJGwi+T+PIvJIZR8YCDQhOrHb1IT5L93lwrzbdgOfQhysUVAsM/nwn0Z
         RUOww35iH9RigQsau3kyaZHgDepfCpOcEm6LWKfrW6/OHk7SNOQBbsIdYNyEKK8HFjfE
         wKUkpXOIOTYvtB2Lrvgt+gYrINik6wESep/+x5GMpyg+8L6P+4hyxgeB4HjQJfhZIz7+
         nltXpV5cO2sB2chvRhSn3oW6EJlj3rPCNFKwf/L8GfPZ7SSTqT0gw5y4vr9W1QZ+K428
         2bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697817818; x=1698422618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oNX1Ea0thZprx26yEb4CusWjD9RdzHGy8cLd4HisOU=;
        b=n4vwKIlWKyHPGbTu0xHO7LwBH2LkUSZ7BjtQAGJ2PgRkjlrLh+QWvRnESZLM7I/yCy
         YmSXhRHvU3AqfP/A4Kgyz7QmcbLp09DczsINRDoChlfnQQARVNzsNytErW7wnlaLJaMU
         5NiitTCrVKLnJQ7neUhFQlwtTKmUxDpfAFCmEVofu3MBf7T59Bi1HvNTVOafaAUg3oxX
         lE3Qgn0S0IdnR/CKXUEixO4nw2am8JGb2tSo10J0DL3f0Ppd8WqjpVaRmLrefufvQU0Y
         jgNd8uPmYVe4iyrhGQV2OywFjhuVghmss+tP2nCjWPJaKyYu/mHp12LSMyULb0U2IQVg
         gR7g==
X-Gm-Message-State: AOJu0Yxr/2/lTfn522ZxtqTOCvoJ3OVNJGGCD8uszQVYgiWIdW/ceE0P
	xuZdd5bguYg8zsaqX8ieeHEbGFG6kSNIIKYTXJpIyw==
X-Google-Smtp-Source: AGHT+IHutmSwiGiPoTJCRygfrjLh337oHS2Osr8FJNG2SNGv6MON4IPWW/bHak1yRB6gkI87r0Zcy2VFQq8+C4tiUw8=
X-Received: by 2002:a0d:d98f:0:b0:5a1:d352:9fe1 with SMTP id
 b137-20020a0dd98f000000b005a1d3529fe1mr2521669ywe.42.1697817818594; Fri, 20
 Oct 2023 09:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020124551.10764-1-fw@strlen.de>
In-Reply-To: <20231020124551.10764-1-fw@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 20 Oct 2023 12:03:27 -0400
Message-ID: <CAM0EoMm=5=P4COYNoK8q8oE1rpjqOQ+HivjCCC7qywxHdmiSYA@mail.gmail.com>
Subject: Re: [PATCH net-next] sched: act_ct: switch to per-action label counting
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:46=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> net->ct.labels_used was meant to convey 'number of ip/nftables rules
> that need the label extension allocated'.
>
> act_ct enables this for each net namespace, which voids all attempts
> to avoid ct->ext allocation when possible.
>
> Move this increment to the control plane to request label extension
> space allocation only when its needed.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  "tdc.py -c ct" still passes with this applied.

Thanks for running those tests Florian!

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

>  include/net/tc_act/tc_ct.h |  1 +
>  net/sched/act_ct.c         | 41 +++++++++++++++++---------------------
>  2 files changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> index b24ea2d9400b..8a6dbfb23336 100644
> --- a/include/net/tc_act/tc_ct.h
> +++ b/include/net/tc_act/tc_ct.h
> @@ -22,6 +22,7 @@ struct tcf_ct_params {
>
>         struct nf_nat_range2 range;
>         bool ipv4_range;
> +       bool put_labels;
>
>         u16 ct_action;
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 7c652d14528b..9422686f73b0 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -690,7 +690,6 @@ static struct tc_action_ops act_ct_ops;
>
>  struct tc_ct_action_net {
>         struct tc_action_net tn; /* Must be first */
> -       bool labels;
>  };
>
>  /* Determine whether skb->_nfct is equal to the result of conntrack look=
up. */
> @@ -829,8 +828,13 @@ static void tcf_ct_params_free(struct tcf_ct_params =
*params)
>         }
>         if (params->ct_ft)
>                 tcf_ct_flow_table_put(params->ct_ft);
> -       if (params->tmpl)
> +       if (params->tmpl) {
> +               if (params->put_labels)
> +                       nf_connlabels_put(nf_ct_net(params->tmpl));
> +
>                 nf_ct_put(params->tmpl);
> +       }
> +
>         kfree(params);
>  }
>
> @@ -1154,10 +1158,10 @@ static int tcf_ct_fill_params(struct net *net,
>                               struct nlattr **tb,
>                               struct netlink_ext_ack *extack)
>  {
> -       struct tc_ct_action_net *tn =3D net_generic(net, act_ct_ops.net_i=
d);
>         struct nf_conntrack_zone zone;
>         int err, family, proto, len;
>         struct nf_conn *tmpl;
> +       bool put_labels =3D false;
>         char *name;
>
>         p->zone =3D NF_CT_DEFAULT_ZONE_ID;
> @@ -1186,15 +1190,20 @@ static int tcf_ct_fill_params(struct net *net,
>         }
>
>         if (tb[TCA_CT_LABELS]) {
> +               unsigned int n_bits =3D sizeof_field(struct tcf_ct_params=
, labels) * 8;
> +
>                 if (!IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)) {
>                         NL_SET_ERR_MSG_MOD(extack, "Conntrack labels isn'=
t enabled.");
>                         return -EOPNOTSUPP;
>                 }
>
> -               if (!tn->labels) {
> +               if (nf_connlabels_get(net, n_bits - 1)) {
>                         NL_SET_ERR_MSG_MOD(extack, "Failed to set connlab=
el length");
>                         return -EOPNOTSUPP;
> +               } else {
> +                       put_labels =3D true;
>                 }
> +
>                 tcf_ct_set_key_val(tb,
>                                    p->labels, TCA_CT_LABELS,
>                                    p->labels_mask, TCA_CT_LABELS_MASK,
> @@ -1238,10 +1247,15 @@ static int tcf_ct_fill_params(struct net *net,
>                 }
>         }
>
> +       p->put_labels =3D put_labels;
> +
>         if (p->ct_action & TCA_CT_ACT_COMMIT)
>                 __set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
>         return 0;
>  err:
> +       if (put_labels)
> +               nf_connlabels_put(net);
> +
>         nf_ct_put(p->tmpl);
>         p->tmpl =3D NULL;
>         return err;
> @@ -1542,32 +1556,13 @@ static struct tc_action_ops act_ct_ops =3D {
>
>  static __net_init int ct_init_net(struct net *net)
>  {
> -       unsigned int n_bits =3D sizeof_field(struct tcf_ct_params, labels=
) * 8;
>         struct tc_ct_action_net *tn =3D net_generic(net, act_ct_ops.net_i=
d);
>
> -       if (nf_connlabels_get(net, n_bits - 1)) {
> -               tn->labels =3D false;
> -               pr_err("act_ct: Failed to set connlabels length");
> -       } else {
> -               tn->labels =3D true;
> -       }
> -
>         return tc_action_net_init(net, &tn->tn, &act_ct_ops);
>  }
>
>  static void __net_exit ct_exit_net(struct list_head *net_list)
>  {
> -       struct net *net;
> -
> -       rtnl_lock();
> -       list_for_each_entry(net, net_list, exit_list) {
> -               struct tc_ct_action_net *tn =3D net_generic(net, act_ct_o=
ps.net_id);
> -
> -               if (tn->labels)
> -                       nf_connlabels_put(net);
> -       }
> -       rtnl_unlock();
> -
>         tc_action_net_exit(net_list, act_ct_ops.net_id);
>  }
>
> --
> 2.41.0
>

