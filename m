Return-Path: <netdev+bounces-42217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1807CDAD1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0081C20EC8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F12EAEF;
	Wed, 18 Oct 2023 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGv8WXFG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FC2DF64
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:40:04 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D8D53
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:39:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c08b7744so81387447b3.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629196; x=1698233996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seUdplTAMb/zRp5FDRW3ieCXWuBCH/+x0BQ3MBVM2m0=;
        b=nGv8WXFGFB/xUG42snGADeTohgk11NlPAXED8Xn1vzcosZuH65oLc0DMOYJP1FnQMm
         h5j2zwTGZsQdafrdca9b9Lrw16d0hn22Al3FH+XL3T7ALzFOOaoQZ7w/dFgddVz34AYk
         AxZ335FLmBojzFhs6kh3pIcjbKHRLSNHReH0Nh76NHIrKOexVddJe68pzvOLBHXs+uo1
         r6ttOJIhNeBJKCpSYHlK96femSM35QMOjwMn3vPy7fcSlX+BdiS2Ka+MPPqgEZt9WjVx
         N4r+c6ykcQVr3TAxfuhXMkJJzKVlvFZS8wTibWs2YFGQPP8IuDszo6wukzHJOSWl9yAE
         H/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629196; x=1698233996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seUdplTAMb/zRp5FDRW3ieCXWuBCH/+x0BQ3MBVM2m0=;
        b=NFHOKQfpK6Qv/IJkK98ztwE9a+Y6s15wKwFbZY68QZCtZk4Dlw3c2yj2RZ88kNH/ky
         T+jbhhq8fopq38BjdGkjzVsBqACp1ucN+0SESiMpCkgGHsjz5NiKXszbUhAEINj1N71U
         4EyNoNmBIGThO25GPpXP+UTX0KLjwJBhfUpCfbf/8akY52v7Hi45BTXyVpW+3eG5gzfs
         yunYqCNni5TowmDPkYLkjzG9JJyB1f+k1ctz0XAVi3I+qj0ogIMFxgR9jHZyZYIQEuK6
         jh7j7fZlQWBO9JL4N4/IARQhGOlfKds4WrSpqpJtT56uoAIx/3zerqDsUW9tIDkXJZRp
         s5zw==
X-Gm-Message-State: AOJu0Yy/DY4c2EUxl4IRt4qVeVGmLiYrCPtrl/7UYpSQQgKP0j1sH7L9
	fNJ7uega9aBitQuGdi+OVQF0prquaOnp7S3fm+qI5w==
X-Google-Smtp-Source: AGHT+IGd6pMmcUmYhIP19DAntAI7kjrqy+WPuQL4RuNHhD2KtYzr3w/qLLHu6U4w6Mo5RaObRLXBuuHLDdyNrlBBvQI=
X-Received: by 2002:a0d:e8c2:0:b0:5a4:db86:4ea8 with SMTP id
 r185-20020a0de8c2000000b005a4db864ea8mr4887814ywe.31.1697629196493; Wed, 18
 Oct 2023 04:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org> <169762516805.391872.4190043734592153628.robh@kernel.org>
In-Reply-To: <169762516805.391872.4190043734592153628.robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Oct 2023 13:39:45 +0200
Message-ID: <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To: Rob Herring <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a requir=
ed property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required =
property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a requir=
ed property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required =
property
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#

Fixed in patch 2/7?

Yours,
Linus Walleij

