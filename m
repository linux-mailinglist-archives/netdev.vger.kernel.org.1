Return-Path: <netdev+bounces-40219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6EA7C621F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 03:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42922824C6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61B653;
	Thu, 12 Oct 2023 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKXRFvcY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AE62F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:19:39 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92D98
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:19:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9daca2b85so3187335ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697073576; x=1697678376; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kizrb6HRA3kpSwLYZpN6ELiJSVYZUOTPRznk1suDhU=;
        b=KKXRFvcYHLbOWyNyeZHK+JC8ZEYVMxFcaAftzojO0PljZN7S6xfM3bX+Gk6LUZPtKT
         kK7/Aw/aTELrgKeLh/LzLV7hqMlcmHFO0YBdnzLmuPY/m+mvaBitNBt+fbPyNfJ7kHny
         SJ4yH/ahND4kkBgtWIDsUJQhSLnlRT+bPZZTPFRQqKH9Gh9Md8tTRU9/b2x2Dw5ETmRe
         /+ZopTe8rjnrE496Dn2lXptVG6lc77faurblbEBvioLMqLi6O+E2Pvlt0HchrQqhgt/k
         9JETysqY82F4CAldYb4Mz9uW85pKWOAtdaXjRsmS04CpFNONgo40y0aqBA5ay5JPmzQL
         1AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697073576; x=1697678376;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Kizrb6HRA3kpSwLYZpN6ELiJSVYZUOTPRznk1suDhU=;
        b=lMVRYIO/mf8diduBmir1ltyCX3S7ExtUXyuLDRCCdBAqxiz7C17ssvoAkikCwmHMjS
         wRVdy7TSmbe9GtgqEl237LuoilW0E2Ambnly0rFYAzcLqI7J7D4zHp0WVp9e8umq4KEm
         lwa6bLUMrt+Fk1NLp4Ms1+Pngc1mnyb9/CKB16U+ENobyoMGed084paLncrTN5dv6LkN
         EeRX86vvtu4gQGy2uzmpMGuT0COzAKaMebzifSQNOpdTosuvOHt+jx1/omiLm/8wX4Ms
         sgrgIbwUZMsmrPVHmSMQMGYdSvtuajrUpSuDbmpIBQOAqD20a4KyDa7H6Q+w/p0zP8ym
         v/Dw==
X-Gm-Message-State: AOJu0Yx7BiMC9uf22GQ59j53Cj43s0nPhTLyykbkv44G2ZBSYzZlT5Mh
	MnfYMmnqQt68igYul7JDK18=
X-Google-Smtp-Source: AGHT+IH0bov2IFjRMtEpvLE0Hjj0mftNarNnB2Cwb8Fm0VN+D/35cWl/CaRGjLY1/vEPnvFP5VCvKw==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id k4-20020a170902c40400b001c99fa6ce5bmr15155703plk.16.1697073576482;
        Wed, 11 Oct 2023 18:19:36 -0700 (PDT)
Received: from localhost ([1.146.17.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001c9ab91d3d7sm533711pli.37.2023.10.11.18.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 18:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Oct 2023 11:19:28 +1000
Message-Id: <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely>
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
 <f7ta5spe1ix.fsf@redhat.com>
In-Reply-To: <f7ta5spe1ix.fsf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Oct 11, 2023 at 11:23 PM AEST, Aaron Conole wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Hi,
> >
> > I'll post this out again to keep discussion going. Thanks all for the
> > testing and comments so far.
>
> Thanks for the update - did you mean for this to be tagged RFC as well?

Yeah, it wasn't intended for merge with no RB or tests of course.
I intended to tag it RFC v2.

>
> I don't see any performance data with the deployments on x86_64 and
> ppc64le that cause these stack overflows.  Are you able to provide the
> impact on ppc64le and x86_64?

Don't think it'll be easy but they are not be pushing such rates
so it wouldn't say much.  If you want to show the worst case, those
tput and latency microbenchmarks should do it.

It's the same tradeoff and reasons the per-cpu key allocator was
added in the first place, presumably. Probably more expensive than
stack, but similar order of magnitude O(cycles) vs slab which is
probably O(100s cycles).

> I guess the change probably should be tagged as -next since it doesn't
> really have a specific set of commits it is "fixing."  It's really like
> a major change and shouldn't really go through stable trees, but I'll
> let the maintainers tell me off if I got it wrong.

It should go upstream first if anything. I thought it was relatively
simple and elegant to reuse the per-cpu key allocator though :(

It is a kernel crash, so we need something for stable. But In a case
like this there's not one single problem. Linux kernel stack use has
always been pretty dumb - "don't use too much", for some values of
too much, and just cross fingers config and compiler and worlkoad
doesn't hit some overflow case.

And powerpc has always used more stack x86, so probably it should stay
one power-of-two larger to be safe. And that may be the best fix for
-stable.

But also, ovs uses too much stack. Look at the stack sizes in the first
RFC patch, and ovs takes the 5 largest. That's because it has always
been the practice to not put large variables on stack, and when you're
introducing significant recursion that puts extra onus on you to be
lean. Even if it costs a percent. There are probably lots of places in
the kernel that could get a few cycles by sticking large structures on
stack, but unfortunately we can't all do that.

Thanks,
Nick

