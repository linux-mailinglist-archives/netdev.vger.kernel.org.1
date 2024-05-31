Return-Path: <netdev+bounces-99766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6E8D64DC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3C31F27DA9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D959147;
	Fri, 31 May 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbzoTH+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14D558B9
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167028; cv=none; b=ZE55vvZoNLG0j1/HYWt4deTu6k3o/kGg2Rle0W7imrqnvm+DGGD/Y2Q0VWCzFQsDk+OgQ9xdAtMMSJi4332cI+7q1YMp5QfexHs+v4RNrPgdTBawNrACX/vK4q7A1Vw/wYEXpPFLDIg+vcmj2kiayG5gS5LbrcVzi+1iXNkSjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167028; c=relaxed/simple;
	bh=V3c+3Y5HJA8ik51zRIjpUeJRb0Yr+J6Q6zHt1I6UsDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXL+J+MhXp5B/d0RMX0y21nTWacfQhUTgrUljp9bA6bwRLhTZrDt9Ti2GwcUh/TsH4npSQTCZ72+XHYkef9td1TwJuw+OAy33SMzGd9Yp5BpJ8+wKQmxYC6pHABuw1525OGd2xer1jvVHaBSW9ilAK5rqayuiFtI/uTgHbLqbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbzoTH+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CFEC32781;
	Fri, 31 May 2024 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167028;
	bh=V3c+3Y5HJA8ik51zRIjpUeJRb0Yr+J6Q6zHt1I6UsDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbzoTH+MJV127ZPsLgWBPWRwSMJcFWhnRsN2MO7rM7Bb1EmITxFdRMYuNY/AdnGoB
	 qHhKhS+X+w3tb8OcLfibCGTphISCpYdgEtLFtSFg28NvUHND7Xff3bhALvymR/BMnT
	 nkANUGUrlwPrQAX5XYLE3qO4I6hw1WJHJ7nfbjaFqj3RsbTxAidGLsErApgWzNSSNq
	 r6wKHRaTjaUmOs2NFKUX4v/hZ8ChZgKH/9Gyo2/t91V+R1w2rPNqx+mQa+NsI/Vya/
	 O24VyJbpgkhp3rwSObWLV+f5Z5nUfa8sYUBjUPsF9ori6TGmVynyU6uOFhcgP7bZwJ
	 DKruvewWldLsA==
Date: Fri, 31 May 2024 15:50:24 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v7 2/7] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20240531145024.GI123401@kernel.org>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-3-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527151023.3634-3-piotr.kwapulinski@intel.com>

On Mon, May 27, 2024 at 05:10:18PM +0200, Piotr Kwapulinski wrote:
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
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 517 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  11 +
>  2 files changed, 528 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

...

> +/**
> + * ixgbe_discover_dev_caps - Read and extract device capabilities
> + * @hw: pointer to the hardware structure
> + * @dev_caps: pointer to device capabilities structure
> + *
> + * Read the device capabilities and extract them into the dev_caps structure
> + * for later use.
> + *
> + * Return: the exit code of the operation.
> + */
> +int ixgbe_discover_dev_caps(struct ixgbe_hw *hw,
> +			    struct ixgbe_hw_dev_caps *dev_caps)
> +{
> +	u8 *cbuf __free(kfree);
> +	u32 cap_count;
> +	int err;
> +
> +	cbuf = kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
> +	if (!cbuf)
> +		return -ENOMEM;
> +	/* Although the driver doesn't know the number of capabilities the
> +	 * device will return, we can simply send a 4KB buffer, the maximum
> +	 * possible size that firmware can return.
> +	 */
> +	cap_count = IXGBE_ACI_MAX_BUFFER_SIZE /
> +		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
> +
> +	err = ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
> +				  &cap_count,
> +				  ixgbe_aci_opc_list_dev_caps);
> +	if (!err)
> +		ixgbe_parse_dev_caps(hw, dev_caps, cbuf, cap_count);
> +
> +	return err;

Hi Piotr, all,

A minor nit from my side.

It would be more idiomatic to write this such that the main flow of
execution is the non-error path, while errors are handled by conditions. In
this case, something like this (completely untested!):

	err = ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
				  &cap_count,
				  ixgbe_aci_opc_list_dev_caps);
	if (err)
		return err;

	ixgbe_parse_dev_caps(hw, dev_caps, cbuf, cap_count);

	return 0;

Likewise in ixgbe_discover_func_caps()

> +}
> +
> +/**
> + * ixgbe_discover_func_caps - Read and extract function capabilities
> + * @hw: pointer to the hardware structure
> + * @func_caps: pointer to function capabilities structure
> + *
> + * Read the function capabilities and extract them into the func_caps structure
> + * for later use.
> + *
> + * Return: the exit code of the operation.
> + */
> +int ixgbe_discover_func_caps(struct ixgbe_hw *hw,
> +			     struct ixgbe_hw_func_caps *func_caps)
> +{
> +	u8 *cbuf __free(kfree);
> +	u32 cap_count;
> +	int err;
> +
> +	cbuf = kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
> +	if (!cbuf)
> +		return -ENOMEM;
> +
> +	/* Although the driver doesn't know the number of capabilities the
> +	 * device will return, we can simply send a 4KB buffer, the maximum
> +	 * possible size that firmware can return.
> +	 */
> +	cap_count = IXGBE_ACI_MAX_BUFFER_SIZE /
> +		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
> +
> +	err = ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
> +				  &cap_count,
> +				  ixgbe_aci_opc_list_func_caps);
> +	if (!err)
> +		ixgbe_parse_func_caps(hw, func_caps, cbuf, cap_count);
> +
> +	return err;
> +}

...

