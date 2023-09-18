Return-Path: <netdev+bounces-34620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCF7A4E0D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353B0280D1E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC537210FA;
	Mon, 18 Sep 2023 16:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD820B27
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:05:15 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBA4226
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:02:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so36324425ad.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052789; x=1695657589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SImvadFeNoGvg+t6+HEbq7a1fwmLC+aPm0CdaZ6NYAc=;
        b=GhrYcYETK4xnnCm5DR/KmTW9kL1qnC9o0evkHN0xun/LTXJ+NktnwP22Zw3dWugMJv
         ogTD4SWWxFN/EhmBLnKC4VOZszDan4G2uzapznP1ZIYmb57zGRvpvzDMwicoU/Bgjppt
         c8B0JoVNhjVIc3wxiAIHeEPkqeR1DcuLvXkTK1R2cYL+QOAtjo0SH9Q6kEpGRp+VkYju
         MkL5zK/fwVciL1zMw7xvRqb72oViC6hy6XGC0lhE5nobMwb9AKoEliUvhG7YgrSfDD+0
         hQb7o4Lo2dAFu2ktSIa1n2L1j5BKQrkD7pVNd0olfmBDTKZT/4Gqzn4qqjFs4wVqS6eM
         4/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052789; x=1695657589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SImvadFeNoGvg+t6+HEbq7a1fwmLC+aPm0CdaZ6NYAc=;
        b=Cb3WA3uByqUzn5JtQajS9rwQBInAiRd6nI7bOApLkjdT1nXm6H8IbiADG52yHWp975
         jKDBHpkYwgtE6N7niHPNw00v4JIv5r4LtavXZAYE3qOicFmaRxuMtDhjzqYfJ+8pkTmG
         jVALV2ZEIVNOgZ+rEmZ2h2nUUkXQ859epIk9VAcwrq3xPzELNmdJwwiBODRfdi3oS/ZV
         DbzxhWGqpRIc+F7KdUwCtbmqPAK9VmcHRKTjZ3DgPwRFtmmB/M6xdajzL1mttKMSev6E
         5MwkyJkfgPxLcGcB+OnN7E/jJEfUftPQ/ydskYCwcH+CO//rYPRLgUK+u1QRxHDFNEiJ
         Oypg==
X-Gm-Message-State: AOJu0YwtbhXk/qJhhRDn41HcdI3GntNzXCUF+dZqQ1teqNeX/UHbDamc
	aXYorej3dvb39E8ZfObRkhH93sbS03DZEhxbMLehqe5e
X-Google-Smtp-Source: AGHT+IF5DijMs04u12QI03Zv4KTyNMUjd4m34aFdriRnRyxXKSdFlL9pYktQn6QqxdfDspSD+3kuk84f4t+c6sUeV+c=
X-Received: by 2002:a1f:4f06:0:b0:48d:2e3d:2d57 with SMTP id
 d6-20020a1f4f06000000b0048d2e3d2d57mr6198507vkb.4.1695042439904; Mon, 18 Sep
 2023 06:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com>
In-Reply-To: <20230918025021.4078252-1-jrife@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Sep 2023 09:06:42 -0400
Message-ID: <CAF=yD-KSuh0CrRn_zXdznLdg4G==qxgGeQuXetVHP2iOdQzpRA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Jordan Rife <jrife@google.com> wro=
te:
>
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces all direct calls to sock->ops->connect() with kernel_connect()
> to make these call safe.
>
> This patch also introduces a sanity check to kernel_connect() to ensure
> that the addr_length does not exceed the size of sockaddr_storage before
> performing the address copy.
>
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@googl=
e.com/
>
> Signed-off-by: Jordan Rife <jrife@google.com>

This looks great to me. Thanks for revising and splitting up.

Please include a Fixes tag in all patches targeting next.

For subsequent iteration, no need for a manual follow-up email to CC
the subsystem reviews. Just add --cc to git send-email?

