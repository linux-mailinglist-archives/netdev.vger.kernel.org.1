Return-Path: <netdev+bounces-28576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA877FE2F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8671C213EE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87917AC2;
	Thu, 17 Aug 2023 18:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD6154B3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:53:26 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABF3ABF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W0AAxcr25Rqplh8gPmSRIiR00kMMA97VNApE2i+Jf9E=; b=MQkToE2ElQXSVwjokXkakKHUdX
	3A76OctqpFezY93Eznjs8W37bwG38A5qfpfj1sWVC54soWyWRRlaUwSZSPpBijNdBXxG036VztwDk
	eufPtUScjCI0Owe/bRzkQG4uNbf8eKLogxSJ+aKbl4+nKbKDc/t9Y0+TcLuu8e/JOkHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWi6O-004Pzv-Mf; Thu, 17 Aug 2023 20:52:12 +0200
Date: Thu, 17 Aug 2023 20:52:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
References: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817182729.q6rf327t7dfzxiow@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Andrew, I'd argue that the MAC-PHY relationship between the DSA master
> and the CPU port is equally clear as between 2 arbitrary cascade ports.
> Which is: not clear at all. The RGMII standard does not talk about the
> existence of a MAC role and a PHY role, to my knowledge.

The standard does talk about an optional in band status, placed onto
the RXD pins during the inter packet gap. For that to work, there
needs to be some notion of MAC and PHY side.

> With rx-internal-delay-ps and tx-internal-delay-ps in each MAC node, you
> get the freedom of specifying RGMII delays in whichever way is needed,
> without baking in any assumption that the port plays the role of a PHY
> or not.

I agree with you here, but these are modern inventions, as a result of
evolution over time, as we see what does and does not work well, and
as we as developers go from newbies to seasoned developers getting
better at defining consistent APIs.

	Andrew

