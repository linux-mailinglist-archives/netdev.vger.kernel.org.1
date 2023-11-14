Return-Path: <netdev+bounces-47751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473887EB34A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9003CB20979
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0D4123E;
	Tue, 14 Nov 2023 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6OjRj1g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7141232
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 15:18:56 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2911A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:18:55 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a877e0f0d8so55022837b3.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699975134; x=1700579934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFMtVfjSVKYek9GbyHaLtk0arn2EeaHiVxhV6llbIKc=;
        b=F6OjRj1g4PruKI6VCqO/c11/noyp0yhPxubApKZBRCCjYBjQsiC6Btvzb1zuzY6+Gu
         B+ty8b4de2MPpGfSUmyAtwaeV04MGSuwOWW9XZBpdCU0mzcabGuV9BltRvzsCpdvrw8T
         Xb2RIe16dvB9yLap1E7GksrDa07xMg9V/7kBJqsleCVvA4kDztbez/adAP5HTMbL3tZZ
         9RF13VP9UieGxlka/A8E3KKtf5HNVLdIExzz9mGBqFEcBKNzWExHBo6W1kMURSZJEkS2
         a/MKD2lbN/SHxj11qD3HixdlSTbHhfGzquWZRJxlATkbzV9dWiia52Rgx4VzU5BeVPZC
         QX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975134; x=1700579934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFMtVfjSVKYek9GbyHaLtk0arn2EeaHiVxhV6llbIKc=;
        b=T7Ahs7sObsoFpZVSTAjQ4mOqvkXKVuL6t/5YRpiQKK2qV0aDinGUIu1rIftA5pTCu2
         BeaTXGV/zrcHuNZkJ+zKxm4me+KwcUbl0pQKY8H3Hb78BQ40hJBypnM4nKGBbXlXaCZb
         XlT1iGm8t3pqFz+eFlHQ18OkWwkZ6x6gKPwfyz7dqECjCXuA2G7nzaX+ukFxGLH0HEFr
         +Exr1OZJVbNA1rzTTtXpVvxaFxtzsSQSGqnL9LSv2b5jgCTrfhkzRC7c8qTIlJGW8r6N
         dSf4TphZVKKtLtzt3gusaZljYDplENILuGK4glKiWzFB7NK5bRN8ejxSRmqhElurz/Kv
         pZnw==
X-Gm-Message-State: AOJu0YzZm53F4BgyW0MQE5yhl/537juPEUA2S65Fo0ulOqaxQafNID4X
	wgcyqmV8oUKN+Pk2IBflBEHCdb83Dlhcw7RpBUk=
X-Google-Smtp-Source: AGHT+IGLxCRujw0Ul1s24ilZdnQIK2+sQIDvZk/+OTLdXQompO0S3tuqyVG7maBUFhkCW2pIxYVTWWBmyM8CWgbQLYY=
X-Received: by 2002:a25:ab25:0:b0:db0:bc3:e21a with SMTP id
 u34-20020a25ab25000000b00db00bc3e21amr1037977ybi.5.1699975133809; Tue, 14 Nov
 2023 07:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
 <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
In-Reply-To: <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 14 Nov 2023 10:18:42 -0500
Message-ID: <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in act_ct
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 4:37=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Nov 13, 2023 at 12:53=E2=80=AFPM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > There is no hardware supporting ct helper offload. However, prior to th=
is
> > patch, a flower filter with a helper in the ct action can be successful=
ly
> > set into the HW, for example (eth1 is a bnxt NIC):
> >
> >   # tc qdisc add dev eth1 ingress_block 22 ingress
> >   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
> >     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
> >   # tc filter show dev eth1 ingress
> >
> >     filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
> >       eth_type ipv4
> >       ip_proto tcp
> >       dst_port 21
> >       ct_state -trk
> >       skip_sw
> >       in_hw in_hw_count 1   <----
> >         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
> >          index 2 ref 1 bind 1
> >         used_hw_stats delayed
> >
> > This might cause the flower filter not to work as expected in the HW.
> >
> > This patch avoids this problem by simply returning -EOPNOTSUPP in
> > tcf_ct_offload_act_setup() to not allow to offload flows with a helper
> > in act_ct.
> >
> > Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
>
> I didnt quite follow:
> The driver accepted the config, but the driver "kind of '' supports
> it. (enough to not complain and then display it when queried).
> Should the driver have rejected something it doesnt fully support?
Hi, Jamal,

The sad thing is now it does not pass the 'helper' param to the HW in
tcf_ct_offload_act_setup() via struct flow_action_entry, in fact
flow_action_entry does not even have a member to keep 'helper'.

Since no HW currently supports 'helper', we can stop it setting to HW
from here for now. In future, if HWs and struct flow_action_entry
support it, we can set it to the entry and reply on HWs to reject
it when not supported, as you mentioned above.

Thanks.
>
>
> cheers,
> jamal
>
> > ---
> >  include/net/tc_act/tc_ct.h | 9 +++++++++
> >  net/sched/act_ct.c         | 3 +++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> > index 8a6dbfb23336..77f87c622a2e 100644
> > --- a/include/net/tc_act/tc_ct.h
> > +++ b/include/net/tc_act/tc_ct.h
> > @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const s=
truct tc_action *a)
> >         return to_ct_params(a)->nf_ft;
> >  }
> >
> > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct t=
c_action *a)
> > +{
> > +       return to_ct_params(a)->helper;
> > +}
> > +
> >  #else
> >  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return=
 0; }
> >  static inline int tcf_ct_action(const struct tc_action *a) { return 0;=
 }
> > @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const s=
truct tc_action *a)
> >  {
> >         return NULL;
> >  }
> > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct t=
c_action *a)
> > +{
> > +       return NULL;
> > +}
> >  #endif /* CONFIG_NF_CONNTRACK */
> >
> >  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 0db0ecf1d110..b3f4a503ee2b 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_act=
ion *act, void *entry_data,
> >         if (bind) {
> >                 struct flow_action_entry *entry =3D entry_data;
> >
> > +               if (tcf_ct_helper(act))
> > +                       return -EOPNOTSUPP;
> > +
> >                 entry->id =3D FLOW_ACTION_CT;
> >                 entry->ct.action =3D tcf_ct_action(act);
> >                 entry->ct.zone =3D tcf_ct_zone(act);
> > --
> > 2.39.1
> >

