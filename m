Return-Path: <netdev+bounces-207992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3CB09335
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB493B16F0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B72FA638;
	Thu, 17 Jul 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OBiT+uH9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732E1E1DE9;
	Thu, 17 Jul 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773420; cv=none; b=PWMLCB4cPeD/c++muI3N/aefYGnyo4CuzZW6kBfSzGEsWfUjeumSZf58dpbqiB+/klszWfIDJqrZ6iTIX0K/jCqI/0Cq0MADQxTozJIIeCuFVeCEEKFwtTQSadKcV8TY+nNyRuBSvvP7BJw8yo6Hw14g2NpixSBM6bug8J41o2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773420; c=relaxed/simple;
	bh=UerManGgtELtM2J88n+DiWg2YWAjMOuHu8daAdvjOrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqYK/qwci7PJMhCGbP/o97KJtpqjBA+fSulMVwCoBwsR3TlY7nOIQ4azrlj77QlbN2FaZJzoeU6A1KmjMBDLla/ZbB6flJVmQRR+G2m1DvLqMcsiSvbtRF56FoUMeqEfxOLTKSAhKNF2xdOD3s6XQnEBdqm2CrrT98cmdWHJwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OBiT+uH9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nYpSzj4evXjvFbftiLWrnsC5l75ywYOdqG1UqGqr6bU=; b=OBiT+uH9MqG6iunp7Xp895LSqE
	BpepnI9LWCcZ+Uup0z+CkeiTMR1F2vfIfkpR2SaeUzo8RjB47ow7CqUWT4jDoBc9pM1YGdEcBRGp4
	Wxc2S1OKL5iVRbe3BMVhkF62L6NGUrb9sT5oWuxLpfyIw73rmEhfRiF/vhfVwvVXFTRkeL1z5087o
	BlOL7kqRFlB/rfwf6Fb2rlzvJCx/N7Hxyq9rA9gLE3CXJfeCY428nC69UC+ZMXonFG1zVz0SuNftK
	mxb7ouz3tJOnU8OnE+ZZ8NAosNUcNPGbeC9o0Q3PZg6JjvrBjNrg9s6quay2FDk3jT0J6AK8IKVNH
	88hkamxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ucSQg-0001Yk-2p;
	Thu, 17 Jul 2025 18:29:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ucSQb-0002JW-2M;
	Thu, 17 Jul 2025 18:29:53 +0100
Date: Thu, 17 Jul 2025 18:29:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Divya.Koppera@microchip.com
Subject: Re: [PATCH net-next v1 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <aHkzEalj6tjhQX8N@shell.armlinux.org.uk>
References: <20250717103702.2112988-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717103702.2112988-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 17, 2025 at 12:37:02PM +0200, Oleksij Rempel wrote:
> +Changing the Settings
> +---------------------
> +Use `ethtool -A <interface>` to change the settings.
> +
> +.. code-block:: bash
> +
> +  # Enable RX and TX pause, with autonegotiation
> +  ethtool -A eth0 autoneg on rx on tx on
> +
> +  # Force RX pause on, TX pause off, without autonegotiation
> +  ethtool -A eth0 autoneg off rx on tx off
> +
> +**Key Configuration Concepts**:
> +
> +* **Autonegotiation Mode**: The recommended mode. The driver programs the PHY
> +    to *advertise* the `rx` and `tx` capabilities. The final active state is
> +    determined by what both sides of the link agree on.

I'm not sure one cal call this "recommended mode", because it doesn't.
If one specifies tx=0 rx=1, one would expect that the "recommend mode"
would be tx=0 and rx=1, but if the link partner supports symmetric
pause, you actually end up with tx=1 and rx=1. If the link partner
supports only asymmetric, then you end up with tx=0 rx=1 as requested.

Perversely, if you specify tx=1 rx=1, then if the remote supports only
asymmetric, you end up with everything disabled. Only tx=1 rx=1 is
supported in this configuration, you can't end up with anything else.

Basically, I don't think calling it "recommended" works.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

