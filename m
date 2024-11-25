Return-Path: <netdev+bounces-147257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37D9D8C15
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A89288940
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43251B87E4;
	Mon, 25 Nov 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uJLWCbek"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288063C;
	Mon, 25 Nov 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558569; cv=none; b=TsrWg//RGkyiz+vZVTJ2szkW/6oJ77gltflFN+h+qHbP/mLCKfLNdgW0/kvuM1WnE7vMtTedVRT73otWj+sgHHcCd0YBImFRRfZzcqsTcvt0JYa3KR90GdkxTBikPOjG5Zdp0KbQe8B4rOCZ0WP7ZxKzMZAWj4c9FbJfIMiKkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558569; c=relaxed/simple;
	bh=oiq1zrNM7MPah04xqeO0vB5cKM+NE7Jf6VS+nMsCj7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDFgt4mgLiqotYdKX6/Y32JMZlDm3Axhch8EZ8pmoh/E5HhLr2pBIFF5oh2WcyZEP+CpPbuJqabiCqRCaYKi8wM5XUTPiVQxSEVca8X5qcdcfMIBdaRORPbEBdSI6niWnhiRDNK/qn1dcMivuszUofVHYOCekA2G4+eWuy7dXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uJLWCbek; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qGdhb61ltiN5zkSj8z5rn1OCVWx5MPUP99AQrJmD3bo=; b=uJLWCbekA3nma5sKI3Z2hdpVxV
	na0iTLHeWUiNelhI7CCh66R2r09U/TXPoLOojWt1TvpwCObZxwbhQuEMILXlaIc1wE/fpXnwzcK0V
	RNADZTbKWsNiERZcFhhnO3y8Axma7JR7vXzV8JTv9ZZUq8D/Sv8JCMUEBRdqvfGBfRoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFdcy-00EPwf-NY; Mon, 25 Nov 2024 19:16:04 +0100
Date: Mon, 25 Nov 2024 19:16:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] arm64: dts: agilex5: initial support for Arrow
 AXE5-Eagle
Message-ID: <062e1d60-29a0-4e92-8c78-e961b130166b@lunn.ch>
References: <20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de>
 <20241125-v6-12-topic-socfpga-agilex5-v2-4-864256ecc7b2@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-v6-12-topic-socfpga-agilex5-v2-4-864256ecc7b2@pengutronix.de>

On Mon, Nov 25, 2024 at 11:33:23AM +0100, Steffen Trumtrar wrote:
> The Arrow AXE5-Eagle is an Intel Agilex5 SoCFPGA based board with:
> 
>    - 1x PCIe Gen4.0 edge connector
>    - 4-port USB HUB
>    - 2x 1Gb Ethernet


> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&emac2_phy0>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		emac2_phy0: ethernet-phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};

It might be hiding somewhere, but i only see one Ethernet interface
here? Where is the second one?

	Andrew

