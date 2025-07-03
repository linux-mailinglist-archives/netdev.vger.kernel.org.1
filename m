Return-Path: <netdev+bounces-203878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1694AF7DA9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE21A1BC0F59
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD123E336;
	Thu,  3 Jul 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c+erWZh9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31418DB29;
	Thu,  3 Jul 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559157; cv=none; b=JU5Dr1HRCTlpCeHt17yfntAXuyGDUImrcNf3qqsBi9z+YiVVRX7z30LNx/7cZsYM4T0HdprJxM29LfYxTNbtAgT8CipCYnTwkT+GcbYUJZXkIH07qwup+QdqAQW6UEPtykmiUO+ihIjvxkWzoyG1aiVkz7PEmBRAAuFtLPpBgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559157; c=relaxed/simple;
	bh=6fXcWVqJXGYH0m2o0b1YUOeF/MgYn2Y0D/klL2x+C4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNbEa7z5Bk095wfCKv3ujHPwL36I1UNY45pZmU0hMHWlvN1lJazDjc5GiIjAQ7G+1yAqNmkz+AusoI3YgojIl4tmEcaRiy3ZUa8Hi4WBTXb3jNbuupOe/tw3jg2aGV1vME1QCUdwOHefLGlqKBUxo7s/8omiiHQvtwL1bcsHGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c+erWZh9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wv4BBXA+4pL6f4PUbQmyirqWFmcBaGMABn9VzcOlZ3U=; b=c+erWZh9K/H57qNTVjYAqIrEOL
	0CI5JHEPPML77qSqRxJ3y8+sdgKQhWnZhiWt6HM+5UC5IiYPL2fePvaabjIaqOlX4ckg1PkkE1Gl3
	rVU0jDk/u6oqPH0At3SkDXcHbiCKR8LVDVvZc87TGUO+KINbKzmRbybM83sM8aweDT9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXMY1-0007LT-ER; Thu, 03 Jul 2025 18:12:29 +0200
Date: Thu, 3 Jul 2025 18:12:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, jszhang@kernel.org,
	jan.petrous@oss.nxp.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com, boon.khai.ng@altera.com,
	dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703092015.1200-1-weishangjuan@eswincomputing.com>

> +/* Default delay value*/
> +#define EIC7700_DELAY_VALUE0 0x20202020
> +#define EIC7700_DELAY_VALUE1 0x96205A20

We need a better explanation of what is going on here. What do these
numbers mean?

> +	dwc_priv->dly_param_1000m[0] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_1000m[1] = EIC7700_DELAY_VALUE1;
> +	dwc_priv->dly_param_1000m[2] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_100m[0] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_100m[1] = EIC7700_DELAY_VALUE1;
> +	dwc_priv->dly_param_100m[2] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_10m[0] = 0x0;
> +	dwc_priv->dly_param_10m[1] = 0x0;
> +	dwc_priv->dly_param_10m[2] = 0x0;

What are the three different values for?

> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps",
> +				   &dwc_priv->rx_delay_ps);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "can't get rx-internal-delay-ps, ret(%d).", ret);
> +	else
> +		has_rx_dly = true;
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps",
> +				   &dwc_priv->tx_delay_ps);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "can't get tx-internal-delay-ps, ret(%d).", ret);
> +	else
> +		has_tx_dly = true;
> +	if (has_rx_dly && has_tx_dly)

What if i only to set a TX delay? I want the RX delay to default to
0ps.

{
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_1000m[1]);
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_100m[1]);
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_10m[1]);
> +	} else {
> +		dev_dbg(&pdev->dev, " use default dly\n");

What is the default? It should be 0ps. So there is no point printing
this message.

	Andrew

