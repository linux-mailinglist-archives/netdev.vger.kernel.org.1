Return-Path: <netdev+bounces-214452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B04B299F7
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965B23A55D9
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0325275B1A;
	Mon, 18 Aug 2025 06:43:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEF275AFB;
	Mon, 18 Aug 2025 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499420; cv=none; b=P3veZT77bmox4rQxpqZDtN97GH9d0hQfFT/GRDjCvS/4qtLkoe287mkiFOU1qbn3VxBTNgHVmuya4kP70FgXh/FPOC0R6u0LEBd37RZRNzdCESPpfZc/vmSySFGzvrvnpTSnv7H6xhJDZXYk6YYgaDcLdQ+vj8MRp65WOA51dGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499420; c=relaxed/simple;
	bh=4y4pH6gN4GxRFalEamSO6SCS1LBe5XYo+LoD6hpfYaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDTcPvH7V5N3nesS9UzYjAC0CRooM7ZXPgOFwMtAULpLlSrdxXfqqpilxm89z4+GFd82AvjYMRab7yqm2v4kDaAyOWaDWhbGHLs52ah3Y34hUBvDBvHiNtqgItonMnM/wrrV47r+uBYZ52zRsetWeP/KKwD5MI4QOFudskX1MPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f8ad279f8so2742714137.2;
        Sun, 17 Aug 2025 23:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499416; x=1756104216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsLPgPjctI1RmC5h18ctG1S8IZm9ltAPjDvM4QJ/h4Q=;
        b=KVqrl+7XjfaOiz9LQ7caKxH5CDsjeZKgi4HJ3rvoRebz29U9ZWqEYVO+lkdc8hIcrx
         FSzUWYX0mB1pWki+brDt9Hjfmlo7yGk357CjRgrfq7qsXoVMV1hiV91pjaQ/p5nJKBMc
         zDZ8vFzoWjeW37f6s1ABDg4igNXgOgUlKvTeB/0MviMWEqknUgtmz3RuXLhdiDZW3ijQ
         Ap2JFIVmr4kz/iNvE8CHbmupfM/Ud1iAC858tzFAw0UggE9jCBFEJGpQe6do7oIaoUOr
         pYc4HwMTMcfJDmw1sqcj/eB6h/gYOmvCcPhv1/OhLyuPwmynKKckAQBu/aoSnRQyQjIf
         W1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUl7xiRBprczB9zAfAUr3+KlBesTmZCjpZOqY3Q7Qr9eWtvmO9nmwqCu6RppzFz0Dc3/K7TJh5VNQwp@vger.kernel.org, AJvYcCW/mS8iiQIip/YC0lRtpBgRBVAb5yDKD9EM3mjM6O8Cii3mLTWsMrJ/dL4hl2hWK3A3Ou/0eyn6@vger.kernel.org, AJvYcCWzRj87OT1BKi5NEt5a4i/iCUaUAdv/WUZtOtmyvDLSyBtU+pSxAH4WoUggvKC2vR6wmR3VXick6BlYNobI@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/0aab9NLKMJ/zhT0FWtAh4IiuOH8AVetKz7pYA+VbtL8Jo1v
	f0Jv42KwCgpxHQJb6gL8jUnnFVg8wV9kmL2GSH4jfcoXWasCmZEks5eMQ7F/uV7u
X-Gm-Gg: ASbGnctJpdqgxm/Y2tjwBuOTJimRvgKOx9VqYn1lKoILErgbE3C74by9z0/PV1kVilG
	KU5Mb4fxQzyWnCWHg93D4ALkpcdFacba1eIztraf2tJyajbqaEFGxaySrWU+6wWQYL2yC/RjcG5
	FnTQ3OdcCWLCTwwgz9+qzZ2zPLNRA6sApGHv1aA1z0SX8cjEe8QE5HbIxm3ggxCGx6JBED5MEiK
	Tg92t3WwQMlu+fOSUNMS4l228o5ioaxS2g1Z1LTlGWUOEpAyK9MdGRpz0fGzcpfRJqDP8DHtoCV
	XnURV3LK9ZlJnhwUqqrC/k1z0pGp7wqs2o+n9f7g3GFjR1JhQEvzzwwok1iCKSHyEAg+N+M6AFk
	sZsAbsrxHe0wB9kTI2QRFZfQmpzhtIdqMBRNwfiuCXVn2Pbv2MxaoXf9UWzRv
X-Google-Smtp-Source: AGHT+IF3pZhOuJGl9BVwfxR24MRdWP5DOFuetTKxXP561t5voHwu5lYeWzH9tzF5lHdc/3ekX1Ur+w==
X-Received: by 2002:a05:6102:6cc:b0:4e9:b793:1977 with SMTP id ada2fe7eead31-51267dc1b45mr4089407137.0.1755499415792;
        Sun, 17 Aug 2025 23:43:35 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5127d4e3036sm1870363137.8.2025.08.17.23.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 23:43:35 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-89018fc2a2fso2430647241.1;
        Sun, 17 Aug 2025 23:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSpKyg+gLwGI0Xe7mtrB6s+5pDu5Daj4E31EJWVr5NFMnTY19NeV0XsEPfwPmDev662sBmGJ53hI8x@vger.kernel.org, AJvYcCW7v7tcQ+uZAzoFf7M8+/06zdKgsZ7BZ7tgtiT6cteGtnZ+6m4K5Le6kAFYDV/D4V6TQIJu9MuQq/ypFBSq@vger.kernel.org, AJvYcCWPCenHjZv9NxJG45AgW9/N+ppO2zgcjBkYwtMA5944enwmlcSJntihifkCCK2oD9L14+Orcu1S@vger.kernel.org
X-Received: by 2002:a05:6102:5129:b0:4fc:2b88:d26d with SMTP id
 ada2fe7eead31-5126cc420aemr4108789137.16.1755499415163; Sun, 17 Aug 2025
 23:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu> <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
In-Reply-To: <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Aug 2025 08:43:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
X-Gm-Features: Ac12FXyQUUDD_v0XZWp4qvaGvKu_U_VjElg-BZC_JMJQPGN3TDaGQppTU27YJys
Message-ID: <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Artur,

On Sat, 16 Aug 2025 at 14:06, Artur Rojek <contact@artur-rojek.eu> wrote:
> On 2025-08-16 10:19, Krzysztof Kozlowski wrote:
> > On 15/08/2025 21:48, Artur Rojek wrote:
> >> Add a documentation file to describe the Device Tree bindings for the
> >> Ethernet Media Access Controller found in the J-Core family of SoCs.
> >>
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/jcore,emac.yaml

> >> +properties:
> >> +  compatible:
> >> +    const: jcore,emac
> >
> > You need SoC-based compatibles. And then also rename the file to match
> > it.
>
> Given how the top-most compatible of the bindings [1] of the board I am
> using has "jcore,j2-soc", this driver should probably go with
> "jcore,j2-emac".
>
> But as this is an FPGA design, I don't know how widespread the use is
> across other jcore derived SoCs (if any?).
> I will wait for Jeff (who's design this is) to clarify on that.
>
> PS. Too bad we already have other IP cores following the old pattern:
>
> > $ grep -r "compatible = \"jcore," bindings/ | grep -v "emac"
> > bindings/timer/jcore,pit.yaml:        compatible = "jcore,pit";
> > bindings/spi/jcore,spi.txt:   compatible = "jcore,spi2";
> > bindings/interrupt-controller/jcore,aic.yaml:        compatible =
> > "jcore,aic2";

I would go with "jcore,emac", as it is already in use.
If an incompatible version comes up, it should use a different
(versioned?) compatible value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

