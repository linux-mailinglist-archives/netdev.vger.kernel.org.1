Return-Path: <netdev+bounces-22781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9D76932B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B053F1C20BCE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853F63CF;
	Mon, 31 Jul 2023 10:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14D18002
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 10:32:14 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFBE3;
	Mon, 31 Jul 2023 03:32:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F03E6606FCD;
	Mon, 31 Jul 2023 11:32:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1690799532;
	bh=xoosHj1qmc0o7HoZ4wSQyUt8HIP0cBsbyMoDAT5q+g4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MstCsEWNQOdrkXbFZ5s2Yku4HVG5NMTLMlJFkDIwHkXuB3bRjyqFsOU/lvrIP+tNO
	 D+LeQNZGY/dEsFzS3X92INL9/RxUdvq/P6+21BbpTQt7+9YZIKdhYhfxf0tO1Nbp0l
	 rMh3qvkWVY6M21t6vnLKVwQRVe44U/JoGJbDDhiuNyYr9tsABBldGVspICjYJoR5lZ
	 eo9rSumxAL2/EuGAVnZWjbc8E2iU7Wm9atwgmU9sCKC24XLEhfIIzql9X3+6VKg9lg
	 v9OUuHkWnQ8ArqQ3FLOGVaVrDCsYAOOGGlt2iwvXmJtKU2LWe1/uQLMNv8s+dqj/Z9
	 FqDVnuC1oyDGQ==
Message-ID: <cae53693-80e9-2dcb-e222-511eb30ef74c@collabora.com>
Date: Mon, 31 Jul 2023 12:32:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: mediatek,net: fixup MAC binding
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20230729111045.1779-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230729111045.1779-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Il 29/07/23 13:10, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use unevaluatedProperties
> It's needed to allow ethernet-controller.yaml properties work correctly.
> 
> 2. Drop unneeded phy-handle/phy-mode
> 
> 3. Don't require phy-handle
> Some SoCs may use fixed link.
> 
> For in-kernel MT7621 DTS files this fixes following errors:
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@0: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@0: 'phy-handle' is a required property
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@1: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@1: 'phy-handle' is a required property
>          From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



