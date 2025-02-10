Return-Path: <netdev+bounces-164560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01611A2E3C7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D23A8229
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83519149F;
	Mon, 10 Feb 2025 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPrxWAEm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58817C220;
	Mon, 10 Feb 2025 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739166026; cv=none; b=Ot9O8u415jtrguzW0QJC7G7V/MmDx188AOOVH/LI7iqTKXNUhsB1XayFaETXJ1VC+b+BjeKuKHgAMl/F56l+ftACsRNfJvE/aWG3zEb9UZIlkPdS/4+vCcfMtlVwP3r5Jukzzl4zAPEHE2XeIqJ9ntKuU6kkd6V1wGZxa3miOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739166026; c=relaxed/simple;
	bh=wqqJHWBJ+k5VNxqZ8rwbBAUHuSes0w4hjTbau4Q3OF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tki4Fx76opyB4T9Ky5Z1wpBy86zw4P+gvYu7yl16ft6PSVgXiRKZkYmVC2jsvs5rUh0J6J4M1MiLweIU7HDBdktaf7kAU9BdtDucGgY20rUpS+mp8l5iD5JJjyHYpxAicH26I4zH6Q4+IS0IHqgU7zNZB4Z0mTWHiGXRVJYDZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPrxWAEm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739166025; x=1770702025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqqJHWBJ+k5VNxqZ8rwbBAUHuSes0w4hjTbau4Q3OF4=;
  b=hPrxWAEmQ45/FrtRrdkZRdbd8qU26I2apEnXb3E8SP090tuJLOrZ1BHl
   9+ZmrxxT1m9w6tmksh52qVUPf8fvrs6zTEYWAi+MDe0uQyrRjqQXILRlo
   NtweJbh/tqLoYa16JlSQpXrRzCo4lm9ZFnFxja8L1QV+c02Nb9LMrYm0I
   oMdcxtaQgHaOApC+lBfABk8hhQsU9edzJs6R1XqBx4uRkFUmTeER7bxfo
   yZggIe12NpQyBdh9qd4Bxs7wnYG2fpqJAEKNvsAvzblknKt1Trr33SLx2
   dMnaZj3V+Lvj9vxQyUJd7Ih3KLMOkK9tXTn0q7HNzmgpvjwntHygrUOGZ
   Q==;
X-CSE-ConnectionGUID: 3OTKSoGFSGK8NHluVYIuhQ==
X-CSE-MsgGUID: niaS2vP8SxiORS4u4Y1rcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39754641"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="39754641"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:40:24 -0800
X-CSE-ConnectionGUID: dY9cPuvhSvaibce0BbRdBg==
X-CSE-MsgGUID: k2hJYR98S/qGieL3zs4VEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135343330"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:40:20 -0800
Date: Mon, 10 Feb 2025 06:36:43 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ixgbe: remove self assignment
Message-ID: <Z6mQa0l6Y4tb9BrY@mev-dev.igk.intel.com>
References: <20250209-e610-self-v1-1-34c6c46ffe11@ethancedwards.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209-e610-self-v1-1-34c6c46ffe11@ethancedwards.com>

On Sun, Feb 09, 2025 at 11:47:24PM -0500, Ethan Carter Edwards wrote:
> Variable self assignment does not have any effect.
> 
> Addresses-Coverity-ID: 1641823 ("Self assignment")
> Fixes: 46761fd52a886 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668672d65535fca3b2fe6f58a9deda1188fa..6b0bce92476c3c5ec3cf7ab79864b394b592c6d4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if ((hicr & IXGBE_PF_HICR_SV)) {
>  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];
>  		}
>  	}
>  

Thanks for the patch. This change is already in progress [1] (I hope,
waiting for v3).

[1] https://lore.kernel.org/netdev/20250115034117.172999-1-dheeraj.linuxdev@gmail.com/

Thanks,
Michal

> 
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250209-e610-self-85eac1f0e338
> 
> Best regards,
> -- 
> Ethan Carter Edwards <ethan@ethancedwards.com>

