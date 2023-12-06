Return-Path: <netdev+bounces-54432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56358070F5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0198A1C209D0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF739FE4;
	Wed,  6 Dec 2023 13:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C662122;
	Wed,  6 Dec 2023 05:34:06 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d9d29a2332so46603a34.0;
        Wed, 06 Dec 2023 05:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869646; x=1702474446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKUyAGPVNJ2iCz/byc+vad2U0HtCXFR/OKxsFSUjBSo=;
        b=Afr08ZZnZPflUMyXwsoWEYz2ezular9v0AiFuR2H+yREBvoQX07sLYoUN1csfE0M+8
         8PFV9eOsxWT0meHHZO1crWjhhg43dFoZzpO6zXKYHHMuZLwgEyiEsUbfoEvwfw7k1Bon
         k/5rHG6bmLPccVJXadEyU5UMQAFgUaPgaZENS3TqYv6/u5s34JrZBuI9+cRYIp3SQhsJ
         pmfKxQcZ6MQ8h/oIH4NZ3EbISQRsDEd1Qe7SdztxRKOg9MW21Df8+wmNng6jmdekriMQ
         k+vKln7W/rb4lWYGX4+H98wPgcDGAXRi2ppCT66RFbElC2uGqNSWzeP1J7PC7NrPLelF
         fmlw==
X-Gm-Message-State: AOJu0Yx9KzH4HMzc1IhChQbqOCTauqXBaUXDiRYCJf5R50ZA2EG3k/V+
	6TkQpIqJ1ylDVDYY5MOs1g==
X-Google-Smtp-Source: AGHT+IHWs8BDYeEsQ9p7nU50NuMdIrEA5NhSUWcTgZm0IYA+OhimehJYkLAie1qpwHIrrcHjciYBFA==
X-Received: by 2002:a05:6830:2aaa:b0:6d8:74e2:552a with SMTP id s42-20020a0568302aaa00b006d874e2552amr431988otu.22.1701869645696;
        Wed, 06 Dec 2023 05:34:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2665206otk.45.2023.12.06.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:34:05 -0800 (PST)
Received: (nullmailer pid 1911334 invoked by uid 1000);
	Wed, 06 Dec 2023 13:34:03 -0000
Date: Wed, 6 Dec 2023 07:34:03 -0600
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
	Alexander Couzens <lynxis@fe80.eu>, Qingfang Deng <dqfext@gmail.com>, 
	SkyLake Huang <SkyLake.Huang@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII PCS
Message-ID: <20231206133403.GA1894508-robh@kernel.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>

On Wed, Dec 06, 2023 at 01:44:38AM +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> create a wrapped PCS taking care of the components shared between the
> new USXGMII PCS and the legacy LynxI PCS.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/pcs/mediatek,usxgmii.yaml    |  46 +-

Why are you changing the binding you just added?

In any case, bindings are separate patches.

>  MAINTAINERS                                   |   2 +
>  drivers/net/pcs/Kconfig                       |  11 +
>  drivers/net/pcs/Makefile                      |   1 +
>  drivers/net/pcs/pcs-mtk-usxgmii.c             | 413 ++++++++++++++++++
>  include/linux/pcs/pcs-mtk-usxgmii.h           |  26 ++
>  6 files changed, 456 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
>  create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

