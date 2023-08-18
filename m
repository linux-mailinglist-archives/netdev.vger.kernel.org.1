Return-Path: <netdev+bounces-28996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBF7815BA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373A81C20BD1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12118011;
	Fri, 18 Aug 2023 23:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B417AC3
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 23:18:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117B4205;
	Fri, 18 Aug 2023 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LRQRZPdrv4QI8bQQoUTKBOoMNyJa1LbrbkfjcCc8uZw=; b=vkl51uAgZ2coNgQgP/P4b8/ozl
	CFZbSnec4ohA+rkE1H92ceFU7AiniNCuavWVyoH+RyBPtjuVUujA6tVAn0aKhzlJk5cRfdds56VFv
	yyMQXQO0bhc7s3zU31cE4b8FwZSyl2wQSdKL0PeJhOs/X4xKGhiQcWiWslcEMhB89CeaPQ0bF6qIx
	NOpTOoT34ekpDhGPB/jkuU5NCH9HH0vAdwT13mclegA8ucop3r+npiuv4n5YQ7mb53OC6ld6DFrZ0
	a0d8CX0NKx6XMbylqHUv7n+TK5Df613wD3hawMRTVHw7ALG868QMRyGCCLxRXRAtPH8xLhJ2pZUBC
	ef7BHUKA==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qX8jS-00A9bg-1P;
	Fri, 18 Aug 2023 23:18:18 +0000
Message-ID: <e1ca6c2f-92e4-6dad-79ec-71cf66e9a385@infradead.org>
Date: Fri, 18 Aug 2023 16:18:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 27/28] ASoC: codecs: Add support for the framer codec
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <cb734efe2eeb89cb1afbf01d3625181537e2850f.1692376361.git.christophe.leroy@csgroup.eu>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cb734efe2eeb89cb1afbf01d3625181537e2850f.1692376361.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/18/23 09:39, Christophe Leroy wrote:
> +config SND_SOC_FRAMER
> +	tristate "Framer codec"
> +	depends on GENERIC_FRAMER
> +	help
> +	  Enable support for the framer codec.
> +	  The framer codec uses the generic framer infrastructure to transport
> +	  some audio data over an analog E1/T1/J1 line.
> +	  This codec allows to use some of the time slots available on the TDM
> +	  bus on which the framer is connected to transport the audio data.
> +

Just curious: what controls the slot allocations/usages?
Is that done in userspace?

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-soc-framer.

thanks.
-- 
~Randy

