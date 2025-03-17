Return-Path: <netdev+bounces-175305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FFA65044
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313C116B86C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E223C8BB;
	Mon, 17 Mar 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A4E4xZ/X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F38F5E;
	Mon, 17 Mar 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216936; cv=none; b=Y0AdcVvH36XbyBrSVA6LQUVQWuGWJhz3cxp3Al/CRUM/A92pWtvZaeVI0C7O8NE1ZiWVaH740KlgRz4LcYAbfCF049Mpb9p71jowWHP96Kd8KTJR8YNzFK9Zq8WvNLmi/fwRM4v1O3RDSJEXWZq9cPOqOVSt0Q1+tJog/Kwb1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216936; c=relaxed/simple;
	bh=LG5AaX//OYah0wUsX1Pw3VQ66aM1dBeObLkx1xgpJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnt0NrYONSmCisvPlgEpBDy1crZP5ViULsx5asvtkJoJmja44u7F+YtTXRvXQnRVF6VMzWJQYIxg5A9oYESfk9d7wQ3UGdDg5GjVir1TEMr0BqrKJxdESHzsOmQCcLNlGu86eHvTh2cf1vlhZF7ylaKKazIEfArVNEdd4RW9vzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A4E4xZ/X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5KAN/TL0PYijvGqP9Y/30zrHPi/CEWhklinOLwIY8Ws=; b=A4E4xZ/XcQNU1dNttR8vxdIB3a
	G8tZgnwP5mdeK9G06uuDMoRIhp0sey4w4eB9vB4WlX3MPdCdy/vlZixCQh6m6oNGI1tolR2Wdjp+z
	OHmy/9ZTzpRQjgO8XmJB534lYIUycJTgaiVuWdhuNM9qm+LJkvTqQmcdTYW22NszkbCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuACv-0068Qc-Mz; Mon, 17 Mar 2025 14:08:41 +0100
Date: Mon, 17 Mar 2025 14:08:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 2/4] ARM: dts: ast2600-evb: add default RGMII delay
Message-ID: <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317025922.1526937-3-jacky_chou@aspeedtech.com>

> @@ -147,6 +153,9 @@ &mac2 {
>  	phy-mode = "rgmii";
>  	phy-handle = <&ethphy2>;
>  
> +	tx-internal-delay-ps = <8>;
> +	rx-internal-delay-ps = <4>;
> +

Ideally you want:

	phy-mode = "rgmii-id";
	tx-internal-delay-ps = <0>;
	rx-internal-delay-ps = <0>;

Since 'rgmii-id' correctly describes the hardware.

	Andrew

