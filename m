Return-Path: <netdev+bounces-181626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7471A85D2F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035C94A113D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C7290BCF;
	Fri, 11 Apr 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftbmc6pi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7829C356
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374991; cv=none; b=QwZaJTRej2StkMlpBpTGFXKVcbL+D7ReX5/+tLlMVemVzm5qF6K+L4LemQEi1hQR4N4VmRwy6wX2qBCYLs/ul+6Suz1qbnlNl5zbc5ks0W6+3KsCZTsiktQ1yaG+1jfOqXjdCFhCSpwk2mF41Agog6lJktbEfVwUrBwjsdVzFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374991; c=relaxed/simple;
	bh=OGoACs6RH+I8/t+z9lvjp50lGOMfeR8mLDulfIHw2JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX7PzpjoVfGNlb0ZMy7oa8ABxC6j4hHPtu4OVKZyOEwpLxwTga0Y7c3pVYdLhGKcd4pi5JS3N6zPtYfv92FC6Xmnaw7WfxBneyjJShiyMKmdNftPb8neK/HmaVq6SAhdsQi023FkO2pgugMJD7PamZ5eLX8B824V2juYCnkVxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftbmc6pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6901C4CEE8;
	Fri, 11 Apr 2025 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744374991;
	bh=OGoACs6RH+I8/t+z9lvjp50lGOMfeR8mLDulfIHw2JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ftbmc6pi3lGTbxjkX9A3bAYC0MDI/k9y+mu95B2c7U1Xvh0PTPlQin3mwFrNU6W3C
	 iwOp/tMWVVYrvYFggpRZXynzQaq8v1a35W75hGBYbKYegvs0P31TZx+njxbtKn80jv
	 xgPY5RkJbhB+lgDdodQTR0NabA9modkDD8kT/sxQaHHz8q8ujhzYoWm+2gWvYgMKjr
	 UdNn9Yu/KduuKscDzorWKBtqmSJKiqREg86jfHUS5xZwq4CzFoH9ASrlIeN/oZJgzC
	 gnPWamCVy2OplRDOKyqgFskMX6cKV3OlkC4eHzvoqL+o6ZRCsETW53qOREBWzX4FbL
	 dlG8HxJeDkUuQ==
Date: Fri, 11 Apr 2025 13:36:27 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 01/10] ice: move TSPLL functions to a
 separate file
Message-ID: <20250411123627.GB395307@horms.kernel.org>
References: <20250409122830.1977644-12-karol.kolacinski@intel.com>
 <20250409122830.1977644-13-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409122830.1977644-13-karol.kolacinski@intel.com>

On Wed, Apr 09, 2025 at 02:24:58PM +0200, Karol Kolacinski wrote:
> Collect TSPLL related functions and definitions and move them to
> a separate file to have all TSPLL functionality in one place.
> 
> Move CGU related functions and definitions to ice_common.*
> 
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index f7fd0a2451de..190d850f7ff7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -6234,3 +6234,64 @@ u32 ice_get_link_speed(u16 index)
>  
>  	return ice_aq_to_link_speed[index];
>  }
> +
> +/**
> + * ice_read_cgu_reg_e82x - Read a CGU register
> + * @hw: pointer to the HW struct
> + * @addr: Register address to read
> + * @val: storage for register value read
> + *
> + * Read the contents of a register of the Clock Generation Unit. Only
> + * applicable to E822 devices.
> + *
> + * Return: 0 on success, other error codes when failed to read from CGU.
> + */
> +int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
> +{
> +	struct ice_sbq_msg_input cgu_msg = {
> +		.opcode = ice_sbq_msg_rd,
> +		.dest_dev = cgu,

This seems to be addressed in patch v2: when applied against iwl-next,
but not next, this needs to be ice_sbq_dev_cgu.

drivers/net/ethernet/intel/ice/ice_common.c:6253:15: error: use of undeclared identifier 'cgu'
 6253 |                 .dest_dev = cgu,

> +		.msg_addr_low = addr
> +	};
> +	int err;
> +
> +	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
> +	if (err) {
> +		dev_dbg(ice_hw_to_dev(hw), "Failed to read CGU register 0x%04x, err %d\n",
> +			addr, err);
> +		return err;
> +	}
> +
> +	*val = cgu_msg.data;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_write_cgu_reg_e82x - Write a CGU register
> + * @hw: pointer to the HW struct
> + * @addr: Register address to write
> + * @val: value to write into the register
> + *
> + * Write the specified value to a register of the Clock Generation Unit. Only
> + * applicable to E822 devices.
> + *
> + * Return: 0 on success, other error codes when failed to write to CGU.
> + */
> +int ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
> +{
> +	struct ice_sbq_msg_input cgu_msg = {
> +		.opcode = ice_sbq_msg_wr,
> +		.dest_dev = cgu,

Ditto.

> +		.msg_addr_low = addr,
> +		.data = val
> +	};
> +	int err;
> +
> +	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
> +	if (err)
> +		dev_dbg(ice_hw_to_dev(hw), "Failed to write CGU register 0x%04x, err %d\n",
> +			addr, err);
> +
> +	return err;
> +}

...

