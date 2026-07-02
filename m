Return-Path: <netdev+bounces-303913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lWXvLn/KRWofFQsAu9opvQ
	(envelope-from <netdev+bounces-303913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8C6F2F8E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:18:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cgocjzGi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303913-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303913-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8F7302C6CB
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF3282F27;
	Thu,  2 Jul 2026 02:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FBE571
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:18:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958707; cv=pass; b=HONcSeIfI2m1sEM6LNt5SIduBL033iujAwmCW5OTFuTFKt/Fd7IT3VeJCs1UDARIkAhprVNnfvttZ3gYNuxHDzFGdpaFNC0rUfSf/6M7OoncqFLJLCw2YeqW39CviRObGXgL9Fmg2rzualoa/1qvjxnSlqA+7vbecA4rqBGepQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958707; c=relaxed/simple;
	bh=V9aALrRSz7frJLaex8plnUn4u2oJyidrE8JxseamW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiH68S0LfkligFVwD20uuCTHIUeRZdf58HxV1hqVdztHQ5HSNmii64ienCB1I7qX4L5f90vSIj6ei6cMnZ6SQFGwCrpC9RZXHxXLMgMUjZ/oFMcMqcpjcjuB947Op7DhLifGxkYSrhX0/M+iUvUjgxdNUMJKGpAOf530UD17MKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgocjzGi; arc=pass smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c89636920a3so515333a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782958705; cv=none;
        d=google.com; s=arc-20260327;
        b=kZe0YPVFqa2LB/JDbAFdFK22VznM/DF68h6Thn9GBy1PKLRjdtgLcR1zSPACP4fM/O
         VmfTrO0Ee/i3uh1jTTRc5+b4o3L3aQjaU+6MwG+yzeRvUXTSQCOjXlj4OGUkjVvQuvjz
         Ey9JqwM28ID28YZlP8rJxGKA3rJ73IbyCorBk5agIIraoZJWlibs9r4+WhmmsL0TbrlF
         cZEHLKphhvmiGoVCu36bgbrRv9Qg0w+7HKqO5vMDXcW11EfIcnbuLcgwi8evnvCE0mre
         gr7Wgu+uq83j/kmE1CdIQ0eMuCIwAAUTTQX1yd5YSaV+1Fj/fbbllASSUKCJKKH26ZB/
         6Q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bQu2JE7tRaR07SgQ+LOX9zNaz45k+xlZl1aMb9A0mb0=;
        fh=8sUdspJBAC/rDtww43PrXPx1dOZG8h6X//Jrfc8mbEQ=;
        b=AFXt4dzN38sLegw1b2Bhaf4UW2jRr7ul5w0M20k+0dCdwmkvxSxI97W9WZ5qhuxYQO
         baSi1HL2++Lh6vpGampobFhjhj++taRNI2XAJ0Sf4kLbZIQnc/pcyRsFkSoV05gPlcrs
         zTQid0ouGng8K+6652TiGPO2eJzBLpnt0KCZcdty3IVav3pzvveMXblw73CtzbVY4HkZ
         x4F7QELUJu3v2kph1mCnPdr/gWpMl+1Q0ZUHNRBRF7cEW2qVd9A17L9sdtp4hWYzh5UQ
         m6bS024/7aLu3MJkP8rVF5OEHdZCKNDXG5P5ub5Yj4aY/epJevAq51KGsiotKML49iSu
         +0IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782958705; x=1783563505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bQu2JE7tRaR07SgQ+LOX9zNaz45k+xlZl1aMb9A0mb0=;
        b=cgocjzGigxu9fV6Yq01jRsYOxUKROcsuWR/rR7aO267ACxpXq1b/f4CYR67JQ/tCpw
         58hrgQMKVEsknFAOVMCNmnepMl+iHFv4W5GD/FjJRM8BapFdsMb16XbrO206QW3pC1w4
         gkdrLqBtlMQPJBbUmvveOnAstULs2paz2hE1qxwqSmYWxiO1W+kDATCgDx+zwkQkGDjP
         H0TqCR1tXy98aXzZ9hLkEis98rUmU03cZvjRqD3H50cyDqDqFdoZaJcLXcW5boG8NF4J
         B31SIIICy5vgHHircGrsr2cSZ4lTCtq9BhI0xNzbswTYf52iNT+GYKo4eYvqpPmk1fUf
         TPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958705; x=1783563505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQu2JE7tRaR07SgQ+LOX9zNaz45k+xlZl1aMb9A0mb0=;
        b=UY1ykNzYK7O+kNxF/0NplI3ugTruSmSsaNdafNLkUSNFLVab8fch7u9SK8dDGORd95
         06ci0xZp3L8grB2y9J3c12GC3xAZSl4rbypYL2eFYbblnvA/iAMCUGJx2sJQA8KjwYQ1
         yaUYZRcAae2FKEXiFGItaHndUEWho7wLMTJZQj9zARCJKfB+E2NO3cTKnr/nLYnOK2g2
         1R993W6b+f3O0mvapjbYfNjMpoTaOrNitZjtZRNRmiwhSGXLbJXeP+pjme3GrGr1bsFX
         em0f7GHlbSHTAeP3GzgU1bfnfXvJK37H+/OdfYwE/s1INeuTckR7yfVZRjFg8Pfoe9Fp
         JNOg==
X-Forwarded-Encrypted: i=1; AFNElJ9K/5UvclvTRk23J5Ki+7Y03Zd116sSfKKaH+n+7rfiAKK76POYBEAYICu1aIh2XowIk7JJ8MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9r1G1sKrGx4pgKS2L/KzcKtpYIaOVB0zUESc17Rg2hepLlzhT
	y2NFizzUrSY2kvg4GCmsHyyQsWCRgqxI5MgyubXsLa37UeVC7h6eVsMq5BxJB4Pc39nSfSqxf6i
	cecybiXSafAIi1p8QZQCpQTk1E4StP70qNGhFFqK7
X-Gm-Gg: AfdE7cnleXGqbT+KB4UTDdoeZirh7iNNa36Zbr5vMVGQZOXzS/HN+at/YGvsS7Ram2i
	eTM5Kkw2Ti2PU0tD2QrZaf7xnhTFbiafnMFPq9qoNxMM96i+K2k/e6hvyYZyXLd36ZXUvVv8ehD
	M3RosDD1528AsnBNzG9LK4Wk4pTdMktUIxMdc+o9F663jyGXnEO33PE2S64scLxuYiCvL207GCW
	aLsn/zoaV0FlqgG6b78HswNCU5y1arF7QRePJdj8Kvv4yUwhRvC43pd+/Xx4HkzAguL/xbVJL0X
	vekHx2TDT27lVbzWktyEO9CiW8g9hc0wpfcIn9BKRG3dkoWgH2G4+3MVJ6Wu4OnumAqevax2ApX
	W/4z2wuXIhQdFZe07fXGm1RlZm0XH2froFlPCCwhG8WqtUQLX2kXO
X-Received: by 2002:a05:6a20:728c:b0:3bf:79d6:f063 with SMTP id
 adf61e73a8af0-3bff4288a18mr3475181637.43.1782958703837; Wed, 01 Jul 2026
 19:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630070600.484-1-yimingqian591@gmail.com> <CAAVpQUC_EcpFf9GmNnD07KhFAOcPhrCa5xNF-idz0CsB=TJV9A@mail.gmail.com>
 <CAL_bE8JU8fpwracSRC5ziiT=YMW-XRkYNsUEGGuoSOv0gYZcwQ@mail.gmail.com>
In-Reply-To: <CAL_bE8JU8fpwracSRC5ziiT=YMW-XRkYNsUEGGuoSOv0gYZcwQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 19:18:12 -0700
X-Gm-Features: AVVi8CdKVj5PPQn_3_9oYWT4nRZ9zQVqMHySoGQQOYcrnJI0I8B4jvdiFAspi8A
Message-ID: <CAAVpQUD9_x0P6wedUCP5Xq81MMn5WLdPcm7km+A5S1EZKXPGHw@mail.gmail.com>
Subject: Re: [PATCH] af_unix: mark MSG_SPLICE_PAGES frags shared
To: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lingchen5202005@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303913-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yimingqian591@gmail.com,m:security@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lingchen5202005@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52A8C6F2F8E

On Wed, Jul 1, 2026 at 7:05=E2=80=AFPM =E9=92=B1=E4=B8=80=E9=93=AD <yimingq=
ian591@gmail.com> wrote:
>
> Thanks, I agree plain AF_UNIX does not by itself provide the writer side.
>
>   The concern was that MSG_SPLICE_PAGES imports externally owned pages in=
to
>   skb frags, while unlike TCP/UDP/KCM this path does not mark them with
>   SKBFL_SHARED_FRAG. I checked the AF_UNIX sockmap path as well, but I do
>   not currently have a concrete in-tree chain where those frags reach a
>   writer that skips COW based on skb_has_shared_frag().
>
>   So this should be treated as a defensive consistency cleanup rather tha=
n
>   a security fix.

Hmm, if it's not exploitable, let's not add that.  It's rather confusing
to future readers.


> I will drop the Fixes tag and the duplicate Reported-by
>   tags in v2.
>
> Kuniyuki Iwashima <kuniyu@google.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=BA=8C 23:51=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jun 30, 2026 at 12:06=E2=80=AFAM Yiming Qian <yimingqian591@gma=
il.com> wrote:
> > >
> > > unix_stream_sendmsg() splices external pages directly into skb frags =
when
> > > MSG_SPLICE_PAGES is set, but it does not propagate SKBFL_SHARED_FRAG
> > > afterward.
> >
> > I think it doesn't matter with the plain AF_UNIX.
> >
> > Please elaborate on the scenario where this could be a problem.
> > e.g. sockmap ?
> >
> >
> > >
> > > That leaves later writers without the shared-frag marker even though =
the
> > > skb still references externally owned pages.
> > >
> > > Set the marker after a successful skb_splice_from_iter() call.
> > >
> > > Fixes: a0dbf5f818f90 ("af_unix: Support MSG_SPLICE_PAGES")
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Can Liu <lingchen5202005@gmail.com>
> >
> > Reported-by is not needed when it's identical to SOB tag.
> >
> >
> > > Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
> > > Signed-off-by: Can Liu <lingchen5202005@gmail.com>
> > > ---
> > >  net/unix/af_unix.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index f7a9d55eee8a1..f2cd0f8ec0914 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -2458,6 +2458,7 @@ static int unix_stream_sendmsg(struct socket *s=
ock, struct msghdr *msg,
> > >                                 goto out_free;
> > >
> > >                         size =3D err;
> > > +                       skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG=
;
> > >                         refcount_add(size, &sk->sk_wmem_alloc);
> > >                 } else {
> > >                         skb_put(skb, size - data_len);
> > > --
> > > 2.34.1

