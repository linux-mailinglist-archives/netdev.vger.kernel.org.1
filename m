Return-Path: <netdev+bounces-19979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2075D132
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B732820E9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149220F93;
	Fri, 21 Jul 2023 18:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001A1FB50
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:18:28 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349E35AB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:18:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1475819a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963503; x=1690568303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgHnK+NAvt1JZYkKXuBdpvjuPFrNMSCzqMv955YZPIE=;
        b=QfHObqQUCCj+GMADWjVozDDydRGAoFYBA74/t66ak37KQDDXMWQdkUE1TYl+0XsISR
         m3Lss88y4oCdg3sxW5UUEqUHatyFQR75Dk96r+wrCxJusd8GwsCALjggX/vjqZW/TcS9
         HHwU2+iM3PyaRkG7kF93WmYck9PudEbKR4sss66ecjt34EsogpNPtUW7yMOlmK7kR8vT
         chz+mWdOZYvkFyKQauYiwCbUfas385tqI94tVRGUu1WxTL3iUUthNwbs+jCeAaOgPZuR
         U2ljnUkC/lp7y0+i7XpTy2lL4T4zDHWPxQ4VYKWKkbpN7XIUQWKUvPnQtHrsQotRezQP
         Hafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963503; x=1690568303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgHnK+NAvt1JZYkKXuBdpvjuPFrNMSCzqMv955YZPIE=;
        b=Kcm8CfcqWrqzD+fLR4xg/8DpGKnAY4GKW5RQtHLzRlKNPWnWAlzE4LWpz9eC9hQHs/
         C404r7jLg/xomChdU5eyWCZbrtnxbVf/yMtgginP2H9iGDog62rdVJq9ANMQQfP4utIh
         Yz8Q5zXGO291GETTpGaIg8sYNGP5M5xvXXsSbuEz8QTpUC/1CsKXghlRMJfhpD0HQ8VA
         rGhZCk+jhLIhFdoUOkkma+nthVOxAamjYCPjfqIqzcVLkAg5A5qWykVxlcy4+gO6V9OQ
         d3WPkxLeLgQASECJBG0HrjHJkozHT0/F2RazLALCGQfwBEyZyTWoKmAJIy29LN8WZf0p
         HCSQ==
X-Gm-Message-State: ABy/qLYNob4BWrJ8+ikERop9AGYLa1bcV7YXhV1D5K1ASl4Mbwoq8HKq
	AfqM2P2NbUI7jYB1oVQBKFvzhrhY2fbg3NvX6++EyA==
X-Google-Smtp-Source: APBJJlFBjfbqVZ+QXIZ/G/BgPGAQrPSmDmJ3EAVJVy0jR0IEIbe+q8zqo9BmDA+slKZ1lpMGQZqX3FouqkeyZJnyv+Y=
X-Received: by 2002:a17:90a:a45:b0:256:cc5e:e55b with SMTP id
 o63-20020a17090a0a4500b00256cc5ee55bmr2356371pjo.7.1689963503382; Fri, 21 Jul
 2023 11:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
In-Reply-To: <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 21 Jul 2023 11:18:12 -0700
Message-ID: <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Eric Dumazet <edumazet@google.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Linux NetDev <netdev@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Willem Bruijn <willemb@google.com>, Xiao Ma <xiaom@google.com>, 
	Patrick Rohr <prohr@google.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@go=
ogle.com> wrote:
> >
> > I've been asked to review:
> >   https://android-review.googlesource.com/c/platform/packages/modules/N=
etworkStack/+/2648779
> >
> > where it comes to light that in Android due to background debugging of
> > connectivity problems
> > (of which there are *plenty* due to various types of buggy [primarily]
> > wifi networks)
> > we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:
> >
> >    arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and ip6[4=
0] <=3D 136)
> >
> > ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
> >
> > If I'm reading the kernel code right this appears to cause skb_clone()
> > to be called on *every* outgoing packet,
> > even though most packets will not be accepted by the filter.
> >
> > (In the TX path the filter appears to get called *after* the clone,
> > I think that's unlike the RX path where the filter is called first)
> >
> > Unfortunately, I don't think it's possible to eliminate the
> > functionality this socket provides.
> > We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> > bugreports / etc.
> > and they *really* should be in order wrt. to each other.
> > (and yeah, that means last few minutes history when an issue happens,
> > so not possible to simply enable it on demand)
> >
> > We could of course split the socket into 3 separate ones:
> > - ETH_P_ARP
> > - ETH_P_IP + cbpf udp dport=3Ddhcp
> > - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
> >
> > But I don't think that will help - I believe we'll still get
> > skb_clone() for every outbound ipv4/ipv6 packet.
> >
> > I have some ideas for what could be done to avoid the clone (with
> > existing kernel functionality)... but none of it is pretty...
> > Anyone have any smart ideas?
> >
> > Perhaps a way to move the clone past the af_packet packet_rcv run_filte=
r?
> > Unfortunately packet_rcv() does a little bit of 'setup' before it
> > calls the filter - so this may be hard.
>
>
> dev_queue_xmit_nit() also does some 'setup':
>
> net_timestamp_set(skb2);  (This one could probably be moved into
> af_packet, if packet is not dropped ?)
> <sanitize mac, network, transport headers>
>
> >
> > Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
> > very minimal
> > functionality... like match 2 bytes at an offset into the packet?
> > Maybe even not a hook at all, just adding a
> > prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> > It doesn't have to be perfect, but if it could discard 99% of the
> > packets we don't care about...
> > (and leave filtering of the remaining 1% to the existing cbpf program)
> > that would already be a huge win?
>
> Maybe if we can detect a cBPF filter does not access mac, network,
> transport header,
> we could run it earlier, before the clone().
>
> So we could add
> prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
>
> Or maybe we can remove sanitization, because BPF should not do bad
> things if these headers are garbage ?

eBPF is already doing those sorts of checks, so maybe another option
is to convert this filter to ebpf tc/egress program?

