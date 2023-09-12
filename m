Return-Path: <netdev+bounces-33028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48679C601
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4113281610
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA3154A9;
	Tue, 12 Sep 2023 04:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E617D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:58:40 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C76C44A0
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:58:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41513d2cca7so192521cf.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694494718; x=1695099518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLIzKOO7d0bZd3UMnClWjaj7cf3WKrg6inZ8KJEIzzo=;
        b=u9vWeg2stZFYZ+zD1BvhIllOfcB6Gw3/81nSLKL6rsfh+890zAnJmyQkbzKYZox5je
         6y+68VV2gxeUZIsr4Abbd4LpFCFdtkcUGXttuVNHzWgKKC2J1GebXBFjfh4DpgPwuHHJ
         8+L4QpTegZ1ReuDqu6x70Mp3S960GJDL3LQ6rd2loruorrdeSIJnpheM2xE6cy37Jemp
         TXJg3xfrtlijKPVxRwdRpljL7EPbsSbejI7TFJWYrRAQenBUbrH6asuB7IF92VYi8QSq
         wm1yN6n1JB915Ilf4uF5YYQ+gvmlEZ0ol+wSctyO/TGkwAVfwZMKxkm2cXJ/PPjZgxgL
         b67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494718; x=1695099518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLIzKOO7d0bZd3UMnClWjaj7cf3WKrg6inZ8KJEIzzo=;
        b=BC8mKe0/AcLm619nefqd1zXNgEU4cDgcYT+pSuha4Yg1u2+ZQxxyGYxOD5yJijoVxp
         mpod4n8Soqy8r3kZijy3Oao4PLrRdTgW8QYh4d7aC+Emkjq5j5mtrsQ53+aPt3qZ1peZ
         wxhonk8AnLBmLqeOQXuBG/rQS9j86vnpiuZC2i+f/7d4Eb50/tYTK9lqWjjYgsSi8l4k
         i7wahQ04hhvZexaswxGtMxz3hGG75SdGMxv8HU+MrLn8Djp2dJdDz3AHBgz0UjbAZsFa
         U5QLRI2pEPrdR4MFi5dMQpay4yzq2yaPk/+m2/MeVB0C7d5RXumn0O3yn9BM1rmVyWl6
         29Yw==
X-Gm-Message-State: AOJu0YyruVXuRdUo+l5vH1UXZ7Cb0rYp7yKBigh+UNbGj5pEdZJGrBXz
	0IymNlBbhIU2z6VEMzhNw0hiAgHek1a6YFA7OSX80g==
X-Google-Smtp-Source: AGHT+IHv7LQ7ftcFs5CmGd3CUKX5RBqzNwk/Kl49CfTXAixnarxRd7OTXorJL33D7QLr07YbgUWNvhpo+9oZIdCIyuQ=
X-Received: by 2002:a05:622a:1a8b:b0:410:ad05:940a with SMTP id
 s11-20020a05622a1a8b00b00410ad05940amr107930qtc.21.1694494718148; Mon, 11 Sep
 2023 21:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911183700.60878-1-kuniyu@amazon.com> <20230911183700.60878-3-kuniyu@amazon.com>
In-Reply-To: <20230911183700.60878-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 06:58:27 +0200
Message-ID: <CANn89i+3Fgo+wez0zS9sDPnP-F_9HerX7cEELrC=9c1wcoxvoA@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/6] tcp: Fix bind() regression for v4-mapped-v6
 wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 8:38=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Andrei Vagin reported bind() regression with strace logs.
>
> If we bind() a TCPv6 socket to ::FFFF:0.0.0.0 and then bind() a TCPv4
> socket to 127.0.0.1, the 2nd bind() should fail but now succeeds.
>
>   from socket import *
>
>   s1 =3D socket(AF_INET6, SOCK_STREAM)
>   s1.bind(('::ffff:0.0.0.0', 0))
>
>   s2 =3D socket(AF_INET, SOCK_STREAM)
>   s2.bind(('127.0.0.1', s1.getsockname()[1]))
>
> During the 2nd bind(), if tb->family is AF_INET6 and sk->sk_family is
> AF_INET in inet_bind2_bucket_match_addr_any(), we still need to check
> if tb has the v4-mapped-v6 wildcard address.
>
> The example above does not work after commit 5456262d2baa ("net: Fix
> incorrect address comparison when searching for a bind2 bucket"), but
> the blamed change is not the commit.
>
> Before the commit, the leading zeros of ::FFFF:0.0.0.0 were treated
> as 0.0.0.0, and the sequence above worked by chance.  Technically, this
> case has been broken since bhash2 was introduced.
>
> Note that if we bind() two sockets to 127.0.0.1 and then ::FFFF:0.0.0.0,
> the 2nd bind() fails properly because we fall back to using bhash to
> detect conflicts for the v4-mapped-v6 address.
>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Reported-by: Andrei Vagin <avagin@google.com>
> Closes: https://lore.kernel.org/netdev/ZPuYBOFC8zsK6r9T@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

