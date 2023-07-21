Return-Path: <netdev+bounces-19981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362D75D153
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED841C217B6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423020F99;
	Fri, 21 Jul 2023 18:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E21FB50
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:25:11 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849D35AB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:25:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40550136e54so37221cf.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963900; x=1690568700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwAgqXKAfR/8duPNE3HxljitAwh1l/C5+PhjchX4zgE=;
        b=YpKpjqhkkia/8kZwmDLqg7jdlLI4AODzWyaUCtfQHY4GpEVJ0CyXlsy5fl0XhuUtnP
         sxPKw4Q8MnKlZjhf9jvX03tQGOj8EkhZhrTs2XzO8Q/SCLPxzEknOySe2TCyjVwxoLPu
         ByEihtH4MmITiGjh0KZrfLsjzvRAOWlH8NGK59x+GhnDQN9+CXhB2dtNw8kh0nh+e74D
         cDX7moamoAsEwzLBDZ8XJDiuuLBDx68rAimDnzgJVA06X+R0lpxpjq1QIb8JdKx1b13g
         BoKBC35FjvXhuRwF0v6rbV9bVp8hjIAnhWZBUe0tX5hxhoIfEY0aEH2S5rdGAyG3JpI3
         Nu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963900; x=1690568700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwAgqXKAfR/8duPNE3HxljitAwh1l/C5+PhjchX4zgE=;
        b=WiEp8ens+K8y/jPhSMzlx/W98oOdUCXRHeAqphn3foJq1hU0szV7PnEh63chGaJecT
         MmkJDlDNwHRCvzisDwgtgf0g+KJNdxlbyWuMQmW5Vv+aFXmKpcTTzMNq2F8kWaYQ/TW8
         YBySglgixPpZ89mVMxl9o3IVYHqSpam/qHNARaK7yPpkxJKF+H8w5SUrXO+gx3p4sqeI
         dtsz9ooojrJsffgYDmGaPV9487HAk1nfF403SLw2TCr06o1acLJh+pqHXpb1toEtaug9
         ksCi2Q2wwudwGFLJTC01RQaOd7tIDvyAioY0VIDkPse+N2YtsKdy+vea6c370HGnCa7K
         BJgg==
X-Gm-Message-State: ABy/qLauqWiGSl2alqISiMVnuDf5CrFAj72WRyZk7actGP+VQN5N+UO5
	oUVAZWGZdFlEObrFm88RPl7Abpy6Li58ABgIkXngjw==
X-Google-Smtp-Source: APBJJlEHAvsK2Q8B0XKSku3IFj/WjSWYJme1Gq7k0IHfq7Y9BeTErXMAJ+/MCBL+bf6WevUaBOS2Um6staIYeR10MgM=
X-Received: by 2002:a05:622a:181b:b0:403:caaa:1f9b with SMTP id
 t27-20020a05622a181b00b00403caaa1f9bmr30481qtc.2.1689963900301; Fri, 21 Jul
 2023 11:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com> <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
In-Reply-To: <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 21 Jul 2023 20:24:48 +0200
Message-ID: <CANP3RGfFAjEDWbLAcmMcz63XUV6=djqZNsMikrqvA-i9K-4pAg@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Stanislav Fomichev <sdf@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Linux NetDev <netdev@vger.kernel.org>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Willem Bruijn <willemb@google.com>, Xiao Ma <xiaom@google.com>, Patrick Rohr <prohr@google.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 8:18=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> > >
> > > I've been asked to review:
> > >   https://android-review.googlesource.com/c/platform/packages/modules=
/NetworkStack/+/2648779
> > >
> > > where it comes to light that in Android due to background debugging o=
f
> > > connectivity problems
> > > (of which there are *plenty* due to various types of buggy [primarily=
]
> > > wifi networks)
> > > we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:
> > >
> > >    arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and ip6=
[40] <=3D 136)
> > >
> > > ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
> > >
> > > If I'm reading the kernel code right this appears to cause skb_clone(=
)
> > > to be called on *every* outgoing packet,
> > > even though most packets will not be accepted by the filter.
> > >
> > > (In the TX path the filter appears to get called *after* the clone,
> > > I think that's unlike the RX path where the filter is called first)
> > >
> > > Unfortunately, I don't think it's possible to eliminate the
> > > functionality this socket provides.
> > > We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> > > bugreports / etc.
> > > and they *really* should be in order wrt. to each other.
> > > (and yeah, that means last few minutes history when an issue happens,
> > > so not possible to simply enable it on demand)
> > >
> > > We could of course split the socket into 3 separate ones:
> > > - ETH_P_ARP
> > > - ETH_P_IP + cbpf udp dport=3Ddhcp
> > > - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
> > >
> > > But I don't think that will help - I believe we'll still get
> > > skb_clone() for every outbound ipv4/ipv6 packet.
> > >
> > > I have some ideas for what could be done to avoid the clone (with
> > > existing kernel functionality)... but none of it is pretty...
> > > Anyone have any smart ideas?
> > >
> > > Perhaps a way to move the clone past the af_packet packet_rcv run_fil=
ter?
> > > Unfortunately packet_rcv() does a little bit of 'setup' before it
> > > calls the filter - so this may be hard.
> >
> >
> > dev_queue_xmit_nit() also does some 'setup':
> >
> > net_timestamp_set(skb2);  (This one could probably be moved into
> > af_packet, if packet is not dropped ?)
> > <sanitize mac, network, transport headers>
> >
> > >
> > > Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
> > > very minimal
> > > functionality... like match 2 bytes at an offset into the packet?
> > > Maybe even not a hook at all, just adding a
> > > prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> > > It doesn't have to be perfect, but if it could discard 99% of the
> > > packets we don't care about...
> > > (and leave filtering of the remaining 1% to the existing cbpf program=
)
> > > that would already be a huge win?
> >
> > Maybe if we can detect a cBPF filter does not access mac, network,
> > transport header,
> > we could run it earlier, before the clone().
> >
> > So we could add
> > prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
> >
> > Or maybe we can remove sanitization, because BPF should not do bad
> > things if these headers are garbage ?
>
> eBPF is already doing those sorts of checks, so maybe another option
> is to convert this filter to ebpf tc/egress program?

Yeah, I've considered tc ingress/egress + bpf ring buffer.

This unfortunately is a fair bit of pain to do:

- it requires a new enough kernel (5.~8 ifirc), so we'd have to keep
the old code
around for 4.9 which we still have to support for a few (5?) more years.

- it needs to be done on a per device basis...
(devices have dynamic lifetimes on Android, and we don't necessarily
even know about all of them,
though perhaps it would be ok to not receive packets on those...)

