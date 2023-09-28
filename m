Return-Path: <netdev+bounces-36827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD67B1EA7
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7A3EE1C20A2F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9D3B7A2;
	Thu, 28 Sep 2023 13:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8C3AC3D;
	Thu, 28 Sep 2023 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C1FC433C8;
	Thu, 28 Sep 2023 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695908308;
	bh=g8ZXaIN93ZfxE2Ei93hCloVx+lzo8p+xJHZE3EoTyxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeY+yq0WZRpbvxIHDdodVZpavSilaGC0SGuJCGzimdgcDrwyAnwfIjvG4EmzVMy9p
	 z1EMiBqgmcKaiWq/o0am3uM67cTFY2oALRIcaP5s3SKfjEtFzoxfTZBnprkCQkeIW0
	 9XtS45BVAUaqF+GEI5YlLptRXEVSBHmvxSgZ0qEbAkaraft+IrUoYFvSqqycC5Zpiq
	 WkLg+aGILOrpJclpz5YkV1NxrcOqD0ilEOd4QMQWal4Qnt4XvuGM4V5U4+7Nj7zpsT
	 hR0Kctvufbs3vRS1oanzoQWtQYAp3k5YTFhbBRQcwgjNu9SmmLJK3CxHz8vfeTzewt
	 X4kJ3LY5lDi5w==
Date: Thu, 28 Sep 2023 15:38:13 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 07/15] net: phylink: centralize
 phy_interface_mode_is_8023z() && phylink_autoneg_inband() checks
Message-ID: <20230928133813.GN24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-8-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-8-vladimir.oltean@nxp.com>

On Sat, Sep 23, 2023 at 04:48:56PM +0300, Vladimir Oltean wrote:
> In a future change, we will extend the PHY interface modes for which
> phylink allows the PCS to handle autoneg. Group the existing occurences

nit: occurrences

...

