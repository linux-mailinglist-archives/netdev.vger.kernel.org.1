Return-Path: <netdev+bounces-249092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACCED13D65
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F04F830081BB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834313624B0;
	Mon, 12 Jan 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fE21Mp34"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05497352958
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233387; cv=none; b=WARNJlxYCitTmhtn4szwCTLEVdi1nNIioU8t5pITJ9c6XDsmMvTHFvral1XhZcICjnmvmOCIQBf+k7tF8cfEfmIKzW10AKLcbsGvUH0jVFUK0S27qCuBN2bZvCsCiL40ONp3S994Xz7tn5DvXlESMEBq4gijCEdQl7CgQKW7Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233387; c=relaxed/simple;
	bh=wTAFDd1V9dzYqz7WLzK4SZS9IAqqJcI4wC/phVfiink=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on1BqzJjMWkx4rwRUb9oaRLAv2pThPyjp8KMyIyD9YEc9Cg2cwHO2Ci/affY2B5pHsh99o3LucqqK6PhnBmf+ilAx3SsHiOmDXf2gPxPyosr9VtxFMQQ7JE6zitamczqZClp8HmZqQasKMfi87LuQJ0+ZMrAlp3cUV8VtfBk6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fE21Mp34; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yVL7iT/rtDYvyNiRL1d4ysqCbmuXsXMI/xyJ7QnChRo=; b=fE21Mp34VUrVBaGb1BEQOever0
	/t8umgtrpOKpGjRoESfcXMvtzj5d0WpEfuwor+eyrUC0RV8rxuMZ6xscQoan0710VASKkaqoRjyEs
	nmXqawB9UD1GOnFtitvPv8epVSivDu06bkofUGEKel7PSJwJAV4yep91EYPDvHJdqk98=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfKHG-002VA5-Id; Mon, 12 Jan 2026 16:56:22 +0100
Date: Mon, 12 Jan 2026 16:56:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 7/7] ixgbe: E610: add EEE support
Message-ID: <8ca1bd29-a736-40bf-8d53-39c9577228c0@lunn.ch>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-8-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112140108.1173835-8-jedrzej.jagielski@intel.com>

> +/**
> + * ixgbe_setup_eee_e610 - Enable/disable EEE support
> + * @hw: pointer to the HW structure
> + * @enable_eee: boolean flag to enable EEE
> + *
> + * Enable/disable EEE based on @enable_eee.
> + *
> + * Return: the exit code of the operation.
> + */
> +int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee)
> +{
> +	struct ixgbe_aci_cmd_get_phy_caps_data phy_caps = {};
> +	struct ixgbe_aci_cmd_set_phy_cfg_data phy_cfg = {};
> +	u16 eee_cap = 0;
> +	int err;
> +
> +	err = ixgbe_aci_get_phy_caps(hw, false,
> +		IXGBE_ACI_REPORT_ACTIVE_CFG, &phy_caps);
> +	if (err)
> +		return err;
> +
> +	ixgbe_copy_phy_caps_to_cfg(&phy_caps, &phy_cfg);
> +	phy_cfg.caps |= (IXGBE_ACI_PHY_ENA_LINK |
> +			IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT);
> +
> +	if (enable_eee) {
> +		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_100_FULL)
> +			eee_cap |= IXGBE_ACI_PHY_EEE_EN_100BASE_TX;
> +		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_1GB_FULL)
> +			eee_cap |= IXGBE_ACI_PHY_EEE_EN_1000BASE_T;

You say in a few different places that EEE is not supported for <=
1G. So why have this? It should never happen.

> +bool ixgbe_is_eee_link_speed_supported_e610(struct ixgbe_adapter *adapter,
> +					    bool print_msg)
> +{
> +	switch (adapter->link_speed) {
> +	case IXGBE_LINK_SPEED_10GB_FULL:
> +	case IXGBE_LINK_SPEED_2_5GB_FULL:
> +	case IXGBE_LINK_SPEED_5GB_FULL:
> +		return true;
> +	case IXGBE_LINK_SPEED_10_FULL:

I don't think IEEE defines EEE for 10Mbs. So this should be in your
default case, where you handle 10_HALF, 100_HALF, 1G_HALF which also
are not defined in 802.3.

> +	case IXGBE_LINK_SPEED_100_FULL:
> +	case IXGBE_LINK_SPEED_1GB_FULL:
> +		if (print_msg)
> +			e_dev_info("Energy Efficient Ethernet (EEE) feature is not supported on link speeds equal to or below 1Gbps. EEE is supported on speeds above 1Gbps.\n");
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +}

	Andrew

