Return-Path: <netdev+bounces-63081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCAA82B200
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6821C23E72
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935D4CDFE;
	Thu, 11 Jan 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bktrPS2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A14CDE9
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e7c1012a42so51035617b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704987786; x=1705592586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTjFgccAG1R4jhsRXCYS9moekU/Ek7kX5/LGMNdyAv4=;
        b=bktrPS2ojcUjFEf5G17MXLB9x4LaU9Ou98YRoA28imkdHOBxdV3KyHJ2y2z1UkWJKL
         XGOETwZ/CGbwQ36fRwVbmK0t4Bv+T4UM5/ydzEaUpeuUfAUy8iTPUb/ht6gtfJUERoXr
         4kba4SgW5nbqXoZAzNbS3ZST+iWbnFmcNsFoGbu4DA0S+KqFKHesu1KhbY8JqCTVUltt
         6ado764NpcmB4Pt+dVHFOt5EAYn1IsVrqKi5oIl+YfhhCTprV3gkHumqSHJolKMaR3TX
         9kjkl7JJ4zybsOP4M9N+oz/vPE0UsIYCR7lPHAIP1aEvzt62siPHLMuqtGgXfA4Imfqr
         7Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987786; x=1705592586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTjFgccAG1R4jhsRXCYS9moekU/Ek7kX5/LGMNdyAv4=;
        b=NUcIxL2WwitoG8YO+MDx4Mcjx/MpYxXg42Jt66ag97kiTL5laijHEe/5mJCgOHAmft
         1cI/HrCYbmdfjDBgg/XbPbWaPEsoGbtWxN1jafzxTLIjDSIXRmNrfABK7kCk1hXEmvhu
         VAjd6I82KhXdIA9STiuTmkAl5jp0fmDo9XM9e7/13O/QNEU5ov7kYxkS7g4V5qslaJNo
         dHGEVA6eFB8abTN4A2KC7jvN7jSuhsU1k0pM4FAgU+UEmEFCW7XRivKXMqjHZnq8Flmu
         12yCUjPuEgLAgOdkk6W+gIgzJdHHErNxMA9c4PblV92tqyyJbcPhu+ihfMbVFYsC455i
         iUiQ==
X-Gm-Message-State: AOJu0YwqsGi1/ACPhKMohsiocT7cKf7X6Lw9n+bpWXMloyTkCY6t9/Ls
	Pn9TXGyAkY+C7mVvgHYPx8/7/OnxKFDy287H43OIWC2dbmni
X-Google-Smtp-Source: AGHT+IHk1lbzR/+Yz8+K/nkQHs2vJlOSey0umJugJ9W9hJDiJPq/RvCt0pdiXOwRcEU+pN7Po506+1l/gQqxcLq2FfI=
X-Received: by 2002:a05:690c:a9d:b0:5e4:f0b6:6235 with SMTP id
 ci29-20020a05690c0a9d00b005e4f0b66235mr972603ywb.26.1704987786420; Thu, 11
 Jan 2024 07:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
In-Reply-To: <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 11 Jan 2024 10:42:55 -0500
Message-ID: <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch.org> =
wrote:
> >
> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > > index adf5de1ff773..253b26f2eddd 100644
> > > --- a/net/sched/cls_api.c
> > > +++ b/net/sched/cls_api.c
> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_bloc=
k, struct Qdisc *q,
> > >                     struct tcf_block_ext_info *ei,
> > >                     struct netlink_ext_ack *extack)
> > >  {
> > > +     struct net_device *dev =3D qdisc_dev(q);
> > >       struct net *net =3D qdisc_net(q);
> > >       struct tcf_block *block =3D NULL;
> > >       int err;
> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_blo=
ck, struct Qdisc *q,
> > >       if (err)
> > >               goto err_block_offload_bind;
> > >
> > > +     if (tcf_block_shared(block)) {
> > > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP=
_KERNEL);
> > > +             if (err) {
> > > +                     NL_SET_ERR_MSG(extack, "block dev insert failed=
");
> > > +                     goto err_dev_insert;
> > > +             }
> > > +     }
> >
> > While this patch fixes the original issue, it creates another one:
> >
> > # ip link add name swp1 type dummy
> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 =
4 3 2 1
> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 2=
00000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop bloc=
k 10
> > RED: set bandwidth to 10Mbit
> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 5=
00000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop bloc=
k 10
> > RED: set bandwidth to 10Mbit
> > Error: block dev insert failed.
> >
>
>
> +cc Petr
> We'll add a testcase on tdc - it doesnt seem we have any for qevents.
> If you have others that are related let us know.
> But how does this work? I see no mention of block on red code and i
> see no mention of block on the reproducer above.

Context: Yes, i see it on red setup but i dont see any block being setup.
Also: Is it only Red or other qdiscs could behave this way?

cheers,
jamal
> Are the qevents exception packets from the hardware? Is there a good
> description of what qevents do?
>
> cheers,
> jamal
>
>
> > The reproducer does not fail if I revert this patch and apply Victor's
> > [1] instead.
> >
> > [1] https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojat=
atu.com/
> >
> > > +
> > >       *p_block =3D block;
> > >       return 0;
> > >
> > > +err_dev_insert:
> > >  err_block_offload_bind:
> > >       tcf_chain0_head_change_cb_del(block, ei);
> > >  err_chain0_head_change_cb_add:

