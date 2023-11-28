Return-Path: <netdev+bounces-51706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632D7FBCAF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B269282EBB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744325ABBB;
	Tue, 28 Nov 2023 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqueN1YI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEACF1B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:27:07 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cce5075bd6so43047477b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701181627; x=1701786427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX51WsgBh7fAZJnYdm3LGG3k8tSGHp+BwBoxwyn46fI=;
        b=bqueN1YIDON7farcbH3pY/uOo8nElYT8922irYe/P/SMSr8jEPhsrcpeZcYE2AIf+p
         W1NfvHjYc47AVe2UkDCBK1ljfTFT1bl9K0Xw6wP3gfpGv349bCKopXl2zaPMMK3cXGmZ
         IWQedcqyskXO8UfFjp6FUh3ILuzredIYqDznlG8IXZWD5e4xMe5xji4wW+4wAjpRE5Q2
         rl6uPqiXCSo8paqaDAtjt5xXFG+pZl+Ok9c1/mifDcDQHv7tGErPGxGZtp2x8gvji8dr
         6Bbovn1kcesMqdfyHwKrLC6ngobcHL/G6dYG26emGJY9hxPB8GYNlx/kHW4sddssGpRz
         Kr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181627; x=1701786427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX51WsgBh7fAZJnYdm3LGG3k8tSGHp+BwBoxwyn46fI=;
        b=PsgKjpaGezD+UJsqLwxtJCxaz5cPu3PJLEFK1yON0HVA+eGX72E0vi+3JybYG/RgB7
         7+RA4zxr+Txxn2qFLDXXO6uSsuG8BPQSa8fBbOFCiM2ZIjr0PrQYcbMsO4b8PTffLzhR
         ht0kLyP6sIj3BtdJUrY3JKnel6mk8SYVejT0ZbFPt2Os0tAXVujwAUze5sazgpG+eEYz
         sVWMuXN3513bpPBp0pp+0Z7R462dL09pxdBk3vsVpZWetklR2evLahcgH+0iGDnB7+Bh
         uLu1vgheSbgUsWKDJfOj3jF1UEnfSFProAg6YAiyMgzc6wlVC9NGm/zdYEACT6UcofUA
         lB8Q==
X-Gm-Message-State: AOJu0YyHn1WwAfarLMhfg3FzdOwrcQdkQTEu3qrwQf+xAcWnaJFU9os6
	lpcMkryfZ30rWHWSSLvo8nxkPFAVX4gNTpnAxD+xnw==
X-Google-Smtp-Source: AGHT+IHxRwisBihnXdRMmCLGshGiUARUDlL2k1HSR24biOIrpIFvzinty4ukiQWuah55vT3Ag1bodB2brjgsCrPY6wY=
X-Received: by 2002:a05:690c:2b0b:b0:5ce:2148:d4bd with SMTP id
 em11-20020a05690c2b0b00b005ce2148d4bdmr10093638ywb.4.1701181627190; Tue, 28
 Nov 2023 06:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128132534.258459-1-herve.codina@bootlin.com> <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
In-Reply-To: <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Nov 2023 15:26:56 +0100
Message-ID: <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256 framer
To: Mark Brown <broonie@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 3:03=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Tue, Nov 28, 2023 at 02:25:29PM +0100, Herve Codina wrote:
> > Hi,
> >
> > This series introduces the framer infrastructure and adds the PEF2256
> > framer provider.
> >
> > Patches were previously sent as part of a full feature series and were
> > previously reviewed in that context:
> > "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1=
]
> >
> > In order to ease the merge, the full feature series has been split and
> > this series contains patches related to the framer part (infrastructure
> > and provider).
> >  - Introduce framer infrastructure (patch 1)
> >  - Add PEF2256 framer provider (patches 2, 3, 4, 5)
>
> If this gets applied it'd be good to get a signed tag based off Linus'
> tree so things that depend on it can be pulled into other trees (eg, the
> ASoC mapping for the framer).

Do you mean my pin control tree or the big penguins tree? :D
(I'm guessing mine.)

I thought this thing would be merged primarily into the networking
tree, and I don't know if they do signed tags, I usually create an
immutable branch but that should work just as fine I guess.

If people wants this from the pinctrl tree (and patches are ACKed by
everyone involved etc) I can certainly do that if the netdev
people are happy to pull an immutable branch from me.

Yours,
Linus Walleij

