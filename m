Return-Path: <netdev+bounces-58450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B58167B3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392451F22D5E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA66101E8;
	Mon, 18 Dec 2023 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1Lvb0J5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F0F9C6
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702885741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYFndZL7jr7Mve4XesyCYT4iZu6F5m+IzNIQ2hY8stM=;
	b=f1Lvb0J5uhbZtdLfvil/SVVj4eDdJrbRpioRypSc37Y0P4Z5UCYaJzno+zKJH4X7g4A7k9
	wBXATKL9yx/sRekR76BZ+1ynsGExpdeYBRVKSgy/4rYhYxmBG6nA/gpeuIM7eO0eTpK4Sb
	EUqCRizIxGH1mdflD/vZMEK+x+C68T4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-KxubwnDuMu6S77YxrOM1mA-1; Mon, 18 Dec 2023 02:48:59 -0500
X-MC-Unique: KxubwnDuMu6S77YxrOM1mA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso57710066b.1
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 23:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702885738; x=1703490538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYFndZL7jr7Mve4XesyCYT4iZu6F5m+IzNIQ2hY8stM=;
        b=oTc8Wx5ScA+QpDUIKZ5smD/EgK0oJxXOW5HEleoyZGnQocl+ZUMHuNXFosVE0Bd9cl
         XV1moceSUcDJvUQjkgb+ch5Kso9TcMYW9x3M0G1N7pwlo8xHa9TZIYf+9OZaaBalexRW
         EDR1e2SYvl5afkPxKZ3Ee61dhaK+42TWKJSS0UDJhAXKYvCg4DI6pUz1cYI5ThbirZHN
         loQMCt25ZXpIafuD0kQUJCoFzUCC2h509wZcxpQRa/L+Q2/8WkPo+9LO02etqPKX4tcY
         nBvaQChzgBR/BBxjOaO/uv80jWaBtRZmJy5jmbaB8eZ2wR0TumMEAqs1pm30A8sYrZbr
         Gj+w==
X-Gm-Message-State: AOJu0YxenB6KdglTtBMZQVzFGUczwMxJXv+l6MbgRLMvqRt4Cx/qLuRI
	alyQYgMyjFxM70d/n0SxdMRtbJaGugqv5Ynq3kthppa1efGQuAEtXm/4h6qSZMrM0dNLCYpdwzo
	2ckhEZA3PzBdqOCU7
X-Received: by 2002:a17:906:ba86:b0:9f2:3e76:5d39 with SMTP id cu6-20020a170906ba8600b009f23e765d39mr17701138ejd.0.1702885738715;
        Sun, 17 Dec 2023 23:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+FeNVWhoCUkfIR4YvsuHROdsDBe/Ie+FNv6i++rL25MjHGUXvNHzKpeZymPDt3IswR4EVqA==
X-Received: by 2002:a17:906:ba86:b0:9f2:3e76:5d39 with SMTP id cu6-20020a170906ba8600b009f23e765d39mr17701134ejd.0.1702885738413;
        Sun, 17 Dec 2023 23:48:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id rd7-20020a170907a28700b00a1f6c2c391dsm13335131ejc.121.2023.12.17.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 23:48:57 -0800 (PST)
Message-ID: <9d4e1a18e6402f5476ebaaafd4a40a925daf19e6.camel@redhat.com>
Subject: Re: [PATCH net-next 03/24] net: Use __napi_alloc_frag_align()
 instead of open coding it.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Mon, 18 Dec 2023 08:48:56 +0100
In-Reply-To: <20231215171020.687342-4-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	 <20231215171020.687342-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 18:07 +0100, Sebastian Andrzej Siewior wrote:
> The else condition within __netdev_alloc_frag_align() is an open coded
> __napi_alloc_frag_align().
>=20
> Use __napi_alloc_frag_align() instead of open coding it.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/skbuff.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea8..de9397e45718a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -311,11 +311,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz,=
 unsigned int align_mask)
> =20
>  		data =3D page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
>  	} else {
> -		struct napi_alloc_cache *nc;
> -
>  		local_bh_disable();
> -		nc =3D this_cpu_ptr(&napi_alloc_cache);
> -		data =3D page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_ma=
sk);

There is a:

	fragsz =3D SKB_DATA_ALIGN(fragsz);

statement just before the enclosing 'if'. I would consider moving such
assignment inside the 'then' branch - since __napi_alloc_frag_align()
already include that.

/P


