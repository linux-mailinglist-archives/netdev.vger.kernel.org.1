Return-Path: <netdev+bounces-55220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D1809DF2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E58281623
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1D1097A;
	Fri,  8 Dec 2023 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPzuoQm6"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE61712;
	Fri,  8 Dec 2023 00:14:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B305240006;
	Fri,  8 Dec 2023 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702023251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNpi/zPSL34A2AILSCeVZYzKaahG4aVQbHxXFOHl7us=;
	b=NPzuoQm6kvXR/VoPhuUdv5yNuJM0Vve3pRFYfIM9SThj/jhXGhqq0IDkkRv2loRg/gUDD0
	FQ68ceCavrKcAlS55WZELcguty0dSsStu+4D+/5EbBnWgmMrnLtwbBdRF5ZzFrv0GY6Cgq
	wHeA1r/5LPGre48RbaZH6s+iJoFP209UeZJ1eBCfKFjREC2wU8+hFRrEZP71JWacsRYm/6
	TeWbEOmDu4BPfLJxbyaB9RWcKsGktVGmz5rV1IpnS09YNN+T4+r4sDu3VNU7STgvYgel9D
	i4uVk9ui9qJ1I2UylkvZZxj4zoDabACcKWwZfN9nWspkHZcpSNQ6hlj2cWC9WQ==
Date: Fri, 8 Dec 2023 09:14:08 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Shenwei Wang
 <shenwei.wang@nxp.com>, Johannes Zink <j.zink@pengutronix.de>, "Russell
 King  (Oracle" <rmk+kernel@armlinux.org.uk>, Jochen Henneberg
 <jh@henneberg-systemdesign.com>, "open list:STMMAC ETHERNET DRIVER"
 <netdev@vger.kernel.org>, "moderated  list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, James Li <James.Li1@synopsys.com>, Martin
 McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Message-ID: <20231208091408.071680db@device.home>
In-Reply-To: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
References: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Fri, 8 Dec 2023 07:02:19 +0000
Jiangfeng Ma <Jiangfeng.Ma@synopsys.com> wrote:

> In order to setup xpcs, has_xpcs must be set to a non-zero value.
> Add new optional devicetree properties representing this.
> 
> If has_xpcs is set to true, then xpcs_an_inband should preferably be
> consistent with it, Otherwise, some errors may occur when starting
> the network, For example, the phy interface that xpcs already supports,
> but link up fails.

Can you elaborate on why you need this, and on which platform
especially ? Usually drivers for the various stmmac variants know if
they have XPCS or not, or can guess it based on some info such as the
configured PHY mode (dwmac-intel).

Besides that, there are a few issues with your submission. If DT is the
way to go (and I don't say it is), you would also need to update the
bindings to document that property.

> The types of has_xpcs and xpcs_an_inband are unsigned int,
> and generally used as flags. So it may be more reasonable to set them to
> bool type. This can also be confirmed from the type of @ovr_an_inband.

And this part would go into a separate patch.

Thanks,

Maxime

