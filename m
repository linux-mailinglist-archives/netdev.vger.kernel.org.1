Return-Path: <netdev+bounces-53100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14A8014B1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967A7281D08
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF7584FE;
	Fri,  1 Dec 2023 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAIDRR5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE810C2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:41:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so2903a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701463291; x=1702068091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l60mpm+HpmDDRECKGguC7L2r56SrsrZfby9L3hYEIMw=;
        b=KAIDRR5vTHhGGFU0Icz1cR0ygMaaXndJfmWcBVA8JkPQ3M9OJ/DbdUx6VqHVAQlgz0
         wnk2RADpVrqjNfLfFXr8AsPJ6C9zSB7Ck2LL511X2kiyPs1ukBWDo8ar7oJrqdF3teKS
         5wtc116QrnAZRAWKk+JYAbFMcEiRpt0mq0DQ5XNljmaaGMqmUumIC6JGcaXPTbkOy75V
         qJybHQYLSQ4rVqgHpUzhy7JP9tGKpT/egNXZ0WMS8NVDlb99UDV36f8ZFzS0v1O7Pgr+
         if1YSUvwQG2q0xNKseHHWnq6GFdFKYypqkxdjOPR+28D6/bdxnqW9DiwkCFZ9UK6L/j2
         Gx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463291; x=1702068091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l60mpm+HpmDDRECKGguC7L2r56SrsrZfby9L3hYEIMw=;
        b=A8ZBp96jxuX7FWKTzoQrPf7aSfZfpM53F3r+ZQmBLXOS9LgjbZlBr4CvGZifslFdkt
         qlwb21ifqMF7aSEVfscpDVsmECARayn+VIDVXcqQ9HhraUsF1dzABnee/jQlyowDqBbn
         WP1mJcqbPc88EdZGa5RVK3RXpul81pSr5hw44ecFNxGOxVVCb4dH8FTxqgfk6awOfder
         3jAY6SMOm3wCTp9Mj/vjn+4Bv201uV56UD6Lapd60UnRzaLE7ZtmK81y0Jy9Z4HyTCMA
         MBTFF83DVxDzN+ExCb0vgQiqpR07DeogGpPUkV9cp1AdENy2Qh9vDUKe+27T8TkG4b+Q
         TurQ==
X-Gm-Message-State: AOJu0Yw9xTeutnbk9FkEglgdJRsq86m7bw4Im7Ecoq84U5wDFlEo+0Ww
	x6asXsVZ/JSX7xr8UDZlQigoIfjXE27quqTNF58ttQ==
X-Google-Smtp-Source: AGHT+IFZ8GJQ3vxEQOl5mMTV42i2pYfNeAUbGo7Tibi6Pizw6BIw+mE1Wt6yZOdTBC7HZl06D8gf1Krg+4CjsJLZz+g=
X-Received: by 2002:a50:d547:0:b0:54c:384b:e423 with SMTP id
 f7-20020a50d547000000b0054c384be423mr132288edj.5.1701463290972; Fri, 01 Dec
 2023 12:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
 <20231201203434.22931-1-kuniyu@amazon.com>
In-Reply-To: <20231201203434.22931-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 21:41:16 +0100
Message-ID: <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: gnault@redhat.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, mkubecek@suse.cz, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 9:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Guillaume Nault <gnault@redhat.com>

> > +                                             goto next_bind;
> > +
> > +                                     if (sk->sk_state !=3D TCP_CLOSE |=
|
> > +                                         !inet->inet_num)
>
> Sorry for missing this in the previous version, but I think
> inet_num is always non-zero because 0 selects a port automatically
> and the min of ipv4_local_port_range is 1.
>

This is not true, because it can be cleared by another thread, before
unhashing happens in __inet_put_port()

Note the test should use READ_ONCE(inet->inet_num), but I did not
mention this, as many reads of inet_num are racy.

