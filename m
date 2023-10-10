Return-Path: <netdev+bounces-39596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC587BFFE9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A5B281DD1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402472AB21;
	Tue, 10 Oct 2023 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="y1Ch3xac"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319D29412
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:02:40 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1EAC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:02:38 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7a80a96dbso13200787b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696950158; x=1697554958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1yWK5hjBQ0wjkXfSMeS0ZutGUHPxAuWdRVh9wYUYN0=;
        b=y1Ch3xacV9UYOYbtQF/ygG09JX7W2v2g6rPSFNfYFIah2logoECmUN8/9cutPaJuWV
         kpk1ml99Eu6q6sQlYQWfOwuafIpjdptTUl80mqJvfPhRrJXa4XX+JoCiOLKTl3K3tdPW
         UWs1pPGURmYjtZVW2Xs6crLKupC9acmSYU+/q4NuAiVyOtjGjqsDbfCD0EENkFwbRsCk
         6aZzrbyvVp0wY9tDNxcgKuHtfety/Fq+EVi1b/mU2SLxAgj3bcKeXQvioqTGjGlXhb3B
         gl865YXo/828WdNM8yUv5tv6xztHg2OMN7DJYecw8IsvBmcc9Xrtiftd0sj/zbh64+1W
         JEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950158; x=1697554958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1yWK5hjBQ0wjkXfSMeS0ZutGUHPxAuWdRVh9wYUYN0=;
        b=AqocI1mte15QwjOfuY1wlRYt2boIpyl8vY9wZwpvJVG8Xp8jyn+MOKFj5HvPR2hkUy
         3tzcs+cjwG+7eH7skti8lMxuLWSgKe4u1KoeJ31X+mYPsr/ZmCrQDh4lrRdUQPArXo6J
         2Gjoo2Tudx28jDVW5y6T1VsnfSzw1TORb2c5Oy4PYVy5KC1k9bmNsbBhDCV+EZMAXZ36
         HX+1kZl2yh1Ql0Iu3IRgoJlFZmikRx/uWvOxzWxeNkjH00qymgzxGkdyjDx6nRVeg2CZ
         IRf3u0LMREScmaqiX4a5eMil+dD2+PHjgEsvwSiAS0RNdWkRF9Rkgx1aMeoUyt/xpqzA
         C2og==
X-Gm-Message-State: AOJu0YyhTNal91gdzb6L+tiiqhkbR0rVYy2TVJyTARAdZ9hPkUsLgmu1
	De9VLGOtZWJfsKb1H1dUAe5BWPj/ch1vnPnl+mUL1A==
X-Google-Smtp-Source: AGHT+IHYBpK+4fI/9nFvpGF+AWon1DhPZtC+/skjso/3+I7vMWj+ecsz05uAzVg4IRIY+AFlCmcCo7MX7O6oMEWIIdU=
X-Received: by 2002:a25:8503:0:b0:d9a:4cc0:a90c with SMTP id
 w3-20020a258503000000b00d9a4cc0a90cmr2065065ybk.15.1696950156384; Tue, 10 Oct
 2023 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com> <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org> <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
 <20231009172849.00f4a6c5@kernel.org>
In-Reply-To: <20231009172849.00f4a6c5@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 10 Oct 2023 11:02:25 -0400
Message-ID: <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC requirement
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com, 
	Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 8:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 9 Oct 2023 12:31:57 -0300 Pedro Tammela wrote:
> > > Herm, how did we get this far without CCing the author of the patch.
> > > Adding Budimir.
> > >
> > > Pedro, Budimir, any idea what the original bug was? There isn't much
> > > info in the commit message.
> >
> > We had a UAF with a very straight forward way to trigger it.
>
> Any details?

As in you want the sequence of commands that caused the fault posted?
Budimir, lets wait for Jakub's response before you do that. I have
those details as well of course.

> > Setting 'rt' as a parent is incorrect and the man page is explicit abou=
t
> > it as it doesn't make sense 'qdisc wise'. Being able to set it has
> > always been wrong unfortunately...
>
> Sure but unfortunately "we don't break backward compat" means
> we can't really argue. It will take us more time to debate this
> than to fix it (assuming we understand the initial problem).
>
> Frankly one can even argue whether "exploitable by root / userns"
> is more important than single user's init scripts breaking.
> The "security" issues for root are dime a dozen.

This is a tough one - as it stands right now we dont see a good way
out. It's either "exploitable by root / userns" or break uapi.
Christian - can you send your "working" scripts, simplified if
possible, and we'll take a look.

cheers,
jamal

