Return-Path: <netdev+bounces-19594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3875B505
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C94280E7C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34D2FA3B;
	Thu, 20 Jul 2023 16:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65A2FA35
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:53:10 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4911D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:53:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40371070eb7so5121cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689871987; x=1690476787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytgbWjweJhYLCQkujVr9P7eLa6/0lY9GgfG60EKI2zs=;
        b=RWJyFqCQ7De3mfUJyiPpq2IjUpaSQyv9O/ZpmA0wmgeui05ONMJHkRjqsOAo9gzJVy
         NsaSwOzNInZdITcxaSN7+Y1BPtanop3nuXHkzM3ZUNyVBUsylpyNJk7s2YOUX4XOjHQB
         400tLyccC9dGN6YEi5SEb6XsfpW9MZxtgqTBSJkabID9vgIbNOhvxBMn3WU3/XEwNMX/
         hF4E0Xm95W91whakNXoqqGGiZqm4zQkJiv0iOcwMtl+IPbFM57yZq9NfWUoe1gdZN55T
         jTUPc1XwSiXYnOFSEIWJ3pm0bFS6bjmXzJ8lPq/e1eeUBRMULLIAliVvzSvUscvWax4t
         7B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871987; x=1690476787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytgbWjweJhYLCQkujVr9P7eLa6/0lY9GgfG60EKI2zs=;
        b=bUFjvFW6y6e5LK/7otqMjDGWa0eHZCiBmBRBvu0YNFyiGgzCZxri3A3W41RhXDH8C3
         Yga3mV5DO2PjWePtDID3YulhBMpgh6wzK1TfxDM+zXcotfcpWf9marokaoiEQFKwxHWk
         0xKiefkJCDkRn8JCmopyFpJgLuLQQsND+M0wrbz6DSWiHXLujy111oxSlhCaxeU4aiKR
         VmiFjziIjtVMqTpwmQcV8fsjXNPOlX7w0ex+jdg+IYvo71T9ogibewinlP6jtN2E8NUa
         vdCJGG0X0Aassfkh8ZMiPf3bo5WFTkwW/EqxzESVMQd1ohmnS+qsDq5fsCZujNhm2fsV
         PB1A==
X-Gm-Message-State: ABy/qLYhReoZBAjFI4u2ZnIHH+HB3WtF7ABZwDF/MBQE5Lk8AmsJoKZz
	3I68WxepGO0VykF/AKRxscF7E8tKgO/wBYV9jmcaYA==
X-Google-Smtp-Source: APBJJlFmRcSNPu4MrIFrvRIWD/jS+5UxMfIsyTHoQK8XtD5RsDFwLgjDeD1xgF55SidTKvKV+MVmMU8uq4FemoC3ZD8=
X-Received: by 2002:a05:622a:120c:b0:3f8:5b2:aef0 with SMTP id
 y12-20020a05622a120c00b003f805b2aef0mr307593qtx.24.1689871987542; Thu, 20 Jul
 2023 09:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
 <20230720160022.1887942-1-maze@google.com> <20230720093423.5fe02118@kernel.org>
In-Reply-To: <20230720093423.5fe02118@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 20 Jul 2023 09:52:55 -0700
Message-ID: <CANP3RGexoRnp6PRX6OG8obxPhdTt74J-8yjr_hNJOhzHnv1Xsw@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Thomas Haller <thaller@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 9:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Jul 2023 09:00:22 -0700 Maciej =C5=BBenczykowski wrote:
> > currently on 6.4 net/main:
> >
> >   # ip link add dummy1 type dummy
> >   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
> >   # ip link set dummy1 up
> >   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
> >   # ip -6 addr show dev dummy1
>
> FTR resending the patch as part of the same thread is really counter
> productive for the maintainers. We review patches in order, no MUA
> I know can be told to order things correctly when new versions are sent
> in reply.

Sorry, but I'm afraid as a non-maintainer I have no idea what your
work flows are like.
(and it shows up just fine on patchwork.kernel.org which is what I
thought you all used now...)

> Don't try too hard, be normal, please.

What's considered 'normal' seems to depend on the list.

I'm pretty sure I've been told to do --in-reply follow ups previously
when I didn't
(though it might not have been on netdev...).

Email is really a very poor medium for code reviews in general.

