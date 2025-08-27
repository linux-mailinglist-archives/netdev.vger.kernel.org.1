Return-Path: <netdev+bounces-217277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DFB38286
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D043117A3A3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BE931812C;
	Wed, 27 Aug 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VcffjXPw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB7145B3F;
	Wed, 27 Aug 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298260; cv=none; b=uhsqB/SrsDFReHPFQKIA4xX6SW4atknyZEUv/uTnQzbE54EVR21K3ak3nVPI0pyWGGliyRhGO16jiU7mX8mWcSMiuXLN9ElqTNeMz70iJCuZZ8mnUh2MIx1gtu2mu7nvOuof8ESUx4DvrHrLY3WmQQB6KiT2luhh1QItCIZZSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298260; c=relaxed/simple;
	bh=T7M7sQJLjtX5ZHdDwKIWu6fWkx9lTXM1Mw4QurTKHSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC250dTElEeL9v/ipElNz6z6vEjJqbJwG7cFyZXuGz3E/qTSFbj/dsGV3go+LXkF/a/A+QRhPPVRyGwMBM5FezPs9VC0SoU0yycqNXptOOqG8C3VT7nbw/oBgvqdd4nDBgtkiq/b0muplukdY3+VjjRbChr3Ex2n3l6mTfIlPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VcffjXPw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=isKWibVXBVycwFd7et1plNZH4fEqTmzHgURf/OQqBDA=; b=VcffjXPw/PgTwsJcBxPKr8x0LS
	NH45jESGr/WF2lfebtS7qCLpXzLVlklMtyUMwkREO7QafooG/b+hsQM7MgiPiUSsBPM//htmY+uZG
	e1Jj3nkF2Ba09x325c05fpfre772d0m1b8s5CY5NIun5+u21ibGFPEHKtd3sNcO3KLlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urFOs-006D0t-7x; Wed, 27 Aug 2025 14:37:14 +0200
Date: Wed, 27 Aug 2025 14:37:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v4 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <7a39a658-0a83-4998-ae43-344025996c7b@lunn.ch>
References: <20250827081135.2243-1-weishangjuan@eswincomputing.com>
 <20250827081418.2347-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827081418.2347-1-weishangjuan@eswincomputing.com>

> +/**
> + * eic7700_apply_delay - Update TX or RX delay bits in delay parameter value.
> + * @delay_ps: Delay in picoseconds (capped at 12.7ns).
> + * @reg:      Pointer to register value to modify.
> + * @is_rx:    True for RX delay (bits 30:24), false for TX delay (bits 14:8).
> + *
> + * Converts delay to 0.1ns units, caps at 0x7F, and sets appropriate bits.
> + * Only RX or TX bits are updated; other bits remain unchanged.
> + */
> +static inline void eic7700_apply_delay(u32 delay_ps, u32 *reg, bool is_rx)
> +{
> +	if (!reg)
> +		return;
> +

Please don't use inline functions in .c files. Leave the compile to
decide.


> +	/* Read rx-internal-delay-ps and update rx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "rx-internal-delay-ps",
> +				  &dwc_priv->rx_delay_ps)) {
> +		eic7700_apply_delay(dwc_priv->rx_delay_ps,
> +				    &eth_dly_param, true);
> +	} else {
> +		dev_warn(&pdev->dev, "can't get rx-internal-delay-ps\n");
> +	}
> +
> +	/* Read tx-internal-delay-ps and update tx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "tx-internal-delay-ps",
> +				  &dwc_priv->tx_delay_ps)) {
> +		eic7700_apply_delay(dwc_priv->tx_delay_ps,
> +				    &eth_dly_param, false);

Given this code, why does eic7700_apply_delay() test for reg?  Don't
use defensive code, read your own code and make sure it cannot happen.

    Andrew

---
pw-bot: cr

