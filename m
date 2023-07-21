Return-Path: <netdev+bounces-19977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C787675D125
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C4A1C217AF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF920F8E;
	Fri, 21 Jul 2023 18:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720F20F83
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:14:49 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F98E68
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:14:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40550136e54so34101cf.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963287; x=1690568087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq9tbPfjHACuwIEGh6Lcnb/gEl2loUSJs/I4zR217/o=;
        b=VhRmilNxsCrVlEEY6w+JGSnsAxEhvmG51blKvm9f7+kYXnnOGDjrAxxFkzIrrqzWJG
         y5aR3HiKa31020P9fZ8IHwFrKXhl5lPrzTpX6lK3ygMmYkMMyh2uyG7c4FMSQ/34UhS2
         ubcHXijcblwg9/FV3j1Z90nI5OgahCYNd3zd8o+9+NfypUJdleppGxYLwT77SWgY/n9d
         TN22ZZRdIuEHvo3eqSo+snrpxXB3T2dprhsDbRxEHCMmL0NtMwnqU9erNUuE8+dnLCex
         DNPv31h0Mdz3dbtN3RWawEElMAdEUJoef50BvmT5eLyh4wl9EJJQQoyUNaPrs05aOOZZ
         3D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963287; x=1690568087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq9tbPfjHACuwIEGh6Lcnb/gEl2loUSJs/I4zR217/o=;
        b=QE2z675lL9JK81Mpr1z+HAQAl0Nq2qyB2iEgc/BYiXgA7G4Z/aFypgX5RLPykckrbe
         fbYD4qAzN+6Bb9Elc6f0DjYuoCqZOJZWY7A16m2gGYmDf3MxZER8G4tzDZ9p6i8hih4o
         4dSMFntrea80+YO6xlgycQyjgte7WKHR1u8eTx6eBpsEt35Xj4MbdpwYrHEwkRsm5P9a
         J8FMcaBhwTNJfHC9QqYUJjYnWJouaMM54r0GoOALjLIpjw2L2GPlSnwFxtF/iKyXz2kw
         VHrgX8l19UI0LhC7xOckQHhxcyKrr3P7hi7UJHpsT1g4Dekznidaxk2bsBGk4HSV73ii
         IULQ==
X-Gm-Message-State: ABy/qLZelylgCmUPsmHu5mgSMutY1kyI70PE0Ch22Wcp5itQGnOobz3K
	/EbGDemOZUD0qk+kHci0pdiFxhgtM9vBwq+k4po55w==
X-Google-Smtp-Source: APBJJlEbXlrrIVgJIPC0zq3BH9Yag576uV/b0Kh88vKGb23+l/UZnlh20fMW6ib1Ga2SBaTUmEXlFOyn36aruRP7kdI=
X-Received: by 2002:ac8:5a4f:0:b0:3fa:3c8f:3435 with SMTP id
 o15-20020ac85a4f000000b003fa3c8f3435mr18542qta.27.1689963286911; Fri, 21 Jul
 2023 11:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
In-Reply-To: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Jul 2023 20:14:35 +0200
Message-ID: <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
Subject: Re: Performance question: af_packet with bpf filter vs TX path skb_clone
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Linux NetDev <netdev@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Willem Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf@google.com>, Xiao Ma <xiaom@google.com>, Patrick Rohr <prohr@google.com>, 
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

On Fri, Jul 21, 2023 at 7:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> I've been asked to review:
>   https://android-review.googlesource.com/c/platform/packages/modules/Net=
workStack/+/2648779
>
> where it comes to light that in Android due to background debugging of
> connectivity problems
> (of which there are *plenty* due to various types of buggy [primarily]
> wifi networks)
> we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:
>
>    arp or (ip and udp port 68) or (icmp6 and ip6[40] >=3D 133 and ip6[40]=
 <=3D 136)
>
> ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)
>
> If I'm reading the kernel code right this appears to cause skb_clone()
> to be called on *every* outgoing packet,
> even though most packets will not be accepted by the filter.
>
> (In the TX path the filter appears to get called *after* the clone,
> I think that's unlike the RX path where the filter is called first)
>
> Unfortunately, I don't think it's possible to eliminate the
> functionality this socket provides.
> We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
> bugreports / etc.
> and they *really* should be in order wrt. to each other.
> (and yeah, that means last few minutes history when an issue happens,
> so not possible to simply enable it on demand)
>
> We could of course split the socket into 3 separate ones:
> - ETH_P_ARP
> - ETH_P_IP + cbpf udp dport=3Ddhcp
> - ETH_P_IPV6 + cbpf icmpv6 type=3DNS/NA/RS/RA
>
> But I don't think that will help - I believe we'll still get
> skb_clone() for every outbound ipv4/ipv6 packet.
>
> I have some ideas for what could be done to avoid the clone (with
> existing kernel functionality)... but none of it is pretty...
> Anyone have any smart ideas?
>
> Perhaps a way to move the clone past the af_packet packet_rcv run_filter?
> Unfortunately packet_rcv() does a little bit of 'setup' before it
> calls the filter - so this may be hard.


dev_queue_xmit_nit() also does some 'setup':

net_timestamp_set(skb2);  (This one could probably be moved into
af_packet, if packet is not dropped ?)
<sanitize mac, network, transport headers>

>
> Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
> very minimal
> functionality... like match 2 bytes at an offset into the packet?
> Maybe even not a hook at all, just adding a
> prot_hook.prefilter{1,2}_u64_{offset,mask,value}
> It doesn't have to be perfect, but if it could discard 99% of the
> packets we don't care about...
> (and leave filtering of the remaining 1% to the existing cbpf program)
> that would already be a huge win?

Maybe if we can detect a cBPF filter does not access mac, network,
transport header,
we could run it earlier, before the clone().

So we could add
prot_hook.filter_can_run_from_dev_queue_xmit_nit_before_the_clone

Or maybe we can remove sanitization, because BPF should not do bad
things if these headers are garbage ?

>
> Thoughts?
>
> Thanks,
> Maciej

