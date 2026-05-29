Return-Path: <netdev+bounces-293178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFDEEJHVGWpmzQgAu9opvQ
	(envelope-from <netdev+bounces-293178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:06:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43AD607075
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558DE3043FC4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20838F932;
	Fri, 29 May 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/r52YLH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxEbbHTQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D138F62F
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076412; cv=none; b=GFKRP3nzvnJznPFgPWJnMtOSau3Uqp36z9Avxguo5LqjbTQyP6oF34Hme4z16pXho3kHm0NaQ6diyll0Ku0mnHDCZloVid3lqL11O48iYBz+MyFLzO4wUB6KI31yPxaluKQuGjQur5fZwWIvaeiON+EIpIvv3hnpn5ScSGfBtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076412; c=relaxed/simple;
	bh=NDY91sr8l6lZhPB3WgzqXnWkjsnPOGzL1hqYgwm1SFQ=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=jzdhNrgOqNsid7sEyC+DYoNQYCcOrYDOlC8uP0v1Pz0uAeamKBfLg+W/SWfrBF4qwErpDSAAfqdSjMr5cJuS1DY008yGIwhH0WD0l91TRYiscOvYovXTIIg6LOmrX+HXldPW/iYIp2lukM9ef98FLvKKmMi7G7RHhKiGDnLUH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/r52YLH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxEbbHTQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780076410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mROXqwjM1FYjjL5btqEYHboTKDCZibxVmrYJ4MK4Oso=;
	b=O/r52YLH6lnHQ/79DkJLF5b6r6Vyv9hx9lfbcVzhoFZHQXU0bdrF/HsHwMFB8F2ksbY1DG
	iKXPl75CXt90z9TNfD9ovG7DmBFemWGQq95+stIxOfFf2L2fACdwIp3aqCE7rJWyfhl0P8
	Gn04879GwAneYA6/BgdCN7ikLMXQFAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-coRBZyIoOGeadKMEUiezZQ-1; Fri, 29 May 2026 13:40:08 -0400
X-MC-Unique: coRBZyIoOGeadKMEUiezZQ-1
X-Mimecast-MFC-AGG-ID: coRBZyIoOGeadKMEUiezZQ_1780076407
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d127eb013so68173425e9.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780076407; x=1780681207; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mROXqwjM1FYjjL5btqEYHboTKDCZibxVmrYJ4MK4Oso=;
        b=dxEbbHTQ/b9Qpqe0Cl9gCmyVRhiexBq4hQ8pjZ/qedZzkovivDstjNv1yhhSUgtLVp
         5E8OxhTbOcFHqtW6E/sdDr49FDVr/Jx2o2HfuX8MvjyNypIi4mthRqqrTapwpuXeB3oa
         qQGttLWjgj2VpSbcrlOrvEMYsOTJBWZxa1iPnkPO/xHfPKZtk2vvHf0OYX5zxRfnK7Nj
         yZcvxT7w4HaYA7cVQ312KZNuLN3k2WSaFN+zzGn7CMLXcbsXJa9fYbXxP2vzIvpE3zhC
         /E0OzFiZ8HjckM7GvvGauxMdqvR8RXvlRCwyuQQXJQfgXpSFS++PdqlBcqD2Erf66i2Q
         vJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076407; x=1780681207;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mROXqwjM1FYjjL5btqEYHboTKDCZibxVmrYJ4MK4Oso=;
        b=qOGtA29AqC8Yq3cQU3DujleGVJKucun4oGCK78IVxvfgbeIjmzwXQ19DUrZCCJygYz
         gHbJNZytl8WQV/gPGn8EAHLgj985FjVAJ69JLhKm6ggSBjWDgI8Xyyxh7wdMBfKluOut
         c2TYI9xNtQScCBsXAMevKs7R3+rgbLbyg31WYLilF2mHjjNBCXw071P5qd5jk7Vb5uRD
         qqQWmTs3tpU1nuyPxgaz1gimvhZXgQDyMxHzPWpN92kyNy8VqOB7bg3c3EFMoAWm4uaJ
         HBkGVF3rMMLcK1gHJrWwz8/qEe24lOSWQfVHkMZiAmABago/gtd2aVUieldc6tNNTNCJ
         E3kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k8p0NtiaHaLOJ6aF6PUSnWze1ItRR7CynX3YE5FlfuX77ZxVtpJdyuzHUyIbYY2RunAnEOac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aDD6U1Y+GVPYC8J3Ou7YCft4rAm2zZFUrN+lmLj3ZLt/O5h1
	unWqDALwTWGDFi7jOzEWLfY9d/+WMs4g43OmDHhdUjp7FbMmMiLqTK3gBV52QuQAX4VjN/d39NT
	2GyOapA8331QOIvqVAk9ryg3zrSa+SuoHTZIm2sSMNdCcO/aWGeDfTsm42Q==
X-Gm-Gg: Acq92OFp/Lj0XZu+bl5aEnQSHod72jElFkAfTEuIPDNjaEtjidw4p9A9YnDlwKQ/Ccj
	xdwRrDiYKrxZ/2bNMcw9g5u8/iogAyvvrGBiy6latkC/ydCEFCfdB0RuGnjraxFNJTz0ICcAeE+
	d9eLFFtay/8jRc05n2sRo3r8LS1ap8J59/swe5R57QzkeBgiqIdy1CdORvv10mkb/isdSb57RZW
	JUSXFqkWtAvq4ct3UsszRM9sSA9YxOgSjLrnwxf+zjvvjSARJuIJs8T08/v/uiYKfD3JsZUEAoz
	ou619S6SnLwcIUYu4fO2Qlzt7wIOQDauxrKaBkwFlwsy5jCg4YC6i83omSnXR47DXpxGd9HlxTc
	SxcAe6+k7Ci4yDGqmQ/eKQvaeqqjX2nSDo6HxLwTJr8W0XrGzma/lvav07nyE
X-Received: by 2002:a05:600d:8654:10b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490a29121b8mr8995585e9.1.1780076407244;
        Fri, 29 May 2026 10:40:07 -0700 (PDT)
X-Received: by 2002:a05:600d:8654:10b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490a29121b8mr8995135e9.1.1780076406689;
        Fri, 29 May 2026 10:40:06 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0b896csm49925345e9.1.2026.05.29.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:40:06 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Beniamino Galvani <bgalvani@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, =?UTF-8?B?w43DsWlnbw==?=
 Huguet <ihuguet@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260529194003.776fd26d@elisabeth>
In-Reply-To: <ahlQ_YFS0s_8B03q@tp>
References: <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
	<20260528153202.14900687@elisabeth>
	<CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
	<20260528165320.15b90ded@elisabeth>
	<CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
	<ahhm1-XfnsWyIWDV@tp>
	<20260528192143.31c9e9ea@elisabeth>
	<ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
	<e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
	<20260528212213.4aa613f8@elisabeth>
	<ahlQ_YFS0s_8B03q@tp>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:40:04 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.de,redhat.com,leemhuis.info,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D43AD607075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 10:40:29 +0200
Beniamino Galvani <bgalvani@redhat.com> wrote:

> On Thu, May 28, 2026 at 09:22:14PM +0200, Stefano Brivio wrote:
> > > >>> about the source address selection is impacted. Indeed, the commit
> > > >>> had effects on one of the selftests, which had to be modified to
> > > >>> change the order of iproute2 invocations.
> > > >>>   =20
> > > >>>>>> If the fix must be in NetworkManager, we only need to parse
> > > >>>>>> them in non-reverse order like IPv4, I guess.   =20
> > > >>>>>
> > > >>>>> But that would then require some form of detection, and, at
> > > >>>>> least according to Fernando, isn't the most robust option
> > > >>>>> anyway, as ideally NetworkManager shouldn't rely on the order
> > > >>>>> at all.   =20
> > > >>>>
> > > >>>> True   =20
> > > >>>
> > > >>> Correct, if the new behavior is considered better, there should be
> > > >>> a way to detect which order must be used. Otherwise userspace
> > > >>> tools won't be able to maintain the same behavior with different
> > > >>> kernels.   =20
> > > >>
> > > >> My remark here is about whether NetworkManager needs to detect this
> > > >> at all. If it used timestamps to detect recent / older addresses, =
as=20
> > > >> Fernando mentioned, then you wouldn't need any detection at all,
> > > >> right? Or is there something else we're missing? =20
>=20
> The problem arises from how NetworkManager handles updates (e.g. after
> receiving a Router Advertisement). At each update NM determines the
> list of addresses to configure and checks if the addresses are already
> in the right order in the kernel. If they aren't, NM removes and
> re-adds them in reverse to achieve the desired order. Since kernel
> 7.0+, the order changed and the addresses always appear in the reverse
> order.

Oh, I see now, thanks for explaining. That's a bit more than just
relying on a given order. On the other hand, it sounds like you have a
possible detection mechanism already implemented. :)

> This creates 2 negative effects. First, it breaks source preference:
> if users configured a profile with addr1=3DA, addr2=3DB because they
> wanted A to be preferred, now B is preferred. This is not
> NetworkManager-specific, it affects also simple scripts that add two
> addresses (like the selftest that had to be changed in the commit).

At the same time, it fixes the kernel behaviour for anything that might
expect the same outcome as IPv4, or relying on iproute2's save /
restore functionality, as I'm showing here:

  https://lore.kernel.org/all/20260529114216.2e42c4dd@elisabeth/

...one might argue that it's more likely to break things than fixing
them at this point. I'm not sure.

> But most importantly, at each commit NM detects that the order is
> wrong and constantly removes and re-adds the addresses. This
> continuous cycle is what causes the bug that Chris reported.
>=20
> BTW, NM doesn't touch the temporary addresses directly; they are
> automatically removed when the corresponding SLAAC address is
> removed. Since the problem is not only about temporary addresses we
> can't rely on timestamps.

So if the kernel change is not reverted you would need to have a
detection mechanism and change NetworkManager's behaviour according to
the detected kernel behaviour, correct? I guess it's nasty / ugly? But
doable?

> > > > Ohno. Now that Beniamino and I=C3=B1igo mentioned it, this will lik=
ely break
> > > > many other environments. In essence, many tools relies on the previ=
ous=20
> > > > ordering to identify which address is the primary one.
> > > >=20
> > > > E.g cloud tooling communicating with the metadata server via IMDS(v=
2) to=20
> > > > configure IPv6 primary and secondary addresses. They are likely rel=
ying=20
> > > > on the ordering for that. =20
> >=20
> > I haven't seen any tool specifically relying on insertion order for
> > this so far and I'm having a hard time believing this kind of tooling
> > wouldn't rely explicitly on home / care-of addresses or different
> > labels -- see RFC 5014 and RFC 6724 Section 5. (or, perhaps clearer,
> > the examples in section 10.1, in particular rule 4. and rule 6. =20
>=20
> I'm not familiar with home addresses, reading the RFC it seems that
> setting the flag might have effect not only on source address
> selection but also on other aspects?

In theory yes, that should affect the destination address as well in
the sense that getaddrinfo() should prefer the same type (home or
care-of) of address as the candidate source address, but I'm not aware
of any C library for Linux supporting ai_eflags / AI_EXTFLAGS that
would be needed for this (RFC 5014 section 11. discusses the
requirement).

As far as I know those flags are commonly used just to prefer a given
source address. I'm not sure if it's used by IMDSv2 tooling, I couldn't
find any evidence so far.

> > But I'll look for more convincing examples in a bit (maybe you have some
> > at hand?) =20
>=20
> I remember we had users reporting issues about the ordering of IPv6
> addresses, I'll try to find links to them.

I'm currently asking around about IMDSv2 cases. I think it would be
really interesting to see what users might have reported around
NetworkManager over the years, in one sense or another.

As to an hypothetical NLM_F_INSERT_LAST flag, I think that would be
fine for pasta(1) and containers, because the same "buggy" behaviour
that one might have on a host / parent namespace would be replicated to
other namespaces, and we're mostly interested in consistency.

The effect of keeping the "wrong" behaviour as default looks rather
problematic to me (see the iproute2 example) but we could also "fix"
iproute2 by setting the flag and maybe propose that as default after a
number of years.

--=20
Stefano


