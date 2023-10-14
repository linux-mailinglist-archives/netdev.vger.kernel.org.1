Return-Path: <netdev+bounces-41048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FCD7C9704
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE51C20940
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C19266BF;
	Sat, 14 Oct 2023 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QvuQcIc1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696C12B88;
	Sat, 14 Oct 2023 22:22:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560CC9;
	Sat, 14 Oct 2023 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j8p9j1S38FRPhzmC1Di4Z+HHROrpeO2BiZNa/wBqDmE=; b=QvuQcIc1PqMX3ys2I/I3gR7Mzg
	1uQFFA9Y7ewif9caniCqVqX+2T7RVEPI1rqetSWwTxH77olzi1EcBGIfG8r5GF8dEGDekyx2wveqQ
	D6Y7A+GN+CZ2FKlWtmCoFvRXwvbUgLXFlVG1mR61TxlHktT3+JjVzb+ChzTfW6DoRA6w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrn1n-002Cvy-4y; Sun, 15 Oct 2023 00:22:35 +0200
Date: Sun, 15 Oct 2023 00:22:35 +0200
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
Subject: Re: [PATCH net-next v2 2/5] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
Message-ID: <4b5b09ab-f5f3-4c61-9ef6-39fbead126bd@lunn.ch>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
 <20231014-marvell-88e6152-wan-led-v2-2-7fca08b68849@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-2-7fca08b68849@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +                port@5 {
> +                    reg = <5>;
> +                    phy-mode = "rgmii-id";

It is a Fast Ethernet switch, so it will not be using Reduced Gigabit
MII. 'rev-mii' would be a better choice.

> +                    ethernet = <&ethc>;
> +                    label = "cpu";

label = "cpu" is deprecated, so you probably don't want it in an
example.


    Andrew

---
pw-bot: cr

