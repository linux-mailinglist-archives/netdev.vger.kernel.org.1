Return-Path: <netdev+bounces-55965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17C80CFDF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EA1F21883
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5B4BAB6;
	Mon, 11 Dec 2023 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mRoIDbTS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F00BD;
	Mon, 11 Dec 2023 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mpoCLQXUg7bSdwQ8Is9a4sXx0Z59ozaHcPkcmMjnjxU=; b=mRoIDbTSG//lHN9jLp0j+Lny17
	koOqFVmM75/5ks3+8OH//lzhThYciWIVXFOjPPGSZ0e3Q3vmNxl8mpQ8WirT6SdlUsF38cLXiNQpG
	uCUvz7r3AzulfwKg+QqotYSMMiUcnHD3pZy7+nG2ZfpFPaaWULqxWR58+tWKh7tjRtSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCiRy-002dPp-5x; Mon, 11 Dec 2023 16:44:06 +0100
Date: Mon, 11 Dec 2023 16:44:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Message-ID: <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209014828.28194-1-ansuelsmth@gmail.com>

> +properties:
> +  qca,led-active-high:
> +    description: Set all the LEDs to active high to be turned on.
> +    type: boolean

I would of expected active high is the default. An active low property
would make more sense. It should also be a generic property, not a
vendor property. As such, we either want the phylib core to parse it,
or the LED core.

       Andrew

