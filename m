Return-Path: <netdev+bounces-35473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A57A9A35
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FB4281B15
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182E1549B;
	Thu, 21 Sep 2023 17:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D91170D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:48:56 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719819280F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:48:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053a7b36b0so8105e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318526; x=1695923326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dWFJnVjGFmbTuADXXCQGOQYxstl8fO1IHn2a61y2ws=;
        b=ikmCRr3QjEKJrHPA6I7TmQ8GYFVntrsGAMWvaRLR5Lq+56cuYT8Rhfx5kIrl2umQy5
         74vBSnG4swd9m9YGkMLWKvYMKQIo4qF0unjc913d19VvE8A0drAcxts9PyKu1GF/GVFY
         iU1ISWzi8qEgl22Yqqs1b9gs2R1aOxh4pfx6a3hPJ1t3C7D/0lFx4bfC70aM8rM76SB3
         JZHR436YVIrbDBd0b9mICFSNWOOyJlBhgEWXSd3hZl/VgSGXkUobviBGQHOnc2mu0Y/B
         q8RYpppaQ5mljDO8+6P24i79dy+tsSs9KnQJ3/0VXp/ZACK6nSeQTgRrEWelRyoTksff
         Bzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318526; x=1695923326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dWFJnVjGFmbTuADXXCQGOQYxstl8fO1IHn2a61y2ws=;
        b=Sfb1tglxE6zbNb8TDYTBjwj2ojWb2Lnup2c7FXoSrYKYs/+yM0RWzCutCGK2b6RAF3
         ooxQJG2rxv+lU78cTN7bmYurF0xvBwFrhoepIPJ9xY2TxaoqLMLxWUByCd+d7l31beQG
         p0cgYwQCbT6NX0pS7PNBAJqVW5VCphqbKj6mKd0oE1CtB86T7HjD0ufQ/KMP/s9Pb2xP
         yVyrwjXNdVWYwUmuFTnZNYeTc3nkcQXuY23LJFQQPy3Q61JbQtGt9Bsce6IeT3jd937H
         E2T7SIlZiP2pUyre32w7wzlIQSeK6xhyYR41VZpJMO4mAuVIyGRp1eGn9kvp9izZVss0
         uuVA==
X-Gm-Message-State: AOJu0YyyoqMGWRt5KYhrhYf038J4ZBq9k5M2+ovQObUZBYV5+9qAvN0j
	DgQgfQjAuX8huyzhHW9JPbETDDe5Ta+jewl6LbxyQaumH0v0+j7lCOSLhxSM
X-Google-Smtp-Source: AGHT+IEWwglfNsMiSEUReu6IkMvRcHC4kESDo+aWQBIwsEObNM9dneHBzDmbGNXhXRdQGo1H2UPWJwg7AKIluhlmKc4=
X-Received: by 2002:a50:d610:0:b0:525:573c:643b with SMTP id
 x16-20020a50d610000000b00525573c643bmr34629edi.7.1695278298934; Wed, 20 Sep
 2023 23:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-2-lixiaoyan@google.com> <69c8b5ce-7b08-42fe-a4f3-724b9b676d19@lunn.ch>
In-Reply-To: <69c8b5ce-7b08-42fe-a4f3-724b9b676d19@lunn.ch>
From: Coco Li <lixiaoyan@google.com>
Date: Wed, 20 Sep 2023 23:38:07 -0700
Message-ID: <CADjXwji6+OSxZzLoPUKpEHM9VNcN4nm5Lq9LAzU0qO619uk_8Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We used 64 bytes for L3_cacheline_size_x86.

We only have arm64 in our testing environment, and we can update some
results on that with the different levels of cache lines on arm64 and
x86.

On Sat, Sep 16, 2023 at 7:36=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Sep 16, 2023 at 01:06:21AM +0000, Coco Li wrote:
> > Analyzed a few structs in the networking stack by looking at variables
> > within them that are used in the TCP/IP fast path.
> >
> > Fast path is defined as TCP path where data is transferred from sender =
to
> > receiver unidirectionaly. It doesn't include phases other than
> > TCP_ESTABLISHED, nor does it look at error paths.
> >
> > We hope to re-organizing variables that span many cachelines whose fast
> > path variables are also spread out, and this document can help future
> > developers keep networking fast path cachelines small.
> >
> > Optimized_cacheline field is computed as
> > (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> > results (see patches to come for these).
>
> What value do you use for L3_cacheline_size_x86? What is
> L3_cacheline_size_arm64, L3_cacheline_size_s390, etc.
>
> Do you have any profile data which compares L3 cache misses vs L2, vs
> L1. I guess there should be some gains by changing the order of
> structure members, such that those which are used at a similar time
> are in the same L1 and L2 cache lines, and so only need to be fetched
> once, so reducing cache thrashing.
>
>       Andrew

