Return-Path: <netdev+bounces-19980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23075D14E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02872820E9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D820F95;
	Fri, 21 Jul 2023 18:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56E1FB50
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:24:53 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D29359D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:24:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40540a8a3bbso34961cf.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963876; x=1690568676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf2JOpJ/T7opUon8UB2Q9VeM1w/94NV/MwaqmF55kQY=;
        b=cyocvhzHiiGnmzAHcj5IgMEQbySVdR7BQvvRUivMe0YTUchl4PZCJefoN/8o88DNAE
         a/9V1cwj0lnPfseB86bYI2o3si+mD27gAPujk1N2hKPqyhq06kpjg7d2yWhVbVYwWs6E
         elVTY93PxtLgUGuO08GjtT2BGVMXtLmQWcDvEXYm+LBJgXCEFaHfdXcboxsECbVSLUvs
         7dkTzgJe8InTIF46WK2LFl9izgBoUAJ4l1DJwC8b2b7o9GejqKbKtiTK/3TbdU0dvljW
         QXLORtYbeWTaO5TeLdbpsfFmlpHfz24OwdyhfRSMhaywcBqgtLtkN1DDi8pH8Ta6FLB6
         TwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963876; x=1690568676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf2JOpJ/T7opUon8UB2Q9VeM1w/94NV/MwaqmF55kQY=;
        b=Xsmb1cvFckc96jSRbTmtd12HqQtJBQEG1GoFO7jYj1H+lTP4a4XrsxKP8s2tsVQctQ
         jIYGXaGWTyuPZLmULSRu+N6OZGNwfSSXTuWZeemJiBAcP9i+YvGO8vYB2GT+BIlvNaau
         syj6K4asPMHn1tnjq8h3Y3k7I2qXXWQMcPAL2xljic9wVTkvK+VMNkI2aU6ZvcCQGs+q
         GHqHr4XdLrSG1i+PPPWHeLnDaMM6GXVRuPzYO3vXVdKMYaBQD+norOSNC5+oX++tVkG6
         maf5zg58Cond5H1zJ3wLti+qyhsvjbK7AmFa4xA3pqdSXV93MOFiMbPpBUsWvYZd/46C
         vAFg==
X-Gm-Message-State: ABy/qLZSi7OY0g+eHbR9C5F0v7r5SM26hA2xCnAlmbuTV+uJy4yF7LEV
	4r9L/kUYScuOM75nm6R70jvKIqPAreTAvx3XVWEy7A==
X-Google-Smtp-Source: APBJJlHdWju1atBGaU2p9zyrCXXfRStv7GxBLKesfhnnWN1vNZG6o0mjQXAiMLddNFxVDnbIlwLinqLv8sxBnbKEboI=
X-Received: by 2002:ac8:5f8b:0:b0:3ef:404a:b291 with SMTP id
 j11-20020ac85f8b000000b003ef404ab291mr20689qta.7.1689963875542; Fri, 21 Jul
 2023 11:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com> <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
In-Reply-To: <CAKH8qBvm9ZPdn3+yifnGay726rKhA-+OAjyQjffYzo0iqoOmJg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Jul 2023 20:24:24 +0200
Message-ID: <CANn89iLzQKkjpycJUetpONjBSJC_tKdw2qoASYPq7goBWoHVnA@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Stanislav Fomichev <sdf@google.com>
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

cBPF / eBPF would not really matter for the very small program Maciej gave,
I think both are running the same underlying helpers, and roughly same
JITed code...

 tcpdump -d "arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133
and ip6[40] <=3D 136)"

(000) ldh      [12]
(001) jeq      #0x806           jt 21 jf 2
(002) jeq      #0x800           jt 3 jf 12
(003) ldb      [23]
(004) jeq      #0x11            jt 5 jf 22
(005) ldh      [20]
(006) jset     #0x1fff          jt 22 jf 7
(007) ldxb     4*([14]&0xf)
(008) ldh      [x + 14]
(009) jeq      #0x44            jt 21 jf 10
(010) ldh      [x + 16]
(011) jeq      #0x44            jt 21 jf 22
(012) jeq      #0x86dd          jt 13 jf 22
(013) ldb      [20]
(014) jeq      #0x3a            jt 18 jf 15
(015) jeq      #0x2c            jt 16 jf 22
(016) ldb      [54]
(017) jeq      #0x3a            jt 18 jf 22
(018) ldb      [54]
(019) jge      #0x85            jt 20 jf 22
(020) jgt      #0x88            jt 22 jf 21
(021) ret      #262144
(022) ret      #0

