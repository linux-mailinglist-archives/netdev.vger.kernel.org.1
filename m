Return-Path: <netdev+bounces-240968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9BC7CEC7
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E14724E2610
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193411D5146;
	Sat, 22 Nov 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGSMDbAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FB4C97;
	Sat, 22 Nov 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812006; cv=none; b=b0rRrOMGBdmPpMLZd/owACkIpXSp1r6oGXcgmAU4xA614P526VyVGS8jmuIhrD5ksVdFf/DPLs+KH24q7yJi7GEPldceUrlOAAfcswfhyWsMHA05gGNfWiK57fBMHTOSvJPcFWGjdNxMz24qkCC6tvJrA3UCHfxpgpg2sJe/1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812006; c=relaxed/simple;
	bh=h22lMiCHBVu/9fd3DqeoWMZM7ifi9QlNE1SP7QytGzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7kLXdInqFhPDyzsrnfX8TN7BI2XyTw5r6n2kgl452KRq4EwZthfcCsV5DH6/l1jhx4/5KdqxZw4ikweIrhTyVAeSUc5hkbOw55kOx+0ht2j+iJX/k6UhcxkTdl3ugSOiEfHbkwn4VoQfYZobMnBSat4oZGuOKQzMpMacda1mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGSMDbAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAD6C4CEF5;
	Sat, 22 Nov 2025 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763812005;
	bh=h22lMiCHBVu/9fd3DqeoWMZM7ifi9QlNE1SP7QytGzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGSMDbAmJyAtPE+KgOIfvaOTuRdqmgsAp68kN8mPJ5EzF7FNO31cbos5tqMaljBYL
	 PMBZR9z5kZ6qQ7EgxvIwnMydxm7J2HoL78tBFWGFkuMYSoeclQAfeP8cwoxX6uUGgY
	 xOkOhbdC43wiqL474B1a/jgwvpKWRWhmpdmgAG9QdeI7zwr/GyU1z/5OP9ubu8VSGk
	 EhTlrDpuDm4yCYX+RsiXAr2P5hd5ihayNQf+sXZZnxc4qkG99rP89o0A3n63prWDgR
	 As1ZB6U0wEKWas74YnX/CFEKGGXmW66rG+nbP5MbTQ6R0f1Ls/vwnkT1hnP3A4jngF
	 IyVdoIEH2JLXA==
Date: Sat, 22 Nov 2025 11:46:40 +0000
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Message-ID: <aSGioGmSP9rtSLpB@horms.kernel.org>
References: <20251118045946.31825-1-parthiban.veerasooran@microchip.com>
 <20251118045946.31825-2-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118045946.31825-2-parthiban.veerasooran@microchip.com>

On Tue, Nov 18, 2025 at 10:29:45AM +0530, Parthiban Veerasooran wrote:

...

> @@ -1695,3 +1695,89 @@ int genphy_c45_oatc14_cable_test_start(struct phy_device *phydev)
>  				OATC14_HDD_START_CONTROL);
>  }
>  EXPORT_SYMBOL(genphy_c45_oatc14_cable_test_start);
> +
> +/**
> + * genphy_c45_oatc14_get_sqi_max - Get maximum supported SQI or SQI+ level of
> + *				   OATC14 10Base-T1S PHY
> + * @phydev: pointer to the PHY device structure
> + *
> + * This function reads the advanced capability register to determine the maximum
> + * supported Signal Quality Indicator (SQI) or SQI+ level
> + *
> + * Return:
> + * * Maximum SQI/SQI+ level (≥0)
> + * * -EOPNOTSUPP if not supported
> + * * Negative errno on read failure
> + */
> +int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev)
> +{
> +	u8 bits;
> +	int ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_ADFCAP);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check for SQI+ capability
> +	 * 0 - SQI+ is not supported
> +	 * (3-8) bits for (8-256) SQI+ levels supported
> +	 */
> +	bits = FIELD_GET(OATC14_ADFCAP_SQIPLUS_CAPABILITY, ret);
> +	if (bits) {
> +		phydev->oatc14_sqiplus_bits = bits;
> +		/* Max sqi+ level supported: (2 ^ bits) - 1 */
> +		return BIT(bits) - 1;
> +	}
> +
> +	/* Check for SQI capability
> +	 * 0 - SQI is not supported
> +	 * 1 - SQI is supported (0-7 levels)
> +	 */
> +	if (ret & OATC14_ADFCAP_SQI_CAPABILITY)
> +		return OATC14_SQI_MAX_LEVEL;
> +
> +	return -EOPNOTSUPP;
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
> + * extended SQI+ value; otherwise, it returns the basic SQI value.
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
> +	/* Calculate and return SQI+ value if supported */
> +	if (phydev->oatc14_sqiplus_bits) {

Hi Parthiban,

AFAICT oatc14_sqiplus_bits will always be 0 until
genphy_c45_oatc14_get_sqi_max() is called, after which
it may be some other value.

But according to the flow of linkstate_prepare_data()
it seems that genphy_c45_oatc14_get_sqi_max()
will be called after genphy_c45_oatc14_get_sqi().

In which case the condition above will be false
(unless genphy_c45_oatc14_get_sqi_max was somehow already
called by some other means.)

This doesn't seem to be in line with the intention of this code.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +				   MDIO_OATC14_DCQ_SQIPLUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* SQI+ uses N MSBs out of 8 bits, left-aligned with padding 1's
> +		 * Calculate the right-shift needed to isolate the N bits.
> +		 */
> +		shift = 8 - phydev->oatc14_sqiplus_bits;
> +
> +		return (ret & OATC14_DCQ_SQIPLUS_VALUE) >> shift;
> +	}
> +
> +	/* Read and return SQI value if SQI+ capability is not supported */
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_DCQ_SQI);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret & OATC14_DCQ_SQI_VALUE;
> +}
> +EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi);

...

