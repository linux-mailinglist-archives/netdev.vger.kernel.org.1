Return-Path: <netdev+bounces-56310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F280E7AE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945082818EB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52D584F4;
	Tue, 12 Dec 2023 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dm+Q7ExC"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBE107;
	Tue, 12 Dec 2023 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702373495;
	bh=63BaG8+UnODbNllY/PE5UFPUBy6aPrVHxXNq6unqZyY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Dm+Q7ExCKkKTJuhUnjwEyNwJM+krOm1JuYCk9nSgkwJSCWzdxuOm3EVOK3+CSPIM9
	 qk8iCFiBNEKWBR5WNHU+85HGJ4fxI/uOUqwHmiQw2ubrzMMZU2WpyoUY19aKaxRRBR
	 W8mV6t8z6BIb9L5eD2cjzsz1K5J7n9PLPVKkVghu/pzAPHU7CmyEi+TwLOqjM47BcV
	 spCfjrfAor/pVbCOW5LCKdXmD9fjxmISwcwU3P+6JVG12PJLf7mhyYMrRzPJLbYYbd
	 V0cz4CXasjsdSAAS7ErqxNmz2OtAtK9V6PRi25JCAdLASQQyfh8e1vGpmv7hvkW6kS
	 61XB5S+uwBNoA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B23B3781423;
	Tue, 12 Dec 2023 09:31:34 +0000 (UTC)
Message-ID: <1cd5446a-37fd-4fbb-8c17-e0046e58c29b@collabora.com>
Date: Tue, 12 Dec 2023 10:31:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] clk: mediatek: add drivers for MT7988 SoC
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Chen-Yu Tsai <wenst@chromium.org>,
 "Garmin.Chang" <Garmin.Chang@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
 <14b00d8c9d1fcfdf8cd6b9b02e5a19566d970e6b.1702350213.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <14b00d8c9d1fcfdf8cd6b9b02e5a19566d970e6b.1702350213.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/12/23 04:19, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Add APMIXED, ETH, INFRACFG and TOPCKGEN clock drivers which are
> typical MediaTek designs.
> 
> Also add driver for XFIPLL clock generating the 156.25MHz clock for
> the XFI SerDes. It needs an undocumented software workaround and has
> an unknown internal design.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



