Return-Path: <netdev+bounces-37482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F487B58AE
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 50EB5282A86
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E291DDF1;
	Mon,  2 Oct 2023 17:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151A1A73C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:19:18 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E9AD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:19:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d865854ef96so15571683276.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696267156; x=1696871956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwLsLTGUTG+7Pk0xfQdwytk3Z16ScSmfgonwV2FIY5E=;
        b=ZfLH7CrYRjx2/zxYu7o1ENB2+Ta9dKPFGCkHzrumf+djHe/yOzO5G9Xm1IrcoOxDPr
         VvOJI1gBd1bwLf6eQ2jIDh8T4W1ANPvyU0DVkiM4R02YZba1hQlLoDpOZud/VDJ7s7VN
         IDfdhBxQjQXnoP22Sy9nFimMtgc2hQRnt1OadXPWvxybZM2j5GBxu9aC3zfaQ98DKwjb
         ikLU/HbNMxFsRKdDVBJJ1Pr1KFFkw7XDeRaVT0SBSi9+xlwJ/EkFrP0imFHlNvXcOdTb
         3G23iPG1EJmPK+doSqycTHhJX2nu2qqjRQm+AP7PvdHhXbHT+8EMb+G5/euV8aaJI01G
         rA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267156; x=1696871956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwLsLTGUTG+7Pk0xfQdwytk3Z16ScSmfgonwV2FIY5E=;
        b=cKvoiMGVDMOQNNNdPBlJPTIK7FKpMMDKWY6XJfLTAFpKonARGXXpr2iY/Hxdg1x1ex
         99DWX7h/uYG7QbWdHcVocivjfhBN+h/bwkTHhX9IH9knLQ3JYyg++x5c0Q2kM6huwIno
         WJlu3c+UGAkM9D6mvKksfM89BOzmTPIgWsOLpK6AEAGdfmHlvFscpu7SutBofFiYj6GN
         V4GXXoMRpgQVR/MQSsWaC/gNFl2nMbTgsLy7cwqKQWO5jZnPoZb4aVz0kWjcvwynvDag
         8rjUI6EuZQN2ZP6k2Xm2zbJKQMJqbLUrDM6xf38IspZUy0w3Sg5T2lKPFyU1/9JVxWh5
         erUQ==
X-Gm-Message-State: AOJu0YxggONLIMHG2GzykksmHhjNkBb/Bul9chREwW435xhG+xvIZslq
	YwR9wPCG/M/N+4bv9mK0vT/Eu1Ed428jDZLcyJs=
X-Google-Smtp-Source: AGHT+IHWxTwkk4vGC6YrFONdZUOpdhelXAvPmYhTS/4jYZ3ztQHXMY1lvUQXiQIH+CDjgJfyagYbuoGzUvLEvooGX6c=
X-Received: by 2002:a25:cb06:0:b0:d81:9612:46fe with SMTP id
 b6-20020a25cb06000000b00d81961246femr11775188ybg.57.1696267156125; Mon, 02
 Oct 2023 10:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org> <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com>
In-Reply-To: <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 2 Oct 2023 13:19:04 -0400
Message-ID: <CADvbK_fR62L+EwjW739MbCXJRFDfW5UTQ1bRrjMhc+cgyGN-dA@mail.gmail.com>
Subject: Re: tcpdump and Big TCP
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 2, 2023 at 6:20=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
> >
> > Eric:
> >
> > Looking at the tcpdump source code, it has a GUESS_TSO define that can
> > be enabled to dump IPv4 packets with tot_len =3D 0:
> >
> >         if (len < hlen) {
> > #ifdef GUESS_TSO
> >             if (len) {
> >                 ND_PRINT("bad-len %u", len);
> >                 return;
> >             }
> >             else {
> >                 /* we guess that it is a TSO send */
> >                 len =3D length;
> >             }
> > #else
> >             ND_PRINT("bad-len %u", len);
> >             return;
> > #endif /* GUESS_TSO */
> >         }
> >
> >
> > The IPv6 version has a similar check but no compile change needed:
> >         /*
> >          * RFC 1883 says:
> >          *
> >          * The Payload Length field in the IPv6 header must be set to z=
ero
> >          * in every packet that carries the Jumbo Payload option.  If a
> >          * packet is received with a valid Jumbo Payload option present=
 and
> >          * a non-zero IPv6 Payload Length field, an ICMP Parameter Prob=
lem
> >          * message, Code 0, should be sent to the packet's source, poin=
ting
> >          * to the Option Type field of the Jumbo Payload option.
> >          *
> >          * Later versions of the IPv6 spec don't discuss the Jumbo Payl=
oad
> >          * option.
> >          *
> >          * If the payload length is 0, we temporarily just set the tota=
l
> >          * length to the remaining data in the packet (which, for Ether=
net,
> >          * could include frame padding, but if it's a Jumbo Payload fra=
me,
> >          * it shouldn't even be sendable over Ethernet, so we don't wor=
ry
> >          * about that), so we can process the extension headers in orde=
r
> >          * to *find* a Jumbo Payload hop-by-hop option and, when we've
> >          * processed all the extension headers, check whether we found
> >          * a Jumbo Payload option, and fail if we haven't.
> >          */
> >         if (payload_len !=3D 0) {
> >                 len =3D payload_len + sizeof(struct ip6_hdr);
> >                 if (length < len)
> >                         ND_PRINT("truncated-ip6 - %u bytes missing!",
> >                                 len - length);
> >         } else
> >                 len =3D length + sizeof(struct ip6_hdr);
> >
> >
> > Maybe I am missing something, but it appears that no code change to
> > tcpdump is needed for Linux Big TCP packets other than enabling that
> > macro when building. I did that in a local build and the large packets
> > were dumped just fine.
> >
Right, wireshark/tshark currently has no problem parsing BIG TCP IPv4 packe=
ts.
I think it enables GUESS_TSO by default.

We also enabled GUESS_TSO in tcpdump for RHEL-9 when BIG TCP IPv4 was
backported in it.

>
> My point is that tcpdump should not guess, but look at TP_STATUS_GSO_TCP
> (and TP_STATUS_CSUM_VALID would also be nice)
>
> Otherwise, why add TP_STATUS_GSO_TCP in the first place ?
That's for more reliable parsing in the future.

As currently in libpcap, it doesn't save meta_data(like
TP_STATUS_CSUM_VALID/GSO_TCP)
to 'pcap' files, and it requires libpcap APIs change and uses the
'pcap-ng' file format.
I think it will take quite some time to implement in userspace.

Thanks.

