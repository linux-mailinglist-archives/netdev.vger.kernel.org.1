Return-Path: <netdev+bounces-42571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA57CF5F8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BA9281EE6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A718030;
	Thu, 19 Oct 2023 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yjNTR+n0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5315EBC;
	Thu, 19 Oct 2023 10:59:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06491FA;
	Thu, 19 Oct 2023 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cf859ebt0ewaGtDbT4sxjszMRDJycfB2RkTOVDIgT/A=; b=yjNTR+n0VMmzANcFR8PZDFW/Wb
	nDGK2xPEigtmqg5cG10EeTva4w3+KOltWZ5shLvxoMksU8hQ50AXAHCXBddeFYmd6H6ToNRvAnIBu
	vFlK5IMZk3IIVRvW3aw3L371JhinyczYKbQlMHJvSt/G3HGejeQwER1CFcoEV4dYQxLT3C81tcA4z
	PPvCVaH8Y5uftDVUy55Vlhs3kNP2at95dR2NPs5w2azVqs2Z+dFASd7NzzPH+dYmMdh8vkSr+IYAo
	0QRRoDMs0r2IH7iA5Whp7nLbBAtQj0X+UIYa9X0iCmCqf94hSlg7NpphljBIDR0MK3qARo5oNQGoB
	MxYecZRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtQjp-0006ps-1T;
	Thu, 19 Oct 2023 11:58:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtQjp-0000Nb-5G; Thu, 19 Oct 2023 11:58:49 +0100
Date: Thu, 19 Oct 2023 11:58:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <ZTEL6Yw+Xcc0E4TJ@shell.armlinux.org.uk>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 18, 2023 at 01:11:45PM +0200, Linus Walleij wrote:
> On Wed, Oct 18, 2023 at 12:32 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> 
> > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > a DSA switch node need to have a ports or ethernet-ports
> > > subnode, and that is actually required, so add requirements
> > > using oneOf.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> 
> Really?
> 
> +  oneOf:
> +    - required:
> +      - ports
> +    - required:
> +      - ethernet-ports
> 
> Two spaces after the oneOf, 2 spaces after a required as usual.
> I don't get it.

Given the other python errors spat out in Rob's report, I would suggest
that the "bot" is running a development version that hasn't been fully
tested, so anything it spits out is suspect. Maybe Rob can comment on
the validity of the warnings in the report.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

