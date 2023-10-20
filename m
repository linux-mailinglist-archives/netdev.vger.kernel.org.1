Return-Path: <netdev+bounces-43011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CB7D0FE3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEA5B20F5C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE214AAC;
	Fri, 20 Oct 2023 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR0eL1lM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DF8F5A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:47:33 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961FD41
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:47:32 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7e5dc8573so8399607b3.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697806051; x=1698410851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvdYlPzJSp2kN+nmfG91ahOiUfPO5XZNyoR+Dhgeu9M=;
        b=jR0eL1lMMaZ0kHSVRKKd21JiEGRu2fszISguxfLMww+gPhZF7tBPI1sNxkNdpx+Ems
         G+RAVF19PVYl0BulGIDZI5sLzOofWRWl6YmB4I5CiFGSkQWmDdo8OzDBag52kwsI2JDU
         jx0ndXlgKBfbh0WfJ59JCxWa5C5X2pKwTA6ttH7k+2J/dAX0+3CeIaDwJ5+kjggLTyBG
         LVzpc3GAy125NTnxAF2Tzfw5uQGasScogLqNvXVtlXPIgGZ/EFvF1NXcQA3cYBAac9R4
         lFlNF0aOZuXGq4DxXotHZxHuGOacqd+tTXdxDxrtH1eOJvjvLhFIDVWTIIPw5IeW6jV2
         jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806051; x=1698410851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvdYlPzJSp2kN+nmfG91ahOiUfPO5XZNyoR+Dhgeu9M=;
        b=pUuK2OSEiN9Oo1Y//8Z4QgaYxaBjCYNkLZgbhxJcEsdG4IAn06RfQMjpz7ru4om+kP
         e1rq90on53F+w7x73e6Kp60ECQ7CYIxj+R/Vy56jxQQc8rDc/KC83Y4jm1Suy3gySe9+
         r+KQrLYTUiWPFPooLBm24qHPn1Ezm78pgfnGS861EIc1gTfnReRS3q0+AX7RYL0o4hkr
         1itN/CjLTWcVNZJXbXRKm/dyqd5nAQhtqrKKHEfI3v9gb9ToslpokRPNGDEUNV4i7NNW
         mmvM54PH6LYyPiIUAcvvp8w8SEeclxMhD+mq3lwnXMgUBmtgdy0joQtN179Bx5CiIH4x
         v2hg==
X-Gm-Message-State: AOJu0YyiaxHlGVLYwAC6K6R246HIb6v3Etun9xpd4Q7U94D4VSWFl5Uz
	4pMoi41iN/8q8eY/AEhktAXwtJWwBy2h63iDIYycig==
X-Google-Smtp-Source: AGHT+IHutw33neeTCKBjV4oIKs+snL/i4PrTC2nP6LgZiP9pPXm3Z4ThyJcePmZQHhtJSzo5jJgBUZ7vAh5+MjyBcyU=
X-Received: by 2002:a0d:d98f:0:b0:5a1:d352:9fe1 with SMTP id
 b137-20020a0dd98f000000b005a1d3529fe1mr1885169ywe.42.1697806051397; Fri, 20
 Oct 2023 05:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org> <20231019153552.nndysafvblrkl2zn@skbuf>
In-Reply-To: <20231019153552.nndysafvblrkl2zn@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2023 14:47:20 +0200
Message-ID: <CACRpkdbskk22SLmopUTD78kMWL_gcOa=YWHLFtrkDAD5=W=HFw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
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

On Thu, Oct 19, 2023 at 5:35=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Yikes, both these examples are actually broken,

As you can see from the patch, they are just carried over from
Documentation/devicetree/bindings/net/dsa/marvell.txt

+/- fixes to make them pass schema checks.

> So either:
>
> - you delete the "mdio" node and the ethernet-phys under it, or
> - you add all ethernet-phys under the mdio node, and put phy-handles
>   from ports to each of them, and phy-modes of "internal"
>
> What you have now is exactly what won't work, i.e. an OF-based
> slave_mii_bus with a non-OF-based phy_connect().

Yeah when I run check_dtbs I get a few (not many) warnings
like this on aarch64 and armv7_multi:

arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dtb: switch@0: ports:port@4:
'phy-mode' is a required property
    from schema $id:
http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Isn't there some in-kernel DTS file with a *good* example of how
a Marvell mv88e6xxx switch is supposed to look I can just
copy instead? We shouldn't conjure synthetic examples.

> I don't want to see DT examples that are structurally broken, sorry,
> because then we wonder why users are confused.

These examples are already in the kernel. Migrating them
from marvell.txt to marvell,mv88e6xxx.yaml doesn't make
the situation worse, it's not like people magically start trusting
the examples more because they are in YAML than in .txt.

But sure let's try to put in better examples!

> Personally, I would opt for adding the more modern explicit phy-handle
> and phy-mode everywhere.

I'm game. Point out the DTS file and I will take that.

> Also, you seem to have duplicated some work also done by Ar=C4=B1n=C3=A7 =
but not
> finalized (the mv88e6xxx schema conversion, on which you were also
> copied). Let me add Marek here too, to make sure he's aware of 2
> previous attempts and doesn't start working on a 3rd one :)

Haha I forgot :D

> One other thing I see as a deal breaker for this schema conversion is
> that $nodename for Marvell needs to allow basically anything (invalidatin=
g
> the constraint from ethernet-switch.yaml), because we can't change node
> names in the case of some boards, otherwise we risk breaking them
> (see MOX). If the schema starts emitting warnings for those node names,
> then it's inevitable that some pixie in the future will eventually break
> them by "fixing" the node name.

I already did a bit of hippo-in-china-porcelain store in the patches
in this series mostly renaming things like "switch0@0" to "switch@0"
(yeah that's all).

Is this part of the problem or something else?

I run the binding checks across all aarch64 and armv7_multi platforms
on this patch set without any major issues.

Yours,
Linus Walleij

