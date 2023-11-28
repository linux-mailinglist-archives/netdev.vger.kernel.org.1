Return-Path: <netdev+bounces-51710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90637FBD31
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1605B1C20CBA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5B5B5C4;
	Tue, 28 Nov 2023 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGA1AxnE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6682D5D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:51:13 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cca00db7f0so55820817b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183073; x=1701787873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtKmT2DzohXXoeUBiHE1NcptmxFv6Dlq3tIhE5fHNKY=;
        b=pGA1AxnEi0vbxlKeQTOZmHBhbdAZg/XT8T/uVzs6SlTOCS/gE09/1JHaHENUP8BHvw
         916kqWzTq4du3rRsYUDSkMsQBjPh9uy/YkqA80Fsq80SFqKtgx997MrvEtxQpPjkogt9
         lx445AtC7C9M2jnZgQhmpS+C9s3lXBsqldeMwOBu3RodutPKgzlCx+OkI8cz1389e63P
         S/11yo5yDQTzAnMDfqxW2Rgn3ScLkTvFa3bhIuQdJug0OGgY5l3WjTNVG6P9E1s8ZwI5
         L3RF42wP0Z9nsIDoU3/Rh53QEhjdPSYHuYloEHQQMHH/hrPNiaARB/DA2sVjxbDEauUu
         YxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183073; x=1701787873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtKmT2DzohXXoeUBiHE1NcptmxFv6Dlq3tIhE5fHNKY=;
        b=rlXct/1u8Fu+sJwnyQKIgKBfZVVdIukCnz4+s//fCMpMnlKKIDnEP3YQIO51LeUZv+
         4XbfyPU9xOvNZpeSSPNyWpZQinVAommlkrbbuSSFZvP32lNXGO03tj4WqMQA03Shz/8o
         vN3+V4lgNKbRkVVbXTe+aRgfN8ZW3XWLPvSKYh1vvMdCFsezUQAzNiAkMo5ECawAgBjS
         EOzkvWSenaWVrVWbiWpDk6WfMXQ44zUdtnQY4cB6C2bMXK9CNatc7Ce4ehSjnAu6+I16
         9dSi1C30x8WpljGZQXH8ZODSqeJ3zQGa56jNFzMqM2os6nzMGUENpsY70f4QwfecYIzG
         fa8g==
X-Gm-Message-State: AOJu0YyUAmDnBv6LPiwF4/tYDVncne51AWQUN6HuJj6oCd86TXRKBfp9
	zS+lbLdqOMir2fmgP4s6Bu1PhANFaB0oBlbTvaH+og==
X-Google-Smtp-Source: AGHT+IFicSzJpbzDad6aZAB4TqQT3PWofoExEOGqMaEEhn64uKOyh66vKgcpu9+rbTZ3JgFvV5lGar3bJdV2yzjDIas=
X-Received: by 2002:a05:690c:2d87:b0:5ce:98c8:df07 with SMTP id
 er7-20020a05690c2d8700b005ce98c8df07mr11919406ywb.26.1701183073137; Tue, 28
 Nov 2023 06:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128132534.258459-1-herve.codina@bootlin.com>
 <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk> <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
 <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
In-Reply-To: <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Nov 2023 15:51:01 +0100
Message-ID: <CACRpkdYmN4318b1wXwUOeFjPN0S2w8M9FpXHOs3LtFa+XoTxVw@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 3:41=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Tue, Nov 28, 2023 at 03:26:56PM +0100, Linus Walleij wrote:
> > On Tue, Nov 28, 2023 at 3:03=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > If this gets applied it'd be good to get a signed tag based off Linus=
'
> > > tree so things that depend on it can be pulled into other trees (eg, =
the
> > > ASoC mapping for the framer).
>
> > Do you mean my pin control tree or the big penguins tree? :D
> > (I'm guessing mine.)
>
> I actually meant mainline there.

Ah based off, not residing in. My bad.

> > I thought this thing would be merged primarily into the networking
> > tree, and I don't know if they do signed tags, I usually create an
> > immutable branch but that should work just as fine I guess.
>
> Right, I'd expect a signed tag on the immutable branch - it's generally
> helpful to avoid confusion about the branch actually being immutable.

Makes sense, best to create that in the netdev tree if possible
I guess.

Yours,
Linus Walleij

