Return-Path: <netdev+bounces-40738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A87C88E4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE34281392
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B461BDCF;
	Fri, 13 Oct 2023 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="51TazhTg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D219BB2;
	Fri, 13 Oct 2023 15:40:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7BB7;
	Fri, 13 Oct 2023 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AfBFoBaUMyUga0dX/cinZPk6S2n8duwEaG/WLcvim9s=; b=51
	TazhTgjAYk9QxOl2q//WchftDn7G9zs/Aw6T9S6HyofI/H6dnmz2lkFOQYo3xq0VMKxpDKQBeFMBS
	8yh6vhKZqp/9UU8NcRuVD4ATjUuXiEqUoB7iOTrfXkhdGucviCJYYf7ehzFXfce4BviInU9nn/G+C
	7BZCI5ODGUDWvHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrKHB-0026de-TM; Fri, 13 Oct 2023 17:40:33 +0200
Date: Fri, 13 Oct 2023 17:40:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Message-ID: <7dd3839a-73da-4fa2-8f0f-e9384a2f0541@lunn.ch>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
 <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
 <CACRpkdYocdsrsydHwe_FF--6g-Y_YwxHXF6GUTe3wRY0suSCCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYocdsrsydHwe_FF--6g-Y_YwxHXF6GUTe3wRY0suSCCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 03:04:10PM +0200, Linus Walleij wrote:
> Hi Andrew,
> 
> thanks for reviewing!
> 
> On Fri, Oct 13, 2023 at 2:43 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - marvell,mv88e6060
> >
> > The 6060 is a separate driver. Its not part of mv88e6xxx. So it should
> > have a binding document of its own.
> 
> It really doesn't matter to the DT bindings.
> It is not the job of DT to reflect the state of Linux.
> 
> In another operating system they might all be the same driver.
> Or all four variants have their own driver.
> 
> If the hardware is distinctly different so a lot of the properties
> are unique then it may be warranted with a separate DT
> binding, for the sake of keeping bindings simpler and
> coherent.

What i want to avoid is giving the impression that the mv88e6060
implements something when in fact it does not. That device does not
have the interrupt controller, so all the interrupt properties are
invalid for it. The hardware does not allow access to the EEPROM, so
the EEPROM length property is not valid, etc.

If you do want to make it part of the binding, it would be good to add
constraints based on the compatible to indicate which properties are
actually valid for the hardware.

The 88e6060 actually has an open datasheet.

https://www.insidegadgets.com/wp-content/uploads/2014/07/88E6060.pdf

	 Andrew

