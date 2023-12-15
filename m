Return-Path: <netdev+bounces-57982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3D814A9F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1731F21AA4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236330640;
	Fri, 15 Dec 2023 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LX1zBuZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACD1E535
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so368612a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702651008; x=1703255808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5oh/bxjXnaE54gtLmR46/UIyG68SRaD4v9mr3JpiXI=;
        b=LX1zBuZGtAdt0kYoo9Rkru/igGe5R2Fc8JfrQXqOLCw3HdcW9b9IJOsm9zvlzl4pka
         WTitCGk9XpNbh++2aZgIW/I0d8j7Om0FVln3MLBRdk8kGgdWxhszT4EGwDmDvQN+Ek7H
         QTZ6cdSG8S/0nFYCr74ixa/+lkKKGSSnap+hVdF4Tn+wbLe9dQi+MADKXY1OOnuhF7mw
         3EjUH/beWG97hJ7Rg3QVHSrTvx52eQkZxIDnaJr1rIN0hZqna6AWzfCZl8zjY7PNeGpB
         InmFb64ZHGR1H3I8E74TXFzK/dTs6QGJSqIeL/8zq3TdTUmWgM1me80jZ4L6tuQDMUfb
         a5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651008; x=1703255808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5oh/bxjXnaE54gtLmR46/UIyG68SRaD4v9mr3JpiXI=;
        b=nJ5K5dXQk25NQ2ngsZBsMt/P47jLF1ZFU/2W5nQoG+c1Vp2fWF87eELp+PRqIa3FeL
         sWAfHWZ5UNXt/wEJRhD/gF8KNFra6yA1EwrUO1pVwWwoiE+tKoXzOvuwuBba5vEiVtGn
         L2lQ9PhFJO2hHTQ3XIWsRw7FnSQso56ZsvDsc/SUMOjOQnHTbgRhfSXkmgRS/3IyOaFw
         xVaMBv0hyos38ItLaTmMZQ/NBnlp/G1A0vq6E3vmsikxSGfHaMBwZYemuA7EwddWSMxE
         QrT85lKP7VQ6dpi1d6s367+GVpOT9JomfrNQdxpre3Vtox1hL6ig3N6IygtMfngzcNPk
         9PpQ==
X-Gm-Message-State: AOJu0YxwY64Z0XmEdE6loIs5FhDqZTcyq83lLWCKROInT5OS2OsS8kWe
	Vsu6zCopxm56h7q6Io5Z+BvKztnyFQfnIaeeIGZDJA==
X-Google-Smtp-Source: AGHT+IFmIkpXpCRnU6WSqeXH7SxQKmDW2IGXTTMtrFVEYTzgyRjKpgGLb6ij50S0HtbEZNCxFWFIPXJ1gyrtg5vhEq0=
X-Received: by 2002:a17:90a:d16:b0:28b:2c7d:7552 with SMTP id
 t22-20020a17090a0d1600b0028b2c7d7552mr629862pja.42.1702651008276; Fri, 15 Dec
 2023 06:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215111050.3624740-1-victor@mojatatu.com> <20231215111050.3624740-4-victor@mojatatu.com>
 <ZXxPZoaIQoa7jlJv@nanopsycho> <1d08f20e-a363-4405-ad97-1107cd34628a@mojatatu.com>
 <ZXxgUHVzFp4BVZl3@nanopsycho>
In-Reply-To: <ZXxgUHVzFp4BVZl3@nanopsycho>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Fri, 15 Dec 2023 09:36:37 -0500
Message-ID: <CAAFAkD8KeMi3z-AArAsp8G8qAYPTv=go0qRvvTguWxAou+fzxw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to block
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com, 
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:19=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Dec 15, 2023 at 02:56:48PM CET, victor@mojatatu.com wrote:
> >On 15/12/2023 10:06, Jiri Pirko wrote:
> >> Fri, Dec 15, 2023 at 12:10:50PM CET, victor@mojatatu.com wrote:
> >> > So far the mirred action has dealt with syntax that handles mirror/r=
edirection for netdev.
> >> > A matching packet is redirected or mirrored to a target netdev.
> >> >
> >> > In this patch we enable mirred to mirror to a tc block as well.
> >> > IOW, the new syntax looks as follows:
> >> > ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <b=
lockid BLOCKID> | <dev <devname>> >
> >> >
> >> > Examples of mirroring or redirecting to a tc block:
> >> > $ tc filter add block 22 protocol ip pref 25 \
> >> >   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 2=
2
> >> >
> >> > $ tc filter add block 22 protocol ip pref 25 \
> >> >   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid=
 22
> >> >
> >> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> > ---
> >> > include/net/tc_act/tc_mirred.h        |   1 +
> >> > include/uapi/linux/tc_act/tc_mirred.h |   1 +
> >> > net/sched/act_mirred.c                | 278 +++++++++++++++++++-----=
--
> >> > 3 files changed, 206 insertions(+), 74 deletions(-)
> >> >
> >> > diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_=
mirred.h
> >> > index 32ce8ea36950..75722d967bf2 100644
> >> > --- a/include/net/tc_act/tc_mirred.h
> >> > +++ b/include/net/tc_act/tc_mirred.h
> >> > @@ -8,6 +8,7 @@
> >> > struct tcf_mirred {
> >> >    struct tc_action        common;
> >> >    int                     tcfm_eaction;
> >> > +  u32                     tcfm_blockid;
> >> >    bool                    tcfm_mac_header_xmit;
> >> >    struct net_device __rcu *tcfm_dev;
> >> >    netdevice_tracker       tcfm_dev_tracker;
> >> > diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/li=
nux/tc_act/tc_mirred.h
> >> > index 2500a0005d05..54df06658bc8 100644
> >> > --- a/include/uapi/linux/tc_act/tc_mirred.h
> >> > +++ b/include/uapi/linux/tc_act/tc_mirred.h
> >> > @@ -20,6 +20,7 @@ enum {
> >> >    TCA_MIRRED_UNSPEC,
> >> >    TCA_MIRRED_TM,
> >> >    TCA_MIRRED_PARMS,
> >> > +  TCA_MIRRED_BLOCKID,
> >>
> >> You just broke uapi. Make sure to add new attributes to the end.
> >
> >My bad, don't know how we missed this one.
> >Will fix in v8.
> >
> >>
> >> >    TCA_MIRRED_PAD,
> >> >    __TCA_MIRRED_MAX
> >> > };
> >> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> >> > index 0a711c184c29..8b6d04d26c5a 100644
> >> > --- a/net/sched/act_mirred.c
> >> > +++ b/net/sched/act_mirred.c
> >> > @@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action =
*a)
> >> >
> >> > static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] =3D=
 {
> >> >    [TCA_MIRRED_PARMS]      =3D { .len =3D sizeof(struct tc_mirred) }=
,
> >> > +  [TCA_MIRRED_BLOCKID]    =3D { .type =3D NLA_U32 },
> >> > };
> >> >
> >> > static struct tc_action_ops act_mirred_ops;
> >> >
> >> > +static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net=
_device *ndev)
> >> > +{
> >> > +  struct net_device *odev;
> >> > +
> >> > +  odev =3D rcu_replace_pointer(m->tcfm_dev, ndev,
> >> > +                             lockdep_is_held(&m->tcf_lock));
> >> > +  netdev_put(odev, &m->tcfm_dev_tracker);
> >> > +}
> >> > +
> >> > static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> >> >                       struct nlattr *est, struct tc_action **a,
> >> >                       struct tcf_proto *tp,
> >> > @@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, str=
uct nlattr *nla,
> >> >    if (exists && bind)
> >> >            return 0;
> >> >
> >> > +  if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
> >> > +          NL_SET_ERR_MSG_MOD(extack,
> >> > +                             "Mustn't specify Block ID and dev simu=
ltaneously");
> >> > +          err =3D -EINVAL;
> >> > +          goto release_idr;
> >> > +  }
> >> > +
> >> >    switch (parm->eaction) {
> >> >    case TCA_EGRESS_MIRROR:
> >> >    case TCA_EGRESS_REDIR:
> >> > @@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, stru=
ct nlattr *nla,
> >> >    }
> >> >
> >> >    if (!exists) {
> >> > -          if (!parm->ifindex) {
> >> > +          if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
> >> >                    tcf_idr_cleanup(tn, index);
> >> > -                  NL_SET_ERR_MSG_MOD(extack, "Specified device does=
 not exist");
> >> > +                  NL_SET_ERR_MSG_MOD(extack, "Must specify device o=
r block");
> >> >                    return -EINVAL;
> >> >            }
> >> >            ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> >> > @@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, stru=
ct nlattr *nla,
> >> >    spin_lock_bh(&m->tcf_lock);
> >> >
> >> >    if (parm->ifindex) {
> >> > -          struct net_device *odev, *ndev;
> >> > +          struct net_device *ndev;
> >> >
> >> >            ndev =3D dev_get_by_index(net, parm->ifindex);
> >> >            if (!ndev) {
> >> > @@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, st=
ruct nlattr *nla,
> >> >                    goto put_chain;
> >> >            }
> >> >            mac_header_xmit =3D dev_is_mac_header_xmit(ndev);
> >> > -          odev =3D rcu_replace_pointer(m->tcfm_dev, ndev,
> >> > -                                    lockdep_is_held(&m->tcf_lock));
> >> > -          netdev_put(odev, &m->tcfm_dev_tracker);
> >> > +          tcf_mirred_replace_dev(m, ndev);
> >>
> >> This could be a separate patch, for better readability of the patches.
> >>
> >> Skimming thought the rest of the patch, this is hard to follow (-ETOOB=
IG).
> >> What would help is to cut this patch into multiple ones. Do preparatio=
ns
> >> first, then you finally add TCA_MIRRED_BLOCKID processin and blockid
> >> forwarding. Could you?
> >
> >Will transform this one into two separate patches.
>
> More please.

I see the first one as preparation and the second as usage. Can you
make suggestion as to what more/better split is?

cheers,
jamal

> >
> >>
> >> >            netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOM=
IC);
> >> >            m->tcfm_mac_header_xmit =3D mac_header_xmit;
> >> > +          m->tcfm_blockid =3D 0;
> >> > +  } else if (tb[TCA_MIRRED_BLOCKID]) {
> >> > +          tcf_mirred_replace_dev(m, NULL);
> >> > +          m->tcfm_mac_header_xmit =3D false;
> >> > +          m->tcfm_blockid =3D nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
> >> >    }
> >> >    goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> >> >    m->tcfm_eaction =3D parm->eaction;
> >>
> >> [...]

