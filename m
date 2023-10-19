Return-Path: <netdev+bounces-42655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC77CFB9D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689F52820BF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A5029433;
	Thu, 19 Oct 2023 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661E27479;
	Thu, 19 Oct 2023 13:49:07 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D75131;
	Thu, 19 Oct 2023 06:49:06 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce322b62aeso36480a34.3;
        Thu, 19 Oct 2023 06:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723345; x=1698328145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIV3i/HNvLNPgakCfPrtUZcxVqXEXL+6MGsHZ5K0R4c=;
        b=lbux8vF8nb38xutkF1CdRga1j26YSU09LD94x1AJGNs49rELLtYm4QN91+UM3u97Rs
         ve/R+fmcV0Bsbg26rK/dSso04sq8bh3bu/rfNc4Dacuw3xhR6MwEjuJms7FtqiJy+DoW
         3Wqq0AJIDCtNi/KBkJwLhLKHvtGE2P03VbnIcSTdndglx8qA9V/qRobxs+RizxDYl4iE
         YzIn9CS00emL33C0hv1bIfmI3kPtPPECT3Ecwxd4WOqJbeafUjZtfXnv1qyZphnr9CJL
         1vxgL8TsqPVz0OmIZJQ+Lfwp+8djOT82wFVAiFVHjzdYCn30vbtO0psEDwTou7TEI7dv
         9Y+A==
X-Gm-Message-State: AOJu0YxhL61fi4h8xo2AcG/k/irpK8LY1PRCSdkPFxgkPcTlsjl9a9y7
	wSeBbnYUmSlQdoYhVZ6JBQ==
X-Google-Smtp-Source: AGHT+IHaI9B2fdB9P1qbAVcNfrBoo52VF4jz72k0QyakB+AzmRV/J8sHTzlfshedfS+sXMw3Y6J4+g==
X-Received: by 2002:a9d:6f19:0:b0:6b9:8357:61e6 with SMTP id n25-20020a9d6f19000000b006b9835761e6mr2027067otq.35.1697723345302;
        Thu, 19 Oct 2023 06:49:05 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bt55-20020a05683039f700b006ce2dd80f3csm107382otb.17.2023.10.19.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:49:04 -0700 (PDT)
Received: (nullmailer pid 203372 invoked by uid 1000);
	Thu, 19 Oct 2023 13:49:02 -0000
Date: Thu, 19 Oct 2023 08:49:02 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231019134902.GB193647-robh@kernel.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <169762516805.391872.4190043734592153628.robh@kernel.org>
 <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZz_+WAt7GG4Chm_xRiBNBP=pin2dx39z27Nx0PuyVN7w@mail.gmail.com>

On Wed, Oct 18, 2023 at 01:39:45PM +0200, Linus Walleij wrote:
> On Wed, Oct 18, 2023 at 12:32 PM Rob Herring <robh@kernel.org> wrote:
> 
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
> >         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
> >         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
> >         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
> >         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fixed in patch 2/7?

Yes. If one patch has errors we drop it. I should probably just give up 
on the rest of the series instead.

Rob

