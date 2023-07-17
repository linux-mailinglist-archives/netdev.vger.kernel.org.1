Return-Path: <netdev+bounces-18192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C720E755B74
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EA4281445
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743258465;
	Mon, 17 Jul 2023 06:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430D79D0;
	Mon, 17 Jul 2023 06:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A093FC433C7;
	Mon, 17 Jul 2023 06:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689575045;
	bh=mzBDvBJqqLyJpJlXdHHc50ky7DqFeoJEZrmNjEwRYw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cSmXkQBMdVKYM2skEir1bV6wfmjtrQbqO1IJGKuBIhaVowNQUTrTgCxjHIGLjQxrf
	 aC/Mqe8ThUtGNnjeclaKm5yYvx+1VkzQA8Mr9utTM3ZL+DpRjNnGms0i8Owh/zz47+
	 h23rcDa+qzK1c9z1FR8QVJBepzxuuB2xEgqOuOIqx4jooERucg0rTondYvdBHeVIOz
	 bL1wNk7h7Adc3SmCkPC256BY6lJOEvwXhhD9BG3119i3AtN9OvJn0PEErA3fywzUPz
	 Uelr5Xmo7pEGEjZ7k3ZowAQcz2l0sAxbf5yJcE3PDjGEbPdkw3ro5etSrrJpG2MR4S
	 U/6x9udfwh94A==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Yu Chen <chenyu56@huawei.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Alban Bedel <albeu@free.fr>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vincent Shih <vincent.sunplus@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-can@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20230714174841.4061919-1-robh@kernel.org>
References: <20230714174841.4061919-1-robh@kernel.org>
Subject: Re: [PATCH] phy: Explicitly include correct DT includes
Message-Id: <168957502626.294691.2933301083453115851.b4-ty@kernel.org>
Date: Mon, 17 Jul 2023 11:53:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 14 Jul 2023 11:48:35 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] phy: Explicitly include correct DT includes
      commit: 7559e7572c03e433efec7734af6a674fdd83dd68

Best regards,
-- 
~Vinod



