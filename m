Return-Path: <netdev+bounces-61599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E18245DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AD287007
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAB23750;
	Thu,  4 Jan 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="a9Vf4gwi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A124A01
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7bb1e0db8so5853077b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704384670; x=1704989470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qibsO5cShZMxXtS9+wVtzxmnZXgZucrE87rrjzzYyxc=;
        b=a9Vf4gwiYVIjeulG52KDcTFmJ40GvjZbJruLAWapRJQryBPyM8sUl8mHqUmlAbmcnB
         C4iIemmuE0mxNOgt2g7JoQDFEQBzcdQb6xJmKTDUJHRFaEdQT5/2GAq4iOvocNGTuJ6f
         23tvdJwl//gGHtOhWUhKQp/QYhaIfeu+HxmgJi/x09qJSpeA2jenJhfWrBd1xL89poiW
         0HBVckdXAWosPgR2aBa9UoH4B+8V0VncZbN1B9bzR1ftG48aazC0WpxuDfqzzcw9Jjmc
         i2q7EDaDy7sFSqUic3fDTUm2cVI1JYHip4uvCcSPbVJp/rtLMrGm8NtJ/MyUzt2CuIAd
         k6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384670; x=1704989470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qibsO5cShZMxXtS9+wVtzxmnZXgZucrE87rrjzzYyxc=;
        b=xHO0MVBZ5mXDh7DIvU3mUQi8GfUla7P31JDDriFzfzSHORKY2rmD610WDaAqA5LS4K
         XGM6v3FFCC9bGiNSqEJLBXAwQMQlljf8xNr+AQvwnZyEskRpdAyC5P7GRS8ppFuXfSUd
         LMcThcoE9qxQriAtmkgKUsVCBIvGdqoCHoyHKnKhDZq43QvXG6InWE8z1w23j3oxN7KD
         wNV2wiV3ZQjcyzzNWd12v2Y/GHRpm4b2KGK9x0VqWp1Fvdu+q6YYBciBpsZB8hJ6f86z
         X/MjGwjKRnkXrmOL770ryhk+xBa9k34kpb3UxHJ6cq6PcCtZfmsPB4sEEPPHC2RmidgI
         ehJA==
X-Gm-Message-State: AOJu0Yz/NRDJi5PQBnYeB1LVUqA5HQDSHzWKhZGlXJfzpmi4AqnKQ37T
	310t2W0qvQ/IMR+43vKUenrNQ2mMACNLLYpx15kTA6Kv7rAy
X-Google-Smtp-Source: AGHT+IFNy2BF/iZwlEImnVnhMEawnouHXivAWtynndI3k/hjbxCHcApcoCEn2YTRuN+EVGRYS9N6yCtLoGqSkXmHVUA=
X-Received: by 2002:a81:df08:0:b0:5e7:8eea:b7e2 with SMTP id
 c8-20020a81df08000000b005e78eeab7e2mr696404ywn.101.1704384669889; Thu, 04 Jan
 2024 08:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us>
In-Reply-To: <20240104125844.1522062-1-jiri@resnulli.us>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jan 2024 11:10:58 -0500
Message-ID: <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, idosch@idosch.org, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 7:58=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Inserting the device to block xarray in qdisc_create() is not suitable
> place to do this. As it requires use of tcf_block() callback, it causes
> multiple issues. It is called for all qdisc types, which is incorrect.
>
> So, instead, move it to more suitable place, which is tcf_block_get_ext()
> and make sure it is only done for qdiscs that use block infrastructure
> and also only for blocks which are shared.
>
> Symmetrically, alter the cleanup path, move the xarray entry removal
> into tcf_block_put_ext().
>
> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra=
")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@=
gmail.com/
> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.c=
om/
> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.c=
om/
> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.c=
om/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Did you get a chance to run the tdc tests?

cheers,
jamal

> ---
>  net/sched/cls_api.c     | 14 ++++++++++++++
>  net/sched/sch_api.c     | 41 -----------------------------------------
>  net/sched/sch_generic.c | 14 --------------
>  3 files changed, 14 insertions(+), 55 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index adf5de1ff773..253b26f2eddd 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, s=
truct Qdisc *q,
>                       struct tcf_block_ext_info *ei,
>                       struct netlink_ext_ack *extack)
>  {
> +       struct net_device *dev =3D qdisc_dev(q);
>         struct net *net =3D qdisc_net(q);
>         struct tcf_block *block =3D NULL;
>         int err;
> @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, =
struct Qdisc *q,
>         if (err)
>                 goto err_block_offload_bind;
>
> +       if (tcf_block_shared(block)) {
> +               err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> +               if (err) {
> +                       NL_SET_ERR_MSG(extack, "block dev insert failed")=
;
> +                       goto err_dev_insert;
> +               }
> +       }
> +
>         *p_block =3D block;
>         return 0;
>
> +err_dev_insert:
>  err_block_offload_bind:
>         tcf_chain0_head_change_cb_del(block, ei);
>  err_chain0_head_change_cb_add:
> @@ -1502,8 +1512,12 @@ EXPORT_SYMBOL(tcf_block_get);
>  void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
>                        struct tcf_block_ext_info *ei)
>  {
> +       struct net_device *dev =3D qdisc_dev(q);
> +
>         if (!block)
>                 return;
> +       if (tcf_block_shared(block))
> +               xa_erase(&block->ports, dev->ifindex);
>         tcf_chain0_head_change_cb_del(block, ei);
>         tcf_block_owner_del(block, q, ei->binder_type);
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 2a2a48838eb9..36b025cc4fd2 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1209,43 +1209,6 @@ static int qdisc_graft(struct net_device *dev, str=
uct Qdisc *parent,
>         return 0;
>  }
>
> -static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev=
,
> -                              struct netlink_ext_ack *extack)
> -{
> -       const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> -       struct tcf_block *block;
> -       int err;
> -
> -       block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> -       if (block) {
> -               err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> -               if (err) {
> -                       NL_SET_ERR_MSG(extack,
> -                                      "ingress block dev insert failed")=
;
> -                       return err;
> -               }
> -       }
> -
> -       block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> -       if (block) {
> -               err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> -               if (err) {
> -                       NL_SET_ERR_MSG(extack,
> -                                      "Egress block dev insert failed");
> -                       goto err_out;
> -               }
> -       }
> -
> -       return 0;
> -
> -err_out:
> -       block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> -       if (block)
> -               xa_erase(&block->ports, dev->ifindex);
> -
> -       return err;
> -}
> -
>  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tc=
a,
>                                    struct netlink_ext_ack *extack)
>  {
> @@ -1416,10 +1379,6 @@ static struct Qdisc *qdisc_create(struct net_devic=
e *dev,
>         qdisc_hash_add(sch, false);
>         trace_qdisc_create(ops, dev, parent);
>
> -       err =3D qdisc_block_add_dev(sch, dev, extack);
> -       if (err)
> -               goto err_out4;
> -
>         return sch;
>
>  err_out4:
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index e33568df97a5..9b3e9262040b 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1052,8 +1052,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>  {
>         const struct Qdisc_ops  *ops =3D qdisc->ops;
>         struct net_device *dev =3D qdisc_dev(qdisc);
> -       const struct Qdisc_class_ops *cops;
> -       struct tcf_block *block;
>
>  #ifdef CONFIG_NET_SCHED
>         qdisc_hash_del(qdisc);
> @@ -1064,18 +1062,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>
>         qdisc_reset(qdisc);
>
> -       cops =3D ops->cl_ops;
> -       if (ops->ingress_block_get) {
> -               block =3D cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
> -               if (block)
> -                       xa_erase(&block->ports, dev->ifindex);
> -       }
> -
> -       if (ops->egress_block_get) {
> -               block =3D cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
> -               if (block)
> -                       xa_erase(&block->ports, dev->ifindex);
> -       }
>
>         if (ops->destroy)
>                 ops->destroy(qdisc);
> --
> 2.43.0
>

