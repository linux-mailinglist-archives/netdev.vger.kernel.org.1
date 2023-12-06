Return-Path: <netdev+bounces-54524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97A807605
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D5B20CBD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FB49F70;
	Wed,  6 Dec 2023 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkXidoGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B562C9
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:03:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso11618a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701882228; x=1702487028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXyslMnIZtRapEGeN7z4lysSeKHGYAdXDShPVwlnUUw=;
        b=JkXidoGVcSrvxIJFrTCu2yInx1lJJiyIUVvH9a6s/1eMzxYFCxyn0O5XfzmOgjDo6d
         n7PPbi6acTHMW1PePTOoLQVwqADzJTxaiecHnQ1sD1d2fgIwlnAnpKpKa6Af38forvO5
         hzOSB62CL6tCrGXA0U88rw7rkS5hLux2SqsLXvzWyIcQlhuil9X18RYz847dufGpMxEM
         Su8gi+G1/z9uCb/SWV0IMlAPwtcXNV+i2c75pGANulaq5nvR66lU+j2y3YRIjMWQWUKX
         ri7rL7BCg1B4ET3yGTABswEFQIa7j1isJeYIZCDaQYTnQ+ih3BaHdIGUuj5sF4roBdDV
         6TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882228; x=1702487028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXyslMnIZtRapEGeN7z4lysSeKHGYAdXDShPVwlnUUw=;
        b=twj4FFAdvyip7Rb5Ey9mqt10XfidLLNlfe2uZpiOp+2uPqV9jxPfEzt4dKF15bgPoe
         MkVoJ9tnL5HWhYyua4RkrgOVjOPTvyI8weDFcPAXuNAeceEkZ9tQuA5Aonh4xk/2BWjO
         OYfUBhs/v3uY+RroFhgTpsXyOrblUz2Ruu81GeEWE4T1x3JZV2dZ7n/VjXlDMcgPz5dA
         wxJbzsmgCg7ZtdR3OUDVW9TxrrP8VOW+c3nxc1TU2JhSSw76G9yvujmNb5+9xMaSRdPP
         KDeA2sTLFZp3GGUxQ7EXzPyLH4PlR+4cCt8kaPecyR/EMRrXx1nW0XSzn6y/+zvyPDdW
         B1ag==
X-Gm-Message-State: AOJu0YzXknVyJp5KK3eHCQ0qJRZcJDpE8B0iI/nqUebDm91vh6EMJIOo
	Jr6QYrcagerifo14BUNuv/rAwHQvcXqykIcpD9NYVg==
X-Google-Smtp-Source: AGHT+IGoKYoou302Ne+vj4H5KEhWJ9/qbdc+7XT14Kbh8SNBgcAuCPatNxWSUnnQPvztZgh1JOKkrAI0fTKWpHoYAgo=
X-Received: by 2002:a50:d744:0:b0:543:fb17:1a8 with SMTP id
 i4-20020a50d744000000b00543fb1701a8mr79388edj.3.1701882228456; Wed, 06 Dec
 2023 09:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141054.41736-1-maze@google.com> <CANn89iKwwfUzh23+dwS5iUCy1vybQ17TqNFbuKc_D2V-RD-i4g@mail.gmail.com>
In-Reply-To: <CANn89iKwwfUzh23+dwS5iUCy1vybQ17TqNFbuKc_D2V-RD-i4g@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 6 Dec 2023 09:03:31 -0800
Message-ID: <CANP3RGewCVT8fATuL3tfVAkE-zgZQpJhNSKJJp6Rc37+2fTofA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv6: support reporting otherwise unknown
 prefix flags in RTM_NEWPREFIX
To: Eric Dumazet <edumazet@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shirley Ma <mashirle@us.ibm.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:18=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
> On Wed, Dec 6, 2023 at 3:10=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
> > +       union __attribute__((packed)) {
> > +               __u8            flags;
> > +               struct __attribute__((packed)) {
>
> For non uapi, it is recommended to use __packed instead of
> __attribute__((packed))

Ah, yes, and checkpatch even finds that.  Fixed in v3.

On patchworks I also see a complaint about the Fixes tag referencing a
non-existing commit:

Commit: d993c6f5d7e7 ("net: ipv6: support reporting otherwise unknown
prefix flags in RTM_NEWPREFIX")
Fixes tag: Fixes: 60872d54d963 ("[IPV6]: Add notification for
MIB:ipv6Prefix events.")
Has these problem(s):
- Target SHA1 does not exist

I (automatically) pulled it (via git blame) from tglx-history @
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
graft...
$ git log --oneline -n1
remotes/tglx-history/v2.6.2..60872d54d963eefeb302ebeae15204e4be229c2b

I'm not sure... would it be better to just not include a fixes tag at
all and just CC stable@?

