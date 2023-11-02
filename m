Return-Path: <netdev+bounces-45779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE397DF894
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4DB21240
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEA1DFEA;
	Thu,  2 Nov 2023 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZvL4PTvN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C51D559;
	Thu,  2 Nov 2023 17:19:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2314192;
	Thu,  2 Nov 2023 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZnqdhuEa2hkSKnwacO9m0gAjt2o7Z6CDrI19S7YG58o=; b=ZvL4PTvNTsYa3kTYxND6oLRNWY
	xTsYGpTYoV5+mzncfT1Gr/pNOgWlf2Cq3/n+ofzbx3rVNuvER5x/nMr7OPXWKbWoelfTcMinVY4NP
	kKbmJyM5nBVqiJv3bdqKF7FIrdJ8D7okFT8UpJPJkv/H4cNoXXKlyfGD862o/A3s2xH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qybM3-000ljH-9n; Thu, 02 Nov 2023 18:19:39 +0100
Date: Thu, 2 Nov 2023 18:19:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 2/4] net: phy: aquantia: move MMD_VEND
 define to header
Message-ID: <c441b8df-61b0-4ead-8b7e-f5715066c214@lunn.ch>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <20231102150032.10740-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102150032.10740-2-ansuelsmth@gmail.com>

On Thu, Nov 02, 2023 at 04:00:30PM +0100, Christian Marangi wrote:
> Move MMD_VEND define to header to clean things up and in preparation for
> firmware loading support that require some define placed in
> aquantia_main.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

