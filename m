Return-Path: <netdev+bounces-63575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C882E214
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308431F2264C
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85711AADC;
	Mon, 15 Jan 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3S0muV/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06D17C9B
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f8cf76ef5bso79603967b3.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705352696; x=1705957496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B5owQJhMGfq7E2l/8Q8+15zFGh01hwobONImQAKqFk=;
        b=3S0muV/WyxbxU7uAM3WFqYWsKtCa2FhUJAKpunpkMHYXeoeH0NDLLy62ccoPSTojBE
         e8m2RAsh8y2yIGfeNh7GVlrRkWF+gWppPq0DUwWNgQw01Zbrsk3x/z/ICBuEhAi9dSOv
         f2+cnyyK9FSyU065zd/1xHdP5w/QJ3e/btAjb+LjSOdRa3N1i5261cHeGadsmkEo+QhI
         hVACgnZqGEX29+cV/sDnECM+SU5ZhqZg0CGqV0miC7TTx25BLPYcJM6GYr1IyPkwvHzK
         aLxGcZ+UT9F2DgQ210I1d8y5kPQ5xZrKFk8TJvGYEkBbVbURYKnyqBsUGDHT4xhxQN/l
         eRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705352696; x=1705957496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B5owQJhMGfq7E2l/8Q8+15zFGh01hwobONImQAKqFk=;
        b=SLleb2Qd6TwHGtAwJJvwiqPOi1Mji8QepSbgZAaj1c3EqJCPxgLFxSZxTaufEX7YCu
         7yeH8Zi4KzqZip8zEKrj63DY9d2/YVskVRvgzX9OuzDkxcOK6fMeZlBwYmYHrPQC9jLt
         aV43MHPfZCc1RRuo3+pOO/CYRvoIceWvqIwgodRGnbX3C+gs6P9xRxi8fKx8j87C56Ix
         3aLrskK2fn+prvtneT9zmlB27m/CHoAoJ1kbIyfywRP0yt2gGz3eHWEVacfn+FH3vYMh
         Xaof+OoW9gMcffFvom0Z0s1xyPcrtlp0kyeHTCp5YwVsh6R/FgRsz8KIJDJDg6PcG5oj
         gqIQ==
X-Gm-Message-State: AOJu0YzuCNox1xIa9a85P2D8xwiCwOgKHitPm/MW7H4Os8l2UWaA7sXI
	U/JltEkbTRkRSPGXeTPnUm28JE1pe6eCyuyaKWXbhPqz+j47mDmw5pwOong=
X-Google-Smtp-Source: AGHT+IGZMR4VTRE+0aDm52H7d7ffs9czzXHDx8Tik/lgGcLvBHTE6nauzeak2B7wWIgnDNOed3URXjy0TqjRUNAF2FQ=
X-Received: by 2002:a81:c74c:0:b0:5f7:f3dc:b050 with SMTP id
 i12-20020a81c74c000000b005f7f3dcb050mr3691314ywl.66.1705352696148; Mon, 15
 Jan 2024 13:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111184451.48227-1-stephen@networkplumber.org>
 <20240111184451.48227-2-stephen@networkplumber.org> <ZaEzpWaTLDG6Ofby@nanopsycho>
 <CAM0EoM=bAsbaNsQUbfO_yLHR2PFXBF9Zq3VXBGPhmKtWsMv5tA@mail.gmail.com> <ZaFdZFA5ebCmwaNh@nanopsycho>
In-Reply-To: <ZaFdZFA5ebCmwaNh@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Jan 2024 16:04:45 -0500
Message-ID: <CAM0EoMmPWOPrw6OM7uAZMVvn+QHn6LiU91s39z9J4-2dXkKaXQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 1/4] man: get rid of doc/actions/mirred-usage
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:40=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Fri, Jan 12, 2024 at 03:55:46PM CET, jhs@mojatatu.com wrote:
> >On Fri, Jan 12, 2024 at 7:42=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Jan 11, 2024 at 07:44:08PM CET, stephen@networkplumber.org wrote:
> >> >The only bit of information not already on the man page
> >> >is some of the limitations.
> >> >
> >>
> >> [...]
> >>
> >> >diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
> >> >index 38833b452d92..71f3c93df472 100644
> >> >--- a/man/man8/tc-mirred.8
> >> >+++ b/man/man8/tc-mirred.8
> >> >@@ -94,6 +94,14 @@ interface, it is possible to send ingress traffic =
through an instance of
> >> > .EE
> >> > .RE
> >> >
> >> >+.SH LIMITIATIONS
> >> >+It is possible to create loops which will cause the kernel to hang.
> >>
> >> Hmm, I think this is not true for many many years. Perhaps you can dro=
p
> >> it? Anyway, it was a kernel issue.
> >
> >Hmm back at you: why do you say it is not true anymore? It is still
>
> Ah, I was falsely under impression this happens in reclassify loop.
> Nevermind then.
>

The burden got shifted to mirred with view that it is the only action
that could cause a loop to happen.


cheers,
jamal

>
> >there - all in the marvelous name of saving 2 bits from the skb.
> >If you want to be the hero, here's the last attempt to fix this issue:
> >https://lore.kernel.org/netdev/20231215180827.3638838-1-victor@mojatatu.=
com/#t
> >
> >Stephen, please cc all the stakeholders when you make these changes.
> >Some of us dont have the luxury to be able to scan every message in
> >the list. I dont have time, at the moment, to review all the
> >documentation you are removing - but if you had Cc me i would have
> >made time.
> >
> >cheers,
> >jamal

