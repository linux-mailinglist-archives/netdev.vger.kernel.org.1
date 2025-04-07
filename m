Return-Path: <netdev+bounces-179824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C7A7E94B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAB7A5215
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED421A458;
	Mon,  7 Apr 2025 18:05:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54B219A68;
	Mon,  7 Apr 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049112; cv=none; b=mZqfp8uHt300oV672ShLPbp7S9WDme4hxeq8rJoY3RgpLSATIe4sdCSfdG2aeuztqi3E39m+xFPz4gWv7wCJilAPovTTFy+anzC/6xcGI+S2RYn0oQLdCt5IKLi6HlvJOTgJU7us+vL+bWvvE5KI332JEYL4kpJo+vCY0ijqMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049112; c=relaxed/simple;
	bh=GWY+4jbGf74Lr4jGPW9p9agatnx3TjXPtC6JeVX+bvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELiQbTn5KVu4159NjJRIpidII1CB6UcTs5DnFZvWgCiOooKUaQI8WktcU8NtgaZzmrtvRf+SzeMWa/RGIGXJZLblX4jUGzLoqzM7RFdGZSOam218mVWXpWs9g+XlwYpc3BzkgJqCVqy93c6bT6T3jwaRlz48T+Q2eDVcHmF6Dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: dN8wMzzLSlK5zr4RfyOsRg==
X-CSE-MsgGUID: zDICQ2MaQnGxOlqv2DhjyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45619736"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45619736"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:05:09 -0700
X-CSE-ConnectionGUID: F0Zc/u4LRZCvaUc6K5OZDQ==
X-CSE-MsgGUID: 46ux0XD4S32SPynHnnNvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="151218455"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:05:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1qqF-0000000A9jI-24aI;
	Mon, 07 Apr 2025 21:05:03 +0300
Date: Mon, 7 Apr 2025 21:05:03 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
Message-ID: <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172836.1009461-2-ivecera@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 07:28:28PM +0200, Ivan Vecera wrote:
> This adds base MFD driver for Microchip Azurite ZL3073x chip family.
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
.
The comments below are applicable to entire series, take your time and fix
*all* stylic and header issues before sending v2.

...

+ array_size.h
+ bits.h

+ device/devres.h

> +#include <linux/module.h>

This file uses *much* amore than that.

+ regmap.h


> +#include "zl3073x.h"

...

> +/*
> + * Regmap ranges
> + */
> +#define ZL3073x_PAGE_SIZE	128
> +#define ZL3073x_NUM_PAGES	16
> +#define ZL3073x_PAGE_SEL	0x7F
> +
> +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
> +	{
> +		.range_min	= 0,

Are you sure you get the idea of virtual address pages here?

> +		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
> +		.selector_reg	= ZL3073x_PAGE_SEL,
> +		.selector_mask	= GENMASK(3, 0),
> +		.selector_shift	= 0,
> +		.window_start	= 0,
> +		.window_len	= ZL3073x_PAGE_SIZE,
> +	},
> +};

...

> +struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
> +{
> +	struct zl3073x_dev *zldev;
> +
> +	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
> +
> +int zl3073x_dev_init(struct zl3073x_dev *zldev)
> +{
> +	devm_mutex_init(zldev->dev, &zldev->lock);

Missing check.

> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
> +
> +void zl3073x_dev_exit(struct zl3073x_dev *zldev)
> +{
> +}
> +EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");

What's the point in these stubs?

...

> +#include <linux/i2c.h>

> +#include <linux/kernel.h>

No usual driver should include kernel.h, please follow IWYU principle.

> +#include <linux/module.h>

Again, this is just a random list of headers, see above and follow the IWYU
principle.

> +#include "zl3073x.h"

...

> +static const struct i2c_device_id zl3073x_i2c_id[] = {
> +	{ "zl3073x-i2c", },

Redundant inner comma.

> +	{ /* sentinel */ },

No comma for the sentinel.

> +};

...

> +static const struct of_device_id zl3073x_i2c_of_match[] = {
> +	{ .compatible = "microchip,zl3073x-i2c" },
> +	{ /* sentinel */ },

No comma.

> +};

> +static int zl3073x_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	const struct i2c_device_id *id;
> +	struct zl3073x_dev *zldev;

> +	int rc = 0;

Useless assignment.

> +	zldev = zl3073x_dev_alloc(dev);
> +	if (!zldev)
> +		return -ENOMEM;
> +
> +	id = i2c_client_get_device_id(client);
> +	zldev->dev = dev;
> +
> +	zldev->regmap = devm_regmap_init_i2c(client,
> +					     zl3073x_get_regmap_config());

It's perfectly a single line.

> +	if (IS_ERR(zldev->regmap)) {
> +		rc = PTR_ERR(zldev->regmap);
> +		dev_err(dev, "Failed to allocate register map: %d\n", rc);
> +		return rc;

		return dev_err_probe(...);

> +	}
> +
> +	i2c_set_clientdata(client, zldev);
> +
> +	return zl3073x_dev_init(zldev);
> +}

...

> +static void zl3073x_i2c_remove(struct i2c_client *client)
> +{

> +	struct zl3073x_dev *zldev;
> +
> +	zldev = i2c_get_clientdata(client);

Just make it one line definition + assignment.

> +	zl3073x_dev_exit(zldev);

This is a red flag and because you haven't properly named the calls (i.e. devm
to show that they are only for probe stage and use managed resources) this is
not easy to catch.

> +}
> +
> +static struct i2c_driver zl3073x_i2c_driver = {
> +	.driver = {
> +		.name = "zl3073x-i2c",
> +		.of_match_table = of_match_ptr(zl3073x_i2c_of_match),

Please, never use of_match_ptr() or ACPI_PTR() in a new code.

> +	},
> +	.probe = zl3073x_i2c_probe,
> +	.remove = zl3073x_i2c_remove,
> +	.id_table = zl3073x_i2c_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(zl3073x_i2c_driver);

...

> +#include <linux/kernel.h>

Just no. You should know what you are doing in the driver.

> +#include <linux/module.h>

> +#include <linux/of.h>

Just no. Use agnostic APIs.

> +#include <linux/spi/spi.h>
> +#include "zl3073x.h"

...

> +static const struct spi_device_id zl3073x_spi_id[] = {
> +	{ "zl3073x-spi", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
> +
> +static const struct of_device_id zl3073x_spi_of_match[] = {
> +	{ .compatible = "microchip,zl3073x-spi" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);

Move the above closer to its user.

...

> +static int zl3073x_spi_probe(struct spi_device *spidev)

Usual name is spi for the above, it's shorter and allows to tidy up the code.

And below same comments as for i2c part of the driver.

...

> +#ifndef __ZL3073X_CORE_H
> +#define __ZL3073X_CORE_H

> +#include <linux/mfd/zl3073x.h>

How is it used here, please?

> +struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev);
> +int zl3073x_dev_init(struct zl3073x_dev *zldev);
> +void zl3073x_dev_exit(struct zl3073x_dev *zldev);
> +const struct regmap_config *zl3073x_get_regmap_config(void);
> +
> +#endif /* __ZL3073X_CORE_H */

...

> +#ifndef __LINUX_MFD_ZL3073X_H
> +#define __LINUX_MFD_ZL3073X_H

> +#include <linux/device.h>
> +#include <linux/regmap.h>

Ditto. Two unused headers and one which must be included is missed.

> +struct zl3073x_dev {
> +	struct device		*dev;
> +	struct regmap		*regmap;
> +	struct mutex		lock;
> +};

-- 
With Best Regards,
Andy Shevchenko



