Return-Path: <netdev+bounces-58910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9B8189A9
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A50C289F33
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD41B292;
	Tue, 19 Dec 2023 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnQuVp3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE111B28C
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5c85e8fdd2dso37786337b3.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702995788; x=1703600588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6qevO3mWcMJ9WIF9QqqkCxVjaljOz4+rdl8AKEEU0w=;
        b=qnQuVp3rS1rwo4TyQJyKHhuR2RNdO60FgeSNEzCURYvB1OdCWzugpCWNYHE5g8vKlk
         QS3SQyO7HAa8R6WJ70hnpnKbYV+flMLT+v0KB/TCkkfjwq49RSGgcn1m3bCP697xzeDT
         WlYz/8GFHOMSZ+upLDwiko2CH9YqXVo4MDcLp2gSRUz7KuHEapodMKCc8Kbtk1Aqu73h
         8pc8bJZaLE2EgU+phaDRZtvrigKEXm6aHqHLW/4YZnqmnC8MU9+oghBtKyMKFcdzgskD
         mVrGJ9K0TJFDQDBRzGy19N9l5UtLlM0q0r7kiuI97AM0OUvy7XrG5XoDlElSlhd1I59T
         3PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995788; x=1703600588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6qevO3mWcMJ9WIF9QqqkCxVjaljOz4+rdl8AKEEU0w=;
        b=ehlCIo0pXy0oRp2Xyx3aeZ9iProi7sD4Y9+FSErcD+6clRW7hPjvvV0Vsd4zK5vAgo
         w3dYcn3pLIlg7NEispmNRvlXxCK3llxeUHCmUsPyDYdTZ/2uMT2XvcK/KIPqyzuOF+MO
         eDCHA9iQi5Xg5t0XjaXX0l+BWwK+P3+4zSqq87pUxHDgXEqs68gXuV46eqxZLL4Bi5MY
         jjDke52s0FidIPSrR9zBCs+N4RJaPHDaldPqiCwwsYZF73OR29kDtAThhGbN4XW672co
         Utd4jR7XrwdzW3MvY0eZgegSZPK2VbKjc1hKzTObHAjAwR9RPTZ2Ur65cNBfQ8yfxokQ
         ynBA==
X-Gm-Message-State: AOJu0YyTWrXAKaeIoa/AjlNdMaSag8lI5v9n02IASjY4fCbrPVh+ZSiz
	HHQgRXhmvxCjqLgBTDslw0D19jWFInb+ySsM9qTu6g==
X-Google-Smtp-Source: AGHT+IHZWjOExL/wZZtAuHSghNK+NuuwvN+TXTYIaHRJq5/fJhvxAnvn0JsCPCrqLiLl1vOu3IuVBfzH8xD2zPDPFlE=
X-Received: by 2002:a0d:ddd4:0:b0:5e7:6526:91da with SMTP id
 g203-20020a0dddd4000000b005e7652691damr1597568ywe.23.1702995787942; Tue, 19
 Dec 2023 06:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
 <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org>
 <CANn89iLu_vE_S++5Q6Re4c6DZOD7GD-pLFC61VjYGcjFnKDWCw@mail.gmail.com>
 <CACRpkdbq=X485QuFvdd8Q=pPE0Hy4CduBbRZH7mdqag=mQw0ag@mail.gmail.com> <CANn89iKfqZaqL02GigqwypwD7xKxKbiJMWvJsiPigzNBMPYtDA@mail.gmail.com>
In-Reply-To: <CANn89iKfqZaqL02GigqwypwD7xKxKbiJMWvJsiPigzNBMPYtDA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Dec 2023 15:22:57 +0100
Message-ID: <CACRpkdZaPd+t3axd4nEDw0i42Tg0Go-j0h=B8wjGELTraPoHng@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Eric Dumazet <edumazet@google.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:15=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> On Tue, Dec 19, 2023 at 12:42=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:

> > This is often what we want: DSA switches will "wash" custom ethertypes
> > before they go out, but in this case the custom ethertype upsets the
> > ethernet checksum engine used as conduit interface toward the DSA
> > switch.
>
>  Problem is that your code misses skb_header_pointer() or
> pskb_may_pull() call...
> Second "ethertype =3D ntohs(*p);" might access uninitialized data.

Yeah, needs to be done properly and look at skb->len etc.

> If this is a common operation, perhaps use a common helper from all drive=
rs,
> this would help code review a bit...

You are right, Maxime opened a discussion on it in a parallel,
I'll cook something up!

Yours,
Linus Walleij

