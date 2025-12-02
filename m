Return-Path: <netdev+bounces-243242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6DDC9C2D5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664F34E2724
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00D276046;
	Tue,  2 Dec 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjnrp4TP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3927279DA2;
	Tue,  2 Dec 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692505; cv=none; b=uxX9G7GzXOHLs0mfN0dQLT72S2GvFQIvLGj1IO7qtFVCWkZpTkoo9Ae7hE7rZWonrU+9uNZ/ArDn6NVK/BaM3Lg/V/1vd9CgWQa7PzddRbwW/ubhVmSxZcMgGlkk/CLaqliRreI5JgN3Z1fQyF1hfo66EHq7/jRCO1rQhD343sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692505; c=relaxed/simple;
	bh=Sjbo92kQLt3c10t++zLRzbEDhdqfU1f3PTdpZLveEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6pqpjVAL7fLViviia/AtXNd3xTruXe0JJqLTB2/p5/MsgoFwPdIMQhYS52GNulJCZbAd3vjegZC+eMgog1k6XzKTgD2ItCX/zOE9PSjvMHEMG/698RWdKDk9sjJd1HzQTK2kX/odayo37wTz56VKHkMT8CSqUDWhB3OlOVfBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjnrp4TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70111C116B1;
	Tue,  2 Dec 2025 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764692504;
	bh=Sjbo92kQLt3c10t++zLRzbEDhdqfU1f3PTdpZLveEDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjnrp4TP8Rd10mxGzKqCWm8MWz5NKLxiAe1ahCNBnF8OYrVL6tPcWWlabfpQpqbon
	 6o9LIDT8u8ptSLJSQJ+rC6utj9OaRAMmyUr/WY9eYlX+oU0K5BlZHzBONIWzLzFsB1
	 3CFBor/WZ6WwqWDTzKPco89CgLdDciX7Ii6TqMb8cce2yR9rD5kyCo+nShN5AQ0Y7w
	 0hQnnvZeYrT4059HtNoJCiVnIIoQbSGv+RaFbNhsEfAcqP9nhsYEzBqD9mlVcgUvpk
	 36o/NwzbOGJs53CePvg09TLh6TKiHiTD42OqfIQtZA0S7nfNziyYFsE8E3syeoTzom
	 fIo+kxpAO2KEA==
Date: Tue, 2 Dec 2025 16:21:40 +0000
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Message-ID: <aS8SFIN_LZsoyAKW@horms.kernel.org>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
 <20251201032346.6699-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201032346.6699-2-parthiban.veerasooran@microchip.com>

On Mon, Dec 01, 2025 at 08:53:45AM +0530, Parthiban Veerasooran wrote:

...

> +int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	if (!phydev->oatc14_sqi_capability.updated) {
> +		ret = oatc14_update_sqi_capability(phydev);
> +		if (ret)
> +			return ret;
> +	}

Hi Parthiban,

I think the check for phydev->oatc14_sqi_capability.updated can be folded
into oatc14_update_sqi_capability(), avoiding duplicating it here and in
genphy_c45_oatc14_get_sqi().

If you agree, could you consider posting a follow-up once net-next has
re-opened?

> +
> +	return phydev->oatc14_sqi_capability.sqi_max;
> +}
> +EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi_max);
> +
> +/**
> + * genphy_c45_oatc14_get_sqi - Get Signal Quality Indicator (SQI) from an OATC14
> + *			       10Base-T1S PHY
> + * @phydev: pointer to the PHY device structure
> + *
> + * This function reads the SQI+ or SQI value from an OATC14-compatible
> + * 10Base-T1S PHY. If SQI+ capability is supported, the function returns the
> + * extended SQI+ value; otherwise, it returns the basic SQI value. The SQI
> + * capability is updated on first invocation if it has not already been updated.
> + *
> + * Return:
> + * * SQI/SQI+ value on success
> + * * Negative errno on read failure
> + */
> +int genphy_c45_oatc14_get_sqi(struct phy_device *phydev)
> +{
> +	u8 shift;
> +	int ret;
> +
> +	if (!phydev->oatc14_sqi_capability.updated) {
> +		ret = oatc14_update_sqi_capability(phydev);
> +		if (ret)
> +			return ret;
> +	}

