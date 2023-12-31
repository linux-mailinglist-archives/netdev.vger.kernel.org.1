Return-Path: <netdev+bounces-60671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83942820CA1
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F811F21A6C
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2465B64C;
	Sun, 31 Dec 2023 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EhDbum30"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B9B65C
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so2336757276.0
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704049320; x=1704654120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlxFCLwXfW7moMuBw1zEKg8lQ+kWu+GGdaARXpqUCSQ=;
        b=EhDbum306iXCU4dw+GQ+v34Dckm/uosxNymit7ER/B/v9hfEDhaf/Y2aNhEjxcsckK
         b04wFc/98w3TGWX8yYiZcVOscbMtxT5iBjBEIurL6zWddTpDLANQccLCKCMC9kl2x/L/
         n/k5fGUJxFfNAvLxL9s2J+T7WKxXik4qYi7O9C7O6RZXjAYLCKgLA07R98t/Yqkm2h6G
         LKZuB5s6gHs1dykpKtqAHcGxykwZDGwtoufRbuYARD3+QJhpSPcQFwh59Y4x5kfRenc8
         cy9fAYOLQ78pQDmJ6nljMVqH1k1c8OouO9foDr4aqRlt2HMWDbxIdy6HhIxLOFApgzGP
         xUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704049320; x=1704654120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlxFCLwXfW7moMuBw1zEKg8lQ+kWu+GGdaARXpqUCSQ=;
        b=xNUdnRvrCj2k2R6OYyErtdZ5h/0+o8Kd9z5vPw9zjEoZeqMVaSmdggjaOCFhDQJIGV
         2xar8pRTurWxriqSYlfnkXRGA44wJFyoEe7Ye1BPlxMzS3N3CaID9ae8GuTNsVsrSS4O
         us3h1sv1L6kPQ3k9yWQlZNpiwIPZj11B1dNtDMYeL5b8DuN/4vxqcKrlF/kXUK5OJiWm
         thLZT3waILQSepaHQrsrkmESOHJfVc4jv8tLEvJtxTWlw/vc2nj7eVGs9ay66Ddvo82a
         YfbI4qTi91vkjPeZKch9ziAxhgEcJjrA0BnkUMYNGRCQtOxPPiB2WwQhN8yGJB5Vo86j
         lHiw==
X-Gm-Message-State: AOJu0Yx63FZuCbfoG3wlDaUrGaYrFOirHnCtra0BNnj7PX5/cf2Y3NC9
	6LMRqvR8yO+pgN2Yk9UBojrrSRRMSevv/L4kgiojYznB5ZR8+FEH+KXfCbs=
X-Google-Smtp-Source: AGHT+IG2QjTmZr7O+LNjD5jUwus6WJV/D7FCTA0SgZAjzg7wd8lcpiAVyxf0K+CQCH0MEsjlWHkjwkyHukegHQ8sFFY=
X-Received: by 2002:a5b:d48:0:b0:dbd:be6a:e5eb with SMTP id
 f8-20020a5b0d48000000b00dbdbe6ae5ebmr7020804ybr.118.1704049319830; Sun, 31
 Dec 2023 11:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229132642.1489088-1-pctammela@mojatatu.com> <20231229132642.1489088-2-pctammela@mojatatu.com>
In-Reply-To: <20231229132642.1489088-2-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 Dec 2023 14:01:48 -0500
Message-ID: <CAM0EoMmRj9NmztK1fTRrEm05M0hGP_0FpWjeQsKt7CCM2kHZQA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: sch_api: conditional netlink notifications
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 8:27=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Implement conditional netlink notifications for Qdiscs and classes,
> which were missing in the initial patches that targeted tc filters and
> actions. Notifications will only be built after passing a check for
> 'rtnl_notify_needed()'.
>
> For both Qdiscs and classes 'get' operations now call a dedicated
> notification function as it was not possible to distinguish between
> 'create' and 'get' before. This distinction is necessary because 'get'
> always send a notification.
>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_api.c | 79 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 299086bb6205..2a2a48838eb9 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1003,6 +1003,32 @@ static bool tc_qdisc_dump_ignore(struct Qdisc *q, =
bool dump_invisible)
>         return false;
>  }
>
> +static int qdisc_get_notify(struct net *net, struct sk_buff *oskb,
> +                           struct nlmsghdr *n, u32 clid, struct Qdisc *q=
,
> +                           struct netlink_ext_ack *extack)
> +{
> +       struct sk_buff *skb;
> +       u32 portid =3D oskb ? NETLINK_CB(oskb).portid : 0;
> +
> +       skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> +       if (!skb)
> +               return -ENOBUFS;
> +
> +       if (!tc_qdisc_dump_ignore(q, false)) {
> +               if (tc_fill_qdisc(skb, q, clid, portid, n->nlmsg_seq, 0,
> +                                 RTM_NEWQDISC, extack) < 0)
> +                       goto err_out;
> +       }
> +
> +       if (skb->len)
> +               return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
> +                                     n->nlmsg_flags & NLM_F_ECHO);
> +
> +err_out:
> +       kfree_skb(skb);
> +       return -EINVAL;
> +}
> +
>  static int qdisc_notify(struct net *net, struct sk_buff *oskb,
>                         struct nlmsghdr *n, u32 clid,
>                         struct Qdisc *old, struct Qdisc *new,
> @@ -1011,6 +1037,9 @@ static int qdisc_notify(struct net *net, struct sk_=
buff *oskb,
>         struct sk_buff *skb;
>         u32 portid =3D oskb ? NETLINK_CB(oskb).portid : 0;
>
> +       if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
> +               return 0;
> +
>         skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>         if (!skb)
>                 return -ENOBUFS;
> @@ -1583,7 +1612,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct=
 nlmsghdr *n,
>                 if (err !=3D 0)
>                         return err;
>         } else {
> -               qdisc_notify(net, skb, n, clid, NULL, q, NULL);
> +               qdisc_get_notify(net, skb, n, clid, q, NULL);
>         }
>         return 0;
>  }
> @@ -1977,6 +2006,9 @@ static int tclass_notify(struct net *net, struct sk=
_buff *oskb,
>         struct sk_buff *skb;
>         u32 portid =3D oskb ? NETLINK_CB(oskb).portid : 0;
>
> +       if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
> +               return 0;
> +
>         skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>         if (!skb)
>                 return -ENOBUFS;
> @@ -1990,6 +2022,27 @@ static int tclass_notify(struct net *net, struct s=
k_buff *oskb,
>                               n->nlmsg_flags & NLM_F_ECHO);
>  }
>
> +static int tclass_get_notify(struct net *net, struct sk_buff *oskb,
> +                            struct nlmsghdr *n, struct Qdisc *q,
> +                            unsigned long cl, struct netlink_ext_ack *ex=
tack)
> +{
> +       struct sk_buff *skb;
> +       u32 portid =3D oskb ? NETLINK_CB(oskb).portid : 0;
> +
> +       skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> +       if (!skb)
> +               return -ENOBUFS;
> +
> +       if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, RTM_NEWTC=
LASS,
> +                          extack) < 0) {
> +               kfree_skb(skb);
> +               return -EINVAL;
> +       }
> +
> +       return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
> +                             n->nlmsg_flags & NLM_F_ECHO);
> +}
> +
>  static int tclass_del_notify(struct net *net,
>                              const struct Qdisc_class_ops *cops,
>                              struct sk_buff *oskb, struct nlmsghdr *n,
> @@ -2003,14 +2056,18 @@ static int tclass_del_notify(struct net *net,
>         if (!cops->delete)
>                 return -EOPNOTSUPP;
>
> -       skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> -       if (!skb)
> -               return -ENOBUFS;
> +       if (rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC)) {
> +               skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> +               if (!skb)
> +                       return -ENOBUFS;
>
> -       if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
> -                          RTM_DELTCLASS, extack) < 0) {
> -               kfree_skb(skb);
> -               return -EINVAL;
> +               if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
> +                                  RTM_DELTCLASS, extack) < 0) {
> +                       kfree_skb(skb);
> +                       return -EINVAL;
> +               }
> +       } else {
> +               skb =3D NULL;
>         }
>
>         err =3D cops->delete(q, cl, extack);
> @@ -2019,8 +2076,8 @@ static int tclass_del_notify(struct net *net,
>                 return err;
>         }
>
> -       err =3D rtnetlink_send(skb, net, portid, RTNLGRP_TC,
> -                            n->nlmsg_flags & NLM_F_ECHO);
> +       err =3D rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
> +                                  n->nlmsg_flags & NLM_F_ECHO);
>         return err;
>  }
>
> @@ -2215,7 +2272,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struc=
t nlmsghdr *n,
>                         tc_bind_tclass(q, portid, clid, 0);
>                         goto out;
>                 case RTM_GETTCLASS:
> -                       err =3D tclass_notify(net, skb, n, q, cl, RTM_NEW=
TCLASS, extack);
> +                       err =3D tclass_get_notify(net, skb, n, q, cl, ext=
ack);
>                         goto out;
>                 default:
>                         err =3D -EINVAL;
> --
> 2.40.1
>

