Return-Path: <netdev+bounces-222977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29699B5764C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F261A22394
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0602FCBF4;
	Mon, 15 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FusBt2vO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCA2FCBE3;
	Mon, 15 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932225; cv=none; b=buae4y0wgKl78FI2pii4ld9dKf592uiykNMsFd4sIyR7LbqWt8gE2+CUdRLUVxlHtCynGWunMVI6EW5fuMkVfhoOGx/xj3e4UqZgzZUyubKL/OFY2HACWY0ZJ1FPfU9IC2jzS25ghQOgbRV5n5Q2TWDeZycAFRzPgdq5tUFwfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932225; c=relaxed/simple;
	bh=77dwZU3PIqsBuoVq1y+3yB+skASgC8Rn9oVnn2I8Biw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu5DzoEpxPxQrNWZsrYGj6NJ5C4RdLdcZv5MP3p0xqVSc+DjMLmeMzhmtp3gP38a5/0l3pIMXc2Ixr0fUNXm4Zo+cCPry48olJOhihZqm924/PzhBH16Dk+YVZxFUh7KQoqCbcU623eGJLmXT1gKOcrWdUtzt9UjYNIQBWWIRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FusBt2vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FAAC4CEF7;
	Mon, 15 Sep 2025 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757932225;
	bh=77dwZU3PIqsBuoVq1y+3yB+skASgC8Rn9oVnn2I8Biw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FusBt2vO6eOMuxurwssBaYr+uujX5QvRO0zN0JJZq8EAZItTiiphjkM31c5VkXP2T
	 w8tS6kMFVVtmreLeXsQbJbyIdk2HUGPkYSCVJvVgWuFrOO9kYYyKGtsl9YncOXK1Tn
	 SC9fdKnznGrcHdsOaKh0l5xiQeikQBnKb4XZUEwnE9tPbeXy4VkooXdRStgu6zlDW0
	 AYFyLKvNwy8xxji85cXDWF6ew+Db2Yl2veFyz5bZremnxoQiZieBsNR+k6+eiqolsy
	 5azau1Wtf/oYJXt7OwRN/YMvaTfDL7Ub+RSY+2EyfGWBNlSNt/HV2kAbzftS1w2vaV
	 0TaR9xlFBB/PA==
Date: Mon, 15 Sep 2025 11:30:19 +0100
From: Simon Horman <horms@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250915103019.GP224143@horms.kernel.org>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913044404.63641-4-mmyangfl@gmail.com>

On Sat, Sep 13, 2025 at 12:44:01PM +0800, David Yang wrote:
> Motorcomm YT921x is a series of ethernet switches developed by Shanghai
> Motorcomm Electronic Technology, including:
> 
>   - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs
>   - YT9213NB / YT9214NB: 2 GbE PHYs
>   - YT9218N / YT9218MB: 8 GbE PHYs
> 
> and up to 2 GMACs.
> 
> Driver verified on a stock wireless router with IPQ5018 + YT9215S.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

...

> +static int
> +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   phy_interface_t interface)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (!yt921x_port_is_external(port)) {
> +		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			dev_err(dev, "Wrong mode %d on port %d\n",
> +				interface, port);
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	switch (interface) {
> +	/* SGMII */
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		mask = YT921X_SGMII_CTRL_PORTn(port);
> +		res = yt921x_reg_set_bits(priv, YT921X_SGMII_CTRL, mask);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_XMII_CTRL_PORTn(port);
> +		res = yt921x_reg_clear_bits(priv, YT921X_XMII_CTRL, mask);
> +		if (res)
> +			return res;
> +
> +		mask = YT921X_SGMII_MODE_M;
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +			ctrl = YT921X_SGMII_MODE_SGMII_PHY;
> +			break;
> +		case PHY_INTERFACE_MODE_100BASEX:
> +			ctrl = YT921X_SGMII_MODE_100BASEX;
> +			break;
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +			ctrl = YT921X_SGMII_MODE_1000BASEX;
> +			break;
> +		case PHY_INTERFACE_MODE_2500BASEX:
> +			ctrl = YT921X_SGMII_MODE_2500BASEX;
> +			break;
> +		default:
> +			WARN_ON(1);
> +			break;
> +		}

Hi David,

If the default case is reached above then ctrl is used uninitialised below.

Flagged by Clang 21.2.1

> +		res = yt921x_reg_update_bits(priv, YT921X_SGMIIn(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +
> +		break;
> +	/* add XMII support here */
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +
> +	return 0;
> +}

...

