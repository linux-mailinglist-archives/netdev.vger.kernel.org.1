Return-Path: <netdev+bounces-257981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOdDGxwwimm3IAAAu9opvQ
	(envelope-from <netdev+bounces-257981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:06:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99A113EE5
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF80301F32C
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD13EFD3C;
	Mon,  9 Feb 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjehFc9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9242E764D
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663961; cv=pass; b=NQfeNiapAilPnNjNg6DRM3gKVojeGdoZGmL2YK59XSAJei17we7jiOm1VE/iwLIbD+b7dcLgmhRs4mkeeXGZ5nuDA2DBVYB/qZbwwrNFrDH0jKeo9335G0fvAJaKauwHzEWUKjSTJ2b5/ztVaIdYWzN7uNAFUPZoNce0aPRBHjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663961; c=relaxed/simple;
	bh=TnKOgqKifp87S4hGzSNCXYniAOZmiglgSk2FMxeCzQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAPf/Pbf62DS1lKNB4crkoYx/bLdY2IXdVqv0yM2R6eRyQ5xg29ZeKe4duHC1skDuKvM+GIMWRfjEDW03LLhilsoPfCb14U9iqTIKYE1lW8yTQ1EOtNNFcvCqizij24Inm8YSxXwEs+2hGgpUlXbtoMbugkzJpaItsmbYBY3ze0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjehFc9Y; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-505d3baf1a7so41391cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 11:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770663960; cv=none;
        d=google.com; s=arc-20240605;
        b=CWmmuwkpCFbK59JnOAt+a1RTWERvIyju1wgLPo96EAbJyqQY5x0yW4e+KR6E6DLvD2
         9Pz/GtmIVoPh2ejhDFoKqPr0Q6sW2S5MNRWoU/46gof6zjwnYOfKaGaOafkIOLw8OzXw
         3q6WxgtxwegmiAkznwcKzKhpizEzgCy72BcQgkg5VfYv+H7TxCCn5opHLfdL5KjKbyQe
         UVIe9IbR7TT5S1+lcUIS2jVFevjWPhkqV3F+doxJvQWFm8G3ETAedYOjxdsJtsDmxAZV
         cufaqjRVGkTgBWjMZA0FFXo3KpH5VK+6cRbSo6y06Q42qElioyseLgUdbMC9oFDqoSW6
         V++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDGGdTWrfiFEfGwIzvd025xBJcNOMHd3nBArqAhnTUY=;
        fh=7q+W6ERNfr6A1f1ak+MzHqk43Lz1tmp8Z3uERCCtBnk=;
        b=C5K80ew3E9Z9r18I9W2zjnyRq7M0dNxhy6n6b6pv4yNpytBWmEgc6S8mJ07A+l59dN
         RPhXnLpANxi/ofTN4dteIqJp5UgFa+od6ef07pvdEXKRNSGW+UZzmfnojgo3gUlcMOyC
         zYWFrvmE5IIVl/dBLFFKC856L4j6K7iynGYIJk+tXZF5E1OfeodX0US41PmrV+iGEvKy
         uYFgBgdh8j0raEr6vY/uCsrAGvovSYiAl7550Ro/jhxf+a/H2I1SEuLw0Ci1QKOKirvX
         tOKMio+8z5BV0aPu9kW4gvWXDd3/AGD34WiynjNmQM/SBP1HS5Wr8pOJO3UBR3pIcTJy
         kt1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770663960; x=1771268760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDGGdTWrfiFEfGwIzvd025xBJcNOMHd3nBArqAhnTUY=;
        b=hjehFc9YA4cdCgxIr2JzrrRgDzfIMMIqYfe8VPR8Ui9g0KGqGbt3krBx4C1+L2wHI1
         EjlFNNJxlOkPaIXvUY8dtyrT6zomOMuDMYumvW2AlFd8oDKQsRbpcPfBxiBlS+4yDitO
         AN0Rwh3gcAWFyhmWOfj0/K6sexeS+gHYU4mA+QMKXusxO20e+R2HwQ0v/nONH3dZia0G
         kW+GcMGDsdM7Od7K9BEl/ufuWhjGh3QdfWFRJvv+Q794sISh8d1k3qUHiyYsxcr6vB5a
         tUZb7LXAmZ1Z/M26lz2d3YzYXhG+G050844X80MyAxRnd6IHbVb+tAR2N1N8DXOxcs0L
         aYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663960; x=1771268760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDGGdTWrfiFEfGwIzvd025xBJcNOMHd3nBArqAhnTUY=;
        b=Pfh1VrFrrhUbugiaDbElJUDoyjJcUpH0z7NgyzKtn8cDGQiFbD9kj12EDy7Qs8TZ3g
         0z+QPTCREqB79L+8MQukgD9Hv/eVnY3BgChTVYBKSvIGy8QJPDN15L+Wubwtnu0is1mk
         fpALYbiAqLy5Xn+u42FMuM+udY0r9RrxlZsDWhA+1Eg63og6T+pgo0RQFJvxRSM2KpVn
         EVMDV3wGheaVvEbOjGH7d7lSaWc1cDAQ/9HbDf1I+nhpvSVfw5Hnbsy+LRBfgpyfEhwI
         NFYr1F16eK+rxbSfBc5d7E+EBpZ1D4vzOHvoRkcjFIQdGhb1KeUuVMj0DbMWwYqKZVjv
         A7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPPaAYaKRkDcJ18G5n+gmRQG5G1nTfbLuoiFGrH2RXjoVz4XuymnNMSZZusINSHdZ/gt9130c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7tYeRe/Vd1ghvf3m8jrVVDjl67CUIUKxxWB3pWYcZgj3Vwhu
	CCYwLH0DfMIUalLxmBftdeeZxYoDnbwayqgwU2DWNxoq8Lvv47SFeq45pnwsi29zKyarPbmmpDV
	64uE3wYue/vmsbWB1OmnO+aCXbi0ldRvxoLeDHwvsl+MKCZfC//PyDAXo
X-Gm-Gg: AZuq6aJh+gE52YhCfgOdpNEu9ozaQsZ7i9iPBtQ20+pMu85G0aMJf2fPxEG/KTCqkl0
	fb9OwxxDkKrIa4eS5sVd5wcaa4iW1kJFnrcWEhRT14JepG+U5dfopNpfhb1unlCs3j9nbFLulAz
	nd2wTL4ParBMfSBKgWXYiPKbetcFR2ihbF20K9JmW//7cF65MS1PglafTafSlsYouZPaP0iNG25
	z7lV+SxyXa3KeBWGd/C+2Cc63I7sRL8coyR7n1ca28wZVRzZWpmzK30icW792H9Uz3WYxiHUSz9
	adMCh07v0W3h5JblriR8DQkh
X-Received: by 2002:ac8:7f52:0:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-50671ea26a7mr983041cf.12.1770663959631; Mon, 09 Feb 2026
 11:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de> <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
In-Reply-To: <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
From: Nathan Harold <nharold@google.com>
Date: Mon, 9 Feb 2026 11:05:48 -0800
X-Gm-Features: AZwV_QhzQ8q9_qDpzv7jEod9qJAwvLP0o9DAskpYmUgS6AE2HnTpIdn_YQNoE1I
Message-ID: <CADhJOfZETazUCX+kgd+gP861SxsU5Ao7QpjBjy8SnCL-FdKO2Q@mail.gmail.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: Yan Yan <evitayan@google.com>
Cc: antony.antony@secunet.com, Steffen Klassert <steffen.klassert@secunet.com>, paul@nohats.ca, 
	netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, horms@kernel.org, 
	saakashkumar@marvell.com, akamluddin@marvell.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nharold@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-257981-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: BD99A113EE5
X-Rspamd-Action: no action

Unfortunately, Android's requirements significantly limit our ability
to implement compatibility fixes between the OS and kernel due to
interface freezes and cross-version compatibility requirements, so
thank you for taking us into consideration! Generally, without a
userspace mechanism to opt in to new behavior though, it's tough. For
now, the Android kernel is just reverting these patches, but that's
not a long-term strategy.

One approach, which seems generally sound to me for this specific
issue (and perhaps more broadly), would be to leverage the relatively
new XFRM_SA_DIR attribute to distinguish between legacy behavior and
stricter 4301 compliance. Much of the optimization is
direction-specific, so we can infer that an implementation using the
newer API and opting in to direction-specific behavior wants 4301/new
feature support--also, Android doesn't yet use that attribute :-) .
Or, as Steffen suggested, there could be a new toggle that indicates a
standards-based target behavior (like 4301), which sounds great if the
SA_DIR flag is deemed insufficient. Thoughts?

-Nathan


On Sun, Feb 8, 2026 at 7:03=E2=80=AFPM Yan Yan <evitayan@google.com> wrote:
>
> Thank you all for the reply! Please see my response inline below
>
> > This is meant for multicast SAs, we don't support multicast SAs.
> I reread the RFC and that makes sense to me. Thanks for the explanation.
>
> > To clarify, how are larval outbound SAs created in Android?
> > Are they created with zero or non-zero SPIs? Multiple zero SPIs (acquir=
e states) are allowed.
>
> In Android, larval outbound SAs are created with non-zero SPIs because
> Android userspace uses XFRM_MSG_ALLOCSPI to manually reserve a unique
> value before the SA is fully finalized. These are not kernel-generated
> "acquire" states.
>
> Regarding the default behavior:
>
> I'm fine with defaulting to RFC 4301 for the upstream kernel to align
> with the modern standard. As long as a toggle exists to fallback to
> the legacy RFC 2401 behavior, Android=E2=80=99s compatibility requirement=
s are
> met.
>
>
>
>
> On Mon, Feb 2, 2026 at 10:27=E2=80=AFPM Antony Antony <antony.antony@secu=
net.com> wrote:
> >
> > Hi Yan,
> >
> > On Wed, Jan 28, 2026 at 16:43:06 +0800, Yan Yan wrote:
> > > Hi all,
> > >
> > > I am writing because unfortunately commit: 94f39804d891 ("xfrm:
> > > Duplicate SPI Handling") has caused a regression in the Android OS, s=
o
> > > we would like to gain some context to help determine next steps. The
> > > issue is caused by the new requirement for global SPI uniqueness
> > > during allocation. Based on our review of RFC 4301 and the previous
> > > review history, we would like to highlight a few concerns:
> > >
> > > 1. Regression on Android:
> > > This change breaks production behavior in Android, which uses
> > > XFRM_MSG_ALLOCSPI to create larval SAs for both directions. Since RFC
> > > 4301 allows duplicate outbound SPIs, and larval SAs are often created
> >
> > To clarify, how are larval outbound SAs created in Android?
> > Are they created with zero or non-zero SPIs? Multiple zero SPIs (acquir=
e states) are allowed. However, I guess there is no user API for managing t=
hese acquire states. Only the kernel can create them and handle expiration =
or deletion via SA updates with acq_req?
> >
> > A user API (UAPI) for creating and deleting acquire states might be a p=
ossible solution.
> >
> > I haven=E2=80=99t been able to consistently reproduce the issue Marvell=
 reported,
> > but I suspect the bug could also affect outbound SAs with non-zero SPIs=
.
> > Also when one peer is behind NAT.
> >
> > I wonder wouldn't duplicate SPI when behind NAT cause issues for output=
 SAs?
> > Because the triplet is SPI, Protocol, Daddr. There is  no dport in it.
> >
> > > before direction or selectors are finalized, the allocator must remai=
n
> > > permissive (at least in our current design).
> > > This also aligns with a concern Herbert Xu raised during the initial
> > > review regarding compatibility:
> > > >    "It's also dangerous to unilaterally do this since existing depl=
oyments
> > > >    could rely on the old behaviour. You'd need to add a toggle for
> > > >    compatibility."
> > >
> > > 2. Inbound SPI uniqueness should not be a hard requirement:
> > > The justification for enforcing global SPI uniqueness often cites the
> > > statement in RFC 4301, Section 4.1, that for unicast traffic, the SPI
> > > "by itself suffices to specify an SA." However, we don=E2=80=99t thin=
k this
> > > means inbound SPI uniqueness is a hard requirement because of the two
> > > following reasons:
> > >
> > > =E2=80=93 Another statement implies that SPI uniqueness is just an
> > > implementation choice:
> > > >    "Each entry in the SA Database (SAD) MUST
> > > >    indicate whether the SA lookup makes use of the destination IP a=
ddress, or the
> > > >    destination and source IP addresses, in addition to the SPI."
> > >
> > > =E2=80=93 There is a "Longest Match" mandate which makes SPI uniquene=
ss unnecessary:
> > > >    "For each inbound, IPsec-protected packet, an implementation MUS=
T
> > > >    conduct its search of the SAD such that it finds the entry that
> > > >    matches the 'longest' SA identifier. In this context, if two or =
more
> > > >    SAD entries match based on the SPI value, then the entry that al=
so
> > > >    matches based on destination address... is the 'longest' match."
> > >
> > > 3. Further clarification on the specific problem being addressed woul=
d
> > > be helpful. The "real-world" problem this commit intends to fix
> > > remains unclear. The patch mentions:
> > > >    "This behavior causes inconsistencies during SPI lookups for inb=
ound packets.
> > > >    Since the lookup may return an arbitrary SA among those with the=
 same SPI,
> > > >    packet processing can fail, resulting in packet drops."
> > >
> > > However, Linux kernel lookups using the triplet (SPI, Protocol, Daddr=
)
> > > are deterministic. The lookup will not return an "arbitrary" SA
> > > because the destination address is used to disambiguate the state.
> > >
> > > As Antony suggested, this change may cater to SPI-only hardware
> > > indexing. If that is the case, we are concerned about applying such
> > > hardware-specific limits to the software stack, especially if the
> > > behavior is not opt-in, as it appears to require an overly-narrow
> > > reading of the RFC 4301.
> >
> > I agree with your suggestion that making the behavior opt-in.
> > I would prefer the Default : to allow duplicate.
> >
> > > Given these concerns, would it be possible to discuss a revert or,
> > > alternatively, could further context be provided regarding the
> > > specific real-world problem this commit was intended to address? Once
> > > the underlying issue is clearly defined, we can work together to find
> > > a backward-compatible solution that satisfies all requirements.
> > >
> > > Review threads are attached for easy reference:
> > > https://lore.kernel.org/netdev/aDQhZ_ikHEt_pLn_@gondor.apana.org.au/T=
/#r45c1786651ce5af730f757aca7438474d494a323
> > > https://lore.kernel.org/netdev/20250616100621.837472-1-saakashkumar@m=
arvell.com/T/#u
> >
> > -antony
>
>
>
> --
> --
> Best,
> Yan

