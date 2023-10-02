Return-Path: <netdev+bounces-37484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B67B58B9
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 91480B20D70
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E11E500;
	Mon,  2 Oct 2023 17:26:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE01DA4A
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:26:17 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D74B3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:26:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so645a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696267574; x=1696872374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+THaq8uFiTd4DrxZR5TG4ua1xeBVAbWIqdUZDzylDcQ=;
        b=wHDvukclocxwTKJLnfJIqsfWcyjNC6lycZiJ9/MT2rIocLUrdAjmigXttjWCdPRqKB
         3EVApsRrs74j4fQQawO3/6+v+9luDU5ATgjC5A9QXkkBEOC2IN5BkGz//eXqoS2FdAtB
         f/rPRWkU9d/dzrkiazciRuZUypCxXmBYQOVXVogC71DQp5IYfLx9zWakg0qeaFYRVVfk
         Aqahm1wGaBBQUcbEDg6Gyej40Rda2THrtaAoHWIz/mzKu1vrOcNrJHRoUDFiUsVXGz9Q
         +7ZDIdTrU1N8Sw8ZP9d2vNZmbAJNvrfgKERWvknZy/WsNE+qckq2jTsq03WW2sub4VMN
         LTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267574; x=1696872374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+THaq8uFiTd4DrxZR5TG4ua1xeBVAbWIqdUZDzylDcQ=;
        b=wS5Lq7TnZjntXbtYYQHFZnJdQJmPkQTtJGtpldQRPQbgSAKXaw7uQQzeksSpMRcLMC
         0ecATxiOGhOqqUUgZ1zORojuAwoERvhlxsrjv0t0knb2icAi1dYl8TwXI5rWYorToSn+
         LIrHDCuOYh1QgOlR2cuh4kYHerTanDhSNfSSUEZhq6OuEru0HRa6/KsJV0+frlp9RMt5
         O+80P8FD5KgH0mFspk2XeRRAChNF0HmHE9ILW29G7dNWvPpizihbaNiqaq9NFTWCWfGB
         XQ+gSyVNWi+hJ14oJyHIwDT+NhDlLy+bxjKzbIyy/2fMHDSuZd8UAIHPq252PTQqhRbv
         HzpQ==
X-Gm-Message-State: AOJu0YwFZJzSLBoyjoTKFxOUyaoc+0lqUxRcWh5OckVLJx/PEYSeL51O
	AdgBD7OJzYlXu7gPfmUAzcYjxla7d418rUro+xGoR14twp4XA8q+yEw=
X-Google-Smtp-Source: AGHT+IFSJAaxaYGn/cTTZr9aRWqq0XkQILGjOJnA25hwlrkNvW0AEw69hcLSh6nqbLQ2P62X0ztV2KCnqJ0dT1fFIbA=
X-Received: by 2002:a50:d602:0:b0:52f:5697:8dec with SMTP id
 x2-20020a50d602000000b0052f56978decmr9508edi.4.1696267573623; Mon, 02 Oct
 2023 10:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
 <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com> <CADvbK_fR62L+EwjW739MbCXJRFDfW5UTQ1bRrjMhc+cgyGN-dA@mail.gmail.com>
In-Reply-To: <CADvbK_fR62L+EwjW739MbCXJRFDfW5UTQ1bRrjMhc+cgyGN-dA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Oct 2023 19:26:00 +0200
Message-ID: <CANn89i+Ef7zNz7t6U2_6VEHPDantgyR8d0w3ALOBVVwK0Fe=FQ@mail.gmail.com>
Subject: Re: tcpdump and Big TCP
To: Xin Long <lucien.xin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 7:19=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Oct 2, 2023 at 6:20=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> > >
> > > Eric:
> > >
> > > Looking at the tcpdump source code, it has a GUESS_TSO define that ca=
n
> > > be enabled to dump IPv4 packets with tot_len =3D 0:
> > >
> > >         if (len < hlen) {
> > > #ifdef GUESS_TSO
> > >             if (len) {
> > >                 ND_PRINT("bad-len %u", len);
> > >                 return;
> > >             }
> > >             else {
> > >                 /* we guess that it is a TSO send */
> > >                 len =3D length;
> > >             }
> > > #else
> > >             ND_PRINT("bad-len %u", len);
> > >             return;
> > > #endif /* GUESS_TSO */
> > >         }
> > >
> > >
> > > The IPv6 version has a similar check but no compile change needed:
> > >         /*
> > >          * RFC 1883 says:
> > >          *
> > >          * The Payload Length field in the IPv6 header must be set to=
 zero
> > >          * in every packet that carries the Jumbo Payload option.  If=
 a
> > >          * packet is received with a valid Jumbo Payload option prese=
nt and
> > >          * a non-zero IPv6 Payload Length field, an ICMP Parameter Pr=
oblem
> > >          * message, Code 0, should be sent to the packet's source, po=
inting
> > >          * to the Option Type field of the Jumbo Payload option.
> > >          *
> > >          * Later versions of the IPv6 spec don't discuss the Jumbo Pa=
yload
> > >          * option.
> > >          *
> > >          * If the payload length is 0, we temporarily just set the to=
tal
> > >          * length to the remaining data in the packet (which, for Eth=
ernet,
> > >          * could include frame padding, but if it's a Jumbo Payload f=
rame,
> > >          * it shouldn't even be sendable over Ethernet, so we don't w=
orry
> > >          * about that), so we can process the extension headers in or=
der
> > >          * to *find* a Jumbo Payload hop-by-hop option and, when we'v=
e
> > >          * processed all the extension headers, check whether we foun=
d
> > >          * a Jumbo Payload option, and fail if we haven't.
> > >          */
> > >         if (payload_len !=3D 0) {
> > >                 len =3D payload_len + sizeof(struct ip6_hdr);
> > >                 if (length < len)
> > >                         ND_PRINT("truncated-ip6 - %u bytes missing!",
> > >                                 len - length);
> > >         } else
> > >                 len =3D length + sizeof(struct ip6_hdr);
> > >
> > >
> > > Maybe I am missing something, but it appears that no code change to
> > > tcpdump is needed for Linux Big TCP packets other than enabling that
> > > macro when building. I did that in a local build and the large packet=
s
> > > were dumped just fine.
> > >
> Right, wireshark/tshark currently has no problem parsing BIG TCP IPv4 pac=
kets.
> I think it enables GUESS_TSO by default.
>
> We also enabled GUESS_TSO in tcpdump for RHEL-9 when BIG TCP IPv4 was
> backported in it.

Make sure to enable this in tcpdump source, so that other distros do
not have to 'guess'.

>
> >
> > My point is that tcpdump should not guess, but look at TP_STATUS_GSO_TC=
P
> > (and TP_STATUS_CSUM_VALID would also be nice)
> >
> > Otherwise, why add TP_STATUS_GSO_TCP in the first place ?
> That's for more reliable parsing in the future.

We want this. I thought this was obvious.

>
> As currently in libpcap, it doesn't save meta_data(like
> TP_STATUS_CSUM_VALID/GSO_TCP)
> to 'pcap' files, and it requires libpcap APIs change and uses the
> 'pcap-ng' file format.
> I think it will take quite some time to implement in userspace.

Great. Until this is implemented as discussed last year, we will not remove
IPv6 jumbo headers.

