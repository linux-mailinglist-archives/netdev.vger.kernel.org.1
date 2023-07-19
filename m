Return-Path: <netdev+bounces-19018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94AE7595EC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE402281586
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F6E14278;
	Wed, 19 Jul 2023 12:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B0107B6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:51:08 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C919F7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:51:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso664221cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689771066; x=1690375866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH+KY+sAnIU4CzTSsdzOW1eUFr67P+UwIjOHBLtTt8Y=;
        b=atpWm7LDbJuINpPMbfxDovC79TSP0MoOYkpGFyproz8WtPpNVjEBe161d4wRMkQWmR
         ygKIOv9tuJttcP99pVlmLDYy6wBVJcVlJJXq6IIiZHyz2KSD/FFJWOCyoV2+ba53rl83
         8XAKttvnRMTA/A66e+/8G3Wfs5Q2voZVVfQF//EeRSlAd17jzU9xb1eoAb6INPNqGv4b
         XMFoW0+HwAnodgb/qwB/CbW0Ryaa3RdUC24EI4q5G5m1LwLAXY84KgbXHPolSMR2Vy9h
         Mqg9mqxHwrRXvmDsOmM59N225V/qEb04jD4Z88WAvk65V0qpK1uhEyqOqLXaTRHqCjMZ
         WwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771066; x=1690375866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH+KY+sAnIU4CzTSsdzOW1eUFr67P+UwIjOHBLtTt8Y=;
        b=A7CLGLp1BELZbJlDKQxbHlDOl13RP9X60wJOfyCuN5KdBZ0ZGNLzMgh2QcjirZ5cA5
         pGYZGWXnnGro557YQvq9c3CDRhy21DuDpfRdDf2hlxfpTFFOLRXQx+qewUO+Zbo3K8fk
         2ruBNjbCtAsNpMq/JE7gYtW8PV9fXYIKP0lp8eE0M2AWl+hIhL3sVycq5urxypIjWfBs
         HD+vxLqXrKUx0wkihYjwhm0T0q1THnuQutApOzF6dOSl5s8TMvC7Gl7kNqODcMwh1+LR
         mNpezu6Kd7pqLR5TRmyY/FX8pMuWR5IM6vHAiOrb4K6zBJ7AwY7+b87Q26yVzzx3SD3Q
         8IDw==
X-Gm-Message-State: ABy/qLbdmwGJ9w7pw/rb32IHhf2EkEIchZeZpS3vLHATLBfzS8IA8Qry
	vSwjicmHkVOQ8TcN7GGCMvLxc5WUSdPCSP4F5qqitOyhKJ5p9rS+d1eyVETMWew=
X-Google-Smtp-Source: APBJJlEPYi6VDK59Q6EGVblhbrOoGNp9YlmOWFS99lJccv+OkoCteLAFuvXP3MGpGmny5eei44VtosZYMjdUzEMmiqM=
X-Received: by 2002:ac8:7dd6:0:b0:403:9572:e37f with SMTP id
 c22-20020ac87dd6000000b004039572e37fmr574664qte.22.1689771066148; Wed, 19 Jul
 2023 05:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712135520.743211-1-maze@google.com> <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
 <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
 <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org> <20230718160832.0caea152@kernel.org>
 <ZLeHEDdWYVkABUDE@nanopsycho>
In-Reply-To: <ZLeHEDdWYVkABUDE@nanopsycho>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 19 Jul 2023 14:50:53 +0200
Message-ID: <CANP3RGdBM+8yZcCmgrw9LTGUbGNNRD0xAx+hLgQE64wxAyda4g@mail.gmail.com>
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 8:47=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
> Wed, Jul 19, 2023 at 01:08:32AM CEST, kuba@kernel.org wrote:
> >On Fri, 14 Jul 2023 08:49:55 -0600 David Ahern wrote:
> >> > I did consider that and I couldn't quite convince myself that simply
> >> > removing "|| list_empty()" from the if statement is necessarily corr=
ect
> >> > (thus I went with the more obviously correct change).
> >> >
> >> > Are you convinced dropping the || list_empty would work?
> >> > I assume it's there for some reason...
> >>
> >> I am hoping Jiri can recall why that part was added since it has the
> >> side effect of adding an address on a delete which should not happen.
> >
> >Did we get stuck here? Jiri are you around to answer?
>
> Most probably a bug. But, this is 10 years since the change, I don't
> remember much after this period. I didn't touch the code since :/

I *think* there might be cases where we want
  addrconf_prefix_rcv_add_addr() -> manage_tempaddrs(create=3Dfalse)
to result in the creation of a new temporary address.

Basically the 'create' argument is a boolean with interpretation
"was managetmpaddr added/created" as opposed to "should a temporary
address be created"

Think:
- RA comes in, we create the managetmpaddr, we call
manage_tempaddrs(create=3Dtrue), a temporary address gets created
- someone comes in and deletes the temporary address (perhaps by hand?
or it expires?)
- another RA comes in, we don't create the managetmpaddr, since it
already exists, we call manage_tempaddrs(create=3Dfalse),
  it notices there are no temporary addresses (by virtue of the ||
list_empty check), and creates a new one.

Note that:
  #define TEMP_VALID_LIFETIME (7*86400)
  #define TEMP_PREFERRED_LIFETIME (86400)
but these are tweakable...
  $ cat /proc/sys/net/ipv6/conf/*/temp_valid_lft | uniq -c
     37 604800
  $ cat /proc/sys/net/ipv6/conf/*/temp_prefered_lft | uniq -c
     37 86400
so we could have these be < unsolicited RA frequency.
(that's probably a bad idea for other reasons... but that's besides the poi=
nt)

I have similar misgivings about  inet6_addr_modify() -> manage_tempaddrs()

if (was_managetempaddr || ifp->flags & IFA_F_MANAGETEMPADDR) {
if (was_managetempaddr &&
!(ifp->flags & IFA_F_MANAGETEMPADDR)) {
cfg->valid_lft =3D 0;
cfg->preferred_lft =3D 0;
}
manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
cfg->preferred_lft, !was_managetempaddr,
jiffies);
}

Here create =3D=3D !was_managetempaddr,
but technically we can have create =3D=3D false, and yet valid/prefered !=
=3D 0.

This will be the case if we have inet6_addr_modify() called where
*both* the before and after state is a managetempaddr.
Perhaps because the expiration was updated?

Anyway... because of the above I remain unconvinced that just removing
'|| list_empty' is safe...

