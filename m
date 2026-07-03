Return-Path: <netdev+bounces-304339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZD90BTdHR2oLVQAAu9opvQ
	(envelope-from <netdev+bounces-304339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:23:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E966FEAC5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=KzH9HkZY;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304339-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304339-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186AA3012C7A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB7331A6E;
	Fri,  3 Jul 2026 05:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8332720C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:22:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056143; cv=pass; b=Cu9rCwRqwbHI9DB1P9JgKOgHMGacih9DEzQdlCCqOWVuaMyseO5FKwIt1EiVSN6iAGoiuBn1Nuh+qeopUu9naIi2WgU1kD7cV/QCY+jH8XklMdcsvm8E5z9L4nKRa5sbIl96Pk/itIbCdlB13gT/zcq0cNoFskbb1FJonApStrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056143; c=relaxed/simple;
	bh=4xQxJeqEqnlHLED88GC1k092LnUJjBEqAI3h102NWE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSId5MYGUozI+hQPgE4im0djps1pSpyOFqL/N377sKhufRu6mG8VjZ1nBti0mB3Xd1b6pcivwJq1nDQD6wbBXe92MqLGThkh80DuF0ghsdrUMqPUEOrsrSkwanzkbx59gBhGS4pGleHNJhTb3f5aaqDI8vt+zNIbQftKM3YeSoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=KzH9HkZY; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842338c18e0so153114b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783056134; cv=none;
        d=google.com; s=arc-20260327;
        b=ktgo8FgTG7cZn36q+St1NdeOTz4vfyahGYUUMwWXhiXRo1eSOnGCvbml81WvziuujR
         fm3eIOd1nreibDwFcE3cpJasFIXE5yQgH+6gqdp/F4fuaJk/WByq6+JMxvnRF2bDxlz7
         KEtvvX+giKsFX341aQCbhRHSk+qqQzLoWeteQS27kg2qlx1rOpwSQJTU2Numstyu9RP3
         ZJgcbLukpxGyioYc9LhjgK4j3Nf4ubOGweKpDT5HkJEz6LFj2gSGRBxygUthbjKnRraz
         UEnkuGFO1NzuzvTkG2BeCUEwCbaY9tGfl0BV3+MoOQX/+DNtLihq+3PetXFSpUVLHE8B
         liyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wbqJ7L0QFPhUQW/bHhoRwKm6QgSOLcKgZmEvKfbKvI=;
        fh=NyotppbMKleIdfo2bvL+w5CT887/abE9eBPy5Y0NEa8=;
        b=Zi1Fc5U1JxIBgr4b+WnluUHezctHmYcoAPjBQTjdBg/YUNv/b8NZXqHNHHmrNQDo8j
         2Ra0sGlr5rzjn5i7wzKeXuft4L5PFs2VK7juSAMirZqRu6nujsfnv5RmMyYjWdjTDffs
         9ttd46mLCqwb2zBRmMuW1MJIMB9uA3Ezj4Bb2/xLXrFkeOTIK+TPImWpqEZUcbeeI3Lk
         AkuunjIRQ3MkY6L+za+Ay4mPVtixVDkD0/M11KTW12/dkJdODPH/9U8tHE1a9khiFR1O
         eEjzyk0PAWQQkoAnIRB+FTH7zAcSI0eGJLeYKv9po//aN9YQ43iVhoJblfk9GJ4meoF9
         npgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783056134; x=1783660934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wbqJ7L0QFPhUQW/bHhoRwKm6QgSOLcKgZmEvKfbKvI=;
        b=KzH9HkZYxoONaI0HxGneRtIwpVigk+d9jnskHtHuV4Z42nyokTiF0+ppi9POnyecGI
         HozQtFcuQQkZmY09twThbmkBOAghhL2Y3R0n2yVh5OTbSL3AbT+F+WrffkBFlTrLUzSD
         1vrCVUlwSSn7Q1uFF2hU2Vr7ntnyu1Cp+wJG9G7KE7yACMT0/W77kA1Uzmbo6nxJxfta
         8fzU+HGNLCkzGuAb6m2DoS6MQBOCjPRqlvoDGfpwDWPCdKtCVNcrPqQCYDqLJsW7GRj1
         nTZwmV1MXPORBYJ8sWhEbx3iqD2kKzR1s/AhKVHiWARWt6ECUUZbmobVAcziQOhh/DrM
         GZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783056134; x=1783660934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wbqJ7L0QFPhUQW/bHhoRwKm6QgSOLcKgZmEvKfbKvI=;
        b=Z1wLauYPUJKoA0lcoaWz7HKL/kSulKAYz65GjOmXYqdmK5RNk6T8/8TvjXuXvUFtug
         ntgeD9C0Ax8DcF+zKDAvCO6OW0NA0E4kgrOElWn36EUWESXbzaxiFb5FQfWoRCUrI1tf
         LCFRxTdivtYfdvgTTe3+5nA0UrtROWvUc80d3S0Kd1c/2TUDvBHUoEVSet3aPPOIeBGT
         rYj9u5Lja/Egzr8pYDQLg3tHI1tShMIDVYFAs670JVAgAwEfQkQg7YJBsQ8j7StJ4SFP
         9HstavCw/CR12x1ZOHqqU5PDx4Yf7vAiPC/eIftImVrviNlxJh+euprHf3cay/lhe4jP
         i9ww==
X-Forwarded-Encrypted: i=1; AFNElJ9BY+6m1/8P+CEzWCPk3Ukhk8v0xVCANrWB/PXpz6ciCBneQrPryH8JNalW7/0/5jT2qE9v6LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkG6w5CoHJCKPC2kTp91a4wz0RWiTkqvFj/nenAnOLq94upDwK
	niz9JK7VyHxipINqWlw/MEQzoSAR4HZ+ibWiCpkZF7gtKNQBuMqgwDIQ+oBA9UEANHSdJ2GooSL
	0V8jrHtdvCNkGf0XhAXKppy/M4sX6fcb16UhLvx2y
X-Gm-Gg: AfdE7cmjM2IDB3S19TFTivOBfVmnLpVZ13vGa7YGicTbPMs4f6J3bSA/GV4PWBF9hr3
	KnvSvc2pTlW9DpKQa+NDfJulhp0rBLTWCerf7mtP8mHwHVrhIEY0FkmWcwfRwJDuUCFj0Zuz4uG
	lIQfKcxKQLb1vi1edL5Hej5QmcR2n4vpns4GJagXca0apxwvI27l+N/lthpB95wJVJLx+BHv8Xq
	Mixi1DWFbv36fgqDsQ93e+uL8nsSnl4aDBmDShhrE6obUDeHt2VrfvYlXFM/PxFqzWYBqFUJOPa
	9Nkp/5ku0kR4Ngyi5xxStOHhhugW
X-Received: by 2002:a05:6a00:815:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-847c074eda4mr8938571b3a.6.1783056133878; Thu, 02 Jul 2026
 22:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702185805.615241-1-xmei5@asu.edu> <aka5pwAGGI56QrrS@strlen.de>
 <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com> <akczZMzVg7l6tUnU@strlen.de>
In-Reply-To: <akczZMzVg7l6tUnU@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 2 Jul 2026 22:22:01 -0700
X-Gm-Features: AVVi8CfoWRh8jpEdVOxkBHVkWhj5TjfKJ6bTq63LYAwvkdSbkU3jz5U4B1aUrjU
Message-ID: <CAPpSM+SJoeLhh12GnFN0MgMcmxqcOYzBw2_aX2=5E-3HjSFicQ@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
To: Florian Westphal <fw@strlen.de>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-304339-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64E966FEAC5

On Thu, Jul 2, 2026 at 8:58=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Xiang Mei <xmei5@asu.edu> wrote:
> > Agreed, and my patch hides it instead of avoiding it. The problem is
> > the prep loop's guard is inverted:
> >
> >         if (policy->selector.prefixlen_d < dbits ||
> >             policy->selector.prefixlen_s < sbits)
> >                 continue;
> >
> > That skips exactly the policies reinserted via the tree (prefixlen <
> > threshold =3D> policy_hash_bysel() NULL =3D> xfrm_policy_inexact_insert=
()),
>
> Indeed.
>
> > locates for the exact ones instead, which never allocate and get
> > pruned again at out_unlock. So the inexact bin/node is allocated GFP_AT=
OMIC
> > after the hlist_del_rcu(), and that's the failure the WARN catches.
> >
> > The reproducer lowers then raises the threshold so those bins are prune=
d
> > and reallocated during reinsert; failslab just makes the failure
> > deterministic, OOM would do the same.
> >
> > v2 inverts the guard so prep prepares the set that's actually reinserte=
d:
> >
> >         -       if (policy->selector.prefixlen_d < dbits ||
> >         -           policy->selector.prefixlen_s < sbits)
> >         +       if (policy->selector.prefixlen_d >=3D dbits &&
> >         +           policy->selector.prefixlen_s >=3D sbits)
> >                         continue;
>
> Much better!
>
> > I checked the new patch on the reproducer, and the crash can't be trigg=
ered.
> > If you agree with this new patch, I'll send this as v2.
>
> Please do, thanks!

Thanks for checking with me. The v2 has been sent at:
https://lore.kernel.org/netdev/20260703051932.966884-1-xmei5@asu.edu/

Xiang

