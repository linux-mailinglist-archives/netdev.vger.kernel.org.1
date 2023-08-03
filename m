Return-Path: <netdev+bounces-23942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8676E387
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C088D1C214F2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACCDDAD;
	Thu,  3 Aug 2023 08:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631D7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:47:17 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D53AA9
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:46:48 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40c72caec5cso236981cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691052407; x=1691657207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFJyrm/ZiNcXEHgtiVxfHVXXobkvwFsh8YfUrD95XL4=;
        b=yDSXrryLFNvnwlnb4MJk2W9/cK6aStz7LjR9J2VtTXl3kddx3N4/w7gRi9uACOxdeb
         285NM8E/rvdQOdhcJi2BUENWtR7TVoPWkMDTK27DJIPSVFF4RhtIIdv6OPX8kINj5C8i
         oQXSG8Wok27BFv2bYIkxRKqBV3e4EoLH1vmX62rFSFYmZGp3Iu3O64K2vinQ+dPf8SQA
         DSGCa3pZEqrFCHXb//UW9kxWT6ApKGwNy4ex3lqwMO3LEhkAiOLOjK9OxrR30Cd0/jBh
         CqYH1fvCd6QJkm/4a/TzQ1pROz2iuldSUpJF+rGrUM6llFVmE0QiKYn4lnum2T0pwWvI
         qwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052407; x=1691657207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFJyrm/ZiNcXEHgtiVxfHVXXobkvwFsh8YfUrD95XL4=;
        b=ZITHj8Ld4rqzu3gB+AGCeec0qa7AjvMnSBKme7gZQV+pezt3Uy7zzx/nuJKUM4wXKr
         zZnwgUj5mptJc6k+BOcvk0fG/QZkr87pSNaebeEVMpCGoUvXtyoFeDp2V/9aEeK5Y9Gg
         2A1nNKwDDhaJb3wVDN9GW5+DhVf6gPfq8SHJ0F3433vEVvV7xHClgTKEbiii2U0wV3sx
         blVwQBEMY5fxXXhtoUZL/vuB1R6zJcQUa1V/Vy9NipDHyweUoVhbof7D6J3hAA9NvCNy
         5Ct9ZpwQjdiWHU57BlmcIq1wgOYGN3nZ2WL3S+rLNd0MdL1T89HyMtYab1GsisyFrudt
         neRg==
X-Gm-Message-State: ABy/qLaxeHzogyvufjDQrbYyoSFojILGCNaWdvjjh42P0YLsXLZAGxWu
	ZWkDkbOe0FVZKVKGG131bRDKBLrG71QhpmMuVzmA5w==
X-Google-Smtp-Source: APBJJlHsCtsiC3N+i1vEuxGpMApG0jHu7MckpqgaEOGDBwFbeIbwaYuNN2IEw9Hnryqvjo/oCx7ZEypMm0zZYIiZdy4=
X-Received: by 2002:a05:622a:1493:b0:404:8218:83da with SMTP id
 t19-20020a05622a149300b00404821883damr1418425qtx.1.1691052406822; Thu, 03 Aug
 2023 01:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com> <d1b1c0cc-c542-e626-9f35-8ad0dabb56b0@kernel.org>
In-Reply-To: <d1b1c0cc-c542-e626-9f35-8ad0dabb56b0@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 3 Aug 2023 10:46:34 +0200
Message-ID: <CANP3RGcTAjkPsFgqyeW5Tp9EJT-SrBX2CGVB7Zavkt6sKRKUOg@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Linux NetDev <netdev@vger.kernel.org>, 
	Pengtao He <hepengtao@xiaomi.com>, Willem Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf@google.com>, Xiao Ma <xiaom@google.com>, Patrick Rohr <prohr@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Dave Tucker <datucker@redhat.com>, Vincent Bernat <vincent@bernat.ch>, 
	Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 4:30=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
> Hi Maze,

Hey!

> Great to see you on the netdev list again.

Yeah, I've been mostly busy dealing with userspace issues for a few years n=
ow
(code refactoring/rearchitecting/rewrites for Android mainline updatability=
).
Argh.

Finding so much undocumented cruft while at it... (I still owe
netfilter folks a description
of what an upstream reserved magic bit for xt_idletimer does... and
xt_quota2 is a mess,
evil hacks with RA reception into different routing tables are a thing too.=
..
much of this should really be replaced with bpf... but 4.9 see below...)

Unfortunately that same updatability, has some evil consequences:
We need to keep our existing tip-of-tree code base running on 4.9 for
a few more years...
Super frustrating, I'd love to be able to just assume 5.10...
However, even our brand new code that hasn't been written yet, that
only targets next year's
Android V (or 15 or whatever it ends up being) can only assume a 4.19 kerne=
l.

> I want to kickstart this thread again,

Great!

> as I think it is a general netstack issue that should be solved

Agreed.

> (I was on vacation when thread was active).

I hope you enjoyed it.

> On 21/07/2023 20.14, Eric Dumazet wrote:
> > On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> >>
> >> I've been asked to review:
> >>    https://android-review.googlesource.com/c/platform/packages/modules=
/NetworkStack/+/2648779
> >>
>
> So, this is blocking TCP zero-copy send feature, according to link.

That's the (unverified by me) claim.

> >> where it comes to light that in Android due to background debugging of
> >> connectivity problems
> >> (of which there are *plenty* due to various types of buggy [primarily]
> >> wifi networks)
> >> we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:
> >>
>
> Many userspace programs/daemons have a permanent AF_PACKET (sock_raw
> "tcpdump") socket running with a cBPF filter attached.
>
> Examples of programs:
>   - DHCP clients and servers.
>   - LLDP (Link Layer Discovery Protocol) daemons (Cc. Vincent)
>   - Path MTU daemons (https://github.com/cloudflare/pmtud/) (Cc Marek)
>   - etc.

I think a fair number of these can get by with non-ETH_P_ALL
(for example ETH_P_LLDP), or can use a different socket for RX
(where you can choose to not see your own TX packets)
and transmit via ETH_P_NONE (btw. that constant should really exist
and be equal to 0)

I believe DHCP servers don't need raw sockets at all, and clients only
need them for very short bursts of time during the initial request.
(most DHCP can be done with normal UDP sockets)
[I *think* DHCP only needs a raw socket to send the initial src-ip-less pac=
ket,
and even that might possibly happen without a raw socket - I seem to recall
seeing our ipv6-only servers generating src ip 0.0.0.0 packets at some
point in the past]

Now of course I don't know whether they're actually written to work that wa=
y...
Back in Google server land I recall spending a fair bit of time many years
ago trying to track down and kill raw socket abusers in system daemons...
Along the way we fixed our lldp daemon, and fixed some upstream bonding
vs ETH_P_LLDP socket behaviour issues as well (on inactive slaves ifirc).

AFAICR it is worth remembering that:
AF_PACKET/ETH_P_ALL + cbpf ethetrype=3DX
and
AF_PACKET/ETH_P_X
 don't quite catch the same packets.

FWICR at least on RX ETH_P_ALL is earlier than ETH_P_X, I think this matter=
s
for bonding and tc ingress ebpf packet modifications? which happen between =
them.
The ingress interface might change as well (from the bonding slave to
the master)...
and or packets may be dropped if the slave is inactive...
there's also some special handling of link-local mac addresses (lldp).

Indeed the Android receive path 464XLAT [clat] even depends on this.
tcpdump uses ETH_P_ALL - and sees incoming unmodified packets
tc ingress ebpf rewrites ipv6 to ipv4 if possible (and bpf_redirects
to a v4 interface)
clatd userspace daemon uses ETH_P_IPV6 + cbpf dstip to catch remaining
untranslated packets and translate them in userspace
ip6tables drops packets to clat ipv6 dst ip

This means ETH_P_ALL + setsockopt(SOL_PACKET, ETHERTYPE_FILTER, LLDP)
would potentially make sense...

> >>     arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and ip6=
[40] <=3D 136)
> >>
> >> ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
> >>
> >> If I'm reading the kernel code right this appears to cause skb_clone()
> >> to be called on *every* outgoing packet,
> >> even though most packets will not be accepted by the filter.
> >>
>
> So, you are saying the issue only occurs for TX ?

Well that's what the patch claims...
There is some asymmetry between RX and TX.
I don't claim to understand the intricacies of the code at all.

But it does seem logical that on RX you get a packet you own wholesale
from the nic
(refcnt=3D1) and you can to some initial parsing (extract ethertype, get
link layer pointers right),
then even if you clone/run filter/discard it, that's just a refcnt ++ && --=
?
You don't need any packet mutations to run the filter.

While on TX you get a potentially dirty skb with refcnt>1 and you
can't modify it?

I don't know... I would need to dig *much* deeper into this.

I vaguely recall looking at the RX path cbpf filtering logic years ago and
coming to the conclusion it was OK.  But I make no guarantees.

I still find skb's to be absolutely chock full of magic ;-)

> Would it be an option to change your AF_PACKET socket to ignore outgoing
> traffic?

That's what the linked patch does.  And, no, we want to see both what we se=
nd
and the responses (or lack there-of).
>
> For some of the daemons (listed above) it might be possible to ignore
> outgoing packets, and thus not enable the TX hook and thus avoid the skb
> cloning.

Right, but that's not the case here.

> >> (In the TX path the filter appears to get called *after* the clone,
> >> I think that's unlike the RX path where the filter is called first)
> >>
>
> I don't fully understand what you are saying here.
> Is the RX path affected or not?

I think it isn't... but I have yet to devote the time to really
understand the topic.

> >> Unfortunately, I don't think it's possible to eliminate the
> >> functionality this socket provides.
> >> We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> >> bugreports / etc.
> >> and they *really* should be in order wrt. to each other.
> >> (and yeah, that means last few minutes history when an issue happens,
> >> so not possible to simply enable it on demand)
> >>
> >> We could of course split the socket into 3 separate ones:
> >> - ETH_P_ARP
> >> - ETH_P_IP + cbpf udp dport=3Ddhcp
> >> - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
> >>
> >> But I don't think that will help - I believe we'll still get
> >> skb_clone() for every outbound ipv4/ipv6 packet.
> >>
>
> I assume this would not help, as it would travel same code path, to
> dev_queue_xmit_nit, right?

It would not help - except - that we would have multiple sockets,
and thus the filters on each would be much simpler...
which in turn means some sort of
  'is there a byte with value X at offset Y'
prefilter would become feasible.

> >> I have some ideas for what could be done to avoid the clone (with
> >> existing kernel functionality)... but none of it is pretty...
> >> Anyone have any smart ideas?
> >>
> >> Perhaps a way to move the clone past the af_packet packet_rcv run_filt=
er?
> >> Unfortunately packet_rcv() does a little bit of 'setup' before it
> >> calls the filter - so this may be hard.
> >
> >
> > dev_queue_xmit_nit() also does some 'setup':
> >
> > net_timestamp_set(skb2);  (This one could probably be moved into
> > af_packet, if packet is not dropped ?)
> > <sanitize mac, network, transport headers>
> >
>
> Regarding AF_PACKET socket to ignore outgoing, I think the
> (ptype->ignore_outgoing) in top of dev_queue_xmit_nit() list-loop is
> doing that trick and thus avoids the skb_clone().

Yes, I agree (and this part I did see before I started the thread).

> >> Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
> >> very minimal
> >> functionality... like match 2 bytes at an offset into the packet?
> >> Maybe even not a hook at all, just adding a
> >> prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> >> It doesn't have to be perfect, but if it could discard 99% of the
> >> packets we don't care about...
> >> (and leave filtering of the remaining 1% to the existing cbpf program)
> >> that would already be a huge win?
> >
> > Maybe if we can detect a cBPF filter does not access mac, network,
> > transport header,
> > we could run it earlier, before the clone().

While this filter is indeed using absolute offsets right now,
I am actually in the process of switching it over to using SKF_NET_OFF
relatives...
https://android-review.googlesource.com/c/platform/packages/modules/Network=
Stack/+/2674195
because it handles more cases correctly.
I guess we'd undo that if it ended up required for speed...
(we could always just filter the rawip and ether cases separately or someth=
ing)

> > So we could add
> > prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone
> >
> > Or maybe we can remove sanitization, because BPF should not do bad
> > things if these headers are garbage ?
> >
>
> To Maze, have you looked at PoC coding what Eric suggested?
> (Prework that allows us to to move filter)

No, not yet.

> >> Thoughts?
> >>
>
> What are your plans for working on a solution for this?

Nothing atm, I'll probably go back to it at some point if nothing happens.
But I'm unlikely to come up with something that isn't a kludge
(like an extra prefilter or two).
I have nowhere near enough understanding of how all the pieces fit
together here.

I've been hoping someone with more knowledge of the stack would
be able to figure out if this is a real problem, and whether it is fixable,
or whether we need kludges.  I can write the kludges :-)

