Return-Path: <netdev+bounces-47737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C47EB13E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7E1F24B49
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639E4405D5;
	Tue, 14 Nov 2023 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34073FE43;
	Tue, 14 Nov 2023 13:56:08 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B98132;
	Tue, 14 Nov 2023 05:56:07 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1efa01323b4so3443564fac.3;
        Tue, 14 Nov 2023 05:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970167; x=1700574967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiASBl9VrAjzQgmOuXmfWuxNZgNwYoFGLkzwqXtE/qw=;
        b=hcEPTm2ogQo3AX1d8RkwYEdT95D16WfIGCgK9lYmPJSnGhhMZYYS/MEGow9VB3ZLNB
         OzrDoyQRQqzBR4DctL9bSIoWHXGqMWUV0U24yXhguiqPDv+V/eUgACphFn0kz/Z3NdBf
         Ex357we+IpZIUxCdBnFPBrGe2eCfsYMhO5X5XVwBLPEgkPgJJs1XDpHWUBNvYUi8Zkea
         vi9Ps2LVuqnhzzvw7fqitENFY4J0eUzz8NhSx8G69YgGeesswgACZKm7pj33mRqGa1ud
         DujMP+sMmpooYEdBN+4Ty96P2hsRvyvutInE6fdO02gcPfBJesWz2XSFxztYdZE7w+Q1
         0MqA==
X-Gm-Message-State: AOJu0Yyvt6+6aNEglA33//BiWbj/EsE7jP7Zy3VfT8VVcWkxkpR35V8y
	nh844IFYVqBiP2peEYHwKm6b1WFudA==
X-Google-Smtp-Source: AGHT+IFYOuCtYvhZonQy046WfyrIoy4A+vOjsLbnefhLS1WXzW1gHM/v6TjGpVo+25v7X/N6wfLMGQ==
X-Received: by 2002:a05:6870:40d2:b0:1e9:d8a4:551f with SMTP id l18-20020a05687040d200b001e9d8a4551fmr11788936oal.17.1699970166709;
        Tue, 14 Nov 2023 05:56:06 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec21-20020a0568708c1500b001e5ad4b2f65sm1372872oab.19.2023.11.14.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:56:06 -0800 (PST)
Received: (nullmailer pid 1664148 invoked by uid 1000);
	Tue, 14 Nov 2023 13:56:04 -0000
Date: Tue, 14 Nov 2023 07:56:04 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexander Couzens <lynxis@fe80.eu>, Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 5/8] dt-bindings: net: pcs: add bindings for MediaTek
 USXGMII PCS
Message-ID: <20231114135604.GA1661768-robh@kernel.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <2dff6aff7006573d3232ec2ddd93c1792740d4d3.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dff6aff7006573d3232ec2ddd93c1792740d4d3.1699565880.git.daniel@makrotopia.org>

On Thu, Nov 09, 2023 at 09:51:47PM +0000, Daniel Golle wrote:
> MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
> it in order to configure and monitor the Ethernet SerDes link in
> USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
> legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
> interface modes are also available.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> new file mode 100644
> index 0000000000000..199cf47859e31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/mediatek,usxgmii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek USXGMII PCS
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The MediaTek USXGMII PCS provides physical link control and status
> +  for USXGMII, 10GBase-R and 5GBase-R links on the SerDes interfaces
> +  provided by the PEXTP PHY.
> +  In order to also support legacy 2500Base-X, 1000Base-X and Cisco
> +  SGMII an existing mediatek,*-sgmiisys LynxI PCS is wrapped to
> +  provide those interfaces modes on the same SerDes interfaces shared
> +  with the USXGMII PCS.
> +
> +properties:
> +  $nodename:
> +    pattern: "^pcs@[0-9a-f]+$"
> +
> +  compatible:
> +    const: mediatek,mt7988-usxgmiisys
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: USXGMII top-level clock
> +      - description: SGMII top-level clock
> +      - description: SGMII subsystem TX clock
> +      - description: SGMII subsystem RX clock
> +      - description: XFI PLL clock
> +
> +  clock-names:
> +    items:
> +      - const: usxgmii
> +      - const: sgmii_sel
> +      - const: sgmii_tx
> +      - const: sgmii_rx
> +      - const: xfi_pll
> +
> +  phys:
> +    items:
> +      - description: PEXTP SerDes PHY
> +
> +  mediatek,sgmiisys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon node of the corresponding SGMII LynxI PCS.
> +
> +  resets:
> +    items:
> +      - description: XFI reset
> +      - description: SGMII reset
> +
> +  reset-names:
> +    items:
> +      - const: xfi
> +      - const: sgmii
> +
> +  "#pcs-cells":

There is no such property defined.

Rob

