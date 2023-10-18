Return-Path: <netdev+bounces-42196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443227CDA0C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517E41C20D2E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029D1A703;
	Wed, 18 Oct 2023 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdUqHgTh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E418C10
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:12:00 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08D112
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:11:58 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7db1f864bso79667167b3.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697627518; x=1698232318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO/PDoCfvCIQp8CUhsVVtzA3USwqbfuZSWYXmX0vX4k=;
        b=NdUqHgThFaSS6CRiu320pMsNt8v76A9IMR56kWxn6XxfWZKQlYBE/3cmIhmnFqZa/M
         76MExfEnETGwcB0CZMzHlF5OPx3aQBSFLiJP+hOd0CIZF33/zVS5lKNLUOxTFUA5EBnL
         /ZJTdUdPa48bUvCxCtNHV7/hGAzJqnFqHR6vu1kRYG1BENL1opSDfpxZo5uhOkMECEE8
         8s2bv87hCe7OQLzJ/OkGRvFh21oxtEpy72ipOzoysiIT4gU5JbkKqtiXJ/G1mv50K5IG
         3HTeD5c8JTRgA7DJWMQZYM6UKMfWKLPxA7VhRqhz6ZL6ktiJA6REv+W3b7J55MyBuYLD
         rS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627518; x=1698232318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO/PDoCfvCIQp8CUhsVVtzA3USwqbfuZSWYXmX0vX4k=;
        b=XW0tMAqKiWVraTScWtuJThx7ezYXKk+Yns1q5z1wbFqUYUL+ijfelK136yClpRop85
         LixTWyo7T4H6URccxYsOmDZqhhspzBTB+QSAgcupgf9XyG9H4Iac64NudJL1wIaLdVnO
         qrfjX6FHU0Rhh/FdkLYXdviGc/+uOIh3m0p2i/zsSIEcM77rECDmdxbx7KE3elvUHqIZ
         STrB7OMq+bX3b6RihcyV0arkmP2gL9J4wPn1/tOokp2sBg1jhCoSAA7B5Z5EAysP5FSj
         pyutTi+OulP8j1yZMLEwOQdK1jOimAHTNZbE6gWyxAo56Rg9asycVsmo1tHmepwwDHbq
         YsKw==
X-Gm-Message-State: AOJu0Ywszn3ctIfEhJGRKawq3b2tniMPWalpbqZCd1AFdeMFJtdIIEqy
	Tfh/ymKvKR97290Va9Ax2BAyRX702Ly0gBiEqdyJFQ==
X-Google-Smtp-Source: AGHT+IGTZPUv5/Bw0Oc83FUy4A9roYHlmtR56tiA4w8g5dxVWLG7VhIBIjSwO1UMnGprrSPG2GfXojIrtvGv8qyCwVA=
X-Received: by 2002:a81:a214:0:b0:5a8:19b0:513f with SMTP id
 w20-20020a81a214000000b005a819b0513fmr5479705ywg.14.1697627517806; Wed, 18
 Oct 2023 04:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org> <169762516670.391804.7528295251386913602.robh@kernel.org>
In-Reply-To: <169762516670.391804.7528295251386913602.robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Oct 2023 13:11:45 +0200
Message-ID: <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To: Rob Herring <robh@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:

> > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > a DSA switch node need to have a ports or ethernet-ports
> > subnode, and that is actually required, so add requirements
> > using oneOf.
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)

Really?

+  oneOf:
+    - required:
+      - ports
+    - required:
+      - ethernet-ports

Two spaces after the oneOf, 2 spaces after a required as usual.
I don't get it.

Yours,
Linus Walleij

