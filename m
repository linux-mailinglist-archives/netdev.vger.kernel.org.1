Return-Path: <netdev+bounces-47838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552C7EB8F0
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD962812B9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C133077;
	Tue, 14 Nov 2023 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xzCJqJbk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAA33072;
	Tue, 14 Nov 2023 21:50:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40966C9;
	Tue, 14 Nov 2023 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dyj12d9JUwarSFi32r69krZSdxAS2fBoSBW7chw1xuM=; b=xzCJqJbkFe2z7NeM7a7ymMtDBm
	jT5Jk9dGhIDAY0qEyglxvv8YPYKhTNIY1xb4/CN0gEi+XZM/RpXyvZ8Dp0ul9wvkP7+zeZgTGaawr
	A90Q70hTt8coE4KGeWwCEVPjifkO0uixEnmh3psVQSfFS2Lrf6myGfbVsrS3GO5XgAac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r31IY-000CBm-KV; Tue, 14 Nov 2023 22:50:18 +0100
Date: Tue, 14 Nov 2023 22:50:18 +0100
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
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>

On Tue, Nov 14, 2023 at 12:35:55AM +0100, Linus Walleij wrote:
> The Marvell switches are lacking DT bindings.
> 
> I need proper schema checking to add LED support to the
> Marvell switch. Just how it is, it can't go on like this.
> 
> Some Device Tree fixes are included in the series, these
> remove the major and most annoying warnings fallout noise:
> some warnings remain, and these are of more serious nature,
> such as missing phy-mode. They can be applied individually,
> or to the networking tree with the rest of the patches.
> 
> Thanks to Andrew Lunn, Vladimir Oltean and Russell King
> for excellent review and feedback!
> 
> This latest version employs special compatibles in the
> odd ABI device trees.

So i have one open question. How do we merge this?

Can we just take it all through the DT tree?

    Andrew

