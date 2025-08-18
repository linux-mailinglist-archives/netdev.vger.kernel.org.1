Return-Path: <netdev+bounces-214696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62FB2AE94
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3D56564A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385E33EAE6;
	Mon, 18 Aug 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BuaHtJtK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CB1581EE;
	Mon, 18 Aug 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536125; cv=none; b=Zi6W1k4c2Yo+/P83JaVSHJxgggkCoP5iKkJ5L4RULOJA/EGXSgrYYQy+W8Khef/vE8eEPTSwWxZ6ISFhpn9m+YsNtP2nFf9FUj8CxEcdZZyUOZmGoZ0CH6/QI3fX1RvNGHnatjv1yIRPlzAziurjP9hgB0w78wA4lrhkbWRNQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536125; c=relaxed/simple;
	bh=g4CIE3yRi37sTgTwAwcHt2iySMTeRTXJa+ahuYCtcgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwSN2VE7NQnxv3ynKq9DV2I8ZJjkWGXOu5x/RoH8ffhD9/Wz4/gacy1GhiNZL6Ud8Z1XgPXohbm084f7dcoB1gQXZN1P/P4OSIttErH6wu12qEZYHB6q7mAsMbe8HfPfl8SMFoxJA9+urXowui3vsa6sYPo/jWC7CnSlbwXcATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BuaHtJtK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QnKxa06RRJ+jhOD5mej1Uo0AmcaFzK3gAg2IgogA8nA=; b=BuaHtJtKwkpSVs+iLrjnAgeJ7O
	5wC3MHN5ZiBeBMxakDs1ESkotR2+U8lLXVfeKonj2SlFKfZtQYjjQuS5AGiz5Z+6EjJ/aTVN4qxGT
	Y5LHvARE5CfCzuYOIMSF25jDTL1olqtjRLgTUzkXdvcB8l0eswi2QsykuQS4sVW8ruqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo38d-0055Cu-Up; Mon, 18 Aug 2025 18:55:15 +0200
Date: Mon, 18 Aug 2025 18:55:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <7c4bc4cc-61d5-40ce-b0d5-c47072ee2f16@lunn.ch>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
 <20250818162445.1317670-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818162445.1317670-2-mmyangfl@gmail.com>

> +  motorcomm,switch-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value selected by Pin SWITCH_ID_1 / SWITCH_ID_0.
> +
> +      Up to 4 chips can share the same MII port ('reg' in DT) by giving
> +      different SWITCH_ID values. The default value should work if only one chip
> +      is present.
> +    enum: [0, 1, 2, 3]
> +    default: 0

It is like getting blood from a stone.

So what you are saying is that you have:

    mdio {
        #address-cells = <1>;
        #size-cells = <0>;

        switch@1d {
            compatible = "motorcomm,yt9215";
            /* default 0x1d, alternate 0x0 */
            reg = <0x1d>;
            motorcomm,switch-id = <0>;
            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
...
	}

        switch@1d {
            compatible = "motorcomm,yt9215";
            reg = <0x1d>;
            motorcomm,switch-id = <1>;
            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
...
	}

        switch@1d {
            compatible = "motorcomm,yt9215";
            reg = <0x1d>;
            motorcomm,switch-id = <2>;
            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
...
	}
    }

Have you tested this? My _guess_ is, it does not work.

I'm not even sure DT allows you to have the same reg multiple times on
one bus.

I'm pretty sure the MDIO core does not allow multiple devices on one
MDIO address. Each device is represented by a struct
mdio_device. struct mii_bus has an array of 32 of these, one per
address on the bus. You cannot have 4 of them for one address.

    Andrew

---
pw-bot: cr

