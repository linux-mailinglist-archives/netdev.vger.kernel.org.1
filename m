Return-Path: <netdev+bounces-48420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35467EE469
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB31F22D56
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22810358A5;
	Thu, 16 Nov 2023 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pVeKY0lE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2D2127
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:29:51 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a87ac9d245so10509977b3.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700148590; x=1700753390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKiqozhKbUACM4wOnociWaUHNpXxfzgPkJ66kCbAsYs=;
        b=pVeKY0lEy4eDh4LM6TqtYXsobSl2IxRj97lk3dS9GRwK91lbEwnKg0p1WLu4aoIHwo
         Fs7U1gv3esKjwCJPlc+OQ4lVWvElTOJOvqyD0avgZYKISXFkYUBwLIiRRaiecXBB+sVH
         SkVj2rk37UFA5uOVejh8ERGDpmJhJ3CXCAWpVD2iWVE3vZnf2WQFBdSoW+K3LWGSVXE0
         um9QTYjs85zOl+Y79W+6+OxYbU4TAUxsMQCYkPjoGjcZVllWMtzxvFDIOkI2TiSVCMdY
         npI081Ldo90lm0ju39Fj+QfduvyGadpWgt1XkIFyEWrzd4fpMRpI/t7JJv8fKL0mXq29
         EJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700148590; x=1700753390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKiqozhKbUACM4wOnociWaUHNpXxfzgPkJ66kCbAsYs=;
        b=dIrR/ihwd841bpQ+jwwhWYeREnyl8sHcnb4xXHvobQtXq2yi6JyKuyvnC35Z7cMgpq
         VhYZWPHg1R2G5zViGiBscSTfSwO/Xf+QW89/quSOfnb47ojSAFxNSExtwtuh77k17qHt
         yZS7KcU5H/bt2u1yjNoGujbDERx8X5WMFKhgRdW0Wzc2gT12AXTGLzbq4A/pmMG6uick
         10OlNfCFIU5UJW/N+XQ22KLyu8Lz/xmz0q2t8azzu/5e7dGrs1Zfrzukxw3sCQ4z2Y22
         NlRtnBd0/4b32jvi1jpHCBZt7RL7Y7LPj0Lh9RKD3+J6u+kn4+QeGac5YX+6Up8b9nu9
         00yA==
X-Gm-Message-State: AOJu0YxiGgh4aQkBl2XvgPqErX9D5yuIhXTu9Qvq141+arxRglRH4dX7
	BZBQXCGMbwOn1AcFUvdYeiIsjea0EFb44Zb7ftVAMg==
X-Google-Smtp-Source: AGHT+IF54TMSUIHzcb+npXq+vlh9d73RrCmH+OgkSmuVbkFRmR8b3q9DctESoBSCTAXClrB2GEJ7ClHSQWqdq8x9Jyk=
X-Received: by 2002:a0d:d9c8:0:b0:589:b3c6:95ff with SMTP id
 b191-20020a0dd9c8000000b00589b3c695ffmr18091329ywe.36.1700148590284; Thu, 16
 Nov 2023 07:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
 <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
 <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
 <CAM0EoMmMMMyxsktxCezjw-oePU-Lqsw2MMwMA5_hOLXiv5i4WA@mail.gmail.com> <ZVX+prlJ2EfB3kuF@t14s.localdomain>
In-Reply-To: <ZVX+prlJ2EfB3kuF@t14s.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Nov 2023 10:29:39 -0500
Message-ID: <CAM0EoMkue6_7G-_BWEDbjuEYPfjSCXdnmvMsEG+QUWAfJNoz4A@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in act_ct
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

On Thu, Nov 16, 2023 at 6:36=E2=80=AFAM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, Nov 15, 2023 at 11:37:51AM -0500, Jamal Hadi Salim wrote:
> > Hi Xin,
> >
> > On Tue, Nov 14, 2023 at 10:18=E2=80=AFAM Xin Long <lucien.xin@gmail.com=
> wrote:
> > >
> > > On Mon, Nov 13, 2023 at 4:37=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Mon, Nov 13, 2023 at 12:53=E2=80=AFPM Xin Long <lucien.xin@gmail=
.com> wrote:
> > > > >
> > > > > There is no hardware supporting ct helper offload. However, prior=
 to this
> > > > > patch, a flower filter with a helper in the ct action can be succ=
essfully
> > > > > set into the HW, for example (eth1 is a bnxt NIC):
> > > > >
> > > > >   # tc qdisc add dev eth1 ingress_block 22 ingress
> > > > >   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
> > > > >     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
> > > > >   # tc filter show dev eth1 ingress
> > > > >
> > > > >     filter block 22 protocol ip pref 49152 flower chain 0 handle =
0x1
> > > > >       eth_type ipv4
> > > > >       ip_proto tcp
> > > > >       dst_port 21
> > > > >       ct_state -trk
> > > > >       skip_sw
> > > > >       in_hw in_hw_count 1   <----
> > > > >         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
> > > > >          index 2 ref 1 bind 1
> > > > >         used_hw_stats delayed
> > > > >
> > > > > This might cause the flower filter not to work as expected in the=
 HW.
> > > > >
> > > > > This patch avoids this problem by simply returning -EOPNOTSUPP in
> > > > > tcf_ct_offload_act_setup() to not allow to offload flows with a h=
elper
> > > > > in act_ct.
> > > > >
> > > > > Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> > > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > >
> > > > I didnt quite follow:
> > > > The driver accepted the config, but the driver "kind of '' supports
> > > > it. (enough to not complain and then display it when queried).
> > > > Should the driver have rejected something it doesnt fully support?
> > > Hi, Jamal,
> > >
> > > The sad thing is now it does not pass the 'helper' param to the HW in
> > > tcf_ct_offload_act_setup() via struct flow_action_entry, in fact
> > > flow_action_entry does not even have a member to keep 'helper'.
> > >
> > > Since no HW currently supports 'helper', we can stop it setting to HW
> > > from here for now. In future, if HWs and struct flow_action_entry
> > > support it, we can set it to the entry and reply on HWs to reject
> > > it when not supported, as you mentioned above.
> >
> > That makes sense - so i am wondering why that was ever added there to
> > begin with. Would there be any hardware that would have any helper
> > support? If no, Shouldnt that code be deleted altogether?
>
> Not sure if I follow you, Jamal. There's no code at all to pass the
> helper information down to the drivers. So drivers ended up accepting
> this flow because they had no idea that a helper was attached to it.
>

So is the goal:
a) if there's a helper it doesnt make sense to offload the flow or
b) if there's a helper then it(the helper) works in s/w only but the
flow offload is still legit?

If it is #a then my question was why is that code even there in the
offload path...
Likely i am missing something..

cheers,
jamal

> Then yes, ideally, it should be driver the one to reject the flow that
> it doesn't support. But as currently zero drivers support it, and I
> doubt one will in the future [*], this patch simplifies it by instead
> of adding all the helper stuff to flow_action_entry, to just abort the
> offload earlier.
>
> [*] it requires parsing TCP payload, including over packet boundaries.
> This is very expensive in hw. And leads to another problem: the HW
> having to tell the SW stack about new conntrack expectations.
>


> Chers,
> Marcelo
>
> >
> > In any case, to the code correctness:
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > cheers,
> > jamal
> > > Thanks.
> > > >
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > > > ---
> > > > >  include/net/tc_act/tc_ct.h | 9 +++++++++
> > > > >  net/sched/act_ct.c         | 3 +++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_c=
t.h
> > > > > index 8a6dbfb23336..77f87c622a2e 100644
> > > > > --- a/include/net/tc_act/tc_ct.h
> > > > > +++ b/include/net/tc_act/tc_ct.h
> > > > > @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(c=
onst struct tc_action *a)
> > > > >         return to_ct_params(a)->nf_ft;
> > > > >  }
> > > > >
> > > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const st=
ruct tc_action *a)
> > > > > +{
> > > > > +       return to_ct_params(a)->helper;
> > > > > +}
> > > > > +
> > > > >  #else
> > > > >  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { =
return 0; }
> > > > >  static inline int tcf_ct_action(const struct tc_action *a) { ret=
urn 0; }
> > > > > @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(c=
onst struct tc_action *a)
> > > > >  {
> > > > >         return NULL;
> > > > >  }
> > > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const st=
ruct tc_action *a)
> > > > > +{
> > > > > +       return NULL;
> > > > > +}
> > > > >  #endif /* CONFIG_NF_CONNTRACK */
> > > > >
> > > > >  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> > > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > > index 0db0ecf1d110..b3f4a503ee2b 100644
> > > > > --- a/net/sched/act_ct.c
> > > > > +++ b/net/sched/act_ct.c
> > > > > @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct =
tc_action *act, void *entry_data,
> > > > >         if (bind) {
> > > > >                 struct flow_action_entry *entry =3D entry_data;
> > > > >
> > > > > +               if (tcf_ct_helper(act))
> > > > > +                       return -EOPNOTSUPP;
> > > > > +
> > > > >                 entry->id =3D FLOW_ACTION_CT;
> > > > >                 entry->ct.action =3D tcf_ct_action(act);
> > > > >                 entry->ct.zone =3D tcf_ct_zone(act);
> > > > > --
> > > > > 2.39.1
> > > > >

