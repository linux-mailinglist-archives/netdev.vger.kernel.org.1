Return-Path: <netdev+bounces-47116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343B7E7D28
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF87BB20C30
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C01C286;
	Fri, 10 Nov 2023 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRN8qqWN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73371BDF1
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:50:33 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532339CDD
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:50:31 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso454155276.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699627830; x=1700232630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdetoPi/fMl4CXLyGLeXpz69T5bIDCd3i84eo578Wj0=;
        b=lRN8qqWNj8+KRgnVxuVci5MsE9+GTTh2IlyUQ5+Pl22BgOzSXmPehHfuUWzguWZL30
         3XnA1W4LmAZTT4NVLZptRjj8JVpGpGTm+YyAk51I55rlNU7RCy5BVFSIyz2y+s0TgJbD
         QcMOPNwgnD95Kp0FkzQWiI+zJfWRASnNTEO9sNvXkZ7BraF7yIYGHz0IsLAa1F3MSxzx
         jrgJjhedH8+GJc6AKMBPFuQgzrUe/1OKkc9FiX1iaSrMQSRvE/WD2czbNsT0ldBBHUow
         gV/bpaGzLI+xS+UJ1aqRH+lgzqr4ZirbNSdSWocw+VZos4P6srTURAE54O5I6GVWzB7d
         dmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627830; x=1700232630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdetoPi/fMl4CXLyGLeXpz69T5bIDCd3i84eo578Wj0=;
        b=f5KHfw1MVA3QsHM3/1MLgm2zQS4P8wX+B9b1yk6Sf9qDNMSqKGdXw2qzrI7yVeF8Ag
         GOOph2E+CiHuJzlLLHTVOs793YHI3+nUlqv4R7CmZM1BZX2CDYk5wUKBrgZB4HiN1pTL
         rJin0m7SiFL74r3E/AmHfsVpigv++Apa8WVQjXb1PFb1pMNPl0pAfGymF0EB42Xr1V4I
         ew9ImaeT5oFCcj4rHIztSYfNcsrefwniohZbhJjie8MYF8le3CmMkqm7Klij/CuOU6nT
         pe6pnfkeoy7FAWozsFludvPgYca4ar4PJ7GpJ8qEu50vI+FUOPwKVTEY+yFp22Sx62tU
         qHyw==
X-Gm-Message-State: AOJu0Yyokexjuau7gItMCFhwZabsy2QvUSuq7i2LkVckfpu838d5+fM4
	EDwbwFIsVXNVfksntpFi+HEeiR9ogpgaO4PVyhXH5udMNkY=
X-Google-Smtp-Source: AGHT+IFk/iDWtH0OiyL0EgBa0D8iZafDC2vA6fZgyWxIeq44JvZx0G0XW/ny40ZJlWKWZWKXz4CM9G4DiPQ6vi0zerg=
X-Received: by 2002:a05:6902:1007:b0:da0:86e8:aea4 with SMTP id
 w7-20020a056902100700b00da086e8aea4mr9052247ybt.57.1699627830357; Fri, 10 Nov
 2023 06:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
 <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com>
 <CADvbK_fR62L+EwjW739MbCXJRFDfW5UTQ1bRrjMhc+cgyGN-dA@mail.gmail.com>
 <CANn89i+Ef7zNz7t6U2_6VEHPDantgyR8d0w3ALOBVVwK0Fe=FQ@mail.gmail.com> <CADvbK_epdT+s-peW9v1oKGrTfttrVFCgSLkdwLLBAT2N+ZDdMQ@mail.gmail.com>
In-Reply-To: <CADvbK_epdT+s-peW9v1oKGrTfttrVFCgSLkdwLLBAT2N+ZDdMQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 10 Nov 2023 09:50:15 -0500
Message-ID: <CADvbK_fzsXeqmayPkR4BDnkrgKDJcRd5bUXp0JNXSu8rfj-F-A@mail.gmail.com>
Subject: Re: tcpdump and Big TCP
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 2, 2023 at 2:59=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> On Mon, Oct 2, 2023 at 1:26=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Mon, Oct 2, 2023 at 7:19=E2=80=AFPM Xin Long <lucien.xin@gmail.com> =
wrote:
> > >
> > > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Oct 2, 2023 at 6:20=E2=80=AFPM David Ahern <dsahern@kernel.=
org> wrote:
> > > > >
> > > > > Eric:
> > > > >
> > > > > Looking at the tcpdump source code, it has a GUESS_TSO define tha=
t can
> > > > > be enabled to dump IPv4 packets with tot_len =3D 0:
> > > > >
> > > > >         if (len < hlen) {
> > > > > #ifdef GUESS_TSO
> > > > >             if (len) {
> > > > >                 ND_PRINT("bad-len %u", len);
> > > > >                 return;
> > > > >             }
> > > > >             else {
> > > > >                 /* we guess that it is a TSO send */
> > > > >                 len =3D length;
> > > > >             }
> > > > > #else
> > > > >             ND_PRINT("bad-len %u", len);
> > > > >             return;
> > > > > #endif /* GUESS_TSO */
> > > > >         }
> > > > >
> > > > >
> > > > > The IPv6 version has a similar check but no compile change needed=
:
> > > > >         /*
> > > > >          * RFC 1883 says:
> > > > >          *
> > > > >          * The Payload Length field in the IPv6 header must be se=
t to zero
> > > > >          * in every packet that carries the Jumbo Payload option.=
  If a
> > > > >          * packet is received with a valid Jumbo Payload option p=
resent and
> > > > >          * a non-zero IPv6 Payload Length field, an ICMP Paramete=
r Problem
> > > > >          * message, Code 0, should be sent to the packet's source=
, pointing
> > > > >          * to the Option Type field of the Jumbo Payload option.
> > > > >          *
> > > > >          * Later versions of the IPv6 spec don't discuss the Jumb=
o Payload
> > > > >          * option.
> > > > >          *
> > > > >          * If the payload length is 0, we temporarily just set th=
e total
> > > > >          * length to the remaining data in the packet (which, for=
 Ethernet,
> > > > >          * could include frame padding, but if it's a Jumbo Paylo=
ad frame,
> > > > >          * it shouldn't even be sendable over Ethernet, so we don=
't worry
> > > > >          * about that), so we can process the extension headers i=
n order
> > > > >          * to *find* a Jumbo Payload hop-by-hop option and, when =
we've
> > > > >          * processed all the extension headers, check whether we =
found
> > > > >          * a Jumbo Payload option, and fail if we haven't.
> > > > >          */
> > > > >         if (payload_len !=3D 0) {
> > > > >                 len =3D payload_len + sizeof(struct ip6_hdr);
> > > > >                 if (length < len)
> > > > >                         ND_PRINT("truncated-ip6 - %u bytes missin=
g!",
> > > > >                                 len - length);
> > > > >         } else
> > > > >                 len =3D length + sizeof(struct ip6_hdr);
> > > > >
> > > > >
> > > > > Maybe I am missing something, but it appears that no code change =
to
> > > > > tcpdump is needed for Linux Big TCP packets other than enabling t=
hat
> > > > > macro when building. I did that in a local build and the large pa=
ckets
> > > > > were dumped just fine.
> > > > >
> > > Right, wireshark/tshark currently has no problem parsing BIG TCP IPv4=
 packets.
> > > I think it enables GUESS_TSO by default.
> > >
> > > We also enabled GUESS_TSO in tcpdump for RHEL-9 when BIG TCP IPv4 was
> > > backported in it.
> >
> > Make sure to enable this in tcpdump source, so that other distros do
> > not have to 'guess'.
> Looks the tcpdump maintainer has posted one:
>
A couple of updates:

> https://github.com/the-tcpdump-group/tcpdump/pull/1085
In tcpdump, this one has been Merged into master and tcpdump-4.99 branch.
It means tcpdump has officially supported BIG TCP parsing on upstream and
its next release version.

For wireshark, according to the maintainer Guy Harris,
Code in Wireshark to deal with the total length being 0 in the IPv4 header
dates back to at least 2012.

For the TP_STATUS from packet socket including our TP_STATUS_GSO_TCP,
it has been merged into the pcapng IETF draft doc:

  https://github.com/IETF-OPSAWG-WG/draft-ietf-opsawg-pcap/pull/144

and the next step is to implement it in both tcpdump and wireshark.

But in my opinion, this doesn't block the IPv6 jumbo headers removal,
as both tcpdump and wireshark now have no issue to parse BIG TCP packets.

Thanks.

>
> >
> > >
> > > >
> > > > My point is that tcpdump should not guess, but look at TP_STATUS_GS=
O_TCP
> > > > (and TP_STATUS_CSUM_VALID would also be nice)
> > > >
> > > > Otherwise, why add TP_STATUS_GSO_TCP in the first place ?
> > > That's for more reliable parsing in the future.
> >
> > We want this. I thought this was obvious.
> >
> > >
> > > As currently in libpcap, it doesn't save meta_data(like
> > > TP_STATUS_CSUM_VALID/GSO_TCP)
> > > to 'pcap' files, and it requires libpcap APIs change and uses the
> > > 'pcap-ng' file format.
> > > I think it will take quite some time to implement in userspace.
> >
> > Great. Until this is implemented as discussed last year, we will not re=
move
> > IPv6 jumbo headers.
> I will get back to this libpcap APIs and pcap-ng things, and let you
> know when it's done.
>
> Thanks.

