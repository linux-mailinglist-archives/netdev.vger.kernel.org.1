Return-Path: <netdev+bounces-52627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DFE7FF829
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62955281706
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B556751;
	Thu, 30 Nov 2023 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tCGiikmX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECE133;
	Thu, 30 Nov 2023 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8uE72B/ZbsCd2fU3mnrHk7yTs0g881UEt43C00CniGU=; b=tCGiikmXA1Toh2xAc4IbKCLf23
	UU8yrlZ7y2ehr8c63qU+z3aBbCS+vKCCKn5pG23ZCFb6gk/utmM3MD64mtt9c+xZNnuI+jbn0d62g
	i3cJVrgHAMFwgDhwJf6CGxi1i9/XjHsGsXyjIH50HhMJCNaxn0h4RKPWHaPDMyeVTFEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8knl-001giW-Mj; Thu, 30 Nov 2023 18:26:13 +0100
Date: Thu, 30 Nov 2023 18:26:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
	edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
	linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
	openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
	devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
	robh+dt@kernel.org, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
	venture@google.com, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
 <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
 <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
 <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
 <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>

> I will check with the xpcs maintainer how can we add indirect access
> to the xpcs module.

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c#L449

It creates a regmap for the memory range. On top of that it creates an
MDIO bus. You can then access the PCS in the normal way.

	Andrew

