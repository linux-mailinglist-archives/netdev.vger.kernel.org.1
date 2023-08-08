Return-Path: <netdev+bounces-25461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FE77435A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D8D1C20E85
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C615481;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93514F7C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A861B2F;
	Tue,  8 Aug 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1eMz8Kx1EHbpbcwhOQKyLVqRjaGKTaNj4sW/uynWnl8=; b=nejMPi3VM7ofMENIN8bhAEJL07
	R1JLkq+Z0e+Vvd3amNjdds5KLa/IkvIBpX/KZhrsGzbSHj/Jpm8DHhBojZxbdLdU2XbGa8Ca9S0Cs
	WFv1W+lkAfog6/kxtpgQlcebGAxCSMz4Gni1CCitszWFXF4f8IxW2G0nJ4D4I9d5w4tw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTNeM-003TSm-VY; Tue, 08 Aug 2023 16:25:30 +0200
Date: Tue, 8 Aug 2023 16:25:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > > Ok so upon some further investigation, the actual culprit is in stmmac
> > > platform code - it always tries to register an MDIO bus - independent
> > > of whether there is an actual mdio child node - unless the MAC is
> > > marked explicitly as having a fixed-link.
> > >
> > > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > > created the MDIO bus.
> > >
> > > Even so, isn't it useful to actually reference the shared MDIO bus in some way?
> > >
> > > If the schematics look something like this:
> > >
> > > --------           -------
> > > | MAC0 |--MDIO-----| PHY |
> > > -------- |     |   -------
> > >          |     |
> > > -------- |     |   -------
> > > | MAC1 |--     ----| PHY |
> > > --------           -------
> > >
> > > Then it would make sense to model it on the device tree?
> >
> > So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> > masters, and the hardware designer decided to tie both together to
> > a single set of clock and data lines, which then go to two PHYs.
> 
> The schematics I have are not very clear on that, but now that you
> mention this, it's most likely the case.

I hope not. That would be very broken. As Russell pointed out, MDIO is
not multi-master. You need to check with the hardware designer if the
schematics are not clear.

> Good point, but it's worse than that: when MAC0 is unbound, it will
> unregister the MDIO bus and destroy all PHY devices. These are not
> refcounted so they will literally go from under MAC1. Not sure how
> this can be dealt with?

unbinding is not a normal operation. So i would just live with it, and
if root decides to shoot herself in the foot, that is her choice.

   Andrew

