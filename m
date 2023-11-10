Return-Path: <netdev+bounces-47139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9607E836B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAE1B20C3B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4833B780;
	Fri, 10 Nov 2023 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772733B2BD;
	Fri, 10 Nov 2023 20:08:04 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391EE9D;
	Fri, 10 Nov 2023 12:08:03 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso1396586a34.0;
        Fri, 10 Nov 2023 12:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646882; x=1700251682;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lU2wi32AdwjPUUZAk+7nh1wLYhNZGsMI5tJITTqsPsQ=;
        b=jzPbfmJpanhbPn9my2KTragafzpg2XXCmdSxCwz4CEQABTGFiS38iyfU8Q0YTHdzx2
         Pz9TKMadOGnmpfndx3/JykYZliBiG5w830hW93bywWsgTgnH7g6DqbRBWb9vaGEXwW/E
         ZunaMT5wRtcnSln0T4oM1PwoNPCzdMRLIrYdHvmEO8VfN9BesdhZnMzs7ESrMBWxxMdd
         UL5pAOQNtK05AG+TnzAePGOmrJ+RBUD3/bsNnMdHyY2wI5rqppnhbHejyNKGgTcNqI9y
         TYKhf212ZtvQDRIUxxSSBpC4YaNSENPWXj82Pj2BBsDmQNe/8gI5SJCr6Ig9/dJpn2J4
         JDgg==
X-Gm-Message-State: AOJu0YxQ+f3aVWVc9NDmvnkvQK5XAKAQTZpvIaNwQENuWX8esuGslEj9
	lm5cF/z8Sz8XEoX93FIwmw==
X-Google-Smtp-Source: AGHT+IGNCyIdj4cJcLS9NAMvOL7IG4RlqmnJQW9n3xmk2NAGPGgd083RhDzB9xSov5b30UDhThnflw==
X-Received: by 2002:a05:6830:3108:b0:6cd:da93:90ce with SMTP id b8-20020a056830310800b006cdda9390cemr204580ots.19.1699646882360;
        Fri, 10 Nov 2023 12:08:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f138-20020a4a5890000000b00584017f57a9sm24691oob.30.2023.11.10.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:08:01 -0800 (PST)
Received: (nullmailer pid 343099 invoked by uid 1000);
	Fri, 10 Nov 2023 20:08:00 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alexander Couzens <lynxis@fe80.eu>, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski <kuba@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org, 
	Sean Wang <sean.wang@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-phy@lists.infradead.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, John Crispin <john@phrozen.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Eric Dumazet <edumazet@google.com>
In-Reply-To: <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
Message-Id: <169964683653.341998.17310260461004337087.robh@kernel.org>
Subject: Re: [RFC PATCH 1/8] dt-bindings: phy: mediatek,xfi-pextp: add new
 bindings
Date: Fri, 10 Nov 2023 14:08:00 -0600


On Thu, 09 Nov 2023 21:50:55 +0000, Daniel Golle wrote:
> Add bindings for the MediaTek PEXTP Ethernet SerDes PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/phy/mediatek,xfi-pextp.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.example.dts:18:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/mediatek,mt7988-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


