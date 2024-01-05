Return-Path: <netdev+bounces-61748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36306824C8F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EC81C219E5
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF102185B;
	Fri,  5 Jan 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Un+TbI09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5961FA3
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbdb12203b4so967918276.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704418111; x=1705022911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Oaicc38XObNOG7EU4LA3z/mlxskXCkzh7KAcTLpJ4s=;
        b=Un+TbI09G22nFwAvTt1YcLxAj/xdR4BVTxl3KXKisd8V1kU7xuM+EMGv8Bi3BWZw7I
         9hle8cGYGxkWxRmwfwNidSqeHHnkVcSe3660O2AlVTOt3XXyRMP+wBCr7fK2hMJ/p1bB
         235xVNOJiiUn/nNnd5v01x+/JvRktk/QX6PdA+crpX3bBb6NerYHpb2qM1m7WMl3kPlD
         PbpEtov+jVk/ZPzUXDnAA7xh2IxQpfc7UBRHPd/ipXG2W6bM1cJd2Zr7YjziqndNQ3TJ
         pwbrog2s9CYCBnecUxxO1plue4FBrHfZJcQp555RN0l7gIL5GP5n1la+8ozYvWf8pwXw
         BaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704418111; x=1705022911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Oaicc38XObNOG7EU4LA3z/mlxskXCkzh7KAcTLpJ4s=;
        b=mnnDme+hXvaxuvtvzYGMx/Ob3tZYsU0w3gtsgm8i8lqi09ubmu6/iSsIqH4TVHfGaO
         c3nXNAjkdk6EuKWTj6tIRFXdaeFWjgKx9Dro2nhtBqfo+xDVAD0Aq7ALB433eVt/V4RN
         uoJ5a+TyvjjIgfhVb2HYlyPZkjSgzd7yURiuE1ZSpho2nuoMNVqjOJW9RUQ4n/6OVHR8
         jHf4VJCeIyHcPewCn9uh0cBgtuaMeJQBHpDtW42L4UTQT2pmgg8Tk/FjzcXHEFqg9IrE
         +Ba/TezPgu+ah8kalsmiUIsBfiYHx74dd7xd9+k7YAL17xsi91LyI/d+CaTvxXQCeAE9
         EcIA==
X-Gm-Message-State: AOJu0YxoFx96llKFlxyRgNco0qh/6oGNqCC+6qh0vB1Lgx42Kg0PkqDP
	mWsWOvF1OWJiKX8tV9xZLM5g1W+MtzXnyyGwqKldA3nO4W0j
X-Google-Smtp-Source: AGHT+IF2kNnGP1Kmpy4Nzc+bksPdIawu7dJpgOxNLYjv/qeCF9X0Bjy/MTwhIKNvdFtJHqbC6ZmaIJWhIFN2SWgVzSs=
X-Received: by 2002:a5b:ca:0:b0:dbe:a081:97b9 with SMTP id d10-20020a5b00ca000000b00dbea08197b9mr1302111ybp.101.1704418110903;
 Thu, 04 Jan 2024 17:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105003810.2056224-1-pctammela@mojatatu.com>
In-Reply-To: <20240105003810.2056224-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jan 2024 20:28:19 -0500
Message-ID: <CAM0EoMnV7-FEA0QfLrtBG8k__LoOV8_cJR=XwpE-VQXEcKSF5A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: simplify tc_action_load_ops parameters
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 7:38=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.co=
m> wrote:
>
> Instead of using two bools derived from a flags passed as arguments to
> the parent function of tc_action_load_ops, just pass the flags itself
> to tc_action_load_ops to simplify its parameters.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  include/net/act_api.h |  3 +--
>  net/sched/act_api.c   | 10 +++++-----
>  net/sched/cls_api.c   |  5 ++---
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 447985a45ef6..e1e5e72b901e 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -208,8 +208,7 @@ int tcf_action_init(struct net *net, struct tcf_proto=
 *tp, struct nlattr *nla,
>                     struct nlattr *est,
>                     struct tc_action *actions[], int init_res[], size_t *=
attr_size,
>                     u32 flags, u32 fl_flags, struct netlink_ext_ack *exta=
ck);
> -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police=
,
> -                                        bool rtnl_held,
> +struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
>                                          struct netlink_ext_ack *extack);
>  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *t=
p,
>                                     struct nlattr *nla, struct nlattr *es=
t,
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index ef70d4771811..3e30d7260493 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1324,10 +1324,10 @@ void tcf_idr_insert_many(struct tc_action *action=
s[], int init_res[])
>         }
>  }
>
> -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police=
,
> -                                        bool rtnl_held,
> +struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
>                                          struct netlink_ext_ack *extack)
>  {
> +       bool police =3D flags & TCA_ACT_FLAGS_POLICE;
>         struct nlattr *tb[TCA_ACT_MAX + 1];
>         struct tc_action_ops *a_o;
>         char act_name[IFNAMSIZ];
> @@ -1359,6 +1359,8 @@ struct tc_action_ops *tc_action_load_ops(struct nla=
ttr *nla, bool police,
>         a_o =3D tc_lookup_action_n(act_name);
>         if (a_o =3D=3D NULL) {
>  #ifdef CONFIG_MODULES
> +               bool rtnl_held =3D !(flags & TCA_ACT_FLAGS_NO_RTNL);
> +
>                 if (rtnl_held)
>                         rtnl_unlock();
>                 request_module("act_%s", act_name);
> @@ -1475,9 +1477,7 @@ int tcf_action_init(struct net *net, struct tcf_pro=
to *tp, struct nlattr *nla,
>         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
>                 struct tc_action_ops *a_o;
>
> -               a_o =3D tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_P=
OLICE,
> -                                        !(flags & TCA_ACT_FLAGS_NO_RTNL)=
,
> -                                        extack);
> +               a_o =3D tc_action_load_ops(tb[i], flags, extack);
>                 if (IS_ERR(a_o)) {
>                         err =3D PTR_ERR(a_o);
>                         goto err_mod;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index adf5de1ff773..4b8ff5b4eb18 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3300,12 +3300,11 @@ int tcf_exts_validate_ex(struct net *net, struct =
tcf_proto *tp, struct nlattr **
>                 if (exts->police && tb[exts->police]) {
>                         struct tc_action_ops *a_o;
>
> -                       a_o =3D tc_action_load_ops(tb[exts->police], true=
,
> -                                                !(flags & TCA_ACT_FLAGS_=
NO_RTNL),
> +                       flags |=3D TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_B=
IND;
> +                       a_o =3D tc_action_load_ops(tb[exts->police], flag=
s,
>                                                  extack);
>                         if (IS_ERR(a_o))
>                                 return PTR_ERR(a_o);
> -                       flags |=3D TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_B=
IND;
>                         act =3D tcf_action_init_1(net, tp, tb[exts->polic=
e],
>                                                 rate_tlv, a_o, init_res, =
flags,
>                                                 extack);
> --
> 2.40.1
>

