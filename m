Return-Path: <netdev+bounces-55078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A918094B4
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8994280E05
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39B5639B;
	Thu,  7 Dec 2023 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W0la2bgT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD56A7E;
	Thu,  7 Dec 2023 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8OvmBG1BbR/bHyNih1YR4dH1zldxx7EatEh9gKyCn3k=; b=W0la2bgTJsrmJjTtn/9/EBX5W1
	G5mWQDTF2TQkuG9W0WswYE6as9kBIlUYP1DiJ7vdkqBMFMFlI70X2zViRx1u+34aMaQdR7zD2kJU5
	lWgBhSiW28BFCD6A2Z3txUSGyw9yjASO3Oc+U2SvpWhFrnkDUnIr403116fEideov2oc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rBLwt-002MAB-2H; Thu, 07 Dec 2023 22:30:23 +0100
Date: Thu, 7 Dec 2023 22:30:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>

On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
> The stmmac_dt_phy() function, which parses the devicetree node of the
> MAC and ultimately causes MDIO bus allocation, misinterprets what
> fixed-link means in relation to the MAC's MDIO bus. This results in
> a MDIO bus being created in situations it need not be.

Please extend that with something like....

This is bad, because ....

Most 'clean' driver unconditionally create the MDIO bus. But stmmac is
not that clean, and has to keep backwards compatibility to some old
usage. I'm just wondering what this patch actually brings us, and is
it worth it. Is it fixing a real bug, or just an optimisation?

   Andrew

