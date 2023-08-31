Return-Path: <netdev+bounces-31491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F7978E5E5
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 07:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49B01C2097C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9D1855;
	Thu, 31 Aug 2023 05:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D01846
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:41:01 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE979EA
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 22:40:54 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-573675e6b43so332882eaf.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 22:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693460454; x=1694065254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5IfIVeN01tRJkWFJQjJszLVp4Gy6lQv3JzGFgaAZn0=;
        b=YBGiC8eEwm4dumRgvmmZ8wZM2rMnBVjckjpi0RjC8w0qPFjlZ/EiFSp8v/6A7Ax9oe
         O0dM1G456Ud38NJ2yuLbUHVGtq2I2WJ3k2KMtcUHX3eBwapiQydtk+1A8r4WqLc6djji
         q/waYj1uqyVJkUA4ncFFUOU7CD8Y0JuxHymuzbQiuJf72pzS3LMykNg4dzVfq4etIzOC
         wisbGorw/zB7bvp1oL9PAnP/WTNmceDnjAp/mFTtKGIsYRVYwuRFJFAw/OiMx+gHrEF4
         Xm5ITb3GqG6j/iczCnLqDMdJ8GCNz6YhWrTPzE1V83KwR5TcelW57K+A3v5ZoaCR2ExO
         w91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693460454; x=1694065254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5IfIVeN01tRJkWFJQjJszLVp4Gy6lQv3JzGFgaAZn0=;
        b=Sh2sFcaK/Uy0Uo4w518bfrq2zR3yq7FDj+oXcXRfK+wbRHuLYijpgrycDzBJz68LD9
         bPCGXp3vUPRJdop5fpRGRodUekjRbbVmu6GRbGUi/ypDkz2UWcbOj/nv4+bQsE5Gwd/N
         x71hoIcZFRD5ot+niypvw3om2lq4g2rT2DgOwWkQ66jzqANs4SEhC4EspoOWGatfsNlo
         pDffRETAJVVkGVfoM/IfUrrwn9M8lAV031vLYMYeU+pkVk7DbtUSWf4fF1YoQaLl2wBG
         JsJdMciZcMQZdUbLm2Cfys3MHwCjZLwihp+UeTt6JAeBvSYWzgz5tMrvN4PeG8iFx2NE
         PEDg==
X-Gm-Message-State: AOJu0YwL2eBB4ezeVthpTGrWHh3yDAQX/xbCZu1CIdbenLL2OwNdQLET
	tq3dD6D35zwnjLwAqSxr/VSlOHPd12QeCk5YChI=
X-Google-Smtp-Source: AGHT+IFgpj+w4DEo7DAVAPnkl/uS+evMrGSCVWit0YAk4WeNLM2L4GkPc6OBhajHUUvMhJqEUouUJu626FnejLbiiHo=
X-Received: by 2002:a4a:314f:0:b0:571:1fad:ebdb with SMTP id
 v15-20020a4a314f000000b005711fadebdbmr4222314oog.3.1693460453960; Wed, 30 Aug
 2023 22:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <20230829054623.104293-1-alexhenrie24@gmail.com> <20230829054623.104293-4-alexhenrie24@gmail.com>
 <20230830182852.175e0ac2@kernel.org>
In-Reply-To: <20230830182852.175e0ac2@kernel.org>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Wed, 30 Aug 2023 23:40:17 -0600
Message-ID: <CAMMLpeSQaHRWXfxS3ew_pbKq93VRDaFGJTkWhwKzu_5hf-REFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] net: ipv6/addrconf: clamp preferred_lft to the
 minimum required
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org, 
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 7:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 28 Aug 2023 23:44:45 -0600 Alex Henrie wrote:
> > If the preferred lifetime was less than the minimum required lifetime,
> > ipv6_create_tempaddr would error out without creating any new address.
> > On my machine and network, this error happened immediately with the
> > preferred lifetime set to 1 second, after a few minutes with the
> > preferred lifetime set to 4 seconds, and not at all with the preferred
> > lifetime set to 5 seconds. During my investigation, I found a Stack
> > Exchange post from another person who seems to have had the same
> > problem: They stopped getting new addresses if they lowered the
> > preferred lifetime below 3 seconds, and they didn't really know why.
> >
> > The preferred lifetime is a preference, not a hard requirement. The
> > kernel does not strictly forbid new connections on a deprecated address=
,
> > nor does it guarantee that the address will be disposed of the instant
> > its total valid lifetime expires. So rather than disable IPv6 privacy
> > extensions altogether if the minimum required lifetime swells above the
> > preferred lifetime, it is more in keeping with the user's intent to
> > increase the temporary address's lifetime to the minimum necessary for
> > the current network conditions.
> >
> > With these fixes, setting the preferred lifetime to 3 or 4 seconds "jus=
t
> > works" because the extra fraction of a second is practically
> > unnoticeable. It's even possible to reduce the time before deprecation
> > to 1 or 2 seconds by also disabling duplicate address detection (settin=
g
> > /proc/sys/net/ipv6/conf/*/dad_transmits to 0). I realize that that is a
> > pretty niche use case, but I know at least one person who would gladly
> > sacrifice performance and convenience to be sure that they are getting
> > the maximum possible level of privacy.
>
> Not entirely sure what the best way to handle this is.
> And whether the patch should be treated as a Fix or "general
> improvement" - meaning - whether we should try to backport this :(

I'm not exactly a subject matter expert here, but for what it's worth,
I think it's important but not important enough to backport. (I would
definitely like to backport the integer underflow fix though.) I'd
love to get more people to test these patches and to hear more from
the original authors.

> > Link: https://serverfault.com/a/1031168/310447
> > Fixes: eac55bf97094 (IPv6: do not create temporary adresses with too sh=
ort preferred lifetime, 2008-04-02)
>
> Thanks for adding the Fixes tag - you're missing the quotes inside
> the parenthesis:
>
> Fixes: eac55bf97094 ("IPv6: do not create temporary adresses with too sho=
rt preferred lifetime, 2008-04-02")
>
> The exact format is important since people may script around it.
> Since we haven't heard back from Paolo or David on v2 could you repost
> with that fixed?

Sorry, I should have looked at the examples more closely instead of
assuming that they were the same as `git log --format=3Dref`. I will
send a v3 with the Fixes tags in the conventional Linux kernel format.

Thanks for the feedback,

-Alex

