Return-Path: <netdev+bounces-31220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362B78C382
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE23E280EA0
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDA154B1;
	Tue, 29 Aug 2023 11:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC238BEE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D8C433C8;
	Tue, 29 Aug 2023 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693309307;
	bh=ymfDnb1wNojQ0jGjJUgnVBim6gA/rLm0coxCCDMJGWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhbD38kB5M9zVuy7OYjG0Q92tnvjC1HsMMr4zWzHR20mIk43cpLQPVNCiEx+Dji0Z
	 lnk14D7A/Fnrxy3UGN9ZDQr7KGesf5cAhrjbwc52kxErnmrtslx2XIDoZzvX3lqkRL
	 fcdD1UB35h4syD44cYE5LWl4hHf+RH0HPd0Km043uN6R4f1iZimUyC6sneECVGll4b
	 e2O2k/izNe2/d4aispw15Y8mwBX45y3P7OneCy/p75qJo3E50Cs7rAUP5pMmvUrQLH
	 QoY6/X7DgEpVX6jP8aGzNPHSchPj2DnCfFE4S3bs8KLmH6LDsxmKke+lrS1hx54VKb
	 hjrdGbW4mKftg==
Date: Tue, 29 Aug 2023 19:29:52 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
Message-ID: <ZO3WsHH1GDWdcLAU@xhacker>
References: <20230829104033.955-1-jszhang@kernel.org>
 <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>

On Tue, Aug 29, 2023 at 12:21:29PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 29, 2023 at 06:40:11PM +0800, Jisheng Zhang wrote:
> > Russell pointed out there's a new devm_stmmac_probe_config_dt()
> > helper now when reviewing my starfive gmac error handling patch[1].
> > After greping the code, this nice helper was introduced by Bartosz in
> > [2], I think it's time to convert all dwmac users to this helper and
> > finally complete the TODO in [2] "but once all users of the old
> > stmmac_pltfr_remove() are converted to the devres helper, it will be
> > renamed back to stmmac_pltfr_remove() and the no_dt function removed."
> 
> I think a useful final patch may be to make stmmac_probe_config_dt()
> static so there aren't any new uses of stmmac_probe_config_dt().

Good idea!
> 
> Also note that net-next is now closed, so please wait until after -rc1
> for net-next to re-open, or post as RFC. Thanks.

oops, I didn't notice this cycle of window is closed, I will wait for next
development window.

Thank you
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

