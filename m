Return-Path: <netdev+bounces-194617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5762ACB597
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D18C40734C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F06230BC8;
	Mon,  2 Jun 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="blvB6/I/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D85224AF3;
	Mon,  2 Jun 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875812; cv=none; b=BnzUSMl2W9fpdsAgBBBZmxCyFGh3WOwii54YoaSCQM7Af3qfZTMkz9vZ6yZyepqath9emduErKAr57n7Knfz86TtWBINLWwdk9/yzwsVfIkK3C7Wq+cKx3B5FVNDp9pdeu5vEMuiitmP+H+YvrFdWLJEgm09y0Pr7XcqmPGYIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875812; c=relaxed/simple;
	bh=blgDM88X1jeUq6a6pKELtXM99bkI0X9VE3VgtHE0QKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY+Z80QD3Z4NWE+cvGeuTOZ0vJcpf5QWRzPpalxnxOx1JweE67kz+z+XeN0DyuFwaIhRxJOQ4Pktas16nMetwwrNR4g/vKSXJ3BxL8OnEvEGYLy/clpHknkz4RV8p1Y3Dh0J/73mbYwTQG8SXdhKSeorgXJ4biWx2sKUtgj78Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=blvB6/I/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nKqwZCXhGkjNvsE42Xwqt58Wfb5dz/M/EpxBUAE8GyY=; b=blvB6/I/05SE0PEHfhVo7BxpuS
	rrpG2PkaQk4VsIGzW6ZEs8h06tbGzNgsGCMlW2e+Yoyl4iT8BWe0xDcfbLYGqH5PRLTOudi/V2SX+
	6HNyxBgsUWxEEwrsJ7Uc1KiqxM6blWzte2eF8uZfAwLiSMWnHMO7Y8+VAAe3fqpTajZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uM6UC-00EVh1-Bo; Mon, 02 Jun 2025 16:50:00 +0200
Date: Mon, 2 Jun 2025 16:50:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to
 yaml format
Message-ID: <65f5e6e9-f02e-4374-9f17-bc833fac2316@lunn.ch>
References: <20250602141638.941747-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602141638.941747-1-Frank.Li@nxp.com>

> +examples:
> +  - |
> +    #include <dt-bindings/clock/lpc18xx-ccu.h>
> +
> +    ethernet@40010000 {
> +        compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
> +        reg = <0x40010000 0x2000>;
> +        interrupts = <5>;
> +        interrupt-names = "macirq";
> +        clocks = <&ccu1 CLK_CPU_ETHERNET>;
> +        clock-names = "stmmaceth";
> +        resets = <&rgu 22>;
> +        reset-names = "stmmaceth";
> +        phy-mode = "rgmii";

Please don't use 'rgmii' in an example, because it is 99% of the time
wrong. You are just encouraging developers to copy/paste this into
real DT blobs, and then i need to point out it is wrong. Use
'rgmii-id', which is much more likely to be correct.

	Andrew

