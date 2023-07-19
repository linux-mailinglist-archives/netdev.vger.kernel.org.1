Return-Path: <netdev+bounces-19055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C5759721
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4BD280C37
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13813FF3;
	Wed, 19 Jul 2023 13:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F613FF0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:27:06 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F504FD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:27:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso674861cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689773223; x=1690378023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJP6IP6O34QOQC7Sgrsf1pjEzxOndOPTdn+h4xkI3pU=;
        b=jqK6J/t/LiXQz66d6QGLPAbrXGYv0VKNcFeCXs8L7TT9Zc5zte+DosvkqoeMOUH3aD
         BdqGZsFSObwcQXkir5AR8RVGnCOF/m90DzK7ats2o3AYPy8IGXLJEbgJm6zb0vvOOQg6
         W9DURS8xYUyPE7YsKYbvdS8coIaaQT05WC1oulLRw6CNzALLrAuNVvmtSi/qO+vYVXZF
         gwCZwVpx3XiiV4xcLWSiixVPT2dzcGDYFddsnflx9XGckQi43kYiYg/RuGZLGQ8CrcEg
         2VITK4EST5PAdtCq/34W+3R58zX7xeIO07D3HkC87A4IeeUMRKjEJiCo3AR5MOB2/JTY
         t3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773223; x=1690378023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJP6IP6O34QOQC7Sgrsf1pjEzxOndOPTdn+h4xkI3pU=;
        b=N70zNSzUpPIFexJ5DAYAj1+tqt927hIFmJEcz3fnjM2aDCojgWZUz7yB2MBMVocSlA
         mOtGol8QJtV1duGdQ8vu+7o6IhP1soqsPG5Pp5q0xaAHSN2l64KE5C8gfFndkPV2njW5
         TkcxdW/RkPhOCbj5PLN9WWjmzLC7hR+HXZO3eXUSEXHHjx8PXcuNDk81Ybk3BXcyoJ7q
         A2H9XEPCIa16EWoPUeAmdjUdoj8VLFtVzR2DOx8CawpgpF6uGOlYk7x3NODd8Od9TVUc
         aw5XhN2VFOBqxn+rpXKhSqxxwFMI2N5Pm7cHhYVfeadT5lVIwapOGXjP5wHO6Zl7xo5q
         F8yw==
X-Gm-Message-State: ABy/qLYZe0IJmRStYSmNZhVTYIVP1NFw6rgPwHKyFFglnqCY++S3Sdaq
	EgWun5yGU/q6s9wSQq0C5YMabTze1GAhkDNyyZsCO9M2d48dNcFzZHCVFg==
X-Google-Smtp-Source: APBJJlE63WxIy+s5a4gSDqcZkInzd9lIS6R4janS97kd49jBhWs4Ac3OtPyshNKTWZJaACJBN+0zSwdd/6JM+U4hMWc=
X-Received: by 2002:a05:622a:1a87:b0:3f4:f0fd:fe7e with SMTP id
 s7-20020a05622a1a8700b003f4f0fdfe7emr529562qtc.3.1689773223467; Wed, 19 Jul
 2023 06:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org> <20230718153631.7a08a6ec@kernel.org>
 <CAO3-Pbqo_bfYsstH47hgqx7GC0CUg1H0xUaewq=MkUvb2BzCZA@mail.gmail.com>
 <61298b77-f1e0-9fc8-aa79-9b48f31c6941@kernel.org> <64b7e2a81b9b0_267b6729485@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b7e2a81b9b0_267b6729485@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jul 2023 15:26:51 +0200
Message-ID: <CANn89i+bYqD9GSVzwEPoG1fn0OGbTt_b5upKsDDVpzAtdKB0_Q@mail.gmail.com>
Subject: Re: Stacks leading into skb:kfree_skb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	Jakub Kicinski <kuba@kernel.org>, Ivan Babrou <ivan@cloudflare.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 3:18=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> David Ahern wrote:
> > On 7/18/23 9:10 PM, Yan Zhai wrote:
> > > On Tue, Jul 18, 2023 at 5:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > >>
> > >> On Fri, 14 Jul 2023 18:54:14 -0600 David Ahern wrote:
> > >>>> I made some aggregations for the stacks we see leading into
> > >>>> skb:kfree_skb endpoint. There's a lot of data that is not easily
> > >>>> digestible, so I lightly massaged the data and added flamegraphs i=
n
> > >>>> addition to raw stack counts. Here's the gist link:
> > >>>>
> > >>>> * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
> > >>>
> > >>> I see a lot of packet_rcv as the tip before kfree_skb. How many pac=
ket
> > >>> sockets do you have running on that box? Can you accumulate the tot=
al
> > >>> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remai=
ning
> > >>> stacktrace?
> > >>
> > >> On a quick look we have 3 branches which can get us to kfree_skb fro=
m
> > >> packet_rcv:
> > >>
> > >>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
> > >>                 goto drop;
> > >> ...
> > >>         if (!net_eq(dev_net(dev), sock_net(sk)))
> > >>                 goto drop;
> > >> ...
> > >>         res =3D run_filter(skb, sk, snaplen);
> > >>         if (!res)
> > >>                 goto drop_n_restore;
> > >>
> > >> I'd guess is the last one? Which we should mark with the SOCKET_FILT=
ER
> > >> drop reason?
> > >
> > > So we have multiple packet socket consumers on our edge:
> > > * systemd-networkd: listens on ETH_P_LLDPD, which is the role model
> > > that does not do excessive things
> >
> > ETH level means raw packet socket which means *all* packets are duplica=
ted.
> >
> > > * lldpd: I am not sure why we needed this one in presence of
> > > systemd-networkd, but it is running atm, which contributes to constan=
t
> > > packet_rcv calls. It listens on ETH_P_ALL because of
> > > https://github.com/lldpd/lldpd/pull/414. But its filter is doing the
> > > correct work, so packets hitting this one is mostly "consumed"
> >
> > This one I am familiar with and its filter -- the fact that the filter
> > applies *after* the clone means it still contributes to the packet load=
.
> >
> > Together these 2 sockets might explain why the filter drop shows up in
> > packet_rcv.
> >
> > >
> > > Now the bad kids:
> > > * arping: listens on ETH_P_ALL. This one contributes all the
> > > skb:kfree_skb spikes, and the reason is sk_rmem_alloc overflows
> > > rcvbuf. I suspect it is due to a poorly constructed filter so too man=
y
> > > packets get queued too fast.
> >
> > Any packet socket is the problem because the filter is applied to the
> > clone. Clone the packet, run the filter, kfree the packet.
>
> Small clarification: on receive in __netif_receive_skb_core, the skb
> is only cloned if accepted by packet_rcv. deliver_skb increases
> skb->users to ensure that the skb is not freed if a filter declines.
>
> On transmit, dev_queue_xmit_nit does create an initial clone. But
> then passes this one clone to all sockets, again using deliver_skb.
>
> A packet socket which filter accepts the skb is worse, then, as that
> clones the initial shared skb.
>
> >
> > > * conduit-watcher: a health checker, sending packets on ETH_P_IP in
> > > non-init netns. Majority of packet_rcv on this one goes to direct dro=
p
> > > due to netns difference.
> >
> > So this the raw packet socket at L3 that shows up. This one should not
> > be as large of a contributor to the increases packet load.
> >
> > >
> > > So to conclude, it might be useful to set a reason for rcvbuf related
> > > drops at least. On the other hand, almost all packets entered
> > > packet_rcv are shared, so clone failure probably can also be a thing
> > > under memory pressure.
>
> kfree_skb is changed across the stack into kfree_skb_reason. Doing the
> same for PF_PACKET sounds entirely reasonable to me.
>
> Just be careful about false positives where only the filter does not
> matches and the shared skb is dereferenced. This is WAI and not cause
> for a report.
>

Relevant prior work was:

commit da37845fdce24e174f44d020bc4085ddd1c8a6bd
Author: Weongyo Jeong <weongyo.linux@gmail.com>
Date:   Thu Apr 14 14:10:04 2016 -0700

    packet: uses kfree_skb() for errors.

    consume_skb() isn't for error cases that kfree_skb() is more proper
    one.  At this patch, it fixed tpacket_rcv() and packet_rcv() to be
    consistent for error or non-error cases letting perf trace its event
    properly.

