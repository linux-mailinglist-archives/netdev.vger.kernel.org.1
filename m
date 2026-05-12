Return-Path: <netdev+bounces-287307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJUzLFaZA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:19:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BE52A2D0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C50730903A3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C937FF71;
	Tue, 12 May 2026 21:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3F26ED46
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620739; cv=none; b=nWN0UVtS2CUCF6nPLtW2lpRDOpAcXf2eTj3oIoEl3FGP7mYpa1gB8a3/cB5+IWXU5vQ+ahm54Q1AolkcmHrh6NxHG7AMaDp9OL+CwYIROzaZedqTGdesV3OChiGiAL7pCwuAgViGT0O/8Ph9qvjHKfbeGYaXADdgw2XLidhCWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620739; c=relaxed/simple;
	bh=ZF+m+ZjVtnGgRZxs8fykE/7UK37XkDux4yfRZUGOw5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQcgKoG+Ht5dG0azZq1bY8kHc5uKC2RFKdgeRyRDSYe7OgFFdPsUfkRrZWBdmcPAj/PreRcbO9siM06nj4XIUpuzK/jra3BVoFy/qX+rBUaW+L9iV5L+Q0kCQgEs+aXzzDAA+LeJhLHUEXiW3yC+BSwS4dzEBArO7khYlp9WkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so10613289a12.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620736; x=1779225536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULDGSLAty8SEh/aPzQ3wMjjybANkPqfntQTcejrtbks=;
        b=iAO26F7d2JAvR9efMRvyD+fi+XRBvyPayQPAO8ioXJrBCksOD2bpkYjmqoItdqRheh
         r+I0cENRoFbh91H7MxIkxkL/FWshiNw9PGk8jUyKIsGlS/oZq2pcEnDplk/CvL5la0Gb
         u0z+RTK+gIFrjbzhfWu+v2grVZYYe8s/Lv0kbCdI4mDKNbgm6rk1DMyBG1Dho4A5Jh72
         5tOS4OiXrv/5WkabyTV9t7TsNJHbhl2Ocm++TkDz0lConymUY+Xzxya0PSUbeeeEa1JK
         PojVeBt8KqeRWA08svzHq7IWbS3gl9RHa3K1IH+d/Nib+8Eqg1DleIcN+k/jjxR6Ul4F
         Mf2Q==
X-Forwarded-Encrypted: i=1; AFNElJ95m+QMf4FI3Q+uDOFkO5og4ov+o3dZmJDx3fS1eikLB0GS8LsP1G8VYije870iWElXvkV2DJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0xBh+wSqPUtCkSk8PTFAbNmeop5DSoFBc5xZIju9KZpf7MGw
	QsFhL+hSay51G1QmpOmEpIr+5lPvhYCCyfpyCn+/lPOw7jE8WfjB7fqb6Jilb9j75ns=
X-Gm-Gg: Acq92OHDIcN/wU1frELK3p5G3O/0HmaFSC32PfW0vlwq7ramJ5osgjTp0GZuhV3D9UK
	iQPvRCdYo/iZOG7bAa/MxK8xj0inf8MK/7E5vlsjjzoCzSbbQu8uT/+Jx1Rie7QorePkml2eyyG
	httEmA29jvehtSy3l8+8ihmd9rgDBjkVkFd9ikbCD1SOPdInmC0yEJQ4GdCq7cwCtsW1FAKMCUQ
	e8N5QWPhiLH+vPWoSIpBsA6m2yowsr3pd7RuKVJtHR7oD8RYv3o9J3aBp5O/IR6/nZD27AnaOWR
	Yhv8umANSLQrOMeH7O8FPPxr3ZLcfnUybquZv6kDTdIzinstbx02nAUZMW5VywmznNsCmOFJZ/H
	llJ3qZefQVYnBwCLe6GqOKFlwEO3tjoyjj2h6Z+QOiKs6LDFh5BlZa1+RREVzvuBoAcSD1OHvjn
	fwWsLqTdDSySmhUZd+atDlVUfJtugw1SCEtYnDf3bGlR9w7EhCLGji3Q==
X-Received: by 2002:aa7:d74f:0:b0:681:2472:76c2 with SMTP id 4fb4d7f45d1cf-682558ec2ccmr197916a12.4.1778620735839;
        Tue, 12 May 2026 14:18:55 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e0d455sm5538690a12.21.2026.05.12.14.18.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 14:18:54 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd24f466598so272297866b.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:18:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Gw26NNvu7MCt9oDCvB5ueFkQaw7vJOBByDZdc2cmn9r3AQ2Xm4J7LtpTkXtAuIdm+2EWgAOU=@vger.kernel.org
X-Received: by 2002:a17:907:80a:b0:bd1:e36f:1ad7 with SMTP id
 a640c23a62f3a-bd3bf484689mr27989066b.9.1778620733204; Tue, 12 May 2026
 14:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com> <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol> <3bfcf406-fdde-4303-9bd6-0d8d21ddba37@linux.win> <20260511213829.GA316710@google.com>
In-Reply-To: <20260511213829.GA316710@google.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Tue, 12 May 2026 22:18:42 +0100
X-Gmail-Original-Message-ID: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
X-Gm-Features: AVHnY4IXFsTsREC72LukcHqvk6gC-iS5eeOIEbsMsX37ajVDHN0xSqZ-iDLXxGU
Message-ID: <CAOs+rJUA+bz6Y2GKioHnFGFKX_uAP+4LaPRs=ZDgRQoUi4mWkg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kamran Khan <kz@inspirated.com>, Jeff Barnes <jeffbarnes@linux.microsoft.com>, 
	Andy Lutomirski <luto@amacapital.net>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 438BE52A2D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287307-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux.win];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@linux.win,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Mon, May 11, 2026 at 10:03:21PM +0100, Ignat Korchagin wrote:
> > I don't think fully discounting hardware offloading is beneficial here.=
 HW
> > accelerators will be produced and without a common interface vendors wo=
uld
> > start implementing their own "bespoke" drivers with bespoke userspace
> > interfaces (we already had such proposals), which in turn may introduce=
 more
> > attack surface. Yes, AF_ALG needs substantial improvement, but at least=
 it
> > can be a standardisation point.
>
> That isn't the best way to accelerate symmetric crypto anymore though,
> if it ever was.  This has been known for a long time.
>
> > > In any case, any hypothetical security benefit provided by AF_ALG wou=
ld
> > > have to be *very high* to outweigh the continuous stream of
> > > vulnerabilities in it.  I understand that people using AF_ALG might n=
ot
> > > be familiar with that continuous stream of vulnerabilities, but it wo=
uld
> >
> >
> > Is it actually that much compared to other features/subsystems, like eB=
PF or
> > user namespaces? But we don't rush to deprecate those - instead trying =
to
> > harden them and come up with better design.
>
> There are plenty of other kernel features with a large attack surface,
> of course.  But they tend to be much more useful than AF_ALG.  It's all
> about weighing benefits vs. risks.

If divide number of CVEs in such systems on imaginary units of
usefulness, I think the ratio is similar.

> When we get the point where a large number of Linux users *had* to
> disable AF_ALG as an emergency vulnerability response, and at the same
> time their systems weren't even using AF_ALG so nothing even broke and
> they could have just done that to begin with, I think we get a very

Well, there were: cryptsetup, RHEL fips check, so there are some...

> clear idea of which side is heavier for AF_ALG in the real world.

Same thing could be said for unprivileged user namespaces - distros
even put a custom sysctl to restrict it and no-one noticed.

> The main relevance of AF_ALG to the Linux community is that it allows
> their systems to be exploited.

To be clear I'm not arguing for the current AF_ALG implementation. I
agree, the splice zero-copy is... suboptimal (to be soft) and is
actually not-so-zero copy. But I think it was just added before we had
more modern approaches like io_uring (have their own can of worms, but
hey - people adopt it fast).

But I advocate for the usefulness of the concept itself - kernel/OS
providing crypto services to userspace. As mentioned in other threads,
other operating systems have it and Linux lags behind. There are use
cases: common interface for HW accelerators, embedded systems, which
don't have the space to bring a userspace lib etc. Even non-technical:
there are environments that just don't want to rely on third-party
userspace libraries like OpenSSL purely for licensing reasons. And I
agree, that it is hard to do it right, but we can piggy-back on other
subsystems (such as io_uring mentioned or other ideas).

> - Eric
>

Ignat

