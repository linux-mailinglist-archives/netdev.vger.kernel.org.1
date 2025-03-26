Return-Path: <netdev+bounces-177757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E4A719F5
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6C93A7432
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9371F3FD9;
	Wed, 26 Mar 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xyqwX3TB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E241E1E0D;
	Wed, 26 Mar 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001728; cv=none; b=Vu9NNOpVjkA4nmDki/yvzxxwkQkNvfk8f1nXTgE5FMbP/kdv7RLHn98G8TbvQDMv+xUqQadcx1BT3y9Xqqr1nQmTekRfIeMpCHVFV6V+dl6lp7KZVGWpohns15ZNZVQPbebo/vyQmq8K4qHWcDyCg3UJSVd3P1mCm8n15MkPCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001728; c=relaxed/simple;
	bh=CHkqnUvrtLsFezrVMwwo4qYDC+JUI87LyJDWlJUV8ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8aJgMnpQ0vJFmhtSXl7d+sdd2+wDGTR4kQpXzbmCn9SwaNKoD9rj71d+173NSmDQm8cVlU0JMsMES2IPgUItCU9QMfpaPps33TZ4ARYx5bkGxTIIqVSUorVxKhTjQfbJxaljKrPibKl2DYvDtX1UoADBRmPfzK3T67AhicZWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xyqwX3TB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UqUtYBbcRdDSWcUuI/754310LPMeZW/3OppMxjMcxEA=; b=xyqwX3TBP+eR63VG9lQiYwWpuG
	ZDzE+l6RxoVJaxqkPzyFKgaGlN2ke8txJWcWpmmySsZgCVE6vmiw4N4vRthd0g+CZAFGTlgN+S+Or
	VACAdtMrOIjqLMFrP5vCrpAA9a9K9a0DIzf1H1Tkbr8/wKXVVdwTpbsuzEO9RWMMdJK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txSMp-007BJQ-CI; Wed, 26 Mar 2025 16:08:31 +0100
Date: Wed, 26 Mar 2025 16:08:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] dt-bindings: net: Document support
 for Aeonsemi PHYs
Message-ID: <77a366f8-0b58-4e1f-9020-b57f7c90b3bb@lunn.ch>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326002404.25530-4-ansuelsmth@gmail.com>

> +  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
> +  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.

> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id7500.9410
> +          - ethernet-phy-id7500.9402
> +          - ethernet-phy-id7500.9412
> +          - ethernet-phy-id7500.9422
> +          - ethernet-phy-id7500.9432
> +          - ethernet-phy-id7500.9442
> +          - ethernet-phy-id7500.9452
> +          - ethernet-phy-id7500.9462
> +          - ethernet-phy-id7500.9472
> +          - ethernet-phy-id7500.9482
> +          - ethernet-phy-id7500.9492

> +        ethernet-phy@1f {
> +            compatible = "ethernet-phy-id7500.9410",
> +                         "ethernet-phy-ieee802.3-c45";

You need to be careful here. And fully understand what this means.  In
general, you don't list a compatible here, or only
ethernet-phy-ieee802.3-c45. This is because the bus can be enumerated,
you can get the ID from the device. What is in the device is more
likely to be correct than whatever the DT author put here. However,
you can state a compatible with an ID, and when you do that, it means
the PHY device ID in the silicon is broken, ignore it, probe based on
the value here.  So if you state ethernet-phy-id7500.9410, it does not
matter if there is firmware or not in the PHY, what ID the PHY has, it
will get probed as a ethernet-phy-id7500.9410.

Except, if there is a .match_phy_device in the driver ops. If there is
a .match_phy_device the driver does whatever it wants to try to
identify the device and perform a match.

	Andrew

