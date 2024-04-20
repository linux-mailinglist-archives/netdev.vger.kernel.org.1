Return-Path: <netdev+bounces-89830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088998ABCA9
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 20:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA21F21338
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11623B182;
	Sat, 20 Apr 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmaCgrOV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B32E3E5
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637111; cv=none; b=f5J/4y9GKtmfPpcDDIuYVriBQE+CHQCGNq75Y+3bj2C+dAzXw3WpafULvQmR6YDY0jvWlveqCfWRcb7FyH36djcRmQZygdryxTL6kXvq9/4JoGm/2AkQsI/xd3GU9akSezAIaqbL5QBEh8MY2Lrtb6+vERKzY39bZtwN02uD4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637111; c=relaxed/simple;
	bh=ts4FPlOyzVKMxbCvwKM4YpkwOuRdKBgIVy0ksYAFLwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6on8sVmGSW0MW5kRqGk2z3KtXYV82qCDjG6KNiCXYtdcMAPlxSDoKcaUKEsXNUKQrEZ0MHVmR6XWyb1og6mRl3Ze1uN7hpT0KV39FGSly9ZFGadmebBBLCqg7ZF2annCRbwSMqWZXlyPwL6vTRIG3fGFBCrlXKuE64u/F792lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmaCgrOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A95C072AA;
	Sat, 20 Apr 2024 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713637110;
	bh=ts4FPlOyzVKMxbCvwKM4YpkwOuRdKBgIVy0ksYAFLwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmaCgrOVGiKi7yhckHOvlXcC3eOgXdiYgKk49e+u3FuePFZxOWL+vNWe0JGHfYa2Y
	 JOak8FPZx3Xm6eMyWhswILqzP0mRn2qo/tyys9bZUw7yzsjyeL8S9NtiLErFUSNunV
	 VqcygiTUG1Z8MXzZw25MRI8Otkp+h2YDF3/dfyjNn7sgYYbYktdY5djHjFsa2Lj/z5
	 bRZQB95ZcxQ9O26gbdsfU50VrWfi6HFkPQFKY+Q0aW9kM8PpgfkNx6sdpzIpZ8Mx+y
	 og6sL7afteF/L45R1ysiZlaexNmMFBaTEU27Jc5VkdXhc0VOl8mFZONQSnUDjzf8bY
	 7Is4osfDNX9Lw==
Date: Sat, 20 Apr 2024 19:18:26 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	vinicius.gomes@intel.com, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v2 2/5] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20240420181826.GA42092@kernel.org>
References: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
 <20240415103435.6674-3-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415103435.6674-3-piotr.kwapulinski@intel.com>

On Mon, Apr 15, 2024 at 12:34:32PM +0200, Piotr Kwapulinski wrote:
> Add low level support for E610 device capabilities detection. The
> capabilities are discovered via the Admin Command Interface. Discover the
> following capabilities:
> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> - device caps: vsi, fdir, 1588
> - phy caps
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Hi Pitor,

A few minor nits from my side.
No need to respin just because of these.

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 517 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  11 +
>  2 files changed, 528 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

...

> +/**
> + * ixgbe_get_num_per_func - determine number of resources per PF
> + * @hw: pointer to the HW structure
> + * @max: value to be evenly split between each PF
> + *
> + * Determine the number of valid functions by going through the bitmap returned
> + * from parsing capabilities and use this to calculate the number of resources
> + * per PF based on the max value passed in.
> + *
> + * Return: the number of resources per PF or 0, if no PH are available.
> + */
> +static u32 ixgbe_get_num_per_func(struct ixgbe_hw *hw, u32 max)
> +{
> +	const u32 IXGBE_CAPS_VALID_FUNCS_M = 0xFF;

nit: Maybe this could simply be a #define?

> +	u8 funcs = hweight8(hw->dev_caps.common_cap.valid_functions &
> +			    IXGBE_CAPS_VALID_FUNCS_M);

nit: Please consider using reverse xmas tree order - longest line to shortest -
     for local variables in new Networking code

> +
> +	return funcs ? (max / funcs) : 0;
> +}

...

> +/**
> + * ixgbe_aci_disable_rxen - disable RX
> + * @hw: pointer to the HW struct
> + *
> + * Request a safe disable of Receive Enable using ACI command (0x000C).
> + *
> + * Return: the exit code of the operation.
> + */
> +int ixgbe_aci_disable_rxen(struct ixgbe_hw *hw)
> +{
> +	struct ixgbe_aci_cmd_disable_rxen *cmd;
> +	struct ixgbe_aci_desc desc;
> +
> +	cmd = &desc.params.disable_rxen;
> +
> +	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_disable_rxen);
> +
> +	cmd->lport_num = (u8)hw->bus.func;

nit: This cast seems unnecessary.
     AFAICT the type of hw->bus.func is u8.

> +
> +	return ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
> +}

...

