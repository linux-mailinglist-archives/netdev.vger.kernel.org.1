Return-Path: <netdev+bounces-165048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95CA30343
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086161889B30
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF031E98FA;
	Tue, 11 Feb 2025 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcXzk/t2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEA1E98EB;
	Tue, 11 Feb 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254192; cv=none; b=mrLD37p6KgjV01A7ZO7oCeyYuJhgEScRTjXWgwOu6KxN9mmCxp8sBiExaiyQ4Fd77hM/+0vbx9kOXRY0x1iPwFScthQ9X/ZAFF9JqnK5F4I+hUgdGipSjgNJy6gIUrUT/+OnfzIWyMGoWn7JMgFXhprCIf0+MvgkHTShR39siAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254192; c=relaxed/simple;
	bh=Ce5Ji/WXQMDkmcJjDCJf+Ub6K+lODSKEHTLEvD1ibhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf8srS55Iy35O99rwo4n3f6C+13n8eYmGL/gHOiP3YmPijIQXUyD1qk/Y5Em/WehEiVQ3U6VIcHLersUJ4ir4eBFc0b09JrxoCjzG6Oh67tW82R2s9AKIkQZ1F+S8Fk5N9IEC2e31pSlQVz1otINXZiMV2Q4Kh4QIb+JTOSowy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcXzk/t2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739254191; x=1770790191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ce5Ji/WXQMDkmcJjDCJf+Ub6K+lODSKEHTLEvD1ibhI=;
  b=JcXzk/t22Flzvyu0qFl6mi1a2XAzgJ4lzKpS7VYXxM7Q8h0QpMyOetDt
   +h5ylWwBYxYNlYR7PjIjCM8DCRLnxgtehZ/9AbC6uT0D8gQ+rniqMic3e
   zLD9w1oQWv2X3WlbwwIp9kaGn9ZMvir9AUUAGyTbZz7NK+c6AHjI0Wuvt
   clGl7lZ7+61orj8ByPXabT1+q9C5U6BxwNqpo9nMRQBjwGlsPSgNcp2kQ
   a3unM6yslOo0RY4BfbAfO33CEww4eZIf7sd+kaGIV5NKZcR/EmD+CwL+9
   8byCkixf+lZQMgU/0GCBk9327NC+p2ViCS2bBrklH1gSKlAxI1wiaxGJA
   A==;
X-CSE-ConnectionGUID: EKLivomvQq+HG6MntZrpDw==
X-CSE-MsgGUID: fgYI+swiQSigIyCUnbJRrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57271607"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="57271607"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 22:09:50 -0800
X-CSE-ConnectionGUID: KjhHhETEQwW6nEdSX5vO5w==
X-CSE-MsgGUID: W7KoF7IvT3CDUO0isJnv+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="117493893"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 22:09:47 -0800
Date: Tue, 11 Feb 2025 07:06:11 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	dave.stevenson@raspberrypi.com, popcornmix@gmail.com,
	mripard@kernel.org, u.kleine-koenig@baylibre.com, nathan@kernel.org,
	linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, zzjas98@gmail.com
Subject: Re: [PATCH] clk: bcm: rpi: Fix potential NULL pointer dereference
Message-ID: <Z6ro06dd81bGO77a@mev-dev.igk.intel.com>
References: <20250211000917.1739835-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211000917.1739835-1-chenyuan0y@gmail.com>

On Mon, Feb 10, 2025 at 06:09:17PM -0600, Chenyuan Yang wrote:
> The `init.name` could be NULL. Add missing check in the
> raspberrypi_clk_register().
> This is similar to commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
> Besides, bcm2835_register_pll_divider() under the same directory also
> has a very similar check.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> index 0e1fe3759530..720acc10f8aa 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -286,6 +286,8 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
>  	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL,
>  				   "fw-clk-%s",
>  				   rpi_firmware_clk_names[id]);
> +	if (!init.name)
> +		return ERR_PTR(-ENOMEM);
>  	init.ops = &raspberrypi_firmware_clk_ops;
>  	init.flags = CLK_GET_RATE_NOCACHE;

Thanks for the fix. There is a need for a fixes tag in case like that.
Please add it in commit message. Take a look here for example [1].

[1] https://lore.kernel.org/netdev/DM3PR11MB8736BC7EF3A66720427F3775ECF22@DM3PR11MB8736.namprd11.prod.outlook.com/T/#mbc8028620ecffb2f3a23c96130fe03708e679b25

Beside that:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> -- 
> 2.34.1

