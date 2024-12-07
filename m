Return-Path: <netdev+bounces-149917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300709E81F0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193A5164EE8
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F3154BF5;
	Sat,  7 Dec 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Poap3r8c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BD34CC4;
	Sat,  7 Dec 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603192; cv=none; b=i3ishPLItsekz8+KbrdFsp8ppynUleCyPo/1V8nJWpXL3pGnwwrjH4fdLHkFdsCKkJRDKhadHHZkHSkhcqRYR7gS4JQ2K0p91hHM6oSGBqnoaSmXQRW3ZBleQ+CbRweI3Qr/TScqe8lpHFdjm6WZBN6kBPNFaq4OtI5Dfk40zAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603192; c=relaxed/simple;
	bh=uUbianTua1fqJ3xsTd9AIf0EsuQrYK4M6Llw6yFInFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF7Eu00VULn2bKc9zJY73J16Uvs6kaLYyYQXsQlZWrojIrGEjTLLeDqVBaVWa2BdGB50SENA+KMwp7IL5VlXkhMb4vZME+NnRVYmUvCTj1dRXy4T6lv48BRF/h4ExxGa4vgXCWL1C1iy16BjQlsJw3XZbz2/QQBfjboDFtWoiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Poap3r8c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=39pDgSNiUk/hOnbnaEPvFVAZbZyU2gLC1/FdQLOqz98=; b=Poap3r8cL36LdEf/kxUIjmPFEK
	+ENesw96BbTmgqtLpseJlLdjdKhMmrH6YEKBKwIrnpBjDCBfIsv4Zp0k6+TA9Tu+T7lwvoLaTDpRs
	2v2vfywg8fsbSbAOtdwOwWYXo0LAPwlzKUoes7+/mnEuHUE87wyW51E7QSe8mWT7JYrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK1Nj-00FVHZ-L9; Sat, 07 Dec 2024 21:26:27 +0100
Date: Sat, 7 Dec 2024 21:26:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: agilex5: initial support for Arrow
 AXE5-Eagle
Message-ID: <4ba6d338-9910-487e-8b98-1f576f9f0366@lunn.ch>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
 <20241205-v6-12-topic-socfpga-agilex5-v3-6-2a8cdf73f50a@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-6-2a8cdf73f50a@pengutronix.de>

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


No gmac1?

	Andrew

