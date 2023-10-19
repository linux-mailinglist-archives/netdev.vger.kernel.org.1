Return-Path: <netdev+bounces-42800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F07D02F0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 22:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFEA1C20E45
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADD3D391;
	Thu, 19 Oct 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiedKH/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DE38F9E;
	Thu, 19 Oct 2023 20:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C358C433C8;
	Thu, 19 Oct 2023 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697745773;
	bh=2MggdwhgnildvMk7NTDjOnoS6Jg5jQXkqNkqB0aYHMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RiedKH/Y9dbYa6ubDlG7uoC+WUOghwhKS6eWHt3VkrGMdKiVpXgjr3wa1Syt8GXzb
	 aSB+8hDbY/HNr9zWPmh72fzVc8GWH6W+XurEWZqjj3vVuJBbCPtrrW/G/J1v2DaTpA
	 ZsbVxpeds1O29uH8kEZLDd9zKF+bkYcUw34+b2WjZNQHf/KTADVgYG04uGSniuLo33
	 Fo+oLOfnmd9qbPJ5MdS3C5zbsyiNyTJq3NAGDbqj4j6DslvZ/IYJqV+KYeiy76VqQJ
	 Hlyp8sUZp8E3iRaOCKosL3bacUhMlLBYdcV78uPcq/PwPb+8a0xG4neCLulkJzM5pO
	 /nbDUji07J9oQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso50783e87.1;
        Thu, 19 Oct 2023 13:02:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKZGhiaRU7dSDQiRJDADsL8AtWjbqaob/EHCWVsn3mZYf5LWrz
	vbQm1kQbyWln1yZe/YIcnH/72IjY+1aclfxTJA==
X-Google-Smtp-Source: AGHT+IHnua5COj4QgtXUHQNJd1cUfAW0WlEMmymFNUywVpcrDbobt71n9JgwhpVYyWQmFIz6kp8EPizyDSqyxeaxEtQ=
X-Received: by 2002:ac2:54af:0:b0:502:9fce:b6cc with SMTP id
 w15-20020ac254af000000b005029fceb6ccmr2235339lfk.11.1697745771855; Thu, 19
 Oct 2023 13:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <169762516805.391872.4190043734592153628.robh@kernel.org> <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>
 <20231019134902.GB193647-robh@kernel.org>
In-Reply-To: <20231019134902.GB193647-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Oct 2023 15:02:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSex0o_jPV=MNsF7oUnaLx97FpiqJXPhUZH=kv7JZM0w@mail.gmail.com>
Message-ID: <CAL_JsqKSex0o_jPV=MNsF7oUnaLx97FpiqJXPhUZH=kv7JZM0w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 8:49=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Oct 18, 2023 at 01:39:45PM +0200, Linus Walleij wrote:
> > On Wed, Oct 18, 2023 at 12:32=E2=80=AFPM Rob Herring <robh@kernel.org> =
wrote:
> >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a re=
quired property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a requi=
red property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a re=
quired property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a requi=
red property
> > >         from schema $id: http://devicetree.org/schemas/net/dsa/marvel=
l,mv88e6xxx.yaml#
> >
> > Fixed in patch 2/7?
>
> Yes. If one patch has errors we drop it. I should probably just give up
> on the rest of the series instead.

The bot should work better now not dropping patches when there are
warnings. It will give incremental new warnings with each patch.

Rob

