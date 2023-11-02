Return-Path: <netdev+bounces-45740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307757DF543
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE06B281B5C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EB6FB4;
	Thu,  2 Nov 2023 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXrzZ4u6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18918659
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:45:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EB138
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698936347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5oiwErrMzgetWVt/rVCESPBJ6u4MEYTMmIt1nWc3a0=;
	b=GXrzZ4u6S6eHQTU8Yc4q596qmVrR+uIKnXYvfB6QzhKnlio3yx+Bh7miTxuDvC8xhWZBuy
	3vxn+SU3bi3BaIZAQg3rLhA0Yl/WrtPaVYeXELujKdT3WZjQXbyPKAMvfOEPvOGFlX5Ram
	UJSsYhuCZz7wYHw6U1R7boMz8mbkrCc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ed6PGihqP8OlTVxQeshaxA-1; Thu, 02 Nov 2023 10:45:46 -0400
X-MC-Unique: ed6PGihqP8OlTVxQeshaxA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c39f53775fso19817866b.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936345; x=1699541145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5oiwErrMzgetWVt/rVCESPBJ6u4MEYTMmIt1nWc3a0=;
        b=oI4fqbTFK5Gn1wlfCLp0GS8zdFr0vjfkxdk7sgZIfbe9biVDpgkYFA8/3aZ5napZK0
         FOF1xIiRg2kWzCVwyAnG4x9LC0au4ATujlRvmM/luTywR3SRCSN+Sr0ykARS7O3DSRbt
         BiNLbx8ebQycs+J0GlH1xjKOayyhGOncX0+NLGm8zGfZmwABx65yXd9dEQIM6ukTUyvv
         hqaktlpb8PdrkL0d7aqjHDMhMPMo7N1oy2LZt9pUvs+Lo7WW6C/uTG2UbXstUgokOOgU
         caYYE0UST898vd1lYUZVjrKScqzKLi1pT2ivlEgdKoZdQtvFhdkTOIsLl4faW0Gm64fq
         ij5Q==
X-Gm-Message-State: AOJu0YyR1n+lqUU/mdcNXzP6Xf5BBKjhzU7lEy/3Amnci+qsPiyPO5e3
	hjX1L/JZUTz8U3qPi9NrM4Ly0J6JJ8gEhmgEV5MCiT/sCRPd4j4GLJW+eWxdUnXxQP4mq/8zEu/
	NN9D9E3nNiE+SElrX
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr17145272ejc.0.1698936345207;
        Thu, 02 Nov 2023 07:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhEHePodwFdxOe+Fe4dph8J/NAgNrgmpPiItHiR/hGjSb1hxyAiYLop6wHDZstWYZrUw14ng==
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr17145253ejc.0.1698936344892;
        Thu, 02 Nov 2023 07:45:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-4.dyn.eolo.it. [146.241.230.4])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906831500b00977cad140a8sm1219837ejx.218.2023.11.02.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:45:44 -0700 (PDT)
Message-ID: <ae2e83fffb89973ba77220d01b4cac192d79ef6c.camel@redhat.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat
 under debug config
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org,
 idosch@idosch.org,  netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 02 Nov 2023 15:45:43 +0100
In-Reply-To: <CAM0EoMnb8nGJ8U6czNix-qnf9pawZMzmdGKwyfAhbA3nsoWsRA@mail.gmail.com>
References: <20231027135142.11555-1-daniel@iogearbox.net>
	 <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
	 <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
	 <5ca2062477738b804ce805847f7aec024ad5988c.camel@redhat.com>
	 <CAM0EoMnb8nGJ8U6czNix-qnf9pawZMzmdGKwyfAhbA3nsoWsRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 08:47 -0400, Jamal Hadi Salim wrote:
> On Thu, Nov 2, 2023 at 6:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > FTR, I agree the comment or even better a build_bug_on() somewhere
> > should be better.
>=20
> Paolo - Did you see the patch i posted? Ido/Daniel?

Nope, not in my inbox, lore nor PW. I guess a repost will be needed?!?

Thanks

Paolo


