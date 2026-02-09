Return-Path: <netdev+bounces-257889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF9eL4VOiWlm6QQAu9opvQ
	(envelope-from <netdev+bounces-257889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:03:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DF10B481
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A9313002B7C
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94D1D6193;
	Mon,  9 Feb 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OvosIXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0B2ECE93
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606200; cv=pass; b=FXQpzPbFRt2v+74YESsApUv+lYG49UxKkgMjAxZbtGUJ2aOXzdNAFoPnwFbv6qprEeYGbP7MN6j1sXJM9aQelI4IYObwYFQdloiEbMByUAfTWQQjNVXq6ZtnjcfUoM6F2MWwvkyAlhdzmCOqM330UfYeKiRAuw6B0bA0pes6ayA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606200; c=relaxed/simple;
	bh=A1vj4gh9glfmELNvlW5b6RZzpvenLzZgUTyMY2dL1Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYOAReTbPwH0ffDZlrIGLGV4vEwIdZsgnpih4SmpiNgmxV6F9sg9Uxg8Vqe1H0WChv9Jl7xOADv3Cui1jpc1p/MODyYgzIJAKHcbTYU0vg9wvpAisQCbKAbFZSi34+dwLk01MG7F/0ilKQI56u5TLiF3ifHolVFEgPz+RELUeeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OvosIXo; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50299648ae9so740381cf.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 19:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770606199; cv=none;
        d=google.com; s=arc-20240605;
        b=fJMEX12IM+yPw771mBknqzzs6JY/3SiwW0puzjPWNngD/WcVRBr9wzbr3MIhTDVn0J
         /O+NC3ZOYdF1beJHsbwMn/j2JLPBSk6z6d9nkN96mcmYVY1+eSD/LPCzRBu0ankEim7m
         CC49yUPseZ/gzxot8r/ZLXyTE/uQl0aOiwxMzMDU9KXAlvKt6ab8o9iKTgEEpmLO1I7i
         ITvwHaWIlR4PrMsIxMvgs03UEngCGsZxCYa7xIrIj79hjrBKxTYp4tbouQkbVvQYVlTV
         BchrWljSb1Ju/h8u3PXcIx1caj1Nd4VeVBiZA0DQPfHC4Yy1quydDjUWOpt/C0Zx1Dig
         Mc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9wK0s6WNY7JHGKFbOusdpN6KZBi0XPPQ6s0A03O5cww=;
        fh=VxzoYdzDONmBnNMfi/3obQSNKCvJL4jJ3JeSqYnE6T4=;
        b=Zhg1AlpLYsenMG643rgCc5KLYjxQKnuNcfYd8EJQiGY1mZBoLTajrtVdn9Dt2WQmdq
         ndk6I1E4a0eUfx5Tqqm5HtdsRYivu4p0CwJzxfTGTc9RL9HhV7a5nmJpqQiQtVu22yP9
         JW5Fn+5Kr/OOMdid4EOnAPjO+QKZoD0tVhanGIUgVGuC31KjUkHdzY4zLLPgLtN6oDbK
         sqcyMyovTF5Jp6Xbmb4ZU76Iyk5PD40sBd4YhiLgwabGXwWe+HGLkjC3TsJl/XhfWXNd
         S9lfbdkWpH2/iUOkUxuEr3LfninpNyBDgRlUBhSux04LfSuR7q1UDyftapT8Y5GxOIMP
         amOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770606199; x=1771210999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wK0s6WNY7JHGKFbOusdpN6KZBi0XPPQ6s0A03O5cww=;
        b=3OvosIXo27v+iCH6WTdUH4I6aM9nzaAjEh4fyZ8pWSffKx5AijwwITnhOC5DoZFgHM
         OxAH1JOuqg5pXBTOQz4ATpBsHmWYqozRqClSeM6QL/fyson08W3trlMfXyWcCcKQCJf+
         zni62mScahmvUX0mYWkS3WGZr4BJMZcFCOVuUlxZadC4FbRpxzZNQOiWKCw5ioH5Urt+
         k7YBlogxZk8YBhGmIdOVSGCbolYc+LIYrtTMipWZOTH8lH0cBRmPKbCZN/UqMzC+S3TF
         qIhT462LL06tWLWN/TY1RS26Kv+71O+3kjmcSkrGFWiqQBF6sv1KSyiC1X6uuZpPPZrf
         AdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770606199; x=1771210999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wK0s6WNY7JHGKFbOusdpN6KZBi0XPPQ6s0A03O5cww=;
        b=SP6WkhSTUPXDFlLJlbq1/DiHXTok8GTXll6Ek/esXbig6UNJB/VjWohSSKu+xTIi4N
         vBPzyFCS0BfrIJ1iC6fpDDJybfIzL8xRJOfSpbqcq39b3ZXTt0Y7x7t3R2jXyB3gbu8t
         cakAAsbvgzieoqgeyeIm4I2GaKQW0NSjheaLHOjgny2RkjyI4f8hwvdl23zOt5r/cQjB
         2Ew3l6l0TMgvioZhoaYLmKQ23lgQTB4u6lyoTFybNj2z0HpW/0Ugjsdw875hD6fXCWWb
         3xnK7HxtifHoOACy79WeiksVLCTfyvsTA+IEVovKF5gRNTblbxM85iwuPwVdmQS9BFch
         g0bQ==
X-Gm-Message-State: AOJu0YzKyaQeu+OyJDte3EHVSQv114I/iUklWyyrWBDYQFcPbL/IoTkz
	HpJPXWgHLBjTZ+XP0QKk3oUtZO5fJ88qDi9TkdbZo6DStGUTcTS1NMkJTG+3keWCKm2m5PAFvyn
	GAOIbjxF7pu5xsaCSIzL7FCllmuLoI/bn9svTLOnMKPnZiXVHmL1e7ywXmZOvAK7b
X-Gm-Gg: AZuq6aI1vd4Ef2WYv9tC+tpNTW+prqG8IBfGV5B0VvU4eGy81STB9N6GfCXvaWxYt7n
	d9ymidtZATpKDrfMl6Azbu/RBoi9ex/popRdn4iUmd7sjQw83OTJ5sk609Nq2wNfNBcoE6pe3RW
	VZKoPHedIPmNbbsONVlUV030alhPgVRtcwz2LbCjZETXwhtTIUw1fqEz9zlmHpFcI8hTvGdXn2q
	DFKWjlkZvfHFotDVQT+iky78yNcu8WSYk4RBo+OHy2xXmnw2czEOk3cYlz9+PmoH9o2l5+a7mv5
	kQZA/VS3QJ5OK4OlnEraTgo=
X-Received: by 2002:a05:622a:492:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-5064b015dcdmr3878951cf.7.1770606198853; Sun, 08 Feb 2026
 19:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de>
In-Reply-To: <aYC0OvkVPkOnVU-i@moon.secunet.de>
From: Yan Yan <evitayan@google.com>
Date: Mon, 9 Feb 2026 11:03:07 +0800
X-Gm-Features: AZwV_QiXs8lSkOsc2cJvUhWm6eVrFGoeniKpFDSf-QpCDs3mIQIfH2M2RUd9Xsk
Message-ID: <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: antony.antony@secunet.com, Steffen Klassert <steffen.klassert@secunet.com>, paul@nohats.ca
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, horms@kernel.org, 
	saakashkumar@marvell.com, akamluddin@marvell.com, 
	Nathan Harold <nharold@google.com>, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257889-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 087DF10B481
X-Rspamd-Action: no action

Thank you all for the reply! Please see my response inline below

> This is meant for multicast SAs, we don't support multicast SAs.
I reread the RFC and that makes sense to me. Thanks for the explanation.

> To clarify, how are larval outbound SAs created in Android?
> Are they created with zero or non-zero SPIs? Multiple zero SPIs (acquire =
states) are allowed.

In Android, larval outbound SAs are created with non-zero SPIs because
Android userspace uses XFRM_MSG_ALLOCSPI to manually reserve a unique
value before the SA is fully finalized. These are not kernel-generated
"acquire" states.

Regarding the default behavior:

I'm fine with defaulting to RFC 4301 for the upstream kernel to align
with the modern standard. As long as a toggle exists to fallback to
the legacy RFC 2401 behavior, Android=E2=80=99s compatibility requirements =
are
met.




On Mon, Feb 2, 2026 at 10:27=E2=80=AFPM Antony Antony <antony.antony@secune=
t.com> wrote:
>
> Hi Yan,
>
> On Wed, Jan 28, 2026 at 16:43:06 +0800, Yan Yan wrote:
> > Hi all,
> >
> > I am writing because unfortunately commit: 94f39804d891 ("xfrm:
> > Duplicate SPI Handling") has caused a regression in the Android OS, so
> > we would like to gain some context to help determine next steps. The
> > issue is caused by the new requirement for global SPI uniqueness
> > during allocation. Based on our review of RFC 4301 and the previous
> > review history, we would like to highlight a few concerns:
> >
> > 1. Regression on Android:
> > This change breaks production behavior in Android, which uses
> > XFRM_MSG_ALLOCSPI to create larval SAs for both directions. Since RFC
> > 4301 allows duplicate outbound SPIs, and larval SAs are often created
>
> To clarify, how are larval outbound SAs created in Android?
> Are they created with zero or non-zero SPIs? Multiple zero SPIs (acquire =
states) are allowed. However, I guess there is no user API for managing the=
se acquire states. Only the kernel can create them and handle expiration or=
 deletion via SA updates with acq_req?
>
> A user API (UAPI) for creating and deleting acquire states might be a pos=
sible solution.
>
> I haven=E2=80=99t been able to consistently reproduce the issue Marvell r=
eported,
> but I suspect the bug could also affect outbound SAs with non-zero SPIs.
> Also when one peer is behind NAT.
>
> I wonder wouldn't duplicate SPI when behind NAT cause issues for output S=
As?
> Because the triplet is SPI, Protocol, Daddr. There is  no dport in it.
>
> > before direction or selectors are finalized, the allocator must remain
> > permissive (at least in our current design).
> > This also aligns with a concern Herbert Xu raised during the initial
> > review regarding compatibility:
> > >    "It's also dangerous to unilaterally do this since existing deploy=
ments
> > >    could rely on the old behaviour. You'd need to add a toggle for
> > >    compatibility."
> >
> > 2. Inbound SPI uniqueness should not be a hard requirement:
> > The justification for enforcing global SPI uniqueness often cites the
> > statement in RFC 4301, Section 4.1, that for unicast traffic, the SPI
> > "by itself suffices to specify an SA." However, we don=E2=80=99t think =
this
> > means inbound SPI uniqueness is a hard requirement because of the two
> > following reasons:
> >
> > =E2=80=93 Another statement implies that SPI uniqueness is just an
> > implementation choice:
> > >    "Each entry in the SA Database (SAD) MUST
> > >    indicate whether the SA lookup makes use of the destination IP add=
ress, or the
> > >    destination and source IP addresses, in addition to the SPI."
> >
> > =E2=80=93 There is a "Longest Match" mandate which makes SPI uniqueness=
 unnecessary:
> > >    "For each inbound, IPsec-protected packet, an implementation MUST
> > >    conduct its search of the SAD such that it finds the entry that
> > >    matches the 'longest' SA identifier. In this context, if two or mo=
re
> > >    SAD entries match based on the SPI value, then the entry that also
> > >    matches based on destination address... is the 'longest' match."
> >
> > 3. Further clarification on the specific problem being addressed would
> > be helpful. The "real-world" problem this commit intends to fix
> > remains unclear. The patch mentions:
> > >    "This behavior causes inconsistencies during SPI lookups for inbou=
nd packets.
> > >    Since the lookup may return an arbitrary SA among those with the s=
ame SPI,
> > >    packet processing can fail, resulting in packet drops."
> >
> > However, Linux kernel lookups using the triplet (SPI, Protocol, Daddr)
> > are deterministic. The lookup will not return an "arbitrary" SA
> > because the destination address is used to disambiguate the state.
> >
> > As Antony suggested, this change may cater to SPI-only hardware
> > indexing. If that is the case, we are concerned about applying such
> > hardware-specific limits to the software stack, especially if the
> > behavior is not opt-in, as it appears to require an overly-narrow
> > reading of the RFC 4301.
>
> I agree with your suggestion that making the behavior opt-in.
> I would prefer the Default : to allow duplicate.
>
> > Given these concerns, would it be possible to discuss a revert or,
> > alternatively, could further context be provided regarding the
> > specific real-world problem this commit was intended to address? Once
> > the underlying issue is clearly defined, we can work together to find
> > a backward-compatible solution that satisfies all requirements.
> >
> > Review threads are attached for easy reference:
> > https://lore.kernel.org/netdev/aDQhZ_ikHEt_pLn_@gondor.apana.org.au/T/#=
r45c1786651ce5af730f757aca7438474d494a323
> > https://lore.kernel.org/netdev/20250616100621.837472-1-saakashkumar@mar=
vell.com/T/#u
>
> -antony



--
--
Best,
Yan

