Return-Path: <netdev+bounces-67215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47E8425E9
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAC6288888
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FD6BB20;
	Tue, 30 Jan 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIoZ9wM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBB6A348
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620423; cv=none; b=umen5TofU7LJg74hUYar1BT7A389s0NVNtSOfsGqG8mm5XTSe8C0G4NLuf4p6O/QcZD12wt3Y8UBBLyBpkGGiX4VS0jmRIAUTsOi/ZtIin6PcNXpl4/OaLOHyW/VbXyFFE6zQgzsKXF9fNIGA6lBTKgTX/Q8KnpdXbM+jLQG1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620423; c=relaxed/simple;
	bh=t1VWMZfJ75RGQ7+F+W1zBcnuaV/kXgLyDNxdFeyW1cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYSv534XPe0PK97ghcj4VB4aSOKquTRKiVTeB4uTdC6JAJIatW+3Z7ZlfdxXLA0c53+vxiElTyPmZ1i5K8bqwaxbUE/blAXMNa4NbM9S77o+aL1Ta2kp139LEyyjHw9M/9moDfDDJVNpA0mK/WCLsIZGC2gsVNZLsEvdJ0ETBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIoZ9wM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94848C433C7;
	Tue, 30 Jan 2024 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620422;
	bh=t1VWMZfJ75RGQ7+F+W1zBcnuaV/kXgLyDNxdFeyW1cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIoZ9wM3Ddnh/7gh2UHyCgNu09jL9SkYngIvWVs9wXWTwRoXn6rfRG4aaoy8viXdt
	 ZQlgsiQ0Iy1x9dsN5WWUIbQVNCfM5LR3IRyb2MRxEeE3HXdvp/cevBJkaGr1yVv6id
	 NRlF71KGCx6PyZ+R7tU2GoNumrDt4e0NlHy4FKnd13vy+tWOySi+Wb05k/4BOgVO4h
	 dgIJmX+rHkLEIRGKQdud9EU/5bChMLflxeswrDxFFYK4ilZWZYl6i+aGlwQPBKX5lr
	 Gg57+WUjwvLj7pnIuCc2Xesx2rEAvQziJ5NjIKVFVSXLBE5owmMTs2rwF64mWcJzZ5
	 XrwAmtnj0Zxjw==
Date: Tue, 30 Jan 2024 13:13:34 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next v4 1/3] ixgbe: Convert ret val type from s32 to
 int
Message-ID: <20240130131334.GJ351311@kernel.org>
References: <20240126130503.14197-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126130503.14197-1-jedrzej.jagielski@intel.com>

On Fri, Jan 26, 2024 at 02:05:01PM +0100, Jedrzej Jagielski wrote:
> Currently big amount of the functions returning standard error codes
> are of type s32. Convert them to regular ints as typdefs here are not
> necessary to return standard error codes.
> 
> Fix incorrect args alignment in touched functions.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Thanks Jedrzej,

this looks good to me.
With the nit below resolved, please feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c

...

> @@ -115,7 +110,7 @@ s32 ixgbe_dcb_config_tx_desc_arbiter_82598(struct ixgbe_hw *hw,
>  }
>  
>  /**
> - * ixgbe_dcb_config_tx_data_arbiter_82598 - Config Tx data arbiter
> + * xgbe_dcb_config_tx_data_arbiter_82598 - Config Tx data arbiter

nit: ixgbe_dcb_config_tx_data_arbiter_82598

>   * @hw: pointer to hardware structure
>   * @refill: refill credits index by traffic class
>   * @max: max credits index by traffic class
> @@ -124,11 +119,8 @@ s32 ixgbe_dcb_config_tx_desc_arbiter_82598(struct ixgbe_hw *hw,
>   *
>   * Configure Tx Data Arbiter and credits for each traffic class.
>   */
> -s32 ixgbe_dcb_config_tx_data_arbiter_82598(struct ixgbe_hw *hw,
> -						u16 *refill,
> -						u16 *max,
> -						u8 *bwg_id,
> -						u8 *prio_type)
> +int ixgbe_dcb_config_tx_data_arbiter_82598(struct ixgbe_hw *hw, u16 *refill,
> +					   u16 *max, u8 *bwg_id, u8 *prio_type)
>  {
>  	u32 reg;
>  	u8 i;

...

