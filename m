Return-Path: <netdev+bounces-30385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC344787157
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DC1281518
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC63111AD;
	Thu, 24 Aug 2023 14:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958FCA7D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:20:11 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF711F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:20:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58de42f9f05so69682797b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692886808; x=1693491608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKwNU8qwvvQCoMt85acYfSYgfvwhYYpy+34sNNZWSqA=;
        b=hvMxJwo6eAv1zBmd5sunqsc61ENK9BgP8491X0fZk9BFVUP74Li1blL0HZ17mokqKj
         K3w1WJsUIIeDYNtTbWK92Fd135pigB9t5E2Dbq+0fNwDLA2W2I4inpbkKrLa9+uP1LsX
         e47MuB4Or2ND/VxjwLYc5bqHr8hXxz9R27zyTmABfTaOJx1yRaxHIrZN3yv3iJRZdzpO
         FKELIIDCN4hSkxGcPRCU++OO8/r/nHwgyffLlkxk9uqP4KUxwlh4AfHNnQdePl+ywfQJ
         izXFR1UAFEIPa6VKiKkytEyPUfA8qZo0TiIiycAT7RRakYU2DJaTjS++t8Knvwk1f4q7
         3Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886808; x=1693491608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKwNU8qwvvQCoMt85acYfSYgfvwhYYpy+34sNNZWSqA=;
        b=loIgiQPWCxQeNJe8XxuT0SUhk7WNnOt2TQrC01QA/bjChfyYjSE3TW1pUI6OVsv/Aa
         5npZfCCH/w3ctGeFQbfCvApwFiXTOfagA3gvKfbY1qrNSZDY7NAwuLRljPHvY8yz5qNe
         0qIcx4mTZwTNZemNfSNRwumVeHQ/FwDW3MeXykgJGrENZh9JvmfE2FqmZ6dpi3KkLE/w
         +LyBT1IJ6BctVLShBVdBK/VfL15DPtwH2klWGrWMziYOk5a2rQb8bRAnzIi7ofdntAwh
         ebX+CG4ux/dXkR1dm+eV7YvxyhdQ5BGddrsKgM/xBmClWW5R5hpsZV88nmW8Ibgej1kd
         X6Mw==
X-Gm-Message-State: AOJu0YwfyCGccriwWYYneHVslO5jAgVqBKRtEtQLo2M+Jvg4amDKrZOK
	Oh0Qyz+CfIpFX6E5KgtG6TBu5TyzgE1tyBZePto0j29cXz3yeZj/
X-Google-Smtp-Source: AGHT+IGdN2LszkpNbU3CZ1p86XIjXJV7XbQ58d7jjm/BbCrh5VI8NEyj4QBqcQj+mLDSq6il0GzeFgWG9YfQSVEnRbw=
X-Received: by 2002:a81:9e4c:0:b0:583:d100:320d with SMTP id
 n12-20020a819e4c000000b00583d100320dmr15922747ywj.48.1692886808250; Thu, 24
 Aug 2023 07:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-4-victor@mojatatu.com>
 <CALnP8ZYQJLv2zzjmg5Q6M1ZLEUm_fK9q6re7xtRsbYtTPTMbSw@mail.gmail.com>
In-Reply-To: <CALnP8ZYQJLv2zzjmg5Q6M1ZLEUm_fK9q6re7xtRsbYtTPTMbSw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 10:19:57 -0400
Message-ID: <CAM0EoM=fd4K94j2RoyTft_sH=DMkwbQyJk0=uyZePrC1Xc3BoA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 1:58=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Sat, Aug 19, 2023 at 01:35:14PM -0300, Victor Nogueira wrote:
> > This action takes advantage of the presence of tc block ports set in th=
e
> > datapath and broadcast a packet to all ports on that set with exception=
 of
> > the port in which it arrived on..
>
> I couldn't find anything int he code blocking this action from being
> used in the egress path as well. So what about: s/arrived/& or is
> being transmitted/ , making it explicit that it is an expected usage?
>

sure.

> more below
>
> >
> > Example usage:
> >     $ tc qdisc add dev ens7 ingress block 22
> >     $ tc qdisc add dev ens8 ingress block 22
> >
> > Now we can add a filter using the block index:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action blockcast
> >
> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >  include/net/tc_wrapper.h  |   5 +
> >  net/sched/Kconfig         |  13 ++
> >  net/sched/Makefile        |   1 +
> >  net/sched/act_blockcast.c | 299 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 318 insertions(+)
> >  create mode 100644 net/sched/act_blockcast.c
> >
> > diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
> > index a6d481b5bcbc..8ef848968be7 100644
> > --- a/include/net/tc_wrapper.h
> > +++ b/include/net/tc_wrapper.h
> > @@ -28,6 +28,7 @@ TC_INDIRECT_ACTION_DECLARE(tcf_csum_act);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_ct_act);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_ctinfo_act);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_gact_act);
> > +TC_INDIRECT_ACTION_DECLARE(tcf_blockcast_run);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_gate_act);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_ife_act);
> >  TC_INDIRECT_ACTION_DECLARE(tcf_ipt_act);
> > @@ -57,6 +58,10 @@ static inline int tc_act(struct sk_buff *skb, const =
struct tc_action *a,
> >       if (a->ops->act =3D=3D tcf_mirred_act)
> >               return tcf_mirred_act(skb, a, res);
> >  #endif
> > +#if IS_BUILTIN(CONFIG_NET_ACT_BLOCKCAST)
> > +     if (a->ops->act =3D=3D tcf_blockcast_run)
> > +             return tcf_blockcast_run(skb, a, res);
> > +#endif
> >  #if IS_BUILTIN(CONFIG_NET_ACT_PEDIT)
> >       if (a->ops->act =3D=3D tcf_pedit_act)
> >               return tcf_pedit_act(skb, a, res);
> > diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> > index 4b95cb1ac435..1b0edf1287d0 100644
> > --- a/net/sched/Kconfig
> > +++ b/net/sched/Kconfig
> > @@ -780,6 +780,19 @@ config NET_ACT_SIMP
> >         To compile this code as a module, choose M here: the
> >         module will be called act_simple.
> >
> > +config NET_ACT_BLOCKCAST
> > +     tristate "TC block Multicast"
> > +     depends on NET_CLS_ACT
> > +     help
> > +       Say Y here to add an action that will multicast an skb to egres=
s of
> > +       all netdevs that belong to a tc block except for the netdev on =
which
> > +          the skb arrived on
> > +
> > +       If unsure, say N.
> > +
> > +       To compile this code as a module, choose M here: the
> > +       module will be called act_blockcast.
> > +
> >  config NET_ACT_SKBEDIT
> >       tristate "SKB Editing"
> >       depends on NET_CLS_ACT
> > diff --git a/net/sched/Makefile b/net/sched/Makefile
> > index b5fd49641d91..2cdcf30645eb 100644
> > --- a/net/sched/Makefile
> > +++ b/net/sched/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_NET_ACT_IPT)   +=3D act_ipt.o
> >  obj-$(CONFIG_NET_ACT_NAT)    +=3D act_nat.o
> >  obj-$(CONFIG_NET_ACT_PEDIT)  +=3D act_pedit.o
> >  obj-$(CONFIG_NET_ACT_SIMP)   +=3D act_simple.o
> > +obj-$(CONFIG_NET_ACT_BLOCKCAST)      +=3D act_blockcast.o
> >  obj-$(CONFIG_NET_ACT_SKBEDIT)        +=3D act_skbedit.o
> >  obj-$(CONFIG_NET_ACT_CSUM)   +=3D act_csum.o
> >  obj-$(CONFIG_NET_ACT_MPLS)   +=3D act_mpls.o
> > diff --git a/net/sched/act_blockcast.c b/net/sched/act_blockcast.c
> > new file mode 100644
> > index 000000000000..85fd0289927c
> > --- /dev/null
> > +++ b/net/sched/act_blockcast.c
> > @@ -0,0 +1,299 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * net/sched/act_blockcast.c Block Cast action
> > + * Copyright (c) 2023, Mojatatu Networks
> > + * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
> > + *              Victor Nogueira <victor@mojatatu.com>
> > + *              Pedro Tammela <pctammela@mojatatu.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/rtnetlink.h>
> > +#include <net/netlink.h>
> > +#include <net/pkt_sched.h>
> > +#include <net/pkt_cls.h>
> > +#include <linux/if_arp.h>
> > +#include <net/tc_wrapper.h>
> > +
> > +#include <linux/tc_act/tc_defact.h>
> > +
> > +static struct tc_action_ops act_blockcast_ops;
> > +
> > +struct tcf_blockcast_act {
> > +     struct tc_action        common;
> > +};
> > +
> > +#define to_blockcast_act(a) ((struct tcf_blockcast_act *)a)
> > +
> > +#define TCA_ID_BLOCKCAST 123
>
> This needs to be part of enum tca_id instead, as this is uapi.
>
> > +#define CAST_RECURSION_LIMIT  4
> > +
> > +static DEFINE_PER_CPU(unsigned int, redirect_rec_level);
> > +
> > +static int cast_one(struct sk_buff *skb, const u32 ifindex)
> > +{
> > +     struct sk_buff *skb2 =3D skb;
> > +     int retval =3D TC_ACT_PIPE;
> > +     struct net_device *dev;
> > +     unsigned int rec_level;
> > +     bool expects_nh;
> > +     int mac_len;
> > +     bool at_nh;
> > +     int err;
> > +
> > +     rec_level =3D __this_cpu_inc_return(redirect_rec_level);
> > +     if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
> > +             net_warn_ratelimited("blockcast: exceeded redirect recurs=
ion limit on dev %s\n",
> > +                                  netdev_name(skb->dev));
>
> I wrote the comment below earlier than this one :-)
> Here, I would think this is really an exception path, and if this
> shows up, it needs to be addressed. So this msg IMHO is fine.
>

ok;->

> > +             __this_cpu_dec(redirect_rec_level);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     dev =3D dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
> > +     if (unlikely(!dev)) {
> > +             __this_cpu_dec(redirect_rec_level);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     if (unlikely(!(dev->flags & IFF_UP) || !netif_carrier_ok(dev))) {
> > +             net_notice_ratelimited("blockcast: device %s is down\n",
> > +                                    dev->name);
>
> Please no, not this warning. We already have a situation with mirred
> and ovs bridges often being down and getting dmesg spammed. We
> couldn't remove that log msg because of fear of some sysadmin missing
> the hint. But here, that doesn't apply, and dmesg is not the right way
> to debug packet drops.
>

I think we could probably increment the action error counter here
instead. The error is not catastrophic really, one of the ports in the
block is not up - big deal.

> > +             __this_cpu_dec(redirect_rec_level);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     skb2 =3D skb_clone(skb, GFP_ATOMIC);
> > +     if (!skb2) {
> > +             __this_cpu_dec(redirect_rec_level);
> > +             return retval;
> > +     }
> > +
> > +     nf_reset_ct(skb2);
> > +
> > +     expects_nh =3D !dev_is_mac_header_xmit(dev);
> > +     at_nh =3D skb->data =3D=3D skb_network_header(skb);
> > +     if (at_nh !=3D expects_nh) {
> > +             mac_len =3D skb_at_tc_ingress(skb) ?
> > +                               skb->mac_len :
> > +                               skb_network_header(skb) - skb_mac_heade=
r(skb);
> > +
> > +             if (expects_nh) {
> > +                     /* target device/action expect data at nh */
> > +                     skb_pull_rcsum(skb2, mac_len);
> > +             } else {
> > +                     /* target device/action expect data at mac */
> > +                     skb_push_rcsum(skb2, mac_len);
> > +             }
> > +     }
> > +
> > +     skb2->skb_iif =3D skb->dev->ifindex;
> > +     skb2->dev =3D dev;
> > +
> > +     err =3D dev_queue_xmit(skb2);
> > +     if (err)
> > +             retval =3D TC_ACT_SHOT;
> > +
> > +     __this_cpu_dec(redirect_rec_level);
> > +
> > +     return retval;
> > +}
> > +
> > +TC_INDIRECT_SCOPE int tcf_blockcast_run(struct sk_buff *skb,
> > +                                     const struct tc_action *a,
> > +                                     struct tcf_result *res)
> > +{
> > +     u32 block_index =3D qdisc_skb_cb(skb)->block_index;
> > +     struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> > +     int action =3D READ_ONCE(p->tcf_action);
> > +     struct net *net =3D dev_net(skb->dev);
> > +     struct tcf_block *block;
> > +     struct net_device *dev;
> > +     u32 exception_ifindex;
> > +     unsigned long index;
> > +
> > +     block =3D tcf_block_lookup(net, block_index);
> > +     exception_ifindex =3D skb->dev->ifindex;
> > +
> > +     tcf_action_update_bstats(&p->common, skb);
> > +     tcf_lastuse_update(&p->tcf_tm);
> > +
> > +     if (!block || xa_empty(&block->ports))
> > +             goto act_done;
> > +
> > +     /* we are already under rcu protection, so iterating block is saf=
e*/
> > +     xa_for_each(&block->ports, index, dev) {
> > +             int err;
> > +
> > +             if (index =3D=3D exception_ifindex)
> > +                     continue;
> > +
> > +             err =3D cast_one(skb, dev->ifindex);
> > +             if (err !=3D TC_ACT_PIPE)
> > +                     printk("(%d)Failed to send to dev\t%d: %s\n", err=
,
> > +                            dev->ifindex, dev->name);
>
> Same comment here about logging.

Yep, error count increment will do.

>
> > +     }
> > +
> > +act_done:
> > +     if (action =3D=3D TC_ACT_SHOT)
> > +             tcf_action_inc_drop_qstats(&p->common);
> > +     return action;
> > +}
> > +
> > +static const struct nla_policy blockcast_policy[TCA_DEF_MAX + 1] =3D {
> > +     [TCA_DEF_PARMS] =3D { .len =3D sizeof(struct tc_defact) },
> > +};
> > +
> > +static int tcf_blockcast_init(struct net *net, struct nlattr *nla,
> > +                           struct nlattr *est, struct tc_action **a,
> > +                           struct tcf_proto *tp, u32 flags,
> > +                           struct netlink_ext_ack *extack)
> > +{
> > +     struct tc_action_net *tn =3D net_generic(net, act_blockcast_ops.n=
et_id);
> > +     struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> > +     bool bind =3D flags & TCA_ACT_FLAGS_BIND;
> > +     struct nlattr *tb[TCA_DEF_MAX + 1];
> > +     struct tcf_chain *goto_ch =3D NULL;
> > +     struct tc_defact *parm;
> > +     bool exists =3D false;
> > +     int ret =3D 0, err;
> > +     u32 index;
> > +
> > +     if (!nla)
> > +             return -EINVAL;
> > +
> > +     err =3D nla_parse_nested_deprecated(tb, TCA_DEF_MAX, nla,
> > +                                       blockcast_policy, NULL);
>
> Why the _deprecated one again please? This one doesn't need backwards
> compatibility.
>

Ah, it's just TheLinuxWay(tm). Original code was cutnpasted from act_simple=
.

Thanks Marcelo.

cheers,
jamal

> Thanks,
> Marcelo
>
> > +     if (err < 0)
> > +             return err;
> > +
> > +     if (!tb[TCA_DEF_PARMS])
> > +             return -EINVAL;
> > +
> > +     parm =3D nla_data(tb[TCA_DEF_PARMS]);
> > +     index =3D parm->index;
> > +
> > +     err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     exists =3D err;
> > +     if (exists && bind)
> > +             return 0;
> > +
> > +     if (!exists) {
> > +             ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> > +                                             &act_blockcast_ops, bind,=
 flags);
> > +             if (ret) {
> > +                     tcf_idr_cleanup(tn, index);
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D ACT_P_CREATED;
> > +     } else {
> > +             if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
> > +                     err =3D -EEXIST;
> > +                     goto release_idr;
> > +             }
> > +     }
> > +
> > +     err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, exta=
ck);
> > +     if (err < 0)
> > +             goto release_idr;
> > +
> > +     if (exists)
> > +             spin_lock_bh(&p->tcf_lock);
> > +     goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> > +     if (exists)
> > +             spin_unlock_bh(&p->tcf_lock);
> > +
> > +     if (goto_ch)
> > +             tcf_chain_put_by_act(goto_ch);
> > +
> > +     return ret;
> > +release_idr:
> > +     tcf_idr_release(*a, bind);
> > +     return err;
> > +}
> > +
> > +static int tcf_blockcast_dump(struct sk_buff *skb, struct tc_action *a=
,
> > +                           int bind, int ref)
> > +{
> > +     unsigned char *b =3D skb_tail_pointer(skb);
> > +     struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> > +     struct tc_defact opt =3D {
> > +             .index   =3D p->tcf_index,
> > +             .refcnt  =3D refcount_read(&p->tcf_refcnt) - ref,
> > +             .bindcnt =3D atomic_read(&p->tcf_bindcnt) - bind,
> > +     };
> > +     struct tcf_t t;
> > +
> > +     spin_lock_bh(&p->tcf_lock);
> > +     opt.action =3D p->tcf_action;
> > +     if (nla_put(skb, TCA_DEF_PARMS, sizeof(opt), &opt))
> > +             goto nla_put_failure;
> > +
> > +     tcf_tm_dump(&t, &p->tcf_tm);
> > +     if (nla_put_64bit(skb, TCA_DEF_TM, sizeof(t), &t, TCA_DEF_PAD))
> > +             goto nla_put_failure;
> > +     spin_unlock_bh(&p->tcf_lock);
> > +
> > +     return skb->len;
> > +
> > +nla_put_failure:
> > +     spin_unlock_bh(&p->tcf_lock);
> > +     nlmsg_trim(skb, b);
> > +     return -1;
> > +}
> > +
> > +static struct tc_action_ops act_blockcast_ops =3D {
> > +     .kind           =3D       "blockcast",
> > +     .id             =3D       TCA_ID_BLOCKCAST,
> > +     .owner          =3D       THIS_MODULE,
> > +     .act            =3D       tcf_blockcast_run,
> > +     .dump           =3D       tcf_blockcast_dump,
> > +     .init           =3D       tcf_blockcast_init,
> > +     .size           =3D       sizeof(struct tcf_blockcast_act),
> > +};
> > +
> > +static __net_init int blockcast_init_net(struct net *net)
> > +{
> > +     struct tc_action_net *tn =3D net_generic(net, act_blockcast_ops.n=
et_id);
> > +
> > +     return tc_action_net_init(net, tn, &act_blockcast_ops);
> > +}
> > +
> > +static void __net_exit blockcast_exit_net(struct list_head *net_list)
> > +{
> > +     tc_action_net_exit(net_list, act_blockcast_ops.net_id);
> > +}
> > +
> > +static struct pernet_operations blockcast_net_ops =3D {
> > +     .init =3D blockcast_init_net,
> > +     .exit_batch =3D blockcast_exit_net,
> > +     .id   =3D &act_blockcast_ops.net_id,
> > +     .size =3D sizeof(struct tc_action_net),
> > +};
> > +
> > +MODULE_AUTHOR("Mojatatu Networks, Inc");
> > +MODULE_LICENSE("GPL");
> > +
> > +static int __init blockcast_init_module(void)
> > +{
> > +     int ret =3D tcf_register_action(&act_blockcast_ops, &blockcast_ne=
t_ops);
> > +
> > +     if (!ret)
> > +             pr_info("blockcast TC action Loaded\n");
> > +     return ret;
> > +}
> > +
> > +static void __exit blockcast_cleanup_module(void)
> > +{
> > +     tcf_unregister_action(&act_blockcast_ops, &blockcast_net_ops);
> > +}
> > +
> > +module_init(blockcast_init_module);
> > +module_exit(blockcast_cleanup_module);
> > --
> > 2.25.1
> >
>

