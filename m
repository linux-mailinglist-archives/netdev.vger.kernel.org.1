Return-Path: <netdev+bounces-48108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D07EC8B1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF1A1C2096E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77824A06;
	Wed, 15 Nov 2023 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G9061NKM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0E3309D
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 16:38:05 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89248E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:38:03 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so932295276.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700066283; x=1700671083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gJBRyk7arFQYKg1+qieXGjO+97XC1UZxyNfAiaaezo=;
        b=G9061NKM+WcpqIMX2avHSj2kLpOr6f5wT6by3p2pqGPk6fPQNaYXZiukUDyVdhD7TC
         /UXnBzjT1i2wTBJZH+A5R+SrTUJrjTCQYkHr/ZD0riJsKlQUnBXWDOh9i5Ld/Mf5VEmr
         iPO4D/nvhTqy803O9G3t5/p1mqvU4TZL2jkKOhDXHZ54QQpTdJ26kdKxpzrU7VQZ2b27
         DdtGNZyzD4Vu6YU2LqV4KQ8BaKD9WKFZqsEXbxNuC0zIGb3y7XD84h4btyUp/JDGg5N8
         W1vjV1oMEGtBy+3RXkWnbXMZk8vh3OTbTkcNUCP5bcR37IIO7t2paLvdgEy40eIQxTU5
         EeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066283; x=1700671083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gJBRyk7arFQYKg1+qieXGjO+97XC1UZxyNfAiaaezo=;
        b=MIgSRwVvKe9qdae1K0vS5p2V1s+6sHjZez0M7e2rgFyP36gb/nm/pvDVYo1seGuq1u
         PCgCe5YGZ+PTU9ynJ1cGkt5nIgqaCGeW7ZLvBM2Zta69/vbMkMUDOUW9sozzf6W8e85D
         Jw4S7FF8cdHxkY7uOvXVU4IQXFd6rCsqXeGzgFuDekR4QK5RJZmo//Kf00FIceDe9lUA
         uMJixzaqwNI2BXBskc2wN1uYp616aRyhrZe7sRzZbUCLOe3JJtXsAAdGC5+XjDAIennA
         Lt16jFWBRc4bxrgDXZCc8BxnXqF5tlnoAm1bbaD6UyWYARHKjGlqEVbw/oOpO9IqyAr7
         GP4A==
X-Gm-Message-State: AOJu0YwoPBJ/f6VO7+4n6lJjVM0ZSE1j+gWQzhCseRLSadvkIUuDfYlz
	pLkwbogqUo+t3rdH2oX4truRkkStkGwfZGYp8LlHWA==
X-Google-Smtp-Source: AGHT+IGQrRyxaA6bjG+u6gGMjSitrzP6VdABCfKxQRKNQt5q3EWvYHvo9ZQnkdkCe2+2e2KW66vVpGjpRJmKgPyeaQg=
X-Received: by 2002:a25:b345:0:b0:daf:627f:9988 with SMTP id
 k5-20020a25b345000000b00daf627f9988mr4957323ybg.7.1700066283106; Wed, 15 Nov
 2023 08:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
 <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com> <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
In-Reply-To: <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Nov 2023 11:37:51 -0500
Message-ID: <CAM0EoMmMMMyxsktxCezjw-oePU-Lqsw2MMwMA5_hOLXiv5i4WA@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in act_ct
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xin,

On Tue, Nov 14, 2023 at 10:18=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Mon, Nov 13, 2023 at 4:37=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Nov 13, 2023 at 12:53=E2=80=AFPM Xin Long <lucien.xin@gmail.com=
> wrote:
> > >
> > > There is no hardware supporting ct helper offload. However, prior to =
this
> > > patch, a flower filter with a helper in the ct action can be successf=
ully
> > > set into the HW, for example (eth1 is a bnxt NIC):
> > >
> > >   # tc qdisc add dev eth1 ingress_block 22 ingress
> > >   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
> > >     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
> > >   # tc filter show dev eth1 ingress
> > >
> > >     filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
> > >       eth_type ipv4
> > >       ip_proto tcp
> > >       dst_port 21
> > >       ct_state -trk
> > >       skip_sw
> > >       in_hw in_hw_count 1   <----
> > >         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
> > >          index 2 ref 1 bind 1
> > >         used_hw_stats delayed
> > >
> > > This might cause the flower filter not to work as expected in the HW.
> > >
> > > This patch avoids this problem by simply returning -EOPNOTSUPP in
> > > tcf_ct_offload_act_setup() to not allow to offload flows with a helpe=
r
> > > in act_ct.
> > >
> > > Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >
> > I didnt quite follow:
> > The driver accepted the config, but the driver "kind of '' supports
> > it. (enough to not complain and then display it when queried).
> > Should the driver have rejected something it doesnt fully support?
> Hi, Jamal,
>
> The sad thing is now it does not pass the 'helper' param to the HW in
> tcf_ct_offload_act_setup() via struct flow_action_entry, in fact
> flow_action_entry does not even have a member to keep 'helper'.
>
> Since no HW currently supports 'helper', we can stop it setting to HW
> from here for now. In future, if HWs and struct flow_action_entry
> support it, we can set it to the entry and reply on HWs to reject
> it when not supported, as you mentioned above.

That makes sense - so i am wondering why that was ever added there to
begin with. Would there be any hardware that would have any helper
support? If no, Shouldnt that code be deleted altogether?

In any case, to the code correctness:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> Thanks.
> >
> >
> > cheers,
> > jamal
> >
> > > ---
> > >  include/net/tc_act/tc_ct.h | 9 +++++++++
> > >  net/sched/act_ct.c         | 3 +++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> > > index 8a6dbfb23336..77f87c622a2e 100644
> > > --- a/include/net/tc_act/tc_ct.h
> > > +++ b/include/net/tc_act/tc_ct.h
> > > @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const=
 struct tc_action *a)
> > >         return to_ct_params(a)->nf_ft;
> > >  }
> > >
> > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct=
 tc_action *a)
> > > +{
> > > +       return to_ct_params(a)->helper;
> > > +}
> > > +
> > >  #else
> > >  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { retu=
rn 0; }
> > >  static inline int tcf_ct_action(const struct tc_action *a) { return =
0; }
> > > @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const=
 struct tc_action *a)
> > >  {
> > >         return NULL;
> > >  }
> > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct=
 tc_action *a)
> > > +{
> > > +       return NULL;
> > > +}
> > >  #endif /* CONFIG_NF_CONNTRACK */
> > >
> > >  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > index 0db0ecf1d110..b3f4a503ee2b 100644
> > > --- a/net/sched/act_ct.c
> > > +++ b/net/sched/act_ct.c
> > > @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_a=
ction *act, void *entry_data,
> > >         if (bind) {
> > >                 struct flow_action_entry *entry =3D entry_data;
> > >
> > > +               if (tcf_ct_helper(act))
> > > +                       return -EOPNOTSUPP;
> > > +
> > >                 entry->id =3D FLOW_ACTION_CT;
> > >                 entry->ct.action =3D tcf_ct_action(act);
> > >                 entry->ct.zone =3D tcf_ct_zone(act);
> > > --
> > > 2.39.1
> > >

