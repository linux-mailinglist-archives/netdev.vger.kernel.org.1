Return-Path: <netdev+bounces-232935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515BC09FC9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119A63AEBFA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E402F12D6;
	Sat, 25 Oct 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bjg6aMuT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B79280033;
	Sat, 25 Oct 2025 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425181; cv=none; b=Q4qZtKO6SfQv4MLaQ8CyK/1wM4N5Y7DzZF53OUQlhDJSgUCt9QfDTRon6MtikL4RvKfAdaxktpAFQquoMhYV7pm16SxSA9FR5xlgXTf7NGY4E3ALA6z3wkCFSqt5ZXdKJLWwFfEEJzHSLVBYkRT5cwWBSDqyPiZp1IoypQ3QY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425181; c=relaxed/simple;
	bh=b5MeFWazwr56LQLRwY3moBEi821dzMS3YUDc0jgPLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFSKQlK713yb8ECmfuDGjK8k8CrmsT8D09CW4Fk5/RfDVpQS/Q5TkIeqr7kPJI/r8ZVCduxjwdUccWl4DL579snjaZix8DBrmOXL6TwSPryUKF3ivfCOL/Ks+aNZ+brCPuT+SMt874BEOCdhetCCDo1T+FF771M1eE3tuT9kucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bjg6aMuT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WJV8yCBpczm8KIDTOsvfMxoNj/9nD30O6hwUymk/qO0=; b=bjg6aMuTvmwxlWyrdPML/qAeGw
	dDzzD5bjnPn2Lbo3fD7YfqscLtqAIJpy6tfD/0TjfwWfugJ7Lop70enTP+lIIWHVzw+GgmlcNHtBb
	Bdrkg7aXs/Q2bxy5zP8wZ0bkPkqO5wD8GlUZVTKbPvzVlJbfke/bx8To+qFO/IyjySxbVepFWwPxn
	1zCv6rgZT5YugM4iktbfuVI1mBLDSXSgyFDK1kWBe8dSH7DtMh7OgePawMCRkQVHYdTdwRTaVqIyu
	yCIh3tuGe8R4dFb9ONUL5cWlbckvDJA/kA9mZDb3nr0dGmnKOdP5ymYwH/XFY2GJ3aj0S9ny26c4b
	Z92vdDDQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38512)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCl9K-000000000Ok-3bSV;
	Sat, 25 Oct 2025 21:46:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCl9J-0000000040n-06JH;
	Sat, 25 Oct 2025 21:46:05 +0100
Date: Sat, 25 Oct 2025 21:46:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 13/13] net: dsa: add driver for MaxLinear GSW1xx
 switch family
Message-ID: <aP03DEZMHOv0NQoj@shell.armlinux.org.uk>
References: <cover.1761324950.git.daniel@makrotopia.org>
 <4216aee3e5cbb20b31fe22c711efc38ea73df880.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4216aee3e5cbb20b31fe22c711efc38ea73df880.1761324950.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 06:05:00PM +0100, Daniel Golle wrote:
> Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
> are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
> and Intel GRX MIPS router SoCs. The main difference is that instead of
> using memory-mapped I/O to communicate with the host CPU these ICs are
> connected via MDIO (or SPI, which isn't supported by this driver).
> Implement the regmap API to access the switch registers over MDIO to allow
> reusing lantiq_gswip_common for all core functionality.
> 
> The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
> 2500Base-X, which can either be used to connect an external PHY or SFP
> cage, or as the CPU port. Support for the SerDes interface is implemented
> in this driver using the phylink_pcs interface.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Not sure what version I reviewed, but please see that other version for
my review comments on this patch.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

