Return-Path: <netdev+bounces-63007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D757482ABBE
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49263284EB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70FB12E59;
	Thu, 11 Jan 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKGMeEMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D114267
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so6341a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 02:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704968205; x=1705573005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unRXO3bgzqCCGiqSMIo1ZdR+Jk1lzWVg4UVCVYa4eOE=;
        b=xKGMeEMiLjAIaSfB9KVnefiD/cvQbAP0mBzusMOYYx0pN5A2Htd+SEf0344fAEBmEE
         rcBxrHudLe0sR9+P2MbVT4NCgymnmFpV0djHVXhTR1GNs3fOTTORPjjzI6f8qgfg/9wc
         Dfpnf969MWSjH44aBa8OrbMlpL8T8OaXDQHz5UthXBfdUojeO5cyldDt9QRctYJOW52s
         mL1r7VVS6I8MKgsRiwPk0nQqnyQF3efwTFNBC3iLZjDcQm6IhqeQpobsXOGddFo0L5WQ
         6RfYcNQyf0krGfd7HF9xMV9bzxdnUK5G6diB63504PR0WVN6Gn2LIV1F3Tnd9DpQd8o7
         ZbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968205; x=1705573005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unRXO3bgzqCCGiqSMIo1ZdR+Jk1lzWVg4UVCVYa4eOE=;
        b=LxC5/pNXMfNMyvjoQ6Wo7+LdAdl8GKg2vUTZZ80OIw0tXcKYVJTfe0ybx/vKL4Bte4
         GqE5QpO391GuCS5zHlVsxbe1Kur/U4wZwqD5bIRwpOKNVwmCkvZ9WDCSjXvZnMVR8Uq6
         yqz4/VV1IyTNLy9NwmDBSmQvJFaY5HBKMCSFAFy5Hit5U7cK2I8JLNtw5KDsmeky88yd
         bITowIzywL73EdYFwdLdPaFsRl/jcYORJH/CG9KMuA00jelxQ2G5gh0OzSQ0jLmkCR7Q
         5GfNu4hD+lGa3wlElJpzu2y7BeUNK9wtvfXBUUpzS9VqxmYMW0YqJqkMwA90O8KNLh7p
         p1KQ==
X-Gm-Message-State: AOJu0Yy3+5s4B5egpaVHHa8mDsO6VI57bm9wSEpP8A0jc3aQuH+eYYGc
	iQ39Vc43hhDvVJuET3w4nZ/TKa6e2FPz0qU6v6NaZgIMZOtnz6MEhDeWC6+HAg==
X-Google-Smtp-Source: AGHT+IGxWYLQ1uL3PYlNCMstxI3MLGwlpuku2to8bjjPFO5aEOWNKZ8VRWSKdu5fSLonkU0n0e6fZ3ukIqJjHmgxMN4=
X-Received: by 2002:a05:6402:34c9:b0:558:8016:b347 with SMTP id
 w9-20020a05640234c900b005588016b347mr59573edc.5.1704968205361; Thu, 11 Jan
 2024 02:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
 <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
 <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
 <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com> <CADxym3YHYoLpDsJ1qx3p74eqGPV-CY8sOqxnX+VvzL8SegD_AQ@mail.gmail.com>
In-Reply-To: <CADxym3YHYoLpDsJ1qx3p74eqGPV-CY8sOqxnX+VvzL8SegD_AQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jan 2024 11:16:34 +0100
Message-ID: <CANn89i+0CWaoPr9rMrgB6UeOQwGjfG-9Cj-c=gmNLdxYFUogaQ@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:06=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Wed, Jan 10, 2024 at 6:41=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jan 10, 2024 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > >
> > > >
> > > > Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> > > > Sorry that I shouldn't be too confident to compile it.
> > > >
> > >
> > > net-next is closed, come back in ~two weeks, thanks.
>
> Okay, I'll send the V2 after two weeks.
>
> >
> > Also look at commit d0e1a1b5a833b625c ("tcp: better validation of
> > received ack sequences"), for some context.
>
> Yeah, I already analyzed this commit before. I think that the return
> value of tcp_ack() mean different thing to SYN_SEND and FIN_WAIT1
> if it is zero, and should be handled separately.
>
> Anyway, we can discuss this part when the net-next is opened.

Discussion can start now, but make sure to add RFC tag so that netdev
maintainers
can prioritize accordingly ;)

