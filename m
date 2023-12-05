Return-Path: <netdev+bounces-53950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ECE80560D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE9B20E66
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B45D8F3;
	Tue,  5 Dec 2023 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NYxnbTgz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C0A8;
	Tue,  5 Dec 2023 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZIg9sbMuwR6Fjcsy9qQUAn4BF9GUUAaTVSpW+PW1dbg=; b=NYxnbTgz5DpZsg/ejiAa0dNxHO
	WlrRPhLtoDVC9dxCcINXQWP59L9530v8garLcxKd7zUuK+j1POEpYKRPNwExpC0PafYZdZy9gqS9j
	iY9i9XNupP3wlPKQV7FI9f3f13c7knQQhZUVRpEyQaR+S5RoOaOXl/0yKklx3bWL4kP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAVZ7-00269l-56; Tue, 05 Dec 2023 14:34:21 +0100
Date: Tue, 5 Dec 2023 14:34:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/16] net: pcs: xpcs: Drop redundant
 workqueue.h include directive
Message-ID: <5bdff6e8-40ae-4273-ad84-254bdc04433a@lunn.ch>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-3-fancer.lancer@gmail.com>

On Tue, Dec 05, 2023 at 01:35:23PM +0300, Serge Semin wrote:
> There is nothing CM workqueue-related in the driver. So the respective
> include directive can be dropped.
> 
> While at it add an empty line delimiter between the generic and local path
> include directives.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

