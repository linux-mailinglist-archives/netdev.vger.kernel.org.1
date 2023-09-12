Return-Path: <netdev+bounces-33333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBA79D6F7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058161C20B7B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787E2106;
	Tue, 12 Sep 2023 16:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948D1FD8
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:59:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AE11110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694537939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+IKhwmAIhUtNi97G0S5r7PUpBk17j0WklS2XFNmBD8=;
	b=FXVVDiJEus3zKYLQAWmtC2iDG/laSyC9l0dyJrgRDsVp2HWlMsnMbeAugr6P2mHl2CjDGi
	Ql8qegQkVnYI6vJkhro43FrdQFCb2svSJu4+KjyLsa+io2LyBTguq+hYMneguEXAmFzKEP
	y4tX2JjuGSi5bvwJZ28e9TunnjT1oqs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-cXGgzhCgNdmgSAKqH2ClDw-1; Tue, 12 Sep 2023 12:58:58 -0400
X-MC-Unique: cXGgzhCgNdmgSAKqH2ClDw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be48142a6cso13521951fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537936; x=1695142736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+IKhwmAIhUtNi97G0S5r7PUpBk17j0WklS2XFNmBD8=;
        b=bJh2JNsY21qgM35/Crq6eilmgUuggVZnh89k7zFtNHkOCJaCDo0V0anQ9J6N6P86Iv
         +v+Q8MYBZfjzTZKbLkPf4B8Y7J8AxFKoEisqOLxO+x8JcI8t9WUfxygNsQ+6R57pVAW6
         jGC/oEbirL2eP97HV/oPAtDxuwoPn7j6BOflrJx1C1e+gyuOZn+7Cxn0y3KG3GzIhceT
         cJ8evAlsWjGzFmNS8wIC80IwYWvc9zYnzc3HC+U8l6fy/S55bJzjQuce9Ug/U9AwkctH
         39L6Ubf24qIztq5WvGNxeTA3ff5NrCApfQJ1RmtFG9Rg5n0WzzFXplIw14SvWTovQ3XN
         6fdQ==
X-Gm-Message-State: AOJu0YwYErYFVwjkviF424maqaQc0KpZMsmAfQS0x9k7KJYs3Z84BcU3
	N7zCiB4u2rhoLoCgjHRwQ224NZhCJu9nG6fBmF+nOl3XkWLed37YWeLvWVyaHYpC0rlHE39nmZC
	Ji0v38Xwt+pZJTdVd
X-Received: by 2002:a2e:bc04:0:b0:2be:5485:4a99 with SMTP id b4-20020a2ebc04000000b002be54854a99mr280865ljf.4.1694537936623;
        Tue, 12 Sep 2023 09:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ODfgfk8c9yOTXUFnewhlGWBMLjAGhiBh3CrBAiA8jQJx0YApRUQ4HJXAfOQFdRAjdnu+2A==
X-Received: by 2002:a2e:bc04:0:b0:2be:5485:4a99 with SMTP id b4-20020a2ebc04000000b002be54854a99mr280852ljf.4.1694537936283;
        Tue, 12 Sep 2023 09:58:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id mb18-20020a170906eb1200b00997cce73cc7sm7100561ejb.29.2023.09.12.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:58:55 -0700 (PDT)
Message-ID: <1d9d20d9e41b351114f4e09f2d394c4fa8f03403.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] net: call prot->release_cb() when
 processing backlog
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, Neal
 Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 eric.dumazet@gmail.com
Date: Tue, 12 Sep 2023 18:58:54 +0200
In-Reply-To: <20230911170531.828100-4-edumazet@google.com>
References: <20230911170531.828100-1-edumazet@google.com>
	 <20230911170531.828100-4-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 17:05 +0000, Eric Dumazet wrote:
> __sk_flush_backlog() / sk_flush_backlog() are used
> when TCP recvmsg()/sendmsg() process large chunks,
> to not let packets in the backlog too long.
>=20
> It makes sense to call tcp_release_cb() to also
> process actions held in sk->sk_tsq_flags for smoother
> scheduling.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/sock.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 21610e3845a5042f7c648ccb3e0d90126df20a0b..bb89b88bc1e8a042c4ee40b3c=
8345dc58cb1b369 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3001,6 +3001,9 @@ void __sk_flush_backlog(struct sock *sk)
>  {
>  	spin_lock_bh(&sk->sk_lock.slock);
>  	__release_sock(sk);
> +
> +	if (sk->sk_prot->release_cb)
> +		sk->sk_prot->release_cb(sk);

Out of sheer curiosity, I'm wondering if adding an
indirect_call_wrapper here could make any difference?

I guess not much, and in any case it could be a follow-up.

Cheers,

Paolo


