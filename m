Return-Path: <netdev+bounces-173678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA385A5A5F3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EB11887C6F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5141DED4B;
	Mon, 10 Mar 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB1ErfGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0231DE4DF;
	Mon, 10 Mar 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641396; cv=none; b=Z0nQaOsnZJDV39sZsV4v6mV8cTEVWSZPzn/sMCu6FvHxITSCBWSnBA7G5e+0q4OtoDQ94owSO0y+UcgYLktOjD8Pkx/4tTxQdC7J5oV5PKhJb228M/ZC/u5/WXXI0IPBOU2pcmtaGFeElupALbXq+bwsMexb/uQP33l4AJxG3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641396; c=relaxed/simple;
	bh=xhhTO52C/8fG7MDjEfxhWhAUsEKxrB+SaqXmnB/oZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXWDAZcFM5EEhC51cTruMZTgxVCiO2ZBhcDOtTHjcXwrD1nWfzcngTTvFcwsRggyGB4arcFztg+ksedfLes5yrVJdzG3B2UoCHTWVc5c99hwQBiz+jASUMlPerP5rULjc5tBFs63sKiErAAKuLuSf9j78301PopTnkvZ3dZtAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB1ErfGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C95C4CEE5;
	Mon, 10 Mar 2025 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741641395;
	bh=xhhTO52C/8fG7MDjEfxhWhAUsEKxrB+SaqXmnB/oZGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KB1ErfGMXqL3eUvY/h60CuKtdRdDzpKgAEjSXuOVZQgYXaX7PjmtRr+7t+hvS6tGy
	 ytMrx41oPxfH3/0bph5XHgZy28tQ6Iyar2WI4JMjngSuQq9nge7too/D5Lq3Nezlm0
	 Ev2cu/gKGiY2ajzu5pUo2A/BRY0gQIWXwKyphw6qT7z7sSreM3Suncat5jtP4rMt+a
	 8Zhi1XgPM3G/xx5GvP1PkwRGVoj8YRnX972OzIo+R+3PskdAyDEgUJqqcOBrRdx7la
	 7no62gUzvph6vkxPCn7Ai5G55Ys2afIwQ35/d85v/cKcR4Vdd40oLznc/OHhu45KPE
	 1Tw6Rt5PmnBPQ==
Date: Mon, 10 Mar 2025 16:16:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	"G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
	netdev@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linux Team <linux-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	David Wu <david.wu@rock-chips.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Biao Huang <biao.huang@mediatek.com>, devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, imx@lists.linux.dev
Subject: Re: [PATCH net-next] dt-bindings: net: Define interrupt constraints
 for DWMAC vendor bindings
Message-ID: <174164139310.903652.6069254912704107254.robh@kernel.org>
References: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Sun, 09 Mar 2025 00:33:01 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The `snps,dwmac.yaml` binding currently sets `maxItems: 3` for the
> `interrupts` and `interrupt-names` properties, but vendor bindings
> selecting `snps,dwmac.yaml` do not impose these limits.
> 
> Define constraints for `interrupts` and `interrupt-names` properties in
> various DWMAC vendor bindings to ensure proper validation and consistency.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> Based on recent patch [0] which increases the interrupts to 11
> and adds `additionalItems: true` its good to have constraints
> to validate the schema. Ive made the changes based on the DT
> binding doc and the users. Ive ran dt binding checks to ensure
> the constraints are valid. Please let me know if you'd like me
> to split this patch or if any of the constraints are incorrect,
> as I don't have documentation for all of these platforms.
> 
> https://lore.kernel.org/all/20250308200921.1089980-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers, Prabhakar
> ---
>  .../devicetree/bindings/net/amlogic,meson-dwmac.yaml   |  6 ++++++
>  .../devicetree/bindings/net/intel,dwmac-plat.yaml      |  6 ++++++
>  .../devicetree/bindings/net/mediatek-dwmac.yaml        |  6 ++++++
>  .../devicetree/bindings/net/nxp,dwmac-imx.yaml         |  8 ++++++++
>  .../devicetree/bindings/net/rockchip-dwmac.yaml        | 10 ++++++++++
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
>  .../bindings/net/toshiba,visconti-dwmac.yaml           |  6 ++++++
>  7 files changed, 52 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


