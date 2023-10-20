Return-Path: <netdev+bounces-42980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64917D0EF6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03B7B21387
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98E619455;
	Fri, 20 Oct 2023 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUeISjOp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0F19440
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:42:14 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EED49E4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:41:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a877e0f0d8so15341137b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697802095; x=1698406895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9bFjh5A1TAJojJW7zz66RNNSkHFaHMwwCUObsG9YEY=;
        b=JUeISjOp5CJHSK1LLZ3b/u3mYHgZxPngvU03BRjZmiFfCPp6/xz+gLqFakwrBql5Za
         020cR5pMnki2DOfExiPXmpv3lv8HSVYiwi2E9eLlzkec4HsNE8fU1xl+ZWpu5sKG0BLq
         bbzD4fhC20QOC77PiZGXqaTKnBomR6PyQFHcWZ8sAx9J7AZTg0tEKve1VJJmWyErG/7r
         6tTNiiI0MNDwLXVdt787JgD6SN4P7kFbKCY54330XpOhxvfC9iGWeaK1A32QiMEYXdlf
         oISaiyG7M4YFqa46ykaCjXmgWCjGTgspaWcd7uQAcik+NiUqbWwFnwqI9XwpDgtPSfZ7
         uOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802095; x=1698406895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9bFjh5A1TAJojJW7zz66RNNSkHFaHMwwCUObsG9YEY=;
        b=Ap1v8k8TsDane55QhxdN5YWPu4ZMx1XDV2JC3ssI+uhKxku8hFI6UWuRSIPYS/X/5V
         tC2DarU45BcKRSnmEoeoLSCNEM4YvGyt53sObu7WdjhK+ycKlgMNKwx8cV4CgtBrBOzo
         g0W5fcYro+S7rkWO/y/kBMWEiVF95f1O6kNrv4tFFS9/wn+AUK2i7/DgwwLkNFqrW4td
         u4MKKz8KgdnuiiC2jtgA6YdmDJRjyZy1/CAP9cDFOZWiQpBBTOokJkNJMEK07VcTmNyf
         C1mbjTTlRSSz1rAfobaYDsxSA4v5jaiI5MMTPO0hFYupaPEQIeRg7Ke12yS6ehiNbdpo
         VkFw==
X-Gm-Message-State: AOJu0Yxn43nBy2wDmP1GB3IZ4xuvw2BRITrY+wFCO1gnnaejdaM7L1bh
	aaFnih1xbf1ssZ4B0CGYTd7OlotNlZYPGVk94MQDRA==
X-Google-Smtp-Source: AGHT+IHyOEVIA5SJ7Y199R5jt+d5f7KKXk70NiIvNCL1uO+i83Ow7XGvhR98WYwCuuNubMD7tt45A0AuyLyah3Upinw=
X-Received: by 2002:a05:690c:dcb:b0:5a7:cb5f:ee0a with SMTP id
 db11-20020a05690c0dcb00b005a7cb5fee0amr1391397ywb.17.1697802094778; Fri, 20
 Oct 2023 04:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org> <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org>
In-Reply-To: <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2023 13:41:22 +0200
Message-ID: <CACRpkdbKxmMk+-OcB6zgH7Nf_jL-AV7H_S4eEcjjjywK0xCJ4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 18/10/2023 13:11, Linus Walleij wrote:
> > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> >> On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:


> >> yamllint warnings/errors:
> >> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] w=
rong indentation: expected 8 but found 6 (indentation)
> >> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] w=
rong indentation: expected 8 but found 6 (indentation)
> >
> > Really?
> >
> > +  oneOf:
> > +    - required:
> > +      - ports
>
> .........^ here
>
> > +    - required:
> > +      - ethernet-ports
> >
> > Two spaces after the oneOf, 2 spaces after a required as usual.
> > I don't get it.
>
> Although YAML accepts your indentation, yamllint does not and we always,
> always, expected yamllint flavor of syntax.

That's chill, however I can't reproduce this, make dt_bindings_check in the
mainline kernel does not yield this warning (after pip install
--upgrade --user dtschema
and yamllint is installed and all), so right now my only way of testing thi=
s
patch is to mail it to the mailing list and have it tested by Rob's bot.

I just don't understand what I'm supposed to do... drop the dash-space "- "=
 in
front of "- ports"? Then the bot will be happy?

(This patch was added in response to Rob's comments
"this should probably be in dsa.yaml".)

We can also just drop the patch if this whole thing upsets the tooling, it'=
s
just intended as a generalization of this requirement as can be seen in
Documentation/devicetree/bindings/net/dsa/qca8k.yaml
which in turn can do that because it is not using the generic def.

Yours,
Linus Walleij

