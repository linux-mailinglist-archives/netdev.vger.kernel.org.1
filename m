Return-Path: <netdev+bounces-52279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173F7FE1FE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12AC281F7A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654C2B9C9;
	Wed, 29 Nov 2023 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey0wuWbt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062ED67
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:33:13 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da077db5145so189452276.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701293592; x=1701898392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK2DmvA9NMVkTXP2kh85VxvDVeGmy7YS6BB1IBzmvwM=;
        b=Ey0wuWbtfnecr0DMc6iE68MSP6ISmBMfzWOMgDHNvy4+qLbuqDkijuBtDwHHpIbcHz
         GwSDvxfdCJd+LQ81l4CqtjaVytc4fnsfmuL21M/O3wFW3lDgOtjHxroLZyzgTFfNkAJj
         XT9A05aLJWSZqlzsZ/cSBCAZ0hKP9MfBG/BwYASGRl0ma32Jtq5iFK985lpsHMP6ZpNJ
         TqGoQjdd2ov4Zjad0FkfbqtlA9jz1gaGja06InIudHDyMHyi4nOa8GoIbmReuQ0rVgOK
         kKL1mFq9WO96Bo3vgfLiZXB6RFwCg7uwEwLlBNvJTtRB4Zsnj0Seq4Fh9PPfmylRwTqX
         YqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293592; x=1701898392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK2DmvA9NMVkTXP2kh85VxvDVeGmy7YS6BB1IBzmvwM=;
        b=ihGq+qSkG5BNchK3edw8eFBjkXEyIORKSo6hCZtfTCb+Akd+aJsuMFUNiHdJfIeT5G
         nXpMgMdq6Re3i/eVH2lQ3XJ2+fvo3HWHJTbB4W+0aZ+/Kju96HRujt6NP9tbT12wHcIs
         ECs+ubqN4+IUSwP6nOjMGLV5FNzu2/UoNxYft8HogBUpRc9Bs39Rn2QwfnBR8776hBuN
         0oXr3hzDpxCBSYNUYMmbxY6YVwUArXMwWmHUcp12cynL+eufwjefEnQa0RR2lTnKIan+
         KwqulFeaMn5WoMlSg9O0VVq1nOYlhcGy4VfDK+JsifV2Y7QEHw9/YbMmepgRk2EJCsd3
         QpPQ==
X-Gm-Message-State: AOJu0Yw7Lnhso5ySThiFDgFwY0zg/yYfYuvvMnkRu0bcAKfR+Ps0Avhq
	T7+amPhECnw3MIquFR12HbfT1VGveNnZSXGO0AuAeQ==
X-Google-Smtp-Source: AGHT+IHzZgXIjLn7ou1rCTJlZgnnvre2KumvBXnqdcF+AjoOkHS0lLVqyN/49Y80EhMpvKrojWib+edhg0wtHE1OaYI=
X-Received: by 2002:a25:4b42:0:b0:da0:3bfc:b915 with SMTP id
 y63-20020a254b42000000b00da03bfcb915mr19790887yba.11.1701293592433; Wed, 29
 Nov 2023 13:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com> <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
In-Reply-To: <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 22:33:00 +0100
Message-ID: <CACRpkdZp=4sP_1a=u6c7DGbPWA8WRee4J8Wpsw7Y57S2FT5GFw@mail.gmail.com>
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random changes
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openwrt-devel@lists.openwrt.org, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 10:20=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gm=
ail.com> wrote:

> Here comes more interesting experiment though. Putting there:
>
> if (!(foo++ % 10000)) {
>         pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
> }
>
> doesn't seem to help.
>
>
> Putting following however seems to make kernel/device stable:
>
> if (!(foo++ % 100)) {
>         pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
> }

That's just too weird.

> I think I'm just going to assume those chipsets are simply hw broken.

If disabling CPU idle on these altogether stabilize them, then maybe that
is what we need to do?

Yours,
Linus Walleij

