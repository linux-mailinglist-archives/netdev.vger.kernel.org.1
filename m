Return-Path: <netdev+bounces-42008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530597CC9DC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC412813B7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734624734B;
	Tue, 17 Oct 2023 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPRPU5A3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13D43ABA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 17:26:12 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FCD3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:26:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so5180277a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697563570; x=1698168370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3sJOjdz4HmVX5Ee8oZMm7CVfPOQuCMEb6MVEUzA9CM=;
        b=iPRPU5A3XNNncjTScWnfjjRgn/g5N397H/BtEh9Wb1MvhKyPX1GjZ3RYu0T1JgLqrn
         fySYCLqE7D/js+nHNetHa8Nrndz17qAqJJd0/Is3TmNxbS9Fa8KgUSIN6IyTZPebz4I5
         rG5NJi0JbzG4kdUUnhboccde97OOIuKU75f+TzNS7Y0tDB2vBo6dYMQZWjNpaoPTxtuZ
         OQrrwdsSC68YNiiW+GDSkYusQl1pK76iZb91afaHFjPYvu6po5BanAj9dZXEbVHPvFTr
         vqe73Oi3fusGLBN5HEQAEm1hFxOGkcKVhLEBai1Q3QlxYjmcaHTVTXxjBouNwKmY8KSE
         ONPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563570; x=1698168370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3sJOjdz4HmVX5Ee8oZMm7CVfPOQuCMEb6MVEUzA9CM=;
        b=FsSk1eFaPRp9z2ETVHskeigNBNtq08iByNObU7YwCEyWNQ4u+0UvigO03ohm0yrddr
         I6gHlP6D6zqZY9faqofSLeSuUHiFgTOkMAAyGOUz3szd/fsijon1BjxjxNeWVvn/eAn3
         hBT1rTT9mKqsTqSZs+O9IaX0JAnRgs/EwfEqkl4yoYuYMzf4YpKZKuYAcab+WkWzshqI
         QeOn7nJQzsCVk45fNvoLWWeFdUFx4nCYLcmes9ZllqV2fZ+a8P5Lh9B0xc0b+7P75oK4
         V07uG4H0azySdC/1i5UumV0dQFRD3XMzkeO/mWIfnft+Kiqyu6bxbT63SIKcMs7NEEc0
         +q5A==
X-Gm-Message-State: AOJu0YwBHicZXmE6JTkgsFzTgJEOmAiulyvrqabGTtrP/CS9euZ9QkOZ
	i9Wfx9YIri/r2sxI2b5qhI4TUDt6chVuPpzYorIzvQ==
X-Google-Smtp-Source: AGHT+IHoa+w5G+1WhCe9EF6u7DQRQO9M4r38jyklDSYv3wWlfUUxuyT2jQDUZ5LPEAlUKpxXSAxQoovOtPawZoU+rjY=
X-Received: by 2002:a50:cd03:0:b0:53e:c2fa:54a with SMTP id
 z3-20020a50cd03000000b0053ec2fa054amr2314809edi.22.1697563569925; Tue, 17 Oct
 2023 10:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
 <20231016161353.48af3ed7@kernel.org>
In-Reply-To: <20231016161353.48af3ed7@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 17 Oct 2023 10:25:58 -0700
Message-ID: <CAFhGd8rjwEn8g0HXLtejyjv=L_0Gj2bCiE4fEcNnqhOqpdC+Xg@mail.gmail.com>
Subject: Re: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Oct 2023 20:53:30 +0000 Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
>
> This driver no longer exists. Praise be.

Thanks for the heads up.

Ignore this patch :)

> --
> pw-bot: reject

