Return-Path: <netdev+bounces-44086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B488B7D60B2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C261C20D44
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45179F1;
	Wed, 25 Oct 2023 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky/Bmsgp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718745392
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 04:06:30 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E8E8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:06:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so4188882b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698206788; x=1698811588; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqXMvG2yZHazgZFuT/988pw2j7RnAblnblJ0Rs61T20=;
        b=Ky/Bmsgp3Tmar8E3NqUFLVjyKkgEkIdQ7mYzdFqAcw7PtFlEI5+peqpe6LwKt4U7N0
         qAJJbz7DQXcnk3SqPRzKhsDgm/fh8NjIFN/L3tfmua5KQd6h6hkpLRgOYpPXn6PpzKI2
         bn0uvmmponVwf0nJYhINQgqhbmGx6jFNd3G3Tcbgz65b8i8yPwgpOU8cPo3lYDWVSAZg
         F4Sy/Do9gm8VG0JZxB3i8FGGbM0EmuJlx2a+499A53GM7lN10GhZw0WcnRJ+JhTJM+qT
         rj/bAIg1NQM2+6FIS9C+88gGw+Ugj9U+HZZs1pjwIcM6AnrxAooAEDrGRzRxQ30ejmoh
         YPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698206788; x=1698811588;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqXMvG2yZHazgZFuT/988pw2j7RnAblnblJ0Rs61T20=;
        b=vCsnu5ZgJZHWwiYL27ASJ00CQfE/Ikuz9Gkx4T0H5x7lR72feBoYxofl3Qxuvr8cCX
         KoDWOLfw1AzVvtcP7nY4uIZcDCQdZg/ycQCXJSCdFqlgB3Jb/wTwqpZaWErPUiFhcHm+
         6e3kyr/tXBl2C1DZ+JvMZjyOcDCVW7WRTzR+XvVnffnqBgZ2Re0molhSCBnmlBLgX9lW
         S0vXejpXgvskqVb2C1wRMOyU00peR9JmdQfrrUR7ir+bppQ/gs4jPH446T8/8VHDsZkP
         LY7Md3k5LWPox2mIuk+t24VVTmHHUk+20AsSiJC7DbE5icOJVOQ+A6+AgMAE9+5yhrh7
         DvtQ==
X-Gm-Message-State: AOJu0YzvSOkneFCMDrDaYLh5XgV8tg9OXoIAV2Pl/GEnznT626R8Yq6b
	9o9+m23Oli5PktEiKlEKMb4=
X-Google-Smtp-Source: AGHT+IGbzZK2xuq+HwWWmKb9VyylT8qmUhY/v/WkghSxd01UxcPguw+aO/WzQzujyS7F4E8WN5IsNg==
X-Received: by 2002:a05:6a00:2389:b0:68f:c215:a825 with SMTP id f9-20020a056a00238900b0068fc215a825mr12705638pfc.12.1698206787633;
        Tue, 24 Oct 2023 21:06:27 -0700 (PDT)
Received: from localhost ([203.63.110.53])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm8377268pfp.56.2023.10.24.21.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 21:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Oct 2023 14:06:19 +1000
Message-Id: <CWH828CBOID2.3U08Y5OKTTOLD@wheely>
Cc: <netdev@vger.kernel.org>, <dev@openvswitch.org>, "Pravin B Shelar"
 <pshelar@ovn.org>, "Eelco Chaudron" <echaudro@redhat.com>, "Ilya Maximets"
 <imaximet@redhat.com>, "Flavio Leitner" <fbl@redhat.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>
Subject: Re: [PATCH 0/7] net: openvswitch: Reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aaron Conole" <aconole@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231011034344.104398-1-npiggin@gmail.com>
 <f7ta5spe1ix.fsf@redhat.com> <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely>
 <f7til71dy42.fsf@redhat.com>
In-Reply-To: <f7til71dy42.fsf@redhat.com>

On Sat Oct 21, 2023 at 3:04 AM AEST, Aaron Conole wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Wed Oct 11, 2023 at 11:23 PM AEST, Aaron Conole wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>
> >> > Hi,
> >> >
> >> > I'll post this out again to keep discussion going. Thanks all for th=
e
> >> > testing and comments so far.
> >>
> >> Thanks for the update - did you mean for this to be tagged RFC as well=
?
> >
> > Yeah, it wasn't intended for merge with no RB or tests of course.
> > I intended to tag it RFC v2.
>
> I only did a basic test with this because of some other stuff, and I
> only tested 1, 2, and 3.  I didn't see any real performance changes, but
> that is only with a simple port-port test.  I plan to do some additional
> testing with some recursive calls.  That will also help to understand
> the limits a bit.

Thanks. Good so far.

>
> That said, I'm very nervous about the key allocator, especially if it is
> possible that it runs out.  We probably will need the limit to be
> bigger, but I want to get a worst-case flow from OVN side to understand.
>
> >>
> >> I don't see any performance data with the deployments on x86_64 and
> >> ppc64le that cause these stack overflows.  Are you able to provide the
> >> impact on ppc64le and x86_64?
> >
> > Don't think it'll be easy but they are not be pushing such rates
> > so it wouldn't say much.  If you want to show the worst case, those
> > tput and latency microbenchmarks should do it.
> >
> > It's the same tradeoff and reasons the per-cpu key allocator was
> > added in the first place, presumably. Probably more expensive than
> > stack, but similar order of magnitude O(cycles) vs slab which is
> > probably O(100s cycles).
> >
> >> I guess the change probably should be tagged as -next since it doesn't
> >> really have a specific set of commits it is "fixing."  It's really lik=
e
> >> a major change and shouldn't really go through stable trees, but I'll
> >> let the maintainers tell me off if I got it wrong.
> >
> > It should go upstream first if anything. I thought it was relatively
> > simple and elegant to reuse the per-cpu key allocator though :(
> >
> > It is a kernel crash, so we need something for stable. But In a case
> > like this there's not one single problem. Linux kernel stack use has
> > always been pretty dumb - "don't use too much", for some values of
> > too much, and just cross fingers config and compiler and worlkoad
> > doesn't hit some overflow case.
> >
> > And powerpc has always used more stack x86, so probably it should stay
> > one power-of-two larger to be safe. And that may be the best fix for
> > -stable.
>
> Given the reply from David (with msg-id:
> <ff6cd12e28894f158d9a6c9f7157487f@AcuMS.aculab.com>), are there other
> things we can look at with respect to the compiler as well?

Not too easily or immediately, and if we did get something improved
then old compilers still have to be supported for some time.

ppc64 stack might be increased to 32K too, which would avoid the
problem.

But whatever else we do, it would still be good to reduce ovs stack.

> > But also, ovs uses too much stack. Look at the stack sizes in the first
> > RFC patch, and ovs takes the 5 largest. That's because it has always
> > been the practice to not put large variables on stack, and when you're
> > introducing significant recursion that puts extra onus on you to be
> > lean. Even if it costs a percent. There are probably lots of places in
> > the kernel that could get a few cycles by sticking large structures on
> > stack, but unfortunately we can't all do that.
>
> Well, OVS operated this way for at least 6 years, so it isn't a recent
> thing.  But we should look at it.

Maybe ppc64 hadn't used it too much before and it was perfectly
fine on x86-64. And ovs developers shouldn't really be expected to
test on or understand stack allocation of all architectures. It
can't be called an ovs bug, there's just a bunch of things where
improvements could be made.

Thanks,
Nick

> I also wonder if we need to recurse in the internal devices, or if we
> shouldn't just push the skb into the packet queue.  That will cut out
> 1/3 of the stack frame that you reported originally, and then when doing
> the xmit, will cut out 2/3rds. I have no idea what the performance
> impact hit there might be.  Maybe it looks more like a latency hit
> rather than a throughput hit, but just speculating.

