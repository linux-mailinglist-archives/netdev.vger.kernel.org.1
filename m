Return-Path: <netdev+bounces-42585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B867CF6B3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEA4B2100D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE71945A;
	Thu, 19 Oct 2023 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sN/q6Wkf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D18658
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:26:56 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2BBE
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:26:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so9123a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697714814; x=1698319614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9inZHsGm0wnFa3HHiE7hNaDUpMUHcl3bPXkGAdpAyg=;
        b=sN/q6WkfxvbIzHzvTLJMhA/Xm+MQxk4w6CwqG2EJTfbjA2Be7OfVj9EYSinHsbJqjo
         Lg80EmbBa2CkXD/GVF/CuUdrUcmzppvnx1jr7mlx9/grfOY8vGji/YDCzs1ediCyGfXv
         xUiUhLqaxvCvif6EmZmzyG8t/4L+Pp6Wa86xgKgCiJl/JVNZRkNXC8ykSH9Zc43FfqrM
         WUBsuMzXOcf9Khcqsq3VlCvgtSTMBmYDVEfBr8fF5BZ3egv1KVFJPHT9jCd9IxwzeX1V
         8YKsmDtAdX3NiKAlkR0aee6pM3CyF2WUKUBArhdR30V9NEfTGP3BKK9mHPAomJ2o1Ein
         ZClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714814; x=1698319614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9inZHsGm0wnFa3HHiE7hNaDUpMUHcl3bPXkGAdpAyg=;
        b=dRL6wdOnSZ+uHdosxXLDQR8xu50LIrrz+UUiFxHqhOk99HUonYyASDYrUSsd82oxWH
         mVNdMqUx9MmUNoBTgeZujmbTR/tYNJJJmNzyYhBFjc+1/S1nau4HyblfPSO3RBckFiYU
         THulQEbXs7CJKBDQIz6nCbj2acdvxc7aW+UmpwH2zezoYNJncmOmfDknQ2M5JxOtS7rT
         07iChYJ4N6OKaGfxw1nmphRcZfZ5/+D24VCrVPYW59LtX7nRvyl4qT+AIgQthLB6TNnx
         AV3brhKeJafN1X38lLQLRC7U2x7qtD4cowajJZLiiQN5SryEyMXgYisvqzm978bsj0me
         OrbQ==
X-Gm-Message-State: AOJu0YwmwBih5EoH+rxQfkUB/Dis+cVmWrtt3spK2jWUiDErKDo2J2PM
	HxUMQ/ooRIHwAWW/z+jycCI9+10XUkzqoaae56s6iA==
X-Google-Smtp-Source: AGHT+IFIT4Hf0eQOs2wzGRnsbe/f6kIAfDbFzgvAR53qjOJEsK2FNL5wV+yw3Wz8gTQPwiE5hnWeHapnp7MVpNaYZmw=
X-Received: by 2002:a05:6402:2cd:b0:53f:9243:310c with SMTP id
 b13-20020a05640202cd00b0053f9243310cmr79683edx.1.1697714813799; Thu, 19 Oct
 2023 04:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018090014.345158-1-edumazet@google.com> <8c74aa6a3fdc417f6573578e084f2a655ddd655b.camel@redhat.com>
In-Reply-To: <8c74aa6a3fdc417f6573578e084f2a655ddd655b.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Oct 2023 13:26:40 +0200
Message-ID: <CANn89iJLxkKNy5cn1UwFC--SjuV-odTzjdiBgZGPoGpJUpHAXg@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: lock the socket in ip_sock_set_tos()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 1:12=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2023-10-18 at 09:00 +0000, Eric Dumazet wrote:
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 18ce624bfde2a5a451e42148ec7349d1ead2cec3..59bd5e114392a007a71df57=
217e0ec357aae8229 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -738,7 +738,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp=
_sock *msk, int optname,
> >       mptcp_for_each_subflow(msk, subflow) {
> >               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >
> > -             ip_sock_set_tos(ssk, val);
> > +             __ip_sock_set_tos(ssk, val);
>
> [not introduced by this patch] but I think here we need the locked
> version.
>
> As a pre-existent issue, I think it's better handled as a separate
> patch - that can go through the mptcp CI.
>
> No additional action needed here, thanks!

SGTM, thanks a lot for double checking.

