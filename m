Return-Path: <netdev+bounces-54245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE28065C2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AA1C2113E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1936D304;
	Wed,  6 Dec 2023 03:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF2D44;
	Tue,  5 Dec 2023 19:39:54 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d9a1a2fb22so1827987a34.0;
        Tue, 05 Dec 2023 19:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833994; x=1702438794;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27O2bZEy3+KAENa38gDF53q97pnYbs0pdHxflIPcivY=;
        b=ahDm9Ri6+2YPjIRhEi1NZjpE3PxWHwkURHGocDi5tcwDS/6c2m7ukYWxTQtekM6yL5
         IO81dGtIuBvKBb3xW8cHa984MfKHEXz0FTJKCKoD3HFFXmzDyhUxXsb/YGeZE9awrbSf
         yQuzK5Xu8vs+XIItY/ToUhbstjlbVgbo1Ta52gsGS4fZHu4nzkyas9ju4JPClFfogA0/
         1seGof0vmVTbxvqUBAHpYDuKwNTNBhIuXu1BRD3ajmVgIvG4z+JJTo3DdG02M59MLvEg
         PMb6S73YV+Ygk+w4me7bHt6M2RXRk8RBGnyaggwxX7MS4FOEbktTLsvoPhSdHc8BlsOA
         gOXw==
X-Gm-Message-State: AOJu0Yy4m42a+pR2UBaYCZDDe+Y7LzCwuvlbd1mW5w4zXmZekbgRN+yX
	mXRLtdB+/37POAVsqfaoxA==
X-Google-Smtp-Source: AGHT+IFZmK9knTyK6Z7myA7wKKOiYLq1oWKaL2xsWe/rjiSvG5jsqRqMq+F3g+GgI8/d743m1gQK6g==
X-Received: by 2002:a05:6870:8086:b0:1fb:75a:c425 with SMTP id q6-20020a056870808600b001fb075ac425mr215974oab.78.1701833993921;
        Tue, 05 Dec 2023 19:39:53 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds52-20020a0568705b3400b001fae2d2630dsm3272321oab.18.2023.12.05.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:53 -0800 (PST)
Received: (nullmailer pid 463137 invoked by uid 1000);
	Wed, 06 Dec 2023 03:39:36 -0000
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
Cc: Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Qingfang Deng <dqfext@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Couzens <lynxis@fe80.eu>, 
	SkyLake Huang <SkyLake.Huang@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	John Crispin <john@phrozen.org>, Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>, 
	linux-mediatek@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org>
Message-Id: <170183397366.463026.10686567364320956476.robh@kernel.org>
Subject: Re: [RFC PATCH v2 4/8] dt-bindings: net: pcs: add bindings for
 MediaTek USXGMII PCS
Date: Tue, 05 Dec 2023 21:39:36 -0600


On Wed, 06 Dec 2023 01:44:27 +0000, Daniel Golle wrote:
> MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
> it in order to configure and monitor the Ethernet SerDes link in
> USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
> legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
> interface modes are also available.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dts:18:18: fatal error: dt-bindings/clock/mediatek,mt7988-clk.h: No such file or directory
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/14c3eb3022fac2af105950eb161990ecfb17c016.1701826319.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


