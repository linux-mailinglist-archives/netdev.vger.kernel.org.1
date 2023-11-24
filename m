Return-Path: <netdev+bounces-50977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BC7F86AC
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 00:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37B282337
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C873C49D;
	Fri, 24 Nov 2023 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uGtbsMYs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E91990;
	Fri, 24 Nov 2023 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZEmM+x5c4j9E2iYripoWJxHgYv7R98NUEa31meAyb3E=; b=uGtbsMYszf8pdWOAfR2MhpRlqV
	24g92f2VFULf7WTq8BWo5l/3XruHQvZr13mP5OFmGelaM3YxeSSS2yBBygiKA74EJKa+qbEbmA040
	u+t3KbeEDYIYMnJpUxJM0BZ6o/TFnIExVIRCdKpQOVZq3vDeASDU6zGVIgO/6OMynBis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6fYP-0018wU-SA; Sat, 25 Nov 2023 00:25:45 +0100
Date: Sat, 25 Nov 2023 00:25:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Javier Carrasco <javier.carrasco@wolfvision.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Message-ID: <42c5c174-e7f2-4323-8db0-0db1ede39ec5@lunn.ch>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
 <20231123-operable-frustrate-6c71ab0dafbf@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-operable-frustrate-6c71ab0dafbf@spud>

On Thu, Nov 23, 2023 at 05:20:48PM +0000, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 01:14:13PM +0100, Javier Carrasco wrote:
> > This property defines if PHY WOL is preferred. If it is not defined, MAC
> > WOL will be preferred instead.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> > ---
> >  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > index 70bbc4220e2a..fc4b02a5a375 100644
> > --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > @@ -91,6 +91,12 @@ properties:
> >        The phandle of the syscon node for the peripheral general register file.
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >  
> > +  rockchip,phy-wol:
> > +    type: boolean
> > +    description:
> > +      If present, indicates that PHY WOL is preferred. MAC WOL is preferred
> > +      otherwise.
> 
> Although I suspect this isn't, it sounds like software policy. What
> attribute of the hardware determines which is preferred?

I tend to agree, its a software policy. Doing WoL in the PHY should be
the preferred solution, because it allows the MAC to be powered off,
saving more power. If the PHY does not implement it, then the MAC
should be used.

It should be possible for the MAC driver to pass the WoL settings to
the PHY, and if it returns EOPNOTSUPP, or maybe EINVAL, implement the
WoL in the MAC.

This might be a behaviour change, depending on the MAC driver. So i
could imaging a less risk tolerant developers wanting a knob to enable
this. However, if done correctly, using the PHY instead of the MAC
should not be visible from the users perspective.

    Andrew

