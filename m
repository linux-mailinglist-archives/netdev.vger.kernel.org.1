Return-Path: <netdev+bounces-30383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06145787105
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CFB2815D1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F111119C;
	Thu, 24 Aug 2023 14:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505142890D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:05:57 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AE19A0
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:05:55 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d748d8cf074so1307704276.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692885955; x=1693490755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIpnec6Y/VdAAjn3XRu7fQGikCJKFqaORPxV/esjB1E=;
        b=DMKo0CWTYH+oPwBUsQuOHIJj6HvJWcJKU/5FrT6bU/ExwKZDm6lKBq5hO956rWUUi+
         5A7HtwXZtcmzSK5BBKpab42Vglgu0P5aCq46uXYuhY3YrUm5MLj77u/yihcqX7b9/1nO
         HLC1/YiNaI5RU2dofDLui1wH8Gw3z8bF9/TfJ/PaSkRDmr5ohU488V44MS6xiI1+ySGk
         aiRa0Et+I42SdQxeTHCb6ZtgH17P/89MDLG+o+v6BlKg+st9j/aVSyEpbOnIkoSNr0th
         NPeROvawaPIkqLrLtWKmLS5Ic8S0a9Qv2zyACUCYCdCauQOo5uqbNVsrhFXlzcb1kOy7
         DG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692885955; x=1693490755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIpnec6Y/VdAAjn3XRu7fQGikCJKFqaORPxV/esjB1E=;
        b=PzIMFekxAtWhtU4HWNnOqVUHMIxBjUTJDc2UZxe1mQrHZyA3Kcn2ExO5WkkFSFNxmX
         UXPRb2TPOQD1dsBXzuRkQ0hr5ravxWUC76vIZCMH/hLs7tL8Cm/K6yxcllIN3v34eekk
         ptnOFin3/AqUPuCZu8y2eN3k7lh40e+6juX8ZrMpmN7Qxgxrir3JDBbsvr0bjabVj5sC
         AMujV7QZ8ZfWtVJ2ZGnAlhumKDIYa/NpYpds47xoN1Ev2hsSFVbbTrN6lhdLHzGl40VA
         hqGht+tpBYhWOz/Tix8H7CFarBIgaD9SIA6FKb0po9Bbe9lb14F+8ycwXWwiprUQPa2p
         ZqjA==
X-Gm-Message-State: AOJu0Yyw41fEImzClvAHHDp63KWpkJ4YhZLu1pcXx2My2FfgqdCFaLGL
	ASsZyVuH8f934ojGPLlic22ZLtN6F2PgKiGgiQ8Q1g==
X-Google-Smtp-Source: AGHT+IEGVG3TvYzbPmL2RbcGe2mMd9exyIU4vzarcwZgEzN4LLinL4YYKnZzz9XMtPdG4Dx8pk8UaC/jElxUte72Cyo=
X-Received: by 2002:a0d:e2c5:0:b0:589:a4c7:ee40 with SMTP id
 l188-20020a0de2c5000000b00589a4c7ee40mr15948681ywe.2.1692885954767; Thu, 24
 Aug 2023 07:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-2-victor@mojatatu.com>
 <871qfw6w8d.fsf@nvidia.com>
In-Reply-To: <871qfw6w8d.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 10:05:43 -0400
Message-ID: <CAM0EoM=WKsJva-Z27GiXKZedeZU7C8Mmqvq6eKHxZRE-op87jA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net/sched: Introduce tc block netdev
 tracking infra
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, mleitner@redhat.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 3:18=E2=80=AFPM Vlad Buslov <vladbu@nvidia.com> wro=
te:
>
>
> On Sat 19 Aug 2023 at 13:35, Victor Nogueira <victor@mojatatu.com> wrote:
> > The tc block is a collection of netdevs/ports which allow qdiscs to sha=
re
> > filter block instances (as opposed to the traditional tc filter per por=
t).
> > Example:
> > $ tc qdisc add dev ens7 ingress block 22
> > $ tc qdisc add dev ens8 ingress block 22
> >
> > Now we can add a filter using the block index:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action drop
> >
> > Up to this point, the block is unaware of its ports. This patch fixes t=
hat
> > and makes the tc block ports available to the datapath as well as contr=
ol
> > path on offloading.
> >
> > Suggested-by: Jiri Pirko <jiri@nvidia.com>
> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >  include/net/sch_generic.h |  4 ++
> >  net/sched/cls_api.c       |  1 +
> >  net/sched/sch_api.c       | 79 +++++++++++++++++++++++++++++++++++++--
> >  net/sched/sch_generic.c   | 34 ++++++++++++++++-
> >  4 files changed, 112 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index e92f73bb3198..824a0ecb5afc 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -19,6 +19,7 @@
> >  #include <net/gen_stats.h>
> >  #include <net/rtnetlink.h>
> >  #include <net/flow_offload.h>
> > +#include <linux/xarray.h>
> >
> >  struct Qdisc_ops;
> >  struct qdisc_walker;
> > @@ -126,6 +127,8 @@ struct Qdisc {
> >
> >       struct rcu_head         rcu;
> >       netdevice_tracker       dev_tracker;
> > +     netdevice_tracker       in_block_tracker;
> > +     netdevice_tracker       eg_block_tracker;
> >       /* private data */
> >       long privdata[] ____cacheline_aligned;
> >  };
> > @@ -458,6 +461,7 @@ struct tcf_chain {
> >  };
> >
> >  struct tcf_block {
> > +     struct xarray ports; /* datapath accessible */
> >       /* Lock protects tcf_block and lifetime-management data of chains
> >        * attached to the block (refcnt, action_refcnt, explicitly_creat=
ed).
> >        */
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index a193cc7b3241..a976792ef02f 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -1003,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct =
net *net, struct Qdisc *q,
> >       refcount_set(&block->refcnt, 1);
> >       block->net =3D net;
> >       block->index =3D block_index;
> > +     xa_init(&block->ports);
>
> Missing dual call to xa_destroy() for this.
>

Good catch - that should go in block destroy. I am not sure why
kmemleak test didnt catch this.

> >
> >       /* Don't store q pointer for blocks which are shared */
> >       if (!tcf_block_shared(block))
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index aa6b1fe65151..6c0c220cdb21 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1180,6 +1180,71 @@ static int qdisc_graft(struct net_device *dev, s=
truct Qdisc *parent,
> >       return 0;
> >  }
> >
> > +static void qdisc_block_undo_set(struct Qdisc *sch, struct nlattr **tc=
a)
> > +{
> > +     if (tca[TCA_INGRESS_BLOCK])
> > +             sch->ops->ingress_block_set(sch, 0);
> > +
> > +     if (tca[TCA_EGRESS_BLOCK])
> > +             sch->ops->egress_block_set(sch, 0);
> > +}
> > +
> > +static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *d=
ev,
> > +                            struct nlattr **tca,
> > +                            struct netlink_ext_ack *extack)
> > +{
> > +     const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> > +     struct tcf_block *in_block =3D NULL;
> > +     struct tcf_block *eg_block =3D NULL;
> > +     unsigned long cl =3D 0;
> > +     int err;
> > +
> > +     if (tca[TCA_INGRESS_BLOCK]) {
> > +             /* works for both ingress and clsact */
> > +             cl =3D TC_H_MIN_INGRESS;
> > +             in_block =3D cl_ops->tcf_block(sch, cl, NULL);
> > +             if (!in_block) {
> > +                     NL_SET_ERR_MSG(extack, "Shared ingress block miss=
ing");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             err =3D xa_insert(&in_block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> > +             if (err) {
> > +                     NL_SET_ERR_MSG(extack, "ingress block dev insert =
failed");
> > +                     return err;
> > +             }
> > +
> > +             netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
> > +     }
> > +
> > +     if (tca[TCA_EGRESS_BLOCK]) {
> > +             cl =3D TC_H_MIN_EGRESS;
> > +             eg_block =3D cl_ops->tcf_block(sch, cl, NULL);
> > +             if (!eg_block) {
> > +                     NL_SET_ERR_MSG(extack, "Shared egress block missi=
ng");
> > +                     err =3D -EINVAL;
> > +                     goto err_out;
> > +             }
> > +
> > +             err =3D xa_insert(&eg_block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> > +             if (err) {
> > +                     netdev_put(dev, &sch->eg_block_tracker);
> > +                     NL_SET_ERR_MSG(extack, "Egress block dev insert f=
ailed");
> > +                     goto err_out;
> > +             }
> > +             netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> > +     }
> > +
> > +     return 0;
> > +err_out:
> > +     if (in_block) {
> > +             xa_erase(&in_block->ports, dev->ifindex);
> > +             netdev_put(dev, &sch->in_block_tracker);
> > +             NL_SET_ERR_MSG(extack, "ingress block dev insert failed")=
;
> > +     }
> > +     return err;
> > +}
> > +
> >  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **=
tca,
> >                                  struct netlink_ext_ack *extack)
> >  {
> > @@ -1270,7 +1335,7 @@ static struct Qdisc *qdisc_create(struct net_devi=
ce *dev,
> >       sch =3D qdisc_alloc(dev_queue, ops, extack);
> >       if (IS_ERR(sch)) {
> >               err =3D PTR_ERR(sch);
> > -             goto err_out2;
> > +             goto err_out1;
> >       }
> >
> >       sch->parent =3D parent;
> > @@ -1289,7 +1354,7 @@ static struct Qdisc *qdisc_create(struct net_devi=
ce *dev,
> >                       if (handle =3D=3D 0) {
> >                               NL_SET_ERR_MSG(extack, "Maximum number of=
 qdisc handles was exceeded");
> >                               err =3D -ENOSPC;
> > -                             goto err_out3;
> > +                             goto err_out2;
> >                       }
> >               }
> >               if (!netif_is_multiqueue(dev))
> > @@ -1311,7 +1376,7 @@ static struct Qdisc *qdisc_create(struct net_devi=
ce *dev,
> >
> >       err =3D qdisc_block_indexes_set(sch, tca, extack);
> >       if (err)
> > -             goto err_out3;
> > +             goto err_out2;
> >
> >       if (tca[TCA_STAB]) {
> >               stab =3D qdisc_get_stab(tca[TCA_STAB], extack);
> > @@ -1350,6 +1415,10 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >       qdisc_hash_add(sch, false);
> >       trace_qdisc_create(ops, dev, parent);
> >
> > +     err =3D qdisc_block_add_dev(sch, dev, tca, extack);
> > +     if (err)
> > +             goto err_out4;
> > +
> >       return sch;
> >
> >  err_out4:
> > @@ -1360,9 +1429,11 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >               ops->destroy(sch);
> >       qdisc_put_stab(rtnl_dereference(sch->stab));
> >  err_out3:
> > +     qdisc_block_undo_set(sch, tca);
>
> Is this a bugfix? This new call is for all sites that jump to
> err_out{3|4} even though you only added new code to the end of the
> function.

I guess it could be labelled as a "bug fix" - the existing code did
not "rewind" the block ID setting when you have attributes
TCA_EGRESS/INGRESS_BLOCK and the blockid is set and then something
later on fails down the codepath..
Maybe need to separate out this into a different patch or even send it
as a bug fix.

cheers,
jamal
> > +err_out2:
> >       netdev_put(dev, &sch->dev_tracker);
> >       qdisc_free(sch);
> > -err_out2:
> > +err_out1:
> >       module_put(ops->owner);
> >  err_out:
> >       *errp =3D err;
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 5d7e23f4cc0e..0fb51fd6f01e 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -1048,7 +1048,12 @@ static void qdisc_free_cb(struct rcu_head *head)
> >
> >  static void __qdisc_destroy(struct Qdisc *qdisc)
> >  {
> > -     const struct Qdisc_ops  *ops =3D qdisc->ops;
> > +     struct net_device *dev =3D qdisc_dev(qdisc);
> > +     const struct Qdisc_ops *ops =3D qdisc->ops;
> > +     const struct Qdisc_class_ops *cops;
> > +     struct tcf_block *block;
> > +     unsigned long cl;
> > +     u32 block_index;
> >
> >  #ifdef CONFIG_NET_SCHED
> >       qdisc_hash_del(qdisc);
> > @@ -1059,11 +1064,36 @@ static void __qdisc_destroy(struct Qdisc *qdisc=
)
> >
> >       qdisc_reset(qdisc);
> >
> > +     cops =3D ops->cl_ops;
> > +     if (ops->ingress_block_get) {
> > +             block_index =3D ops->ingress_block_get(qdisc);
> > +             if (block_index) {
> > +                     cl =3D TC_H_MIN_INGRESS;
> > +                     block =3D cops->tcf_block(qdisc, cl, NULL);
> > +                     if (block) {
> > +                             if (xa_erase(&block->ports, dev->ifindex)=
)
> > +                                     netdev_put(dev, &qdisc->in_block_=
tracker);
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (ops->egress_block_get) {
> > +             block_index =3D ops->egress_block_get(qdisc);
> > +             if (block_index) {
> > +                     cl =3D TC_H_MIN_EGRESS;
> > +                     block =3D cops->tcf_block(qdisc, cl, NULL);
> > +                     if (block) {
> > +                             if (xa_erase(&block->ports, dev->ifindex)=
)
> > +                                     netdev_put(dev, &qdisc->eg_block_=
tracker);
> > +                     }
> > +             }
> > +     }
> > +
> >       if (ops->destroy)
> >               ops->destroy(qdisc);
> >
> >       module_put(ops->owner);
> > -     netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
> > +     netdev_put(dev, &qdisc->dev_tracker);
> >
> >       trace_qdisc_destroy(qdisc);
>

