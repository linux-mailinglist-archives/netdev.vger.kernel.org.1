Return-Path: <netdev+bounces-36648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D357B107B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 03:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 589ED1C208B5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95215C9;
	Thu, 28 Sep 2023 01:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB517EE
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:52:21 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3DAC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:52:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5ff5f858dso66547935ad.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695865939; x=1696470739; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGhrGA5LATQVSvvuYiZw3/ef+ARJe2Xj+Xt/fzkc/CA=;
        b=hNmMfWJsZtAshhRLl/ocLqwV4XPOPzPhqDj1rbz0xajew2ZEfJZIJ5VY0RPxXFVsnI
         2ix3vIqm52wlxGXDTYPJTO4oX6GFFXE+63vUqpMi0Qa/2VlIFy8NzYeLDlJg+mDExMDt
         bD0DqPS0cP8LDfGGx99HFGe9A/h+dy0YG1YP3A7WSXfCgAlGsfHQTeQJamYAu/Pj/pg9
         OlTYAIaOYK99VduH4z640dEuKbXNCcN3wqkvxIz3M/rpnsAhIkotDi0+mWvgtxMLqYp8
         bURsuZSf85dwTEvi8dx4gIrePoQIfb3xzrBHzXQ0rQydTPpPXlxYNzb6Td9aRF+KHAad
         KY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695865939; x=1696470739;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGhrGA5LATQVSvvuYiZw3/ef+ARJe2Xj+Xt/fzkc/CA=;
        b=shr+Md/4CM9w6xYxBOCp2gcU8Ol+Ww8N8Cp0zgi+Oa2R44R9O92DnndGurjl3vHbUF
         LC6BwLJjRCvkn6gM7Ol62BAu09XKerXtOYnmVrDdEJcwb5ZTP8L9FOJlyE/jp+mlVVHO
         nCRXLunI7xH/LvkZR5Nh8pV/iVdqeWVi5/lKW46LxxsCjepgng+w5pe+HENMtlch7IMP
         SOOkjeeXJrXiNdAX3/7PDkrspSe0eKSIy6dHQMwN9QPhCkqOl6l9rSVRsx3wOUBF+E9I
         NFHk3t2iTrVNx5Qvc0oX/+mDKvvuacCzosyfhvOZ6Wcz5TikfJ8hT022eVMGzYR/rx1s
         Jlfw==
X-Gm-Message-State: AOJu0YzJzVWsazlIWuekKFE9BeM4uXoed8RUR6oCgBKAyWMLHrEOxeRI
	yk8tKQclr7KXYonCWqvGyQcXObPT4Ts=
X-Google-Smtp-Source: AGHT+IEE2RZ/BpAmSDks74Jpflk23RBuuqTMBu80XLHHnylqZY84xhzvMULsv2FphC7LgEr5R6WloA==
X-Received: by 2002:a17:903:187:b0:1c3:b1d8:41b7 with SMTP id z7-20020a170903018700b001c3b1d841b7mr3271955plg.7.1695865939403;
        Wed, 27 Sep 2023 18:52:19 -0700 (PDT)
Received: from localhost ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902c94e00b001c465bedaccsm10149207pla.83.2023.09.27.18.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 18:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Sep 2023 11:52:14 +1000
Message-Id: <CVU6AV9T8CVH.GCHC8KB7QZ28@wheely>
Cc: <dev@openvswitch.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ilya Maximets" <i.maximets@ovn.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
In-Reply-To: <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Sep 27, 2023 at 6:36 PM AEST, Ilya Maximets wrote:
> On 9/27/23 02:13, Nicholas Piggin wrote:
> > Hi,
> >=20
> > We've got a report of a stack overflow on ppc64le with a 16kB kernel
> > stack. Openvswitch is just one of many things in the stack, but it
> > does cause recursion and contributes to some usage.
> >=20
> > Here are a few patches for reducing stack overhead. I don't know the
> > code well so consider them just ideas. GFP_ATOMIC allocations
> > introduced in a couple of places might be controversial, but there
> > is still some savings to be had if you skip those.
> >=20
> > Here is one place detected where the stack reaches >14kB before
> > overflowing a little later. I massaged the output so it just shows
> > the stack frame address on the left.
>
> Hi, Nicholas.  Thanks for the patches!

Hey, sorry your mail didn't come through for me (though it's on the
list)... Anyway thanks for the feedback.

And the important thing I forgot to mention: this was reproduced on a
RHEL9 kernel and that's where the traces are from. Upstream is quite
similar though so the code and call chains and stack use should be
pretty close.

It's a complicated configuration we're having difficulty with testing
upstream kernel. People are working to test things on the RHEL kernel
but I wanted to bring this upstream before we get too far down that
road.

Unfortunately that means I don't have performance or exact stack
use savings yet. But I will let you know if/when I get results.

> Though it looks like OVS is not really playing a huge role in the
> stack trace below.  How much of the stack does the patch set save
> in total?  How much patches 2-7 contribute (I posted a patch similar
> to the first one last week, so we may not count it)?

ovs functions themselves are maybe 30% of stack use, so significant.  I
did find they are the ones with some of the biggest structures in local
variables though, so low hanging fruit. This series should save about
2kB of stack, by eyeball. Should be enough to get us out of trouble for
this scenario, at least.

I don't suggest ovs is the only problem, I'm just trying to trim things
where possible. I have been trying to find other savings too, e.g.,
https://lore.kernel.org/linux-nfs/20230927001624.750031-1-npiggin@gmail.com=
/

Recursion is a difficulty. I think we recursed 3 times in ovs, and it
looks like there's either 1 or 2 more recursions possible before the
limit (depending on how the accounting works, not sure if it stops at
4 or 5), so we're a long way off. ppc64le doesn't use an unusually large
amount of stack, probably more than x86-64, but shouldn't be by a big
factor. So it could be risky for any arch with 16kB stack.

I wonder if we should have an arch function that can be called by
significant recursion points such as this, which signals free stack is
low and you should bail out ASAP. I don't think it's reasonable to
expect ovs to know about all arch size and usage of stack. You could
keep your hard limit for consistency, but if that goes wrong the
low free stack indication could save you.

>
> Also, most of the changes introduced here has a real chance to
> noticeably impact performance.  Did you run any performance tests
> with this to assess the impact?

Will see if we can do that, but I doubt this setup would be too
sensitive to small changes so it might be something upstream would have
to help evaluate. Function calls and even small kmalloc/free on the same
CPU shouldn't be too costly I hope, but I don't know how hot these paths
can get.

>
> One last thing is that at least some of the patches seem to change
> non-inlined non-recursive functions.  Seems unnecessary.

I was concentrating on functions in the recursive path, but there
were one or two big ones just off the side that still can be called
when you're deep into stack. In general it's just a good idea to
be frugal as reasonably possible with kernel stack always so I
wouldn't say unnecessary, but yes arguably less important. I defer
to your judgement about cost and benefit of all these changes
though.

Thanks,
Nick

