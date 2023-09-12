Return-Path: <netdev+bounces-33029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3479C605
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E03E281584
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63732168B1;
	Tue, 12 Sep 2023 04:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55947138C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:59:37 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF44268E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:59:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41513d2cca7so192651cf.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694494776; x=1695099576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2V4Z40dfjex7Lak5h04xkwnYGqcm4JC5/u1fz55z/M=;
        b=DGJDmy7MdAI7KvWkL5SApBwHuza0HUPSqBKioqZluWuEAllEhJKqj9MCnc5QbA/pcf
         SQEVynWh1MjvW7lN7Ws11Gztl/+ziolCQyAAeNfUrcVPOq8BJ2YnOTMQhP2lOXjcLFHM
         pIk53feHvNubvOWE3lAfdksCbCn65AnzuS23n2zqoRHWzlhe+HpG1iR/nVyeMuZpDxP7
         MRFLyEGN3hdScdtXw8Ct4Mb3n0Vgjg5Tq0UlTwN2D3TeE+KROSooNsBvnwfTQybdacWR
         9gaD9OQq1PsOxAtqgXdv2L1xF8/xov3WjdUwm0c2IWY9JzQEt7f7rAQmfKHuOc38XAhC
         2EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494776; x=1695099576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2V4Z40dfjex7Lak5h04xkwnYGqcm4JC5/u1fz55z/M=;
        b=Jp67sScv+42piqR+WCuluDh5awrym4/5Zwf20BLYxPpBOlQbbYzqTekU4D7h9eLKLd
         EEiRLR9dIFjUGR7uJTnj93x4PgcUvB/ctHp6kSGVpTXY8AzYDPvnvPTC1EUiUF1MJPdP
         JdHhQbhYC7udB4LRzCfZvvzSZN6o56bkS+LxBS/MvAS/PONB1hB/GVnDnsyFnxGlltqS
         +qEIRh9iK0sBciBC+m4jKdnPfKUXwgcVB+reo6UF0PmuFcZf6N0j2+HBCUavcv8j+DLL
         JIx8ULzahFZnjXWUJWPdLKrwzG/lyyHQ4OEZEfYbpTPR154kJwyqZqwk3T8BmFSdcJ3N
         e2Qg==
X-Gm-Message-State: AOJu0Ywpsq+/lhYpOea8MhYVQvDdsvbCpa69Ey0RFIT9U+dcA4G+DVFp
	vAQKKIBYi7aVx6DZOge/izBkUQPOpuwJamar9He1pA==
X-Google-Smtp-Source: AGHT+IGlC7QoN5PSYQPUoSUObWJ1sYCdWHNsyXHlLHezWB5zxOIeDab0jyFTVOS9e0JBNzAY2pkEleuj2fOFNVPMlZY=
X-Received: by 2002:ac8:5987:0:b0:403:f5b8:2bd2 with SMTP id
 e7-20020ac85987000000b00403f5b82bd2mr87648qte.9.1694494775591; Mon, 11 Sep
 2023 21:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911183700.60878-1-kuniyu@amazon.com> <20230911183700.60878-4-kuniyu@amazon.com>
In-Reply-To: <20230911183700.60878-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 06:59:24 +0200
Message-ID: <CANn89iKyjinaKDHLzXXOtXEHtbvfPpPnM+=QQJoujfmMKExSDw@mail.gmail.com>
Subject: Re: [PATCH v2 net 3/6] tcp: Fix bind() regression for v4-mapped-v6
 non-wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 8:38=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Since bhash2 was introduced, the example below does not work as expected.
> These two bind() should conflict, but the 2nd bind() now succeeds.
>
>   from socket import *
>
>   s1 =3D socket(AF_INET6, SOCK_STREAM)
>   s1.bind(('::ffff:127.0.0.1', 0))
>
>   s2 =3D socket(AF_INET, SOCK_STREAM)
>   s2.bind(('127.0.0.1', s1.getsockname()[1]))
>
> During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
> fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocat=
es
> a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() tha=
t
> checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
> new tb2 does not include the 1st socket, thus the bind() finally succeeds=
.
>
> In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
> the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> returns the 1st socket's tb2.
>
> Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
> the 2nd bind() fails properly for the same reason mentinoed in the previo=
us
> commit.
>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

