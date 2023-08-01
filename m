Return-Path: <netdev+bounces-23412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E1976BE36
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A03281419
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC7253C6;
	Tue,  1 Aug 2023 19:58:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A125170;
	Tue,  1 Aug 2023 19:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976AC433C7;
	Tue,  1 Aug 2023 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690919910;
	bh=79BwIOnM6SioCje3neXfEamXafGIUojs9GGzwDzIaT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaG0UuuiBslQIwwDoxSGmwylSNwUwUH7DIQ7eAy76ZMwNQxm6uzQTZe+DpR8IvAQD
	 AR9sF34c6pu020pThaegFYojP886SrOpKscmfRnTNlEgNYWd06/PU127Un7orzG1/E
	 9rUKbhIJY4SvTChDop2NC6sJMRkZgC9FxkLKSBCJ5AX8gdvgUcXJEF/V5ZaRjvw4ws
	 g4igCCOm2Ui3wG63wvnwlKi2DoXv7gVow1xbUTW25ecmVHjRgzWHzoVjMTgMGAYnGS
	 yrqItcGmOO8B2dQEyoty0KKnJhLztUcShDR3TUA3S9ggYOAW7cy5RY8WUi7dlpa5+q
	 jNZZJhtmtcNHQ==
Date: Tue, 1 Aug 2023 12:58:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod
 Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Jose
 Abreu <joabreu@synopsys.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Simon Horman <simon.horman@corigine.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Nobuhiro Iwamatsu
 <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabio Estevam <festevam@gmail.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Wong Vee Khee <veekhee@apple.com>,
 dl-linux-imx <linux-imx@nxp.com>, Andrew Halaney <ahalaney@redhat.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Revanth Kumar Uppala
 <ruppala@nvidia.com>, Jochen Henneberg <jh@henneberg-systemdesign.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode
 parameter for fix_mac_speed
Message-ID: <20230801125828.209c5e88@kernel.org>
In-Reply-To: <AS8PR04MB9176FC45B9663B5BF964F58A890AA@AS8PR04MB9176.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
	<20230731161929.2341584-2-shenwei.wang@nxp.com>
	<20230801-portside-prepaid-513f1f39f245-mkl@pengutronix.de>
	<AS8PR04MB9176FC45B9663B5BF964F58A890AA@AS8PR04MB9176.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 18:43:52 +0000 Shenwei Wang wrote:
> Subject: RE: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter  for fix_mac_speed

Looks like new platform enablement, the correct tree to target this 
at is net-next (i.e. [PATCH net-next]).

> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: Tuesday, August 1, 2023 1:37 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: Russell King <linux@armlinux.org.uk>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> > Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Neil Armstrong
> > <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Vinod
> > Koul <vkoul@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec
> > <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>; Jose
> > Abreu <joabreu@synopsys.com>; imx@lists.linux.dev; Simon Horman
> > <simon.horman@corigine.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Giuseppe Cavallaro
> > <peppe.cavallaro@st.com>; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Fabio Estevam <festevam@gmail.com>;
> > linux-stm32@st-md-mailman.stormreply.com; Jerome Brunet
> > <jbrunet@baylibre.com>; Bartosz Golaszewski
> > <bartosz.golaszewski@linaro.org>; Wong Vee Khee <veekhee@apple.com>; dl-
> > linux-imx <linux-imx@nxp.com>; Andrew Halaney <ahalaney@redhat.com>;
> > Bhupesh Sharma <bhupesh.sharma@linaro.org>; Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com>; Revanth Kumar Uppala
> > <ruppala@nvidia.com>; Jochen Henneberg <jh@henneberg-systemdesign.com>;
> > linux-amlogic@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Pengutronix Kernel
> > Team <kernel@pengutronix.de>
> > Subject: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter
> > for fix_mac_speed

Why is this quote included? Please get a sane email client.

> > On 31.07.2023 11:19:28, Shenwei Wang wrote:  
> > > A mode parameter has been added to the callback function of
> > > fix_mac_speed to indicate the physical layer type.
> > >
> > > The mode can be one the following:
> > > 	MLO_AN_PHY	- Conventional PHY
> > > 	MLO_AN_FIXED	- Fixed-link mode
> > > 	MLO_AN_INBAND	- In-band protocol
> > >
> > > Also use short version of 'uint' to replace the 'unsigned int' in the
> > > function definitions.  
> > 
> > There are not many users of 'uint' in the kernel and it's not used in the stmmac
> > driver so far. From my point of view I would not introduce it and stick to the
> > standard 'unsigned int'.
> 
> Using 'uint' makes the code look cleaner because adding one extra
> parameter may cause some function declarations to span multiple
> lines.  This change keeps function declarations compact on a single
> line.

Marc is right. Just do it.

