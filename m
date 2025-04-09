Return-Path: <netdev+bounces-180844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425ADA82B46
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3489A1BAC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50145267B92;
	Wed,  9 Apr 2025 15:43:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52817A319;
	Wed,  9 Apr 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213406; cv=none; b=rxgMlwb3mpJUmn2rG9GEzwdtrRdk2fLnLAsoSaTKSfvCBMSG8jFRDTvZZeh+9LZaEhhIkFqSHo2nBB4DpWsdT79wZqv6+lVBVVthQY46m1I+b2XQQiT6O08WtjUq0xWBbetH3yJZrbt4o6KpNqfnj2BWwmbRZP8Pr8SI5O5CGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213406; c=relaxed/simple;
	bh=y9uebcKW8YvKkKHt4Ltu6yUEyYoT0rCBCLeMKwit3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1LHJc0mICJSmKfo4rRy03rLUeDkSCraxXHHSCDrZ293tWHedFgMcyStL98ZAr1XpVCSX/QPSt/Ov46Qt2PSBOkIQFS/nWoL68SCmfVPGRv7P+FPCEw+2AhhnO0kPr/EqQujgtrHIDDmspd6fKLzXf/VovaxXCGR21W46AqYoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: z09WTXwoSD6gInyYwOsg3w==
X-CSE-MsgGUID: qBZiBJvZShqOzDg+fyM8rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56330918"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56330918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:43:23 -0700
X-CSE-ConnectionGUID: jBz6NS4OR62aMwAXaezCtA==
X-CSE-MsgGUID: Ckj9YI5xSyu3GY5GKOussQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128540658"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:43:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u2Xa8-0000000AmY0-3UpM;
	Wed, 09 Apr 2025 18:43:16 +0300
Date: Wed, 9 Apr 2025 18:43:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 03/14] mfd: Add Microchip ZL3073x support
Message-ID: <Z_aVlIiT07ZDE2Kf@smile.fi.intel.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409144250.206590-4-ivecera@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:42:39PM +0200, Ivan Vecera wrote:
> Add base MFD driver for Microchip Azurite ZL3073x chip family.
> These chips provide DPLL and PHC (PTP) functionality and they can
> be connected over I2C or SPI bus.
> 
> The MFD driver provide basic communication and synchronization
> over the bus and common functionality that are used by the DPLL
> driver (later in this series) and by the PTP driver (will be
> added later).
> 
> The chip family is characterized by following properties:
> * 2 separate DPLL units (channels)
> * 5 synthesizers
> * 10 input pins (references)
> * 10 outputs
> * 20 output pins (output pin pair shares one output)
> * Each reference and output can act in differential or single-ended
>   mode (reference or output in differential mode consumes 2 pins)
> * Each output is connected to one of the synthesizers
> * Each synthesizer is driven by one of the DPLL unit

...

> +/*
> + * Regmap ranges
> + */
> +#define ZL3073x_PAGE_SIZE	128
> +#define ZL3073x_NUM_PAGES	16
> +#define ZL3073x_PAGE_SEL	0x7F
> +
> +/*
> + * Regmap range configuration
> + *
> + * The device uses 7-bit addressing and has 16 register pages with
> + * range 0x00-0x7f. The register 0x7f in each page acts as page
> + * selector where bits 0-3 contains currently selected page.
> + */
> +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
> +	{
> +		.range_min	= 0,

This still has the same issue, you haven't given a chance to me to reply
in v1 thread. I'm not going to review this as it's not settled down yet.
Let's first discuss the questions you have in v1.

> +		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
> +		.selector_reg	= ZL3073x_PAGE_SEL,
> +		.selector_mask	= GENMASK(3, 0),
> +		.selector_shift	= 0,
> +		.window_start	= 0,
> +		.window_len	= ZL3073x_PAGE_SIZE,
> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko



