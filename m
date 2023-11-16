Return-Path: <netdev+bounces-48307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA87EDFEF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066EE1C2084C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105262E654;
	Thu, 16 Nov 2023 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrap0l7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109085
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:36:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-282ff1a97dcso509090a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700134569; x=1700739369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANo9zyxOtx5BIKUfarL5sMj5EFyIDyCvSVW0leCtQ+8=;
        b=Mrap0l7e2ssVCLwSjf6INd2WE3E3j7BtoeeqfzY3oK1kssAzsqyjCIi9A/xopdcHq1
         DZYRwvAd0L/D9B8P+oaqECRC4JhXYugWgjMXCBOt6WlbC+0Y+ze9IzafDS2Kp6TreSph
         rQq4iPOjARwf+o/pMoCXj77ppshSkGAAmK+jB0LOdP400YSou7rQzR/o4uR2ef8Tc5/N
         WicGxkl5Fq1lfjI1hEl+XtGS96S8EX0lu3Z+R2PEEgWGgyVRArHZAJawn4P9Kb2tLTae
         91EtIdUUuwIpUImVv2MA8En1jWeMYj/uOEoa9Q3V2Z0jrASYjzerRunjtl7SDcdatB2t
         af5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134569; x=1700739369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANo9zyxOtx5BIKUfarL5sMj5EFyIDyCvSVW0leCtQ+8=;
        b=hecCDOdvESztVhYQPr3M+sfsNjdOBmDE2FT9iZ2n6NeGdYvK7tsn068H4lCUeQWTGS
         6bY4DEueqWAr/ccnjlZeG9SGkbo3bZahPP5M3sf8bXg70ngNe+Dt2ql/3YYz/khjk5Me
         XyE2/BNBJ2pc5BS5OH+bWJkvYTxthfbtrGzl7pt3/+czBeETMnHiTih3TSiCsoHvtZym
         D6TEIQkfNRKX7sFzqFzu7Pi8WwyyfyEryj9tOSchJBBlwg8a5M0eC5FngFsyLRvKLbrC
         loZLCZpQSRoMdpU7fCyuuazp+XTOaLboItHp0tVjej+aZEaWnlOht1KzqAcnyIthTBCK
         oikg==
X-Gm-Message-State: AOJu0YyqgctMEPHNCeq/bh73zk9iTG8Z6nLB3Ia3SItD63d/t6hfMudT
	xTU1yQF447WrreRQs0SCr3Y=
X-Google-Smtp-Source: AGHT+IEw53RYxszSzkKmG1jd/oHPDlxhPT9wtgKhQfw+Ds/om4JqtP7xtzkajWlbt9ldUf3tV/TdmA==
X-Received: by 2002:a17:90b:3904:b0:274:8949:d834 with SMTP id ob4-20020a17090b390400b002748949d834mr10314565pjb.49.1700134569373;
        Thu, 16 Nov 2023 03:36:09 -0800 (PST)
Received: from t14s.localdomain ([2804:29b8:5086:6485:61b4:61a6:e9fe:e6ca])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090a9b0800b0026b12768e46sm1365504pjp.42.2023.11.16.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:36:08 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 38C207D6E74; Thu, 16 Nov 2023 08:36:06 -0300 (-03)
Date: Thu, 16 Nov 2023 08:36:06 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in
 act_ct
Message-ID: <ZVX+prlJ2EfB3kuF@t14s.localdomain>
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
 <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
 <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
 <CAM0EoMmMMMyxsktxCezjw-oePU-Lqsw2MMwMA5_hOLXiv5i4WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmMMMyxsktxCezjw-oePU-Lqsw2MMwMA5_hOLXiv5i4WA@mail.gmail.com>

On Wed, Nov 15, 2023 at 11:37:51AM -0500, Jamal Hadi Salim wrote:
> Hi Xin,
> 
> On Tue, Nov 14, 2023 at 10:18 AM Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Mon, Nov 13, 2023 at 4:37 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > >
> > > On Mon, Nov 13, 2023 at 12:53 PM Xin Long <lucien.xin@gmail.com> wrote:
> > > >
> > > > There is no hardware supporting ct helper offload. However, prior to this
> > > > patch, a flower filter with a helper in the ct action can be successfully
> > > > set into the HW, for example (eth1 is a bnxt NIC):
> > > >
> > > >   # tc qdisc add dev eth1 ingress_block 22 ingress
> > > >   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
> > > >     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
> > > >   # tc filter show dev eth1 ingress
> > > >
> > > >     filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
> > > >       eth_type ipv4
> > > >       ip_proto tcp
> > > >       dst_port 21
> > > >       ct_state -trk
> > > >       skip_sw
> > > >       in_hw in_hw_count 1   <----
> > > >         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
> > > >          index 2 ref 1 bind 1
> > > >         used_hw_stats delayed
> > > >
> > > > This might cause the flower filter not to work as expected in the HW.
> > > >
> > > > This patch avoids this problem by simply returning -EOPNOTSUPP in
> > > > tcf_ct_offload_act_setup() to not allow to offload flows with a helper
> > > > in act_ct.
> > > >
> > > > Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > >
> > > I didnt quite follow:
> > > The driver accepted the config, but the driver "kind of '' supports
> > > it. (enough to not complain and then display it when queried).
> > > Should the driver have rejected something it doesnt fully support?
> > Hi, Jamal,
> >
> > The sad thing is now it does not pass the 'helper' param to the HW in
> > tcf_ct_offload_act_setup() via struct flow_action_entry, in fact
> > flow_action_entry does not even have a member to keep 'helper'.
> >
> > Since no HW currently supports 'helper', we can stop it setting to HW
> > from here for now. In future, if HWs and struct flow_action_entry
> > support it, we can set it to the entry and reply on HWs to reject
> > it when not supported, as you mentioned above.
> 
> That makes sense - so i am wondering why that was ever added there to
> begin with. Would there be any hardware that would have any helper
> support? If no, Shouldnt that code be deleted altogether?

Not sure if I follow you, Jamal. There's no code at all to pass the
helper information down to the drivers. So drivers ended up accepting
this flow because they had no idea that a helper was attached to it.

Then yes, ideally, it should be driver the one to reject the flow that
it doesn't support. But as currently zero drivers support it, and I
doubt one will in the future [*], this patch simplifies it by instead
of adding all the helper stuff to flow_action_entry, to just abort the
offload earlier.

[*] it requires parsing TCP payload, including over packet boundaries.
This is very expensive in hw. And leads to another problem: the HW
having to tell the SW stack about new conntrack expectations.

Chers,
Marcelo

> 
> In any case, to the code correctness:
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> cheers,
> jamal
> > Thanks.
> > >
> > >
> > > cheers,
> > > jamal
> > >
> > > > ---
> > > >  include/net/tc_act/tc_ct.h | 9 +++++++++
> > > >  net/sched/act_ct.c         | 3 +++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> > > > index 8a6dbfb23336..77f87c622a2e 100644
> > > > --- a/include/net/tc_act/tc_ct.h
> > > > +++ b/include/net/tc_act/tc_ct.h
> > > > @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
> > > >         return to_ct_params(a)->nf_ft;
> > > >  }
> > > >
> > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
> > > > +{
> > > > +       return to_ct_params(a)->helper;
> > > > +}
> > > > +
> > > >  #else
> > > >  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return 0; }
> > > >  static inline int tcf_ct_action(const struct tc_action *a) { return 0; }
> > > > @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
> > > >  {
> > > >         return NULL;
> > > >  }
> > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
> > > > +{
> > > > +       return NULL;
> > > > +}
> > > >  #endif /* CONFIG_NF_CONNTRACK */
> > > >
> > > >  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > index 0db0ecf1d110..b3f4a503ee2b 100644
> > > > --- a/net/sched/act_ct.c
> > > > +++ b/net/sched/act_ct.c
> > > > @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_action *act, void *entry_data,
> > > >         if (bind) {
> > > >                 struct flow_action_entry *entry = entry_data;
> > > >
> > > > +               if (tcf_ct_helper(act))
> > > > +                       return -EOPNOTSUPP;
> > > > +
> > > >                 entry->id = FLOW_ACTION_CT;
> > > >                 entry->ct.action = tcf_ct_action(act);
> > > >                 entry->ct.zone = tcf_ct_zone(act);
> > > > --
> > > > 2.39.1
> > > >

