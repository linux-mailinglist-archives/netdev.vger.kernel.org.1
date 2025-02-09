Return-Path: <netdev+bounces-164486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72966A2DF1A
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 17:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C13A52A9
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC01DEFDC;
	Sun,  9 Feb 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK6GFDtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16413B2BB
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118446; cv=none; b=dpVbPN4IaaruTTXvadQsMfKpDDoU8J7CeB8ygPaorZCuOwcPnK87GzUVBUCQ0cJbXVdAdIPRInOjpbbbztlsH9FHo4ZvRArUSMWIpI2Ayngkrfhcv+ovrpC1P5w22SRPnNjizEK9FkhNjjnFNbT8oCJ+Guf1cSlrtwfE5uB6R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118446; c=relaxed/simple;
	bh=PLKwHjwFhvQFpzH747yxvcgU0xNzFy/1pmXG755VHlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8ZZ1290BJK07D4nSUW+mtcJ7rK2ugDFwIX7s1yiudHdh9LTllVonKIkIoZ7TvGHSlS0exm6JeNdoij83VCjpyQ1wUQGCqISUMKyqt67wavMoieEKGVICDeBZFers3mUHUbVbFyeDZ9HbKBb9xXvsX/29BvGaNtFGueHpmHJK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK6GFDtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BEEC4CEDD;
	Sun,  9 Feb 2025 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739118445;
	bh=PLKwHjwFhvQFpzH747yxvcgU0xNzFy/1pmXG755VHlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WK6GFDtE9puQKNpsixY8BDYyWp4RpAs42LpEk4MzNk9kAQTmKBnvWuPptXwAO9luD
	 Ow2y5V+DZUC6PMQUrX15t08sQtj5DPEhCksrDBAlQQU26KdobvnITs9u8ZU7G4j23m
	 9gfuyEgaHWFgQLJkHUZjsjR1dUFxcegxlipLtKbfzo0nCENWPlwXGFSFy4H9oHLzo+
	 LAzExTNtUdxbHHioGid7L+jFN5GlwhJO+kIRoy5R2XjRbMdgV6LeL8Pr/7XPNsCRqy
	 7f+MHAF3iWF2CHRCJt/v05oqSwF/ki0XnOTDmXbuxB9/8LDrfhkgf5xwkgGPBp/z8Z
	 XdIOXLKJiIpuw==
Date: Sun, 9 Feb 2025 16:27:22 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v1 02/13] ixgbe: add handler for devlink
 .info_get()
Message-ID: <20250209162722.GD554665@kernel.org>
References: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
 <20250203150328.4095-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203150328.4095-3-jedrzej.jagielski@intel.com>

On Mon, Feb 03, 2025 at 04:03:17PM +0100, Jedrzej Jagielski wrote:
> Provide devlink .info_get() callback implementation to allow the
> driver to report detailed version information. The following info
> is reported:
> 
>  "serial_number" -> The PCI DSN of the adapter
>  "fw.bundle_id" -> Unique identifier for the combined flash image
>  "fw.undi" -> Version of the Option ROM containing the UEFI driver
>  "board.id" -> The PBA ID string
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c

...

> +static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
> +			       struct ixgbe_info_ctx *ctx)
> +{
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	struct ixgbe_nvm_version nvm_ver;
> +
> +	ixgbe_get_oem_prod_version(hw, &nvm_ver);
> +	if (nvm_ver.oem_valid) {
> +		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x",
> +			 nvm_ver.oem_major, nvm_ver.oem_minor,
> +			 nvm_ver.oem_release);
> +
> +		return;
> +	}
> +
> +	ixgbe_get_orom_version(hw, &nvm_ver);
> +	if (nvm_ver.or_valid)
> +		snprintf(ctx->buf, sizeof(ctx->buf), "%d.%d.%d",
> +			 nvm_ver.or_major, nvm_ver.or_build, nvm_ver.or_patch);

Hi Jedrzej,

If neither of the conditions above are met then it seems that ctx->buf will
contain whatever string was present when the function was called. Is
something like the following needed here?

	ctx->buf[0] = '\0';

> +}
> +
> +static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
> +			       struct ixgbe_info_ctx *ctx)
> +{
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	struct ixgbe_nvm_version nvm_ver;
> +
> +	ixgbe_get_oem_prod_version(hw, &nvm_ver);
> +	/* No ETRACK version for OEM */
> +	if (nvm_ver.oem_valid)
> +		return;

Likewise, here.

> +
> +	ixgbe_get_etk_id(hw, &nvm_ver);
> +	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm_ver.etk_id);
> +}
> +
> +static int ixgbe_devlink_info_get(struct devlink *devlink,
> +				  struct devlink_info_req *req,
> +				  struct netlink_ext_ack *extack)
> +{
> +	struct ixgbe_devlink_priv *devlink_private = devlink_priv(devlink);
> +	struct ixgbe_adapter *adapter = devlink_private->adapter;
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	struct ixgbe_info_ctx *ctx;
> +	int err;
> +
> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ixgbe_info_get_dsn(adapter, ctx);
> +	err = devlink_info_serial_number_put(req, ctx->buf);
> +	if (err)
> +		goto free_ctx;
> +
> +	ixgbe_info_nvm_ver(adapter, ctx);
> +	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
> +				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
> +				     ctx->buf);
> +	if (err)
> +		goto free_ctx;
> +
> +	ixgbe_info_eetrack(adapter, ctx);
> +	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
> +				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
> +				     ctx->buf);
> +	if (err)
> +		goto free_ctx;
> +
> +	err = ixgbe_read_pba_string_generic(hw, ctx->buf, sizeof(ctx->buf));
> +	if (err)
> +		goto free_ctx;
> +
> +	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_FIXED,
> +				     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
> +				     ctx->buf);
> +free_ctx:
> +	kfree(ctx);
> +	return err;
> +}

...

