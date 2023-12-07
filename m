Return-Path: <netdev+bounces-54937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51B808F9C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52170281653
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D864CE1E;
	Thu,  7 Dec 2023 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIAs5AKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707A10F0
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:10:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so655a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701972646; x=1702577446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8Hmu7FnmICeAYxbjKKT5jPh0Yue6VnP+fm4/9aJSEU=;
        b=uIAs5AKKOEN435sDNbgS76fbUgGng0+RjB7GTSRDj8M0ye5N/BQA7Nq+av3fulIsj6
         nAaBJuXXagLCEl2oM9/hqew8So89nhLxgGSydiSB8hOlntqCuMngFK2Z5Bf+kKESWBUk
         dGq8lGsULs4bL3045R1sl4dMylE7Amv0J9IcBTo10YQ3WhmTazRcpzbnNpO9boa4p3DQ
         0yx0Bdk4eGzmhrnE5T8o5+hQff7qbktYkO4GjbjXu9DkAyp52hXpVYCleQ76oa6vINrp
         K93w8VdHpCznONjb+raPy66JZWgGBcB6gFtX2yd2a1PA94vGnYYXCKOw8huneyVtYxES
         4Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972646; x=1702577446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8Hmu7FnmICeAYxbjKKT5jPh0Yue6VnP+fm4/9aJSEU=;
        b=aPWF8nmLgcbDyF/3KarIt/5heeKSHQqDGMvIgLE3o7rdaluZPGc3NoRWEo7+qXDby4
         3Rqhe+HK0l15JwWeCax4EswjfVX06d0pzBLdStPLeKexUHEO6kw3YJpA+8Ar7wKhaiV5
         4AvIqeuVA945/MCkFGp6lT5x6jNP0tIUSifXKsBuyRoCwYNJubPpTYnfpJaMD3mQSOgk
         zJNKoF/IeOsH7bL4mOcWb50K0IfuMeLSjxKK4OuqRBzWu155VdCh43mwp7feEBnuZRKn
         r8nkgJ+BfYitniZVG9+Ym5O3bNhXxavKTN5xNN7pCzWWhTK/fWF2qDrn9e892nqQCxwc
         2a6A==
X-Gm-Message-State: AOJu0YzUbVP4sr5KVvboqnht0djoZX4VrBDqLqp116fWG4SBJtf2D42B
	hZMgjkY7TV5EM4kW6MVjg82NNKSy6Qzmcphu5mSEKA==
X-Google-Smtp-Source: AGHT+IHt6nJ4Hr33RVZRKkZoPoExLufLMXosujQEw3x+D9JpmBtAoLU00EiH6+RnxQfNygCE8jp/3pfG1SfJ2PL1hsk=
X-Received: by 2002:a50:cc8b:0:b0:54b:8f42:e3dc with SMTP id
 q11-20020a50cc8b000000b0054b8f42e3dcmr243382edi.2.1701972645963; Thu, 07 Dec
 2023 10:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205173250.2982846-1-edumazet@google.com> <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com> <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
In-Reply-To: <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 19:10:34 +0100
Message-ID: <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:06=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:

> Do you happen to have a test program that can reproduce it?

syzbot has a repro, let me release the bug.

Of course syzbot bisection points to my last patch.

