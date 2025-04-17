Return-Path: <netdev+bounces-183816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C6A92202
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527CA171138
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6260253F28;
	Thu, 17 Apr 2025 15:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B5253956;
	Thu, 17 Apr 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905229; cv=none; b=Fyw3hL2+VXVV+8i4mlPO81r6C992VcF9jwduiCzT4XiiTwr5Z1BrWzr5YBpgClDfv6dBaXRvNKHiLapjEFu6nMTb30O0p7lv0mCLsMjoEdFmBdIyawNHjIJD7QI/qL8/anOqSuQO2v7SGUQDw1Qgam1TpWdOGB2x2/1Zw3oIMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905229; c=relaxed/simple;
	bh=7pkkB8jiphZ1tt+fGYzi1eQrIinGLTSIKkVgKhP56fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkOdVSmdn90ctilLjZQfxzBx32bOYS5GJccZ/HnfbHlF7SJ/ln5K9PmGMkLr3lJIS69yGWoQxcle82nZbhCSBJKO9QDPlhltuGKePmKtSphN0SX8wOIsxZS+exJ0OZSF1K/Ys3+mHd7gbRNJ2z4TfO9n0emDys+HCHyr0siDZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: oKQ2u1d1Qpisw9B440VFxQ==
X-CSE-MsgGUID: NXQ8KRx0SDKUYHiMSO/7Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46628147"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46628147"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:53:47 -0700
X-CSE-ConnectionGUID: k9AqzmaWTIan+SgfNXdEdw==
X-CSE-MsgGUID: FHF73yGfQSqk3fwljmHODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="154024564"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:53:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5RYb-0000000DFA1-0OGW;
	Thu, 17 Apr 2025 18:53:41 +0300
Date: Thu, 17 Apr 2025 18:53:40 +0300
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
Subject: Re: [PATCH v3 net-next 4/8] mfd: zl3073x: Add support for devlink
 device info
Message-ID: <aAEkBOSQRoYXxcIB@smile.fi.intel.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-5-ivecera@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 06:21:40PM +0200, Ivan Vecera wrote:
> Use devlink_alloc() to alloc zl3073x_dev structure, register the device
> as a devlink device and add devlink callback to provide devlink device
> info.

...

>  /**
>   * zl3073x_devm_alloc - allocates zl3073x device structure
>   * @dev: pointer to device structure
> @@ -124,12 +204,18 @@ static const struct regmap_config zl3073x_regmap_config = {
>  struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
>  {
>  	struct zl3073x_dev *zldev;
> +	struct devlink *devlink;
>  	int rc;
>  
> -	zldev = devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
> -	if (!zldev)
> +	devlink = devlink_alloc(&zl3073x_devlink_ops, sizeof(*zldev), dev);
> +	if (!devlink)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* Add devres action to free devlink device */
> +	if (devm_add_action_or_reset(dev, zl3073x_devlink_free, devlink))
> +		return ERR_PTR(-ENOMEM);

Please, do not shadow the error codes. You might miss something. Shadowing
error codes needs a good justification.

> +	zldev = devlink_priv(devlink);
>  	zldev->dev = dev;

>  }

...

> +	/* Add devres action to unregister devlink device */
> +	rc = devm_add_action_or_reset(zldev->dev, zl3073x_devlink_unregister,
> +				      devlink);
> +	if (rc)
> +		return rc;

The code is even inconsistent in one patch!

-- 
With Best Regards,
Andy Shevchenko



