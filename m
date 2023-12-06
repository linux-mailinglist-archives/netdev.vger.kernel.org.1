Return-Path: <netdev+bounces-54265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7B806617
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9801C20E1B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F06E554;
	Wed,  6 Dec 2023 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6es1Mhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B41BC
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 20:19:38 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67abaab0bc7so19428786d6.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 20:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701836377; x=1702441177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTKy0hiU8NHA7anGYGLHR9WdJQna6PmYER9oYXwLWKo=;
        b=D6es1MhkHgGA8E4kdE2GS9eoGSKvw4ekUSnqrXUV/w/h5qxtv81htxXMr4BAy66T5R
         QZKDWhPJKgsgMnbzX6CuV/fmJkOrGVM57Db7TNVF8mFG1vNmE7IxZ893XqQlGPVgSJ6B
         RKHFGV1rnVPItEZlvArVCxvrvgPvBL6Z3yHaYxjwGog76J013GLEG0W+A331pW4Go75W
         E/qD1CnGfehNbIDJRQl7nvfIVYNy8/+ZhT0FLctusshJ5Ik5y8sgIxnkqtLbM5sv0W1T
         I0pUVmRsvEi0mVsoLCXmsfRCb5cuDnxGidIMiWz1rFMhnZ173eLVf5XRXKR2I18y6Mqu
         eswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701836377; x=1702441177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTKy0hiU8NHA7anGYGLHR9WdJQna6PmYER9oYXwLWKo=;
        b=NjAycc8N/6cO2kWNv7xkAxP3fYaIbseLh5Trq59p7gBB5bC/w18u1LW8kFxxWwWcnK
         30o4CwW+ULuK1LIXrgb8ILqsjOjZ3Zhik1eYF6+pixR8VGhFOaQDUAX9SZ9MPoz471UW
         cksim7khNal7gEVcrQT77Eq84H3krz5gnllFGlxe1LnO5SHPSyDa+EL1xF16IEbk4SLF
         60197CHzV69c3gFhISArmxGL18isZX8ZbBvTJssch1HOOqRCXtqWfOlVnE9PUhuRsYM0
         HGCypF2FzB+GlxHTglhcCEU85+dAaVBQ1wCJB4Vnk1a3J9J2naEsxjJuAdnn44pryKxg
         PZPg==
X-Gm-Message-State: AOJu0YwTz2yyO93YfNrMni/vjMnV256VGFvmI9C+zOebwDZyY9bubsMl
	2yLLo2do2+CtZ3htsjBh+vXhLqYNS3q2baTlvaTF/w==
X-Google-Smtp-Source: AGHT+IFo4+4CNqFxEGHb3Jv+kCSRU8+voGpbi48Qu+qybWcFarsQjMAsQB5slaIkd0ywCi/YDapHfZ0qSPOMyp4S4F8=
X-Received: by 2002:a05:6214:bce:b0:67a:8ff2:34dc with SMTP id
 ff14-20020a0562140bce00b0067a8ff234dcmr280245qvb.3.1701836377008; Tue, 05 Dec
 2023 20:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204195252.2004515-1-maze@google.com> <416f1e84-1293-470f-b613-d676fe9e4f93@kernel.org>
In-Reply-To: <416f1e84-1293-470f-b613-d676fe9e4f93@kernel.org>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 6 Dec 2023 13:19:25 +0900
Message-ID: <CAKD1Yr01-pWf-SCRK2b93r3VGwWfXeZgqz32uYCi1SiwwqBJsQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
To: David Ahern <dsahern@kernel.org>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shirley Ma <mashirle@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:39=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
> > Lorenzo points out that we effectively clear all unknown
> > flags from PIO when copying them to userspace in the netlink
> > RTM_NEWPREFIX notification.
>
> The existing flags have been there since before git (2005) and no new
> ones have been added. So, what is the problem with existing code?
> conflicts with an out-of-tree patch?

One thing that's incorrect today is that RTM_NEWPREFIX doesn't pass to
userspace the R flag added in RFC 6275 (2011).

Also, the 6man working group is in the process of defining another flag, P:

 https://datatracker.ietf.org/doc/html/draft-ietf-6man-pio-pflag

Of course, it's possible to change the kernel now to understand the R
flag, and then, if/when the P flag becomes an RFC, modify the kernel
again to  support that. But it seems better simply to copy the whole
field, so we don't have to change it again when other flags are added
in the future.

