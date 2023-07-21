Return-Path: <netdev+bounces-19984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99DC75D22D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B19D1C21745
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49331F956;
	Fri, 21 Jul 2023 18:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04161F94B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:56:52 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E963A97
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:56:39 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7656652da3cso191454185a.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689965798; x=1690570598;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEoarqksgl75xEDFaodgyfxS93gI1OdMyPsmzD0gfkg=;
        b=XL6BH/Rz9VcjP6fZnDMByRgM1UiPw2y1ur+kk0wCCPOoR6ukVgtaTCqcvMCGQ9E2zL
         REc4l70rWoth3fQqDWO6s/QaYzU3RQHzUamxiTyRRKG2GxnlZrqkg4k+l0+jYTJzoU1a
         qmvnPH3IctLw9TVD6ryiy79yubsBFG7RwbuCXlNWJ5SontXJxI7B6rFnQkLaV7seqKg9
         S1wmpDMCmn65zfSPX5MELi4tVdzkOqKp6sw1xKmEzR2M1jHVtpzvX4Pu/ka8dWeuHssE
         cM3ri5KEpnWXn7ne1+PkXyRLRLwilk3LQD++qQvSulJM2JUN2EBAgVxviz/wEGI5xjYs
         EYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965798; x=1690570598;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LEoarqksgl75xEDFaodgyfxS93gI1OdMyPsmzD0gfkg=;
        b=UdTSa7v0W2LCFWz7YqeHCZ65gIVj0JBfmnkR3KGdMtLQzPog3xV9fdKTFU/gAbDJhH
         2IuTH21sMW5eDVoOnqjGSvOzM1scIw+NCDh8TRQFkcFxKhGNddLjTM1feeXUm/NoLeOp
         Lr0o5/4isODypvI5Nt8etHGRmJPlWNuDlNpo3K9mH52P3cxmfbMuddHy6XeqTg9a9cZZ
         CPmys5+OY8YPQvNY7Bv3Ug04SekDVmwClrjGQqAzWnI3elJDR0n4KYMg1X/If3gDMQf5
         fn/2ariM/Y6Ho4RrOlfIMl5K+UhcyoEqhyzaC5/tvu0SXGP9rNra0/5bQ7zr9cZ5lcjt
         fOBg==
X-Gm-Message-State: ABy/qLah7pf2ufFW4b6GN4k7fVeXy+iMKtgVB/1OHQND7X12rC+d0H6k
	olVJH0ydFzsY4FR9b8tC4bE=
X-Google-Smtp-Source: APBJJlF1eiS1xCQjO2vxcQsH+oxpoOfl1hHx6+/J49IlqnuZ/tLzp2bUScSeE0x9gwCLwqB4ogp7PQ==
X-Received: by 2002:a37:5a02:0:b0:763:aa49:bd3f with SMTP id o2-20020a375a02000000b00763aa49bd3fmr878003qkb.43.1689965798454;
        Fri, 21 Jul 2023 11:56:38 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id b27-20020a05620a119b00b007678973eaa1sm1301429qkk.127.2023.07.21.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:56:38 -0700 (PDT)
Date: Fri, 21 Jul 2023 14:56:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Stanislav Fomichev <sdf@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 Linux NetDev <netdev@vger.kernel.org>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Pengtao He <hepengtao@xiaomi.com>, 
 Willem Bruijn <willemb@google.com>, 
 Xiao Ma <xiaom@google.com>, 
 Patrick Rohr <prohr@google.com>, 
 Alexei Starovoitov <ast@kernel.org>
Message-ID: <64bad4e5d4e18_2f85252944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGfFAjEDWbLAcmMcz63XUV6=djqZNsMikrqvA-i9K-4pAg@mail.gmail.com>
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
 <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
 <CANP3RGfFAjEDWbLAcmMcz63XUV6=djqZNsMikrqvA-i9K-4pAg@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path
 skb_clone
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej =C5=BBenczykowski wrote:
> On Fri, Jul 21, 2023 at 8:18=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> >
> > On Fri, Jul 21, 2023 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > >
> > > On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <m=
aze@google.com> wrote:
> > > >
> > > > I've been asked to review:
> > > >   https://android-review.googlesource.com/c/platform/packages/mod=
ules/NetworkStack/+/2648779
> > > >
> > > > where it comes to light that in Android due to background debuggi=
ng of
> > > > connectivity problems
> > > > (of which there are *plenty* due to various types of buggy [prima=
rily]
> > > > wifi networks)
> > > > we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filte=
r:
> > > >
> > > >    arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and=
 ip6[40] <=3D 136)
> > > >
> > > > ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
> > > >
> > > > If I'm reading the kernel code right this appears to cause skb_cl=
one()
> > > > to be called on *every* outgoing packet,
> > > > even though most packets will not be accepted by the filter.
> > > >
> > > > (In the TX path the filter appears to get called *after* the clon=
e,
> > > > I think that's unlike the RX path where the filter is called firs=
t)
> > > >
> > > > Unfortunately, I don't think it's possible to eliminate the
> > > > functionality this socket provides.
> > > > We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> > > > bugreports / etc.
> > > > and they *really* should be in order wrt. to each other.
> > > > (and yeah, that means last few minutes history when an issue happ=
ens,
> > > > so not possible to simply enable it on demand)
> > > >
> > > > We could of course split the socket into 3 separate ones:
> > > > - ETH_P_ARP
> > > > - ETH_P_IP + cbpf udp dport=3Ddhcp
> > > > - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
> > > >
> > > > But I don't think that will help - I believe we'll still get
> > > > skb_clone() for every outbound ipv4/ipv6 packet.
> > > >
> > > > I have some ideas for what could be done to avoid the clone (with=

> > > > existing kernel functionality)... but none of it is pretty...
> > > > Anyone have any smart ideas?
> > > >
> > > > Perhaps a way to move the clone past the af_packet packet_rcv run=
_filter?
> > > > Unfortunately packet_rcv() does a little bit of 'setup' before it=

> > > > calls the filter - so this may be hard.
> > >
> > >
> > > dev_queue_xmit_nit() also does some 'setup':
> > >
> > > net_timestamp_set(skb2);  (This one could probably be moved into
> > > af_packet, if packet is not dropped ?)
> > > <sanitize mac, network, transport headers>
> > >
> > > >
> > > > Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that =
has
> > > > very minimal
> > > > functionality... like match 2 bytes at an offset into the packet?=

> > > > Maybe even not a hook at all, just adding a
> > > > prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> > > > It doesn't have to be perfect, but if it could discard 99% of the=

> > > > packets we don't care about...
> > > > (and leave filtering of the remaining 1% to the existing cbpf pro=
gram)
> > > > that would already be a huge win?
> > >
> > > Maybe if we can detect a cBPF filter does not access mac, network,
> > > transport header,
> > > we could run it earlier, before the clone().
> > >
> > > So we could add
> > > prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
> > >
> > > Or maybe we can remove sanitization, because BPF should not do bad
> > > things if these headers are garbage ?
> >
> > eBPF is already doing those sorts of checks, so maybe another option
> > is to convert this filter to ebpf tc/egress program?
> =

> Yeah, I've considered tc ingress/egress + bpf ring buffer.
> =

> This unfortunately is a fair bit of pain to do:
> =

> - it requires a new enough kernel (5.~8 ifirc), so we'd have to keep
> the old code
> around for 4.9 which we still have to support for a few (5?) more years=
.

Wouldn't any kernel patch to net-next have the same issue?
 =

Another hack might be to use tc egress bpf or even u32 plus tc_mirred to
redirect only interesting packets to an ifb virtual device, and only
attach the packet socket there.

> - it needs to be done on a per device basis...
> (devices have dynamic lifetimes on Android, and we don't necessarily
> even know about all of them,
> though perhaps it would be ok to not receive packets on those...)



