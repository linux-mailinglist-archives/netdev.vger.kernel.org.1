Return-Path: <netdev+bounces-51720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3587FBDAF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07332282973
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55C5C91C;
	Tue, 28 Nov 2023 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSyICtZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A73D64
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:06:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so9729a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183984; x=1701788784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B51ucxmEy2aEfz26L5+IMconI2FiGS9DsqMFLwsu5qU=;
        b=fSyICtZGT8AQx2EYdZ1n3j1EQlxsjq1D/MYNLnOrHR5KWe9lGPLnviKwkbhc0V8IfM
         uc/L8dOASj/rauD4Cy73K4iOnmljg1l3/ZBR/rUVcAyDX2ZL+1EJkEvUbyg1PkVLUGsL
         U8hMt1PUBCKlmAQwavN2R+1IYGjHvSvnYK3YQKTxbLeiESOM7VlChKVanP9KPmbympVK
         lrA56riuFLFg7M97m1PfPgcupeTGcT8o6nwqZK9WXbonAFFY4S9h/3HE0v7GU/6QqXT/
         knrP74XiAT1rXpm+RThfF7l4J7W9HVFMbyOOeyS+80qGToPanUVmMlSRhoNbjF7DfWtZ
         SXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183984; x=1701788784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B51ucxmEy2aEfz26L5+IMconI2FiGS9DsqMFLwsu5qU=;
        b=UO7XxvYisXllX2EEFJIA36zEksFR3R1l5cwkhv9QkX7Za8tNUCagHMrfOc/2Q6YU8i
         W4lnoGG68ujW+lwsB+T96MwXcrSelmtWmFLqLLL09wajVdHr5/JcyQVUelsIpmMjgA9t
         cmL5pfMSM2Jiso9JlnKkLNqf9uRj4UHqP9N2BRWxSZFsl7dBZtfGkDWZtzA9VD06fgOq
         MtvxjXsd9p5gUpbqb1qyNOz8BHTVxRR0lb7wqOfVlD9Wn2hdJcdsJ3ViTxiUl61hCeVV
         sgMmBGuv/HDQMKZjYtCMgbNI033QO2txQ1Tzg6TA8NMA55pDXTZvo2kbRsQ6FY8/LLDe
         KT6A==
X-Gm-Message-State: AOJu0YzN0m5prK1IXjXIB/+EnIzWjZq+xiEaeucWmTVJPLcjJfB9F4km
	TLcpg8ebJD+xmosK9r2TuVZsyYWQmETU0DTzeqEDBg==
X-Google-Smtp-Source: AGHT+IHY7ZOwKCAeVi5SbHSRIhd3nsGS9h/rS91KvUd9g4tr1KJiaY1q14pZi0IIjJj8dYtd+512QY1zClQjpLrgj3M=
X-Received: by 2002:a05:6402:5515:b0:543:fb17:1a8 with SMTP id
 fi21-20020a056402551500b00543fb1701a8mr850572edb.3.1701183984229; Tue, 28 Nov
 2023 07:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-3-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:06:10 +0100
Message-ID: <CANn89iLy5cuVU6Pbb4hU7otefEn1ufRswJUo5JZ-LC8aGVUCSg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/8] tcp: Cache sock_net(sk) in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> sock_net(sk) is used repeatedly in cookie_v[46]_check().
> Let's cache it in a variable.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazert@google.com>

Note that because of register pressure, chances are high that compiler
will use a slot in the stack
to store 'net' pointer, which will not be faster than using sk->sk_net

No big deal, I agree this makes the code a bit more concise.

