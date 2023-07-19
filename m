Return-Path: <netdev+bounces-19028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99075966A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BED2817AC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2F14AB8;
	Wed, 19 Jul 2023 13:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133F125AD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:18:35 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ABA1724
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:18:33 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63719ad32e7so40870266d6.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689772713; x=1690377513;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubt3LjyuGlCg7ymT9NaAzfAgyEklcqh8FsE6VKFE1tM=;
        b=JIkCcAp6R/jRaeiqXcz2Xbv8722PvYpnEyYFHePlXUaKUztcV3EWlTyLXCWM9iLZE6
         iW6R6HEV/Nb+nB/ZfUPeSbniDYkJo5lQshgBjKCn/zJr2DwMpI9LFCjLHLVVt9mlP3D0
         04KkIqijZ+TDtKiioErvVPzNDbuQB+zUuv74vK4exg7/hKWNVTk6C9w2P8kzAJ/F/9GD
         V7dHmicT7V8x6nC6zjDs7yqS54B4MiZdOZBS6ueT1qBJH6b49qVSZE3RW82yqXb1Vluo
         oufsQdhNFcBUHdnjqZt3yL+aOKdX71jM5+ZG4CLlT4Hy3PizghLkb2TGZOOOWJ89UUVg
         w3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772713; x=1690377513;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ubt3LjyuGlCg7ymT9NaAzfAgyEklcqh8FsE6VKFE1tM=;
        b=MVaLj3MQpm2E4ajxwsBMRi6Kt6x/GRwfK54o4JjPVJqXZ5S9BGoFVtn3no10IKToE3
         RhMKEpP9vLILwcO+KXh2EqUaoFy+m2sW5XGnEXx6TeeW40q1ptkPIE2natI7h7FajXZm
         GnGjuS5veyMfaDP7+Ud22G8GClv5L2gNJaiSuAHeF4qgp7+vii5jAo3olxhFHLk87Zog
         4fiPjJx96jE6STbxYN54SXRNLw9GoV85oofBkKFX2Kqpcfq3MFPh90vj68M5Hm4mb5DB
         5avxWnCB7mYPa1ZCDWj7pypvaxrrpsPv9/BpF+UriWIUX4a2J++pAczVIemIW0OqFCLj
         3KzA==
X-Gm-Message-State: ABy/qLbT4Bn3IzIBoGmIClVDf9gvIQwjnSDI/FtxCjMt2Mf1/3UXnqPQ
	PH/LqGofAR4ePPql16T3/uQ=
X-Google-Smtp-Source: APBJJlH7JtjbxdQfkkADtSuoIO9EglurDF6u9m0QLl9P49qS5LUvPB6yl4ehPD4cakL1hCfXulqt7g==
X-Received: by 2002:a0c:8f0a:0:b0:62d:f8e7:304a with SMTP id z10-20020a0c8f0a000000b0062df8e7304amr16915671qvd.54.1689772712738;
        Wed, 19 Jul 2023 06:18:32 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id f1-20020a0ccc81000000b0062df95d7ef6sm1428432qvl.115.2023.07.19.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:18:32 -0700 (PDT)
Date: Wed, 19 Jul 2023 09:18:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Ahern <dsahern@kernel.org>, 
 Yan Zhai <yan@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Babrou <ivan@cloudflare.com>, 
 Linux Kernel Network Developers <netdev@vger.kernel.org>, 
 kernel-team <kernel-team@cloudflare.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <64b7e2a81b9b0_267b6729485@willemb.c.googlers.com.notmuch>
In-Reply-To: <61298b77-f1e0-9fc8-aa79-9b48f31c6941@kernel.org>
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
 <20230718153631.7a08a6ec@kernel.org>
 <CAO3-Pbqo_bfYsstH47hgqx7GC0CUg1H0xUaewq=MkUvb2BzCZA@mail.gmail.com>
 <61298b77-f1e0-9fc8-aa79-9b48f31c6941@kernel.org>
Subject: Re: Stacks leading into skb:kfree_skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Ahern wrote:
> On 7/18/23 9:10 PM, Yan Zhai wrote:
> > On Tue, Jul 18, 2023 at 5:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>
> >> On Fri, 14 Jul 2023 18:54:14 -0600 David Ahern wrote:
> >>>> I made some aggregations for the stacks we see leading into
> >>>> skb:kfree_skb endpoint. There's a lot of data that is not easily
> >>>> digestible, so I lightly massaged the data and added flamegraphs i=
n
> >>>> addition to raw stack counts. Here's the gist link:
> >>>>
> >>>> * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
> >>>
> >>> I see a lot of packet_rcv as the tip before kfree_skb. How many pac=
ket
> >>> sockets do you have running on that box? Can you accumulate the tot=
al
> >>> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remai=
ning
> >>> stacktrace?
> >>
> >> On a quick look we have 3 branches which can get us to kfree_skb fro=
m
> >> packet_rcv:
> >>
> >>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
> >>                 goto drop;
> >> ...
> >>         if (!net_eq(dev_net(dev), sock_net(sk)))
> >>                 goto drop;
> >> ...
> >>         res =3D run_filter(skb, sk, snaplen);
> >>         if (!res)
> >>                 goto drop_n_restore;
> >>
> >> I'd guess is the last one? Which we should mark with the SOCKET_FILT=
ER
> >> drop reason?
> > =

> > So we have multiple packet socket consumers on our edge:
> > * systemd-networkd: listens on ETH_P_LLDPD, which is the role model
> > that does not do excessive things
> =

> ETH level means raw packet socket which means *all* packets are duplica=
ted.
> =

> > * lldpd: I am not sure why we needed this one in presence of
> > systemd-networkd, but it is running atm, which contributes to constan=
t
> > packet_rcv calls. It listens on ETH_P_ALL because of
> > https://github.com/lldpd/lldpd/pull/414. But its filter is doing the
> > correct work, so packets hitting this one is mostly "consumed"
> =

> This one I am familiar with and its filter -- the fact that the filter
> applies *after* the clone means it still contributes to the packet load=
.
> =

> Together these 2 sockets might explain why the filter drop shows up in
> packet_rcv.
> =

> > =

> > Now the bad kids:
> > * arping: listens on ETH_P_ALL. This one contributes all the
> > skb:kfree_skb spikes, and the reason is sk_rmem_alloc overflows
> > rcvbuf. I suspect it is due to a poorly constructed filter so too man=
y
> > packets get queued too fast.
> =

> Any packet socket is the problem because the filter is applied to the
> clone. Clone the packet, run the filter, kfree the packet.

Small clarification: on receive in __netif_receive_skb_core, the skb
is only cloned if accepted by packet_rcv. deliver_skb increases
skb->users to ensure that the skb is not freed if a filter declines.

On transmit, dev_queue_xmit_nit does create an initial clone. But
then passes this one clone to all sockets, again using deliver_skb.

A packet socket which filter accepts the skb is worse, then, as that
clones the initial shared skb.

> =

> > * conduit-watcher: a health checker, sending packets on ETH_P_IP in
> > non-init netns. Majority of packet_rcv on this one goes to direct dro=
p
> > due to netns difference.
> =

> So this the raw packet socket at L3 that shows up. This one should not
> be as large of a contributor to the increases packet load.
> =

> > =

> > So to conclude, it might be useful to set a reason for rcvbuf related=

> > drops at least. On the other hand, almost all packets entered
> > packet_rcv are shared, so clone failure probably can also be a thing
> > under memory pressure.

kfree_skb is changed across the stack into kfree_skb_reason. Doing the
same for PF_PACKET sounds entirely reasonable to me.

Just be careful about false positives where only the filter does not
matches and the shared skb is dereferenced. This is WAI and not cause
for a report.

> > =

> > =

> =




