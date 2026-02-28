Return-Path: <netdev+bounces-262121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HWMMiDoomlG8AQAu9opvQ
	(envelope-from <netdev+bounces-262121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:05:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7D1C317C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22B173019FCD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3C36212E;
	Sat, 28 Feb 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LdWYHt/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58158364944
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283931; cv=pass; b=DbwktXJ1KIXCTdiC5Ik3iy+9iRWMB0Mi3LiryJua4i/MxvWmxxC8kwi+YIeK72fYAIsDKbloR6gJsTdABneaPF5E6ZktpSJ5kY31OasIrGAZwVJr19MYscIgntjBc7vnhw9MSh8fvnNX4dy7QLSO5KtlWQhJe5vOk5ayz2/DWZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283931; c=relaxed/simple;
	bh=OqozRgE+7Hr2AbFLJnG6hrQ5TWyJLeOE7GLaUeOb7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/f7icxEFt/+y7AOkCa6qHjUqCGkWb1BveRhaktI0HBWmlXuhPhiX4PRpclDE1H2uTfUDkDs72QlUioIMUGDkeTuTXG3EBFLgQa2xsYky8T0OafyZQE5ElfCrI5JyeOwSRueT3zKHglIOV2oWVIJxkmZsGoO4KF2UzNhSDsrLaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LdWYHt/z; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad4d639db3so14239925ad.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:05:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772283930; cv=none;
        d=google.com; s=arc-20240605;
        b=SbQaJBTJeR5afJW/jjf19ipCgwX94tLpl/PI/9pY/RobRDBBqoMnUcMQxfl/CaOzxx
         rtVdkY/Mwz4X3p4EaEU33fWr+mZ/bpCTKGGWzH8b/EFhuhintWzzu0xQg6kGcLWvhAbL
         flZmwoRVKGfJ7D0AmfRDMzomNx3CD7LvjDF9FBuzNzqk+tYJz891G0dkaTXmuuj42fLO
         uiEZZJNqmELnJL/KjI/Bmqfx617qqKKEAlvemL49aulllfoGN74IDVGRztMDxAGfHCQQ
         eb7upYUQolBP+2fk7l4EACdD1qUZHx3c4ai10+E7TURk1U8jRHXC0ubRF7ZI3reMCRFg
         Up5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqozRgE+7Hr2AbFLJnG6hrQ5TWyJLeOE7GLaUeOb7A0=;
        fh=vjLW6jY5srCzNU4cDo2A0X0bPYmeHUDTwq+W+b+Sm2I=;
        b=aefY3FMyHFgREo8en86vdzvsfzzFAQb7fPFKCsttti8KLY50cjJmYwXce6wKtXl3g8
         lvM8IzXR/mWjtccwwdJCh5oXdUHphHt2r0ZTjNA7znxZ2o6O3cW34Pxsbe0F2MYw34oC
         r16dTCHKa53Xse+rBtN2jEDDbbFGQLfvEHnmEX87qWd8pKUrtsMoUJPr1K3VUHfpXRx+
         zAVveLr6w9l/JttoXc0sjOMoAKrUU/+6RlAsHWVtzLFrpzGlHG+JvieggD4M9doKl4vZ
         JtB4Xrbob4xQtc4XEd95EVEZk8a7NtP28QMr1qsJ//Uoo3eBYa9hBRsgRCm2zKejedZe
         GK0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772283930; x=1772888730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqozRgE+7Hr2AbFLJnG6hrQ5TWyJLeOE7GLaUeOb7A0=;
        b=LdWYHt/z7UszWxsjf2OOzfhxDD5y9UTAr37f0eD793Z1/354DhMychY27Dl5AdKmS7
         0tnSiuN/1u6EHiQ1c7gfR+0qx1vDkgg6y2H5kFW3zv9fwItp3+NzWyV9Jr3PIaI6emgA
         ni8t0OvdSEAXdImwHwu9QmrpoxYo0kfwZ/ptUW15MfThkPrg+ZbNX9VehwnLynX6cryk
         7jn4+i2LUJt0hpjkKrXam6FjsGMvWNuIoteW1X6AURnW60TmzuvsWs5qlrVl2Ioh/Ld5
         ujhzCaGfFVyi6L7z63DNonnNuH/ZC3JhWyjz2VLS8QtXxVZhNnsFDU565TlL/ziwsK+f
         v8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772283930; x=1772888730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqozRgE+7Hr2AbFLJnG6hrQ5TWyJLeOE7GLaUeOb7A0=;
        b=nYGAcq58HpNXbnkvDVHVWl37NSDFlgZUwX6/6fQRM9mgz7eSoUFguLGUvLkobMUyjq
         lnc07pXd5iKoq3w20D1tX4InX/vebwqhr1twMQi9FvMhckM6+5u75EYdXQOjXVxUY1S5
         P9Dzy1xw3XjfLliilRg1yx54c9bl+a8vKnT4D+zz46r58g9NfXQJS6ThkqFi1BXsFD4D
         /OvzWcpQdaES00/o5bboyycpgmuhMeP3VqbGy/hxavAjcmkFYkaes/rzQr7c3drVvLVf
         TLFUB/yL2fKnRBQYLOmlje4YDcqg7pAj7bbUQE5PzZq1KogA80nnL1wqkq4jbo5cyBIs
         tYqw==
X-Forwarded-Encrypted: i=1; AJvYcCUNgWOQJS4vhnrLX0IQDWNtZEPVP0YSvr9ODbLAZQ+mjmHbmJnaIumZp/4UBqpTT58Ne/7F57w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykc1vXS+uypq/MmKFA294eQNpgJ5Ln3C72GObyG0Qq5npiSQJQ
	XQF2nabYg5hZqZlwMj6lLqKUetNYR4ju55w3cqNbOXHiLm/WtnDNxJhh1r67oVkoOYlsX+WgK5X
	BtGStG2FlBZbA7aiyE7nd2mmZqYeliVWXsTC2J2tv
X-Gm-Gg: ATEYQzxMJixruRqaZ5c1DaXtwybAOYH258tw55295nA5ddUPXTaZf5ka5Fe11xzc1vG
	JMC6AXbgOG3OfwKufkmDrEc+FoHUoaXxwqV7z/hsyXbAiUw701iBUm/UwlYzQzfRruSR5SWAvMs
	hHABr4jXUIxxzShFqLHdUTHTDPyFh8Y7lkDfhSdTJiIkxQJPSgSzTa8ApPRgPLAhfD+1PdMLnTh
	JxBT89fsyzVSzX4M1xB7ytpJswVuCO95KWbNQsc+bRFKV2BQEEg64c6xG4dz+j+mUnmlOAWBRHz
	IZUSJHLVaqnT7ieWjq6ynIcO0w==
X-Received: by 2002:a17:902:cf0f:b0:2ad:99bb:3129 with SMTP id
 d9443c01a7336-2ae2e4e8d73mr54637665ad.50.1772283929489; Sat, 28 Feb 2026
 05:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
 <CAM0EoMkFMURPj3+gNOaqO60D4deeht2F3EZWZbmShjO+B4wJBA@mail.gmail.com>
 <CAF=yD-Jah3+1Sj3-Us72fKNu-__sg7pNb+-kC_knAV=iTHAitQ@mail.gmail.com> <CAM0EoMmAQ8RvHRmyEeMwehhNe0yXzn8NU5UvwitzAoL3cwVPqg@mail.gmail.com>
In-Reply-To: <CAM0EoMmAQ8RvHRmyEeMwehhNe0yXzn8NU5UvwitzAoL3cwVPqg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Feb 2026 08:05:18 -0500
X-Gm-Features: AaiRm50J7n10K1tJc5XtV8aE3FRKjaSqWroTN1RyVqgLAaiRSaTEaJr15HC97dA
Message-ID: <CAM0EoMmXq67kso-n_+Y6sCMhJkkiE8b0R1Kn-d0rLb_X=ALV3A@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-262121-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3C7D1C317C
X-Rspamd-Action: no action

()
Sorry, I was busied out so dropped the ball on this one...

On Thu, Jan 29, 2026 at 4:22=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Jan 29, 2026 at 12:06=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Jan 15, 2026 at 6:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Thu, Jan 15, 2026 at 5:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:

[..]

> > > > Generally speaking I think that a more self-encapsulated solution s=
hould
> > > > be preferable.
> > > >
> > >
> > > I dont see a way to do that with mirred. I am more than happy if
> > > someone else solves that issue or gives me an idea how to.
> >
> > It might be informative that there used to be a redirect ttl field. I
> > removed it as part of tc_verd in commit aec745e2c520 ("net-tc: remove
> > unused tc_verd fields"). It was already unused by that time. The
> > mechanism was removed earlier in commit c19ae86a510c ("tc: remove
> > unused redirect ttl").
>
> True - we used to have 3 bits, but we can leave with two;
> Unfortunately, a single bit won't work - otherwise we could have just
> used the one available.
> Only one bit was available, so we recouped another (skb->from_ingress)
> and adapted it to use the tc cb struct.
> There is still a chance that could cause issues - all the users of
> this field were CC'ed and i was hoping they would respond.
>

And indeed reclaiming that bit is problematic. So the AI didnt catch this ;=
->
Stephen, see if you can improve your prompt to catch this in the
future. Should be noted this would be nice to include as well in the
netdev type AI to catch cb stomping bugs. Turning skb->from_ingress
into an skb->cb field is problematic because the bit gets written way
before we hit tc. First the mlnx driver writes it in
mlx5e_tc_int_port_dev_fwd() and then the GRO code trumples over it. So
by the time it gets to tc it could have an arbitrary value. So I guess
our overlords are not ready to take over ;->

> > The IFB specific redirect logic remains (tc_at_ingress,
> > tc_skip_classify, from_ingress, redirected). Maybe some of those bits
> > can be used more efficiently. The cover letter for commit aec745e2c520
> > had a few suggestions [1].
> >
>
> Using the iif check against netdev feels a bit "dirty," but if there's
> a strong view that it's okay, we could liberate that bit (some testing
> needed) and in that case i would leave skb->from_ingress alone.
>

Let me try to reclaim skb->tc_skip_classify first and see if that
causes any issues.

cheers,
jamal

