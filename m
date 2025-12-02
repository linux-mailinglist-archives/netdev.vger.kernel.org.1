Return-Path: <netdev+bounces-243240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D90C9C2B4
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B2A3A58EA
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51787283FC5;
	Tue,  2 Dec 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JafeZQ57"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916E274641
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691969; cv=none; b=KmaHmlRSEG9D1DMhWy5uNg3c86lGgcXXbEzlFyRoN117PCz9CP35PaW58Jn1wqx7x71tYrIQPYK2Y28x4VQ0p50yO/1zxZJoVa0bQc/ebEBiOF+xcG+XyxWcojcttB62JB63yS6FtsNkZgUx5791i9jyxGnvOybW3yVQw/ZYoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691969; c=relaxed/simple;
	bh=rSkZyYoevwSedvSfNlK4TZnGRdkWJ2yxJp4QR/m1B8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWZWGJOCNohm1wxr9YHsjVfoDu1IjnLeFRusCO3ZpsDEWPUxLp0R9aQUMZBnwOd91Mbfw6BrqUgE8rtmxkvij5YZoYSk2b7aaUWPQgY4wdiIek772tVkQR05Fv5zWQ79uHLe0NRBheOOqpqQfAxqadrq0QNkgh8WIrE5MqVhD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JafeZQ57; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T4IBIZ4B5njtMyQ4rzAExR29qYvdP+JGz6jzKn8rSGc=; b=JafeZQ57CWrWyilfwi9NUSnIMc
	17T3RiJnCQZOLKLQpFw5SjgBL1eFdX60ocO/EvFqPpV5+Ud2Xw0AQRXMfhvx6kiBlGd7sBXOGjpYQ
	rZPYL18jB3zGqmuZFrddL9EAPn25EuQckxSJxS17Y0QuP+Y1jvxnGnkJxTJVuYdHn5k8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQSzb-00FiQp-Qe; Tue, 02 Dec 2025 17:12:43 +0100
Date: Tue, 2 Dec 2025 17:12:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
Message-ID: <497ad08d-2603-4159-a4ce-52bdc5361aed@lunn.ch>
References: <20251202102222.1681522-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202102222.1681522-1-bjorn@mork.no>

>  static int en8811h_load_firmware(struct phy_device *phydev)
>  {
>  	struct en8811h_priv *priv = phydev->priv;
>  	struct device *dev = &phydev->mdio.dev;
>  	const struct firmware *fw1, *fw2;
> +	bool en8811h;
>  	int ret;
>  
> -	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
> -	if (ret < 0)
> -		return ret;
> +	switch (phydev->phy_id & PHY_ID_MATCH_MODEL_MASK) {
> +	case EN8811H_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
> +		ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
> +		if (ret < 0)
> +			return ret;
>  
> -	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> -	if (ret < 0)
> -		goto en8811h_load_firmware_rel1;
> +		ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> +		if (ret < 0)
> +			goto en8811h_load_firmware_rel1;
> +
> +		en8811h = true;
> +		break;
> +
> +	case AN8811HB_PHY_ID & PHY_ID_MATCH_MODEL_MASK:
> +		ret = request_firmware_direct(&fw1, AN8811HB_MD32_DM, dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = request_firmware_direct(&fw2, AN8811HB_MD32_DSP, dev);
> +		if (ret < 0)
> +			goto en8811h_load_firmware_rel1;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
>  
>  	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				     EN8811H_FW_CTRL_1_START);
> +	if (ret == 0 && en8811h)

Generally, you don't test for 0. If there is an error you return
it. Does this need to be special?

> +		ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +					      EN8811H_FW_CTRL_2_LOADING,
> +					      EN8811H_FW_CTRL_2_LOADING);
>  	if (ret < 0)
>  		goto en8811h_load_firmware_out;
>  
> -	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> -				      EN8811H_FW_CTRL_2_LOADING,
> -				      EN8811H_FW_CTRL_2_LOADING);
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
>  	if (ret < 0)
>  		goto en8811h_load_firmware_out;
>  
> -	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
> +	if (ret == 0 && !en8811h)
> +		ret = an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
> +					 AN8811HB_CRC_DM_MON2,
> +					 AN8811HB_CRC_DM_MON3);

This !en881h and en881h looks a bit ugly. Maybe see if you can
refactor this code into helpers for the two cases? 

> @@ -952,8 +1141,9 @@ static int en8811h_probe(struct phy_device *phydev)
>  	}
>  
>  	priv->phydev = phydev;
> +
>  	/* Co-Clock Output */
> -	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
> +	ret = en8811h_clk_provider_setup(phydev, &priv->hw);
>  	if (ret)
>  		return ret;

Maybe look at having two different probe functions, with a helper for
any common code? That might mean you don't need as many switch
statements. And this is a common pattern when dealing with variants of
hardware. You have a collection of helpers which are generic, and then
version specific functions which make use of the helpers are
appropriate.

This patch is also quite large. See if you can break it
up. Refactoring the existing code into helpers can be a patch of its
own.

	Andrew

