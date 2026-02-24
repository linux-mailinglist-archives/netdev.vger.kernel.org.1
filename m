Return-Path: <netdev+bounces-260322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4dByG9kanWmJMwQAu9opvQ
	(envelope-from <netdev+bounces-260322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:28:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8618160B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69ECC303A6DC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB729B789;
	Tue, 24 Feb 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdcK0YwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70229B20D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903700; cv=pass; b=IC3BFs82bain1Pd7NYOfdmNbtXcJAC3NMYGRNHhYUOVKScUlW8N4NPJkK8rVnsoYFJn3ECaKmKD1huH0Jedy6xTTo8LCt4pFlsTPSMiagrGIdiNEVwrAbB+8x0Irkam3c9RGxxfsIPWfaoY0nikf3Lw/YcCM4jEksiCEOxwjXZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903700; c=relaxed/simple;
	bh=FkI8/e2KYG4uetxy8S+ZQ4GydStUxKTKCiGH/WZQPpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDyanMPvvKJs6Est4S+4iBl1Bh7DIPxaWIm5XbDy9BQCxBiNpXBgnDXBc9e6THTK/e1RiE6JPQNOgrPKKNF53iHtinjrUXgSmQxNidv1Cd2bTP08yBECZCJijQMjasVI+4r+ncXHVEbLQs77dNgtwxvD9F51c6uC/Gm3X/PY+BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdcK0YwM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5069a785ed2so161051cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771903698; cv=none;
        d=google.com; s=arc-20240605;
        b=ZiGfxEgOSwBN0p5+WrkgUfahHOvY/AJO1uWPyEZiLBQ3eNnDFUbajyyXb+WSfoqGv3
         Vkbcn3dFwh5YMQaWNBFfM5z8KBETpNPR6nEr1V/gZvTwBABzu5p4syIsKSUjsyC6+IxH
         H/7dwPUinPC4ejFHgzfQJGc2o580UTl+btFn1+rJp2fsy6x/hlou/dXJgznMfli6ljY0
         mb4rpG3wr3LpW2vM7JbHjHSaunbrh3RLMoY1WNraE7AoRgTR8n/VY/d9ufrjV/y3Cigq
         OuUZs8r08bBtBwERkIv4sQF32mHpg7exp+3/gseXElUzEfrKKRLhtCXfzGd1R4uSIbVw
         loMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwcM+iEPBhUnD4F73r7Q9uM2FATET2leNmHYF8iHSCo=;
        fh=nUamM5D/JTQ0na4W6Ll/VKgoQwFWif5yls34UkB1HWE=;
        b=FFx2Vl364uBTFHX2jBtWdVleTq2VERe/S+UdnsJqYdnGhnEMc8TCdaZQX2abCUb1tG
         xL6W8C0CFo+VOi92E15YMujFNzioqIREASXqytZ925WQEmkan66TT1k3Yu3ufdhTLHmE
         WwQYVcaWDwOvfSbVBc90w5YVM4uvZnOM5f7IRwGvWxYWVJLddWtfCaLi/fZVHqG+SIFq
         9Z+8SThzi8JYmNJi8uG+aZ/EC9GEo+Kh13qq5cUm959Ox+aVUHwVYwQksNitT8Mpa5W+
         KCAk6f+wmmh3SAmCTZiY08X8G0N7t68fEPeCuUN2Ufq41SXir4pVNktAMHgDqzPYn7n7
         bYTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771903698; x=1772508498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwcM+iEPBhUnD4F73r7Q9uM2FATET2leNmHYF8iHSCo=;
        b=jdcK0YwMJGHr23GU9QXG7MjweWrgAyXiAcx0+1u8WyrrX/c5enZIq8VEc95wEo7AW6
         h3f6grKnV3PvEYysYu13aFzzUTv0oQvOZy0Ag7osqH2S3luyymmi2hBRhm78Ntrq/Osv
         ucccEFrZPh5UfNb8r5GPz1Gk13WTy2qkcZ2ObQsJtuVUI4cmZOWwoBHO1O0QC5lSPxhR
         z0xKrpR3XT3KIDU8T1QHDovQaceC+qZYe3NB8HgxJgOu5ltN7iw5kyIg2jTsGQLoVONB
         VzxHJijjq0pyir1/VJLJ7BCdCBaTUpM8au2XpbAiXmx0p3OhvIFtYqlHNiTZwZ8kbW0Q
         V68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903698; x=1772508498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwcM+iEPBhUnD4F73r7Q9uM2FATET2leNmHYF8iHSCo=;
        b=bgtCisSJkgyC/f5P6RCEeB87IIg/Ym5i/bHfD+qmUoWJNXkjhwMLWXUtzRXEe5xG24
         C467/K90qTgNHCve+Mq5sSdNCtRlwNdBTFvc5AjqKLaXtVIouLDkUmxI/EyY1PoPh0lX
         R7vjv1We5Qg985X3gHUSTnQwoif+QwowfYv/VWnoBfM0gtR1JAamYCF8ypXxqeRP0Y0s
         Dcae42XOyXoDBPhfwf11BK9uIx9vUn73nGU4iIQb+kwCFtLq8obG+c9PycxfF8xhRd/d
         R9z+Bvbw7O9AMHOafSyjpJtvTwHo7hGaMFFb8tuxFBp4Ts4gCtTjRuThPYKX3OtMf79A
         Lv0w==
X-Forwarded-Encrypted: i=1; AJvYcCUZKkxryJE0/R9Rokf9Hvdq7PshwnV0PUjh9+WloEV/Qh/AQnIQU/BQDb51sP4TkyBXWXCnUIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIkyFY6USb0pfaZN9NnHL7LrE5s4/ADJfJGmq4psXdhaEuxlB
	0Du4uiTRvPfDcB7anpvdXVLXlv9cMKVp60c1q6B8dlpP/UETfsVXTeC9T0gg7BFIG8sTgbo6Iu8
	2PxyTtRTjxzCsZ+AHpuC5sR1jHZGu9JEm/q9pZREF
X-Gm-Gg: AZuq6aKRRAqCoRBM7tI7+3JQ5T1UVt3jW2s9TuMZicQ46Cn31MID+BKFNoJo4RKVW11
	yMqb+o5tJnjG4fCVK1Z+Irdjqk7AwrNVo9YTHsFHgEid+J5UVJDpCnKPMyuZdcdGdODqbdb9DGS
	ElZzJSFOJCaBIkmk0kN553yHlN26qpEhDl4SGBuA93q4BP3KdlLGy7gt3FpiGZRnDNoefxCARn9
	Lo/jSpFBS6i94oV1SayQ9cDEzWC6D6uQG2X7ERrPXed1Ka/ka5yt2mzPKL/4ZtazUg9y06BVhpi
	HVQP3RBNbGKkkJ6jh88VCPHqpFzeun1rrs+s
X-Received: by 2002:a05:622a:60b:b0:506:2116:4b93 with SMTP id
 d75a77b69052e-5072c9ed3efmr6181221cf.10.1771903697601; Mon, 23 Feb 2026
 19:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
 <aXyV028imsUPWSyq@krikkit> <aYCfVAeKGqF7MIRq@moon.secunet.de>
 <CADhJOfbkUFaPfxTBrmOnrEh2JvxPKpkxaRrSdJHZGxeoQsQTcw@mail.gmail.com> <aYD9O5qiA1R2KIJ_@Antony2201.local>
In-Reply-To: <aYD9O5qiA1R2KIJ_@Antony2201.local>
From: Yan Yan <evitayan@google.com>
Date: Mon, 23 Feb 2026 19:28:06 -0800
X-Gm-Features: AaiRm537pqqKRtp-41V--fGiJBJPW7CjJ2gm6nMlaXkIE3lDTedzV9ZVKyivjeU
Message-ID: <CADHa2dB+-nCHQK5nu0wKXKw+ut4wieUtoB9Gd-csr7sn8ZKjtg@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 3/8] xfrm: allow migration
 from UDP encapsulated to non-encapsulated ESP
To: Antony Antony <antony@phenome.org>
Cc: Nathan Harold <nharold@google.com>, antony.antony@secunet.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260322-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phenome.org:email]
X-Rspamd-Queue-Id: BBE8618160B
X-Rspamd-Action: no action

Hi Antony,

Sorry for the late reply. We=E2=80=99ve prototyped this and confirmed that
Android can be changed to explicitly provide the encap_tmpl in the
MIGRATE requests. Also we are excited to have kernel support for
encap-to-non-encap migration.

Thanks,
Yan and Nathan

On Mon, Feb 2, 2026 at 11:38=E2=80=AFAM Antony Antony <antony@phenome.org> =
wrote:
>
> On Mon, Feb 02, 2026 at 10:15:24AM -0800, Nathan Harold via Devel wrote:
> > Unfortunately, I believe Android relies on this behavior (at least for
> > now). We never re-send the encap parameters.
> >
> > https://cs.android.com/android/platform/superproject/main/+/main:system=
/netd/server/XfrmController.cpp;l=3D1183;drc=3D61197364367c9e404c7da6900658=
f1b16c42d0da
>
> Thanks Nathan. It is good to know.
>
> The next question is how do you feel about changing the behavior in
> Android? Would you be willing re-send ports every time the SA has it?
>
> This will allow more flexible migration. Migrating from NAT to no NAT an
> IPv6 without NAT would be possible.
>
> If that is a bad idea, I would limit this change to the new method only.
>
> regards,
> -antony
>
> >
> > -Nathan
> >
> >
> > On Mon, Feb 2, 2026 at 4:58=E2=80=AFAM Antony Antony via Devel <
> > devel@lists.linux-ipsec.org> wrote:
> >
> > > On Fri, Jan 30, 2026 at 12:28:19 +0100, Sabrina Dubroca wrote:
> > > > 2026-01-27, 11:42:40 +0100, Antony Antony wrote:
> > > > > The current code prevents migrating an SA from UDP encapsulation =
to
> > > > > plain ESP. This is needed when moving from a NATed path to a non-=
NATed
> > > > > one, for example when switching from IPv4+NAT to IPv6.
> > > > >
> > > > > Only copy the existing encapsulation during migration if the enca=
p
> > > > > attribute is explicitly provided.
> > > >
> > > > Are we sure nobody out there relies on this behavior (silently copy=
ing
> > > > the existing UDP encap without having to explicitly request it in t=
he
> > > > MIGRATE request)? If there are, this patch would break their setup =
by
> > > > clearing the encap that they expect to still be present.
> > >
> > > Libreswan and Android are the main users of migrate method. Libreswan=
 sets
> > > the
> > > value in every call. I am guessing Android does that too.
> > >
> > > Yan, would this patch cause regression in Android?
> > >
> > > Without this fix migrating from v4 nat to v6 and no v4 nat won't  wor=
k.
> > >
> > > Also the ENCAP migrate with UDP port was broken before, 2017,
> > > the commit 4ab47d47af20 ("xfrm: extend MIGRATE with UDP encapsulation
> > > port") ?
> > > So likely it was never used by older code and PF_KEY.
> > >
> > > For the new methed strongSwan wants to support migrating from UDP enc=
ap
> > > to no UDP encap.
> > >
> > > regards
> > > -antony
> > >
> > > PS : Steffen advised not to Fixes tag.
> > > --
> > > Devel mailing list -- devel@lists.linux-ipsec.org
> > > To unsubscribe send an email to devel-leave@lists.linux-ipsec.org
> > >
>
> > --
> > Devel mailing list -- devel@lists.linux-ipsec.org
> > To unsubscribe send an email to devel-leave@lists.linux-ipsec.org
>


--=20
--
Best,
Yan

