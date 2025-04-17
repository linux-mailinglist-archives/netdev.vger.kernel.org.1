Return-Path: <netdev+bounces-183815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF895A921FC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539181B6082B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD2253F05;
	Thu, 17 Apr 2025 15:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A341B6D08;
	Thu, 17 Apr 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905071; cv=none; b=XhNrUuSIaB2u70+XE9nw4zGo8UlFgKHo6b4iHO7EGlpdjxNxLge7mG1bcS9xzuz+cBcBdYNinXxWl6JKw8m08/mXrRFrlyRkGMMMqfHc1eM1p9TBQUuQQhSFuJtKgFjSYAEP56VzE9rgNAUs1r7+DNRJ8q0bqSHwRMYE1Pn6uMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905071; c=relaxed/simple;
	bh=8+m8FtQWc3+9G18FsrPMZxJRnPFm+iWeEJMrthHy02U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2D99kF8TrX5edc8XPVb5CyaTYr7awOlLzxN5MJHNuECd5SOYAr+UuFJ8yUEtYUueU60IRkBDeHTTzjL6TX3O9N30a88ELt1BZ8md0LUYsDcW0YqeQ7Hy4+hKhiqwj82xjEd11iktLo7LkgnoC1VWfnKVe0PxmCiIH7/roxUKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JtQPHBw8SN+YFzSLotcFkQ==
X-CSE-MsgGUID: IuiuBwFqQFKHZ5dj1wVEZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46217536"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46217536"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:51:07 -0700
X-CSE-ConnectionGUID: MstRhv1ESuGYWtpOO46x3g==
X-CSE-MsgGUID: AL0CZa1jT/K7ko4fq8zkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131831286"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:51:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5RW0-0000000DF7a-4B8y;
	Thu, 17 Apr 2025 18:51:00 +0300
Date: Thu, 17 Apr 2025 18:51:00 +0300
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
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <aAEjZGjNi_m9mfxP@smile.fi.intel.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-4-ivecera@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 06:21:39PM +0200, Ivan Vecera wrote:
> Add base MFD driver for Microchip Azurite ZL3073x chip family.
> These chips provide DPLL and PHC (PTP) functionality and they can
> be connected over I2C or SPI bus.
> 
> The MFD driver provide basic communication and synchronization
> over the bus and common functionality that are used by the DPLL
> driver (in the part 2) and by the PTP driver (will be added later).
> 
> The chip family is characterized by following properties:
> * up to 5 separate DPLL units (channels)
> * 5 synthesizers
> * 10 input pins (references)
> * 10 outputs
> * 20 output pins (output pin pair shares one output)
> * Each reference and output can act in differential or single-ended
>   mode (reference or output in differential mode consumes 2 pins)
> * Each output is connected to one of the synthesizers
> * Each synthesizer is driven by one of the DPLL unit
> 
> The device uses 7-bit addresses and 8-bits for values. It exposes 8-, 16-,
> 32- and 48-bits registers in address range <0x000,0x77F>. Due to 7bit
> addressing the range is organized into pages of size 128 and each page
> contains page selector register (0x7F). To read/write multi-byte registers
> the device supports bulk transfers.
> 
> There are 2 kinds of registers, simple ones that are present at register
> pages 0..9 and mailbox ones that are present at register pages 10..14.
> 
> To access mailbox type registers a caller has to take mailbox_mutex that
> ensures the reading and committing mailbox content is done atomically.
> More information about it in later patch from the series.

...

> +#define ZL_NUM_PAGES		15
> +#define ZL_NUM_SIMPLE_PAGES	10
> +#define ZL_PAGE_SEL		0x7F
> +#define ZL_PAGE_SEL_MASK	GENMASK(3, 0)
> +#define ZL_NUM_REGS		(ZL_NUM_PAGES * ZL_PAGE_SIZE)
> +
> +/* Regmap range configuration */
> +static const struct regmap_range_cfg zl3073x_regmap_range = {
> +	.range_min	= ZL_RANGE_OFF,
> +	.range_max	= ZL_RANGE_OFF + ZL_NUM_REGS - 1,
> +	.selector_reg	= ZL_PAGE_SEL,
> +	.selector_mask	= ZL_PAGE_SEL_MASK,
> +	.selector_shift	= 0,
> +	.window_start	= 0,
> +	.window_len	= ZL_PAGE_SIZE,
> +};

On the first glance this looks good now, thanks for addressing that.

...

> +static bool
> +zl3073x_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* Only page selector is non-volatile */
> +	return (reg != ZL_PAGE_SEL);

Unneeded parentheses.

> +}

...

> +/**
> + * zl3073x_devm_alloc - allocates zl3073x device structure
> + * @dev: pointer to device structure
> + *
> + * Allocates zl3073x device structure as device resource and initializes
> + * regmap_mutex.
> + *
> + * Return: pointer to zl3073x device on success, error pointer on error
> + */
> +struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
> +{
> +	struct zl3073x_dev *zldev;
> +	int rc;
> +
> +	zldev = devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
> +	if (!zldev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	zldev->dev = dev;
> +
> +	/* We have to initialize regmap mutex here because during
> +	 * zl3073x_dev_probe() is too late as the regmaps are already
> +	 * initialized.
> +	 */
> +	rc = devm_mutex_init(zldev->dev, &zldev->mailbox_lock);
> +	if (rc) {
> +		dev_err_probe(zldev->dev, rc, "Failed to initialize mutex\n");
> +		return ERR_PTR(rc);

		return dev_err_probe(...);

> +	}
> +
> +	return zldev;
> +}

...

> +int zl3073x_dev_probe(struct zl3073x_dev *zldev,
> +		      const struct zl3073x_chip_info *chip_info)
> +{
> +	u16 id, revision, fw_ver;
> +	u32 cfg_ver;
> +	int i, rc;
> +
> +	/* Read chip ID */
> +	rc = zl3073x_read_id(zldev, &id);
> +	if (rc)
> +		return rc;
> +
> +	/* Check it matches */
> +	for (i = 0; i < chip_info->num_ids; i++) {
> +		if (id == chip_info->ids[i])
> +			break;
> +	}
> +
> +	if (i == chip_info->num_ids) {

> +		dev_err(zldev->dev, "Unknown or non-match chip ID: 0x%0x\n", id);
> +		return -ENODEV;

		return dev_err_probe(...);

> +	}
> +
> +	/* Read revision, firmware version and custom config version */
> +	rc = zl3073x_read_revision(zldev, &revision);
> +	if (rc)
> +		return rc;
> +	rc = zl3073x_read_fw_ver(zldev, &fw_ver);
> +	if (rc)
> +		return rc;
> +	rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n", id,
> +		revision, fw_ver);
> +	dev_dbg(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
> +		FIELD_GET(GENMASK(31, 24), cfg_ver),
> +		FIELD_GET(GENMASK(23, 16), cfg_ver),
> +		FIELD_GET(GENMASK(15, 8), cfg_ver),
> +		FIELD_GET(GENMASK(7, 0), cfg_ver));
> +
> +	return 0;
> +}

...

> +#include <linux/device.h>

Is it used?

> +#include <linux/dev_printk.h>

+ err.h

> +#include <linux/i2c.h>
> +#include <linux/mfd/zl3073x.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

...

> +static int zl3073x_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap_config regmap_cfg;
> +	struct device *dev = &client->dev;
> +	struct zl3073x_dev *zldev;
> +
> +	zldev = zl3073x_devm_alloc(dev);
> +	if (IS_ERR(zldev))
> +		return PTR_ERR(zldev);

> +	i2c_set_clientdata(client, zldev);

Is it used anywhere?

> +	zl3073x_dev_init_regmap_config(&regmap_cfg);
> +
> +	zldev->regmap = devm_regmap_init_i2c(client, &regmap_cfg);
> +	if (IS_ERR(zldev->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
> +			      "Failed to initialize regmap\n");

		return dev_err_probe(...);

> +		return PTR_ERR(zldev->regmap);
> +	}
> +
> +	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
> +}

...

> +++ b/drivers/mfd/zl3073x-spi.c

Same comments as per i2c part.

...

> +static inline void zl3073x_mailbox_lock(struct zl3073x_dev *zldev)
> +{
> +	mutex_lock(&zldev->mailbox_lock);

Do you need sparse annotations? (build with `make C=1 ...` to check)

> +}

> +static inline void zl3073x_mailbox_unlock(struct zl3073x_dev *zldev)
> +{
> +	mutex_unlock(&zldev->mailbox_lock);
> +}
> +
> +DEFINE_GUARD(zl3073x_mailbox, struct zl3073x_dev *, zl3073x_mailbox_lock(_T),
> +	     zl3073x_mailbox_unlock(_T));

Seems to be they are useless as you share the lock. One may use
guard(nutex)(...) directly.

> +#endif /* __LINUX_MFD_ZL3073X_H */

...

> +#include <asm/byteorder.h>

asm/* usually goes after linux/* as they are more specific and linux/* are more
generic.

> +#include <linux/lockdep.h>
> +#include <linux/mfd/zl3073x.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +static inline __maybe_unused int

Why __maybe_unused? Please, get rid of those.

> +zl3073x_read_id(struct zl3073x_dev *zldev, u16 *value)
> +{
> +	__be16 temp;
> +	int rc;
> +
> +	rc = regmap_bulk_read(zldev->regmap, ZL_REG_ID, &temp, sizeof(temp));
> +	if (rc)
> +		return rc;
> +
> +	*value = be16_to_cpu(temp);
> +	return rc;
> +}

-- 
With Best Regards,
Andy Shevchenko



