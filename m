Return-Path: <netdev+bounces-43029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE57D1012
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B499B21397
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CDA1A709;
	Fri, 20 Oct 2023 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foUvfQU0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B91A29C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:59:56 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5FD60
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:59:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7af20c488so8489577b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697806794; x=1698411594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFC/B00tUI2hXABfcSdP/RdnPPeUlHvWc23J3vC1mo8=;
        b=foUvfQU0BLptbJBxK7DRcxWBDl4s950H52WKbEUUpoUd22VoX9RtTPpI4OxOYnF4az
         TXtJeBEVMDZk1Yfnwzq8oVRxeJ8GN27HmTjhxGu2buqcu5jKb2kx6pwC8Gj1Msy7JvEu
         YV9INu23Imn4YcTKACkoRMRPVXXA+X3febVFAHUHKVb74Q3aIThxbcZZuX3So7+IFPOa
         O4zmP4WvFCnFS3MA5tnaWQi5ubJGT53/HBmCXv84y7+OEecycOCIGJg0iiWTvbpL8ZBC
         fiVFAz0KmRKmMS/AcRiBToz6JAnNdpszKHGtBsrakLOcohCPEl9z+sNrcMJMOPyxnNWj
         hfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806794; x=1698411594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFC/B00tUI2hXABfcSdP/RdnPPeUlHvWc23J3vC1mo8=;
        b=m3HQEz4oQDUdCPbgDOEbh5/jDAChbjw7VlKZ5L2V59nL9q6vkuzZP/60t9Z+MLVR0T
         xIzxRX8F+wXD7mhOpeYSJDR/g0MNguTnQuYkdc02g+Hq91dzVWDXLFJ7XLX/MlrVY34W
         b2T+mL9CUG1kXULMifRT8rAPI4RlrvQ4PcDFcA3bKFCU7rrDHKtc3HYY/KmsO6JzVeQI
         TrfHl8FRAWf/gefVpiQSqBbN4BOKhz5ZOkYmoG21JjFtSyIHVVqTv5iD6VnVK0qMn/2w
         AaSS8o+UsSGSSgbcHnI5kIFXfYd1CVrdjBpAM5UyxGb6RDvdEZv2hkQUJwavik46lZIr
         gYAQ==
X-Gm-Message-State: AOJu0YyyJTz5fGV6+pHsYIhn56+IS7+MLdX21lpAyvkzF5BgjNdJj/Fq
	ZPGNNPHP5PStoWID61jetPV2XtPPryt1fyUg/LBvZA==
X-Google-Smtp-Source: AGHT+IFaEnMKB0meMkvyhN4BbXF4gAdnlozEeoARMKEWNdhaivAk0ry/mu1R4xUPut/elXgpxZq5kcDKovovpb4EQoQ=
X-Received: by 2002:a0d:e843:0:b0:5a7:dac8:440c with SMTP id
 r64-20020a0de843000000b005a7dac8440cmr1964960ywe.23.1697806794468; Fri, 20
 Oct 2023 05:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf> <20231019144935.3wrnqyipiq3vkxb7@skbuf>
 <20231019172649.784a60d4@dellmb> <20231019162232.5iykxtlcezekc2uz@skbuf>
In-Reply-To: <20231019162232.5iykxtlcezekc2uz@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2023 14:59:43 +0200
Message-ID: <CACRpkdam5UZWbB_tAKoU3_jdZLbH0TFT3yt3Xf9G1b=_42e4zQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 6:22=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
> On Thu, Oct 19, 2023 at 05:26:49PM +0200, Marek Beh=C3=BAn wrote:
> > Yes, unfortunately changing that node name will break booting.
> >
> > Maybe we could add a comment into the DTS to describe this unfortunate
> > state of things? :)
>
> Well, the fact that Linus didn't notice means that there are insufficient
> signals currently, so I guess a more explicit comment would help. Could
> you prepare a patch?

I can just include a blurb in my patch so we don't get colliding
changes.

Yours,
Linus Walleij

