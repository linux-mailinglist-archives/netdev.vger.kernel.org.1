Return-Path: <netdev+bounces-19989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41575D39B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490101C21789
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACB20F8E;
	Fri, 21 Jul 2023 19:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7320F88
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:12:32 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9AD30E4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:12:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40371070eb7so50561cf.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689966749; x=1690571549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPXE2RFBTgaJuQU46MbmD6OM9XeAOcQXgpYH0j2iei4=;
        b=bgnb8f9DOxhRa9RSUvSNWqsGSNA2NIh/cQk1sMl0N8bzCLDunpRng93TisNd7CO6Ds
         q1oZE+U/N6tJDaBLyLCNwbkJ7UJ2PSJc625k9M7qeZRhx/oocT4rs6FAlUt8WJjvkZgB
         nSYKmzj1XEPlk3Vx8wglDjLusQ5Ttwfq26W6OHIGCWWPlRymCGV7dZlH5OavwXpoUj0H
         K+ycYYA6iLiIbdKWX2fiuZdza97e8Lzc2BWv9AQ6OnElaYKj7V3eRreDkcydfkv9WGNw
         hTL2lHGqgjJ5r8xbKEeLrpm+WdyhdNCq2zyaahCM9AD1u9ypUPsSAFc65d0ahdmTBKN/
         7Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966749; x=1690571549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPXE2RFBTgaJuQU46MbmD6OM9XeAOcQXgpYH0j2iei4=;
        b=RVhet78Fc4S5Q4SA6lZfaCzvDnOli/tz+qfyVhCi7UTF2ZhoOP/1nJvayd9zLll7VR
         ZOV6L+wT1/HhpFvgYVpLZeTY7h1kWIJGnA4for7XUxqcG8DqofjK27HeGJkprYh9S5fb
         UF3RhoGldJ6GQQERlOZs5lG9UrktF+k9N+dZLCQ6BGU4Esf/YZbk2LpwaZ0NLHUla/h4
         QpOaVbwfYDuZK9jdUh8JQRK+a/eaSvrp6KpHMcrHO9U3WuhatoainDeAL5TyIKyzz8G7
         2Brl2ypciij/vb35FSQaATsxNgOoceb45wbEEV5IVBclWD1zK9qCBMME8dzE7Vl6jxv5
         mEsg==
X-Gm-Message-State: ABy/qLaGjB+21A0fPCXJIEszU3sn/PE1Wv2wGR47ebr8BLv8rDtRNNRX
	avuBRouVEhj0CfdkeBOlmZFBUcv7TKG6bknz93eAZHzq2kQEDV7Q2RFvNw==
X-Google-Smtp-Source: APBJJlG7pScVNIqi1GF3eiN5kdUpMuImycTLDl3yQl8Ck5uu4fTo+piW+Za2UFzbGjRkLJqnE9OxwUn77zMoGCLHyNw=
X-Received: by 2002:ac8:5bc2:0:b0:403:ac17:c18a with SMTP id
 b2-20020ac85bc2000000b00403ac17c18amr45996qtb.14.1689966749183; Fri, 21 Jul
 2023 12:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
 <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
 <CANP3RGfFAjEDWbLAcmMcz63XUV6=djqZNsMikrqvA-i9K-4pAg@mail.gmail.com> <64bad4e5d4e18_2f85252944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <64bad4e5d4e18_2f85252944f@willemb.c.googlers.com.notmuch>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 21 Jul 2023 21:12:17 +0200
Message-ID: <CANP3RGccKpZSpJOAUd0ui3+jCLGLGg19FCcxeyzLuNuAqkAm-w@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Eric Dumazet <edumazet@google.com>, 
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

On Fri, Jul 21, 2023 at 8:56=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Maciej =C5=BBenczykowski wrote:
> > On Fri, Jul 21, 2023 at 8:18=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On Fri, Jul 21, 2023 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <m=
aze@google.com> wrote:
> > > > >
> > > > > I've been asked to review:
> > > > >   https://android-review.googlesource.com/c/platform/packages/mod=
ules/NetworkStack/+/2648779
> > > > >
> > > > > where it comes to light that in Android due to background debuggi=
ng of
> > > > > connectivity problems
> > > > > (of which there are *plenty* due to various types of buggy [prima=
rily]
> > > > > wifi networks)
> > > > > we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filte=
r:
> > > > >
> > > > >    arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and=
 ip6[40] <=3D 136)
> > > > >
> > > > > ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
> > > > >
> > > > > If I'm reading the kernel code right this appears to cause skb_cl=
one()
> > > > > to be called on *every* outgoing packet,
> > > > > even though most packets will not be accepted by the filter.
> > > > >
> > > > > (In the TX path the filter appears to get called *after* the clon=
e,
> > > > > I think that's unlike the RX path where the filter is called firs=
t)
> > > > >
> > > > > Unfortunately, I don't think it's possible to eliminate the
> > > > > functionality this socket provides.
> > > > > We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> > > > > bugreports / etc.
> > > > > and they *really* should be in order wrt. to each other.
> > > > > (and yeah, that means last few minutes history when an issue happ=
ens,
> > > > > so not possible to simply enable it on demand)
> > > > >
> > > > > We could of course split the socket into 3 separate ones:
> > > > > - ETH_P_ARP
> > > > > - ETH_P_IP + cbpf udp dport=3Ddhcp
> > > > > - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
> > > > >
> > > > > But I don't think that will help - I believe we'll still get
> > > > > skb_clone() for every outbound ipv4/ipv6 packet.
> > > > >
> > > > > I have some ideas for what could be done to avoid the clone (with
> > > > > existing kernel functionality)... but none of it is pretty...
> > > > > Anyone have any smart ideas?
> > > > >
> > > > > Perhaps a way to move the clone past the af_packet packet_rcv run=
_filter?
> > > > > Unfortunately packet_rcv() does a little bit of 'setup' before it
> > > > > calls the filter - so this may be hard.
> > > >
> > > >
> > > > dev_queue_xmit_nit() also does some 'setup':
> > > >
> > > > net_timestamp_set(skb2);  (This one could probably be moved into
> > > > af_packet, if packet is not dropped ?)
> > > > <sanitize mac, network, transport headers>
> > > >
> > > > >
> > > > > Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that =
has
> > > > > very minimal
> > > > > functionality... like match 2 bytes at an offset into the packet?
> > > > > Maybe even not a hook at all, just adding a
> > > > > prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> > > > > It doesn't have to be perfect, but if it could discard 99% of the
> > > > > packets we don't care about...
> > > > > (and leave filtering of the remaining 1% to the existing cbpf pro=
gram)
> > > > > that would already be a huge win?
> > > >
> > > > Maybe if we can detect a cBPF filter does not access mac, network,
> > > > transport header,
> > > > we could run it earlier, before the clone().
> > > >
> > > > So we could add
> > > > prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
> > > >
> > > > Or maybe we can remove sanitization, because BPF should not do bad
> > > > things if these headers are garbage ?
> > >
> > > eBPF is already doing those sorts of checks, so maybe another option
> > > is to convert this filter to ebpf tc/egress program?
> >
> > Yeah, I've considered tc ingress/egress + bpf ring buffer.
> >
> > This unfortunately is a fair bit of pain to do:
> >
> > - it requires a new enough kernel (5.~8 ifirc), so we'd have to keep
> > the old code
> > around for 4.9 which we still have to support for a few (5?) more years=
.
>
> Wouldn't any kernel patch to net-next have the same issue?
>
> Another hack might be to use tc egress bpf or even u32 plus tc_mirred to
> redirect only interesting packets to an ifb virtual device, and only
> attach the packet socket there.

Not if it's an 'improvement' that would either work automatically
on any devices that take the kernel fix,

Or a feature that we could enable via some setsockopt() and just ignore fai=
lures
(for older kernels that don't support it)

Sure older kernels/devices wouldn't get the benefit, but whatever...
they wouldn't regress, just wouldn't improve.

> > - it needs to be done on a per device basis...
> > (devices have dynamic lifetimes on Android, and we don't necessarily
> > even know about all of them,
> > though perhaps it would be ok to not receive packets on those...)

