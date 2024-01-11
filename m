Return-Path: <netdev+bounces-63078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C212F82B1F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD83B1C2397F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C24B5B1;
	Thu, 11 Jan 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dX6k60Zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66A15ADE
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed788aad4so4756055276.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 07:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704987647; x=1705592447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBAh+OeCftZNwl1O3mEia62SmVZ/nCWsL1RCjpRC/N4=;
        b=dX6k60Zgt1irsYoVXILIFKJtZ6OqT5YGFhBKneVQOPs80eMzcPutKXXTkpRkryzasj
         M3/kxQgiBeNKijIjw9Rq978p15d6RMbwGEdBEyxtZczIYoVIRlazI+InoA8U7zAgQw+n
         NzsTyQSBG5W+vRX0UR61rSuG7LGmDPhOHf1AzLfA/Pr+U59FebYxYyoK0+yfv7x6euxQ
         fv5kHxEmJiXyasPN7psxPU9L4CkgS2vvLriXDsHHhfDge6phTp/PS1Ia/2vx5plDju+d
         dfGZT6c/aj5W+z74p8vKUd1hKYop6URKrVeTMu1H26/Bgq2f2aHIu/ErI/hadb+AOAAO
         Bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987647; x=1705592447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBAh+OeCftZNwl1O3mEia62SmVZ/nCWsL1RCjpRC/N4=;
        b=Zx59o8wbKBknWo1YsPiIMmhDQSf0y5zyh3WG/bLM0X8hS8S6Ls68UMAdwsXGXL28uY
         7M0XAxgey1cYg7hVXoxmY2kaIM68CrF+tmt3HZRoD+1QBcYMbAVgGqgV44Qy1dHNcT7b
         W6pkNx2Pftvbh6SEHLKI2+5FO7ehoImMBXUFxxYSdoQh9f3wKnMFDLu1kHbz/Ys1bpSm
         kt7bWQAqojxCctGQD7QWtWv38VB7JbvSX9A7kE/i/lEwCHGXsGdCY9J44lytpBrJNimW
         ysf/gND6eBC2WC6U1ZPhweMHaAaPtBgUtNnoL/vMTqzNmADz2oz2PADClM/e3lCpcOG/
         C0ng==
X-Gm-Message-State: AOJu0Yxs+ejNjQKdlaGvbM0oq9Fa1rLIRCJQFJ0oWngz+AG9D7XyInCi
	fJVYvk2TnE33bu3kh50Mo7pki7bG0iLnNOsvWhohuJ8kWHh+
X-Google-Smtp-Source: AGHT+IFukpakCplllp1olH3Mwz5rN9iPZ4WtNYSW+PKwUUbnF1FEKlDT/JpNli76uNj5NcGD7NpyFqjpNiwT5xZ54uM=
X-Received: by 2002:a05:6902:1d2:b0:dbd:45db:25cb with SMTP id
 u18-20020a05690201d200b00dbd45db25cbmr1314657ybh.97.1704987647567; Thu, 11
 Jan 2024 07:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <ZZ6JE0odnu1lLPtu@shredder>
In-Reply-To: <ZZ6JE0odnu1lLPtu@shredder>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 11 Jan 2024 10:40:36 -0500
Message-ID: <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index adf5de1ff773..253b26f2eddd 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block,=
 struct Qdisc *q,
> >                     struct tcf_block_ext_info *ei,
> >                     struct netlink_ext_ack *extack)
> >  {
> > +     struct net_device *dev =3D qdisc_dev(q);
> >       struct net *net =3D qdisc_net(q);
> >       struct tcf_block *block =3D NULL;
> >       int err;
> > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block=
, struct Qdisc *q,
> >       if (err)
> >               goto err_block_offload_bind;
> >
> > +     if (tcf_block_shared(block)) {
> > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> > +             if (err) {
> > +                     NL_SET_ERR_MSG(extack, "block dev insert failed")=
;
> > +                     goto err_dev_insert;
> > +             }
> > +     }
>
> While this patch fixes the original issue, it creates another one:
>
> # ip link add name swp1 type dummy
> # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 4 =
3 2 1
> # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 200=
000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop block =
10
> RED: set bandwidth to 10Mbit
> # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 500=
000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop block =
10
> RED: set bandwidth to 10Mbit
> Error: block dev insert failed.
>


+cc Petr
We'll add a testcase on tdc - it doesnt seem we have any for qevents.
If you have others that are related let us know.
But how does this work? I see no mention of block on red code and i
see no mention of block on the reproducer above.
Are the qevents exception packets from the hardware? Is there a good
description of what qevents do?

cheers,
jamal


> The reproducer does not fail if I revert this patch and apply Victor's
> [1] instead.
>
> [1] https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojatat=
u.com/
>
> > +
> >       *p_block =3D block;
> >       return 0;
> >
> > +err_dev_insert:
> >  err_block_offload_bind:
> >       tcf_chain0_head_change_cb_del(block, ei);
> >  err_chain0_head_change_cb_add:

