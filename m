Return-Path: <netdev+bounces-45554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD77DE1B4
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5422812B6
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74F134C6;
	Wed,  1 Nov 2023 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F520F6;
	Wed,  1 Nov 2023 13:38:36 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB178A2;
	Wed,  1 Nov 2023 06:38:31 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2f2b9a176so4363933b6e.0;
        Wed, 01 Nov 2023 06:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845911; x=1699450711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9KfA3zYa4RuQNIKTFwtE9LoaDqeAECPgnjla+xhy8s=;
        b=jw1k9OmfeDBjsmHvMk47jJ+drK05ufIy9GFOHKLrdLufA8l5jxqPrr5gWW3sj+3ZpO
         TkzhH+2Ki0szPIMTPCwuPA9S/Gi+o3QPWzen5T/cHvoCBZMLO1we6uQodafpQJ6HQwGU
         QT6uFurxIGAKDWF0Wa61QCIe1aZ73zJJR8HdYlsQPoFdm/Rkm8oWCVUITI4v8lxNUhQA
         ahVHZvPwg6UL1fu9n7xaMrZqQrDmvbk7BQLD6U/nM7xDtNrOvrb4BnQfwchlh3i4EBAp
         lIISna0sKp22ra47WFPYRrUYGp8qU7dvMkweNgY5eagjNSf2AZFCS8saEPmszMIykum7
         W8gQ==
X-Gm-Message-State: AOJu0YzSwpszB0XVdz+oAUCSaveYn29+ZgUyvXG43fNLuYYVvOszf+PZ
	Get/VBOg0UsYTKndh10NDA==
X-Google-Smtp-Source: AGHT+IFng2kWgDi/1hqDnOprjsKzdtQIpq3XJ04ryXRQbkhSKYvchZzbtrVi8LElnoloOtq2Rwli+w==
X-Received: by 2002:a05:6808:8d0:b0:3af:75d5:e10b with SMTP id k16-20020a05680808d000b003af75d5e10bmr15564720oij.25.1698845910938;
        Wed, 01 Nov 2023 06:38:30 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k16-20020a544410000000b003b2e7231faasm218911oiw.28.2023.11.01.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:38:29 -0700 (PDT)
Received: (nullmailer pid 4121437 invoked by uid 1000);
	Wed, 01 Nov 2023 13:38:28 -0000
Date: Wed, 1 Nov 2023 08:38:28 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <20231101133828.GA4116063-robh@kernel.org>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <20231101123608.11157-2-ansuelsmth@gmail.com>
 <169884529967.4072013.2362625689707570358.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169884529967.4072013.2362625689707570358.robh@kernel.org>

On Wed, Nov 01, 2023 at 08:28:48AM -0500, Rob Herring wrote:
> 
> On Wed, 01 Nov 2023 13:36:08 +0100, Christian Marangi wrote:
> > Document bindings for Marvell Aquantia PHY.
> > 
> > The Marvell Aquantia PHY require a firmware to work correctly and there
> > at least 3 way to load this firmware.
> > 
> > Describe all the different way and document the binding "firmware-name"
> > to load the PHY firmware from userspace.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Add DT patch
> > 
> >  .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ethernet-phy.example.dtb: ethernet-phy@0: compatible:0: 'ethernet-phy-id0141.0e90' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: Unevaluated properties are not allowed ('interrupt' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: $nodename:0: 'phy@0' does not match '^ethernet-phy(@[a-f0-9]+)?$'
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: Unevaluated properties are not allowed ('#phy-cells', 'compatible' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#

You need a custom 'select' with all the compatibles except 
ethernet-phy-ieee802.3-c45 listed.

Rob

