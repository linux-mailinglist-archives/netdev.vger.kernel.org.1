Return-Path: <netdev+bounces-164040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7AA2C687
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3393B3A3060
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA3238D5F;
	Fri,  7 Feb 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMr9DsMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493C238D52
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940873; cv=none; b=Uun8j+1pA7l7iGS7L7L9Y1vuuLqwp2QtOqTIlCuTUVuk/1mceRv8lYemhJ8otxoe5Sgln1IG/NbvVNGgT6ninHY2Jbe9AC7vyzFy70WvwEHDaS3ok7k/TsWWOh4sbOCIgtgEq1d90OaAyOhxnNZc55hpw+xtBk8lQcERFF2HshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940873; c=relaxed/simple;
	bh=v1KzgMiQjDb+Z8BzvytQeodhaZrSQcciaDlfQvx2zvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L90K2Ng9jJ7JoXtnougD/w9tiS3z8XYkJLyXcHC7L69ZcjNXuXjGoTxzHeKWYhWd/7Wn1B+quOSCXr+qxUz+wfMtiMIROo1pXK+SMiLdR1PgaUwwJA5LUQd5UKJOoaP5tWMxguE85B0In9LG2yqIpHCBqKg2fvKaiqCy6cnuzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMr9DsMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217DC4CED1;
	Fri,  7 Feb 2025 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738940873;
	bh=v1KzgMiQjDb+Z8BzvytQeodhaZrSQcciaDlfQvx2zvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMr9DsMjg1owhYUANvbZ3XPgHwGiUrhfLMUGmwLYkH9Jpg/K9CZXsaSbUbNIDsldJ
	 iA6Z3r+0WKlsJlp0pdL1MO1Gsfrur8CFSzhcflqBZv6D81Jsm4sF7eeb94/JFBgqcx
	 +RHOQQKKzKPIaP6J2oAt9ubzOK+RkYTgExrlLFIJPOL08vmkQoJXPB4ZRSEBBkZCx/
	 H76BQvVbjoqVT0F8mFpF8RHDL5WPRmKdzuDNEyM8YL/nZiV6eLaDhXrNZCORLYjZCU
	 haePR8+Ed8JRh17v11OV8IpGXM0S9CZELJGeImkZHjnaOBZWF7+RJV+zsLd/pOTCXv
	 ITBSb0iV80AGA==
Date: Fri, 7 Feb 2025 15:07:49 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com
Subject: Re: [iwl-next v1 1/4] ixgbe: add MDD support
Message-ID: <20250207150749.GY554665@kernel.org>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
 <20250207104343.2791001-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207104343.2791001-2-michal.swiatkowski@linux.intel.com>

On Fri, Feb 07, 2025 at 11:43:40AM +0100, Michal Swiatkowski wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add malicious driver detection. Support enabling MDD, disabling MDD,
> handling a MDD event, and restoring a MDD VF.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c

...

> +/**
> + * ixgbe_handle_mdd_x550 - handle malicious driver detection event
> + * @hw: pointer to hardware structure
> + * @vf_bitmap: output vf bitmap of malicious vfs
> + */
> +void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap)
> +{
> +	u32 i, j, reg, q, div, vf, wqbr;
> +
> +	/* figure out pool size for mapping to vf's */
> +	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
> +	switch (reg & IXGBE_MRQC_MRQE_MASK) {
> +	case IXGBE_MRQC_VMDQRT8TCEN:
> +		div = IXGBE_16VFS_QUEUES;
> +		break;
> +	case IXGBE_MRQC_VMDQRSS32EN:
> +	case IXGBE_MRQC_VMDQRT4TCEN:
> +		div = IXGBE_32VFS_QUEUES;
> +		break;
> +	default:
> +		div = IXGBE_64VFS_QUEUES;
> +		break;
> +	}
> +
> +	/* Read WQBR_TX and WQBR_RX and check for malicious queues */
> +	for (i = 0; i < IXGBE_QUEUES_REG_AMOUNT; i++) {
> +		wqbr = IXGBE_READ_REG(hw, IXGBE_WQBR_TX(i)) |
> +		       IXGBE_READ_REG(hw, IXGBE_WQBR_RX(i));
> +		if (!wqbr)
> +			continue;
> +
> +		/* Get malicious queue */
> +		for_each_set_bit(j, (unsigned long *)&wqbr,
> +				 IXGBE_QUEUES_PER_REG) {

The type of wqbr is a u32, that is it is 32-bits wide.
Above it's address is cast to unsigned long *.
But, unsigned long may be 64-bits wide, e.g. on x86_64.

GCC 14.2.0 EXTRA_CFLAGS=-Warray-bounds builds report this as:

In file included from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:21,
                 from ./arch/x86/include/asm/cpuid.h:71,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:59,
                 from ./include/linux/thread_info.h:60,
                 from ./include/linux/uio.h:9,
                 from ./include/linux/socket.h:8,
                 from ./include/uapi/linux/if.h:25,
                 from ./include/linux/mii.h:12,
                 from ./include/uapi/linux/mdio.h:15,
                 from ./include/linux/mdio.h:9,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe_type.h:8,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h:7,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:4:
In function ‘find_next_bit’,
    inlined from ‘ixgbe_handle_mdd_x550’ at drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3907:3:
./include/linux/find.h:65:23: error: array subscript ‘long unsigned int[0]’ is partly outside array bounds of ‘u32[1]’ {aka ‘unsigned int[1]’} [-Werror=array-bounds=]
   65 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~

I think this can be addressed by changing the type of wqmbr to unsigned long.

> +			/* Get queue from bitmask */
> +			q = j + (i * IXGBE_QUEUES_PER_REG);
> +			/* Map queue to vf */
> +			vf = q / div;
> +			set_bit(vf, vf_bitmap);
> +		}
> +	}
> +}
> +
>  #define X550_COMMON_MAC \
>  	.init_hw			= &ixgbe_init_hw_generic, \
>  	.start_hw			= &ixgbe_start_hw_X540, \

...

