Return-Path: <netdev+bounces-45260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0F7DBBEB
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5942813DC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83C10964;
	Mon, 30 Oct 2023 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8wSQfDo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431A384
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:37:37 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FCC2
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:37:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a877e0f0d8so47529107b3.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698676655; x=1699281455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkvEup63X/NvswoWIpVSdrCM6wW/OjO9ZV/xamvkCgE=;
        b=g8wSQfDoEn/fesrGMgwclQNbdryinuQrbbwX/AbZbNj9UTwmk93D51Uq+X0ooNsPab
         jYx6tvZ4w40xClYZOCR6UG//pI6TBoitNmWPCO9mknHqp4Khf2KPgfUGAdHyEwSlPkvZ
         rdEbOMeX8jV6X5Bx94sWkjepXd+7QClXxw2DtTwfh2fIlvcwxOZw6Q4Wrc5sbz36CicH
         mbnVwFx2PYbW6Lp9hjuVfO6TjCLmK6Z8md5pAMOvX0LAwTXYEgVH7CQLezBwe0qvx/R5
         uG261wH65dHdNWd2oNY/REefUVpiBdaOnJyiI6ZgghyhHlUm35IWdUiAx9yZZycwj2L9
         gZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676655; x=1699281455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkvEup63X/NvswoWIpVSdrCM6wW/OjO9ZV/xamvkCgE=;
        b=TEuyXx6s++8IptQs3ovfHr+QLePg8VEyJ1ihBb0NEXsvQZJvVwaARN+AY/wBFBOhXK
         kTvkFon2aKU/KegIDdSqGE2C2Zve1pXR+2Zlc7vH//HWz5vr8HDyHeuH4LNBlaRXcxvv
         d/BcLvVsD6bBq9DRfZ3rDSSEInLgw4By2o8K5XnB6Hc2bcO/VCm4Qp2JoVOiZeqb1qCY
         pEP1ERCTz1Jnez62mEfCNbZOIpfQ2koW37pbqsL3CgRXI2COtFhhMPUltPNVeQV/Ji7y
         cO6c/fJiFINN6cCwCGsdvRi7OUDngHLGrL2tGsM9nsQVYiiDsP6pviLAEglEMvvbLblj
         ch3Q==
X-Gm-Message-State: AOJu0YzoQcNhJYKXgf3IzElAZu6WLlw3L3Qgg4rzaaB0Ew8u16XzxsXo
	xakXOyxG01QaEW3GWTJ7GRYpUDuUOxm0lZfv9DsEow==
X-Google-Smtp-Source: AGHT+IHuomUh+zOvo8VjkEA9snndKjGy3W9I5R/IyKh/37t55RKlwqVFLy5AWRwPxIud0EOVCaVooiwjhV4GJik9vGs=
X-Received: by 2002:a81:b108:0:b0:5a7:fbac:4ffe with SMTP id
 p8-20020a81b108000000b005a7fbac4ffemr15205506ywh.22.1698676655663; Mon, 30
 Oct 2023 07:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org> <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
In-Reply-To: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 15:37:24 +0100
Message-ID: <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 3:16=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Could you please try to revert the effect of commit 339133f6c318 ("net:
> dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
> the egress tag again? Who knows, maybe it is the bit which tells the
> switch to bypass the forwarding process.

I have already tried that, it was one of the first things I tried,
just looking over the git log and looking for usual suspects.

Sadly it has no effect whatsoever, the problem persists :(

> Or maybe there is a bit in a
> different position which does this. You could try to fill in all bits in
> unknown positions, check that there are no regressions with packet sizes
> < 1496, and then see if that made any changes to packet sizes >=3D 1496.
> If it did, try to see which bit made the difference.

Hehe now we're talking :D

I did something similar before, I think just switching a different bit
every 10 packets or so and running a persistent ping until it succeeds
or not.

I'll see what I can come up with.

Yours,
Linus Walleij

