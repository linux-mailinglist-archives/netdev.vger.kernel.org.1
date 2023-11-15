Return-Path: <netdev+bounces-47932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33327EBFB8
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8521A1F26B39
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB779465;
	Wed, 15 Nov 2023 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhxVZcgD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78787E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:51:08 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC111F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:51:07 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afa5dbc378so68709867b3.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700041867; x=1700646667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tmf2nRZN1s/CHTKzt/jZkzy4o27CfCTxzAeztvQEdk=;
        b=qhxVZcgDq+7LFnZR1nXnJ+Z5ax38INsPmfiZHmIF2q0lSuGlhrzD7y8nCAO4Bo7uET
         TAfTX2rotlFZ8Yim6UsUlotPAfXVeQUq0W91NIXEkYU05kori/ZeDtGo8eZ5eUMfAZHK
         c1StQZ+GmW7SmeKTll9tRlLr+KNro23kgAyI0t0Og2piZjjIWQEouQZNwxEJUGw7mVbt
         hdMznRYWPqw3JtRaEC3yQQKIoKq1e6jqMHGECMW7oAPgWDh/z9pBYoH0n7ZkaqpfrduO
         r1/t11txAV8Yd2HVsnaXHNus2FWMLjeT7gKko5PWY5kx/LThWGdKpl7SSFrAtP1ifTl+
         EkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700041867; x=1700646667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tmf2nRZN1s/CHTKzt/jZkzy4o27CfCTxzAeztvQEdk=;
        b=Yisa9VMHT49rP9kHKE1MTgaIK9yZVqDyp74hZzcEIu3PrAT7GhgyOMME9ymoHOXXcE
         Oi8t0dIkYrA1CLgwEr6Wg9Pn9w8zZbY7SaI03NkBF+3HEDmT6Lp8ILlRFZ03nr+eI1H2
         kC5oz6xQ8Lu0oKuldEQbYeoQiRGsRK6yLxfYZRh03/RB4XJSh58jBIAT+gzPeSJCR7nS
         a4jgyu3oSzzXpHsIoP4DLBlhdv/Sj8W8qeQzZ8pV0sT8KCoQKWbT8ntmAgLyDXR8jM0X
         JlyBof2dqQfGcBFAS9NLEectiL2vrCGjNQuF3E1siEAyVEFbyYN4g5L9sc86DNNFPXvE
         oAcw==
X-Gm-Message-State: AOJu0YyLt9CO0e8Pt9PeRjF0/YjcmGhyIwFsXt8MGqgeHkFNgqjqQhWw
	5FGeBvOXRc0k7n1ykx5eBA3uEEHl+bmHf6XY3ogQEQ==
X-Google-Smtp-Source: AGHT+IFSgX0z5IlGDoT/0m+VbJ7P43EUtewnNSaZqeSORdKG017CT78/HSbY7YbPEenWZdoSQofQPbPdtldquHeip9M=
X-Received: by 2002:a25:655:0:b0:da0:95c0:d157 with SMTP id
 82-20020a250655000000b00da095c0d157mr8553037ybg.51.1700041866709; Wed, 15 Nov
 2023 01:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org> <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
In-Reply-To: <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 Nov 2023 10:50:54 +0100
Message-ID: <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
To: Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:

> So i have one open question. How do we merge this?
>
> Can we just take it all through the DT tree?

If we don't expect the affected DTS files to have orthogonal
modifications we certainly could, if the respective subarch
mainatiners are OK with it and can ACK that approach.

For Marvell that's you I guess :)

For NXP VF that's Shawn Guo, Shawn are you OK with
these changes going through the net tree?

Yours,
Linus Walleij

