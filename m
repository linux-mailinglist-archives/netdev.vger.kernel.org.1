Return-Path: <netdev+bounces-45553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA107DE17A
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A11C20C59
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164C134AE;
	Wed,  1 Nov 2023 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB611CBF;
	Wed,  1 Nov 2023 13:28:59 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2CEFC;
	Wed,  1 Nov 2023 06:28:51 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2e44c7941so4559723b6e.2;
        Wed, 01 Nov 2023 06:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845330; x=1699450130;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yuRhwoRZhsAqDUdHH78st4OhSKCrO+YWmaTXJR5WojE=;
        b=FBXb95r0YpQKKxksJazMcmmwop6jeUA4wiLCILYBLrYEd3jtbCyIhp0eBDSkXktzZR
         LHwIiD9TD0cGQFoapkZOlLRz+zVtnsL1ZQX8Zpq9yUJpCvITJjH1bJ/A3qIoFfXWjOJ7
         3MqUp/wML8r7OdCv11D7GfaoPzQt+xeSJlrp98gsAvhDAYCMQwsYDpvyn7J3lpGd+4RB
         m5G+5F77BenYumRNAN/F5Uk+OkaSM1NbamQSMM5AphFDMoFjduPonniI9swB+alqrUR3
         Q3OSOqYkwVwlHtiYZXklqrn4DFnarXgHJDm/Z5An2OqGiddvdzH1t7VZC3J465MDiFQy
         HbjQ==
X-Gm-Message-State: AOJu0YzI9vePqtMdKVwJio80bPyPctY4JqiKYi87QB3x8v1foJq9sl9f
	Nn+4nR4BBX8ewmIh8sCheA==
X-Google-Smtp-Source: AGHT+IE5bPC9rrewIVjh/QtRMTKfvJg0gEfDZ/hx+nIvG88LiXjawrwUWwltBfASmntx2SbX7IBNxQ==
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id f4-20020a05680814c400b003b5663c9b91mr5571557oiw.12.1698845330569;
        Wed, 01 Nov 2023 06:28:50 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a056808008700b003ae165739bbsm221997oic.7.2023.11.01.06.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:28:49 -0700 (PDT)
Received: (nullmailer pid 4072711 invoked by uid 1000);
	Wed, 01 Nov 2023 13:28:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20231101123608.11157-2-ansuelsmth@gmail.com>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <20231101123608.11157-2-ansuelsmth@gmail.com>
Message-Id: <169884529967.4072013.2362625689707570358.robh@kernel.org>
Subject: Re: [net-next PATCH v2 2/2] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Date: Wed, 01 Nov 2023 08:28:48 -0500


On Wed, 01 Nov 2023 13:36:08 +0100, Christian Marangi wrote:
> Document bindings for Marvell Aquantia PHY.
> 
> The Marvell Aquantia PHY require a firmware to work correctly and there
> at least 3 way to load this firmware.
> 
> Describe all the different way and document the binding "firmware-name"
> to load the PHY firmware from userspace.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Add DT patch
> 
>  .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-mux-mmioreg.example.dtb: ethernet-phy@4: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ethernet-phy.example.dtb: ethernet-phy@0: compatible:0: 'ethernet-phy-id0141.0e90' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sff,sfp.example.dtb: ethernet-phy@0: Unevaluated properties are not allowed ('interrupt' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: $nodename:0: 'phy@0' does not match '^ethernet-phy(@[a-f0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: compatible:0: 'ethernet-phy-ieee802.3-c45' is not one of ['ethernet-phy-id03a1.b445', 'ethernet-phy-id03a1.b460', 'ethernet-phy-id03a1.b4a2', 'ethernet-phy-id03a1.b4d0', 'ethernet-phy-id03a1.b4e0', 'ethernet-phy-id03a1.b5c2', 'ethernet-phy-id03a1.b4b0', 'ethernet-phy-id03a1.b662', 'ethernet-phy-id03a1.b712', 'ethernet-phy-id31c3.1c12']
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: compatible: ['ethernet-phy-ieee802.3-c45'] is too short
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: phy@0: Unevaluated properties are not allowed ('#phy-cells', 'compatible' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231101123608.11157-2-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


