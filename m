Return-Path: <netdev+bounces-140383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8669B645F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE9F1F231C4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4E1EABDA;
	Wed, 30 Oct 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HkDSIqJ5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230D1EABBE;
	Wed, 30 Oct 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295686; cv=none; b=Mj16zx0YkhVwKISZfPcLtIBCk5FoVrjAYTR7/7il7zENvh8WkykA7hgoLNRouUsD/uZluAe+k0asvAacolm+EaEbQtg4X4LVtL1PI0YustJIR+/zNqGcoqS6FSoPZV77GCd4gaKd+hTn+3qunBqf0bMmrbsy88kYb9NP8VQw7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295686; c=relaxed/simple;
	bh=js8OWuVfc+6P59q7r8A9v9QkZPXDdmK4FIK6J0rwO1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVRE0P+GrCPDEZn8PeEU0KYWtrdveLkAXSqeKPV3hm/7mPcdbiIEUirceKRm3jBPwE6tXRoGe49NJrEJ06vgbHGvvHKF596zNsH4eECE0J6RDEobeburMVJMRunF+5IUp7wY2gaVG0xzkZathNKMAuGFr3Nn1sO25gjLCJ/X2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HkDSIqJ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HfgxdgiUAQiWmL2DptAL0OS3pzfCdOrkZKQvGdoq9to=; b=HkDSIqJ553XUcVw4+XDX8gX1qO
	DgV/OjplWvp5ldDWJr/skwTJJ9AlLGwoMCLYctTP5Mzh3a6HLZpLuGU2IwGFVf6FXnzgx6o4FCZG+
	Fzs6ck6OKrRd01kJfc1/bp4WIscY1Q5y8oD33ekdn/xUVKexvBAKrm7va/SVFbAN4GTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t68wr-00Bh2o-NW; Wed, 30 Oct 2024 14:41:21 +0100
Date: Wed, 30 Oct 2024 14:41:21 +0100
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
Subject: Re: [PATCH 4/4] arm64: dts: agilex5: initial support for Arrow
 AXE5-Eagle
Message-ID: <3f55a225-7d09-486a-818f-307c1f1ba806@lunn.ch>
References: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
 <20241030-v6-12-topic-socfpga-agilex5-v1-4-b2b67780e60e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-v1-4-b2b67780e60e@pengutronix.de>

> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&emac2_phy0>;
> +
> +	max-frame-size = <9000>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		emac2_phy0: ethernet-phy@1 {
> +			reg = <0x1>;
> +			adi,rx-internal-delay-ps = <2000>;
> +			adi,tx-internal-delay-ps = <2000>;

You have rgmii-id and 2000ps delay? Are these two lines actually
required?

	Andrew

